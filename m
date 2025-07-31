Return-Path: <linux-kselftest+bounces-38157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E687B179CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C637BADED
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C028A1DD;
	Thu, 31 Jul 2025 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IiVy2qEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F821FF4D
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004015; cv=none; b=gQB/78Bqe0L79OgOIK1xJzmALKk0VBZBEIv3z/Al/ZDAUh2b+DfeStBjLJHq5spCi4hQc+oJvclmhfwHXylPPfYrvOBQX3tXMWtsW14e+3OdmGqfebEqv+BpLLVDt8uN3MocOUxjGx80SbIn9huvjAanpNcZkLgfoNVyQhd658s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004015; c=relaxed/simple;
	bh=kI0JEIvhnozf7HW2k2LoLdj2L7bNb8dWhw7SVD1JQVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1AYpuiogSaOWo9uDIqwScPiTJNDPhKwwh5Chnb04BEtDd8kse7+mR2zS/brm7aMWRkRJmx1w6gTmYI6+xcdje+uWmqUidbtJ7oboDjkqVIAAucPQ7YBpJtoAiUSzKdM5NKmWBcDHOHp2XwI8v9wuNKyoIpaWXWCX3ttONFa1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IiVy2qEl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2403df11a2aso7540275ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004013; x=1754608813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaOhr4B8UIBnpyYSF4WgF0h84c6zm8BnVR368xQHyas=;
        b=IiVy2qEl17LtZAtepzcUw8EIpA5pS4iuaKNBTWGuAEGIJY/DmVxCJ9iKLqkwYREc0a
         iOqeJRuMiUomRbExepgiAE3U7+REc9OiuUYBP5gFleQIRFPn9D8pSsKQu2uQCKqYL+Vb
         RGd3zuZRcCdefTO3h8j+AYK8aSsJbEW7B9X2qSGSW7E9er1SUURT6Tyc1k1yvZ6HFvoM
         vOhnAzN+uP30wjcUDOzAjP0QLuwkuY2EpPNlaE8vTTZZ7+gKZ272HN874Rem6Xyhtyio
         kFBwJlBBJ95OsrklA6teuVrusv/si1JHGyL3czQKHs4TQM0rNxY7DK3O38m9G8AUrsfI
         +DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004013; x=1754608813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaOhr4B8UIBnpyYSF4WgF0h84c6zm8BnVR368xQHyas=;
        b=FjORL0wMsmjSVaiWIazocRC2AG9pvdqDJOix5dGCzcWmjdFCR+IpfTVZ9jGpeSyXlR
         Mpz6IudqOnflMw1Pnt27lELNprIBYJwWz4QYOOVeKFeHnCBPrv1VSsIfyb9JrGmbvXFh
         1EqY0q/X05SfNVmrmew3EuIFyU0aKeWZOJRDNSvvPn9Ayv8uls94rzsY+YyjU5YgQYdm
         Nm7KAuNXBB/f1WswfPPKJcU1ET/S+M3qxjUKC6zBntTY+oJ3AQ5AkLlgJnbJ7v8M/IsK
         jwBCK9LIqNSCkYsk40NAIxHp8HDa5Zg5O8uhiSor/uviOImKZXcCXwZKHVx6JuasRO5m
         R2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsisshXbDpgbfBwdwAH4UxJgkvmDYuHvavkGWb1j5RkcI/Ups1cOhxwYeMpmWMfHep/FEVDV97n7YGvDksnBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywrXJ8papUu6+wN+w2IGZqzezfN+TGCLYT5e9CyXm7liMRukzE
	HQMWOrsT8Bl2tSQlOtK1utW8dtGzDWeJQmWcYOJclT+CAFtwhpm60MZULNV8ca8/7Ag=
X-Gm-Gg: ASbGncthRXtGOo6IjhHntJVfXXIf+fD46qPLm1Kmb1S6J9PlS/1vt9dayUMgISM0HJZ
	LvbY7bQOsdrukuxiUqVc52qgL2B6MTdDp40LmPeN7VluQ8ZrLzDrZfD3MxyyxPu6pC1mSl+oMEh
	Na3BZbU5MK4s5oNXYme2zqQtJPw0mliy8j9qCVbiot4IzopSW+plrVJm/1sBpI5pLOsFkNmcu0G
	GXj4yLUTZaahk69xIvbM/gKCCkj6LrakJmi2gXr9zBW06vYK4ZcCJl6vNZXOK9rXjZKQ5zbAxUR
	V/kFczNWrQasU2mwYj1jnAycoqS6F4xlWdMDj09eLtKCWH5NCbGalsfwtydLtlnl4Lrb4xn8+hl
	Kpo97ySl7jBcpiFPeW9Q1q5m+OPc9PSO2
X-Google-Smtp-Source: AGHT+IEOx2kNK4TLWda5A9GHVV0DV0Tzu98/FGzwUAzzSt+lpD57+aAlabnlaZr4ia9ZMoripanr5A==
X-Received: by 2002:a17:902:d48d:b0:242:1a:1710 with SMTP id d9443c01a7336-2422a3397e4mr5432705ad.6.1754004013350;
        Thu, 31 Jul 2025 16:20:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:12 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:28 -0700
Subject: [PATCH v19 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-18-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 91db51413fab..a88b06ad2f9a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -93,8 +93,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.43.0


