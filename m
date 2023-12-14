Return-Path: <linux-kselftest+bounces-1930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387181361E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 17:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2006B2181B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEC5F1FA;
	Thu, 14 Dec 2023 16:24:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8418F112
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 08:24:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B87AC15;
	Thu, 14 Dec 2023 08:25:28 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051153F5A1;
	Thu, 14 Dec 2023 08:24:41 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Date: Thu, 14 Dec 2023 16:24:34 +0000
Message-Id: <20231214162434.3580009-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running tests on a CI system (e.g. LAVA) it is useful to output
test results in TAP format so that the CI can parse the fine-grained
results to show regressions. Many of the mm selftest binaries already
output using the TAP format. And the kselftests runner
(run_kselftest.sh) also uses the format. CI systems such as LAVA can
already handle nested TAP reports. However, with the mm selftests we
have 3 levels of nesting (run_kselftest.sh -> run_vmtests.sh ->
individual test binaries) and the middle level did not previously
support TAP, which breaks the parser.

Let's fix that by teaching run_vmtests.sh to output using the TAP
format. Ideally this would be opt-in via a command line argument to
avoid the possibility of breaking anyone's existing scripts that might
scrape the output. However, it is not possible to pass arguments to
tests invoked via run_kselftest.sh. So I've implemented an opt-out
option (-n), which will revert to the existing output format.

Future changes to this file should be aware of 2 new conventions:

 - output that is part of the TAP reporting is piped through tap_output
 - general output is piped through tap_prefix

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 51 +++++++++++++++++------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 87f513f5cf91..246d53a5d7f2 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -5,6 +5,7 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4

+count_total=0
 count_pass=0
 count_fail=0
 count_skip=0
@@ -17,6 +18,7 @@ usage: ${BASH_SOURCE[0]:-$0} [ options ]
   -a: run all tests, including extra ones
   -t: specify specific categories to tests to run
   -h: display this message
+  -n: disable TAP output

 The default behavior is to run required tests only.  If -a is specified,
 will run all tests.
@@ -77,12 +79,14 @@ EOF
 }

 RUN_ALL=false
+TAP_PREFIX="# "

-while getopts "aht:" OPT; do
+while getopts "aht:n" OPT; do
 	case ${OPT} in
 		"a") RUN_ALL=true ;;
 		"h") usage ;;
 		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
+		"n") TAP_PREFIX= ;;
 	esac
 done
 shift $((OPTIND -1))
@@ -184,30 +188,52 @@ fi
 VADDR64=0
 echo "$ARCH64STR" | grep "$ARCH" &>/dev/null && VADDR64=1

+tap_prefix() {
+	sed -e "s/^/${TAP_PREFIX}/"
+}
+
+tap_output() {
+	if [[ ! -z "$TAP_PREFIX" ]]; then
+		read str
+		echo $str
+	fi
+}
+
+pretty_name() {
+	echo "$*" | sed -e 's/^\(bash \)\?\.\///'
+}
+
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
 	if test_selected ${CATEGORY}; then
+		local test=$(pretty_name "$*")
 		local title="running $*"
 		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
-		printf "%s\n%s\n%s\n" "$sep" "$title" "$sep"
+		printf "%s\n%s\n%s\n" "$sep" "$title" "$sep" | tap_prefix

-		"$@"
-		local ret=$?
+		("$@" 2>&1) | tap_prefix
+		local ret=${PIPESTATUS[0]}
+		count_total=$(( count_total + 1 ))
 		if [ $ret -eq 0 ]; then
 			count_pass=$(( count_pass + 1 ))
-			echo "[PASS]"
+			echo "[PASS]" | tap_prefix
+			echo "ok ${count_total} ${test}" | tap_output
 		elif [ $ret -eq $ksft_skip ]; then
 			count_skip=$(( count_skip + 1 ))
-			echo "[SKIP]"
+			echo "[SKIP]" | tap_prefix
+			echo "ok ${count_total} ${test} # SKIP" | tap_output
 			exitcode=$ksft_skip
 		else
 			count_fail=$(( count_fail + 1 ))
-			echo "[FAIL]"
+			echo "[FAIL]" | tap_prefix
+			echo "not ok ${count_total} ${test} # exit=$ret" | tap_output
 			exitcode=1
 		fi
 	fi # test_selected
 }

+echo "TAP version 13" | tap_output
+
 CATEGORY="hugetlb" run_test ./hugepage-mmap

 shmmax=$(cat /proc/sys/kernel/shmmax)
@@ -231,9 +257,9 @@ CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
 echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages

 if test_selected "hugetlb"; then
-	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"
-	echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
-	echo "      hugetlb regression testing."
+	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"	  | tap_prefix
+	echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for" | tap_prefix
+	echo "      hugetlb regression testing."			  | tap_prefix
 fi

 CATEGORY="mmap" run_test ./map_fixed_noreplace
@@ -312,7 +338,7 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate

-echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
+(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret

 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
@@ -369,6 +395,7 @@ CATEGORY="mkdirty" run_test ./mkdirty

 CATEGORY="mdwe" run_test ./mdwe_test

-echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}"
+echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
+echo "1..${count_total}" | tap_output

 exit $exitcode
--
2.25.1


