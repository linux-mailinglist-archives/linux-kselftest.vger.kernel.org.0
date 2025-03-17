Return-Path: <linux-kselftest+bounces-29254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554AA659E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D10162EFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADEB1A3A8A;
	Mon, 17 Mar 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TH0Wpr6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE21EDA3F
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231302; cv=none; b=sxIBIQW5y0qVQi2xirLiC9mm+i+j4FqKXcXlgtAssO0rCjzJ6/Ud89wC/JhbRwKQ4LNa5UoSKh5C+PnN1dXVklVgiAYWJ/fTabhDvTce46nyWSegNj6EPuYw0oPI0DAO932yLEN+9qGQFh62pHCo8VaTfXDAy7ylYEzSYD6K9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231302; c=relaxed/simple;
	bh=B4l5ww4xM3ybuxVDnFD7O4s6SCugiqPi0tOYv0B/adg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlM8F0bPuncy9N0olSAG/WduGHyiO4uj6Uyz5mrnHccNmNmEs4/LwKvQ3E2Hb2iqvn2QBcI1SQrSP9RL5c01AWcfUEhAEYg6ZFlMRQlrkp984tgqCvueM6T/ZdVX5tQ3ptgXZlI5mRcRYzAfs2LBggI/RmM3y1BfNgd8pC9KAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TH0Wpr6k; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2482991f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742231298; x=1742836098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=TH0Wpr6kUlHO8JCQ8f1xc1hUwdTwBLerRFQ1twh7EsTet8H64iJxR7jlfxf4PtwVsk
         VXRN09JsGKDl7bY4vCW0Ht2UFXJ1kdeHbPrjlSVA3Eho+hcUH1ZUF9cUDYufFnkKkWbb
         f4ETFjelcXuCl7cyxhkKFvNpn4547+fOHY9Rrso8D78/OUSgoe3wKWtPwfYxqSA+ma9d
         xPemuYDNAL9vwUieKeknaKYh85TIPPhPeNbNeII+DXeoIiPQ2NGhnzSf4n6rb42h+ICU
         /5BZuHy9st5KLNxj/lERhDOCDRtPCd0+D+MqaLN3MhM0rVeQyU+XrA80YfffflQxVQA4
         swUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231298; x=1742836098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Vwlc46bZsQyt2QxW9m2l1M9vTOam7Mm6HyDDfLEZk=;
        b=Ivxflg2DEhUeydvvujo9aQ5hnbpum483LrY3F9e0vdxCyVoWH9JEsP/qcKQ0d2nTAY
         3qUKBWVLaBV+5eNxpNS20492MRwSbmmrqd42GTVNM31uOGmjlqrKMrliVJMXdiVI974P
         /HT6vjYdMKkqhZKkdZsPQRHRF0MoaI5goyTozKFUziJeDpu3tHGM/jbftJDKLGqD5UP7
         mgKUU0uTJiVrRigV5QwrXwcV/oqHmgjAsljoyyrkkdr6r9NgBrnJtr7WuveLKqHu282W
         Qtf114A3jqZVWDg18EO2xGhVsl4X864htF4M2PEF9qegB5mq3Y9pNgvA+cxGqQmIIOuH
         Vaiw==
X-Forwarded-Encrypted: i=1; AJvYcCXyJoyPWYAVIFqdf13f0xTgsKolUeN3HDVmkj3xjnQNC6tuoL19Tj7Wqz/jtiHf+ydDDZ9Y21vq0rxgALSd9yE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NUt2Wo7Zdr9tK3U0HpstNI18HwKcrjMuDu9z6i1mD8/AGGRf
	IwuV2MxJdnmdhJ1SooC/9+U5xrAHkhEXZg5PO3NAs6hPa0C9S3eA0Q8UxPYHS+8=
X-Gm-Gg: ASbGncvy126OCSTJVzA3w5MCZYAIxrthgqUJ0jZDdz1TIM5HgxI8OztYqPP6Km2Tuq4
	TAZkoKBuVdI3Cqy3C3GKb656B0mgkrefdpDRsSDkRi8pnJRhF72LTTE4IgIyZBvZjKkpnqF1cxa
	t+nj3lUXQdPGW5/xJM1HIR+d0HZvXccwDXfMbnc+sVwgCGKrbJnYeyL1ZDP6ga76NY3qUEff7q2
	JQk3JYOg/FETp1CRLhPox3Fe29vph6eNixVkAlFSGrmG8tR6KzQlLY5owc0KAhRzP8CpCTweeuW
	toodizsE6GWOpkScHbJSX0fgv5AGEIvq+GzJSXIeB0stzw==
X-Google-Smtp-Source: AGHT+IGA2Rdk6jf2tb4X7esu4pon4fXkJaTK84F8Y0BwgA61Xp90vVw97TtNBjS5pxzMobEPki6sdQ==
X-Received: by 2002:a05:6000:1f8e:b0:391:253b:4046 with SMTP id ffacd0b85a97d-3971d51f3f8mr14939898f8f.16.1742231298143;
        Mon, 17 Mar 2025 10:08:18 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d23cddb2asm96014505e9.39.2025.03.17.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:08:17 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 10/18] riscv: misaligned: factorize trap handling
Date: Mon, 17 Mar 2025 18:06:16 +0100
Message-ID: <20250317170625.1142870-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317170625.1142870-1-cleger@rivosinc.com>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned accesses traps are not nmi and should be treated as normal
one using irqentry_enter()/exit(). Since both load/store and user/kernel
should use almost the same path and that we are going to add some code
around that, factorize it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..55d9f3450398 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -198,47 +198,38 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+enum misaligned_access_type {
+	MISALIGNED_STORE,
+	MISALIGNED_LOAD,
+};
+
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
+	irqentry_state_t state = irqentry_enter(regs);
 
+	if (type ==  MISALIGNED_LOAD) {
 		if (handle_misaligned_load(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
-		irqentry_exit_to_user_mode(regs);
+				      "Oops - load address misaligned");
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_load(regs))
+		if (handle_misaligned_store(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
-		irqentry_nmi_exit(regs, state);
+				      "Oops - store (or AMO) address misaligned");
 	}
+
+	irqentry_exit(regs, state);
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
-
-		irqentry_exit_to_user_mode(regs);
-	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
+	do_trap_misaligned(regs, MISALIGNED_LOAD);
+}
 
-		irqentry_nmi_exit(regs, state);
-	}
+asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+{
+	do_trap_misaligned(regs, MISALIGNED_STORE);
 }
+
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
-- 
2.47.2


