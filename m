Return-Path: <linux-kselftest+bounces-18775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606698C291
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9931C23800
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75521CEABB;
	Tue,  1 Oct 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R3G2S/uv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E781CDA3C
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798854; cv=none; b=S3X2LIJeWXCEISLGxb+Lp1BNqp3Y5eSGhQgBBAc9J7a4HERIN8PassgcAatG6+SwDaT2O6Q3sPyu7wVX91gJ551MAxKccAUJMc5uex8NqxGtW8meXvvMahRGxgYBCZffebnU8RrmXvq05VmTdpafphpgHxOnH1/eqMpdCtIsXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798854; c=relaxed/simple;
	bh=0P0H7tyzucv3KISYxlKm6qbY67oBbop+zQ8AHryx3GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTgqm8jRt6GrCz+EYnHSVgNZMtKPg0NJJZcsv96lhQkjE1aAYVffcmZRhZdMATmhLJHcGtZuOF+bMM5X28QraWxFx/BPUb4xbFq8UPgJ7tkRqlB5wDs9uHC7bXO7+6m2Me6fvtXfV0ip8ubSuM3C45oFefOF7dPFRc55UfUhAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R3G2S/uv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so4288366a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798853; x=1728403653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvFaRabdOYgj/FaUxHA5lpjBxuSoaWHPSkkVGjDU8NY=;
        b=R3G2S/uvOFDZBl5pLDC+WWBYGEfPbFhi1qD4GiaxGCxeGAmVgPU9t4cBQi50L1n5qR
         iQH0hheTLRXU6hjf+UrnY85FsKzz9Ar46gplx/PmFXZeTit0Z4cvZ/jZPKqZBSUuL+Ep
         6AOCg4gRYPPh8Aca4BojOunksW7mp+iJa0EAVVapSQwpzH3hHgEUlRbOsRvdoYnh+sz8
         cmw7Ot8QCovLNyLxSa8+UzogNZa68QVOjACr53BsR9N1rkBptUWCheABDV5ESYMr1KGK
         Gu2RlmYR7NUvUJob6pvhWH9G7ZfhIvjSy5eq9QLaZEpRisBYdB1eBOQdiiYVB7JHdRaH
         M8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798853; x=1728403653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvFaRabdOYgj/FaUxHA5lpjBxuSoaWHPSkkVGjDU8NY=;
        b=TtMwTZG8CEniuAXZTxVEtzVeh+kbVyztpmZr0qoAFHUQJB8Hut+gxXxyXVIdEIkmbt
         BJ8a5gungciP0qBePxd/RG0KGrUsotaIGex6f1lqMX1fH0w6wk5Amg9tbreDioHqldzK
         xBWUvHLzXB7X62PmFSkLR1lYzRGmEMlhmwKEIoYIC+iGAqMfAJYhrn5sVP/IrWw9W/WD
         cn3gTSe/9eVZEyyvY69nsNlF79DJ0hKdnYsSPJqfcdDdgiDvKsJ/gEGVsNlBN/sgJi+O
         TezVj6eT5ziY3/TZ1KS/2pMkXJnSj+TE8GQEdUfFYy1MnPyu5YMQBi/rlilbiIh1tico
         e+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6643opMvq548x5h54rvgbrC3JB5TfVCTnKtsriuWA85eOELDRFdcrGdizP5c2DjsRaWb+ESS/r0TM3sYYAd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGuD7HqrPuA0qO2QXGQ2kvVDZ4j33iZXkqvu/NOr0DFXVNyiN
	uI/4pdRKbtNVRA9keaFeJzEkQfun/03q/XyXIjCQrZuKBo1+R+CPkf0EPEN8tyo=
X-Google-Smtp-Source: AGHT+IG9catzJvE6iZhMcet9lnrBEGB4mWrgVfEl6Aw7Bwjo8k2vC5A57va5s4Xp67KUnf9ZyIG6qQ==
X-Received: by 2002:a17:90a:ba88:b0:2e0:f81c:731f with SMTP id 98e67ed59e1d1-2e18481a282mr222726a91.24.1727798852879;
        Tue, 01 Oct 2024 09:07:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:17 -0700
Subject: [PATCH 12/33] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-12-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4948a1f18ae8..2c6edc8d04a3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,6 +421,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -738,6 +743,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.45.0


