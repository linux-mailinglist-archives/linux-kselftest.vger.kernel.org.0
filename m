Return-Path: <linux-kselftest+bounces-23059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7B9E9EB2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD61881CA4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFD19343B;
	Mon,  9 Dec 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="hsozfRMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00698194C9E;
	Mon,  9 Dec 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770607; cv=pass; b=pNyjjWTzEPcXQPnTVZXn1EdcOgCfuJDDt+3RAYJ75gWJkJM3M22CJ/ztoALWtaXzzSv++KaT6L2fsDCx27OwDO+8mtD8JGXaTQXl2gd+t+b9BxKVy81wFvEyKlVhO58TCIAKqlBdUTZtEbpWkEt1xn6vOO6qqD2vo4VrYg++xJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770607; c=relaxed/simple;
	bh=Kwv6aO/27IArKRiMj1cFQdSsWxkoy6DL3ccDQf9tJ6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l09/WisHRS3dnGxbLEWKbNaykkAHZof0cjleFa1qSPfleuKxUdasuZOxB1TdyY0qlCgAHPBuwCcSFbLQCPrdEbJt+lLseGs14Cq7J94JnJbhIqgP9TgzN9uuTeV7jmJDULxv6DulU4ZwXPnY7oHLUnnb4MtoRBk7KjEULuQuetk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=hsozfRMz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733770588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BH1uN4PNbgO2EdoTYC+DWceD5kkupIwlLyYjeNybiRzMbJg2dwWY6374yn17xPx93VfOsxP00ItYIP1SdZ8A+1sdDdTEANNmPet8Wo+NKdsGydgrM33DsxIJ+JUaOd8459RYu410iWq6HMo/C/RgMSYScTTKsOJDqXrQd7KnAY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733770588; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/Qv2og47kVG8c0xQF+Q2piw26jz1RE6nH/VURIZHB9U=; 
	b=m24NXzuNBxWQASS9nQIl3zB7p9+GMrbdq1V7xQ7pwHvUPjeDS1O11ek18V59J0yvI5rvlzGF4JC/cg0EmWpkp1vg3exK121D74UNnYGPqERqG0J/JpGDc8P4S0wYSg19/+wWXZw+5t17d+3E1x3w2geEw+FjJBeDLQqGmdkik9I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733770588;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/Qv2og47kVG8c0xQF+Q2piw26jz1RE6nH/VURIZHB9U=;
	b=hsozfRMzsNmgww3EpXvmZ74cjdAxxuzkEY6jVQsUKmRRU2FUgwEiRsOYFr4ccrAZ
	c4FNYl/MZapxI+zHlQOCc6Cn/Pf5YKglvOZ55epMNdTOaweM0lZsuDwxWpD5Q2rIIaf
	KMHT8RcgD9od9TQRHSqFFre14sSIrtDMzuyjwgfU=
Received: by mx.zohomail.com with SMTPS id 1733770586925426.83591125268447;
	Mon, 9 Dec 2024 10:56:26 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 1/4] selftests/mm: thp_settings: remove const from return type
Date: Mon,  9 Dec 2024 23:56:21 +0500
Message-Id: <20241209185624.2245158-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185624.2245158-1-usama.anjum@collabora.com>
References: <20241209185624.2245158-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Remove cost from the return type as it is ignored anyways and generates
the warning:
  warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Optional fixes tag.
Fixes: 00679a183ac6 ("selftests/mm: factor out thp settings management")
Add fixes tag to last patch which had created these files instead of
original patch which added these.
---
 tools/testing/selftests/mm/thp_settings.c | 4 ++--
 tools/testing/selftests/mm/thp_settings.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index 577eaab6266fd..ad872af1c81aa 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -87,7 +87,7 @@ int write_file(const char *path, const char *buf, size_t buflen)
 	return (unsigned int) numwritten;
 }
 
-const unsigned long read_num(const char *path)
+unsigned long read_num(const char *path)
 {
 	char buf[21];
 
@@ -172,7 +172,7 @@ void thp_write_string(const char *name, const char *val)
 	}
 }
 
-const unsigned long thp_read_num(const char *name)
+unsigned long thp_read_num(const char *name)
 {
 	char path[PATH_MAX];
 	int ret;
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index 876235a23460c..fc131d23d5930 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -64,12 +64,12 @@ struct thp_settings {
 
 int read_file(const char *path, char *buf, size_t buflen);
 int write_file(const char *path, const char *buf, size_t buflen);
-const unsigned long read_num(const char *path);
+unsigned long read_num(const char *path);
 void write_num(const char *path, unsigned long num);
 
 int thp_read_string(const char *name, const char * const strings[]);
 void thp_write_string(const char *name, const char *val);
-const unsigned long thp_read_num(const char *name);
+unsigned long thp_read_num(const char *name);
 void thp_write_num(const char *name, unsigned long num);
 
 void thp_write_settings(struct thp_settings *settings);
-- 
2.39.5


