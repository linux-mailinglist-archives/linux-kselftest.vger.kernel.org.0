Return-Path: <linux-kselftest+bounces-3581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A883C731
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4385B1F217F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D476906;
	Thu, 25 Jan 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="spQERbvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34B76916;
	Thu, 25 Jan 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197635; cv=none; b=eUc20eKlOyPMOdlIAEAqDRNSn/noUUVawiGFBjUt5rrw713PtvA9fEi3nM8OHcoj9j3TjB+drgJtPKGUZUY4HfHN2+fTNxhQUeXLBgwxmh5P/mNkah1w+AT5ej2RtRxYN8B7zcHDf1OlbG23on64r40Xt2iXOKScLQ9wtevnQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197635; c=relaxed/simple;
	bh=zJmZgfxWIaYLZOFMPT1jD8KyCb1GdfoJ77F3vo97p4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdWN0zIHsm3IoNqlO+l8VWgF+tLY6++Nyt5qByXU3ijjcLT3uKESgT8B7bpBZ5a7zPm4tAoyaK89/HSotNAxpxwi3JoKcWu+qiXOwXbR6kS/uO4a0rlaOo61ZNuME5ykTQZw/wbQsfBOiycPRaykQ041fmc+trnwJjZOcrTA7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=spQERbvP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197631;
	bh=zJmZgfxWIaYLZOFMPT1jD8KyCb1GdfoJ77F3vo97p4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spQERbvPbrDUUyL60ZyWYlK+MZp56OErqHy8CwHbVAFap8AHI1Cli622MWdnld8Aq
	 TwrHHehfcs8JZFmZqcaO2enEofICBe5wzVbDWlb1D8QiJXEqIusR9jUQIC6rnsgoXa
	 3KYVOqzo6hgu2Vq9YzXFpkrOs7jo+IFO6J0mY84SVJBxJvWgaNryCiARh783mOqQZn
	 NhuqkS6FzsWMQKat6kiOVEnBQsHuEyflRBYKkRjSmgK0nQsFStNyJ2SBsfkh9WdtoA
	 iAevWDtNz/VCkSYlH8veDwFpBgNKwa3UyH3WPKaRf0VRS00NXT0j6BMvwSFl5u2zTU
	 i7BuFoEPy1Tfw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 01DD737820C3;
	Thu, 25 Jan 2024 15:47:08 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] selftests/mm: run_vmtests.sh: add missing tests
Date: Thu, 25 Jan 2024 20:46:08 +0500
Message-ID: <20240125154608.720072-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125154608.720072-1-usama.anjum@collabora.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing tests to run_vmtests.sh. The mm kselftests are run through
run_vmtests.sh. If a test isn't present in this script, it'll not run
with run_tests or `make -C tools/testing/selftests/mm run_tests`.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Copy the original scripts and their dependence script to install directory as well

Changes since v2:
- Add a comment
- Move tests down in the file
- Add "-d" option which poisons the pages and aren't being useable after
  the test
---
 tools/testing/selftests/mm/Makefile       | 5 +++++
 tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2453add65d12f..f3aec7be80730 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -114,6 +114,11 @@ TEST_PROGS := run_vmtests.sh
 TEST_FILES := test_vmalloc.sh
 TEST_FILES += test_hmm.sh
 TEST_FILES += va_high_addr_switch.sh
+TEST_FILES += charge_reserved_hugetlb.sh
+TEST_FILES += hugetlb_reparenting_test.sh
+
+# required by charge_reserved_hugetlb.sh
+TEST_FILES += write_hugetlb_memory.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index e373d592dbf5c..a0f37e4438937 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -19,6 +19,7 @@ usage: ${BASH_SOURCE[0]:-$0} [ options ]
   -t: specify specific categories to tests to run
   -h: display this message
   -n: disable TAP output
+  -d: run destructive tests
 
 The default behavior is to run required tests only.  If -a is specified,
 will run all tests.
@@ -79,6 +80,7 @@ EOF
 }
 
 RUN_ALL=false
+RUN_DESTRUCTIVE_TEST=false
 TAP_PREFIX="# "
 
 while getopts "aht:n" OPT; do
@@ -87,6 +89,7 @@ while getopts "aht:n" OPT; do
 		"h") usage ;;
 		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
 		"n") TAP_PREFIX= ;;
+		"a") RUN_DESTRUCTIVE_TEST=true ;;
 	esac
 done
 shift $((OPTIND -1))
@@ -304,6 +307,11 @@ CATEGORY="process_mrelease" run_test ./mrelease_test
 CATEGORY="mremap" run_test ./mremap_test
 
 CATEGORY="hugetlb" run_test ./thuge-gen
+CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
+CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
+if $RUN_DESTRUCTIVE_TEST; then
+CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
+fi
 
 if [ $VADDR64 -ne 0 ]; then
 
-- 
2.42.0


