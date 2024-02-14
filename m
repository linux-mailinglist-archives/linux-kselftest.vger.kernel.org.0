Return-Path: <linux-kselftest+bounces-4635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1536854C41
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9876728CEC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4735D475;
	Wed, 14 Feb 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIrBx5Sb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D765C91F
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923511; cv=none; b=PifeHhsXdQFEAA2vC7Uid4biejTBK+1sKXsXj6nuk2jX2mt65vGcsQB1O0VOBZMaFrI95ezfHQIzOHzqSbaMTuDkw3pToIOCLceGgSyeEvHv69Sy6PoTyDvN8ST/P6OUAmodQYClkbU0tEwgkV9E4VrZJNyp0li3Ycc/pz6dq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923511; c=relaxed/simple;
	bh=GDzQykRFSAgPeZKp+9RbLxV312AhYtbasVd13eQzY9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI19jh/vBvi89YaNopbB2FJo1R9wuLplKiBAb/ir2SMXLE/ryQlAxCXsJ5ysLfgh5KVNvZ/7+gf6Vm2tofjGniWiCkEO9zEMQE1PM7fmetJJInIw5MtSjLphBoJbXq0iQw9pm/dz1sbgw8wONWAjRMyOdMXC1o2zAXDzdcNE9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kIrBx5Sb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4580670b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707923508; x=1708528308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyb07WA/Fa4EDQGJFH9DvLqt4UfHMLv3rZ/vOhJvFvw=;
        b=kIrBx5SbmG952KBmOk4TaQX3v+IvLVT7eLRMhP6CfTtbuNOn2yTR35NGTSVWw76/nP
         QYvxrO0kYFdqmg7TkaytdJdVzxzkVY+JFq1FyTa02sH9l7EuBcaa1Diki1NcRE1O36oL
         zRvzmDfmfvpzw6eid2JL5YHMXUtwU7KRk0kFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923508; x=1708528308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyb07WA/Fa4EDQGJFH9DvLqt4UfHMLv3rZ/vOhJvFvw=;
        b=aEPMxwzLXwZPAu/GApL8RTVS1MK/FPFiOuGlff+I/RjcQqS+H0dfj2toSY+akke1wN
         ERx1Es/rq0QkyxMSnmFp+pDpK4SU8Kt6PHCde6O86zhkT0Owc7I1b3JU+TgXWWRusdmJ
         mItx0R9wpvTxbRX3+4JXkcw0iehbbyiPGjm55gog1qQ1Dy4vjzIZK012kvgAG0fzq19W
         ol9iNuFEAV3xEdXR1BZKWPCCykTVxsG1MnFzbOmdXs13x6inAPRd3/jI7EjjTkb/Sl/5
         kdsW+38F0KeX+2JeyijW235AzObBSnpC9P0TOuXK8gXGLq7mKUmdzKuT4bxAC0CuGl7f
         A+5w==
X-Forwarded-Encrypted: i=1; AJvYcCWncgiw2QCLKuOqNoluCXm/3lqvWnY5y8W9YRtId/4rc5FbFkVOqfPu/6NDbZeJUSfovHwjz5a2DO6prUMxtgjFIf3P+XvWDVgPWbXdTc0L
X-Gm-Message-State: AOJu0YzhFGokKeBCQf16L48mDwJhv2putE67lfLOQBrOqMVWy29sbaNC
	S7OpvhLN+wBR6fZqkFdPFm+y9qw9ODZo2Uy33WNFEv8Zy1+Sa6D2dUBDXtQj5g==
X-Google-Smtp-Source: AGHT+IEQn6gKe2uy3qp2k4gTLytGRcciiyOJisT9ZpuZkd3jt59Gly35159q3GnBguql9UHK6e2Pug==
X-Received: by 2002:a05:6a20:e585:b0:19e:98a1:1160 with SMTP id ng5-20020a056a20e58500b0019e98a11160mr2318980pzb.28.1707923508184;
        Wed, 14 Feb 2024 07:11:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN+6ILCfU4IwdUf7PPQHT08mrAXEzxk0cdVewn0j3U13RbJ7fFu7UUEAqRms++V13xRFZEvWWse6uj9D2R8or/0t1OFOygbt9TeVj5J1rGEbgteP1kFQBZ2augSHKkmE1+WuP0R+YSBZXOSMZcWwCw891OK7Gfdy87u53rcL8YNZAJByKFzuOOVjhnjT0mm1d5iujY96F6R3rpdvGvBrmHlMW+i0urGf6hhh6ZkPCQ92ZYqH9VjNkCBhEOUKL0lHzaySHwTBp6dNh0COCm/laOuYtWz0ws0x7c8V/gAbbER7HQrTout7rptJoUawBMhEQWW7lDzIStN3izx+chLm/6oolgaB9Hetx8ESgm5nTlbTVBrPnKhEcx39+1xJd/VgsEaTZVrR9Xb9H99NQclwcZzQmmvPOSTCVknE6TCD6HjN6Cl8rksXOst8EM+/Kn2myzY0Hy99hyHsY+0qNT/khpBr8vCkV48WthLj96geK5XOFTCxLHxMzuADfCmMdHSfXFX6fpyMBb2jau6uC60j4iUO8gms4WvKIvN+ku3BBqXSFbcyqq7s1bemn3hubMB3Y1fNcxQNqA/gMUrMoaO4qn34DyQmh9rQmNFV6al6Vs2QN2ZS3kM5vNKvPTujKDpzZMJtH0Uenc8fSgshPzLJcGY+DPMaJ3njtuvePgVs3prXx8v53HsIyaOM5q0CUZ03LbLlRoLj2aodCHHNEMMPGE0AfS2TUb7iYriC+xyMK2UTryroRxf9db7Kc3d+3OKntKNCdPvQRIpDd3aXBAEu4XiJE=
Received: from localhost (56.72.82.34.bc.googleusercontent.com. [34.82.72.56])
        by smtp.gmail.com with UTF8SMTPSA id ka30-20020a056a00939e00b006ddc03c425bsm9408064pfb.180.2024.02.14.07.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:11:47 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
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
	=David.Laight@aculab.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 1/5] mseal: Wire up mseal syscall
Date: Wed, 14 Feb 2024 15:11:25 +0000
Message-ID: <20240214151130.616240-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240214151130.616240-1-jeffxu@chromium.org>
References: <20240214151130.616240-1-jeffxu@chromium.org>
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
2.43.0.687.g38aa6559b0-goog


