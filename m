Return-Path: <linux-kselftest+bounces-25008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD484A1A54F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE83F3AC0AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912A211463;
	Thu, 23 Jan 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hGfsu1iP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61A21129D;
	Thu, 23 Jan 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640528; cv=none; b=t3QbQrYkInNZxUWG8kQlDWeP8E1D/faLOFCgPynEJUX8qENZ3TYphQAb0QxAHQNq0GWO2WUNioA8f491XrkAx28+rOQhZjIpz7WORFNWGukrzld9orvZxtUYYt/LFckjmSOY/qC9Us4tGsUJhVUobtiLhEhlZwndqiyJ7li7Ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640528; c=relaxed/simple;
	bh=ch2pzJGTc3aYg+byV9YZ1M2zRb5bhcxs85xaDaa3pgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joCBlRNwIUdiNyQ/RTGKNJ/WoIrxV8RhtvAF8wAA5GPLDgRZY8uJvhXZ5jY2XSbzBILPvQFYqpYd0rSHw7JbXShEYv2E+YP0Vq/lLKAHjQCFRw3FNxyuUt/w4X+fBotaXMTO4fQ+f2qaTGJcgCKL3ShNpsnBNNlS2uELhmJvp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hGfsu1iP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640524;
	bh=ch2pzJGTc3aYg+byV9YZ1M2zRb5bhcxs85xaDaa3pgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGfsu1iPsFnFtdsQh8Nj+y4TE6cDO8fezGU99FMQ0bAEMF7kWrcLsL3aoUKmiADB4
	 llvLPqijmNjuWZ0saz602r5syqW4RONOpdRKDae2HTqqumHaYBjvceH4qHsv00cLjo
	 U9HU4+xgWPHDH6NKQkhCromw1g7oLofzOuaMHfYb6EHovhylpmp2hr2SHoiFNKNU0b
	 iWNPathzX5FFOMM/qi5D8q0ExCAZDTqQALh672JBDiOh3p799UBS8R1p+UsV1U/rS/
	 In5e9MEKM1AM02C8kn/OMnU2F3zFTsoyDuBe8jBpuozwfTaPjsQmCq/r1o/GCsmO53
	 2ttkVy+FEiJGQ==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A2EA017E0FCA;
	Thu, 23 Jan 2025 14:55:07 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: kernelci@lists.linux.dev
Cc: linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org,
	gustavo.padovan@collabora.com,
	pawiecz@collabora.com,
	spbnick@gmail.com,
	tales.aparecida@gmail.com,
	workflows@vger.kernel.org,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	daniels@collabora.com,
	helen.koike@collabora.com,
	shreeya.patel@collabora.com,
	denys.f@collabora.com,
	nicolas.dufresne@collabora.com,
	louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com,
	broonie@kernel.org,
	leobras.c@gmail.com,
	groeck@google.com,
	rdunlap@infradead.org,
	geert@linux-m68k.org,
	michel.daenzer@mailbox.org,
	sakari.ailus@iki.fi,
	jarkko@kernel.org
Subject: [PATCH v2 4/5] kci-gitlab: Add documentation
Date: Thu, 23 Jan 2025 19:23:34 +0530
Message-ID: <20250123135342.1468787-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123135342.1468787-1-vignesh.raman@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helen Koike <helen.koike@collabora.com>

Add documentation of kci-gitlab.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 Documentation/ci/gitlab-ci/gitlab-ci.rst | 471 +++++++++++++++++++++++
 Documentation/index.rst                  |   7 +
 2 files changed, 478 insertions(+)
 create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst

diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
new file mode 100644
index 000000000000..940a80006923
--- /dev/null
+++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
@@ -0,0 +1,471 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=========================================
+Automated Testing with kci-gitlab
+=========================================
+
+
+This documentation outlines kci-gitlab, a GitLab CI/CD workflow for the
+Linux Kernel. kci-gitlab pipeline is specifically designed for kernel testing.
+It provides kernel developers with an integrated, efficient, and flexible
+testing framework using GitLab's CI/CD capabilities. The workflow is designed
+to simplify testing for developers, allowing tests to be run on any branch at
+any time, without the need for specific infrastructure. Tests are automatically
+triggered on each `git push`, with results displayed in the GitLab UI.
+
+.. image:: images/the-pipeline.png
+   :alt: GitLab-CI pipeline for kernel testing
+   :align: center
+
+Customizations and extensions of the pipeline are possible through the
+scenarios. Scenarios can override existing jobs, change configurations, or
+define new jobs and stages. See :ref:`extending-the-ci` section.
+
+.. note:: If you are unfamiliar with GitLab CI/CD basic concepts, please check
+   the `official documentation <https://docs.gitlab.com/ee/ci/>`_.
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
+Setup
+-----
+
+The kci-gitlab pipeline is set up with minimal configuration required. Pushing code to a
+GitLab repository automatically triggers the pipeline provided the CI/CD configuration
+file path is set as per the instructions given below..
+
+    .. code-block:: bash
+
+      # Download the Linux kernel source code
+      git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+      # Create a repository on GitLab and add it as a remote
+      git remote add gitlab https://gitlab.yourinstance.com/your-username/your-repo.git
+      # In GitlabCI, go to Settings > CI/CD > General pipelines > CI/CD Configuration file
+      # and add the following path to it :-
+      tools/ci/gitlab-ci/gitlab-ci.yml
+      # Push the code to GitLab
+      git push gitlab
+
+.. image:: images/pipelines-on-push.png
+   :alt: Pipeline triggered on push
+   :align: center
+
+Troubleshooting
+---------------
+
+If the pipeline doesn't trigger automatically, check the following:
+
+1. **Enable CI/CD in Project Settings:**
+
+   - Go to `Settings > General > Visibility, project features, permissions`.
+   - Under `Repository`, ensure the `CI/CD` toggle is enabled.
+
+2. **Enable Container Registry:**
+
+   - Still in `Settings`, find the `Container Registry` section.
+   - Enable the `Container Registry` toggle.
+
+3. **CI Minutes and Resources:**
+
+   - If you've exhausted CI minutes or other resources on the Free Tier,
+     consider setting up a local GitLab runner (see below).
+
+Setting Up a Local GitLab Runner
+--------------------------------
+
+You can use your own machine as a runner, instead of the shared runners provided
+by your GitLab instance.
+
+1. **Generate a GitLab Runner Token:**
+
+   - Navigate to `Settings > CI/CD > Runners`.
+   - Expand the `Runners` section and click on "New project runner".
+   - Choose "Run untagged jobs" and click "Create runner".
+   - Copy the provided token.
+
+.. image:: images/new-project-runner.png
+   :alt: New project runner button
+   :align: center
+
+2. **Launch the Runner:**
+
+   - Ensure Docker is installed and your user is added to the Docker group:
+
+    .. code-block:: bash
+
+        sudo usermod -aG docker <your-user>
+
+   - Log in again to apply the changes.
+   - Set up the runner:
+
+    .. code-block:: bash
+
+     export GITLAB_RUNNER_TOKEN=<your_token>
+     export GITLAB_URL=https://gitlab.yourinstance.com  # Use this for instances other than gitlab.com
+     cd tools/ci/gitlab-ci
+     ./bootstrap-gitlab-runner.sh
+
+
+Current Pipeline Jobs
+---------------------
+
+stage: container
+^^^^^^^^^^^^^^^^
+
+**job: debian/x86_64_build debian/arm64_build**
+
+This job prepares the container for x86_64 and arm64 architectures that will be
+used by subsequent jobs. It starts from a base Debian image, installing necessary
+tools for building the kernel and running tests. The resulting image is pushed to
+the project registry and cached. If the image already exists in the registry, it
+won't be rebuilt.
+
+To force a rebuild, update the `FDO_DISTRIBUTION_TAG` variable in the
+`container.yml` file.
+
+stage: static-checks
+^^^^^^^^^^^^^^^^^^^^
+
+**job: checkpatch**
+
+Runs the `checkpatch.pl` script on the last `$ICI_PATCH_SERIES_SIZE` commits.
+This variable is determined by:
+
+- `ICI_PATCH_SERIES_SIZE=` The number of differing patches between target and
+  source branches for merge requests; Or
+- `ICI_PATCH_SERIES_SIZE=$KCI_PATCH_SERIES_SIZE` if `KCI_PATCH_SERIES_SIZE` is
+  set (see :ref:`how-to-set-variables` below).
+
+Defaults to 1 and raises a GitLab warning if unable to identify the number of
+commits.
+
+**job: smatch**
+
+Checks `.c` files in the last `$ICI_PATCH_SERIES_SIZE` commits. Creates a
+job based on architecture and configuration mentioned in the scenario specific
+yaml files.
+If a smatch database exists (see `job: smatch-db-generate` below), it reuses it.
+
+stage: build
+^^^^^^^^^^^^
+
+**job: build:arm32 build:arm64 build:x86_64**
+
+Compiles the kernel for each architecture and configuration
+in `container.yml`.
+
+Raises a GitLab warning if "warning" is found in the build log.
+
+.. image:: images/job-matrix.png
+   :alt: build kernel jobs
+   :align: center
+
+**job: build-docs**
+
+Builds documentation. Creates a job for each documentation type. Not run
+automatically; requires manual triggering.
+
+stage: test
+^^^^^^^^^^^
+
+**job: test-boot**
+
+Runs boot tests using virtme to launch a virtual machine and execute
+`test-boot.sh` script.
+
+stage: cache
+^^^^^^^^^^^^
+
+**job: smatch-db-generate**
+
+Generates a smatch database for use by the `smatch` job. Not run automatically;
+requires manual triggering.
+
+.. _extending-the-ci:
+
+Extending the CI - Test Scenarios (KCI_SCENARIO)
+------------------------------------------------
+
+The kci-gitlab pipeline offers flexibility and adaptability through the use of
+scenarios, enhancing the CI/CD process with broad customization options.
+Key capabilities include:
+
+- **Overriding Existing Jobs:** Tailor existing jobs to meet specific needs or
+  conditions.
+
+- **Changing Configurations:** Dynamically adapt job settings to suit various
+  environments or subsystem requirements.
+
+- **Defining New Jobs and Stages:** Introduce new jobs and stages for additional
+  tests, build processes, or deployment strategies.
+
+These features are particularly useful when a subsystem has distinct
+requirements. For instance, to enable testing different configurations for a
+specific architecture, running static checks with varied arguments, or
+installing specialized tools to conduct targeted tests.
+
+Writing a test scenario
+^^^^^^^^^^^^^^^^^^^^^^^
+
+The kci-gitlab pipeline configuration allows the inclusion of additional `.yml` files
+based on the `KCI_SCENARIO` variable. For example, setting `KCI_SCENARIO` to `my-scenario`
+includes `my-scenario.yml` from the `scenarios/<my-scenario>/` folder.
+
+A different container image can be built for the newly added scenario by modifying
+the FDO_DISTRIBUTION_TAG. FDO_DISTRIBUTION_EXEC can be used to run scripts to install
+the required tools for the container. To illustrate, building a container for a specific
+architecture with a custom configuration can be achieved by overriding the `build` job
+in the `scenarios/<my-scenario>/my-scenario.yml` file:
+
+.. code-block:: yaml
+
+    variables:
+      FDO_DISTRIBUTION_TAG: "<tag>"
+      FDO_DISTRIBUTION_EXEC: <script>
+
+    build:arm64:
+      variables:
+        KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
+        KCI_DEFCONFIG: "my/custom/config1"
+
+We also need to add `scenarios/<my-scenario>/test.yml` to override the test-boot job
+and add job to run tests for the scenario.
+
+This modifies the builds and static checks for `arm64` with different configurations.
+
+To select this scenario, trigger the pipeline with KCI_SCENARIO=my-scenario. See
+:ref:`how-to-set-variables` below.
+
+Additionally, we need to add `scenarios/<my-scenario>/test.yml` to override the default
+test-boot job and add job to run tests for the scenario.
+
+DRM scenario
+^^^^^^^^^^^^
+
+Setting `KCI_SCENARIO` to `drm` includes `drm.yml` from the `scenarios/drm/` folder.
+
+A different container image can be built for the newly added `drm` scenario by modifying
+the FDO_DISTRIBUTION_TAG. FDO_DISTRIBUTION_EXEC runs the `prepare-container.sh` script,
+which installs the required tools (e.g., deqp-runner, IGT, Rust) for the container.
+To illustrate, building a container for a specific architecture with a custom
+configuration can be achieved by overriding the build job in the `scenarios/drm/drm.yml` file:
+
+.. code-block:: yaml
+
+    variables:
+      FDO_DISTRIBUTION_TAG: "<tag>"
+      FDO_DISTRIBUTION_EXEC: <prepare-container.sh>
+
+    build:arm64:
+      variables:
+        KCI_KCONFIGS_ENABLE: "DRM_VKMS DRM_BOCHS"
+
+This modifies the builds for x86_64 to enable VKMS driver in the kernel.
+
+Additionally, we need to add `scenarios/drm/test.yml` to override the default
+test-boot job and add job to run tests for the `drm` scenario.
+
+Below is a pipeline running IGT tests using igt-runner provided by
+deqp-runner for :ref:`VKMS <vkms>`.
+
+.. image:: images/drm-vkms.png
+   :alt: DRM vkms job
+   :align: center
+
+`deqp-runner tool <https://gitlab.freedesktop.org/mesa/deqp-runner>`_ supports parallel
+testing of various test suites, including dEQP, Piglit, GTest, and IGT GPU Tools,
+using baseline expectations and known flakes. deqp-runner contains experimental support
+for running IGT tests. `IGT GPU Tools <https://gitlab.freedesktop.org/drm/igt-gpu-tools>`_
+is a collection of tools for development and testing of the DRM drivers.
+
+Refer to Documentation/gpu/automated_testing.rst for details regarding
+fails/flakes/skips files.
+
+Variables
+---------
+
+kci-gitlab supports various variables to modify pipeline behavior or for use
+in jobs.
+
+- **CI_ Prefix:** Standard GitLab CI/CD variables (see GitLab documentation).
+- **KCI_ Prefix:** Custom variables defined for kernel CI.
+- **ICI_ Prefix:** Internal variables used between scripts (not for external
+  use).
+
+.. _how-to-set-variables:
+
+How to Set Variables
+--------------------
+
+Variables can be set in several ways:
+
+- **Project Settings:** Under `CI/CD > Variables`.
+- **Pipeline UI:** When triggering a pipeline manually.
+- **Command Line:** When triggering a pipeline manually (see
+  :ref:`triggering-pipelines-from-command-line` below).
+- **YML Files:** Using the `variables` keyword.
+- **Commit Message:** For runtime variables only (see
+  :ref:`setting-variables-in-the-commit-message` below).
+
+.. image:: images/variables.png
+   :alt: Manual creation of pipeline
+   :align: center
+
+Variables Precedence
+--------------------
+
+- **Commit Message Variables:** Highest precedence if evaluated at runtime.
+- **Pipeline Variables:** Next in precedence.
+- **Project Variables:** Follow pipeline variables.
+- **YML File Variables:** Considered after the above levels.
+
+.. _setting-variables-in-the-commit-message:
+
+Setting Variables in the Commit Message
+---------------------------------------
+
+Runtime variables can be set in the commit message. Patterns like
+`KCI_VARIABLE=value` are extracted and exported to the job. To avoid including
+variables in the git history, add them after three dashes (`---`) in the commit
+message, as `git am` ignores text after this line.
+
+Example:
+
+.. code-block::
+
+    Title of my awesome commit
+
+    This is the commit message description of my awesome patch
+    ---
+    KCI_PATCH_SERIES_SIZE=4
+
+Description of Each Variable
+----------------------------
+
+**KCI_BUILD_ARCH**
+    Defines the build architecture to be used in FDO_REPO_SUFFIX for the container
+    image name.
+
+**KCI_KERNEL_ARCH**
+    Defines the architecture to be used in the kernel build jobs and static checks jobs.
+    Usually set in the `container.yml` or overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_DEFCONFIG**
+    Defines the config file to be used in the build-kernel and static checks
+    jobs. Usually set in the `container.yml` or overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_KCONFIGS_{ENABLE,DISABLE,MODULE}**
+    Defines the extra configs to be enabled, disabled or set as a module, used
+    in the build-kernel and static checks jobs. Usually set in the `container.yml` or
+    overridden in scenarios/<my-scenario>/my-scenario.yml.
+
+**KCI_SCENARIO**
+    Used to select which extra scenario file to include in the pipeline. See
+    :ref:`extending-the-ci` section above. Usually set by the user at project or
+    pipeline level.
+
+**KCI_CHECKPATCH_OPTIONS**
+    Used in `checkpatch.pl "$KCI_CHECKPATCH_OPTIONS"` (see checkpatch
+    documentation). It is commonly used with the --ignore flag to suppress
+    specific warnings generated by checkpatch.pl. It can also be defined in the
+    commit message, since it is evaluated in run time.
+
+**KCI_PATCH_SERIES_SIZE**
+    Used to define the size of the patch series, see `job: checkpatch` section
+    above. It is evaluated in run time, and can be set in the commit message.
+
+.. _triggering-pipelines-from-command-line:
+
+Triggering Pipelines from Command Line
+--------------------------------------
+
+Pipelines can be triggered from the command line with custom variables using the
+`GitLab CLI tool <https://docs.gitlab.com/ee/editor_extensions/gitlab_cli>`_.
+
+Example:
+
+.. code-block:: bash
+
+    glab auth login
+    glab ci run -b gitlab-draft -R https://gitlab.collabora.com/koike/linux/ --variables-env KCI_PATCH_SERIES_SIZE:4
+
+
+Debugging and Replicating Jobs Locally
+--------------------------------------
+
+When a job fails in GitLab CI/CD, it's handy to replicate the issue in the
+same environment used by the GitLab CI/CD runner. This allows for interactive
+execution of each step and the use of debugging tools to pinpoint the failure's
+root cause.
+
+Rather than repeatedly modifying scripts and running the entire pipeline for
+debugging, you can download the specific Docker image used by the job and run it
+locally.
+
+To do this, first inspect the failed job in GitLab CI/CD. Look for a message
+indicating the Docker image used, typically in this format:
+
+   Pulling docker image registry.gitlab.collabora.com/koike/linux/debian/bookworm-slim:2024-02-6-ci-test-1
+
+You can then use this image to run the job locally. For example:
+
+.. code-block:: bash
+
+   IMAGE=registry.gitlab.collabora.com/koike/linux/debian/bookworm-slim:2024-02-6-ci-test-1
+   docker pull $IMAGE
+   docker run --rm -v `pwd`:/linux -w /linux $IMAGE bash
+
+
+Suggestions
+-----------
+
+Send Pipeline Links with Your Patch
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When submitting patches or merge requests, it's highly beneficial to include
+links to the related GitLab CI pipelines. This practice enhances the review
+process in several ways:
+
+1. **Immediate Visibility:** Reviewers can immediately see the results of
+   automated tests, making it easier to assess the patch's impact.
+
+2. **Increased Confidence:** Successful pipeline runs increase confidence in the
+   changes, demonstrating that they pass existing tests.
+
+3. **Efficient Troubleshooting:** If there are issues, pipeline links allow both
+   authors and reviewers to quickly access logs and test results, facilitating
+   faster troubleshooting and iteration.
+
+4. **Transparency:** Providing pipeline links promotes transparency in the
+   development process, making it clear how changes have been verified.
+
+To include a pipeline link in your patch or merge request, simply copy the URL
+of the pipeline from your GitLab project's CI/CD pipeline page and paste it into
+your commit description after three dashes (`---`) or as a reply to your email
+patch.
+
+Always Green Pipeline
+^^^^^^^^^^^^^^^^^^^^^
+
+Maintaining an "always green" pipeline refers to the practice of ensuring that
+the main branch's pipeline is always in a passing state. This approach has
+several advantages:
+
+1. **Reliable Main Branch:** A green pipeline indicates a stable and reliable
+   main branch, which is crucial for continuous integration practices.
+
+2. **Immediate Feedback:** Developers receive immediate feedback on their
+   changes. If a merge causes the pipeline to fail, it's a clear signal that the
+   change introduced an issue.
+
+3. **Faster Iteration:** An always green pipeline facilitates faster development
+   and iteration, as developers can confidently build on top of the latest main
+   branch without worrying about hidden failures.
+
+4. **Culture of Responsibility:** It fosters a culture of responsibility, where
+   developers are encouraged to fix broken builds promptly and avoid merging
+   changes that could disrupt the pipeline.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index f9f525f4c0dd..701e70b54780 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,13 @@ Architecture-specific documentation
 
    CPU architectures <arch/index>
 
+CI: Automated testing documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   ci/gitlab-ci/gitlab-ci
 
 Other documentation
 ===================
-- 
2.43.0


