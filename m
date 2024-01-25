Return-Path: <linux-kselftest+bounces-3539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6383BA08
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F866B2721F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3D1C298;
	Thu, 25 Jan 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MYXk6NVn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B8111B6
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164227; cv=none; b=oitOKnbr2H2XcdO2KETZ9+CAbOt59ABSUIa45kUUj3p+Z3cZ99eDr3nsz6+XcEh8hnKNWkCGqLBJX7DUYCAaahx3JmrtDynMh834GLrLRUDF+EEIs96R6swAUd7HaLjGSBp0Yy8Zj/S1K79XK/2TUXT3KPeMbf/cafL12vmtYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164227; c=relaxed/simple;
	bh=8SEZffN6M55aEq8BfU/L1CS/5dnnMiqMpO6bLOo2noo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8QRy1FgCikel1GuR7uIUrBTWB5yC/nZp+A5lRUJ4esj4ht0b8zdRS8iHWOkXS63yXE9oxuJ+/CFjikUdFz4UqkroRSJWkhGZ/G+p4LqNzB/5M0EZriVkokjVPwq8k6egx6da7BBHevpVyseIIuZ9K2NFlVodkb2B3JLnD6VrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MYXk6NVn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6daa89a6452so4539042b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164225; x=1706769025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6BBG9hVElQCtGiSKaNMQBT766TrVfR9hP9RPboZviE=;
        b=MYXk6NVnOPnDZAWuuC4793qeNRvj4kKLmPjfnPTReW9tZ+xEzIc+16Xd6OAzVXLO/b
         20mpJ4OCrelAh9n3UqbodEzkcYXOUDETfjXZHJMLBVA2TjEEHQjknuBKX+O8Lvb0zjUN
         iTVZuzAzsss2RNNhfwAIaMJ0Y+i+3OyIebZapq2YQ3zjohmjn3eZ21cZ5P+g3JrBbOOe
         c6C/JrsFEM31GL9aPEKVYvTLhWWNEdi7QjHToulEHL3eaYixHX6oLow38aEg5JnuqE2I
         Uxe/ITT7CQBkXCYvs9QfXnA/mt8XZg6mJCKPf+pq7p7xMQTPTUGScLi7G8QFz1k276c3
         HMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164225; x=1706769025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6BBG9hVElQCtGiSKaNMQBT766TrVfR9hP9RPboZviE=;
        b=HjT2qxquxEBoLaHS+r1uczWP9odswNv/u6cpMqVFvW/x2l1kObyl+hUeHaY/X7OQqI
         Tvw4903kYxEkM7m9iyuRlFqW6eiM6uvM4HPGRyOp2D8+X0BgrlWc6SNeF5NMozsi9e/k
         5b8sjAzLsqPmVOhfGoqC0QgSKjynpkgaDUNdkPugrgxkIae+MQ/oPf70FKAw1j2l+QaQ
         BpMAtpfMsqRG6qky6N7/0QBzBjXirMi5wXkqYrB274bBAXGmyHRL3f9+g3Fj1IIuF3Xo
         Nzo+ZbmYmCoQo3f1/ZENHBDa5od8moHNFjrextxVrcIY1rxC76DVZVRJPdwbcjCW6v6V
         t0Cg==
X-Gm-Message-State: AOJu0YyVaRb/NqTy0zB+8wXazpUtuhzlblke6WSZqokXigzVRThXqZ5f
	Q7o+xVxSpmxTnIqvvyX+Dnuvm4+D+rbKuS3oMfT6SH11IpfB+PveFXiF+2MTd1g=
X-Google-Smtp-Source: AGHT+IGPdTEWV7DVpyBSBSm0VXEKez0sh3BLdrU06vyzOddQ2bIPsNpxM7VseJi4GIrXrQhafpjvgg==
X-Received: by 2002:aa7:88c5:0:b0:6d9:9afd:82f9 with SMTP id k5-20020aa788c5000000b006d99afd82f9mr284323pff.51.1706164225355;
        Wed, 24 Jan 2024 22:30:25 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:25 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 24/28] riscv: select config for shadow stack and landing pad instr support
Date: Wed, 24 Jan 2024 22:21:49 -0800
Message-ID: <20240125062739.1339782-25-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

This patch selects config shadow stack support and landing pad instr
support. Shadow stack support and landing instr support is hidden behind
`CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires up path
to enumerate CPU support and if cpu support exists, kernel will support
cpu assisted user mode cfi.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9d386e9edc45..437b2f9abf3e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,6 +163,7 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select RISCV_USER_CFI
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA32 if 64BIT
 
@@ -182,6 +183,20 @@ config HAVE_SHADOW_CALL_STACK
 	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
 	depends on $(ld-option,--no-relax-gp)
 
+config RISCV_USER_CFI
+	bool "riscv userspace control flow integrity"
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
-- 
2.43.0


