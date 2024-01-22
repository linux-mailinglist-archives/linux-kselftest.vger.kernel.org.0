Return-Path: <linux-kselftest+bounces-3322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E56836BFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6211C2643E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288435DF02;
	Mon, 22 Jan 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1qF88TB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DE5D8EF
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937352; cv=none; b=Ntiny5s6NvkreQMAPF9rQ3t8m4HMlI6lpEisg4rTJggVKHLvaRboEzvxqfBLDWoYraaU2/tLfkOC+IgcawtlBph2zu+3IQgAiF7eGAYKVSi7Z5zOzYB0zeLfmFEq8X/Hz02W3KZ0GAOrtph8hCEuqzkKpeCLJfwzDjaTAyki0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937352; c=relaxed/simple;
	bh=swTmNq0vnWu0kpV/NiNa/0cxrTCIc+fzejGlFfJRJFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKWT80/ds8VKICwilYSCY9untpSeKXC8RJNbAce0v3v3Yxg9t5FAuhu3CPS9bbAeUDmq3HeF9eSqEELHLgaFNUmJqPXKmNF7t/vjAMkehAYxbDcXccdM4aKPxO13BNLKHirgPT71/cKXLOpGtddluWFpvG9gCdPrp/+Sc0vASmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d1qF88TB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so599356a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705937349; x=1706542149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1nXFBm8Wq9fX7ppYWScs7k2sQNa6wcd9LyWfOMZwQs=;
        b=d1qF88TBJdtqXC4XVQJinGyGJ2Mh6cZGqEPeDAjSRStO7ayLvlTXYx250lRg3tf83M
         67tfU9VXJNeFrEcOiISnrLsGuYnM09ddw3F2FibK7WKZacm3KPqMMPibXULefyBG6x2d
         qrS9TtAjeAgzHOdS6VnAmRxCHJOxEaO+X2Pgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937349; x=1706542149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1nXFBm8Wq9fX7ppYWScs7k2sQNa6wcd9LyWfOMZwQs=;
        b=JR75MTYzm2mR48v3dtlHswRxA0vUemS3qu54ongQSC3ylXQ0c/NMyiFV9ooA4LCtpw
         D9/lsu0W8pl/iZcI7BKY23WHFC95vSmXgnFU1W3laFUuiiZ+hVi+DGAOHkXU5xWrOMTg
         iM6NwtKS2ISbCRt70qMm18BPN8kpDWMTn1QOu0gwPLv8fAZK+PmenlvlnVa/YbVBA/Bz
         fHzQhack6jJuwIuV6uT9iXt0lgBEX4FvKHEJohZ6dEous1e89cC27ThqlVjpMnW0XyVL
         R1TFtUMWExnqJrN58IoD4mgaPIjidBcT1H2sJMLlpCFLfdPRJoIEL7c3Nqwiq2euQol1
         v9LQ==
X-Gm-Message-State: AOJu0YxWeMffnT+dkpgQOaNaNmhwNcyP4zbWVWgy5z0Sl29MwgvaqexE
	7077iB7Bq6433kfR2OXGmU625VgWr9R0DaTrpX0iv2koZbCi/JdZIO75KwNOVw==
X-Google-Smtp-Source: AGHT+IHeHeb65t+VJYqntENsZi5Hu4wtarN33a34Ye/qpiXFiCACGG0yxUCfuTgCve1300tEYccgRw==
X-Received: by 2002:a17:90a:9e6:b0:290:34a0:212 with SMTP id 93-20020a17090a09e600b0029034a00212mr1363174pjo.40.1705937348991;
        Mon, 22 Jan 2024 07:29:08 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm9552273pjb.37.2024.01.22.07.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:29:08 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v7 1/4] mseal: Wire up mseal syscall
Date: Mon, 22 Jan 2024 15:28:47 +0000
Message-ID: <20240122152905.2220849-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122152905.2220849-1-jeffxu@chromium.org>
References: <20240122152905.2220849-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Wire up mseal syscall for all architectures.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/uapi/asm-generic/unistd.h           | 5 ++++-
 kernel/sys_ni.c                             | 1 +
 19 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ff110826ce2..d8f96362e9f8 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -501,3 +501,4 @@
 569	common	lsm_get_self_attr		sys_lsm_get_self_attr
 570	common	lsm_set_self_attr		sys_lsm_set_self_attr
 571	common	lsm_list_modules		sys_lsm_list_modules
+572	common  mseal				sys_mseal
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index b6c9e01e14f5..2ed7d229c8f9 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -475,3 +475,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 491b2b9bd553..1346579f802f 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		462
+#define __NR_compat_syscalls		463
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 7118282d1c79..266b96acc014 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -929,6 +929,8 @@ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
 __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+#define __NR_mseal 462
+__SYSCALL(__NR_mseal, sys_mseal)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7fd43fd4c9f2..22a3cbd4c602 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index b00ab2cabab9..2b81a6bd78b2 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -467,3 +467,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 83cfc9eb6b88..cc869f5d5693 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -400,3 +400,4 @@
 459	n32	lsm_get_self_attr		sys_lsm_get_self_attr
 460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n32	lsm_list_modules		sys_lsm_list_modules
+462	n32	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 532b855df589..1464c6be6eb3 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -376,3 +376,4 @@
 459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
 460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 461	n64	lsm_list_modules		sys_lsm_list_modules
+462	n64	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index f45c9530ea93..008ebe60263e 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -449,3 +449,4 @@
 459	o32	lsm_get_self_attr		sys_lsm_get_self_attr
 460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
 461	o32	lsm_list_modules		sys_lsm_list_modules
+462	o32	mseal				sys_mseal
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b236a84c4e12..b13c21373974 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 17173b82ca21..3656f1ca7a21 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -548,3 +548,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 095bb86339a7..bd0fee24ad10 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
 460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
+462  common	mseal			sys_mseal			sys_mseal
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 86fe269f0220..bbf83a2db986 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b23d59313589..ac6c281ccfe0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -507,3 +507,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal 				sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 5f8591ce7f25..7fd1f57ad3d3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -466,3 +466,4 @@
 459	i386	lsm_get_self_attr	sys_lsm_get_self_attr
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
+462	i386	mseal 			sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..52df0dec70da 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459	common	lsm_get_self_attr	sys_lsm_get_self_attr
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
+462 	common  mseal			sys_mseal
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index dd116598fb25..67083fc1b2f5 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -432,3 +432,4 @@
 459	common	lsm_get_self_attr		sys_lsm_get_self_attr
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal 				sys_mseal
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..d983c48a3b6a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
+#define __NR_mseal 462
+__SYSCALL(__NR_mseal, sys_mseal)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..d7eee421d4bc 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -196,6 +196,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(mseal);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
-- 
2.43.0.429.g432eaa2c6b-goog


