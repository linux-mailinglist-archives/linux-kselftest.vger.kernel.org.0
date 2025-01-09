Return-Path: <linux-kselftest+bounces-24150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7CA07F05
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE017168C14
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DD19D07A;
	Thu,  9 Jan 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="JO/5voGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDB191F68;
	Thu,  9 Jan 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444410; cv=pass; b=rYHF8u3kTcfWxfWoWPkGiZxe4/PD0C0i3lPS1edvKhRp1tqjWiEnpSkXYe5yJoJo3Wy0BVBPeGb45ZsUAYo3ePQYaNdbpJwVnTODEf/4bRILMorrqJn7tzW8FJPp6L8JaSbgEfQNhhaNfI3s8PYDu3iz5SPgVCFpMxVePbqTt5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444410; c=relaxed/simple;
	bh=Q4x3BwtxxyZmI9YSoZD8jQQvVaV4y2oFeXHasJCKYe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmX0O4VkQ38RmzF/xYJ/votyz/TxfXyj5qrtA+4FPk3ptPVaWdukh8/cn9st/Mc6uzXpa7I/PQttsBl46IwN9a/zeUAv+McxJZIC7LxdS2LmlYfzNWzWwv1WJlmSi9Sn0oRUiIy64iWNFMhB8DgCpyzFQyzKmY+YZEAAivQizDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=JO/5voGX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444390; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FI2ZpYM2l2lhH4e/ZoKt+g/s4GJCa4puWKr6Q/8iqSEeXqL8P3ua7YLIb98EGDrUsPuTYuAFMxzPMnVnZiXRSId0OdrQGPVH1Qeh43IuFdtrS9FMxClLFXMWYf1gQIOF+nzHlFRF5KL4Zv6ty7BwwLofHU+QCcsU3eG/m+gBzCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444390; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rFE3LTCLLZcWDz1roRpcEOSHGmZKQ3KY8sj8JWlAwYo=; 
	b=JzZW+JZQeRsw6idAdw7Xnes1PyvMbbgbY3zN2DJn/SntKedZYSeCT+VE7qyPOy/lpiWeW5Ci+Hcgy1LXw6g74SPtPbmP2OUBKvSBl4q/Jb51UKXKEipl8oEP6zh0BoWeU8ruLTqtUNFnLhxUJavNp4UsIkdCuaDxfTcWMDKz5Hk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444390;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=rFE3LTCLLZcWDz1roRpcEOSHGmZKQ3KY8sj8JWlAwYo=;
	b=JO/5voGX2w0I8SSOy2/ZpKge+LyWYMK4YtdngTqOXAwJ7JdherhUWOJQy/V4sb+6
	cyh55owN4fMOGxrGEXdV5nu6nIQdCz9KtvBOvDboghRYJN7AOTVWsOepSOjBmLsj1hy
	BTGrO39cuFi69MUD1212zJdAsZAaDSPOLSJrvGUc=
Received: by mx.zohomail.com with SMTPS id 1736444388075563.3499694648385;
	Thu, 9 Jan 2025 09:39:48 -0800 (PST)
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
Subject: [PATCH 12/16] selftests/mm: khugepaged: Fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:38 +0500
Message-Id: <20250109173842.1142376-13-usama.anjum@collabora.com>
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

Fix type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/khugepaged.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 8a4d34cce36b2..dde7c7fbbac2c 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -140,7 +140,7 @@ static void get_finfo(const char *dir)
 		exit(EXIT_FAILURE);
 	}
 	if (snprintf(finfo.path, sizeof(finfo.path), "%s/" TEST_FILE,
-		     finfo.dir) >= sizeof(finfo.path)) {
+		     finfo.dir) >= (signed int)sizeof(finfo.path)) {
 		printf("%s: Pathname is too long\n", __func__);
 		exit(EXIT_FAILURE);
 	}
@@ -155,7 +155,7 @@ static void get_finfo(const char *dir)
 	/* Find owning device's queue/read_ahead_kb control */
 	if (snprintf(path, sizeof(path), "/sys/dev/block/%d:%d/uevent",
 		     major(path_stat.st_dev), minor(path_stat.st_dev))
-	    >= sizeof(path)) {
+	    >= (signed int)sizeof(path)) {
 		printf("%s: Pathname is too long\n", __func__);
 		exit(EXIT_FAILURE);
 	}
@@ -169,7 +169,7 @@ static void get_finfo(const char *dir)
 			     sizeof(finfo.dev_queue_read_ahead_path),
 			     "/sys/dev/block/%d:%d/queue/read_ahead_kb",
 			     major(path_stat.st_dev), minor(path_stat.st_dev))
-		    >= sizeof(finfo.dev_queue_read_ahead_path)) {
+		    >= (signed int)sizeof(finfo.dev_queue_read_ahead_path)) {
 			printf("%s: Pathname is too long\n", __func__);
 			exit(EXIT_FAILURE);
 		}
@@ -197,7 +197,7 @@ static void get_finfo(const char *dir)
 			if (snprintf(finfo.dev_queue_read_ahead_path,
 				     sizeof(finfo.dev_queue_read_ahead_path),
 				     "/sys/block/%s/queue/read_ahead_kb",
-				     str) >= sizeof(finfo.dev_queue_read_ahead_path)) {
+				     str) >= (signed int)sizeof(finfo.dev_queue_read_ahead_path)) {
 				printf("%s: Pathname is too long\n", __func__);
 				exit(EXIT_FAILURE);
 			}
@@ -271,7 +271,7 @@ static void *alloc_mapping(int nr)
 
 static void fill_memory(int *p, unsigned long start, unsigned long end)
 {
-	int i;
+	unsigned int i;
 
 	for (i = start / page_size; i < end / page_size; i++)
 		p[i * page_size / sizeof(*p)] = i + 0xdead0000;
@@ -333,10 +333,10 @@ static void *alloc_hpage(struct mem_ops *ops)
 
 static void validate_memory(int *p, unsigned long start, unsigned long end)
 {
-	int i;
+	unsigned int i;
 
 	for (i = start / page_size; i < end / page_size; i++) {
-		if (p[i * page_size / sizeof(*p)] != i + 0xdead0000) {
+		if ((unsigned int)p[i * page_size / sizeof(*p)] != i + 0xdead0000) {
 			printf("Page %d is corrupted: %#x\n",
 					i, p[i * page_size / sizeof(*p)]);
 			exit(EXIT_FAILURE);
@@ -537,7 +537,7 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 			  struct mem_ops *ops)
 {
-	int full_scans;
+	unsigned int full_scans;
 	int timeout = 6; /* 3 seconds */
 
 	/* Sanity check */
-- 
2.39.5


