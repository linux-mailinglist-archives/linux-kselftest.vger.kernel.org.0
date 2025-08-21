Return-Path: <linux-kselftest+bounces-39509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C485CB2FCB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88A294E21F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E30239E6F;
	Thu, 21 Aug 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoWVb4Q7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669E223DC6;
	Thu, 21 Aug 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786611; cv=none; b=EYqLdqK15+PnNy2RY8iZig1MUnGcMgzWvs73n8Vh+9T0eS4Em3abEi7Af27YSZHRNwvV8n1U6TfDNznALCa1aRz6l0uGqBVQ+mMAbQNd/ccZmDL4VXn6lCglDoYm6ekVDWU8MyV8WfA537yBo9WFHrKe7FKdFeFMBucQTlJelwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786611; c=relaxed/simple;
	bh=171YN9oS89feifoGx1r0j0QafdKTNjIdfxZtZtvAWKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rnru+QxbsFwZZ5nNr0cTJsnUdZXxMSmNwWtIsegH0hbZCOpFTOIg1BtHH2lPT3E8t/lEEvPJcA1b3fQOgWzz8uqTrTGLb0roMyoFbZReo6+i4NNVf1dSuGXraRs38JJ1mD6rz+XSl4uZoLanbHpn97ZeqmXWu+fR0wOFMj1dWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoWVb4Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E9FC4CEEB;
	Thu, 21 Aug 2025 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786609;
	bh=171YN9oS89feifoGx1r0j0QafdKTNjIdfxZtZtvAWKk=;
	h=From:Date:Subject:To:Cc:From;
	b=KoWVb4Q7efd4vcYZzzqohUYkceBmDC1X50LylOiB8UYn+cvuxzaRPfZpG6gPkvgNk
	 ZSJyt3SmdHGst5XVkXLY4zG02aRJXANpeXu/1Ayjd93kR8rjXRkFayZO1Uf1NaP288
	 r0kwE9UbpG34jvLLesFo+E6CyaHYp/OgHcaCgQLysZcQyeNB/rfh5zKq+my2TqDtT0
	 ZrVVDBrJKv7QwDEQ+0VpnKn5CuPNLaq9h0J+eGxtnVkSpRfnqMDKNI4CQjiPBaBfki
	 JI7iKyNKojtfeBtI87DxJtwxo9Hv8KwbVX8MstT6fspg6w8hb9t7ZoiAG/WIxMC/12
	 SUCmXPyC9BmRA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 21 Aug 2025 16:29:55 +0200
Subject: [PATCH] selftests/hid: update vmtest.sh for virtme-ng
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-virtme-ng-v1-1-0e6359872bf3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGItp2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ML3bLMopLcVN28dN00c+OUJPNUM0MjY1MloPqCotS0zAqwWdGxtbU
 AhuhWeFsAAAA=
X-Change-ID: 20250818-virtme-ng-f73db7e61235
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755786608; l=20560;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=171YN9oS89feifoGx1r0j0QafdKTNjIdfxZtZtvAWKk=;
 b=a6+jALH0FilOQ/3n3VM739eO6H+1gZpUjnL4bgLk0+0EMzmrynt0Jj3wdACdkuT6gD8/B0X90
 P9Px+FnChYHAqGkWYiePgpsVPo74WK5V3uCkYOVkjfv1DzivUxsuCiJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This commit is a rewrite almost from scratch of vmtest.sh.

By relying on virtme-ng, we get rid of boot2container, reducing the
total bootup time (and network requirements). That means that we are
relying on the programs being installed on the host, but that shouldn't
be an issue. The generation of the kconfig is also now handled by
virtme-ng, so that's one less thing to worry.

I used tools/testing/selftests/vsock/vmtest.sh as a base and modified it
to look mostly like my previous script:
- removed the custom ssh handling
- make use of vng for compiling, which allows to bring remote
  compilation (and potentially remote compilation on a remote container)
- change the verbosity logic by having 2 levels:
  - first one shows the tests outputs
  - second level also shows the VM logs
- instead of only running the compiled kernel when it is built, if we
  are in the kernel tree, use the kernel artifacts there (and complain
  if they are not built)
- adapted the tests list to match the HID subsystem tests

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
I have switched my workflow to make use of virtme-ng for a few months.
Now it's time to automate the manual commands I've been running in
vmtest.sh.
---
 tools/testing/selftests/hid/vmtest.sh | 668 +++++++++++++++++++++-------------
 1 file changed, 423 insertions(+), 245 deletions(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index db534e9099a8a4684346eed0067d397ffa6f80cf..ecbd57f775a044b4d076b4800ca0068f9533056c 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -1,296 +1,474 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Red Hat
+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
+#
+# Dependencies:
+#		* virtme-ng
+#		* busybox-static (used by virtme-ng)
+#		* qemu	(used by virtme-ng)
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
+
+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
+
+readonly HID_BPF_TEST="${SCRIPT_DIR}"/hid_bpf
+readonly HIDRAW_TEST="${SCRIPT_DIR}"/hidraw
+readonly HID_BPF_PROGS="${KERNEL_CHECKOUT}/drivers/hid/bpf/progs"
+readonly SSH_GUEST_PORT=22
+readonly WAIT_PERIOD=3
+readonly WAIT_PERIOD_MAX=60
+readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_hid_vmtest_XXXX.pid)
+
+readonly QEMU_OPTS="\
+	 --pidfile ${QEMU_PIDFILE} \
+"
+readonly KERNEL_CMDLINE=""
+readonly LOG=$(mktemp /tmp/hid_vmtest_XXXX.log)
+readonly TEST_NAMES=(vm_hid_bpf vm_hidraw vm_pytest)
+readonly TEST_DESCS=(
+	"Run hid_bpf tests in the VM."
+	"Run hidraw tests in the VM."
+	"Run the hid-tools test-suite in the VM."
+)
+
+VERBOSE=0
+SHELL_MODE=0
+BUILD_HOST=""
+BUILD_HOST_PODMAN_CONTAINER_NAME=""
+
+usage() {
+	local name
+	local desc
+	local i
+
+	echo
+	echo "$0 [OPTIONS] [TEST]... [-- tests-args]"
+	echo "If no TEST argument is given, all tests will be run."
+	echo
+	echo "Options"
+	echo "  -b: build the kernel from the current source tree and use it for guest VMs"
+	echo "  -H: hostname for remote build host (used with -b)"
+	echo "  -p: podman container name for remote build host (used with -b)"
+	echo "      Example: -H beefyserver -p vng"
+	echo "  -q: set the path to or name of qemu binary"
+	echo "  -s: start a shell in the VM instead of running tests"
+	echo "  -v: more verbose output (can be repeated multiple times)"
+	echo
+	echo "Available tests"
+
+	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
+		name=${TEST_NAMES[${i}]}
+		desc=${TEST_DESCS[${i}]}
+		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+	done
+	echo
 
-set -u
-set -e
-
-# This script currently only works for x86_64
-ARCH="$(uname -m)"
-case "${ARCH}" in
-x86_64)
-	QEMU_BINARY=qemu-system-x86_64
-	BZIMAGE="arch/x86/boot/bzImage"
-	;;
-*)
-	echo "Unsupported architecture"
 	exit 1
-	;;
-esac
-SCRIPT_DIR="$(dirname $(realpath $0))"
-OUTPUT_DIR="$SCRIPT_DIR/results"
-KCONFIG_REL_PATHS=("${SCRIPT_DIR}/config" "${SCRIPT_DIR}/config.common" "${SCRIPT_DIR}/config.${ARCH}")
-B2C_URL="https://gitlab.freedesktop.org/gfx-ci/boot2container/-/raw/main/vm2c.py"
-NUM_COMPILE_JOBS="$(nproc)"
-LOG_FILE_BASE="$(date +"hid_selftests.%Y-%m-%d_%H-%M-%S")"
-LOG_FILE="${LOG_FILE_BASE}.log"
-EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
-CONTAINER_IMAGE="registry.freedesktop.org/bentiss/hid/fedora/39:2023-11-22.1"
-
-TARGETS="${TARGETS:=$(basename ${SCRIPT_DIR})}"
-DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"
-
-usage()
-{
-	cat <<EOF
-Usage: $0 [-j N] [-s] [-b] [-d <output_dir>] -- [<command>]
-
-<command> is the command you would normally run when you are in
-the source kernel direcory. e.g:
-
-	$0 -- ./tools/testing/selftests/hid/hid_bpf
-
-If no command is specified and a debug shell (-s) is not requested,
-"${DEFAULT_COMMAND}" will be run by default.
-
-If you build your kernel using KBUILD_OUTPUT= or O= options, these
-can be passed as environment variables to the script:
-
-  O=<kernel_build_path> $0 -- ./tools/testing/selftests/hid/hid_bpf
-
-or
-
-  KBUILD_OUTPUT=<kernel_build_path> $0 -- ./tools/testing/selftests/hid/hid_bpf
-
-Options:
-
-	-u)		Update the boot2container script to a newer version.
-	-d)		Update the output directory (default: ${OUTPUT_DIR})
-	-b)		Run only the build steps for the kernel and the selftests
-	-j)		Number of jobs for compilation, similar to -j in make
-			(default: ${NUM_COMPILE_JOBS})
-	-s)		Instead of powering off the VM, start an interactive
-			shell. If <command> is specified, the shell runs after
-			the command finishes executing
-EOF
 }
 
-download()
-{
-	local file="$1"
+die() {
+	echo "$*" >&2
+	exit "${KSFT_FAIL}"
+}
 
-	echo "Downloading $file..." >&2
-	curl -Lsf "$file" -o "${@:2}"
+vm_ssh() {
+	# vng --ssh-client keeps shouting "Warning: Permanently added 'virtme-ng%22'
+	# (ED25519) to the list of known hosts.",
+	# So replace the command with what's actually called and add the "-q" option
+	stdbuf -oL ssh -q \
+		       -F ${HOME}/.cache/virtme-ng/.ssh/virtme-ng-ssh.conf \
+		       -l root virtme-ng%${SSH_GUEST_PORT} \
+		       "$@"
+	return $?
 }
 
-recompile_kernel()
-{
-	local kernel_checkout="$1"
-	local make_command="$2"
+cleanup() {
+	if [[ -s "${QEMU_PIDFILE}" ]]; then
+		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
+	fi
 
-	cd "${kernel_checkout}"
+	# If failure occurred during or before qemu start up, then we need
+	# to clean this up ourselves.
+	if [[ -e "${QEMU_PIDFILE}" ]]; then
+		rm "${QEMU_PIDFILE}"
+	fi
+}
+
+check_args() {
+	local found
 
-	${make_command} olddefconfig
-	${make_command} headers
-	${make_command}
+	for arg in "$@"; do
+		found=0
+		for name in "${TEST_NAMES[@]}"; do
+			if [[ "${name}" = "${arg}" ]]; then
+				found=1
+				break
+			fi
+		done
+
+		if [[ "${found}" -eq 0 ]]; then
+			echo "${arg} is not an available test" >&2
+			usage
+		fi
+	done
+
+	for arg in "$@"; do
+		if ! command -v > /dev/null "test_${arg}"; then
+			echo "Test ${arg} not found" >&2
+			usage
+		fi
+	done
+}
+
+check_deps() {
+	for dep in vng ${QEMU} busybox pkill ssh pytest; do
+		if [[ ! -x $(command -v "${dep}") ]]; then
+			echo -e "skip:    dependency ${dep} not found!\n"
+			exit "${KSFT_SKIP}"
+		fi
+	done
+
+	if [[ ! -x $(command -v "${HID_BPF_TEST}") ]]; then
+		printf "skip:    %s not found!" "${HID_BPF_TEST}"
+		printf " Please build the kselftest hid_bpf target.\n"
+		exit "${KSFT_SKIP}"
+	fi
+
+	if [[ ! -x $(command -v "${HIDRAW_TEST}") ]]; then
+		printf "skip:    %s not found!" "${HIDRAW_TEST}"
+		printf " Please build the kselftest hidraw target.\n"
+		exit "${KSFT_SKIP}"
+	fi
 }
 
-update_selftests()
-{
-	local kernel_checkout="$1"
-	local selftests_dir="${kernel_checkout}/tools/testing/selftests/hid"
+check_vng() {
+	local tested_versions
+	local version
+	local ok
 
-	cd "${selftests_dir}"
-	${make_command}
+	tested_versions=("1.36" "1.37")
+	version="$(vng --version)"
+
+	ok=0
+	for tv in "${tested_versions[@]}"; do
+		if [[ "${version}" == *"${tv}"* ]]; then
+			ok=1
+			break
+		fi
+	done
+
+	if [[ ! "${ok}" -eq 1 ]]; then
+		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
+		printf "not function properly.\n\tThe following versions have been tested: " >&2
+		echo "${tested_versions[@]}" >&2
+	fi
 }
 
-run_vm()
-{
-	local run_dir="$1"
-	local b2c="$2"
-	local kernel_bzimage="$3"
-	local command="$4"
-	local post_command=""
-
-	cd "${run_dir}"
-
-	if ! which "${QEMU_BINARY}" &> /dev/null; then
-		cat <<EOF
-Could not find ${QEMU_BINARY}
-Please install qemu or set the QEMU_BINARY environment variable.
-EOF
+handle_build() {
+	if [[ ! "${BUILD}" -eq 1 ]]; then
+		return
+	fi
+
+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
+		echo "-b requires vmtest.sh called from the kernel source tree" >&2
 		exit 1
 	fi
 
-	# alpine (used in post-container requires the PATH to have /bin
-	export PATH=$PATH:/bin
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
 
-	if [[ "${debug_shell}" != "yes" ]]
-	then
-		touch ${OUTPUT_DIR}/${LOG_FILE}
-		command="mount bpffs -t bpf /sys/fs/bpf/; set -o pipefail ; ${command} 2>&1 | tee ${OUTPUT_DIR}/${LOG_FILE}"
-		post_command="cat ${OUTPUT_DIR}/${LOG_FILE}"
-	else
-		command="mount bpffs -t bpf /sys/fs/bpf/; ${command}"
+	if ! vng --kconfig --config "${SCRIPT_DIR}"/config; then
+		die "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
 	fi
 
-	set +e
-	$b2c --command "${command}" \
-	     --kernel ${kernel_bzimage} \
-	     --workdir ${OUTPUT_DIR} \
-	     --image ${CONTAINER_IMAGE}
+	local vng_args=("-v" "--config" "${SCRIPT_DIR}/config" "--build")
 
-	echo $? > ${OUTPUT_DIR}/${EXIT_STATUS_FILE}
+	if [[ -n "${BUILD_HOST}" ]]; then
+		vng_args+=("--build-host" "${BUILD_HOST}")
+	fi
 
-	set -e
+	if [[ -n "${BUILD_HOST_PODMAN_CONTAINER_NAME}" ]]; then
+		vng_args+=("--build-host-exec-prefix" \
+			   "podman exec -ti ${BUILD_HOST_PODMAN_CONTAINER_NAME}")
+	fi
 
-	${post_command}
-}
+	if ! vng "${vng_args[@]}"; then
+		die "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	fi
 
-is_rel_path()
-{
-	local path="$1"
+	if ! make -j$(nproc) -C "${HID_BPF_PROGS}"; then
+		die "failed to build HID bpf objects from source tree (${HID_BPF_PROGS})"
+	fi
 
-	[[ ${path:0:1} != "/" ]]
+	if ! make -j$(nproc) -C "${SCRIPT_DIR}"; then
+		die "failed to build HID selftests from source tree (${SCRIPT_DIR})"
+	fi
+
+	popd &>/dev/null
 }
 
-do_update_kconfig()
-{
-	local kernel_checkout="$1"
-	local kconfig_file="$2"
+vm_start() {
+	local logfile=/dev/null
+	local verbose_opt=""
+	local kernel_opt=""
+	local qemu
 
-	rm -f "$kconfig_file" 2> /dev/null
+	qemu=$(command -v "${QEMU}")
 
-	for config in "${KCONFIG_REL_PATHS[@]}"; do
-		local kconfig_src="${config}"
-		cat "$kconfig_src" >> "$kconfig_file"
-	done
-}
+	if [[ "${VERBOSE}" -eq 2 ]]; then
+		verbose_opt="--verbose"
+		logfile=/dev/stdout
+	fi
 
-update_kconfig()
-{
-	local kernel_checkout="$1"
-	local kconfig_file="$2"
-
-	if [[ -f "${kconfig_file}" ]]; then
-		local local_modified="$(stat -c %Y "${kconfig_file}")"
-
-		for config in "${KCONFIG_REL_PATHS[@]}"; do
-			local kconfig_src="${config}"
-			local src_modified="$(stat -c %Y "${kconfig_src}")"
-			# Only update the config if it has been updated after the
-			# previously cached config was created. This avoids
-			# unnecessarily compiling the kernel and selftests.
-			if [[ "${src_modified}" -gt "${local_modified}" ]]; then
-				do_update_kconfig "$kernel_checkout" "$kconfig_file"
-				# Once we have found one outdated configuration
-				# there is no need to check other ones.
-				break
-			fi
-		done
-	else
-		do_update_kconfig "$kernel_checkout" "$kconfig_file"
+	# If we are running from within the kernel source tree, use the kernel source tree
+	# as the kernel to boot, otherwise use the currently running kernel.
+	if [[ "$(realpath "$(pwd)")" == "${KERNEL_CHECKOUT}"* ]]; then
+		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
-}
 
-main()
-{
-	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
-	local kernel_checkout=$(realpath "${script_dir}"/../../../../)
-	# By default the script searches for the kernel in the checkout directory but
-	# it also obeys environment variables O= and KBUILD_OUTPUT=
-	local kernel_bzimage="${kernel_checkout}/${BZIMAGE}"
-	local command="${DEFAULT_COMMAND}"
-	local update_b2c="no"
-	local debug_shell="no"
-	local build_only="no"
-
-	while getopts ':hsud:j:b' opt; do
-		case ${opt} in
-		u)
-			update_b2c="yes"
-			;;
-		d)
-			OUTPUT_DIR="$OPTARG"
-			;;
-		j)
-			NUM_COMPILE_JOBS="$OPTARG"
-			;;
-		s)
-			command="/bin/sh"
-			debug_shell="yes"
-			;;
-		b)
-			build_only="yes"
-			;;
-		h)
-			usage
-			exit 0
-			;;
-		\? )
-			echo "Invalid Option: -$OPTARG"
-			usage
-			exit 1
-			;;
-		: )
-			echo "Invalid Option: -$OPTARG requires an argument"
-			usage
-			exit 1
-			;;
-		esac
-	done
-	shift $((OPTIND -1))
-
-	# trap 'catch "$?"' EXIT
-	if [[ "${build_only}" == "no" && "${debug_shell}" == "no" ]]; then
-		if [[ $# -eq 0 ]]; then
-			echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
-		else
-			command="$@"
-
-			if [[ "${command}" == "/bin/bash" || "${command}" == "bash" ]]
-			then
-				debug_shell="yes"
-			fi
+	vng \
+		--run \
+		${kernel_opt} \
+		${verbose_opt} \
+		--qemu-opts="${QEMU_OPTS}" \
+		--qemu="${qemu}" \
+		--user root \
+		--append "${KERNEL_CMDLINE}" \
+		--ssh "${SSH_GUEST_PORT}" \
+		--rw  &> ${logfile} &
+
+	local vng_pid=$!
+	local elapsed=0
+
+	while [[ ! -s "${QEMU_PIDFILE}" ]]; do
+		if ! kill -0 "${vng_pid}" 2>/dev/null; then
+			echo "vng process (PID ${vng_pid}) exited early, check logs for details" >&2
+			die "failed to boot VM"
 		fi
-	fi
 
-	local kconfig_file="${OUTPUT_DIR}/latest.config"
-	local make_command="make -j ${NUM_COMPILE_JOBS} KCONFIG_CONFIG=${kconfig_file}"
+		if [[ ${elapsed} -ge ${WAIT_TOTAL} ]]; then
+			echo "Timed out after ${WAIT_TOTAL} seconds waiting for VM to boot" >&2
+			die "failed to boot VM"
+		fi
 
-	# Figure out where the kernel is being built.
-	# O takes precedence over KBUILD_OUTPUT.
-	if [[ "${O:=""}" != "" ]]; then
-		if is_rel_path "${O}"; then
-			O="$(realpath "${PWD}/${O}")"
+		sleep 1
+		elapsed=$((elapsed + 1))
+	done
+}
+
+vm_wait_for_ssh() {
+	local i
+
+	i=0
+	while true; do
+		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
+			die "Timed out waiting for guest ssh"
 		fi
-		kernel_bzimage="${O}/${BZIMAGE}"
-		make_command="${make_command} O=${O}"
-	elif [[ "${KBUILD_OUTPUT:=""}" != "" ]]; then
-		if is_rel_path "${KBUILD_OUTPUT}"; then
-			KBUILD_OUTPUT="$(realpath "${PWD}/${KBUILD_OUTPUT}")"
+		if vm_ssh -- true; then
+			break
 		fi
-		kernel_bzimage="${KBUILD_OUTPUT}/${BZIMAGE}"
-		make_command="${make_command} KBUILD_OUTPUT=${KBUILD_OUTPUT}"
+		i=$(( i + 1 ))
+		sleep ${WAIT_PERIOD}
+	done
+}
+
+vm_mount_bpffs() {
+	vm_ssh -- mount bpffs -t bpf /sys/fs/bpf
+}
+
+__log_stdin() {
+	stdbuf -oL awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0; fflush() }'
+}
+
+__log_args() {
+	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
+}
+
+log() {
+	local verbose="$1"
+	shift
+
+	local prefix="$1"
+
+	shift
+	local redirect=
+	if [[ ${verbose} -le 0 ]]; then
+		redirect=/dev/null
+	else
+		redirect=/dev/stdout
+	fi
+
+	if [[ "$#" -eq 0 ]]; then
+		__log_stdin | tee -a "${LOG}" > ${redirect}
+	else
+		__log_args "$@" | tee -a "${LOG}" > ${redirect}
 	fi
+}
 
-	local b2c="${OUTPUT_DIR}/vm2c.py"
+log_setup() {
+	log $((VERBOSE-1)) "setup" "$@"
+}
 
-	echo "Output directory: ${OUTPUT_DIR}"
+log_host() {
+	local testname=$1
 
-	mkdir -p "${OUTPUT_DIR}"
-	update_kconfig "${kernel_checkout}" "${kconfig_file}"
+	shift
+	log $((VERBOSE-1)) "test:${testname}:host" "$@"
+}
 
-	recompile_kernel "${kernel_checkout}" "${make_command}"
-	update_selftests "${kernel_checkout}" "${make_command}"
+log_guest() {
+	local testname=$1
 
-	if [[ "${build_only}" == "no" ]]; then
-		if [[ "${update_b2c}" == "no" && ! -f "${b2c}" ]]; then
-			echo "vm2c script not found in ${b2c}"
-			update_b2c="yes"
-		fi
+	shift
+	log ${VERBOSE} "# test:${testname}" "$@"
+}
 
-		if [[ "${update_b2c}" == "yes" ]]; then
-			download $B2C_URL $b2c
-			chmod +x $b2c
-		fi
+test_vm_hid_bpf() {
+	local testname="${FUNCNAME[0]#test_}"
 
-		run_vm "${kernel_checkout}" $b2c "${kernel_bzimage}" "${command}"
-		if [[ "${debug_shell}" != "yes" ]]; then
-			echo "Logs saved in ${OUTPUT_DIR}/${LOG_FILE}"
-		fi
+	vm_ssh -- "${HID_BPF_TEST}" \
+		2>&1 | log_guest "${testname}"
+
+	return ${PIPESTATUS[0]}
+}
+
+test_vm_hidraw() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	vm_ssh -- "${HIDRAW_TEST}" \
+		2>&1 | log_guest "${testname}"
+
+	return ${PIPESTATUS[0]}
+}
+
+test_vm_pytest() {
+	local testname="${FUNCNAME[0]#test_}"
 
-		exit $(cat ${OUTPUT_DIR}/${EXIT_STATUS_FILE})
+	shift
+
+	vm_ssh -- pytest ${SCRIPT_DIR}/tests --color=yes "$@" \
+		2>&1 | log_guest "${testname}"
+
+	return ${PIPESTATUS[0]}
+}
+
+run_test() {
+	local vm_oops_cnt_before
+	local vm_warn_cnt_before
+	local vm_oops_cnt_after
+	local vm_warn_cnt_after
+	local name
+	local rc
+
+	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
+	vm_error_cnt_before=$(vm_ssh -- dmesg --level=err | wc -l)
+
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}" "$@"
+	rc=$?
+
+	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
+		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+		rc=$KSFT_FAIL
+	fi
+
+	vm_error_cnt_after=$(vm_ssh -- dmesg --level=err | wc -l)
+	if [[ ${vm_error_cnt_after} -gt ${vm_error_cnt_before} ]]; then
+		echo "FAIL: kernel error detected on vm" | log_host "${name}"
+		vm_ssh -- dmesg --level=err | log_host "${name}"
+		rc=$KSFT_FAIL
 	fi
+
+	return "${rc}"
 }
 
-main "$@"
+QEMU="qemu-system-$(uname -m)"
+
+while getopts :hvsbq:H:p: o
+do
+	case $o in
+	v) VERBOSE=$((VERBOSE+1));;
+	s) SHELL_MODE=1;;
+	b) BUILD=1;;
+	q) QEMU=$OPTARG;;
+	H) BUILD_HOST=$OPTARG;;
+	p) BUILD_HOST_PODMAN_CONTAINER_NAME=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+PARAMS=""
+
+if [[ ${#} -eq 0 ]]; then
+	ARGS=("${TEST_NAMES[@]}")
+else
+	ARGS=()
+	COUNT=0
+	for arg in $@; do
+		COUNT=$((COUNT+1))
+		if [[ x"$arg" == x"--" ]]; then
+			break
+		fi
+		ARGS+=($arg)
+	done
+	shift $COUNT
+	PARAMS="$@"
+fi
+
+if [[ "${SHELL_MODE}" -eq 0 ]]; then
+	check_args "${ARGS[@]}"
+	echo "1..${#ARGS[@]}"
+fi
+check_deps
+check_vng
+handle_build
+
+log_setup "Booting up VM"
+vm_start
+vm_wait_for_ssh
+vm_mount_bpffs
+log_setup "VM booted up"
+
+if [[ "${SHELL_MODE}" -eq 1 ]]; then
+	log_setup "Starting interactive shell in VM"
+	echo "Starting shell in VM. Use 'exit' to quit and shutdown the VM."
+	CURRENT_DIR="$(pwd)"
+	vm_ssh -t -- "cd '${CURRENT_DIR}' && exec bash -l"
+	exit "$KSFT_PASS"
+fi
+
+cnt_pass=0
+cnt_fail=0
+cnt_skip=0
+cnt_total=0
+for arg in "${ARGS[@]}"; do
+	run_test "${arg}" "${PARAMS}"
+	rc=$?
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${cnt_total} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${cnt_total} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${cnt_total} ${arg} # exit=$rc"
+	fi
+	cnt_total=$(( cnt_total + 1 ))
+done
+
+echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
+echo "Log: ${LOG}"
+
+if [ $((cnt_pass + cnt_skip)) -eq ${cnt_total} ]; then
+	exit "$KSFT_PASS"
+else
+	exit "$KSFT_FAIL"
+fi

---
base-commit: b80a75cf6999fb79971b41eaec7af2bb4b514714
change-id: 20250818-virtme-ng-f73db7e61235

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


