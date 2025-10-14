Return-Path: <linux-kselftest+bounces-43052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A30BD689B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 00:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D194F6228
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0467830FC31;
	Mon, 13 Oct 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="T5KWLza+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C630F930
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392607; cv=none; b=qLRf/e6BVrMZkw0wT76PVLvNMvCqFEb5QzNP0RAXjGOU9nKkJb7I24u8J3dtB6Ia9l83+UBwb1Uk2zJfffdub4SlZtk1VYIyMGD4uDoWEcBVarifJBU1MsZYJB88MDmguC183ACdT8/LVOYVaUpIR82CDS//JESavR5FyF452ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392607; c=relaxed/simple;
	bh=I1jqcPRPd1hxfvYCXrKsXB3tX7WWaFK9J8/4Z0z3BE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1H2z9DGGNtSI1dfsC7onwyLRWcaBRPgxwnwP62BWTtk4Zw2CVrLtVCRhDQF1opxYk9J38gR5K4DU+ve8zBhyhBW5+qz6/CbuCldpuG+//+tWUO7TFrLR625+gYVFrY9PndInjma7u7lMqV/+PD11z9mJWP/FPKBpl2GbMph2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=T5KWLza+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782bfd0a977so3972158b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392603; x=1760997403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=T5KWLza+iGXUyHRBycXhmvm/1Y7ZB6CsAV1DSsyEsACpd87IVU3ClrVHyZe7Z0JTUx
         JehjJ/PJPu3sI5K20XvyuH22Hf4p0hP/8s6sTJ2a2QU3y6ft7Q4e4cUfCXjPyj8iPCQ1
         sVPGc0i4NXsRpvdYPNJILKjyfisaucuDojGlSjF4D5uNlXw2Wa1YuL99hmh19aL6lTO9
         jC+UAWfhmfC1pz+pOKVFca8TJu7FDt8eVew7Fw726hPI9DTSzkeo/RxE8xv8AHeKg0c6
         ogNeo0YVYZqlR7f8hhqBLCsq+NQj6R1Rc5GpZe3DCJvGYR+5nbfiEvYFL43UAj/m+ERH
         /L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392603; x=1760997403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=acx0Uqg1uIe2o7TTWWHZNWI9u/hqPrpfyLdordKkEADV9u750x9bTkVbaUyIyXRU9c
         IG1IxjpeUTH6AIFV/a8zp1SReyenGL1sI/XB2h3KWSVWVaJOJdr+4lOJNasgvJfcrczW
         sVV2b/z2kkmzbNOhXSpWSjGsLN/EJmKe4DCC8vBqm9I07I9pyFijzl2vsWZGpaQQZtpH
         tA6QPIVtC5Z/ZtjUyO0B0i8WXFI28tcpreri52tFRx2rICE+jLaIqSaTKY3/jSinIevD
         bgosqoNsBCQPbJIbvC+OOf8eZsGOb/25MPVY4NaHuuhYYgnB7p6WrFpevYCx+rCaesr0
         zQVg==
X-Forwarded-Encrypted: i=1; AJvYcCWulGNfXRqFuD9bCi+IDlS/3tNwd7zEVOZngCJak/MN2Mge3FdGCfpErIxMZOH2/+O3tMxL1zZ4huGNtavGl0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYJ6I9y7sLbBJvKrBw0w9EP9YURsG7OkQcyRReMAZh1jefxSl
	jocMHNtTV3Dnz2bHYLKACUEzKStMzCxiyGZRh1LuEAAJO6p7nctbRYRDt0Iejh7rX/8=
X-Gm-Gg: ASbGncuwQh6yK/QjbUKqyLEtUgHXQcoFdcESyNirHxOkhMZBNjubB9SfpfJ21yxtzAJ
	snrF5ZmvUgXz90OXn8afMmT2OnwmOXCPVLet4/TA9BlSLF7xw+MvTg9NwZb8fsgZCUsLaPGUBb2
	7gNUslfUOMYQ/HJzhan/LdaOqHSXsZdcrHAbe8M0OF5n6fZIfqWUd3bz40FAWA7hrvsQ6jzV9+G
	2O1xtqZUgtWFMQLaGm0lWzu6wQkEEMZJnyMQ2hWTZHU5zC1L73n7eTVkIIVoDX4V+RycPHLd+tX
	zerjoDJ9xTHY+AnGA7NpmAlTD/rsR85FuJhWZTMugizaKGo6Ofx3eiwWmRfcFbtg6BOBchF5mvf
	nvJBXWKHlFQfEzIE+QmOGr4Mp/kj7Fci4grrQiI0rhvj/zaQKlGg=
X-Google-Smtp-Source: AGHT+IE3NXVbgrP/RYPydbW9+drnd1N+r2sI087097hN50jn9gE4DDohow4FO1i/KcQ8Qec2oH8NZA==
X-Received: by 2002:a17:90b:3908:b0:335:21bf:3b99 with SMTP id 98e67ed59e1d1-33b5139a3c6mr28585062a91.32.1760392603453;
        Mon, 13 Oct 2025 14:56:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:12 -0700
Subject: [PATCH v20 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-20-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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


