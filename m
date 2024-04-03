Return-Path: <linux-kselftest+bounces-7131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43C897C3F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FC1F27A54
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B311586CB;
	Wed,  3 Apr 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WSPS38vq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30A158212
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187713; cv=none; b=NKlA628+mi7e7xYlfkSpzcLyfnXGw+pdZRfTBZF6sWCoJgrnGn+kMMzf+mUoF1fM83YdmRMqgXa5eU10JIPNOAr8jvin3i2hJmKMTT2lIOrwgvercyNq0fHxmaj/negWL4ojVXOyxdbvO1ZI5tEDECOWitW+l5jvKpuD5VyUP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187713; c=relaxed/simple;
	bh=ZshD/5wywYZOoD7/u3SYmOTR2SIaMjHKlWumK97il8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pilfvmXhDtLSUvHc7C//2EncrxIPc+WqcnQUPezq9vKSR0AOSMdoc6h2QeuawiiFP4ourVk5JGZ/WB32iMmnQO18vTFsyU2bRFI+TvS+Ro7KCrVVoU+RZSsD1KLmjA2O2x9I+JZ+RaD1DfssMteSG3CMrR1WJ3EsPVuxqzYVVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WSPS38vq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so358438b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187711; x=1712792511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABpeeFCkULjAH2+wvqdO28185Mvpk++2Yk/j/QF7GJ0=;
        b=WSPS38vqE0RSmCl5/mHAvxiYjuUqgkGN16SPOi53Pz9owOm/JcFZbEz2PZvKqeI95x
         6XnfV7ymNpxe20jOM58dR5YcNBEMy+tPWOyB6tTt+UkxAlesgvrNw3fEa6KjACYnntZf
         dNC8QEjvD7luxmLJ7Dtf8pZt3/acLsD2iuwUm/3+SW3gz3IY8BF3z6TuISWsn0fTvq63
         Eh3IfdEKTFZ87hO9mpy/jdtnbBlyDldcnMK2F6mTh5LYDPztWFahuho+HqvbfOCGyqQu
         eYW7RP+KOMKHbq9WjsxHwTJ9Xjz63VM8JrVJZGdL5pagF5qxXl3wIRBW47ylxN9kPbVZ
         g6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187711; x=1712792511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABpeeFCkULjAH2+wvqdO28185Mvpk++2Yk/j/QF7GJ0=;
        b=MC2WnsIVCtxnkiznWyyXbCDnxz0+wKwZgzNkJRsgRh93rCFlWsBFZx93rvwtbvhuID
         cgxO9SH4abTJZ41IQIq1G60vWo8hVjmsetnq/E/wfTsvlU2JfGiB1qvr8rtw8lWFlGn4
         n33SdF7zJhKtBwXeL84PPdivfMmFeU1vHOuoUbRptnhWWT327vNPXnGPTUIOw9zzGIL/
         4yLraCSBhAhDvf9FjafndvOh7av9bf8LMMobch0tsfwxFCyDwVIokv2C7DUR/3QS1m6z
         CaFhkmx4mi3Ol1/x4Fl+6gxpGiGgiTtbT8b1FYf39Rm2ELmbFzjVxj4JYFf6ipsEo5Q1
         dB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPSsk+IoIkJYM77zfh+K/YZ7FzEAKXmUK2fFLVPwqjQLVszAo9T5uUq3ozut+dl7w0ldesIxptmBs4XHQugYPE5psjTS1HdVsG0fFX3Kr/
X-Gm-Message-State: AOJu0YyY8Yu5zs06MgxnF/oYgyHZOTFVpmZaqlSQzjcmaEkseO+OnY7j
	7ceBTQUPibBUbZ5nvh0ljULE2vyvnWPMPmVBUfqS4VcIpUF0rbaQ+89sG5FmPDs=
X-Google-Smtp-Source: AGHT+IEuPdJ9+VZyZuaG1MlOsTEyLTpxiJH28qDOFi58HVozeCfEc+yN58hPfTIqNV3cM5o/KXJ7iw==
X-Received: by 2002:a05:6a21:339e:b0:1a6:f8cf:1e23 with SMTP id yy30-20020a056a21339e00b001a6f8cf1e23mr1102834pzb.41.1712187711360;
        Wed, 03 Apr 2024 16:41:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 08/29] mm: Define VM_SHADOW_STACK for RISC-V
Date: Wed,  3 Apr 2024 16:34:56 -0700
Message-ID: <20240403234054.2020347-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VM_SHADOW_STACK is defined by x86 as vm flag to mark a shadow stack vma.

x86 uses VM_HIGH_ARCH_5 bit but that limits shadow stack vma to 64bit only.
arm64 follows same path (see links)

To keep things simple, RISC-V follows the same.
This patch adds `ss` for shadow stack in process maps.

Links:
https://lore.kernel.org/lkml/20231009-arm64-gcs-v6-12-78e55deaa4dd@kernel.org/#r

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 fs/proc/task_mmu.c |  3 +++
 include/linux/mm.h | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..d9d63eb74f0d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -702,6 +702,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_RISCV_USER_CFI
+		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..64109f6c70f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,7 +352,16 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
-#else
+#endif
+
+#ifdef CONFIG_RISCV_USER_CFI
+/*
+ * RISC-V is going along with using VM_HIGH_ARCH_5 bit position for shadow stack
+ */
+#define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
+#ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
-- 
2.43.2


