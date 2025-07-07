Return-Path: <linux-kselftest+bounces-36703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF1AFB74F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D67E1AA6976
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E12E336E;
	Mon,  7 Jul 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec+CT27+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B272E3360;
	Mon,  7 Jul 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901980; cv=none; b=pnSIAnq5Ltp3eHyCKGa3N9nMoKcEoC429Q9tLrlrLDxLCG3GNqelIIsJff/WV6wxN9d7avFrMWxqNQL41c3sm0XeUs5fj8XkaFOfxHANeaNhwjtgq69JOrqgLyw4oG8y4lb+0sUwUqaaoIrTaRxXG5tQ74gG5ciFY1YiLKkA46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901980; c=relaxed/simple;
	bh=auft5QMJz3JBw8guzVy3fSYxhiMqLYHXCpyih2sdaFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFdwfFgO6/70/HjhqgNa0olLWilA2KlCaDl6Esuf6Si3VHXOLhF6BNzwo1b60ciddNZX/WkIVqV1OGdLoT0R46SE7696PHwA4g+WyItJxcymqBPwKphN+5M+T4eOgIge41m4jWfJpOU0YIkAzDafPjoxsmTpGPirnWXdcp0RDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec+CT27+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234bfe37cccso36447025ad.0;
        Mon, 07 Jul 2025 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901978; x=1752506778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlocpt7CECBU87LrrF2s/X5hZPUr9DDE65AWKyn7Ey8=;
        b=ec+CT27+PSFaJ7RYR5mMCiTIcZO3MP1WjWUAQijxdnf9cdzZFLcteWoWoDcvJwNMDs
         sJGAyIRZVyx2H7ywpqOa61fPmdkvfAuv4wSkNqB6B4VRbYzAWrjvzSPFFwCJ9aR06vH4
         eaJm0iT2pOK686Hwhupy9e5vy/iPUPIPIZJSmQzUFdR4SMPOFa/a85hONMnZgj33NlGf
         BpdqwBeoQjF/VOHhAz2eClX80UD5rgZh93qhtKRpk5g4F7RBJpfEwl76dE5SaqCSAWu2
         mIyrCJiewwOWmp6EYqmZBbWVbIDzjXYM8SDuaO2vrKmnIpssE8pgJQKPvx9hU34ChiSP
         8YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901978; x=1752506778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlocpt7CECBU87LrrF2s/X5hZPUr9DDE65AWKyn7Ey8=;
        b=pdC97APZucvOfz1yrGnjoJo5XYzS6lQqTSHv7yW/LhVxgh3RCnbyrpqzHhPF4gJvHI
         YztjWy0ZiBO4Pi6vNlrliUpjIRFzXWdtkknmBENVRQ1B3526y81xm/joEz+qPjI5KwBt
         L5rJEE7Hs8HLz/+co+BhY7rPEXtdsYP3gukQMqrUprAN0y2pK6G21AjNjscXdb3NbCjs
         aT0sf12K2miE1Iybkr6Jh145nrI4pu3BMEGy3d68cc9poaXb+Tr/1TJS190osJQtKwB1
         gjlavoX67D9FmGl3VcVFCBclssww3twK3koQhBpB+faRtPiCbEKvn9ZQPq6rFpK3OeyY
         WqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUsDPQl0b6QW02h8hqTnNvVOFtkzIHd5hpzO8nDq2Za26Sb+JEb6GFaE9T6yYG0mFtmXjH4BS35Yl6riRU7rYWH@vger.kernel.org, AJvYcCV3YYcPkd2l1XXUiSoYBuEESjj2pXIoL7xLO7p4qtJ3s912HwJVm7MzxIDtFCauuAuDqOOMunL3Qq2m4Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTchi/t9ju2f9DN57RemBNvH3W5MaDOdr4Akkz/bYs2xzL7qSX
	Kgnqr8tsUSWhASoXlMSgXgMAS6fjtnjGYjdTNCwi0E5NvQtnS+JZo0n+QTCeobMSe6k=
X-Gm-Gg: ASbGncu16qVPwiYh3oDrU0u9PUnlMgRDWgK1IhvsfewlxXPX8JVAdOZfk35BiLfjdXh
	K5rGOj3pIei5LLK+GxTX5Z6QPPgOZ1Bdy6xzPZsu22cIVm53d4UN26ejDdtEQnYEtFxbQo5GPBB
	8Prbc1JvmD/MHjYki43eYWPhhCpu+319rVhlA5OBkn8XFBRIcWnxOMwkEHuDliHESjza8K9Rn78
	Z3Cgy8gdqW1+Qp12B9fV9iIQxzMP/Nf8Ij+vDCm5382pYXk8XFGEwk/5kgsoKH/NKJj/3Ol1pvV
	jpVTYW5faAWXJtpp7OmVYLrP9IDm2KVeTQv5N/S1vcHptizg88qPFSEYHnm4NTk=
X-Google-Smtp-Source: AGHT+IGqWykd/w8bQ2ujww+9Z+3Ef0AnD/9nZSc3qwKua8/lEzUPtMn2BPqrtfdNhs0V2ycI7bUO5A==
X-Received: by 2002:a17:903:1ae8:b0:23c:8f2d:5e23 with SMTP id d9443c01a7336-23c9100b4a3mr135778515ad.52.1751901977697;
        Mon, 07 Jul 2025 08:26:17 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84593e0asm87533495ad.193.2025.07.07.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:26:17 -0700 (PDT)
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
Date: Mon,  7 Jul 2025 20:55:57 +0530
Message-ID: <20250707152557.49877-2-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707152557.49877-1-suresh.k.chandrappa@gmail.com>
References: <20250707152557.49877-1-suresh.k.chandrappa@gmail.com>
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


