Return-Path: <linux-kselftest+bounces-34322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4714AACE34B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C37171949
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863925B1CB;
	Wed,  4 Jun 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ozRr8y7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89A1FECAD
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057437; cv=none; b=NHGENbH0bAwX22+N1stMPw+/R4rC3/qqJLwZcQLv0ySSFAGZbPd5iv77+ax9y15RrSD+AuhyjDxq2PyHXeYF1hoNDPGDHYUu4F4MeNSC5u9lDH6WKRFroOOpoyhAJnOAwyibzL9MtUcSVaz3k8AUnaCeR/WOpdF7MVfsPaSPScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057437; c=relaxed/simple;
	bh=ZMNfJGQcTcXW+Ox6hYmgZeihjxgbaJ9GC8ja8XfQDIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szEkgMsxSZGUv8rCsW6xJPdyEVvTh/qFrA1GUleUqeEkOlJ2GdSO7IcRAMEGQIhxyaNw7+w9Jab+ZkVhpeIz3w9kBxO71sn7PjxJVKO1kpY1Vem1fqrU89pWPzLoe51hdF3O7pqcUS4foD7cDvJ1Cn4W/d+suPDlTNsD1iaIeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ozRr8y7/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so86257a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057435; x=1749662235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXNrGX2eIDDqqmRRfhE1GhCa5+tzqdtGdU7JTzGQSvA=;
        b=ozRr8y7/5j+NNkAT8S024NAEtpV7T1b8AJ1B5wrqR6/IgnmFrmMVUJDExVEtdyWB6w
         mdPYF1KrjuIObV4YNm6RXeJ8o28VkoOTL3CarVIZ+DjvK1vRdY/UuJ2aGPVpXR3rPdS4
         AM+RtC4C83iaxo60atQPSNiBe/vll9Ftod8Ypz6edpS8M1TIbhWpVnRG81TGOK2teu/f
         5tyPo+2KtO6V2MkQTQHoYts0i2riJbyJV1BNpAxtKXOqTxNI4GlbVzOtdkL5K2/K01R6
         VWNcI+xF2VIRicX8Rp1s3LUtt3NDT4A5rYpszx55fVEkI+YkF9pbc2wC4t6oiGpShxkd
         EqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057435; x=1749662235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXNrGX2eIDDqqmRRfhE1GhCa5+tzqdtGdU7JTzGQSvA=;
        b=GjqypHY/xk65TiaC7+7Gpjwwu6dBt2TZz6sBgGoEZjQo8eNV2j8qMa0NRvlQk9JLOW
         cbDHkVTgbUWIu9uGlQZpblJvk3p8bI67whJc1UBKSc6R9BwsWMqAqllzssT3jveCYJNZ
         VwJDNOYQF0xzJJuqBKr5xQu8GeoADcqrDU0d/gz6j9biWL/YiLuzup4wmCOAHAWfvzCL
         iTeOXna9pT0u/LSquYsy5gHWPs7f68rsAoT2/QmO1k1Kr4tj/9E06qBNCoMlnabYyZnO
         XyNitSa8Z3ua6PLIDvYevD7NZuK8eCTZ/9NUtGuFZJIVoGayWBDMvHnOcQ3Vo0IKCADH
         2BwA==
X-Forwarded-Encrypted: i=1; AJvYcCU6mVk8mx6OeN4gSBxB/GCUFlerqO/qiux1JATbKSRClsYYSnlWEM+QIxdO+dg4JEc0ZFSnlTBpAVdAIkZZ7YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflHbUY9jFfd+n2EFEcJU9xZ5lxWc7vBHxUvb6houlhJawsa7t
	GQZ79Uh+qwnux4LIvTgES5gUwwN2f5a/pypl4k29UGgEJL1yev6FuIe5CHE+B6HMDPQ=
X-Gm-Gg: ASbGncsqxDf1y5bHb75dse3x1BkeaSz+Xceughde2qUkG7t4w4ZoGRjMr+C9xHBcEm+
	iu8GXfQLaHIdxTZg/WUHxsfgVxhk24K7j65J9T5ln3T20MBMbw3RspC46QsDf9Inw79WJAcQuS9
	OV6+IjwN1zCP0rZPvz5M1KBOnvnvnntvaMipHrqvGkvs7u22pSByIFjlBLyjjI22qxGvZt3qOvY
	gzlyan+lgQrVJFNRfRK/QzQqN9rAz9xCfP+pJRzFUSoN/pDjkmceVjgD+PvW6oLRrHwU7Xf8zTA
	8IuKGUoDMAZpG/gPBTiMHr+3kMXPxDBsJNWLIqugzmbU/aTKtxciCyi/uWwxYn+K7PS9nQsg
X-Google-Smtp-Source: AGHT+IFRkG/ueZmWo+NqSTRZ9V3ys7So/QoEVgn4dpe4KHFol1emcatYOtg6C5H9Gx/Ts8HBIn3E3A==
X-Received: by 2002:a17:90b:3d02:b0:312:e9d:4002 with SMTP id 98e67ed59e1d1-3130cdad8e7mr5727605a91.28.1749057435352;
        Wed, 04 Jun 2025 10:17:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:17:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:44 -0700
Subject: [PATCH v17 20/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-20-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 3c2fce939673..9bc96881dc9b 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -81,6 +81,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 55)
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 59)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 249aec8594a9..c86cba0e4506 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -111,6 +111,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.43.0


