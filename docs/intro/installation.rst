.. _install:

Installation and configuration
------------------------------


Install DANDI client
^^^^^^^^^^^^^^^^^^^^

Beyond DANDI client itself, the installation requires :term:`Python`,
and potentially Pythons package manager ``pip``.
The instructions below detail how to install
each of these components for different common operating systems. Please
`file an issue <https://github.com/dandi/handbook/issues/new>`_
if you encounter problems.

.. figure:: ../artwork/src/install.svg
   :width: 70%


Linux: (Neuro)Debian, Ubuntu, and similar systems
"""""""""""""""""""""""""""""""""""""""""""""""""

For Debian-based operating systems, the most convenient installation method
is to enable the `NeuroDebian <http://neuro.debian.net/>`_ repository.
If you are on a Debian-based system, but do not have the NeuroDebian repository
enabled, you should very much consider enabling it right now. The above hyperlink links
to a very easy instruction, and it only requires copy-pasting three lines of code.
Also, should you be confused by the name:
enabling this repository will not do any harm if your field is not neuroscience.

The following command installs
DataLad and all of its software dependencies (including the git-annex-standalone package):

.. code-block:: bash

   $ sudo apt-get install dandi

The command above will also upgrade existing installations to the most recent
available version.


Linux-machines with no root access (e.g. HPC systems)
"""""""""""""""""""""""""""""""""""""""""""""""""""""

If you want to install DANDI on a machine you do not have root access to, DataLad
can be installed with `Miniconda <https://docs.conda.io/en/latest/miniconda.html>`_.

.. code-block:: bash

  $ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  $ bash Miniconda3-latest-Linux-x86_64.sh
  # acknowledge license, keep everything at default
  $ conda install -c conda-forge dandi

The installer automatically configures the shell to make conda-installed
tools accessible, so no further configuration is necessary.

To update an existing installation with conda, use ``conda update dandi``.


Using Python's package manager ``pip``
""""""""""""""""""""""""""""""""""""""

DataLad can be installed via Python's package manager
`pip <https://pip.pypa.io/en/stable/>`_.
``pip`` comes with Python distributions, e.g., the Python distributions
downloaded from `python.org <https://www.python.org>`_. When downloading
Python, make sure to chose a recent Python **3** distribution.

If you have Python and ``pip`` set up,
to automatically install DataLad and its software dependencies, type

.. code-block:: bash

   $ pip install datalad~=0.12

If this results in a ``permission denied`` error, install DataLad into
a user's home directory:

.. code-block:: bash

   $ pip install --user datalad~=0.12

An existing installation can be upgraded with ``pip install -U datalad``.

In addition, it is necessary to have a current version of :term:`git-annex` installed which is
not set up automatically by using the ``pip`` method.
You can find detailed installation instructions on how to do this
`here <https://git-annex.branchable.com/install/>`__.

For Windows, extract the provided EXE installer into an existing Git
installation directory (e.g. ``C:\\Program Files\Git``). If done
this way, no ``PATH`` variable manipulation is necessary.


Windows 10
""""""""""

There are two ways to get DataLad on Windows 10: one is within Windows itself,
the other is using WSL, the Windows Subsystem for Linux. We recommend the
former, but information on how to use the WSL can be found here:

.. container:: toggle

   .. container:: header

      Using the Windows Subsystem for Linux

   You can find out how to install the Windows Subsystem for Linux at
   `ubuntu.com/wsl <https://ubuntu.com/wsl>`_. Afterwards, proceed with your
   installation as described in the installation instructions for Linux.

Note: Using Windows itself comes with some downsides.
In general, DataLad can feel a bit sluggish on Windows systems. This is because of
a range of filesystem issues that also affect the version control system :term:`Git` itself,
which DataLad relies on. The core functionality of DataLad works, and you should
be able to follow the contents covered in this book.
You will notice, however, that some Unix commands displayed in examples may not
work, and that terminal output can look different from what is displayed in the
code examples of the book.
If you are a Windows user and want to help improve the handbook for Windows users,
please `get in touch <https://github.com/datalad-handbook/book/issues/new>`_.

Note: This installation method will get you a working version of
DataLad, but be aware that many Unix commands shown in the book
examples will not work for you, and DataLad-related output might
look different from what we can show in this book. Please
`get in touch <https://github.com/datalad-handbook/book/issues/new>`__
touch if you want to help.

- **Step 1**: Install Conda

  - Go to https://docs.conda.io/en/latest/miniconda.html and pick the
    latest Python 3 installer. Miniconda is a free, minimal installer for
    conda and will install `conda <https://docs.conda.io/en/latest/>`_,
    Python, depending packages, and a number of useful packages such as
    `pip <https://pip.pypa.io/en/stable/>`_.

  - During installation, keep everything on default. In particular, do
    not add anything to ``PATH``.

  - From now on, any further action must take place in the ``Anaconda prompt``,
    a preconfigured terminal shell. Find it by searching for "Anaconda prompt"
    in your search bar.

- **Step 2**: Install Git

  - In the ``Anaconda prompt``, run::

       conda install -c conda-forge git

    Note: Is has to be from ``conda-forge``, the anaconda version does not
    provide the ``cp`` command.

- **Step 3**: Install git-annex

  - Obtain the current git-annex versions installer
    `from here <https://downloads.kitenet.net/git-annex/windows/current/>`_.
    Save the file, and double click the downloaded
    :command:`git-annex-installer.exe` in your Downloads.

  - During installation, you will be prompted to "Choose Install Location".
    **Install it into the miniconda Library directory**, e.g.
    ``C:\Users\me\Miniconda3\Library``.

- **Step 4**: Install DataLad via pip

  - ``pip`` was installed by ``miniconda``. In the ``Anaconda prompt``, run::

       pip install datalad~=0.12

- **Step 5**: Install 7zip

  - `7zip <https://7-zip.de/download.html>`_ is a dependency of DataLad and
    not installed by default on Windows 10. Please make sure to download and
    install it.

.. _installconfig:

Initial configuration
^^^^^^^^^^^^^^^^^^^^^

.. index:: ! Git identity

Initial configurations only concern the setup of a :term:`Git` identity. If you
are a Git-user, you should hence be good to go.

.. figure:: ../artwork/src/gitidentity.svg
   :width: 70%

If you have not used the version control system Git before, you will need to
tell Git some information about you. This needs to be done only once.
In the following example, exchange ``Bob McBobFace`` with your own name, and
``bob@example.com`` with your own email address.

.. code-block:: bash

   # enter your home directory using the ~ shortcut
   % cd ~
   % git config --global --add user.name "Bob McBobFace"
   % git config --global --add user.email bob@example.com

This information is used to track changes in the DataLad projects you will
be working on. Based on this information, changes you make are associated
with your name and email address, and you should use a real email address
and name -- it does not establish a lot of trust nor is it helpful after a few
years if your history, especially in a collaborative project, shows
that changes were made by ``Anonymous`` with the email
``youdontgetmy@email.fu``.
And do not worry, you won't get any emails from Git or DataLad.
