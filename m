Return-Path: <linux-kselftest+bounces-3390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39C83880A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F28E1C20B3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B852F73;
	Tue, 23 Jan 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XJBKv2O/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86451C3A;
	Tue, 23 Jan 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995386; cv=none; b=H7wao4Sm4Oe7EOdrP6UzZVwN2I4bkRMFTv6kQSXE0kaWPx8w/2yAOoMCcg+h2NJE3dWGRVrXGa+5FRjOmZRMaqaF/jaKPzJpKQIXgO65QoR1aHZ6KTDU6KifEaq1tp+RNJi0Bu7YLo7Ira4kS27ObV3y5XBosJEsTnpydtrquwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995386; c=relaxed/simple;
	bh=UjyihoPyN6SOPFC4hXvckN7LSDeJ3FDGKGRL79wdbrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8tKh+f9XwjLHyaQjH3KQPhv60ZXVdaA2A0DTcztzNF2IrTmbX9k7LecL+n9I30BZ9/jNIyD69hVChHZtgUWjIfjjsAv1teQARyV/DENK1nRyGYuqcMBsKKLE9Fzollxd1uMI6g87TXEzOP52wL6PRAXcsVxb8XPNfUosjVuy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XJBKv2O/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705995378;
	bh=UjyihoPyN6SOPFC4hXvckN7LSDeJ3FDGKGRL79wdbrI=;
	h=From:To:Cc:Subject:Date:From;
	b=XJBKv2O/lbViF3stGvXrhrgD6QAkY3LkvT2znhJvBl8JwewmKA+W0sDCCN4Tnsm6c
	 D1nUuRlb5LJ1l5RbF72JT4R0Mby8v1FB5Fpw0U2caKcFedUzPcv0AV6rKJEnUtTlGO
	 29DCJMwu7QHL9vYlv7mJ151n+deebekBZGkRqXpAhcm0EyC4GG3Tcbux290jKc3u/e
	 epJslm+MhXD5jwfuncizu2PfPCTAR1vQtxUYNFP4y9ui8vwDtcGlwUOUBoZjWW3DpW
	 hjCSW80jWtpD7ohV4IR2LR+61z0XAUPoOhNBCL+dPDvVMFch+iBex9eUAojH5tTPRS
	 ju3FJeDlSJWJA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 91D033782039;
	Tue, 23 Jan 2024 07:36:16 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/mm: run_vmtests.sh: add missing tests
Date: Tue, 23 Jan 2024 12:36:13 +0500
Message-ID: <20240123073615.920324-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
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
---
 tools/testing/selftests/mm/Makefile       | 3 +++
 tools/testing/selftests/mm/run_vmtests.sh | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2453add65d12f..c9c8112a7262e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -114,6 +114,9 @@ TEST_PROGS := run_vmtests.sh
 TEST_FILES := test_vmalloc.sh
 TEST_FILES += test_hmm.sh
 TEST_FILES += va_high_addr_switch.sh
+TEST_FILES += charge_reserved_hugetlb.sh
+TEST_FILES += write_hugetlb_memory.sh
+TEST_FILES += hugetlb_reparenting_test.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f28..12754af00b39c 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
 CATEGORY="hugetlb" run_test ./hugepage-mremap
 CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
+CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
+CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
+CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
 
 nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 # For this test, we need one and just one huge page
-- 
2.42.0


