Return-Path: <linux-kselftest+bounces-2753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A797828931
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DBD1C243FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA6839FF9;
	Tue,  9 Jan 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCjpjh/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C839FE7
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jan 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso14160275ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 07:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704815162; x=1705419962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3ohwHzq/4+GvsXCviFQR9Ej/i5Rnl+U+9CFpvV1sg=;
        b=NCjpjh/iCaA3heLvOS3B4E7Fe4On1CzMaoruY7djqUt71I5ikyNI9ZNgp2VObGucxQ
         0XhtPKF5oh/VANmRcpxV0xZ5/fwZpQJodMgonyro7eoJbSTq7tFrHWBj0z7NhRw4dTCB
         uzFkzgURPuiwWHjzEVeVVk/HjeQiRP9Xn83MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704815162; x=1705419962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig3ohwHzq/4+GvsXCviFQR9Ej/i5Rnl+U+9CFpvV1sg=;
        b=rJiruapgKlkjnr5saYJPmcUduHpTHVc/H1D9aViguUAu40SvchK+VVHrU9OkxZuQO0
         gxzmUcjDPuZutspB/Pi1ODZA+L9EQJpKWnrszzq/HFz7edJZeUwYEcdZv1JTs+piQTGS
         C8rpzVT88tfLOPwwlV54uETvzQ+7KI+W+tH8d+pb6mJHDTraoMY7av/T9+5ujLup6K1R
         CUVeWtg2+l3eYvTaxhaLVeNkw1HnJgbGSq+Q1PnYt8ANCLYvJPQO/otj0tu3/PMV6Jtn
         3eIUnpRtNCbr5VaMI6whA0vPjxZHqiuRIEAsz1MD+1C/bCebDNAV82qIfpEu0WTe/8hj
         KN8A==
X-Gm-Message-State: AOJu0YwuImeBv9+gpRAMI8PvnI9+MYpEGfU2j0q/Je5q269XapdtKlHc
	vbO689pZmA5ipj4Dx9sQmkIhupxok5E3
X-Google-Smtp-Source: AGHT+IH4k0ufyA+hoVXReRKZGJVZrKy5Y1nbuBoicBfPXBbSt8cSLBYs3HNIHxmv1p7vZ518XLU4cw==
X-Received: by 2002:a17:902:b405:b0:1d4:133d:6ace with SMTP id x5-20020a170902b40500b001d4133d6acemr2714492plr.7.1704815162231;
        Tue, 09 Jan 2024 07:46:02 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id j9-20020a170902690900b001d403969b65sm1939344plk.187.2024.01.09.07.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:46:01 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com
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
Subject: [RFC PATCH v5 1/4] mseal: Wire up mseal syscall
Date: Tue,  9 Jan 2024 15:45:39 +0000
Message-ID: <20240109154547.1839886-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
In-Reply-To: <20240109154547.1839886-1-jeffxu@chromium.org>
References: <20240109154547.1839886-1-jeffxu@chromium.org>
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
index 18c842ca6c32..dd92e2639a03 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 564	common	futex_wake			sys_futex_wake
 565	common	futex_wait			sys_futex_wait
 566	common	futex_requeue			sys_futex_requeue
+567	common  mseal				sys_mseal
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 584f9528c996..d96461ee1ebe 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -470,3 +470,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 531effca5f1f..298313d2e0af 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		457
+#define __NR_compat_syscalls		458
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 9f7c1bf99526..e3118e0327c7 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -919,6 +919,8 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_mseal 457
+__SYSCALL(__NR_mseal, sys_mseal)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7a4b780e82cb..105e966db655 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 5b6a0b02b7de..18956345d348 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -462,3 +462,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index a842b41c8e06..06cac28209d2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -395,3 +395,4 @@
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
 456	n32	futex_requeue			sys_futex_requeue
+457	n32	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 116ff501bf92..bb8270588953 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -371,3 +371,4 @@
 454	n64	futex_wake			sys_futex_wake
 455	n64	futex_wait			sys_futex_wait
 456	n64	futex_requeue			sys_futex_requeue
+457	n64	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 525cc54bc63b..93958f063c3f 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -444,3 +444,4 @@
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
 456	o32	futex_requeue			sys_futex_requeue
+457	o32	mseal				sys_mseal
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index a47798fed54e..c6bc9277dcd7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7fab411378f2..2947c4caf22e 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -543,3 +543,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 86fec9b080f6..2400a0e91883 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
+457  common	mseal			sys_mseal			sys_mseal
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 363fae0fe9bf..6768e43c5d23 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7bcaa3d5ea44..4285465f7e4b 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -502,3 +502,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal 				sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..e4e3b2097658 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	mseal 			sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..03cff8a24726 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457 	common  mseal			sys_mseal
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 06eefa9c1458..3c87cf0424c8 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -427,3 +427,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal 				sys_mseal
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..9b2b6a4a80b6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -829,8 +829,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
+#define __NR_mseal 457
+__SYSCALL(__NR_mseal, sys_mseal)
+
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 9a846439b36a..02280199069b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -193,6 +193,7 @@ COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
 COND_SYSCALL(cachestat);
+COND_SYSCALL(mseal);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
-- 
2.43.0.195.gebba966016-goog


