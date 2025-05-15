Return-Path: <linux-kselftest+bounces-33055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88114AB807F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265F54A1DFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751D297B62;
	Thu, 15 May 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Yk6WHYJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB50295D89
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297438; cv=none; b=qGfEfbAP84s0OXhaCo0hmopXzTZZvOODZ0x6trjsKNNIgttrRNbTNrrPt9aWGdmDSbK+Xb9s1+VyoT5Ph1W9F3qx/j0UY5FJmVdKGa6bnl792IBZjYFyVOoiq0hMJXEmyHYgB3wGhsny/aIG+2Jf23cxHOcxlr6CAbgT5XxRLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297438; c=relaxed/simple;
	bh=uz1riMVMX6ESvcly3DK7ZVeRESfNcHcQ1KO1rEuMiRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpjMBV8vFDsPyXt5vLpdnVx10zYNOBe2OVHfux6bU9yFlyEGXKVhpgbfm7085rs9vXYbjydCatSoYF0+wsssFN5oo9LSnlU++COmgvNIMZ5lPT/9o6/O/SfiSDXK3NRRCrPvF6Eulk+xq5y6Siz3nPLdSq7eRkWMDH3y0QXAK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Yk6WHYJT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so6999445e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297433; x=1747902233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW3Gt5ot6i3Z0vibD5tiRCC8lZra7MrDIFxKpe4L2VI=;
        b=Yk6WHYJT4QdCmQSEWOroBrq/gu2itGDi2XdFnjsBzYiaAd5vxtI74pNgsjV5RyvOWm
         MNg8j2rZCgcmPtaXNrFX58zkli73L0D6C2s7mbqnAm2Nj7KS2W2TJ1/ioIDGb/5fgOCX
         FTqtkc7KPN1umDaN5WsKhUzKGuxlsO1j8Bk9B6231AVbtEP12bSazPKKAXcy4A1yiVKc
         OEtRaZ7eNskiMMWJqT22sLlXYJNOeGvPHWjuG1Vjpvh/rrdKpvJ/Ehut4uvCdXmzNThh
         5KI3DhYsYJWGcxyrAPAb/7WWLg8BGVe5J5CDxKJG1BcBdFjcvNxiQ4tGsL+2LQ5nTJ4z
         nNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297433; x=1747902233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW3Gt5ot6i3Z0vibD5tiRCC8lZra7MrDIFxKpe4L2VI=;
        b=bUMySMMVK0Sk932/GB0whHb+I/Xl5vH6Yp1BGgucJMxlPDFl0m9yc72b7qBGqn9Yii
         DZYyvR1AEiAY+b26MZExFczGe2gPU5xuhpI7wU6O5vySQ9ug73u8j5wR1/HeujI0Uz2v
         B4mZgs5KKxlAF9QQaOOExMnEFt5Rzq3SUbCek8Jb5pTgaqeaPwuUXLBtE9C7Zk3dNpsZ
         pzGSqAkN17Yav11bsWUnlqliH9NtouSy7ozSwc4Dzl0237jJIuPncYGhzDeyO2rooln4
         jy/p5skDSCmiNesmHlvesKDB4k3lIPO9bFiEWQxdemG1abdSXPCz4MUeLM+7Po6DeuL7
         DfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz35/3uBj8zp8Nm4P/g9EwB9UfrigYQzukjeIoc6/siaeqDs49kDm6U9pYJWzFlXqjCSxNP9c5on+k9uz8LMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdzh0G/WP05MFoOTYbphNzxH3sDnVQEMHoM1FjL5VoI+7cWJc
	qghFkFDpe17+A1Y4hnthsDHoxfccngNhu26rPM6XdyQl/NTNVIu+t3cOEjZ+sYM=
X-Gm-Gg: ASbGnctzhHijlPp4sqCkHhAQmOrRN2z9Q3cidJ+SslkUkPi//BcZ0TjgluuIVyDr+cn
	JN2IMG/kTmOgDXqSuvGK4IzFko7QFTGrOQNfzVWC0kq1agSaiXZpwcyhk8grJG9Pl0FF5o51cH0
	oTquzWy+M/WY+VgRFMubuyTQr7NJ0t8S9VPHpRYWM5R2Sa3eSKy7pS4MQDGG6giJ3BvMFaFSork
	5cJ2k11r13a4yG/3ZKoPBjybN8fRDN3GNW3XAGTPHrWq7vVC3gi4S4whKbETfUOFtAC02fk2wFM
	yPJ59kcArEEDDyl784ZOYJXREY1XSwJ+Pwkt0KkDMaprM8zh7pM=
X-Google-Smtp-Source: AGHT+IEkMTLzUmbcaQoV7fBGhKB8oDf174vYHHp/il10qE0/kSBDkuCpwfLuKVtfldQPVM2OqN3Neg==
X-Received: by 2002:a05:600c:a07:b0:43c:e481:3353 with SMTP id 5b1f17b1804b1-442f96eca92mr14271065e9.17.1747297433494;
        Thu, 15 May 2025 01:23:53 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:52 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 08/14] riscv: misaligned: use correct CONFIG_ ifdef for misaligned_access_speed
Date: Thu, 15 May 2025 10:22:09 +0200
Message-ID: <20250515082217.433227-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
using the correct config option.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 34b4a4e9dfca..e551ba17f557 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -369,7 +369,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 #endif
 
-- 
2.49.0


