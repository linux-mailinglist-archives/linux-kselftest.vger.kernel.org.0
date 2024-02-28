Return-Path: <linux-kselftest+bounces-5560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9B86BB1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9911C21A74
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2A72909;
	Wed, 28 Feb 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XE2QzdTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864671EA1;
	Wed, 28 Feb 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160950; cv=none; b=qhOM0aDfpUuyayDLfHt7oGLjF86DTfC3nYsjNqh/XRcHzPW5YoG/wXtU2J8jhUMMFZMKYbbvx1ioKhpl2PUw74Wb/trVyCOPELq9yfvok6yuU3jKZ65nHawngjcyDpI0nkA1U4Qcyah9DwZyYSYZtayMa90EcO1K7dpOGNqd6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160950; c=relaxed/simple;
	bh=hHHXqInms8Ik0LQiKPyZlJZuiftwiFOtRHazgtBxh2E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ty8ahXsRCF2vMvLnU8SJmF4St9K06fKBCDM0uyR8Qc0cGY6xH+O8bFQudva1PitByzSC1h9e9ZDBbUsxXSI8YdmRFGQOazpRRsfDOrP9zVGXkIylF8ICLJ/gqpeHDYu8MgdA+m2x+JLmTf7R4dno57ZDIK5J79cA244q7zKiGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XE2QzdTG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709160945;
	bh=hHHXqInms8Ik0LQiKPyZlJZuiftwiFOtRHazgtBxh2E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XE2QzdTGqOcKDieGZNMT30fi5vx6rxmmFmVX6gIP9TE87v2tQthAMl/7eXUxyDPKh
	 LS3vmj68a3vRiRJL676QGTsFVzl/Sj/FPgEIWJ871bUDn0aXkrR3CtLz5+mZ3/TapY
	 hdI6n9GxIiUJ93nkTPWtDVebtT8sabQikhN7CEk2G8JyYpnzIqieUHJL+h/p3Gwag9
	 jd5rk22q87Og6MemggVBmMbh1n9xCPPHC4bEIGqvrqfkiPY+xP1YruVTLdNw6JqnaU
	 n6GemkU1JZnPIwRszBvi4pzahVrHbRF97exc9cMsuIO+gGB54RWcTOBI+EIldykEA7
	 OGYKNUyRNr4pA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E311D37820D9;
	Wed, 28 Feb 2024 22:55:38 +0000 (UTC)
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
Subject: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
Date: Wed, 28 Feb 2024 19:55:25 -0300
Message-Id: <20240228225527.1052240-2-helen.koike@collabora.com>
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

This patch introduces a `.gitlab-ci` file along with a `ci/` folder,
defininga basic test pipeline triggered by code pushes to a GitLab-CI
instance. This initial version includes static checks (checkpatch and
smatch for now) and build tests across various architectures and
configurations. It leverages an integrated cache for efficient build
times and introduces a flexible 'scenarios' mechanism for
subsystem-specific extensions.

[ci: add prerequisites to run check-patch on MRs]
Co-developed-by: Tales Aparecida <tales.aparecida@redhat.com>
Signed-off-by: Tales Aparecida <tales.aparecida@redhat.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

Hey all,

You can check the validation of this patchset on:
        https://gitlab.collabora.com/koike/linux/-/pipelines/87035

I would appreciate your feedback on this work, what do you think?

If you would rate from 0 to 5, where:

[ ] 0. I don't think this is useful at all, and I doubt it will ever be. It doesn't seem worthwhile.
[ ] 1. I don't find it useful in its current form.
[ ] 2. It might be useful to others, but not for me.
[ ] 3. It has potential, but it's not yet something I can incorporate into my workflow.
[ ] 4. This is useful, but it needs some adjustments before I can include it in my workflow.
[ ] 5. This is really useful! I'm eager to start using it right away. Why didn't you send this earlier? :)

Which rating would you select?

---
 .gitlab-ci.yml                                |   2 +
 MAINTAINERS                                   |   8 ++
 ci/gitlab-ci/bootstrap-gitlab-runner.sh       |  55 +++++++++
 ci/gitlab-ci/ci-scripts/build-docs.sh         |  35 ++++++
 ci/gitlab-ci/ci-scripts/build-kernel.sh       |  35 ++++++
 ci/gitlab-ci/ci-scripts/ici-functions.sh      | 104 ++++++++++++++++++
 ci/gitlab-ci/ci-scripts/install-smatch.sh     |  13 +++
 .../ci-scripts/parse_commit_message.sh        |  27 +++++
 ci/gitlab-ci/ci-scripts/run-checkpatch.sh     |  20 ++++
 ci/gitlab-ci/ci-scripts/run-smatch.sh         |  45 ++++++++
 ci/gitlab-ci/docker-compose.yaml              |  18 +++
 ci/gitlab-ci/linux.code-workspace             |  11 ++
 ci/gitlab-ci/yml/build.yml                    |  43 ++++++++
 ci/gitlab-ci/yml/cache.yml                    |  26 +++++
 ci/gitlab-ci/yml/container.yml                |  36 ++++++
 ci/gitlab-ci/yml/gitlab-ci.yml                |  71 ++++++++++++
 ci/gitlab-ci/yml/kernel-combinations.yml      |  18 +++
 ci/gitlab-ci/yml/scenarios.yml                |  12 ++
 ci/gitlab-ci/yml/scenarios/file-systems.yml   |  21 ++++
 ci/gitlab-ci/yml/scenarios/media.yml          |  21 ++++
 ci/gitlab-ci/yml/scenarios/network.yml        |  21 ++++
 ci/gitlab-ci/yml/static-checks.yml            |  21 ++++
 22 files changed, 663 insertions(+)
 create mode 100644 .gitlab-ci.yml
 create mode 100755 ci/gitlab-ci/bootstrap-gitlab-runner.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/build-docs.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/build-kernel.sh
 create mode 100644 ci/gitlab-ci/ci-scripts/ici-functions.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/install-smatch.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/parse_commit_message.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/run-checkpatch.sh
 create mode 100755 ci/gitlab-ci/ci-scripts/run-smatch.sh
 create mode 100644 ci/gitlab-ci/docker-compose.yaml
 create mode 100644 ci/gitlab-ci/linux.code-workspace
 create mode 100644 ci/gitlab-ci/yml/build.yml
 create mode 100644 ci/gitlab-ci/yml/cache.yml
 create mode 100644 ci/gitlab-ci/yml/container.yml
 create mode 100644 ci/gitlab-ci/yml/gitlab-ci.yml
 create mode 100644 ci/gitlab-ci/yml/kernel-combinations.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/file-systems.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/media.yml
 create mode 100644 ci/gitlab-ci/yml/scenarios/network.yml
 create mode 100644 ci/gitlab-ci/yml/static-checks.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 0000000000000..fac523bb86866
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,2 @@
+include:
+  - ci/gitlab-ci/yml/gitlab-ci.yml
diff --git a/MAINTAINERS b/MAINTAINERS
index 716b2e22598c8..aa0f65791c2ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4998,6 +4998,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 F:	drivers/media/cec/i2c/ch7322.c
 
+CI AUTOMATED TESTING
+M:	Helen Koike <helen.koike@collabora.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git https://gitlab.collabora.com/koike/linux.git
+F:	.gitlab-ci.yml
+F:	ci/
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
diff --git a/ci/gitlab-ci/bootstrap-gitlab-runner.sh b/ci/gitlab-ci/bootstrap-gitlab-runner.sh
new file mode 100755
index 0000000000000..73238960d0880
--- /dev/null
+++ b/ci/gitlab-ci/bootstrap-gitlab-runner.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -eo pipefail
+
+# Define variables
+CONFIG_VOLUME="/srv/gitlab-runner/config" # Path to your GitLab Runner config
+
+# Check if RUNNER_REGISTRATION_TOKEN is set
+if [ -z "${RUNNER_REGISTRATION_TOKEN}" ]; then
+    echo "Error: RUNNER_REGISTRATION_TOKEN is not set."
+    echo "Please set the RUNNER_REGISTRATION_TOKEN environment variable and try again."
+    exit 1
+fi
+
+# Check if GITLAB_URL is set
+if [ -z "${GITLAB_URL}" ]; then
+    GITLAB_URL="https://gitlab.com/"
+    echo "Info: GITLAB_URL is not set. Using the default $GITLAB_URL"
+    echo "Please set the RUNNER_REGISTRATION_TOKEN environment variable and try again."
+fi
+
+# Check if docker-compose is installed
+if ! command -v docker-compose &> /dev/null
+then
+    echo "docker-compose could not be found. Please install it first."
+    exit 1
+fi
+
+# Start the GitLab Runner using Docker Compose
+echo "Starting GitLab Runner..."
+docker-compose up -d
+
+# Wait for a few seconds to ensure the service is up
+sleep 5
+
+# Register the GitLab Runner
+echo "Registering GitLab Runner..."
+docker run --rm -v ${CONFIG_VOLUME}:/etc/gitlab-runner gitlab/gitlab-runner register \
+  --non-interactive \
+  --url ${GITLAB_URL} \
+  --token ${RUNNER_REGISTRATION_TOKEN} \
+  --executor docker \
+  --docker-image "alpine:latest" \
+  --description "Docker Runner" \
+  --docker-privileged
+
+echo ""
+echo "INFO: To configure the number of concurrent jobs, edit the value of"
+echo "INFO: concurrent in ${CONFIG_VOLUME}/config.toml, than restart the GitLab"
+echo "INFO: Runner using docker-compose restart"
+echo ""
+echo "GitLab Runner setup complete."
diff --git a/ci/gitlab-ci/ci-scripts/build-docs.sh b/ci/gitlab-ci/ci-scripts/build-docs.sh
new file mode 100755
index 0000000000000..2053cb8794acf
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/build-docs.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_get_patch_series_size
+
+# Get the list of modified files in the last $ICI_PATCH_SERIES_SIZE commits
+MODIFIED_DOC_FILES=$(git diff HEAD~$ICI_PATCH_SERIES_SIZE --name-only -- Documentation/)
+
+make -j$(nproc) "$ICI_DOC_TYPE" 2>&1 | tee output.txt
+
+mkdir -p "${CI_PROJECT_DIR}/artifacts"
+mv Documentation/output "${CI_PROJECT_DIR}/artifacts/Documentation-output"
+
+# Check if any of the MODIFIED_DOC_FILES generated a warning
+# NOTE: the alternative solution was to touch the modified files and run make
+# again, but too much warnings still appears
+for file in $MODIFIED_DOC_FILES; do
+    if grep -qi "warning" output.txt && grep -q "$file" output.txt; then
+        echo "Warning found in $file"
+        exit 101
+    fi
+done
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the"
+    echo " whole series. Exiting with a warning."
+    exit 101
+fi
diff --git a/ci/gitlab-ci/ci-scripts/build-kernel.sh b/ci/gitlab-ci/ci-scripts/build-kernel.sh
new file mode 100755
index 0000000000000..361826368a573
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/build-kernel.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_prepare_build
+
+pushd build
+
+# compile the entire kernel
+make CF=-D__CHECK_ENDIAN__ -C "$ICI_KERNEL_DIR" O=$(pwd) -j$(nproc) 2>&1 | tee output.txt
+
+export INSTALL_PATH="${CI_PROJECT_DIR}/artifacts/"
+INSTALL_PATH+="kernel-install-${KCI_KERNEL_ARCH}-${KCI_DEFCONFIG}_config"
+mkdir -p "$INSTALL_PATH"
+
+# install the kernel image to artifacts/kernel-install
+make -C "$ICI_KERNEL_DIR" O=$(pwd) install INSTALL_PATH="$INSTALL_PATH"
+
+# install kernel modules to artifacts/kernel-install
+make -C "$ICI_KERNEL_DIR" O=$(pwd) modules_install INSTALL_MOD_PATH="$INSTALL_PATH"
+
+# export config as artifact
+cp .config "${CI_PROJECT_DIR}/artifacts/${KCI_KERNEL_ARCH}-${KCI_DEFCONFIG}_config"
+
+# if the compilation has warnings, exit with the warning code
+if grep -iq "warning" output.txt; then
+    exit 101
+fi
+
+popd
diff --git a/ci/gitlab-ci/ci-scripts/ici-functions.sh b/ci/gitlab-ci/ci-scripts/ici-functions.sh
new file mode 100644
index 0000000000000..df133b4d00103
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/ici-functions.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+# internal CI bash functions
+
+# convention:
+# KCI_<VARIABLE_NAME> for variables defined by the user (outside of this script)
+# ICI_<VARIABLE_NAME> for variables defined internally for usage between scripts
+# CI_<VARIABLE_NAME> for variables defined by GitLab CI
+
+
+ici_prepare_build() {
+    BUILD_DIR="${1:-build}"
+
+    echo ""
+    echo "Architecture: $KCI_KERNEL_ARCH"
+    echo "Defconfig: $KCI_DEFCONFIG"
+    echo ""
+
+    # Get the current directory if KCI_KERNEL_DIR is not set
+    ICI_KERNEL_DIR="${KCI_KERNEL_DIR:-$(pwd)}"
+
+    cd "$ICI_KERNEL_DIR" || { echo "Kernel directory not found"; exit 1; }
+
+    # Clean up stale rebases that GitLab might not have removed when reusing a checkout dir
+    rm -rf .git/rebase-apply
+
+    if [[ "$KCI_KERNEL_ARCH" = "arm64" ]]; then
+        GCC_ARCH="aarch64-linux-gnu"
+    elif [[ "$KCI_KERNEL_ARCH" = "arm" ]]; then
+        GCC_ARCH="arm-linux-gnueabihf"
+    else
+        GCC_ARCH="x86_64-linux-gnu"
+    fi
+
+    # do not set ARCH and CROSS_COMPILE if KCI_KERNEL_ARCH is not set, useful for local run
+    if [ -n "$KCI_KERNEL_ARCH" ]; then
+        export ARCH=${KCI_KERNEL_ARCH}
+        export CROSS_COMPILE="${GCC_ARCH}-"
+    fi
+
+    mkdir -p "$BUILD_DIR"
+
+    pushd "$BUILD_DIR" || { echo "Failed to create $BUILD_DIR directory"; exit 1; }
+
+    # generate defconfig
+    make -C "$ICI_KERNEL_DIR" O=$(pwd) $(basename ${KCI_DEFCONFIG-"defconfig"})
+
+    # add extra configs from variable KCI_KCONFIGS_{ENABLE,DISABLE,MODULE}
+    for opt in $KCI_KCONFIGS_ENABLE; do
+        ../scripts/config --file .config --enable CONFIG_$opt
+    done
+    for opt in $KCI_KCONFIGS_DISABLE; do
+        ../scripts/config --file .config --disable CONFIG_$opt
+    done
+    for opt in $KCI_KCONFIGS_MODULE; do
+        ../scripts/config --file .config --module CONFIG_$opt
+    done
+
+    if [ -n "$KCI_KCONFIGS_DISABLE" ] || [ -n "$KCI_KCONFIGS_ENABLE" ] ||
+       [ -n "$KCI_KCONFIGS_MODULE" ]; then
+        # execude olddefconfig only if we changed the default config, otherwise,
+        # let it raise warnings if any
+        make -C "$ICI_KERNEL_DIR" O=$(pwd) olddefconfig
+    fi
+
+    popd
+}
+
+ici_get_patch_series_size()
+{
+    local CLONE_DEPTH
+    CLONE_DEPTH=$(git rev-list --count HEAD)
+    echo "The depth of the clone is $CLONE_DEPTH"
+
+    # If this is in the context of a merge request, calculate the patch series
+    # size comparing to the target branch
+    if [ -n "$CI_MERGE_REQUEST_IID" ]; then
+        git fetch origin "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" --depth $CLONE_DEPTH
+        BASE_COMMIT="origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME"
+        ICI_PATCH_SERIES_SIZE=$(git rev-list --count ${BASE_COMMIT}.."$CI_COMMIT_SHA")
+
+    # if KCI_PATCH_SERIES_SIZE is set, use it
+    elif [ -n "$KCI_PATCH_SERIES_SIZE" ]; then
+        ICI_PATCH_SERIES_SIZE="$KCI_PATCH_SERIES_SIZE"
+    else
+        ICI_PATCH_SERIES_SIZE=1
+        echo "WARNING: unable to detect the patch series size, using the default value of 1."
+        # shellcheck disable=SC2034
+        ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE=true
+    fi
+
+    # Check if the clone depth is smaller than or equal to KCI_PATCH_SERIES_SIZE,
+    # otherwise the checkpatch.pl hangs
+    if [ "$ICI_PATCH_SERIES_SIZE" -ge "$CLONE_DEPTH" ]; then
+        echo -n "ERROR: the depth of the clone is $CLONE_DEPTH, smaller than or equal to the patch"
+        echo " series size. Update your GitLab configuration to increase the size of the clone."
+        return 1
+    fi
+}
diff --git a/ci/gitlab-ci/ci-scripts/install-smatch.sh b/ci/gitlab-ci/ci-scripts/install-smatch.sh
new file mode 100755
index 0000000000000..cae16a0e90fa8
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/install-smatch.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+pushd /
+git clone --depth 1 https://repo.or.cz/smatch.git
+pushd smatch
+make
+popd
+popd
diff --git a/ci/gitlab-ci/ci-scripts/parse_commit_message.sh b/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
new file mode 100755
index 0000000000000..c9792c64ad51e
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/parse_commit_message.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+# Get the last commit message
+commit_message=$(git log -1 --pretty=%B)
+
+pattern='(KCI_[A-Za-z_]+)=("[^"]*"|[^ ]+)'
+
+while read -r line; do
+    if [[ $line =~ $pattern ]]; then
+        variable_name="${BASH_REMATCH[1]}"
+        variable_value="${BASH_REMATCH[2]}"
+
+        # Remove quotes if present
+        variable_value="${variable_value%\"}"
+        variable_value="${variable_value#\"}"
+
+        # Export the variable
+        export "$variable_name=$variable_value"
+
+        echo "Exported $variable_name=$variable_value"
+    fi
+done <<< "$commit_message"
diff --git a/ci/gitlab-ci/ci-scripts/run-checkpatch.sh b/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
new file mode 100755
index 0000000000000..98585ec18be2b
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/run-checkpatch.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ici_get_patch_series_size
+
+# shellcheck disable=SC2086
+scripts/checkpatch.pl $KCI_CHECKPATCH_OPTIONS --git HEAD-"$ICI_PATCH_SERIES_SIZE"
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the whole series."
+    echo " Exiting with a warning."
+    exit 101
+fi
diff --git a/ci/gitlab-ci/ci-scripts/run-smatch.sh b/ci/gitlab-ci/ci-scripts/run-smatch.sh
new file mode 100755
index 0000000000000..ec054df9ef179
--- /dev/null
+++ b/ci/gitlab-ci/ci-scripts/run-smatch.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+set -exo pipefail
+
+source ci/gitlab-ci/ci-scripts/ici-functions.sh
+
+ls -l
+pwd
+
+# generate config file
+ici_prepare_build
+
+ici_get_patch_series_size
+
+cp build/.config .
+
+# Get a list of modified .c files in the last ICI_PATCH_SERIES_SIZE commits
+MODIFIED_C_FILES=$(git diff --name-only HEAD~$ICI_PATCH_SERIES_SIZE HEAD | grep '\.c$' || true)
+
+# Check if any .c files were modified
+if [ -z "$MODIFIED_C_FILES" ]; then
+    echo "No .c files were modified in the last $ICI_PATCH_SERIES_SIZE commits."
+else
+    echo "Running kchecker on modified .c files..."
+    mkdir -p "$CI_PROJECT_DIR"/artifacts
+fi
+
+# Run kchecker on each modified .c file
+for file in $MODIFIED_C_FILES; do
+    if [ -f "$file" ]; then
+        /smatch/smatch_scripts/kchecker "$file" | tee "$CI_PROJECT_DIR"/artifacts/smatch_warns.txt
+    else
+        echo "File not found: $file"
+    fi
+done
+
+if [ -n "$ICI_UNABLE_TO_DETECT_PATCH_SERIES_SIZE" ]; then
+    # If the patch series size was not detected, exit with a warning
+    echo -n "The patch series size was not detected, we probably didn't check the whole series."
+    echo " Exiting with a warning."
+    exit 101
+fi
diff --git a/ci/gitlab-ci/docker-compose.yaml b/ci/gitlab-ci/docker-compose.yaml
new file mode 100644
index 0000000000000..7edf8055ca375
--- /dev/null
+++ b/ci/gitlab-ci/docker-compose.yaml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+version: '3.8'
+
+services:
+  gitlab-runner:
+    image: gitlab/gitlab-runner:latest
+    container_name: gitlab-runner
+    restart: always
+    privileged: true
+    volumes:
+      - /srv/gitlab-runner/config:/etc/gitlab-runner
+      - /var/run/docker.sock:/var/run/docker.sock
+
+# To register the GitLab Runner, run the following command:
+# docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register --url https://gitlab.com --token YOUR_REGISTRATION_TOKEN
diff --git a/ci/gitlab-ci/linux.code-workspace b/ci/gitlab-ci/linux.code-workspace
new file mode 100644
index 0000000000000..dd76698e38c2c
--- /dev/null
+++ b/ci/gitlab-ci/linux.code-workspace
@@ -0,0 +1,11 @@
+{
+	"folders": [
+		{
+			"path": "../../../.."
+		},
+		{
+			"path": "../../../../../mesa"
+		}
+	],
+	"settings": {}
+}
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/build.yml b/ci/gitlab-ci/yml/build.yml
new file mode 100644
index 0000000000000..f81410c293f35
--- /dev/null
+++ b/ci/gitlab-ci/yml/build.yml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.build:
+  extends: .use-debian/x86_64_build
+  stage: build
+
+build-kernel:
+  extends:
+    - .build
+    - .kernel-combinations
+  variables:
+    # ccache in gitlab-runner to speed up builds
+    CCACHE_BASEDIR: $CI_PROJECT_DIR
+    CCACHE_DIR: $CI_PROJECT_DIR/ccache
+    CCACHE_COMPILERCHECK: content
+  cache:
+    - key: ccache-$CI_JOB_NAME
+      paths:
+        - $CCACHE_DIR
+  before_script:
+    - export PATH="/usr/lib/ccache:$PATH"
+    - ccache --zero-stats || true
+    - ccache --show-stats || true
+  after_script:
+    - ccache --show-stats
+  script:
+    - ./ci/gitlab-ci/ci-scripts/build-kernel.sh
+
+build-docs:
+  extends:
+    - .build
+  parallel:
+    matrix:
+      - ICI_DOC_TYPE: "htmldocs"
+      # TODO: re-add pdfdocs once build errors are fixed
+      # - ICI_DOC_TYPE: "pdfdocs"
+      - ICI_DOC_TYPE: "latexdocs"
+      - ICI_DOC_TYPE: "epubdocs"
+  script:
+    - ./ci/gitlab-ci/ci-scripts/build-docs.sh
+  when: manual
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/cache.yml b/ci/gitlab-ci/yml/cache.yml
new file mode 100644
index 0000000000000..efe4fc69b11ca
--- /dev/null
+++ b/ci/gitlab-ci/yml/cache.yml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Smatch db is saved to a cached folder, so it can be used by other jobs and pipelines.
+# It is set to manual so it can be run when needed
+
+.use-cache-smatch-db:
+  cache:
+    # TODO: check if this cache shouldn't be per architecture
+    - key: smatch-db
+      paths:
+        - /smatch/smatch_data
+
+smatch-db-generate:
+  stage: cache
+  extends:
+    - .kernel-combinations
+    - .use-debian/x86_64_build
+    - .use-cache-smatch-db
+  script:
+    - source ci/gitlab-ci/ci-scripts/ici-functions.sh
+    - ici_prepare_build
+    - cp build/.config .
+    - /smatch/smatch_scripts/build_kernel_data.sh
+  when: manual
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/container.yml b/ci/gitlab-ci/yml/container.yml
new file mode 100644
index 0000000000000..eecca95caca0e
--- /dev/null
+++ b/ci/gitlab-ci/yml/container.yml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.prep-debian/x86_64_build:
+  variables:
+    FDO_DISTRIBUTION_VERSION: bookworm-slim
+    FDO_DISTRIBUTION_TAG: "2024-02-28-ci-test-1"
+
+
+debian/x86_64_build:
+  extends:
+    - ".fdo.container-build@debian"
+    - ".prep-debian/x86_64_build"
+  variables:
+    FDO_DISTRIBUTION_PACKAGES: >
+      make bc flex bison pahole mount build-essential
+      libcairo-dev libdw-dev libjson-c-dev libkmod2
+      libkmod-dev libpciaccess-dev libproc2-dev libudev-dev
+      libunwind-dev python3-docutils bc python3-ply
+      libssl-dev ccache
+      gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
+      gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
+      perl git kmod python3-git python3-yaml python3-dulwich
+      sqlite3 libsqlite3-dev libdbd-sqlite3-perl libssl-dev libtry-tiny-perl
+      python3-sphinx imagemagick graphviz dvipng python3-venv fonts-noto-cjk
+      latexmk librsvg2-bin texlive-lang-chinese texlive-xetex
+    FDO_DISTRIBUTION_EXEC: ./ci/gitlab-ci/ci-scripts/install-smatch.sh
+  stage: container
+
+
+.use-debian/x86_64_build:
+  extends:
+    - ".fdo.distribution-image@debian"
+    - ".prep-debian/x86_64_build"
+  needs: [debian/x86_64_build]
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/gitlab-ci.yml b/ci/gitlab-ci/yml/gitlab-ci.yml
new file mode 100644
index 0000000000000..57b9c02904713
--- /dev/null
+++ b/ci/gitlab-ci/yml/gitlab-ci.yml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+workflow:
+  name: $PIPELINE_NAME
+  rules:
+    # when triggered as a multi-project pipeline for an MR
+    - if: $CI_PIPELINE_SOURCE == 'pipeline' && $PARENT_MERGE_REQUEST_IID != null && $PARENT_MERGE_REQUEST_IID != ""
+      variables:
+        PIPELINE_NAME: 'Downstream pipeline for $PARENT_PROJECT_PATH!$PARENT_MERGE_REQUEST_IID'
+    # when triggered as a multi-project pipeline
+    - if: $CI_PIPELINE_SOURCE == 'pipeline'
+      variables:
+        PIPELINE_NAME: 'Downstream pipeline for $PARENT_PROJECT_PATH'
+    # when triggered via a schedule
+    - if: $CI_PIPELINE_SOURCE == 'schedule'
+      variables:
+        PIPELINE_NAME: 'Scheduled pipeline for $ONLY_JOB_NAME'
+    # for merge requests
+    - if: $CI_MERGE_REQUEST_ID
+    # when triggered via the REST api
+    - if: $CI_PIPELINE_SOURCE == 'api'
+    # for the tip of the default branch
+    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
+    # when triggered via a trigger token
+    - if: $CI_PIPELINE_SOURCE == 'trigger'
+    # when triggered from a button press in the web interface
+    - if: $CI_PIPELINE_SOURCE == 'web'
+    # for branch tips without open MRs, ignoring special branches
+    - if: $CI_PIPELINE_SOURCE == 'push' && $CI_OPEN_MERGE_REQUESTS == null
+    # when forced via '-o ci.variable="FORCE_CI=true"' during pushing
+    - if: $FORCE_CI == 'true'
+
+variables:
+  FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where to look for cached images
+    # ccache builds in gitlab-runner to speed up builds
+  SMATCH_DB_DIR: /smatch/smatch_data
+  # exit code of bash script on `script` will be the exit code of the job
+  FF_USE_NEW_BASH_EVAL_STRATEGY: "true"
+
+default:
+  artifacts:
+    paths:
+      - artifacts/
+    when: always
+
+include:
+  - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/ci-fairy.yml'
+  - remote: 'https://gitlab.freedesktop.org/freedesktop/ci-templates/-/raw/16bc29078de5e0a067ff84a1a199a3760d3b3811/templates/debian.yml'
+
+  - ci/gitlab-ci/yml/kernel-combinations.yml
+  - ci/gitlab-ci/yml/container.yml
+  - ci/gitlab-ci/yml/cache.yml
+  - ci/gitlab-ci/yml/build.yml
+  - ci/gitlab-ci/yml/static-checks.yml
+  - ci/gitlab-ci/yml/scenarios.yml
+
+before_script:
+  - source ci/gitlab-ci/ci-scripts/parse_commit_message.sh
+
+.use-debian/x86_64_build:
+  allow_failure:
+    # Code to exit with a warning
+    exit_codes: 101
+
+stages:
+  - container
+  - static-checks
+  - build
+  - cache
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/kernel-combinations.yml b/ci/gitlab-ci/yml/kernel-combinations.yml
new file mode 100644
index 0000000000000..87f08579ffd62
--- /dev/null
+++ b/ci/gitlab-ci/yml/kernel-combinations.yml
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.kernel-combinations:
+  parallel:
+    matrix:
+      - KCI_KERNEL_ARCH: "x86_64"
+        KCI_DEFCONFIG: "x86_64_defconfig"
+        KCI_KCONFIGS_ENABLE: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT CONFIG_DEBUG_SECTION_MISMATCH"
+
+      - KCI_KERNEL_ARCH: "arm64"
+        KCI_DEFCONFIG: "defconfig"
+        KCI_KCONFIGS_ENABLE: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT CONFIG_DEBUG_SECTION_MISMATCH"
+
+      - KCI_KERNEL_ARCH: "arm"
+        KCI_DEFCONFIG: "multi_v7_defconfig"
+        KCI_KCONFIGS_ENABLE: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT CONFIG_DEBUG_SECTION_MISMATCH"
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/scenarios.yml b/ci/gitlab-ci/yml/scenarios.yml
new file mode 100644
index 0000000000000..11598c3b6f2a9
--- /dev/null
+++ b/ci/gitlab-ci/yml/scenarios.yml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Extend the CI by including a test scenario here. The scenario will be
+# activated if KCI_SCENARIO is set to the scenario name. KCI_SCENARIO can be
+# defined in the gitlab-ci.yml file, or through GitLab UI.
+
+include:
+  - local: 'ci/gitlab-ci/yml/scenarios/$KCI_SCENARIO.yml'
+    rules:
+      - if: '$KCI_SCENARIO'
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/scenarios/file-systems.yml b/ci/gitlab-ci/yml/scenarios/file-systems.yml
new file mode 100644
index 0000000000000..66456600a9dd3
--- /dev/null
+++ b/ci/gitlab-ci/yml/scenarios/file-systems.yml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# .kernel-combinations:
+#   parallel:
+#     matrix:
+#       - KCI_KERNEL_ARCH: "x86_64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/scenarios/media.yml b/ci/gitlab-ci/yml/scenarios/media.yml
new file mode 100644
index 0000000000000..66456600a9dd3
--- /dev/null
+++ b/ci/gitlab-ci/yml/scenarios/media.yml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# .kernel-combinations:
+#   parallel:
+#     matrix:
+#       - KCI_KERNEL_ARCH: "x86_64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/scenarios/network.yml b/ci/gitlab-ci/yml/scenarios/network.yml
new file mode 100644
index 0000000000000..66456600a9dd3
--- /dev/null
+++ b/ci/gitlab-ci/yml/scenarios/network.yml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+# Write here specific configurations and extensions for the given scenario
+
+# Example - overwrite kernel combinations in the pipeline
+# .kernel-combinations:
+#   parallel:
+#     matrix:
+#       - KCI_KERNEL_ARCH: "x86_64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm64"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
+#
+#       - KCI_KERNEL_ARCH: "arm"
+#         KCI_DEFCONFIG: "path/to/my/config/file_config"
+#         KCI_ENABLE_KCONFIGS: "CONFIG1 CONFIG2 CONFIG3 ..."
\ No newline at end of file
diff --git a/ci/gitlab-ci/yml/static-checks.yml b/ci/gitlab-ci/yml/static-checks.yml
new file mode 100644
index 0000000000000..a99a1ea910f40
--- /dev/null
+++ b/ci/gitlab-ci/yml/static-checks.yml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+
+.static-checks:
+  stage: static-checks
+  extends:
+    - .use-debian/x86_64_build
+
+checkpatch:
+  extends: .static-checks
+  script:
+    - ci/gitlab-ci/ci-scripts/run-checkpatch.sh
+
+smatch:
+  extends:
+    - .static-checks
+    - .kernel-combinations
+    - .use-cache-smatch-db
+  script:
+    - ci/gitlab-ci/ci-scripts/run-smatch.sh
\ No newline at end of file
-- 
2.40.1


