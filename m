Return-Path: <linux-kselftest+bounces-26482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D350EA32DC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E3318855CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AF25D554;
	Wed, 12 Feb 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iihh7zap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C325D54D;
	Wed, 12 Feb 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382351; cv=none; b=sYGy69myGObZaJITxDY5Hsn3E1eaD2HlAOdjdHzhlMhbWVqbvLh3Zm6QlT20LjO6fwqQ/TTS8/BLXTxjH9syjxJPzLMoMnuxQ4EsH8qyq6QzwMsXP5FLGfxUNKMRaTjexAUqC+CKS0lrz2IO9K7Cp7LaclplomP2Fjo+7oW8ifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382351; c=relaxed/simple;
	bh=Am3KdYIPQjJJqDySmLeo2AVr33lxdKgLJ8ZrAYJIfwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tr91xlNjLQspZ+26E/dSlUA8pS7HHmI50D+iT4Z8E6ljsBX/e9JAn5R6veSv2QvYY8ChvQ3yU4DkPlc1wrKpViRGzNVoKribB/helCkSuoZiZXmjzzDyFsKwnjukYJsPNMctvqfIxkRgE5NztxTPvdkd9xGxNI8PZcnvrw0gSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iihh7zap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E043C4CEE5;
	Wed, 12 Feb 2025 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382351;
	bh=Am3KdYIPQjJJqDySmLeo2AVr33lxdKgLJ8ZrAYJIfwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iihh7zapczT7KxM5Vm3g/yb9+uPSB50XlzAuM/ZoQlE/5EuYk1NrXTxEN8WzE4vEd
	 UypVyXnjfqXbtDsPro2pnKgJ93nwdPDsn8lkP+0Bh/OwBQIULiubjzbSzAV4AYYzsl
	 WXdoYsEhJc52TSKIyoi8bvXruubS9li10FrChCFIa/WmAFblavJnYtwHVZfLKHE6tL
	 fy43htODUYPox4RDzISQzzHxn1rOpNn352ZnGa/A1Lx+Uxrb/pPRfepwTAr07/y2RX
	 j/m+yNQ04DRO+UeOKVJiHqQlAwBA4CSJDeIkyeowpS3ZvcU3LAA5Qsy1x8TyabvKfy
	 FdzFdwFNiQoXg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Feb 2025 17:44:26 +0000
Subject: [PATCH 2/2] selftests/mm: Allow tests to run with no huge pages
 support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-kselftest-mm-no-hugepages-v1-2-44702f538522@kernel.org>
References: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org>
In-Reply-To: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=5034; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Am3KdYIPQjJJqDySmLeo2AVr33lxdKgLJ8ZrAYJIfwE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrN5Il20DD+VhUdR0ubKKm9DDL6E/oyYts5aGN3Za
 zrQz7T2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6zeSAAKCRAk1otyXVSH0ICeB/
 4w/FgxT9RwtA7DwrjwxGCHSfCWlO/iDd4knXJQInuAxqYW2IveU6Y2bvg280rXvcuN4+hctl0uLwQK
 fp3zw+bBota+Gl+ftZ9rN9GrTSuGG8XMipvbBAUDfziHGsExY7LkD/OXHe3S7ukFBu23gfzbzvEiAX
 ty4OiU5xMUOEnC6szMeeiUFUU72RdJaReiAHLcwhhr6Gsxyq0C6CDVXpwEYLHXcaDowJEireF4mGaq
 GkEP2n938y7ooIcmA08JVDrjKZfEUUzwH1laDNEgVoV7HMuNuAL0hHNUFKjjyseOQWq3OerBry8xHw
 2xZq/jwpdRGaasWQYe1dBPPEgUHsJZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the mm selftests refuse to run if huge pages are not available in
the current system but this is an optional feature and not all the tests
actually require them. Change the test during startup to be non-fatal and
skip or omit tests which actually rely on having huge pages, allowing the
other tests to be run.

The gup_test does support using madvise() to configure huge pages but it
ignores the error code so we just let it run.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 66 ++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index da7e266681031d2772fb0c4139648904a18e0bf9..d3866b50a6e16a9ba08b6cf33d131edf2a9226be 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -187,9 +187,10 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
 	fi
+	HAVE_HUGEPAGES=1
 else
 	echo "no hugetlbfs support in kernel?"
-	exit 1
+	HAVE_HUGEPAGES=0
 fi
 
 # filter 64bit architectures
@@ -218,13 +219,20 @@ pretty_name() {
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
 	if test_selected ${CATEGORY}; then
+		local skip=0
+
 		# On memory constrainted systems some tests can fail to allocate hugepages.
 		# perform some cleanup before the test for a higher success rate.
 		if [ ${CATEGORY} == "thp" -o ${CATEGORY} == "hugetlb" ]; then
-			echo 3 > /proc/sys/vm/drop_caches
-			sleep 2
-			echo 1 > /proc/sys/vm/compact_memory
-			sleep 2
+			if [ "${HAVE_HUGEPAGES}" = "1" ]; then
+				echo 3 > /proc/sys/vm/drop_caches
+				sleep 2
+				echo 1 > /proc/sys/vm/compact_memory
+				sleep 2
+			else
+				echo "hugepages not supported" | tap_prefix
+				skip=1
+			fi
 		fi
 
 		local test=$(pretty_name "$*")
@@ -232,8 +240,12 @@ run_test() {
 		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
 		printf "%s\n%s\n%s\n" "$sep" "$title" "$sep" | tap_prefix
 
-		("$@" 2>&1) | tap_prefix
-		local ret=${PIPESTATUS[0]}
+		if [ "${skip}" != "1" ]; then
+			("$@" 2>&1) | tap_prefix
+			local ret=${PIPESTATUS[0]}
+		else
+			local ret=$ksft_skip
+		fi
 		count_total=$(( count_total + 1 ))
 		if [ $ret -eq 0 ]; then
 			count_pass=$(( count_pass + 1 ))
@@ -271,13 +283,15 @@ CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
 CATEGORY="hugetlb" run_test ./hugetlb_dio
 
-nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
-# For this test, we need one and just one huge page
-echo 1 > /proc/sys/vm/nr_hugepages
-CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
-CATEGORY="hugetlb" run_test ./hugetlb_madv_vs_map
-# Restore the previous number of huge pages, since further tests rely on it
-echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
+if [ "${HAVE_HUGEPAGES}" = "1" ]; then
+	nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
+	# For this test, we need one and just one huge page
+	echo 1 > /proc/sys/vm/nr_hugepages
+	CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
+	CATEGORY="hugetlb" run_test ./hugetlb_madv_vs_map
+	# Restore the previous number of huge pages, since further tests rely on it
+	echo "$nr_hugepages_tmp" > /proc/sys/vm/nr_hugepages
+fi
 
 if test_selected "hugetlb"; then
 	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"	  | tap_prefix
@@ -391,7 +405,9 @@ CATEGORY="memfd_secret" run_test ./memfd_secret
 fi
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
-CATEGORY="ksm" run_test ./ksm_tests -H -s 100
+if [ "${HAVE_HUGEPAGES}" = "1" ]; then
+	CATEGORY="ksm" run_test ./ksm_tests -H -s 100
+fi
 # KSM KSM_MERGE_TIME test with size of 100
 CATEGORY="ksm" run_test ./ksm_tests -P -s 100
 # KSM MADV_MERGEABLE test with 10 identical pages
@@ -440,15 +456,17 @@ CATEGORY="thp" run_test ./transhuge-stress -d 20
 
 # Try to create XFS if not provided
 if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
-    if test_selected "thp"; then
-        if grep xfs /proc/filesystems &>/dev/null; then
-            XFS_IMG=$(mktemp /tmp/xfs_img_XXXXXX)
-            SPLIT_HUGE_PAGE_TEST_XFS_PATH=$(mktemp -d /tmp/xfs_dir_XXXXXX)
-            truncate -s 314572800 ${XFS_IMG}
-            mkfs.xfs -q ${XFS_IMG}
-            mount -o loop ${XFS_IMG} ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
-            MOUNTED_XFS=1
-        fi
+    if [ "${HAVE_HUGEPAGES}" = "1" ]; then
+	if test_selected "thp"; then
+	    if grep xfs /proc/filesystems &>/dev/null; then
+		XFS_IMG=$(mktemp /tmp/xfs_img_XXXXXX)
+		SPLIT_HUGE_PAGE_TEST_XFS_PATH=$(mktemp -d /tmp/xfs_dir_XXXXXX)
+		truncate -s 314572800 ${XFS_IMG}
+		mkfs.xfs -q ${XFS_IMG}
+		mount -o loop ${XFS_IMG} ${SPLIT_HUGE_PAGE_TEST_XFS_PATH}
+		MOUNTED_XFS=1
+	    fi
+	fi
     fi
 fi
 

-- 
2.39.5


