Return-Path: <linux-kselftest+bounces-31993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDFAA3F67
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D7C9A4506
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77027E7D5;
	Wed, 30 Apr 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1qd4ycqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647027E7C1
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972252; cv=none; b=d1Mlz5UTeHZfSGJarlirThINAk7SyX7XNomMOrR3sSEkH8quF02Nkj8/TafLbQX4fxTHHrVyctbovMva7Emn3zDwTbFqscXCeO6ECZ+eh8DhNtWVusKTlBk6Iuk6xbVNS5n9MNRW7OwpnCAc/nDVAhbst97HyUTP+CTT4YMoGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972252; c=relaxed/simple;
	bh=ZMNfJGQcTcXW+Ox6hYmgZeihjxgbaJ9GC8ja8XfQDIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkO+R/kcMP8B0G/CgUodAnKGtXnttaEQUMjbssQ2X7rKvm6pKOZQph1HrYEmbRpSFGo8ANQo/hIVNo33FZraMFoBFVUcud7RDSEYsU81N49K3vs4be1r5D9NEkae1qg+bbZ7kMMaA+zfcS1W+QgC/grUgbD7MURKc+lrr5ijYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1qd4ycqV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2295d78b433so72320615ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972250; x=1746577050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXNrGX2eIDDqqmRRfhE1GhCa5+tzqdtGdU7JTzGQSvA=;
        b=1qd4ycqVVXV6gRzk4zVnmBc2QQTTqKKLOW1HxqoQaweVitluUX6xSnvadAO2/RShId
         JT2Nxbj8g897Rj8FPcqiUS7Z2Id54pR+cRDSEYnBUC/v+NBc8G+kuRXCIv+lW60lT2Ff
         qbfMIESN2N1ndYXKb9zhvzr7PmIabQyPxOh7sGtXodtPU6LmfNH7+nCLF43Wm0dRR/Mq
         +w7AiRj1RkmmKGBBpm4SZAHHOWYzUgVYYdwiWnDNfwL8YshhhvN0znv6lx3dq4PQBYpC
         rLBcYhQvfq2pfvTmSGyygeDhwrB9b8XpK+xsMocdwsnnPrfec+QEHirFjH+hnjUKZl/x
         Iflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972250; x=1746577050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXNrGX2eIDDqqmRRfhE1GhCa5+tzqdtGdU7JTzGQSvA=;
        b=WE2YumF+oyqaZmOQTDhvm5Ulhfs1PU1++ENTdyEwzMozrpqajM7SDyYWdH6ixc8xxa
         QqZh7appObT2YDsvusvYtxu3f7zohbysHeZd6P5ZtgVIRBpQU+YnjCXMglqNSwXnVWaa
         sex6OkFDL93agBZEsxWJXIvzmTWIR03eHSWl8tqz85rMcLoQup8H1dEWc6SXqd8KBKYQ
         ziPdmmxDumGQ8nLlnXsjqWALxqG55Xkrdr0lzENIb0Y5RxechkKCBHkL/an4XEOy7DFA
         Z5Vs6hgg7cYfR5DV+ojSGkXT42yNZ3ULUqYeR9aJ2FAnZ8F3JxD5/TfNiTOXXYCybLNT
         sY9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOTqJtvMPgPUKvsdJ4pefu6Q6fCSU11uMa+9xxwwseNj3sBTZD7fNVKvDELUNaNUyaAWlEE2b4SSDo8eFTxWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTW9tB3mSWgJy3W+kijSSjxB8WKjbbw0ZOmfgaIMmWNbiE0rX
	rWHdsHMDNY7QSdGYQOgDZ7Dj3PtGYb6y7Dx18jCwSXZot6mdekV2yhcbkiX+474=
X-Gm-Gg: ASbGnctdz6wkZjidiNH09ie56HW4611wExQ9KxKh2vG2SpWw1aVxF4MQUQVGbgUoqUf
	06HtQRWErq7QUlQPfM6nECH4yC/64Y81Hru0uA3T+PxG2N81wpNOtVtBtABHsqFaIV3kg7ZiyJT
	2ordI9hD1MA5IM6kCtT6VbIM1h2ufcs7iNCEcaZhA+EtskVXxCR0l+NpLdaeIxpdg//3+XZBaaU
	YuzWt3MXchCyil81OZ6TbkhQaymYgWJrIXFpAzBk/FoN6OLtKlQdnvWkZsWwURJ6dgCOm5/Y8Hb
	oc5/FihM5W7yu9y+SRURQRkiW/yEzUADhUS4mUZ+P5ZB4YImp8c=
X-Google-Smtp-Source: AGHT+IEv08Pi1B4n8aq/gama+rOHWezI3b9NXNMRL3JsLWbL6t5wIuHJZfTFW7KjphDiUJGfsha+Gg==
X-Received: by 2002:a17:902:dac3:b0:223:faf5:c82 with SMTP id d9443c01a7336-22df5769b69mr6013935ad.8.1745972249788;
        Tue, 29 Apr 2025 17:17:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:37 -0700
Subject: [PATCH v14 20/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-20-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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


