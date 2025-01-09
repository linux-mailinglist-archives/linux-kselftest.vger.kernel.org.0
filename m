Return-Path: <linux-kselftest+bounces-24153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DEA07F0F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A48168C93
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F21A238E;
	Thu,  9 Jan 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="OqtrwqmQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4F191499;
	Thu,  9 Jan 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444418; cv=pass; b=k3rVr9zQGZQnDxa73FDbJ0RcY9x56Jia+niF4DZVoiavbxQLvJsyW+Q0IONWu8TA/G2ALh95XIT5Q/Sc0oY3/87UTfZl0W8X8zBnSLpgDJ34kIUZBBAqmGqTOkOO6ihexMkb0hd7gOa2K6K+h8ugp6I4AZeg10dF0YaLwjvUbso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444418; c=relaxed/simple;
	bh=uAe2yaZpNZg6/iS0TsDcrGp/iisStiCJHGxdvbunhds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaO99mgVeyDe1noQ7+IpV6nJp2WfLkUyfIAdMpTk6R35Ts5mD52rd4ujnr+H0hpbF7NZOmrC5n8Yz8iLjuspgxfdTB5l6D1c011esirfrz1CpLkth82qHnrNreAkENLGFuh+GiILfKQlHM1myCxgWMUyWSBGfS3bZtPoWwD8vFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=OqtrwqmQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RKT/gDA02p5jlVeA0ZbGdM6gvQ1lXql/mRPcPhYmrgpAWdlBYGw/6R1eHKPUaICqGTSQsuCwjzQ+BblY+QHmUwPHgGtfm1nKB/tuyz3joF6fCkRmSnK5dD4/vDQtb1dfvy4YFpjHUv/CX+lcWMm1qEViRaKb9zeE3qhmaV8zktc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444400; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jExE7sSKlOBw8hiTubKK6vBM62dOLKsuL/Hd624njm0=; 
	b=mccv1hFXvmsaa923Bm/zl8be9pFJqVhaz6+MXRnAbEJIO2QwYY8dUf8Nzzdo56yIWHwVXAe1MVNOdXG3j4btiny4SRCjxCbRvYKhLDIbP4Yo0pot8QghDP+soM9f+iaaYFEdYOVM1M7CgEhfxFyZreTokRLIDgpNbOdSwjGrZR8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444400;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=jExE7sSKlOBw8hiTubKK6vBM62dOLKsuL/Hd624njm0=;
	b=OqtrwqmQveeDkFGdhTZ7RPC8k3KFXiDUsZQ+0JYO9UXiSr4piapx1Q3hAVYr4bbm
	wVl9zGA7DV2gmu2tXYAoy1E89945Czf4gC7qPh3JFs0u/uJpGEBv9szx5xtTl/BIdnW
	6x1E0vqVaF0ZRTYEJwHHsybiJhTs/JzKMtkNyBTg=
Received: by mx.zohomail.com with SMTPS id 1736444398626830.5404799734731;
	Thu, 9 Jan 2025 09:39:58 -0800 (PST)
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
Subject: [PATCH 14/16] selftests/mm: thuge-gen: Fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:40 +0500
Message-Id: <20250109173842.1142376-15-usama.anjum@collabora.com>
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

Fix all the found type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index e4370b79b62ff..515b89ac4eb59 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -65,7 +65,7 @@ void show(unsigned long ps)
 {
 	char buf[100];
 
-	if (ps == getpagesize())
+	if ((signed long)ps == getpagesize())
 		return;
 
 	ksft_print_msg("%luMB: ", ps >> 20);
@@ -106,7 +106,7 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
 
 unsigned long read_free(unsigned long ps)
 {
-	return read_sysfs(ps != getpagesize(),
+	return read_sysfs((signed long)ps != getpagesize(),
 			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
 			  ps >> 10);
 }
@@ -126,7 +126,7 @@ void test_mmap(unsigned long size, unsigned flags)
 	after = read_free(size);
 
 	show(size);
-	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
+	ksft_test_result((signed long)size == getpagesize() || (before - after) == NUM_PAGES,
 			 "%s mmap\n", __func__);
 
 	if (munmap(map, size * NUM_PAGES))
@@ -164,7 +164,7 @@ void test_shmget(unsigned long size, unsigned flags)
 	after = read_free(size);
 
 	show(size);
-	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
+	ksft_test_result((signed long)size == getpagesize() || (before - after) == NUM_PAGES,
 			 "%s: mmap\n", __func__);
 	if (shmdt(map))
 		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
@@ -173,7 +173,7 @@ void test_shmget(unsigned long size, unsigned flags)
 void find_pagesizes(void)
 {
 	unsigned long largest = getpagesize();
-	int i;
+	unsigned int i;
 	glob_t g;
 
 	glob("/sys/kernel/mm/hugepages/hugepages-*kB", 0, NULL, &g);
-- 
2.39.5


