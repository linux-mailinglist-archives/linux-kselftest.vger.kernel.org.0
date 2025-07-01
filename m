Return-Path: <linux-kselftest+bounces-36208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04237AF0326
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337B84A4F26
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4F2797B2;
	Tue,  1 Jul 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iavTYV90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A5258CE8;
	Tue,  1 Jul 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395763; cv=none; b=FBGqvzSdxjowIwgMYEE+TXyICK6G4hn51aei7RqlNqGbbY+lHKAU6S/kgZzm7wUMHBFOHqf2CZeJ7r+RVW4fICanThujfNiXvf2GWkcWzlN0rCH3huotPjvjhmwLq0gB4HE4PWn2Nnhf8N9hdNCjUnuY65j1R98C8brfI97ByJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395763; c=relaxed/simple;
	bh=auft5QMJz3JBw8guzVy3fSYxhiMqLYHXCpyih2sdaFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRRvYHtZGS1wXI3g5WfqwWLkW5rn73rrEWtkzAEAfx3AGmHGNK0tUmUyoy0gfFrrG0bL0aPZTrqhCtwPzf+BeDDD4mKK1mKQITQ5A5gwxKFj9D213yFt4y65mW55hHbrYmhWp279el7FrnDvb1nN8CGkijN9xoWQwvVbxGAh45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iavTYV90; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c172f1de1so1902680a34.3;
        Tue, 01 Jul 2025 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751395761; x=1752000561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlocpt7CECBU87LrrF2s/X5hZPUr9DDE65AWKyn7Ey8=;
        b=iavTYV90wDtVeBYmZxACRPhxDPbA6mK/2l08fjCavI6Bj/3z4OV+WbgOTcgEi3OqEd
         PlN9s8JEZbhldeU9GudffHKp2rB0jHP9VnGwCUNkWAc+5CKO09tNV7a/xgGoagsYQ7da
         OVnJKBRNsDKGfHfViisxKjO8OBwEbQ0KY3gnDel/BNR6OeTpHlKkqIIDVtEoXWMasjTV
         MyU1lDjMKwwBC6FH6HAMwI9IuE2HYItroolPtkEIj67uyiDOoHJ04jQMeYDTEGmq83U/
         HOF1xUueRke3aT3n8ujU9FCPDGEyhNCBxBCmBDsre3IAs4rnk7W1lf0nLCPNbF+VxCHl
         oolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751395761; x=1752000561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlocpt7CECBU87LrrF2s/X5hZPUr9DDE65AWKyn7Ey8=;
        b=JXZ+iVA0SSKQh9NGAmPkoqusxoS+yyywFutrfyIanbQo+wseZIj+X2tBBI4HyoNnw+
         HHUwuxjNGaJdhcLckvhTKoZzrTXWc7eaz2i0kfgCU3yW6DyyoeuSvFe3KwYUZhwgzWx8
         76trZuMKHRQeq9kXD1Ucs5OCuYngEKa9l6j8RyBlNZj6dHtgoh/D1Uq+oaUE40Tj9Bxt
         eds+l3t866eBg8cUtd1p9RRWSgBxzT/yHuqpcBjpZdqvGiMdRkceWCmyQvUzqAtDVc/s
         zjXOZ/KkYJ33DjlCk8o3lCBvDtlL9zPE1wRNjSIWF2nn3tJxgaBuNeVrCoHe9tAL9H4Q
         V5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsEsTvXPorNe3Hl8a0UcXoo61ZLhQedsXV3Alu7jUI4nlPZ2zZUMu6nHz1r3I4yMozXY39dtORBtNY6hd/TVQY@vger.kernel.org, AJvYcCWZTZFTAkqCQwJShjlqeBi3wG3wX4Mu9R1VULwLaAg6JMNR53WlKNuUMdmg7GteTyDaqhniRmZ4EafE9Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfj8IImwztRifpGhynNzxJ4LVxAZkZSnw4aVUB60nOxIYXYpiJ
	1frjKXsXVyJf6ti4jjIfMegBSKgqDfVWey4+np1mpOu4E2t9LgQWLMpLooZhVM6Hd+Y=
X-Gm-Gg: ASbGncs41EFCiObRVWt48H/lJ46dsKIAexy3wUQaVhQXl9H3TLsx1DTFydpSqXf/k7b
	lHUBbpK3+4tJq/6dL931nNBF1lqJRAB87p4eT2sX0bSPGCJNCUeU6OiiH1COV2kZgtJbjTdJOhu
	9Vq9oGjW+Xzhvw2PsHws2vZGqlZjDZ9DgfT35XMsrlMvYJH9qMMIL/eKcDnaOZJ5la7ecBmeroj
	2fMyPmefBJA4pVFDSHhpQYxlFXjv4H+sTja5oEGN1FqL9ZA9qsNRWTQxvLofy2kJFxeyVzFVfAB
	5ZExgQLJslomSGcik7JJCnljjVeGHpmOuL/m4FUFqPwyT4VecdXQJiR1kRECPDw=
X-Google-Smtp-Source: AGHT+IGD6GYhV0TyC/EZGQWTN/JNDfKd7qgK/xYCQH+qgaNeT3VqCslC9FibejmA5HPhSxwD102TRw==
X-Received: by 2002:a05:6830:91e:b0:72b:8fd3:e2dc with SMTP id 46e09a7af769-73b4cbe37a2mr82752a34.21.1751395760847;
        Tue, 01 Jul 2025 11:49:20 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb0e3160sm2213242a34.44.2025.07.01.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:49:20 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH v2 2/2] selftest: improve mmap test clarity
Date: Wed,  2 Jul 2025 00:19:02 +0530
Message-ID: <20250701184902.8927-2-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701184902.8927-1-suresh.k.chandrappa@gmail.com>
References: <20250701184902.8927-1-suresh.k.chandrappa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

This patch refactors the mmap test logic to remove redundancy and improve
error reporting. It also removes leftover test code that is no longer needed.

Changes since v1:
- Refactored mmap logic into a switch statement as suggested
- Removed the last-character difference, which was only used for testing
- Added clearer error messages to indicate whether shmem or mmap failed
- Combined patches into a series for better context
- Addressed feedback on patch origin and versioning

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 .../selftests/cachestat/test_cachestat.c      | 52 +++++++++++++------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b6452978dae0..0549b7224ba1 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -206,6 +206,17 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 out:
 	return ret;
 }
+const char* file_type_str(enum file_type type) {
+	switch (type) {
+		case FILE_SHMEM:
+			return "shmem";
+		case FILE_MMAP:
+			return "mmap";
+		default:
+			return "unknown";
+	}
+}
+
 
 bool run_cachestat_test(enum file_type type)
 {
@@ -225,34 +236,41 @@ bool run_cachestat_test(enum file_type type)
 		fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
 
 	if (fd < 0) {
-		ksft_print_msg("Unable to create file.\n");
+		ksft_print_msg("Unable to create %s file.\n",file_type_str(type));
 		ret = false;
 		goto out;
 	}
 
 	if (ftruncate(fd, filesize)) {
-		ksft_print_msg("Unable to truncate file.\n");
-		ret = false;
-		goto close_fd;
-	}
-
-	if (!write_exactly(fd, filesize)) {
-		ksft_print_msg("Unable to write to file.\n");
+		ksft_print_msg("Unable to truncate %s file.\n",file_type_str(type));
 		ret = false;
 		goto close_fd;
 	}
 
-	if (type == FILE_MMAP){
-		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-		if (map == MAP_FAILED) {
-			ksft_print_msg("mmap failed.\n");
+	switch (type){
+		case FILE_SHMEM:
+			if (!write_exactly(fd, filesize)) {
+				ksft_print_msg("Unable to write to file.\n");
+				ret = false;
+				goto close_fd;
+			}
+			break;
+		case FILE_MMAP:
+			char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+			if (map == MAP_FAILED) {
+				ksft_print_msg("mmap failed.\n");
+				ret = false;
+				goto close_fd;
+			}
+			for (int i = 0; i < filesize; i++) {
+				map[i] = 'A';
+			}
+			break;
+		default:
+			ksft_print_msg("Unsupported file type.\n");
 			ret = false;
 			goto close_fd;
-		}
-		for (int i = 0; i < filesize; i++) {
-			map[i] = 'A';
-		}
-		map[filesize - 1] = 'X';
+			break;
 	}
 	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
-- 
2.43.0


