Return-Path: <linux-kselftest+bounces-7134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4FA897C4E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605211C2169E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391E158876;
	Wed,  3 Apr 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qin+KnVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281F158868
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187721; cv=none; b=Kl9iZX21Q4pTT43okhipylSHg10sCTpEbEVsOhqCOs2215efaEpdOgHO0RmExjTc3Vhnl0aQ63Qf722TGsV2mYDlierVchRgB0IBVPBV5rGZ4IJKfPkzpXEenoprs2EGfM36xvhhLoVeTSKoe3RG5+eLrGhHiQYCZ5aQnDz6Dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187721; c=relaxed/simple;
	bh=CNl3hprkQqVLkBFECp9sssqM0vv7IwZGZ7tM7RPw44k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzVaJOkM0ssLI2QW8Lgp2KEtR6DPUtA0I9QCBSfkfyxRh45N4F9onTWxDaZ/Oxm6n/qHeH2uIzxs4SYNrbGrd6vx9djLSWQCTDIbMiwaXqnb0MgSW/Im3KeceKik2mNOdrFJVJMLxatzj//lqLSgVTwSxKlUWmYIRadFrTFUheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qin+KnVl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0f3052145so3491645ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187719; x=1712792519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=Qin+KnVlIIcZhNoYZvq20/1nCED1I2HIiBhT8a85Fn7F9l+JuoHRoqpHIU0PL3sBbl
         JV1++fC+Z6wgfSgUDq7gdo7WsTv0s5BMDvz+SWDpikGQIAhrgLdtWzOwBS2ddgoNnwtm
         mSpP6jBdKPE5nBJA1e9ZxIOnFJhVPY2AlCrqx/QRlC+sP3grwmeZWXdEL9pqq00bbH4R
         IpceTNxix6ng7ED1u1RDxHGuGAZcSHUwvpF93aOPNnlEBh5m0Kopv+HfQNpZ7OVwbBqu
         GLaNQ54ZwBKAHqkm/CBcYAWsvC+F6e4ltb8sFoTWAi+JY0KTz24QUN8ZF4LZXoloZ9Uh
         LBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187719; x=1712792519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1ajd+NFF25bzcoUpj6TOVq3gYUXEAPUF2iej3ctG8E=;
        b=pVrM5ZMvnK8lc0uBXCRL61pwOncnrefiVuiTwY2BULHwsmjeIsvbZvhdxGwq3C3Ed+
         OD9PswaApxu8DtJK3sfl2YwzM3zSaMxlRnnjDhoph8ySFqUuPKKN///cayQqK6+xApD5
         Avb5fit2fx1cyqIezMZaaX0L6NoUROcAxNrBIjmI3kmau9pCbGi9SK3T539pMFTC6GDf
         U3Cn51mudUg4mNeE32nennHNU0gG2228Zjd7cNHDm7ZpoVm4TmEjDPWr85A8pVUeMGdZ
         I3Jx3ggYFpt7+fp8SoWSO0eUbmXO7Mz3gslWfgQ4j6WWO1JB5O7ymbk8XArqaIU4UgKX
         pZhg==
X-Forwarded-Encrypted: i=1; AJvYcCX03Thswpf3HG0Ot7rH8aARwvC6dtrSmt3SNEUwu0lwYiGc198/dvMmq10515rRbkUlBJmSJYRj7kqxd9DDOakprXMY3ukZc28BTHcMSkzB
X-Gm-Message-State: AOJu0YzsF7AY3DugYPcw8LPNaR7d8WjFHxG/ODHCFGOTDcoVjFx7hxQL
	buG+dUlo6F6hsErhy2I3geSC50yp+vdspi1uFvPc3Rc7vsRt4EPvDKt4rTN2dmo=
X-Google-Smtp-Source: AGHT+IGh4iyC/GhUryA4pkxFBs7yNJ36fG0Y8vGsIbyj+jFCsDK2F7CISUUTPnXh7UOmjs+99OfNvA==
X-Received: by 2002:a17:902:f105:b0:1e2:718c:61e with SMTP id e5-20020a170902f10500b001e2718c061emr712135plb.27.1712187719240;
        Wed, 03 Apr 2024 16:41:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:41:58 -0700 (PDT)
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
Subject: [PATCH v3 11/29] riscv mm: manufacture shadow stack pte
Date: Wed,  3 Apr 2024 16:34:59 -0700
Message-ID: <20240403234054.2020347-12-debug@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4d5983bc6766..6362407f1e83 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -408,6 +408,12 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -693,6 +699,12 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));
-- 
2.43.2


