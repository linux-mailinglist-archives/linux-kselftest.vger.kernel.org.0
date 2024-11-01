Return-Path: <linux-kselftest+bounces-21290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165509B901E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4160A1C210BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8841991A9;
	Fri,  1 Nov 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOvuOXaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0216F8E5;
	Fri,  1 Nov 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459849; cv=none; b=N518NtPiuNOk+EM4A+pIMwixRblO1zryNUO4/rwTVRc4GBbJOUgM7yi2+Z3KM/6SzY/IfLg/pFf2Msn7E5ccqaomklSjCRuOIt4ifWk7hM738KW/NqmejaJ5nmR3R9BE4OyTf1QGvH9MESbvcUHbkTzdjNBya6gmT19W4t3mBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459849; c=relaxed/simple;
	bh=cpgpBdelIWA1Fdk8uQxZCUhbQSBIqgEJWw0Kw4d5BAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo+i38o9D0RxTx6DnTelBQk4/VldM8alpS/AdrjE4eBHUZV6OSYte+c6nAJBEZenDP6jProEnaM9sXxlwoyvR9Fv7a/DS4sRkgD+SxMgzpVzD6t0DG8MU2lHrRsCPdmgxUyY0W1aqvI+380ZL9Onc+D9Fy/ZfdemlR7lRy+fluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOvuOXaC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so2532640a12.2;
        Fri, 01 Nov 2024 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730459846; x=1731064646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owNM3/QzlAhNtYzONHthhBgzoBUFnEtJ8clA/gqOqP8=;
        b=fOvuOXaCOMEW+tObVazzcLjgnv3BVGr/7AqzgtuYxl5xTNuPubuIntEIBTDyTs2NBW
         DXeWMNhHrCXcRIZM6yiGNBDmFX5EUaRO+GJksByAqREx29W5LNhoCT7+62CPU9dx44/j
         un32BfFoEHWBWBKTWCTUkfsYk4dQFwBLpsnj/et+AWRVaZ6FME8KZDXPAE5iN+I6b7Oi
         lQMiu31qeTF1YBinEGQG7QDjmvAxHDUP7W2rU/doZauadpu6CCbI4ss2Pv2ReV8IHlGB
         /3A2N4CKrKMDzESRQXrSiwtCPRQCDGV4/OBGpIswAO9Tn776QqqoMyN5ECk3qQRPtPV2
         12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459846; x=1731064646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owNM3/QzlAhNtYzONHthhBgzoBUFnEtJ8clA/gqOqP8=;
        b=EBmQfkZJ0BX/HDg674n+BNS84IjWxMTtUA8GZ1TtaQH9nBfufsiaJU0FRUgtqJoY1P
         mmS5xHWQbDmeKpHhdav/L6GF14hXmTKahkbxNHVgWzB7W+/0YOkTcCn4eqWTDSAQW+fQ
         bBHeilEPlUZ6CcfFp3VGlOlxt2NlVw2mGfXeBX/3qPQ+DuTASIuuMNfYRaYsLYBpwhbB
         qTisp2Rlo+RjrXjSC5oWyupA5fgECrhXq9uD+7FcPf7hFYa0C+wG4ljSzPgCvXQwZdu4
         I9tInuKTIFOnNo4RuT4T8U3ahlryIze6tAgGWO/B/LhfZkUHKwd1aXY7Txg27oNjQXHU
         3M3g==
X-Forwarded-Encrypted: i=1; AJvYcCVBSIXjv4g8aAV+QTAFRomONJx451MOBC6uv2S+oL5rgu80se/vZuAqP9NpAL6JEeBv8mNV+I7xkoNFuaXH3Qd2@vger.kernel.org, AJvYcCX9B8CJRVtTfZtQDTUviWyXr6jgzxDO+yxsPd13rwO0kgVR7aNzgCJya8NP/a343pABUe7JJsdy49hYiqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAVhjsEkI3JVcKfOX3Trj7wKsjcbsXFHd2DdgpGix1OsasqdD
	ERO3JmkLXzM31RL0kJT2h8OlAvaglfa0cKcDwhEeD9vJAT2jBJtI
X-Google-Smtp-Source: AGHT+IGcNVKqsisXLQ6ZTw8bj6zkCrJ2Fi6FOroGRITjh3Eiw9Wx7lM7MdorBUvTtiDM49X2w7QDGg==
X-Received: by 2002:a17:907:6d12:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-a9e50938952mr539160766b.30.1730459845500;
        Fri, 01 Nov 2024 04:17:25 -0700 (PDT)
Received: from localhost (dh207-40-94.xnet.hr. [88.207.40.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494068sm169226566b.31.2024.11.01.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:17:25 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 2/2] selftests/mm: fix coccinelle WARNING recommending the use of ARRAY_SIZE()
Date: Fri,  1 Nov 2024 12:15:25 +0100
Message-ID: <20241101111523.1293193-4-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101111523.1293193-2-mtodorovac69@gmail.com>
References: <20241101111523.1293193-2-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
to improve the code readability:

./tools/testing/selftests/mm/uffd-unit-tests.c:1484:32-33: WARNING: Use ARRAY_SIZE
./tools/testing/selftests/mm/uffd-unit-tests.c:1485:30-31: WARNING: Use ARRAY_SIZE

Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1: initial version.

 tools/testing/selftests/mm/uffd-unit-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index a2e71b1636e7..4f6a7440a9aa 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1481,8 +1481,8 @@ static void usage(const char *prog)
 
 int main(int argc, char *argv[])
 {
-	int n_tests = sizeof(uffd_tests) / sizeof(uffd_test_case_t);
-	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
+	int n_tests = ARRAY_SIZE(uffd_tests);
+	int n_mems = ARRAY_SIZE(mem_types);
 	const char *test_filter = NULL;
 	bool list_only = false;
 	uffd_test_case_t *test;
-- 
2.43.0


