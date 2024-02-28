Return-Path: <linux-kselftest+bounces-5561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9786BB1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6401F27819
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE773509;
	Wed, 28 Feb 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ztcfiq/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF2A72936;
	Wed, 28 Feb 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160956; cv=none; b=Z9smRS3czlI8WfEDXsfbCJfymKvS8I7OsQDFndqqK945frEanLVp3hedM0FpefNhnXBOLAWKag2ZLWJq53aSG2UakTX/j4av8IFqBU4/L+7ZlYQrfkPw8uWCKR1vAOhxd6rwCtcRwWJALZd1YyVK1Dc5a7M9n2nofb66BsxypoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160956; c=relaxed/simple;
	bh=FpJMfFLb7RI2hPRJguM7WRGYTcIgvbeDtXM2KpoFr80=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYQiZkOeyHbZZIoNcjVS0Pgzd+cTfuctLlJjlqBiEarxq7yfflZPcuST7BeAeCbgL+M+DWe7SDoNrFRO51OGcDdjFoI04rYkEK18ExjgidhxkTSkRdqhuuNB5IFzk4cOzzUFJgkpyH8Zm1VkSkU6M7nK9V94FWrPziqH651ZASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ztcfiq/n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709160952;
	bh=FpJMfFLb7RI2hPRJguM7WRGYTcIgvbeDtXM2KpoFr80=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ztcfiq/nY1NQv8uHl+Nm6NOaAU4iFZw6qLJwYRkGCXs6nTJWfJBvHFlvetKSafJ09
	 ebOeERquONkTdEeUtTjYNzSJQkoaNOf13AIZJtt9NV9Y+ATL1X2n+GYnXFMZYDUeZW
	 6b1UtbV4ElY195NJlnZa5B8yJkcw+1AXHfUVeBjcpFMkXzvhMYhPAR8soEE2FYX/w6
	 SmemBGCQw/cyaNr+HzTAGCgZUCkuyzc2tGIXAtOWzfHj5t8xCytd4L589nis4hK6yR
	 jH+a/6pnCGmn40ioAcO41MFIIFZ44cOR+2fYl2HhQPmykNKe6/FV9EjS2+LUKAgKb2
	 FaP0QyADyzXMw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 332C137820DD;
	Wed, 28 Feb 2024 22:55:45 +0000 (UTC)
From: Helen Koike <helen.koike@collabora.com>
To: linuxtv-ci@linuxtv.org,
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
	kernelci@lists.linux.dev,
	skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com,
	nfraprado@collabora.com,
	davidgow@google.com,
	cocci@inria.fr,
	Julia.Lawall@inria.fr,
	laura.nao@collabora.com,
	ricardo.canuelo@collabora.com,
	kernel@collabora.com,
	torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 2/3] kci-gitlab: Add documentation
Date: Wed, 28 Feb 2024 19:55:26 -0300
Message-Id: <20240228225527.1052240-3-helen.koike@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240228225527.1052240-1-helen.koike@collabora.com>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation of kci-gitlab.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
 Documentation/ci/gitlab-ci/gitlab-ci.rst | 404 +++++++++++++++++++++++
 Documentation/index.rst                  |   7 +
 MAINTAINERS                              |   1 +
 3 files changed, 412 insertions(+)
 create mode 100644 Documentation/ci/gitlab-ci/gitlab-ci.rst

diff --git a/Documentation/ci/gitlab-ci/gitlab-ci.rst b/Documentation/ci/gitlab-ci/gitlab-ci.rst
new file mode 100644
index 0000000000000..4f7ef03cca95c
--- /dev/null
+++ b/Documentation/ci/gitlab-ci/gitlab-ci.rst
@@ -0,0 +1,404 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=========================================
+Automated Testing with GitLab CI/CD
+=========================================
+
+This documentation outlines the GitLab CI/CD workflow for the Linux Kernel. The
+workflow is designed to simplify testing for developers, allowing tests to be
+run on any branch at any time, without the need for specific infrastructure.
+Tests are automatically triggered on each `git push`, with results displayed in
+the GitLab UI.
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
+The GitLab CI pipeline is configured for **"out-of-the-box"** use. Pushing code to a
+GitLab repository automatically triggers the pipeline.
+
+    .. code-block:: bash
+
+      # Download the Linux kernel source code
+      git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+      # Create a repository on GitLab and add it as a remote
+      git remote add gitlab https://gitlab.yourinstance.com/your-username/your-repo.git
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
+     cd ci/gitlab-ci
+     ./bootstrap-gitlab-runner.sh
+
+
+Current Pipeline Jobs
+---------------------
+
+stage: container
+^^^^^^^^^^^^^^^^
+
+**job: debian/x86_64_build**
+
+This job prepares the container used by subsequent jobs. It starts from a base
+Debian image, installing necessary tools for building the kernel and running
+tests. The resulting image is pushed to the project registry and cached. If the
+image already exists in the registry, it won't be rebuilt.
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
+Checks `.c` files in the last `$ICI_PATCH_SERIES_SIZE` commits. Spawns a
+"sub-job" for each architecture and configuration in `kernel-combinations.yml`.
+If a smatch database exists (see `job: smatch-db-generate` below), it reuses it.
+
+stage: build
+^^^^^^^^^^^^
+
+**job: build-kernel**
+
+Compiles the kernel. Spawns a "sub-job" for each architecture and configuration
+in `kernel-combinations.yml`. Uses `ccache` to speed up builds, with its
+database shared inside the runner or across runners if configured with S3.
+
+Raises a GitLab warning if "warning" is found in the build log.
+
+.. image:: images/job-matrix.png
+   :alt: Matrix of jobs under build-kernel
+   :align: center
+
+**job: build-docs**
+
+Builds documentation. Spawns a "sub-job" for each documentation type. Not run
+automatically; requires manual triggering.
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
+The pipeline offers flexibility and adaptability through the use of scenarios,
+enhancing the CI/CD process with broad customization options. Key capabilities
+include:
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
+The GitLab CI pipeline configuration allows for the inclusion of additional
+`.yml` files based on the `KCI_SCENARIO` variable. For example, setting
+`KCI_SCENARIO` to `media` includes `media.yml` from the `scenarios/` folder.
+
+To illustrate, building a specific architecture with a custom config can be
+achieved by overriding the `.kernel-combinations` hidden job in the
+`scenarios/my-scenario.yml` file:
+
+.. code-block:: yaml
+
+    .kernel-combinations:
+        parallel:
+            matrix:
+            - KCI_KERNEL_ARCH: "arm64"
+              KCI_DEFCONFIG: "my/custom/config1"
+              KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2 CONFIG3"
+
+            - KCI_KERNEL_ARCH: "arm64"
+              KCI_DEFCONFIG: "my/custom/config2"
+              KCI_KCONFIGS_ENABLE: "CONFIG4 CONFIG5"
+
+This modifies builds and static checks for `arm64` with different
+configurations.
+
+To select this scenario, trigger the pipeline with KCI_SCENARIO=my-scenario. See
+:ref:`how-to-set-variables` below.
+
+Variables
+---------
+
+GitLab CI/CD supports various variables to modify pipeline behavior or for use
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
+**KCI_KERNEL_ARCH**
+    Defines the architecture to be used in the build-kernel and static checks
+    jobs. Usually set in the `.kernel-combinations` hidden job.
+
+**KCI_DEFCONFIG**
+    Defines the config file to be used in the build-kernel and static checks
+    jobs. Usually set in the `.kernel-combinations` hidden job.
+
+**KCI_KCONFIGS_{ENABLE,DISABLE,MODULE}**
+    Defines the extra configs to be enabled, disabled or set as a module, used
+    in the build-kernel and static checks jobs. Usually set in the
+    `.kernel-combinations` hidden job.
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
\ No newline at end of file
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 36e61783437c1..cc96548ea8ef0 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,13 @@ Architecture-specific documentation
 
    arch/index
 
+CI: Automated testing documentation
+===================================
+
+.. toctree::
+   :maxdepth: 2
+
+   ci/gitlab-ci/gitlab-ci
 
 Other documentation
 ===================
diff --git a/MAINTAINERS b/MAINTAINERS
index aa0f65791c2ee..5627300397e23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5004,6 +5004,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git https://gitlab.collabora.com/koike/linux.git
 F:	.gitlab-ci.yml
+F:	Documentation/ci/
 F:	ci/
 
 CIRRUS LOGIC AUDIO CODEC DRIVERS
-- 
2.40.1


