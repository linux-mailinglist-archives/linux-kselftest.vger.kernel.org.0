Return-Path: <linux-kselftest+bounces-1759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABB80FB27
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D023B20E50
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDE64733;
	Tue, 12 Dec 2023 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JveXj9O7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C72B7
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:13 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so5569935b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423033; x=1703027833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YF8gInYyKnjLyYVifyCViAm+ORlRHRAbg0UC91NVL0=;
        b=JveXj9O7DrMtVI6EPYNPmCyQRpnbxLDOhltqcF7+JB1Mj/2fPZVbqn3rHV/mDTKqto
         oq9A6Jrp3IpCXOYSFlMzA+YHd6jLv7dXk5x3n6Qri6rtHqhjf3nihi1/0kjx3w0qZdjK
         B9bMPguq9e8wEUUPgwmqrD0kB82X4Bo8Agkuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423033; x=1703027833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YF8gInYyKnjLyYVifyCViAm+ORlRHRAbg0UC91NVL0=;
        b=Z4z0bg26TdVC7srNt0Ok+qCQf3V6xVKK73HUzvIPbdRiBvXL8crLSPpa5q9BjDY6DT
         J6dYfULIaBx/9aegPGRHOPcDP9aam0miZu3KrKIRXkAIPgtBRkGOIejUk1/X+MZUgwrZ
         +jegaklTOTpQiQ4CvDEgymUJe2AFk1Z358qQjHPMDrFsB/uGNmbdAX87JqfSRGMuPlGe
         opEUi44lHRfZs+B/5mymvazT2GAtVsyEdPpbHVtS2AEuTgs8A3TE0Qq+Ij8so4o9YKbL
         pq/9/BHhvJr+zHDLTZt1jetgHrBwQ9wl4RGRaGnGCmbW0cjnWN+YqJw/aH/ao9wONhKE
         lMhg==
X-Gm-Message-State: AOJu0Yytpo4p//SQCbK2UHVZtYG7fhSmNttVAWBqWnaVYGbJNCX5uvlI
	UWsHgiC5/Gcpb+ydZCH7Svq+/g==
X-Google-Smtp-Source: AGHT+IGEdvNtjL7vVDPGkLMDHm2ntWIQ9rfmcT11m+WtWcnAGDujtZ9MEI7HDfwGIcXn8coPiQFtiA==
X-Received: by 2002:a05:6a00:2d1b:b0:6cb:bc92:c73f with SMTP id fa27-20020a056a002d1b00b006cbbc92c73fmr7494441pfb.2.1702423032923;
        Tue, 12 Dec 2023 15:17:12 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id m26-20020aa78a1a000000b006c988fda657sm8975614pfa.177.2023.12.12.15.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:12 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
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
Subject: [RFC PATCH v3 02/11] mseal: Wire up mseal syscall
Date: Tue, 12 Dec 2023 23:16:56 +0000
Message-ID: <20231212231706.2680890-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231212231706.2680890-1-jeffxu@chromium.org>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
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
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
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
 19 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index b68f1f56b836..4de33b969009 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 564	common	futex_wake			sys_futex_wake
 565	common	futex_wait			sys_futex_wait
 566	common	futex_requeue			sys_futex_requeue
+567	common  mseal				sys_mseal
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 93d0d46cbb15..dacea023bb88 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -469,3 +469,4 @@
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
index c453291154fd..015c80b14206 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -917,6 +917,8 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_mseal 457
+__SYSCALL(__NR_mseal, sys_mseal)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 81375ea78288..e8b40451693d 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -376,3 +376,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal 				sys_mseal
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f7f997a88bab..0da4a4dc1737 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 2967ec26b978..ca8572222783 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 383abb1713f4..4fd33623b7e8 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -394,3 +394,4 @@
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
 456	n32	futex_requeue			sys_futex_requeue
+457	n32	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c9bd09ba905f..aaa6382781e0 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -370,3 +370,4 @@
 454	n64	futex_wake			sys_futex_wake
 455	n64	futex_wait			sys_futex_wait
 456	n64	futex_requeue			sys_futex_requeue
+457	n64	mseal				sys_mseal
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ba5ef6cea97a..bbdd6f151224 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -443,3 +443,4 @@
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
 456	o32	futex_requeue			sys_futex_requeue
+457	o32	mseal				sys_mseal
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 9f0f6df55361..8dda80555c7c 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 26fc41904266..d0aa97a669bc 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -542,3 +542,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 31be90b241f7..228f100f8565 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
+457  common	mseal			sys_mseal			sys_mseal
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 4bc5d488ab17..cf08ea4a7539 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal				sys_mseal
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8404c8e50394..30796f78bdc2 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -501,3 +501,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal 				sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 31c48bc2c3d8..c4163b904714 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -460,3 +460,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	mseal 			sys_mseal
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a577bb27c16d..47fbc6ac0267 100644
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
index dd71ecce8b86..fe5f562f6493 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -426,3 +426,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	mseal 				sys_mseal
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d9e9cd13e577..1678245d8a2b 100644
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
-- 
2.43.0.472.g3155946c3a-goog


