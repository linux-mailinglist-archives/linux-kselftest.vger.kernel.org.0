Return-Path: <linux-kselftest+bounces-29895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD51A75241
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4617061C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD091A8418;
	Fri, 28 Mar 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffg02hjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686024A05;
	Fri, 28 Mar 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199305; cv=none; b=dBJbcTxveElUpgCVm8PKrZg+0Efq6cous5XkLy9hnheqe6qEvPWPUrtP//jKm4o14/qy6K5fFFZqVdIrCsHPuS8C3NSatYm00mCSOb9G1H+otytJ1Qpphnkr2gWSv1K0hBX8nWpLD2EoPji9ch66cHO7ezG0lH4mSQXqtTXlyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199305; c=relaxed/simple;
	bh=SSH6fnOtoT1ysxQcZHp9njNCoc5fKETBZvRU3SyCI/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZCNhC8d03MYw7/Y3EueIyecBF++XOFooNwH3AfCRi1SStsQDGYGB3SpCND4r6UWWbh4pCZyy28dG9tEWsaaDkpOaWFHdCGoSkf7CQ5VDq8RGzv0iPtrKn7Vn4Mr586N5v8oqeid4thXXsBlo6rIkl486u8sZFxWKe6QP/elS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffg02hjy; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2260c91576aso46654755ad.3;
        Fri, 28 Mar 2025 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743199303; x=1743804103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IVrZIj5NwvolOp7P5/XK/Tk+P2OhfakRiW9sxSIYFs=;
        b=Ffg02hjybBYIU2aF315dGuF40DRNdUj/VLfPTvCkOPh2N3h6DqibexjUc06F4r3yka
         nPPjEZifHK67UiVxATkZaNWTGjEwQbVhbUnzYfgehZ3SacZCaov5nraeRTF2JhN0ISa0
         xaY8AwyFt0fdmwzebBv6cg70gobV4VL642wU0HzCaRRzP/GoID/Hf0nsYJKyIKZHTYP0
         /jwpgm7GSRV0nB8/AJKwGIVUAFkuZjx096KwHKfPBkuuEWtBb093P+bb3jWutawmR4xy
         Hasp5BlNZdtkj6Piv0a4Bm3ciycbjou2bPGhbj7IiXl+vGnH4wfTCTdIif+YGp4X1ign
         XJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743199303; x=1743804103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IVrZIj5NwvolOp7P5/XK/Tk+P2OhfakRiW9sxSIYFs=;
        b=CT+tWBGHcsjbq2tt2g8I2E7egu828YvjXMIvGxB2ToI+bUirDEOgHGvv1gT+B/jv3Q
         uezT2ctma6RFO06R+ZYJQ+XBfWgSUgPkOAyA1qdfMj+5QSMh/Wewd3xgQ7PkQhY75/wU
         oOX3XLICGNwnrOGZyu7HlhMAcwsbbmvqZXFLwN0yVlwzKzaO7dzaN7dP6VUcayn7yD+I
         ooyf8l4OYZZMci0pUgY0DclQ49R+qSAoo5/jE7QAiSizyN4wlMo70gOwCBDoLVB61pDs
         Ksig64UAVwMk4oGsmSfOHTdUSlNUsPthyZ6HPIJgi2pgWlgxA/fTxVnB8GJZGDUeyYSO
         xMFw==
X-Forwarded-Encrypted: i=1; AJvYcCUtoTirXxPEoSducUn7IMusf1n5NmG9jLHpPHTc+2QJ5ttk5GOnQSr1+bJO9xpFoEM43Otq49BtgG73SVjgCSWY@vger.kernel.org, AJvYcCWJGikblEcwYkRHaWUt6LKSVzIb/Vhxefj3b6+tTj2sjUULrDwyrnpnxXU/jdqyQ+3VnnsY59FYTDNXPJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsQic44I7hc8tnz2nA6OY8ZMY2SSRgf1MiAlSRq6QSyuZ6m1a
	y7fYMpP9IFzGVmUWOJJ5I+jGD4Piz2NbEAQaZk+yRa/WItCWS7lQ
X-Gm-Gg: ASbGnctS3AIGaJcjmvVZA+rzZ0g6KXNkZSqT9tQrzdkgoLB/+/ei7cFisNoi0QbOjy+
	Jj7PW0prpGXwJtH747VVq7uxUX3ht3hu4byZtSSHf/UqkpTxaDv+oURhOaBjQpyMe3TYUOpmxXP
	FnimGWoBpxp7zcKMNCfka86puAc27sf7UxOTVoesJJY4KMOTDBlSh8LUqwMc+8aGTsMC0hF1vuG
	NTu0oY0V4MRYxPJoIb5oFfFNnHbdIkCiVEc6HASp3hu68w1FAcTT6at/3ZaINnrOOUYREmsg10i
	F7xCWJEaS4HlFp2NfpZWVNgVJ0+TOUDenH58mdc01ltv7sfyCfcK2NpWv4UPh9va
X-Google-Smtp-Source: AGHT+IGJyrofPtYjcdwJFJMViyQI/JadXUdxW2feSLnMyP0HVI8yOQ2zIl58vUTrfxBzH7KUhYJ53Q==
X-Received: by 2002:a05:6a00:1784:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7398038028cmr1140094b3a.10.1743199303271;
        Fri, 28 Mar 2025 15:01:43 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.231.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710d4761sm2318154b3a.167.2025.03.28.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 15:01:42 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Siddarth G <siddarthsgml@gmail.com>,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH] selftests/mm: Fix loss of information warnings
Date: Sat, 29 Mar 2025 03:30:37 +0530
Message-ID: <20250328220037.149763-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cppcheck reported a style warning:
int result is assigned to long long variable. If the variable is long long
to avoid loss of information, then you have loss of information.

Changing the type of page_size from 'unsigned int' to 'unsigned long long'
was considered. But that might cause new conversion issues in other
parts of the code where calculations involving 'page_size' are assigned
to int variables. So we approach by appending ULL suffixes

Reported-by: David Binderman <dcb314@hotmail.com>
Closes: https://lore.kernel.org/all/AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com/
Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f..f3b12402ca89 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -244,7 +244,7 @@ int sanity_tests_sd(void)
 	long walk_end;
 
 	vec_size = num_pages/2;
-	mem_size = num_pages * page_size;
+	mem_size = num_pages * (long long)page_size;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
 	if (!vec)
@@ -432,7 +432,7 @@ int sanity_tests_sd(void)
 	free(vec2);
 
 	/* 8. Smaller vec */
-	mem_size = 1050 * page_size;
+	mem_size = 1050ULL * page_size;
 	vec_size = mem_size/(page_size*2);
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -487,7 +487,7 @@ int sanity_tests_sd(void)
 	total_pages = 0;
 
 	/* 9. Smaller vec */
-	mem_size = 10000 * page_size;
+	mem_size = 10000ULL * page_size;
 	vec_size = 50;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -1058,7 +1058,7 @@ int sanity_tests(void)
 	char *tmp_buf;
 
 	/* 1. wrong operation */
-	mem_size = 10 * page_size;
+	mem_size = 10ULL * page_size;
 	vec_size = mem_size / page_size;
 
 	vec = malloc(sizeof(struct page_region) * vec_size);
@@ -1507,7 +1507,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	sanity_tests_sd();
 
 	/* 2. Normal page testing */
-	mem_size = 10 * page_size;
+	mem_size = 10ULL * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem\n");
@@ -1520,7 +1520,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	munmap(mem, mem_size);
 
 	/* 3. Large page testing */
-	mem_size = 512 * 10 * page_size;
+	mem_size = 512ULL * 10 * page_size;
 	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
 	if (mem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem\n");
-- 
2.43.0


