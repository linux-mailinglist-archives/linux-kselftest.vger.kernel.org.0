Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F7445528
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKDOUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 10:20:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59692
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhKDOTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 10:19:35 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFCB83F19B
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Nov 2021 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636035415;
        bh=Nk+x9ywMZ4EZQfdQnv5PA8GdX6QGcMDokRaJp4Pdcvw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=C8Sad8jXcbcIs2wbqME9ARIVvhozMIkJD3KZ74hfxAzqYnjkB+woL3gy3HMaFWDQa
         L4OH7r6JSZguTQPc2qQCw0T2spsSP83RJLgFFARhVq2J5HlSisExi/cf6YSDu7tNU3
         2Fk6xTnOwoxW1/oG1bzb1R28LbXIDBZZuRPgYAt+08pos5TF0Zx+yIqagHmx1W/oGO
         Il1ZYzsNogZ1xlq12Y6F750YbLeA7aHjw8bkwEafMY+NkMAY+WlZWOz6mrH0R9T1KN
         MKPgqkzhq7v9dEkaM142540QKBD2QvkXDcdiyrmDZFyjpLpMaepFjM3JyqPvhW0NMC
         muHRswlV09UTw==
Received: by mail-ed1-f72.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so5850059edd.8
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Nov 2021 07:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nk+x9ywMZ4EZQfdQnv5PA8GdX6QGcMDokRaJp4Pdcvw=;
        b=O5yNj3aRTaPlTq6TZNTfTV1TELk9PG8VMEeLCgpDXpo6TJ7sjsUhA+crBCMN+OM+QM
         GZ3dqmbEbPIY5Fa/dhnNtR9pLcHNWtE5CmeeXeSxPmdhR5ZavbqijSa+hrzHyOEII3yr
         SDscRWsyctavyZQPWtox5LbYahAXoZX2R876+iOsLzKnXiooAPYqbITN/hIJez1e0Jz3
         WMLXAVM9j+oaDCBu5GVB1f8UnYh0qZ93sggYuD4i2EB0zr9lW2rHYvuklK/xTca0yj70
         HFmq9XeW+TxgMrIPl1Huf0JjeGu0cMcTLZVlsl2tl2vtOyzjz0wJanK8WH7+YDkjibME
         gQZQ==
X-Gm-Message-State: AOAM532luA5b7jWe53EeykDGxqj621jXlF2s1NFJyVq3rcHQayclrNda
        7GL7yRRP9oLjAtLKFzSeDFYS8Ac9UtDD7swu7q6eTzvkHTET4umxr12qvkCFjPGnlRdV4T2SJ9d
        40PeswuwcQHEPiVCRbHPx4R+3paVrsKCoxCu9Mwp0IRlNMw==
X-Received: by 2002:a05:6402:1242:: with SMTP id l2mr50214141edw.50.1636035415450;
        Thu, 04 Nov 2021 07:16:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM/965bAB20QbF1Y7/AkTjpYJFdKS1qUET35fMU/FpMndUbs2LQg8VKPVaxzbmVkOwE6P1rw==
X-Received: by 2002:a05:6402:1242:: with SMTP id l2mr50214100edw.50.1636035415058;
        Thu, 04 Nov 2021 07:16:55 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id w1sm3217648edd.49.2021.11.04.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:16:54 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] testing/selftests: replace deprecated "which" with "command -v"
Date:   Thu,  4 Nov 2021 15:16:53 +0100
Message-Id: <20211104141653.24015-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As /usr/share/doc/debianutils/NEWS.Debian.gz says:

 * The 'which' utility will be removed in the future.  Shell scripts
    often use it to check whether a command is available.  A more
    standard way to do this is with 'command -v'; for example:
      if command -v update-icon-caches >/dev/null; then
        update-icon-caches /usr/share/icons/...
      fi
    '2>/dev/null' is unnecessary when using 'command': POSIX says "no
    output shall be written" if the command isn't found.  It's also
    unnecessary for the debianutils version of 'which', and hides the
    deprecation warning.

Starting with debianutils 5.4 "which" is spitting out the following
warning:

 this version of `which' is deprecated; use `command -v' in scripts instead

Start to transition from "which" to "command -v" in the selftests
scripts.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/network_helpers.c             | 2 +-
 tools/testing/selftests/bpf/test_flow_dissector.sh        | 2 +-
 tools/testing/selftests/bpf/test_xdp_redirect_multi.sh    | 2 +-
 tools/testing/selftests/bpf/test_xdp_vlan.sh              | 6 +++---
 tools/testing/selftests/bpf/vmtest.sh                     | 4 ++--
 tools/testing/selftests/firmware/fw_lib.sh                | 2 +-
 tools/testing/selftests/fpu/run_test_fpu.sh               | 2 +-
 .../testing/selftests/ftrace/test.d/selftest/bashisms.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 2 +-
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 2 +-
 tools/testing/selftests/kexec/test_kexec_file_load.sh     | 4 ++--
 tools/testing/selftests/kmod/kmod.sh                      | 4 ++--
 tools/testing/selftests/net/fcnal-test.sh                 | 4 ++--
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh    | 2 +-
 tools/testing/selftests/net/fib_tests.sh                  | 2 +-
 tools/testing/selftests/net/icmp_redirect.sh              | 2 +-
 tools/testing/selftests/net/l2tp.sh                       | 2 +-
 tools/testing/selftests/net/pmtu.sh                       | 8 ++++----
 tools/testing/selftests/net/unicast_extensions.sh         | 4 ++--
 tools/testing/selftests/net/vrf-xfrm-tests.sh             | 2 +-
 tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh   | 2 +-
 tools/testing/selftests/netfilter/nft_conntrack_helper.sh | 2 +-
 tools/testing/selftests/netfilter/nft_flowtable.sh        | 2 +-
 tools/testing/selftests/powerpc/scripts/hmi.sh            | 6 +++---
 tools/testing/selftests/sysctl/sysctl.sh                  | 6 +++---
 tools/testing/selftests/vm/test_hmm.sh                    | 2 +-
 tools/testing/selftests/vm/test_vmalloc.sh                | 2 +-
 tools/testing/selftests/zram/zram_lib.sh                  | 2 +-
 28 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db1af8fdee7..972e6984f668 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -349,7 +349,7 @@ char *ping_command(int family)
 {
 	if (family == AF_INET6) {
 		/* On some systems 'ping' doesn't support IPv6, so use ping6 if it is present. */
-		if (!system("which ping6 >/dev/null 2>&1"))
+		if (!system("command -v ping6 >/dev/null 2>&1"))
 			return "ping6";
 		else
 			return "ping -6";
diff --git a/tools/testing/selftests/bpf/test_flow_dissector.sh b/tools/testing/selftests/bpf/test_flow_dissector.sh
index dbd91221727d..a6469aa01ad5 100755
--- a/tools/testing/selftests/bpf/test_flow_dissector.sh
+++ b/tools/testing/selftests/bpf/test_flow_dissector.sh
@@ -19,7 +19,7 @@ fi
 # namespace.
 if [[ -z $(ip netns identify $$) ]]; then
 	err=0
-	if bpftool="$(which bpftool)"; then
+	if bpftool="$(command -v bpftool)"; then
 		echo "Testing global flow dissector..."
 
 		$bpftool prog loadall ./bpf_flow.o /sys/fs/bpf/flow \
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
index 351955c2bdfd..1e9b99a9b180 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
@@ -61,7 +61,7 @@ check_env()
 		exit 4
 	fi
 
-	which tcpdump &>/dev/null
+	command -v tcpdump &>/dev/null
 	if [ $? -ne 0 ];then
 		echo "selftests: [SKIP] Could not run test without tcpdump"
 		exit 4
diff --git a/tools/testing/selftests/bpf/test_xdp_vlan.sh b/tools/testing/selftests/bpf/test_xdp_vlan.sh
index 0cbc7604a2f8..83bd88aa0aa8 100755
--- a/tools/testing/selftests/bpf/test_xdp_vlan.sh
+++ b/tools/testing/selftests/bpf/test_xdp_vlan.sh
@@ -134,9 +134,9 @@ fi
 set -e
 
 # Some shell-tools dependencies
-which ip > /dev/null
-which tc > /dev/null
-which ethtool > /dev/null
+command -v ip > /dev/null
+command -v tc > /dev/null
+command -v ethtool > /dev/null
 
 # Make rest of shell verbose, showing comments as doc/info
 if [ -n "$VERBOSE" ]; then
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 027198768fad..37f8ce59cce0 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -97,7 +97,7 @@ download_rootfs()
 	local rootfsversion="$1"
 	local dir="$2"
 
-	if ! which zstd &> /dev/null; then
+	if ! command -v zstd &> /dev/null; then
 		echo 'Could not find "zstd" on the system, please install zstd'
 		exit 1
 	fi
@@ -212,7 +212,7 @@ run_vm()
 	local kernel_bzimage="$1"
 	local rootfs_img="${OUTPUT_DIR}/${ROOTFS_IMAGE}"
 
-	if ! which "${QEMU_BINARY}" &> /dev/null; then
+	if ! command -v "${QEMU_BINARY}" &> /dev/null; then
 		cat <<EOF
 Could not find ${QEMU_BINARY}
 Please install qemu or set the QEMU_BINARY environment variable.
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..ac90c288f1fe 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -99,7 +99,7 @@ check_setup()
 	OLD_FWPATH="$(cat /sys/module/firmware_class/parameters/path)"
 
 	if [ "$HAS_FW_LOADER_COMPRESS" = "yes" ]; then
-		if ! which xz 2> /dev/null > /dev/null; then
+		if ! command -v xz 2> /dev/null > /dev/null; then
 			HAS_FW_LOADER_COMPRESS=""
 		fi
 	fi
diff --git a/tools/testing/selftests/fpu/run_test_fpu.sh b/tools/testing/selftests/fpu/run_test_fpu.sh
index d77be93ec139..67f45a0f9ffe 100755
--- a/tools/testing/selftests/fpu/run_test_fpu.sh
+++ b/tools/testing/selftests/fpu/run_test_fpu.sh
@@ -9,7 +9,7 @@ if [ $uid -ne 0 ]; then
 	exit 1
 fi
 
-if ! which modprobe > /dev/null 2>&1; then
+if ! command -v modprobe > /dev/null 2>&1; then
 	echo "$0: You need modprobe installed"
         exit 4
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
index 1b081e910e14..1082287b66fd 100644
--- a/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
+++ b/tools/testing/selftests/ftrace/test.d/selftest/bashisms.tc
@@ -7,7 +7,7 @@ if [ ! -f $FTRACETEST_ROOT/ftracetest ]; then
   exit_unresolved
 fi
 
-if ! which checkbashisms > /dev/null 2>&1 ; then
+if ! command -v checkbashisms > /dev/null 2>&1 ; then
   echo "No checkbashisms found. skipped."
   exit_unresolved
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
index 11be10e1bf96..868c70817e1c 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -3,7 +3,7 @@
 # description: Test wakeup tracer
 # requires: wakeup:tracer
 
-if ! which chrt ; then
+if ! command -v chrt ; then
   echo "chrt is not found. This test requires nice command."
   exit_unresolved
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
index 3a77198b3c69..91f534559c7f 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -3,7 +3,7 @@
 # description: Test wakeup RT tracer
 # requires: wakeup_rt:tracer
 
-if ! which chrt ; then
+if ! command -v chrt ; then
   echo "chrt is not found. This test requires chrt command."
   exit_unresolved
 fi
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 2ff600388c30..cebdf5b495b6 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -59,7 +59,7 @@ is_ima_sig_required()
 # Return 1 for PE signature found and 0 for not found.
 check_for_pesig()
 {
-	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
+	command -v pesign > /dev/null 2>&1 || log_skip "pesign not found"
 
 	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
 	local ret=$?
@@ -77,7 +77,7 @@ check_for_imasig()
 {
 	local ret=0
 
-	which getfattr > /dev/null 2>&1
+	command -v getfattr > /dev/null 2>&1
 	if [ $?	-eq 1 ]; then
 		log_skip "getfattr not found"
 	fi
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..8147e72790f2 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -110,12 +110,12 @@ function allow_user_defaults()
 
 test_reqs()
 {
-	if ! which modprobe 2> /dev/null > /dev/null; then
+	if ! command -v modprobe 2> /dev/null > /dev/null; then
 		echo "$0: You need modprobe installed" >&2
 		exit $ksft_skip
 	fi
 
-	if ! which kmod 2> /dev/null > /dev/null; then
+	if ! command -v kmod 2> /dev/null > /dev/null; then
 		echo "$0: You need kmod installed" >&2
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 3313566ce906..f4bafa9ffdf7 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -82,7 +82,7 @@ NSA_CMD="ip netns exec ${NSA}"
 NSB_CMD="ip netns exec ${NSB}"
 NSC_CMD="ip netns exec ${NSC}"
 
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 ################################################################################
 # utilities
@@ -4037,7 +4037,7 @@ elif [ "$TESTS" = "ipv6" ]; then
 	TESTS="$TESTS_IPV6"
 fi
 
-which nettest >/dev/null
+command -v nettest >/dev/null
 if [ $? -ne 0 ]; then
 	echo "'nettest' command not found; skipping tests"
 	exit $ksft_skip
diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 51df5e305855..4f7dd3f99209 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -15,7 +15,7 @@
 PAUSE_ON_FAIL=no
 VERBOSE=0
 
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 ################################################################################
 # helpers
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 5abe92d55b69..17fda5db85e0 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -17,7 +17,7 @@ PAUSE=no
 IP="ip -netns ns1"
 NS_EXEC="ip netns exec ns1"
 
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 log_test()
 {
diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index ecbf57f264ed..42c073658e3c 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -488,7 +488,7 @@ EOF
 # main
 
 # Some systems don't have a ping6 binary anymore
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 ret=0
 nsuccess=0
diff --git a/tools/testing/selftests/net/l2tp.sh b/tools/testing/selftests/net/l2tp.sh
index 5782433886fc..a79f30f4d5ba 100755
--- a/tools/testing/selftests/net/l2tp.sh
+++ b/tools/testing/selftests/net/l2tp.sh
@@ -16,7 +16,7 @@
 VERBOSE=0
 PAUSE_ON_FAIL=no
 
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 ################################################################################
 #
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 543ad7513a8e..609c682e78cf 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -197,7 +197,7 @@ VERBOSE=0
 TRACING=0
 
 # Some systems don't have a ping6 binary anymore
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 #               Name                          Description                  re-run with nh
 tests="
@@ -661,7 +661,7 @@ setup_xfrm() {
 }
 
 setup_nettest_xfrm() {
-	which nettest >/dev/null
+	command -v nettest >/dev/null
 	if [ $? -ne 0 ]; then
 		echo "'nettest' command not found; skipping tests"
 	        return 1
@@ -1777,7 +1777,7 @@ test_pmtu_vti6_link_change_mtu() {
 check_command() {
 	cmd=${1}
 
-	if ! which ${cmd} > /dev/null 2>&1; then
+	if ! command -v ${cmd} > /dev/null 2>&1; then
 		err "  missing required command: '${cmd}'"
 		return 1
 	fi
@@ -2072,7 +2072,7 @@ do
 	case $o in
 	p) PAUSE_ON_FAIL=yes;;
 	v) VERBOSE=1;;
-	t) if which tcpdump > /dev/null 2>&1; then
+	t) if command -v tcpdump > /dev/null 2>&1; then
 		TRACING=1
 	   else
 		echo "=== tcpdump not available, tracing disabled"
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index 2d10ccac898a..afcc7f15b67e 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -32,9 +32,9 @@
 ksft_skip=4
 
 # nettest can be run from PATH or from same directory as this selftest
-if ! which nettest >/dev/null; then
+if ! command -v nettest >/dev/null; then
 	PATH=$PWD:$PATH
-	if ! which nettest >/dev/null; then
+	if ! command -v nettest >/dev/null; then
 		echo "'nettest' command not found; skipping tests"
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index 184da81f554f..04b6dd78137d 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -31,7 +31,7 @@ ENC_2=0x3fb07ac2a91f0347dffeacf62fc46c20f8048be9725930ff
 SPI_1=0x02122b77
 SPI_2=0x2b770212
 
-which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+command -v ping6 > /dev/null 2>&1 && ping6=$(command -v ping6) || ping6=$(command -v ping)
 
 ################################################################################
 #
diff --git a/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh b/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
index 4a6f5c3b3215..a2e08e71d0bf 100755
--- a/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
+++ b/tools/testing/selftests/netfilter/ipip-conntrack-mtu.sh
@@ -41,7 +41,7 @@ checktool (){
 
 checktool "iptables --version" "run test without iptables"
 checktool "ip -Version" "run test without ip tool"
-checktool "which nc" "run test without nc (netcat)"
+checktool "command -v nc" "run test without nc (netcat)"
 checktool "ip netns add ${r_a}" "create net namespace"
 
 for n in ${r_b} ${r_w} ${c_a} ${c_b};do
diff --git a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
index bf6b9626c7dd..17b3f699dc6b 100755
--- a/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
+++ b/tools/testing/selftests/netfilter/nft_conntrack_helper.sh
@@ -37,7 +37,7 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-which nc >/dev/null 2>&1
+command -v nc >/dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without netcat tool"
 	exit $ksft_skip
diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/netfilter/nft_flowtable.sh
index d4ffebb989f8..bcb3e547f639 100755
--- a/tools/testing/selftests/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/netfilter/nft_flowtable.sh
@@ -35,7 +35,7 @@ checktool (){
 
 checktool "nft --version" "run test without nft tool"
 checktool "ip -Version" "run test without ip tool"
-checktool "which nc" "run test without nc (netcat)"
+checktool "command -v nc" "run test without nc (netcat)"
 checktool "ip netns add nsr1" "create net namespace"
 
 ip netns add ns1
diff --git a/tools/testing/selftests/powerpc/scripts/hmi.sh b/tools/testing/selftests/powerpc/scripts/hmi.sh
index dcdb392e8427..f4efc282604f 100755
--- a/tools/testing/selftests/powerpc/scripts/hmi.sh
+++ b/tools/testing/selftests/powerpc/scripts/hmi.sh
@@ -9,9 +9,9 @@
 if [ -x ./getscom ] && [ -x ./putscom ]; then
 	GETSCOM=./getscom
 	PUTSCOM=./putscom
-elif which getscom > /dev/null; then
-	GETSCOM=$(which getscom)
-	PUTSCOM=$(which putscom)
+elif command -v getscom > /dev/null; then
+	GETSCOM=$(command -v getscom)
+	PUTSCOM=$(command -v putscom)
 else
 	cat <<EOF
 Can't find getscom/putscom in . or \$PATH.
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 19515dcb7d04..582d550c82c6 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -97,15 +97,15 @@ test_reqs()
 		exit $ksft_skip
 	fi
 
-	if ! which perl 2> /dev/null > /dev/null; then
+	if ! command -v perl 2> /dev/null > /dev/null; then
 		echo "$0: You need perl installed"
 		exit $ksft_skip
 	fi
-	if ! which getconf 2> /dev/null > /dev/null; then
+	if ! command -v getconf 2> /dev/null > /dev/null; then
 		echo "$0: You need getconf installed"
 		exit $ksft_skip
 	fi
-	if ! which diff 2> /dev/null > /dev/null; then
+	if ! command -v diff 2> /dev/null > /dev/null; then
 		echo "$0: You need diff installed"
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
index 0647b525a625..575d0b31d852 100755
--- a/tools/testing/selftests/vm/test_hmm.sh
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -26,7 +26,7 @@ check_test_requirements()
 		exit $ksft_skip
 	fi
 
-	if ! which modprobe > /dev/null 2>&1; then
+	if ! command -v modprobe > /dev/null 2>&1; then
 		echo "$0: You need modprobe installed"
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/vm/test_vmalloc.sh b/tools/testing/selftests/vm/test_vmalloc.sh
index d73b846736f1..8ba91883f13c 100755
--- a/tools/testing/selftests/vm/test_vmalloc.sh
+++ b/tools/testing/selftests/vm/test_vmalloc.sh
@@ -35,7 +35,7 @@ check_test_requirements()
 		exit $ksft_skip
 	fi
 
-	if ! which modprobe > /dev/null 2>&1; then
+	if ! command -v modprobe > /dev/null 2>&1; then
 		echo "$0: You need modprobe installed"
 		exit $ksft_skip
 	fi
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 6f872f266fd1..e284e8b7a5a4 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -199,7 +199,7 @@ zram_makefs()
 	local i=0
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
-		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
+		command -v mkfs.$fs > /dev/null 2>&1 || fs=ext2
 
 		echo "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
-- 
2.32.0

