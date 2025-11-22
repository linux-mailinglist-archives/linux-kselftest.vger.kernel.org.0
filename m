Return-Path: <linux-kselftest+bounces-46306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC55C7C839
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 611AD360392
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B52C325C;
	Sat, 22 Nov 2025 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wn6QIkGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F62BE03D;
	Sat, 22 Nov 2025 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790691; cv=none; b=qD74TVHb6s4DA8dIEKgE4WAVUQFeJRevB5FBHWE83gRLlnMom3DiMc1TWt3XK1G9Kg0CQjLRCOY8SjEsKVPAotx3xfRpryIUgs/ObyOaGCiJjRENQyJYH8BkqIsqa8QpebSluM7LghJRXv1yX+Mnwe0MQLDKDTHWSugQbdyqi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790691; c=relaxed/simple;
	bh=hbNXjpY847J9gIEo/zUHDT1s0Qd3MFk6DEAx759fcDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rF8ghrfMhSRB1MlnPPGRfJYKhDjyHgV84iJ8gIUg6QzuBZZNiSigxKr9n+FDNDOqo35ZcnPhvqp281eM6HxZ+D6DOgwYuPHYdngvD9Lwh6iajNvrP0/ijsiSARPDlBRueCkASgISiKZ6wVkXDp/DboE1QssY6sUg6ryeJTHhUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wn6QIkGZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oMl8VKqo68dtKQI1fBQMiaA54tMMEUZSj8LxMeoI1/0=; b=Wn6QIkGZak159bCkfkYXOOAltI
	FgAT9KU1syCjCS7HeexwhS6IAagZhJMgGd811x0omMxGZawSlwqWWgc3xPkJRXOy2ACA7ez0pY7yc
	oLcQ1VRnf771PKnwa2KTUbGY3M8/KfbyKrTW6RG7SaeSWv/nTz3oDmMqbhRHoJOFo/w0HGx1mR2pn
	Uy2sXLspaZWi9WDHzgk5nWRw3GqICVG0xUg3YuUbKsfXwWDtcnL+f9H+WVnK3ArmmkfI6ajk7jaQC
	shiTGEy0Q0VDWMC3oSwYinmkSpEidZfum33az937jwCC6mp/7E9nU5GpEwnOTpjhHsrC/7eBkNeqN
	eyBJYXyw==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWs-003xEt-BA; Sat, 22 Nov 2025 06:51:26 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:48 -0300
Subject: [PATCH v6 6/9] futex: Wire up get_robust_list2 syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-6-05fea005a0fd@igalia.com>
References: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
In-Reply-To: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Wire up the new get_robust_list2 syscall in all available architectures.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
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
 include/uapi/asm-generic/unistd.h           | 4 +++-
 kernel/sys_ni.c                             | 1 +
 17 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index d0cb7b902cc6..b4a42beda6db 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -510,3 +510,4 @@
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
 580	common	set_robust_list2		sys_set_robust_list2
+581	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 910e6e14ccf0..d4a4d8446cb0 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -485,3 +485,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index eee3f320483d..c2f1c5a3313c 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common  set_robust_list2		sys_set_robust_list2
+471	common  get_robust_list2		sys_get_robust_list2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 6c69d8ebbc38..1389dd194eec 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -476,3 +476,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f70db3741b0e..e149d2ddbc2f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -409,3 +409,4 @@
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
 470	n32	set_robust_list2		sys_set_robust_list2
+471	n32	get_robust_list2		sys_get_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 9480488f9495..7ddddc89a751 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -385,3 +385,4 @@
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
 470	n64	set_robust_list2		sys_set_robust_list2
+471	n64	get_robust_list2		sys_get_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2761c9cd8946..c0a5ebafed1a 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -458,3 +458,4 @@
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
 470	o32	set_robust_list2		sys_set_robust_list2
+471	o32	get_robust_list2		sys_get_robust_list2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index eb37fda5c48f..4c6cb64ec113 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 472bebec449d..1475fa6b3ee3 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -561,3 +561,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+470	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index ba7fac304941..b8161ee922ef 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
 470  common	set_robust_list2	sys_set_robust_list2		sys_set_robust_list2
+471  common	get_robust_list2	sys_get_robust_list2		sys_get_robust_list2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c05c94a742be..566baa152634 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -474,3 +474,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 3a59f3008325..fb3844c17711 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index e9d6e1a1d777..0df93458ef37 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -476,3 +476,4 @@
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
 470	i386	set_robust_list2	sys_set_robust_list2
+471	i386	get_robust_list2	sys_get_robust_list2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8fdcf090300d..e7fdcc3d6e52 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -395,6 +395,7 @@
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
 470	common	set_robust_list2	sys_set_robust_list2
+471	common	get_robust_list2	sys_get_robust_list2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index d7bb6b9104dd..bd63dbc78c0e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	set_robust_list2		sys_set_robust_list2
+471	common	get_robust_list2		sys_get_robust_list2
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 44fc87287983..9539e893c9ac 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -860,9 +860,11 @@ __SYSCALL(__NR_file_setattr, sys_file_setattr)
 
 #define __NR_set_robust_list2 470
 __SYSCALL(__NR_set_robust_list2, sys_set_robust_list2)
+#define __NR_get_robust_list2 471
+__SYSCALL(__NR_get_robust_list2, sys_get_robust_list2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 471
+#define __NR_syscalls 472
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ca2cfe69b11..0a7f7634446c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -173,6 +173,7 @@ COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
 COND_SYSCALL(lsm_list_modules);
 COND_SYSCALL(set_robust_list2);
+COND_SYSCALL(get_robust_list2);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);

-- 
2.52.0


