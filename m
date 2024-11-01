Return-Path: <linux-kselftest+bounces-21289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D249B901C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E411F21A8F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646E170A03;
	Fri,  1 Nov 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beTa1rhB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902E16F8E5;
	Fri,  1 Nov 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459832; cv=none; b=ODcnq+Og6z9It2PMzW/q4HLrIXPrOeZ1YZKs0X5RL7QnP3713LzjSIGV0xKNRSE/X2HvvBfc9UyOkkAoQZ3QBEw45k+w5QId/TL+beKpP87J4zOVZ8kK3Fp8b8k3oKviV2y+Q3ozM8PKRzJHtrw19XJteq3SW785OCR0W6iPPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459832; c=relaxed/simple;
	bh=5QPEu2ZIm8XWpYWiFlykRMa5UkJdeDfUlIHY7p676BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLP/VOybxmWesvwdhwKQLQvKmPfXhckpdhs19o2bDUZlJaXYKMi5NA8qNuIlFK4G66KfxiFQvkCp3M/cn8V28TtbjMNX07yFubnOYdzBpcR8uzqaRnzqH/AGIIz6hj5LDiHHfwCHkIHlf5hhPxBjGaAml2Rn3pD+JqqeSKrlHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beTa1rhB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso253256066b.2;
        Fri, 01 Nov 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730459829; x=1731064629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtArAmKRSjy4GcchaiNpaMfT3D/wOjJsG1VCp35IVxY=;
        b=beTa1rhBZjQzEP9GbH+0mNUJe1ZEQ0pIBkZdysctsM9lP8GEQHGBgglsbvpmryyedu
         mj/hSRaNu6dFc9OkWwITce9Uu2dNf5rHOO2qEWIExeHisW+uMUeeweeQwsxNsFLDZl6o
         X415y4dT1NobpTXhRAGc/6Mqkr/hRIbxeTsRhWi7mHX96CQgIqsLLsnJmkFXzZKFr87U
         bS1XcuTXXQXV2NIcFV6d7jaeBFy+G2aGAcq0p+GWfnTPYO/+MXL4bLqghkWzoNfCXW7p
         6gm3vUqyscYPUdfk7ane9JSt0tL9j7vcq02U9h3ykPsexNMrWNZgTTbOMcu922ea1uTP
         v1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459829; x=1731064629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtArAmKRSjy4GcchaiNpaMfT3D/wOjJsG1VCp35IVxY=;
        b=N+wZK6LDD5/dBq6W6xRRU64YJRnA7NXE+7YpnZRe5dH5qnL2wTBp/n4pxGxyvwapuF
         +x2jDeDmXfdS2DrAi7echTBu3TkeEaW04mEdhwZpeJmA+nP2Q/dbwLwQxyIDzfbi7otA
         UR5Cc2PPEPJywVvU+xvh7e1j35kMqc6+GGrOB/1o7nALsxn04yEpJmG6mwMJb7ASfpQg
         tw/GXzuJSdWJ5HAgrVGb7Dvi8MxOpofjha1gSskNN7U7+JSFqI7fg38BBZr7j4U0H3Rs
         smcFGRx/8gEsNIkDof9TSjDHCmQFIoxjnSEN2D7EcYxSAdFCfBefJoG70LwyIeclmHs/
         Gw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUOXouVPUJkfp3VJ9OI6KSjgcHoLqxbBsmazRoyoGlADImuzUwxykvprNMUXz5Lu5567XNUrXfGHNCpZtaolk3@vger.kernel.org, AJvYcCUsqpJHNuKVWjBO+k2dLPnt2Mv53l7iXpR6Uvt7rBEkw39SZbquhMrzJboYyEk/y1YZTMnqIsDe5e09ENE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgEVjbTwFLXdmSHHboZhlrrUmSwCxqboXbjwzUJgADpGwHoDx
	cleMt4Pj9p6X7YxJozjyl/IINXBRkpP0tmIv/6klO0HD64GCZwqo
X-Google-Smtp-Source: AGHT+IGYOswi8GmANhJOnv4qTAd/hplNOcov2HOYf1vVwLcaSpO9QPvPflM28+q+u9Xe2bf6/pIihA==
X-Received: by 2002:a17:907:72d6:b0:a9a:14fc:9868 with SMTP id a640c23a62f3a-a9e5089b6b2mr555416066b.4.1730459828356;
        Fri, 01 Nov 2024 04:17:08 -0700 (PDT)
Received: from localhost (dh207-40-94.xnet.hr. [88.207.40.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df949sm168711466b.121.2024.11.01.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:17:08 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/2] selftests/x86/syscall: fix coccinelle WARNING recommending the use of ARRAY_SIZE()
Date: Fri,  1 Nov 2024 12:15:23 +0100
Message-ID: <20241101111523.1293193-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle gives WARNING recommending the use of ARRAY_SIZE() macro definition
to improve the code readability:

./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING: Use ARRAY_SIZE

Fixes: 15c82d98a0f78 ("selftests/x86/syscall: Update and extend syscall_numbering_64")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1: initial version.

 tools/testing/selftests/x86/syscall_numbering.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 991591718bb0..41c42b7b54a6 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -25,6 +25,7 @@
 #include <sys/mman.h>
 
 #include <linux/ptrace.h>
+#include "../kselftest.h"
 
 /* Common system call numbers */
 #define SYS_READ	  0
@@ -313,7 +314,7 @@ static void test_syscall_numbering(void)
 	 * The MSB is supposed to be ignored, so we loop over a few
 	 * to test that out.
 	 */
-	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(msbs); i++) {
 		int msb = msbs[i];
 		run("Checking system calls with msb = %d (0x%x)\n",
 		    msb, msb);
-- 
2.43.0


