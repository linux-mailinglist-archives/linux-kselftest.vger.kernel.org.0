Return-Path: <linux-kselftest+bounces-25007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E6A1A54B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7851882FE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A934211269;
	Thu, 23 Jan 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="afpqeILm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31420FA8E;
	Thu, 23 Jan 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640514; cv=none; b=tKYH6ihFCMzQUqJ/pIKvthHDcogQsMU/7O+ucm+YonAd6dL/Qr7OZufJVsasaL6niK0RecXAMngWACXp6s/KyBf4h4vmG4SB0nYbChBPa5IuUZNHSSAcPmycX9dbIbaZuyLTp5ACj7iip/6EznvQzrB3rS1DGYA5dW//1qY1AlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640514; c=relaxed/simple;
	bh=fxWS3NGelXBYFJWvJ4HFLdQKrZf9ZSrAO6ZxxtsJC08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5g/d/iM4JOefFjYeTzYc9NxZ+EH1eTV0DLLgZ9IMXAdRLGECrpBCnDN8bgEX3mlskGvueeG01VVRimxt56fxZjaLeZDjl2qS6Hd/CGdqkM0K5C84FcBKaYIIqmiUadcSrR9NjHQd3xn4TQ5KNlPCcIUUA63jYhMRfcA+Fo0IMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=afpqeILm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737640506;
	bh=fxWS3NGelXBYFJWvJ4HFLdQKrZf9ZSrAO6ZxxtsJC08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afpqeILm14xWgmp/F79xLI5X3QjSpw4LU1lMuhaIz9TlTj+m8h3Br9KwtmJQJuxKU
	 YXE7dULns+34frw9AZqqe1JbswmSxTbkDZ5VBl9vSn1tKtc9b555YufKUeqo1//TAK
	 iM+r8sn02Ldd2eRWxPYDs3axDVXAd77IFfSXFNVO+KsNpTkyqWOFXDhmEtf0vkiOu9
	 nzbs4oFUETUv7ydi1c/iegylPo06S6ngMP0taSYe4F4kykk7WLO3sMorWsJ54Rrgat
	 SAfAY1k6dQdSolaozqZqtHs9JUxWYYARZkJuiOCDUy4wLfYzWKq+JEloIr10qcoGav
	 jN8/b/XzBrmxg==
Received: from localhost.localdomain (unknown [171.76.86.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 702AA17E0EA4;
	Thu, 23 Jan 2025 14:54:49 +0100 (CET)
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
Subject: [PATCH v2 3/5] kci-gitlab: Add drm scenario
Date: Thu, 23 Jan 2025 19:23:33 +0530
Message-ID: <20250123135342.1468787-4-vignesh.raman@collabora.com>
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

Add a drm scenario that includes a job to run IGT tests for vkms.
It also includes helper scripts to build deqp-runner and IGT,
which are based on the mesa-ci project.

The xfails are added from drm-ci (drivers/gpu/drm/ci/xfails)
Refer to Documentation/gpu/automated_testing.rst for details
regarding fails/flakes/skips files.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 MAINTAINERS                                   |   1 +
 .../scenarios/drm/build-deqp-runner.sh        |  42 +
 tools/ci/gitlab-ci/scenarios/drm/build-igt.sh |  80 ++
 .../ci/gitlab-ci/scenarios/drm/build-rust.sh  |  42 +
 .../scenarios/drm/create-cross-file.sh        |  65 ++
 tools/ci/gitlab-ci/scenarios/drm/drm.yml      |  45 +-
 .../scenarios/drm/prepare-container.sh        |  18 +
 tools/ci/gitlab-ci/scenarios/drm/run-igt.sh   |  83 ++
 tools/ci/gitlab-ci/scenarios/drm/test.yml     |  32 +
 .../scenarios/drm/xfails/vkms-none-fails.txt  |  22 +
 .../scenarios/drm/xfails/vkms-none-flakes.txt |  90 ++
 .../scenarios/drm/xfails/vkms-none-skips.txt  | 812 ++++++++++++++++++
 12 files changed, 1326 insertions(+), 6 deletions(-)
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-igt.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/build-rust.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh
 create mode 100755 tools/ci/gitlab-ci/scenarios/drm/run-igt.sh
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/test.yml
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt
 create mode 100644 tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 874044e570f7..8de12618c3e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7551,6 +7551,7 @@ S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/gpu/vkms.rst
 F:	drivers/gpu/drm/ci/xfails/vkms*
+F:	tools/ci/gitlab-ci/scenarios/drm/xfails/vkms*
 F:	drivers/gpu/drm/vkms/
 
 DRM DRIVER FOR VIRTUALBOX VIRTUAL GPU
diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh b/tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh
new file mode 100755
index 000000000000..9f2574537423
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh
@@ -0,0 +1,42 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the build-deqp-runner.sh script from the mesa project:
+# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/container/build-deqp-runner.sh
+#
+# shellcheck disable=SC2086 # we want word splitting
+
+set -uex
+
+DEQP_RUNNER_GIT_URL="${DEQP_RUNNER_GIT_URL:-https://gitlab.freedesktop.org/mesa/deqp-runner.git}"
+DEQP_RUNNER_GIT_TAG="${DEQP_RUNNER_GIT_TAG:-v0.20.0}"
+
+git clone $DEQP_RUNNER_GIT_URL --single-branch --no-checkout
+pushd deqp-runner
+git checkout $DEQP_RUNNER_GIT_TAG
+
+RUST_TARGET="${RUST_TARGET:-}"
+
+# When CC (/usr/lib/ccache/gcc) variable is set, the rust compiler uses
+# this variable when cross-compiling arm32 and build fails for zsys-sys.
+# So unset the CC variable when cross-compiling for arm32.
+SAVEDCC=${CC:-}
+if [ "$RUST_TARGET" = "armv7-unknown-linux-gnueabihf" ]; then
+    unset CC
+fi
+cargo install --locked  \
+    -j ${FDO_CI_CONCURRENT:-4} \
+    --root /usr/local \
+    ${EXTRA_CARGO_ARGS:-} \
+    --path .
+CC=$SAVEDCC
+
+popd
+rm -rf deqp-runner
+
+# remove unused test runners
+if [ -z "${DEQP_RUNNER_GIT_TAG:-}" ]; then
+    rm -f /usr/local/bin/igt-runner
+fi
diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-igt.sh b/tools/ci/gitlab-ci/scenarios/drm/build-igt.sh
new file mode 100755
index 000000000000..fc82aa6fddec
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/build-igt.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the build-igt.sh script from the drm-ci project:
+# https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/ci/build-igt.sh
+
+set -ex
+
+function generate_testlist {
+    set +x
+    while read -r line; do
+        if [ "$line" = "TESTLIST" ] || [ "$line" = "END TESTLIST" ]; then
+            continue
+        fi
+
+        tests=$(echo "$line" | tr ' ' '\n')
+
+        for test in $tests; do
+            output=$(/igt/libexec/igt-gpu-tools/"$test" --list-subtests || true)
+
+            if [ -z "$output" ]; then
+                echo "$test"
+            else
+                echo "$output" | while read -r subtest; do
+                    echo "$test@$subtest"
+                done
+            fi
+        done
+    done < /igt/libexec/igt-gpu-tools/test-list.txt > /igt/libexec/igt-gpu-tools/ci-testlist.txt
+    set -x
+}
+
+git clone https://gitlab.freedesktop.org/drm/igt-gpu-tools.git --single-branch --no-checkout
+pushd igt-gpu-tools
+git checkout $IGT_VERSION
+
+if [[ "$KCI_KERNEL_ARCH" = "arm" ]]; then
+    . ../tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh armhf
+    EXTRA_MESON_ARGS="--cross-file /cross_file-armhf.txt"
+fi
+
+MESON_OPTIONS="-Doverlay=disabled                    \
+               -Dchamelium=disabled                  \
+               -Dvalgrind=disabled                   \
+               -Dman=enabled                         \
+               -Dtests=enabled                       \
+               -Drunner=enabled                      \
+               -Dlibunwind=enabled                   \
+               -Dprefix=/igt"
+
+if [[ "$KCI_KERNEL_ARCH" = "arm64" ]] || [[ "$KCI_KERNEL_ARCH" = "arm" ]]; then
+    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
+fi
+
+mkdir -p /igt
+meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
+ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
+ninja -C build install
+
+if [[ "$KCI_KERNEL_ARCH" = "arm64" ]]; then
+    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu
+elif [[ "$KCI_KERNEL_ARCH" = "arm" ]]; then
+    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib
+else
+    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/x86_64-linux-gnu
+fi
+
+echo "Generating ci-testlist.txt"
+generate_testlist
+
+export INSTALL_PATH="${CI_PROJECT_DIR}/artifacts/"
+INSTALL_PATH+="igt-install-${KCI_KERNEL_ARCH}"
+mkdir -p "$INSTALL_PATH"
+
+tar -cf $INSTALL_PATH/igt.tar /igt
+
+popd
+rm -rf igt-gpu-tools
diff --git a/tools/ci/gitlab-ci/scenarios/drm/build-rust.sh b/tools/ci/gitlab-ci/scenarios/drm/build-rust.sh
new file mode 100755
index 000000000000..48702d5a9648
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/build-rust.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the build-rust.sh script from the mesa project:
+# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/container/build-rust.sh
+
+# Note that this script is not actually "building" rust, but build- is the
+# convention for the shared helpers for putting stuff in our containers.
+
+set -ex
+
+# cargo (and rustup) wants to store stuff in $HOME/.cargo, and binaries in
+# $HOME/.cargo/bin.  Make bin a link to a public bin directory so the commands
+# are just available to all build jobs.
+mkdir -p "$HOME"/.cargo
+ln -s /usr/local/bin "$HOME"/.cargo/bin
+
+# Pick a specific snapshot from rustup so the compiler doesn't drift on us.
+RUST_VERSION=1.78.0-2024-05-02
+
+# For rust in Mesa, we use rustup to install.  This lets us pick an arbitrary
+# version of the compiler, rather than whatever the container's Debian comes
+# with.
+curl -L --retry 4 -f --retry-all-errors --retry-delay 60 \
+    --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
+      --default-toolchain $RUST_VERSION \
+      --profile minimal \
+      -y
+
+rustup component add clippy rustfmt
+
+# Set up a config script for cross compiling -- cargo needs your system cc for
+# linking in cross builds, but doesn't know what you want to use for system cc.
+cat > /root/.cargo/config <<EOF
+[target.armv7-unknown-linux-gnueabihf]
+linker = "arm-linux-gnueabihf-gcc"
+
+[target.aarch64-unknown-linux-gnu]
+linker = "aarch64-linux-gnu-gcc"
+EOF
diff --git a/tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh b/tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh
new file mode 100755
index 000000000000..e078346f23b3
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/create-cross-file.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the create-cross-file.sh script from the mesa project:
+# https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/container/create-cross-file.sh
+
+arch=$1
+cross_file="/cross_file-$arch.txt"
+meson env2mfile --cross --debarch "$arch" -o "$cross_file"
+
+# Explicitly set ccache path for cross compilers
+sed -i \
+    "s|/usr/bin/\([^-]*\)-linux-gnu\([^-]*\)-g|/usr/lib/ccache/\\1-linux-gnu\\2-g|g" \
+    "$cross_file"
+
+# Rely on qemu-user being configured in binfmt_misc on the host
+# shellcheck disable=SC1003 # how this sed doesn't seems to work for me locally
+sed -i -e '/\[properties\]/a\' -e "needs_exe_wrapper = False" "$cross_file"
+
+# Add a line for rustc, which meson env2mfile is missing.
+cc=$(sed -n "s|^c\s*=\s*\[?'\(.*\)'\]?|\1|p" < "$cross_file")
+
+if [[ "$arch" = "arm64" ]]; then
+    rust_target=aarch64-unknown-linux-gnu
+elif [[ "$arch" = "armhf" ]]; then
+    rust_target=armv7-unknown-linux-gnueabihf
+elif [[ "$arch" = "i386" ]]; then
+    rust_target=i686-unknown-linux-gnu
+elif [[ "$arch" = "ppc64el" ]]; then
+    rust_target=powerpc64le-unknown-linux-gnu
+elif [[ "$arch" = "s390x" ]]; then
+    rust_target=s390x-unknown-linux-gnu
+else
+    echo "Needs rustc target mapping"
+fi
+
+# shellcheck disable=SC1003 # single-quoted string ends in a backslash
+sed -i \
+    -e '/\[binaries\]/a\' \
+    -e "rust = ['rustc', '--target=$rust_target', '-C', 'linker=$cc']" \
+    "$cross_file"
+
+# Set up cmake cross compile toolchain file for dEQP builds
+toolchain_file="/toolchain-$arch.cmake"
+if [[ "$arch" = "arm64" ]]; then
+    GCC_ARCH="aarch64-linux-gnu"
+    DE_CPU="DE_CPU_ARM_64"
+elif [[ "$arch" = "armhf" ]]; then
+    GCC_ARCH="arm-linux-gnueabihf"
+    DE_CPU="DE_CPU_ARM"
+fi
+
+if [[ -n "$GCC_ARCH" ]]; then
+    {
+        echo "set(CMAKE_SYSTEM_NAME Linux)";
+        echo "set(CMAKE_SYSTEM_PROCESSOR arm)";
+        echo "set(CMAKE_C_COMPILER /usr/lib/ccache/$GCC_ARCH-gcc)";
+        echo "set(CMAKE_CXX_COMPILER /usr/lib/ccache/$GCC_ARCH-g++)";
+        echo "set(CMAKE_CXX_FLAGS_INIT \"-Wno-psabi\")";  # makes ABI warnings quiet for ARMv7
+        echo "set(ENV{PKG_CONFIG} \"/usr/bin/$GCC_ARCH-pkgconf\")";
+        echo "set(DE_CPU $DE_CPU)";
+    } > "$toolchain_file"
+fi
diff --git a/tools/ci/gitlab-ci/scenarios/drm/drm.yml b/tools/ci/gitlab-ci/scenarios/drm/drm.yml
index 206e6f0d1a46..220223544673 100644
--- a/tools/ci/gitlab-ci/scenarios/drm/drm.yml
+++ b/tools/ci/gitlab-ci/scenarios/drm/drm.yml
@@ -1,11 +1,44 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2024 Collabora, Helen Koike <helen.koike@collabora.com>
+# DRM-specific scenario configurations based on drivers/gpu/drm/ci/build.yml
 
-# Write here specific configurations and extensions for the given scenario
+variables:
+  FDO_DISTRIBUTION_TAG: "2025-01-21-drm"
+  FDO_DISTRIBUTION_EXEC: ./tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh
+  IGT_VERSION: a73311079a5d8ac99eb25336a8369a2c3c6b519b
+  DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runner.git
+  DEQP_RUNNER_GIT_TAG: v0.20.0
 
-# Example - overwrite kernel combinations in the pipeline
-# build:arm64:
-#   variables:
-#     KCI_KCONFIGS_ENABLE: "CONFIG1 CONFIG2"
-#     KCI_DEFCONFIG: "my/custom/config1"
+build:x86_64:
+  variables:
+    KCI_KCONFIGS_ENABLE: "DRM_VKMS DRM_BOCHS"
+
+.igt:
+  stage: build
+  script:
+    - FDO_CI_CONCURRENT=${FDO_CI_CONCURRENT} bash ./tools/ci/gitlab-ci/scenarios/drm/build-igt.sh
+  artifacts:
+    when: always
+    paths:
+      - artifacts/
+
+# Build IGT for testing on devices
+# TODO: Fix cross compilation issue
+.igt:arm32:
+  extends:
+    - .arm32-config
+    - .use-debian/arm64_build
+    - .igt
+
+igt:arm64:
+  extends:
+    - .arm64-config
+    - .use-debian/arm64_build
+    - .igt
+
+igt:x86_64:
+  extends:
+    - .x86_64-config
+    - .use-debian/x86_64_build
+    - .igt
diff --git a/tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh b/tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh
new file mode 100755
index 000000000000..43fbfdcd3514
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/prepare-container.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+set -ex
+
+############### Install Smatch
+
+. ./tools/ci/gitlab-ci/ci-scripts/install-smatch.sh
+
+############### Install Rust toolchain
+
+. ./tools/ci/gitlab-ci/scenarios/drm/build-rust.sh
+
+############### Build dEQP runner
+
+. ./tools/ci/gitlab-ci/scenarios/drm/build-deqp-runner.sh
diff --git a/tools/ci/gitlab-ci/scenarios/drm/run-igt.sh b/tools/ci/gitlab-ci/scenarios/drm/run-igt.sh
new file mode 100755
index 000000000000..4822fcc2780f
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/run-igt.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+#
+# Based on the igt_runner.sh script from the drm-ci project:
+# https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/ci/igt_runner.sh
+
+set -ex
+
+STATUS_FILE="${1}"
+
+export IGT_FORCE_DRIVER=${DRIVER_NAME}
+export PATH=$PATH:/igt/bin/
+export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:\
+/igt/lib/aarch64-linux-gnu:\
+/igt/lib/x86_64-linux-gnu:\
+/igt/lib:\
+/igt/lib64
+
+# Uncomment the below to debug problems with driver probing
+: '
+ls -l /dev/dri/
+cat /sys/kernel/debug/devices_deferred
+cat /sys/kernel/debug/device_component/*
+'
+
+# Dump drm state to confirm that kernel was able to find a connected display:
+set +e
+cat /sys/kernel/debug/dri/*/state
+set -e
+
+if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-skips.txt" ]; then
+    IGT_SKIPS="--skips /install/xfails/$DRIVER_NAME-$GPU_VERSION-skips.txt"
+fi
+
+if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-flakes.txt" ]; then
+    IGT_FLAKES="--flakes /install/xfails/$DRIVER_NAME-$GPU_VERSION-flakes.txt"
+fi
+
+if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-fails.txt" ]; then
+    IGT_FAILS="--baseline /install/xfails/$DRIVER_NAME-$GPU_VERSION-fails.txt"
+fi
+
+TESTLIST="/igt/libexec/igt-gpu-tools/ci-testlist.txt"
+
+# If the job is parallel at the gitab job level, take the corresponding fraction
+# of the caselist.
+if [ -n "$CI_NODE_INDEX" ]; then
+    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" $TESTLIST
+fi
+
+# core_getversion checks if the driver is loaded and probed correctly
+# so run it in all shards
+if ! grep -q "core_getversion" $TESTLIST; then
+    # Add the line to the file
+    echo "core_getversion" >> $TESTLIST
+fi
+
+set +e
+igt-runner \
+    run \
+    --igt-folder /igt/libexec/igt-gpu-tools \
+    --caselist $TESTLIST \
+    --output /results \
+    -vvvv \
+    $IGT_SKIPS \
+    $IGT_FLAKES \
+    $IGT_FAILS \
+    --jobs 1
+ret=$?
+set -e
+
+deqp-runner junit \
+   --testsuite IGT \
+   --results /results/failures.csv \
+   --output /results/junit.xml \
+   --limit 50 \
+   --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.freedesktop.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testcase}}.xml"
+
+cd $oldpath
+echo $ret > ${STATUS_FILE}
+exit $ret
diff --git a/tools/ci/gitlab-ci/scenarios/drm/test.yml b/tools/ci/gitlab-ci/scenarios/drm/test.yml
new file mode 100644
index 000000000000..9fb37beb446d
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/test.yml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Collabora, Vignesh Raman <vignesh.raman@collabora.com>
+
+vkms:none:
+  extends: build:x86_64
+  stage: test
+  timeout: "1h30m"
+  variables:
+    DRIVER_NAME: vkms
+    GPU_VERSION: none
+  tags:
+    - kvm
+  script:
+    - mkdir -p /install/xfails
+    - cp -rfv tools/ci/gitlab-ci/scenarios/drm/xfails /install/
+    - cp $CI_PROJECT_DIR/artifacts/kernel-install-${KCI_KERNEL_ARCH}/bzImage /install
+    - tar -xv -C / -f $CI_PROJECT_DIR/artifacts/igt-install-${KCI_KERNEL_ARCH}/igt.tar
+    - mkdir -p $CI_PROJECT_DIR/results
+    - ln -sf $CI_PROJECT_DIR/results /results
+    - ./tools/ci/gitlab-ci/ci-scripts/run-virtme.sh /install/bzImage ./tools/ci/gitlab-ci/scenarios/drm/run-igt.sh "DRIVER_NAME=$DRIVER_NAME GPU_VERSION=$GPU_VERSION"
+  artifacts:
+    when: always
+    paths:
+      - results/
+  needs:
+    - build:x86_64
+    - igt:x86_64
+
+test-boot:
+  rules:
+    - when: never
diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt
new file mode 100644
index 000000000000..3979c95c07ed
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-fails.txt
@@ -0,0 +1,22 @@
+kms_cursor_crc@cursor-rapid-movement-256x85,Fail
+kms_cursor_crc@cursor-rapid-movement-32x10,Fail
+kms_cursor_crc@cursor-rapid-movement-64x64,Fail
+kms_cursor_legacy@basic-flip-before-cursor-atomic,Fail
+kms_cursor_legacy@basic-flip-before-cursor-legacy,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic,Fail
+kms_cursor_legacy@cursor-vs-flip-legacy,Fail
+kms_cursor_legacy@cursor-vs-flip-toggle,Fail
+kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
+kms_cursor_legacy@flip-vs-cursor-atomic,Fail
+kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail
+kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail
+kms_cursor_legacy@flip-vs-cursor-legacy,Fail
+kms_flip@flip-vs-modeset-vs-hang,Fail
+kms_flip@flip-vs-panning-vs-hang,Fail
+kms_writeback@writeback-check-output,Fail
+kms_writeback@writeback-check-output-XRGB2101010,Fail
+kms_writeback@writeback-fb-id,Fail
+kms_writeback@writeback-fb-id-XRGB2101010,Fail
+kms_writeback@writeback-invalid-parameters,Fail
+kms_writeback@writeback-pixel-formats,Fail
+perf@i915-ref-count,Fail
diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt
new file mode 100644
index 000000000000..62428f3c8f31
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-flakes.txt
@@ -0,0 +1,90 @@
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_cursor_legacy@long-nonblocking-modeset-vs-cursor-atomic
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@basic-flip-vs-wf_vblank
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@flip-vs-expired-vblank-interruptible
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@flip-vs-wf_vblank-interruptible
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@plain-flip-fb-recreate-interruptible
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@plain-flip-ts-check
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@plain-flip-ts-check-interruptible
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@flip-vs-absolute-wf_vblank
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@flip-vs-absolute-wf_vblank-interruptible
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-g0df7b9b97
+# Linux Version: 6.9.0-rc7
+kms_flip@flip-vs-blocking-wf-vblank
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-gf13702b8e
+# Linux Version: 6.10.0-rc5
+kms_cursor_legacy@flip-vs-cursor-varying-size
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-gf13702b8e
+# Linux Version: 6.10.0-rc5
+kms_flip@flip-vs-expired-vblank
+
+# Board Name: vkms
+# Bug Report: https://lore.kernel.org/dri-devel/61ed26af-062c-443c-9df2-d1ee319f3fb0@collabora.com/T/#u
+# Failure Rate: 50
+# IGT Version: 1.28-gf13702b8e
+# Linux Version: 6.10.0-rc5
+kms_pipe_crc_basic@nonblocking-crc-frame-sequence
diff --git a/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt
new file mode 100644
index 000000000000..24659c18c765
--- /dev/null
+++ b/tools/ci/gitlab-ci/scenarios/drm/xfails/vkms-none-skips.txt
@@ -0,0 +1,812 @@
+# skip suspend tests
+.*suspend.*
+
+# keeps printing vkms_vblank_simulate: vblank timer overrun and never ends
+kms_invalid_mode@int-max-clock
+
+# kernel panic seen with kms_cursor_crc tests
+kms_cursor_crc.*
+# kms_cursor_crc@cursor-rapid-movement-32x10
+# Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 0 PID: 2635 Comm: kworker/u8:13 Not tainted 6.9.0-rc7-g40935263a1fd #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
+# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
+# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246
+# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
+# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8
+# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700
+# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000078 CR3: 000000010bd30000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x490
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1c7/0x4e0 [vkms]
+#  ? compose_active_planes+0x2a3/0x4e0 [vkms]
+#  ? srso_return_thunk+0x5/0x5f
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x1f4/0x6b0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x350
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 0000000000000078
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
+# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
+# RSP: 0018:ffffbb4700c17d58 EFLAGS: 00010246
+# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
+# RDX: 0000000000000000 RSI: ffffa2ad0788c000 RDI: 00000000fff479a8
+# RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffffa2ad0bb14000 R11: 0000000000000000 R12: ffffa2ad03e21700
+# R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffffa2ad2bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+
+#kms_cursor_crc@cursor-rapid-movement-256x85
+# [drm:drm_crtc_add_crc_entry] *ERROR* Overflow of CRC buffer, userspace reads too slow.
+# Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 PID: 10 Comm: kworker/u8:0 Not tainted 6.9.0-rc7-g646381cde463 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
+# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
+# RSP: 0018:ffffa7e980057d58 EFLAGS: 00010246
+# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
+# RDX: 0000000000000000 RSI: ffff977987aa5c00 RDI: 000000001b43a85f
+# RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff977981bf0000 R11: 0000000000000000 R12: ffff977989622590
+# R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffff9779abd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000078 CR3: 0000000109b38000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x490
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1c7/0x4e0 [vkms]
+#  ? compose_active_planes+0x2a3/0x4e0 [vkms]
+#  ? srso_return_thunk+0x5/0x5f
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x1f4/0x6b0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x350
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 0000000000000078
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1c7/0x4e0 [vkms]
+# Code: c9 0f 84 6a 01 00 00 8b 42 30 2b 42 28 41 39 c5 0f 8c 6f 01 00 00 49 83 c7 01 49 39 df 74 3b 4b 8b 34 fc 48 8b 96 48 01 00 00 <8b> 42 78 89 c1 83 e1 0a a8 20 74 b1 45 89 f5 41 f7 d5 44 03 6a 34
+# RSP: 0018:ffffa7e980057d58 EFLAGS: 00010246
+# RAX: 0000000000000400 RBX: 0000000000000002 RCX: 0000000000000002
+# RDX: 0000000000000000 RSI: ffff977987aa5c00 RDI: 000000001b43a85f
+# RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff977981bf0000 R11: 0000000000000000 R12: ffff977989622590
+# R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffff9779abd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000078 CR3: 0000000109b38000 CR4: 0000000000350ef0
+
+#kms_cursor_crc@cursor-onscreen-256x256
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 PID: 1913 Comm: kworker/u8:6 Not tainted 6.10.0-rc5-g8a28e73ebead #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffb477409fbd58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff8b124a242000
+# RDX: 00000000000000ff RSI: ffff8b124a243ff8 RDI: ffff8b124a244000
+# RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000003ff
+# R10: ffff8b124a244000 R11: 0000000000000000 R12: ffff8b1249282f30
+# R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffff8b126bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000018 CR3: 0000000107a86000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x344/0x4e0 [vkms]
+#  ? compose_active_planes+0x32f/0x4e0 [vkms]
+#  ? srso_return_thunk+0x5/0x5f
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x350
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 0000000000000018
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffb477409fbd58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff8b124a242000
+# RDX: 00000000000000ff RSI: ffff8b124a243ff8 RDI: ffff8b124a244000
+# RBP: 0000000000000002 R08: 0000000000000000 R09: 00000000000003ff
+# R10: ffff8b124a244000 R11: 0000000000000000 R12: ffff8b1249282f30
+# R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffff8b126bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000018 CR3: 0000000107a86000 CR4: 0000000000350ef0
+
+kms_cursor_edge_walk@128x128-right-edge
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 0 PID: 1911 Comm: kworker/u8:3 Not tainted 6.10.0-rc5-g5e7a002eefe5 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffb2f040a43d58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa2c181792000
+# RDX: 0000000000000000 RSI: ffffa2c181793ff8 RDI: ffffa2c181790000
+# RBP: 0000000000000031 R08: 0000000000000000 R09: 00000000000003ff
+# R10: ffffa2c181790000 R11: 0000000000000000 R12: ffffa2c1814fa810
+# R13: 0000000000000031 R14: 0000000000000031 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffffa2c1abc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000018 CR3: 0000000106768000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? srso_return_thunk+0x5/0x5f
+#  ? mark_held_locks+0x49/0x80
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x344/0x4e0 [vkms]
+#  ? compose_active_planes+0x32f/0x4e0 [vkms]
+#  ? srso_return_thunk+0x5/0x5f
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x350
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 0000000000000018
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffb2f040a43d58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa2c181792000
+# RDX: 0000000000000000 RSI: ffffa2c181793ff8 RDI: ffffa2c181790000
+# RBP: 0000000000000031 R08: 0000000000000000 R09: 00000000000003ff
+# R10: ffffa2c181790000 R11: 0000000000000000 R12: ffffa2c1814fa810
+# R13: 0000000000000031 R14: 0000000000000031 R15: 000000000000
+
+kms_cursor_edge_walk@128x128-left-edge
+# DEBUG - Begin test kms_cursor_edge_walk@128x128-left-edge
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 0 UID: 0 PID: 27 Comm: kworker/u8:1 Not tainted 6.11.0-rc5-g5d3429a7e9aa #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffa437800ebd58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa0e841904000
+# RDX: 00000000000000ff RSI: ffffa0e841905ff8 RDI: ffffa0e841902000
+# RBP: 0000000000000000 R08: ffffa0e84158a600 R09: 00000000000003ff
+# R10: 0000000078b2bcd2 R11: 00000000278b2bcd R12: ffffa0e84870fc60
+# R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffffa0e86bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000018 CR3: 0000000101710000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x344/0x4e0 [vkms]
+#  ? compose_active_planes+0x32f/0x4e0 [vkms]
+#  ? srso_return_thunk+0x5/0x5f
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x310
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 0000000000000018
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x344/0x4e0 [vkms]
+# Code: 6a 34 0f 8e 91 fe ff ff 44 89 ea 48 8d 7c 24 48 e8 71 f0 ff ff 4b 8b 04 fc 48 8b 4c 24 50 48 8b 7c 24 40 48 8b 80 48 01 00 00 <48> 63 70 18 8b 40 20 48 89 f2 48 c1 e6 03 29 d0 48 8b 54 24 48 48
+# RSP: 0018:ffffa437800ebd58 EFLAGS: 00010282
+# RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffa0e841904000
+# RDX: 00000000000000ff RSI: ffffa0e841905ff8 RDI: ffffa0e841902000
+# RBP: 0000000000000000 R08: ffffa0e84158a600 R09: 00000000000003ff
+# R10: 0000000078b2bcd2 R11: 00000000278b2bcd R12: ffffa0e84870fc60
+# R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
+# FS:  0000000000000000(0000) GS:ffffa0e86bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 0000000000000018 CR3: 0000000101710000 CR4: 0000000000350ef0
+# vkms_vblank_simulate: vblank timer overrun
+
+# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-64x64
+# ------------[ cut here ]------------
+# WARNING: CPU: 1 PID: 1250 at drivers/gpu/drm/vkms/vkms_crtc.c:139 vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Modules linked in: vkms
+# CPU: 1 UID: 0 PID: 1250 Comm: kms_cursor_crc Not tainted 6.13.0-rc2-ge95c88d68ac3 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Code: f7 48 89 f3 e8 d0 bf ee ec 48 8b 83 50 01 00 00 a8 01 75 15 48 8b bb a0 01 00 00 e8 59 05 95 ec 48 89 df 5b e9 50 05 95 ec 90 <0f> 0b 90 eb e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
+# RSP: 0018:ffff9fb640aafb08 EFLAGS: 00010202
+# RAX: ffff8e7240859e05 RBX: ffff8e7241cd6400 RCX: ffffffffae496b65
+# RDX: ffffffffad2d1f80 RSI: 0000000000000000 RDI: 0000000000000000
+# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002
+# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff8e72590cc000
+# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
+# FS:  00007f0942ad56c0(0000) GS:ffff8e726bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 00007f0942ad0008 CR3: 0000000118d1e000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __warn+0x8c/0x190
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? report_bug+0x164/0x190
+#  ? handle_bug+0x54/0x90
+#  ? exc_invalid_op+0x17/0x70
+#  ? asm_exc_invalid_op+0x1a/0x20
+#  ? __pfx_drm_property_free_blob+0x10/0x10
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
+#  drm_atomic_state_default_clear+0x137/0x2f0
+#  __drm_atomic_state_free+0x6c/0xb0
+#  drm_atomic_helper_update_plane+0x100/0x150
+#  drm_mode_cursor_universal+0x10e/0x270
+#  drm_mode_cursor_common+0x115/0x240
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  drm_mode_cursor_ioctl+0x4a/0x70
+#  drm_ioctl_kernel+0xb0/0x110
+#  drm_ioctl+0x235/0x4b0
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  __x64_sys_ioctl+0x92/0xc0
+#  do_syscall_64+0xbb/0x1d0
+#  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+# RIP: 0033:0x7f0943a84cdb
+# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
+# RSP: 002b:00007fff267d68d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
+# RAX: ffffffffffffffda RBX: 000000000000005a RCX: 00007f0943a84cdb
+# RDX: 00007fff267d6960 RSI: 00000000c01c64a3 RDI: 0000000000000005
+# RBP: 00007fff267d6960 R08: 0000000000000007 R09: 00005619a60f3450
+# R10: fe95a83851609dee R11: 0000000000000246 R12: 00000000c01c64a3
+# R13: 0000000000000005 R14: 00005619a3cd2c68 R15: 00005619a608c830
+#  </TASK>
+# irq event stamp: 57793
+# hardirqs last  enabled at (57799): [<ffffffffacba3e4d>] __up_console_sem+0x4d/0x60
+# hardirqs last disabled at (57804): [<ffffffffacba3e32>] __up_console_sem+0x32/0x60
+# softirqs last  enabled at (45586): [<ffffffffacb17980>] handle_softirqs+0x310/0x3f0
+# softirqs last disabled at (45569): [<ffffffffacb17bc1>] __irq_exit_rcu+0xa1/0xc0
+# ---[ end trace 0000000000000000 ]---
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 0 UID: 0 PID: 119 Comm: kworker/u8:6 Tainted: G        W          6.13.0-rc2-ge95c88d68ac3 #1
+# Tainted: [W]=WARN
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffff9fb640efbd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff8e7241926000 RSI: ffff8e7241927ffc RDI: 000000000b7fb767
+# RBP: ffff9fb640efbde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff8e7241b09a80 R11: 0000000000000000 R12: ffff8e7241cd6200
+# R13: 0000000000000013 R14: 0000000000000000 R15: ffff8e7241b09a80
+# FS:  0000000000000000(0000) GS:ffff8e726bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000118d1e000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? srso_return_thunk+0x5/0x5f
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1a3/0x760 [vkms]
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x320
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 000000000000001c
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffff9fb640efbd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff8e7241926000 RSI: ffff8e7241927ffc RDI: 000000000b7fb767
+# RBP: ffff9fb640efbde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff8e7241b09a80 R11: 0000000000000000 R12: ffff8e7241cd6200
+# R13: 0000000000000013 R14: 0000000000000000 R15: ffff8e7241b09a80
+# FS:  0000000000000000(0000) GS:ffff8e726bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000118d1e000 CR4: 0000000000350ef0
+
+# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-128x42
+# ------------[ cut here ]------------
+# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Modules linked in: vkms
+# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2-g5219242748c8 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 48 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90 <0f> 0b 90 eb e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
+# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202
+# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65
+# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000
+# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002
+# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000
+# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
+# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __warn+0x8c/0x190
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? report_bug+0x164/0x190
+#  ? handle_bug+0x54/0x90
+#  ? exc_invalid_op+0x17/0x70
+#  ? asm_exc_invalid_op+0x1a/0x20
+#  ? __pfx_drm_property_free_blob+0x10/0x10
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
+#  drm_atomic_state_default_clear+0x137/0x2f0
+#  __drm_atomic_state_free+0x6c/0xb0
+#  drm_atomic_helper_update_plane+0x100/0x150
+#  drm_mode_cursor_universal+0x10e/0x270
+#  drm_mode_cursor_common+0x115/0x240
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  drm_mode_cursor_ioctl+0x4a/0x70
+#  drm_ioctl_kernel+0xb0/0x110
+#  drm_ioctl+0x235/0x4b0
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  __x64_sys_ioctl+0x92/0xc0
+#  do_syscall_64+0xbb/0x1d0
+#  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+# RIP: 0033:0x7f4f44960c5b
+# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
+# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
+# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b
+# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005
+# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30
+# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3
+# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0
+#  </TASK>
+# irq event stamp: 58747
+# hardirqs last  enabled at (58753): [<ffffffff903a3e4d>] __up_console_sem+0x4d/0x60
+# hardirqs last disabled at (58758): [<ffffffff903a3e32>] __up_console_sem+0x32/0x60
+# softirqs last  enabled at (47324): [<ffffffff90317980>] handle_softirqs+0x310/0x3f0
+# softirqs last disabled at (47307): [<ffffffff90317bc1>] __irq_exit_rcu+0xa1/0xc0
+# ---[ end trace 0000000000000000 ]---
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W          6.13.0-rc2-g5219242748c8 #1
+# Tainted: [W]=WARN
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? __kvmalloc_node_noprof+0x3e/0xc0
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1a3/0x760 [vkms]
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x320
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 000000000000001c
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+
+# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-32x32
+# ------------[ cut here ]------------
+# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Modules linked in: vkms
+# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2-g5219242748c8 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 48 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90 <0f> 0b 90 eb e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
+# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202
+# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65
+# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000
+# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002
+# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000
+# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
+# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __warn+0x8c/0x190
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? report_bug+0x164/0x190
+#  ? handle_bug+0x54/0x90
+#  ? exc_invalid_op+0x17/0x70
+#  ? asm_exc_invalid_op+0x1a/0x20
+#  ? __pfx_drm_property_free_blob+0x10/0x10
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
+#  drm_atomic_state_default_clear+0x137/0x2f0
+#  __drm_atomic_state_free+0x6c/0xb0
+#  drm_atomic_helper_update_plane+0x100/0x150
+#  drm_mode_cursor_universal+0x10e/0x270
+#  drm_mode_cursor_common+0x115/0x240
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  drm_mode_cursor_ioctl+0x4a/0x70
+#  drm_ioctl_kernel+0xb0/0x110
+#  drm_ioctl+0x235/0x4b0
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  __x64_sys_ioctl+0x92/0xc0
+#  do_syscall_64+0xbb/0x1d0
+#  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+# RIP: 0033:0x7f4f44960c5b
+# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
+# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
+# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b
+# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005
+# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30
+# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3
+# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0
+#  </TASK>
+# irq event stamp: 58747
+# hardirqs last  enabled at (58753): [<ffffffff903a3e4d>] __up_console_sem+0x4d/0x60
+# hardirqs last disabled at (58758): [<ffffffff903a3e32>] __up_console_sem+0x32/0x60
+# softirqs last  enabled at (47324): [<ffffffff90317980>] handle_softirqs+0x310/0x3f0
+# softirqs last disabled at (47307): [<ffffffff90317bc1>] __irq_exit_rcu+0xa1/0xc0
+# ---[ end trace 0000000000000000 ]---
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W          6.13.0-rc2-g5219242748c8 #1
+# Tainted: [W]=WARN
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? __kvmalloc_node_noprof+0x3e/0xc0
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1a3/0x760 [vkms]
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x320
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 000000000000001c
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+
+# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-32x32
+# ------------[ cut here ]------------
+# WARNING: CPU: 0 PID: 2933 at drivers/gpu/drm/vkms/vkms_crtc.c:139 vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Modules linked in: vkms
+# CPU: 0 UID: 0 PID: 2933 Comm: kms_cursor_crc Not tainted 6.13.0-rc2-g5219242748c8 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Code: f7 48 89 f3 e8 d0 bf 6e d0 48 8b 83 50 01 00 00 a8 01 75 15 48 8b bb a0 01 00 00 e8 59 05 15 d0 48 89 df 5b e9 50 05 15 d0 90 <0f> 0b 90 eb e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
+# RSP: 0018:ffffa14cc08b3b08 EFLAGS: 00010202
+# RAX: ffff9b864084b605 RBX: ffff9b8641ba4600 RCX: ffffffff91c96b65
+# RDX: ffffffff90ad1f80 RSI: 0000000000000000 RDI: 0000000000000000
+# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002
+# R10: 0000000047dd15a5 R11: 00000000547dd15a R12: ffff9b864099c000
+# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
+# FS:  00007f4f437ab6c0(0000) GS:ffff9b866bc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 00007f4f44c3cd40 CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __warn+0x8c/0x190
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? report_bug+0x164/0x190
+#  ? handle_bug+0x54/0x90
+#  ? exc_invalid_op+0x17/0x70
+#  ? asm_exc_invalid_op+0x1a/0x20
+#  ? __pfx_drm_property_free_blob+0x10/0x10
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
+#  drm_atomic_state_default_clear+0x137/0x2f0
+#  __drm_atomic_state_free+0x6c/0xb0
+#  drm_atomic_helper_update_plane+0x100/0x150
+#  drm_mode_cursor_universal+0x10e/0x270
+#  drm_mode_cursor_common+0x115/0x240
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  drm_mode_cursor_ioctl+0x4a/0x70
+#  drm_ioctl_kernel+0xb0/0x110
+#  drm_ioctl+0x235/0x4b0
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  __x64_sys_ioctl+0x92/0xc0
+#  do_syscall_64+0xbb/0x1d0
+#  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+# RIP: 0033:0x7f4f44960c5b
+# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
+# RSP: 002b:00007ffcdfb0b560 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
+# RAX: ffffffffffffffda RBX: 0000000000000060 RCX: 00007f4f44960c5b
+# RDX: 00007ffcdfb0b5f0 RSI: 00000000c01c64a3 RDI: 0000000000000005
+# RBP: 00007ffcdfb0b5f0 R08: 0000000000000007 R09: 000055c3a5801a30
+# R10: 3107764f00e1f281 R11: 0000000000000246 R12: 00000000c01c64a3
+# R13: 0000000000000005 R14: 000055c38b7e42c8 R15: 000055c3a579aab0
+#  </TASK>
+# irq event stamp: 58747
+# hardirqs last  enabled at (58753): [<ffffffff903a3e4d>] __up_console_sem+0x4d/0x60
+# hardirqs last disabled at (58758): [<ffffffff903a3e32>] __up_console_sem+0x32/0x60
+# softirqs last  enabled at (47324): [<ffffffff90317980>] handle_softirqs+0x310/0x3f0
+# softirqs last disabled at (47307): [<ffffffff90317bc1>] __irq_exit_rcu+0xa1/0xc0
+# ---[ end trace 0000000000000000 ]---
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Tainted: G        W          6.13.0-rc2-g5219242748c8 #1
+# Tainted: [W]=WARN
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? __kvmalloc_node_noprof+0x3e/0xc0
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1a3/0x760 [vkms]
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x320
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 000000000000001c
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa14cc005fd20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff9b8669626000 RSI: ffff9b8669627ffc RDI: 00000000348d6c39
+# RBP: ffffa14cc005fde0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff9b8645650eb0 R11: 0000000000000000 R12: ffff9b8641ba5800
+# R13: 0000000000000028 R14: 0000000000000000 R15: ffff9b8645650eb0
+# FS:  0000000000000000(0000) GS:ffff9b866bd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000108c14000 CR4: 0000000000350ef0
+
+# DEBUG - Begin test kms_cursor_crc@cursor-rapid-movement-128x128
+# ------------[ cut here ]------------
+# WARNING: CPU: 0 PID: 2898 at drivers/gpu/drm/vkms/vkms_crtc.c:139 vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Modules linked in: vkms
+# CPU: 0 UID: 0 PID: 2898 Comm: kms_cursor_crc Not tainted 6.13.0-rc2-g1f006005ebf8 #1
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# RIP: 0010:vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+# Code: f7 48 89 f3 e8 d0 bf 6e e1 48 8b 83 50 01 00 00 a8 01 75 15 48 8b bb a0 01 00 00 e8 59 05 15 e1 48 89 df 5b e9 50 05 15 e1 90 <0f> 0b 90 eb e5 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
+# RSP: 0018:ffffa35c4082fb08 EFLAGS: 00010202
+# RAX: ffff8b02c1c0f005 RBX: ffff8b02d4509600 RCX: ffffffffa2c96b65
+# RDX: ffffffffa1ad1f80 RSI: 0000000000000000 RDI: 0000000000000000
+# RBP: 0000000000000000 R08: 0000000000000034 R09: 0000000000000002
+# R10: 0000000030f11ddf R11: 00000000f30f11dd R12: ffff8b02d2528000
+# R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
+# FS:  00007f4b071ab6c0(0000) GS:ffff8b02efc00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000055f7f8384b48 CR3: 0000000104ef0000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __warn+0x8c/0x190
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? report_bug+0x164/0x190
+#  ? handle_bug+0x54/0x90
+#  ? exc_invalid_op+0x17/0x70
+#  ? asm_exc_invalid_op+0x1a/0x20
+#  ? __pfx_drm_property_free_blob+0x10/0x10
+#  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
+#  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
+#  drm_atomic_state_default_clear+0x137/0x2f0
+#  __drm_atomic_state_free+0x6c/0xb0
+#  drm_atomic_helper_update_plane+0x100/0x150
+#  drm_mode_cursor_universal+0x10e/0x270
+#  drm_mode_cursor_common+0x115/0x240
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  drm_mode_cursor_ioctl+0x4a/0x70
+#  drm_ioctl_kernel+0xb0/0x110
+#  drm_ioctl+0x235/0x4b0
+#  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
+#  __x64_sys_ioctl+0x92/0xc0
+#  do_syscall_64+0xbb/0x1d0
+#  entry_SYSCALL_64_after_hwframe+0x77/0x7f
+# RIP: 0033:0x7f4b0815ac5b
+# Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
+# RSP: 002b:00007ffd726f75e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
+# RAX: ffffffffffffffda RBX: 000000000000005d RCX: 00007f4b0815ac5b
+# RDX: 00007ffd726f7670 RSI: 00000000c01c64a3 RDI: 0000000000000005
+# RBP: 00007ffd726f7670 R08: 0000000000000007 R09: 000055f7f83e30c0
+# R10: 2b16893c03bd381a R11: 0000000000000246 R12: 00000000c01c64a3
+# R13: 0000000000000005 R14: 000055f7dbee72c8 R15: 000055f7f837bab0
+#  </TASK>
+# irq event stamp: 58921
+# hardirqs last  enabled at (58927): [<ffffffffa13a3e4d>] __up_console_sem+0x4d/0x60
+# hardirqs last disabled at (58932): [<ffffffffa13a3e32>] __up_console_sem+0x32/0x60
+# softirqs last  enabled at (46140): [<ffffffffa1317980>] handle_softirqs+0x310/0x3f0
+# softirqs last disabled at (46135): [<ffffffffa1317bc1>] __irq_exit_rcu+0xa1/0xc0
+# ---[ end trace 0000000000000000 ]---
+# Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
+# CPU: 1 UID: 0 PID: 1657 Comm: kworker/u8:14 Tainted: G        W          6.13.0-rc2-g1f006005ebf8 #1
+# Tainted: [W]=WARN
+# Hardware name: ChromiumOS crosvm, BIOS 0
+# Workqueue: vkms_composer vkms_composer_worker [vkms]
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa35c40c43d20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff8b02c52c8000 RSI: ffff8b02c52c9ffc RDI: 00000000fa4761c9
+# RBP: ffffa35c40c43de0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff8b02c1c87840 R11: 0000000000000000 R12: ffff8b02d4508800
+# R13: 0000000000000021 R14: 0000000000000000 R15: ffff8b02c1c87840
+# FS:  0000000000000000(0000) GS:ffff8b02efd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+# CR2: 000000000000001c CR3: 0000000104ef0000 CR4: 0000000000350ef0
+# Call Trace:
+#  <TASK>
+#  ? __die+0x1e/0x60
+#  ? page_fault_oops+0x17b/0x4a0
+#  ? srso_return_thunk+0x5/0x5f
+#  ? exc_page_fault+0x6d/0x230
+#  ? asm_exc_page_fault+0x26/0x30
+#  ? compose_active_planes+0x1a3/0x760 [vkms]
+#  vkms_composer_worker+0x205/0x240 [vkms]
+#  process_one_work+0x201/0x6c0
+#  ? lock_is_held_type+0x9e/0x110
+#  worker_thread+0x17e/0x320
+#  ? __pfx_worker_thread+0x10/0x10
+#  kthread+0xce/0x100
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork+0x2f/0x50
+#  ? __pfx_kthread+0x10/0x10
+#  ret_from_fork_asm+0x1a/0x30
+#  </TASK>
+# Modules linked in: vkms
+# CR2: 000000000000001c
+# ---[ end trace 0000000000000000 ]---
+# RIP: 0010:compose_active_planes+0x1a3/0x760 [vkms]
+# Code: db 4d 89 fa 85 c9 0f 84 32 03 00 00 4d 8b 24 da 48 c7 44 24 60 00 00 00 00 48 c7 44 24 68 00 00 00 00 49 8b 84 24 48 01 00 00 <8b> 50 1c 44 39 ea 0f 8f f3 02 00 00 44 39 68 24 0f 8e e9 02 00 00
+# RSP: 0018:ffffa35c40c43d20 EFLAGS: 00010202
+# RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
+# RDX: ffff8b02c52c8000 RSI: ffff8b02c52c9ffc RDI: 00000000fa4761c9
+# RBP: ffffa35c40c43de0 R08: 0000000000000000 R09: 0000000000000000
+# R10: ffff8b02c1c87840 R11: 0000000000000000 R12: ffff8b02d4508800
+# R13: 0000000000000021 R14: 0000000000000000 R15: ffff8b02c1c87840
+# FS:  0000000000000000(0000) GS:ffff8b02efd00000(0000) knlGS:0000000000000000
+# CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+
+# Skip driver specific tests
+^amdgpu.*
+^msm.*
+nouveau_.*
+^panfrost.*
+^v3d.*
+^vc4.*
+^vmwgfx*
+
+# Skip intel specific tests
+gem_.*
+i915_.*
+xe_.*
+tools_test.*
+
+# IGT issue. is_joiner_mode() should return false for non-Intel hardware.
+# https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/162
+kms_display_modes@extended-mode-basic
+kms_display_modes@mst-extended-mode-negative
-- 
2.43.0


