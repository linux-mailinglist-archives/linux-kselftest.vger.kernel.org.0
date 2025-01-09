Return-Path: <linux-kselftest+bounces-24154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640EA07F10
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98725188D2F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE71A2C0B;
	Thu,  9 Jan 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="E42plzwo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87919306F;
	Thu,  9 Jan 2025 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444426; cv=pass; b=Ms95GArsPt4QfxuJQ12vyfK3cWRilI38Lj3IbQjPkeobylIo3H2A+IGOidBR2tXfRMBAPMJbnGM9wQGSZFbPMgollcMR0WW2x1DIhR5ffVMwKtXesZzYV47cuwrLYwl2Js5SG92kgehWdPCRoQBmJH0cdvQacqNRmJJBbbqgzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444426; c=relaxed/simple;
	bh=ZfDYeNDp/NbUJRxCeBp2IvOWYJKgrIuO3sZpGkWAb+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBc066kvtrtUgxHB67CFd/qrglPcPBcqC+gQdYaOcGNlt+xYQ2XrbSfcY5HiKg/h486ttZ28+Rvt1evlNAtymRx0ipZ4fv7HYc6f0qTSIvjxxwMC7fL1mxn4wo1VvRzZpDZ/rT0fQpZ9jVn9hKNFq2TuVZb5Lg1zGG7lkPghAVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=E42plzwo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444408; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EA96Fos4BhL2pPCfCvhDOGRlyxxT1MkPpiO4QNlECeC0D28p7B6/iJaOgfw4SgWGglX2Y3XSE/sBz/rAM9McoIjzPo44zNDG+woARIuIduahd6ZpYzJAg9hlBkMU1lUbViy/rjT7Jm6M3z3+mJPFsUezq/hCCHvyvoMTkOTpSvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444408; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CeHZ22DeRcbYzVqgFrIGCzYTZL3s2f2EUGStcqAuXWw=; 
	b=QoGmpsBPt1rQgSWYA+KTSGfCOR5BggWu1E95AwxFKv4EgsIyMkzPcdWAjvHHhDe1gmMcQs2FaySvML4du+wvgRuDVgFeXtgR3GO3IsMhwMYp8UMdZZYOTjQRIkONbJoEGAeL1hw4xd3sAw05CI7+I4CfHrrENWHUTVZxNqA2ylk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444408;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=CeHZ22DeRcbYzVqgFrIGCzYTZL3s2f2EUGStcqAuXWw=;
	b=E42plzwodXz91pjg1bgn90hvwF78JGAIljtjn7PZMAitJ8hRSr2yiIoCeJZsFgJC
	ckmgDtP4qT/Ry+FpcwT0KsXqI1UKC07vh7upsP+dwKvjCTdLDJKHQaKVJsv952MgqRS
	/g1yACduicG6hPfMZWQ95JiHapj4goG8W6lmVlBU=
Received: by mx.zohomail.com with SMTPS id 1736444406712435.8462214370427;
	Thu, 9 Jan 2025 09:40:06 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 15/16] selftests/mm: uffd-*: Fix all type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:41 +0500
Message-Id: <20250109173842.1142376-16-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix all type mismatch warnings in all uffd-* files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 6 +++---
 tools/testing/selftests/mm/uffd-stress.c     | 2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index c15674a60f299..47bdcb47481ae 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -450,7 +450,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
 		args->wp_faults++;
 	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
 		uint8_t *area;
-		int b;
+		unsigned int b;
 
 		/*
 		 * Minor page faults
@@ -621,7 +621,7 @@ int __copy_page(int ufd, unsigned long offset, bool retry, bool wp)
 			err("UFFDIO_COPY error: %"PRId64,
 			    (int64_t)uffdio_copy.copy);
 		wake_range(ufd, uffdio_copy.dst, page_size);
-	} else if (uffdio_copy.copy != page_size) {
+	} else if (uffdio_copy.copy != (signed long)page_size) {
 		err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.copy);
 	} else {
 		if (test_uffdio_copy_eexist && retry) {
@@ -655,7 +655,7 @@ int move_page(int ufd, unsigned long offset, unsigned long len)
 			err("UFFDIO_MOVE error: %"PRId64,
 			    (int64_t)uffdio_move.move);
 		wake_range(ufd, uffdio_move.dst, len);
-	} else if (uffdio_move.move != len) {
+	} else if (uffdio_move.move != (signed long)len) {
 		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
 	} else
 		return 1;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 1270ff3104cc6..5509ec32c3290 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -77,7 +77,7 @@ static void usage(void)
 
 static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < n_cpus; i++) {
 		args[i].cpu = i;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 81b315bedb744..c3d59ec754040 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -917,7 +917,7 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
 		else if (res != -EINVAL)
 			err("UFFDIO_ZEROPAGE not -EINVAL");
 	} else if (has_zeropage) {
-		if (res != page_size)
+		if (res != (signed long)page_size)
 			err("UFFDIO_ZEROPAGE unexpected size");
 		else
 			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
@@ -949,7 +949,7 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 static void uffd_zeropage_test(uffd_test_args_t __attribute__((unused)) *args)
 {
 	bool has_zeropage;
-	int i;
+	unsigned int i;
 
 	has_zeropage = uffd_register_detect_zeropage(uffd, area_dst, page_size);
 	if (area_dst_alias)
@@ -997,7 +997,7 @@ static void do_uffdio_poison(int uffd, unsigned long offset)
 
 	if (ret)
 		err("UFFDIO_POISON error: %"PRId64, (int64_t)res);
-	else if (res != page_size)
+	else if (res != (signed long)page_size)
 		err("UFFDIO_POISON unexpected size: %"PRId64, (int64_t)res);
 }
 
-- 
2.39.5


