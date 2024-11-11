Return-Path: <linux-kselftest+bounces-21821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC129C4885
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 22:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B34DB365BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2B1E048A;
	Mon, 11 Nov 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NGPyZW9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191D1D1E63
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358499; cv=none; b=AZqZvI4E6S0IEhKbqvM9cYH2SBBX2itnuXU8vHj8Dqw6QtxU246sFF3Hrp2tKwo4GEsJ9kl7O052zOEmd+Aus7BhO96hQyITL4yLUoyw0C3pPDWXElwh+71BcDWXcf1nDZ8y3QHwwxqJCxF4o5AyIvNzrr/ce8Ti4WNM3Cg/Kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358499; c=relaxed/simple;
	bh=wYCEI7wvSMLui8WMRpDFv0a+NDWckEqPGqXUbhFxHHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwOwdCf4W3As5QvsxXGGI8DmwaMWd7eDljlVf8D9W3pb3cV4WmjE1unl/IC0C292E1mYogDl8cGSE10JKXKWSBKQ049zlUru4IW57pBt0aC/F8R8RAfdwUZtFzwifAF4tiK2noYTiSgT2LUV5BMR47g+cYFZyqAtTorU6x0urds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NGPyZW9p; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso3951070a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358497; x=1731963297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=NGPyZW9pLPhC9nXjvoY7+iCDi7hEEe7Aq4Q1nnrUeilw8TGv/tUAoXjNfpMjejLsFU
         rXwibYB2aPGCSbhjOFtGcyIzSPw8KpaZp7MaIFpIsnG83mCS7FgWWKnXDvKvISuwy+xF
         MSAreHKMqyBbzXP6NLnjNwf8VMMkHbgFyUvtOc2ZuNX8wrMDx90l3114cIV2S1iyb8bR
         pO99P4WTmS/rhknkCCg/CtDnD1uKMpn6ddlASHZyI1IpA3olgS8hbbcPbBjpWo1sMG8/
         bgrvwH6+8zfRnXewf0+PEHPJHbOIdpFohrZdBcGjgWvCWvkhVc8YSyurqllWi2SDD+Ee
         BbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358497; x=1731963297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq3DaQ4YpzTwJN9yZW6Sl3gPyL1m035+b/05XFtk9T8=;
        b=r4w2GnAhjb2mSAm9xnRx53L4KC+Qjw6V16W1HdvalZN2Cx6pLFzoPx0fh3FO9OTout
         0G7OIgRmCsbZwnz990aUH8MPym0/SYImJzca9lKqnLIwHq7r1EhFqPbQRgJ5O6ENJcWg
         GGLbwTMmGNVWgRWE+u3H6rSr5Ybn1dUJohAn/dOnDouIwCsrmRTfaCXbLcvD4nKqjvCt
         DQU2F2cHTZSOpSCCM/VelFUZMaeS0hKyP4xyATCV5l0cVNnmSBeBOO5Z0/m+m0+/ob83
         +CDQYbN4j00g/mx6r302vLt9RcjWzvELD4KON+XsgALlHLRw8NwxRFo+j9WkpnJCoIWj
         P2lg==
X-Forwarded-Encrypted: i=1; AJvYcCXi/No9jUzJZHBD4NxQohVkvjClaTWY04ZkgJ0ARhvxJ62Ujc2p/5wVtQM9v+M6AS708V484RlSNzpVaIQPR0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8AB4TW3/F/yOPdA1lu8I5TnYz02M4/LjfqvHDiuljZ2xl2Ty
	EHZ/H5R4efeWP73YqubseNL1kulU0mm5nPK0FLI8qJKa4sB0oD/yyyURhEanOBM=
X-Google-Smtp-Source: AGHT+IEEKaEBcK4MgBqd/tJtgjOiUzsMic6zpl+RlG/WSuE/W94Zyl8KoJt+g6fHJT4sQqdqWl8Dag==
X-Received: by 2002:a17:90a:d88d:b0:2cb:5aaf:c12e with SMTP id 98e67ed59e1d1-2e9b1788b6amr17044135a91.37.1731358497234;
        Mon, 11 Nov 2024 12:54:57 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:56 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:08 -0800
Subject: [PATCH v8 23/29] riscv: Add Firmware Feature SBI extensions
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-v5_user_cfi_series-v8-23-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 rick.p.edgecombe@intel.com
X-Mailer: b4 0.14.0

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 98f631b051db..754e5cdabf46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,7 @@ enum sbi_ext_id {
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -281,6 +282,32 @@ struct sbi_sta_struct {
 
 #define SBI_SHMEM_DISABLE		-1
 
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		(1 << 31)
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		(1 << 30)
+
+#define SBI_FWFT_SET_FLAG_LOCK			(1 << 0)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24

-- 
2.45.0


