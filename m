Return-Path: <linux-kselftest+bounces-31991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B9AA3F58
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90CF188632C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002827A455;
	Wed, 30 Apr 2025 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KKpx11LF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B045266566
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972247; cv=none; b=fH9LJD1uIYU61uqeDrA6j8Rvvjh2vykrZXXMzOk/8U3KNhxt2yeyKE6k8WqIcJwCfF/SLLxYsdgm8pyC6hhQIKGabU0i9YIwGcGh+J5njDKW98vLcOiD10v7TM6NSfnE8Ec7wh6rQLP+teR+KYMavtaXXL+5eA4CZkVIMyVbBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972247; c=relaxed/simple;
	bh=HSj61/DKHbscjrSxiKNrJbrvkTbOzS+iDBZfj2iqRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Az6d178KTMZFJWecycFcQiBR3erTEHxoCYYBjUyxkGUMTnm0xQ8MHOrXGAZP0gqV2jeY4sURz94y08e1Hl66gCo9n3MYMBaxoF6IeKggjr4+SZj91jj9rBOc4UT/iY+/M03X3siMbs/kD+77x0B6UeDul/ml7gh61XczpAgM/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KKpx11LF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227914acd20so3536285ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972243; x=1746577043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=KKpx11LFOKRylmi0Sd1rLW2w/J/8/DK+hsEHQDesR/vv+ipwiSlwnO4SOM1DI6dQMM
         lpvaGipyeB5DeWLEwZzCxPxumaY8I49nMKpTkcPXtaYtsaouqiBtFr+FlN4nTyr2f1ds
         bUjDQZhZgMfr4kt0NNELjSjPQdHO2VgfDSkwVQ+tq7OzxlPk97yckLpEOW6vgryiJsOt
         oHjI1/jhSlJk3FsIReakJmBbwWVaWIwXwCDywEj9OdvfKikovaY38npSNVrUI63lOVT7
         ICjtHlVLyoYDMRCEmoYSqOQf1ihIM7Mf/6ZFiUdyEWnw10Lsax114voGqK50yDYf45hT
         ntkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972243; x=1746577043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puoahas2OCQQdRJkSX5kN4b6Bd2MCUgo7wt+1uTIqSI=;
        b=gbNu4zQ94WBEfQuurwW3CnJHEtJmyGJFjTg0+c5844qbo6mSL0ROLKI2YCir26KGr1
         PgOzRwXaWF2ba3D3zUSHTr61FlyIwA7OmcVkOmIOIqhReLxSBwzuXdPmLGTIs+j85Jmw
         gBmvGk8WHGTpkXNKSx0ZYjCm08Zo6mdgsBMoMhVV5Xtz2oLaL+TiIF1e2JbhprnnULsv
         PM5tfkXbBH3E+o9ebPt8PDiLeMIbx4/IflS+FE/r3BUVpi9p6iUGa1dVweAOt99UTKQr
         6x9OGznxwrLDzinQUQX/iRQt40aTPWImGXKv/KrCpqsesj+t9O+qqctTqPv6rBQ0XZzu
         nlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQUeFZ0rX5Ifmh/Cx6lXJ0LmK6t3rsFD/NXsjoBD+00xiP6tsOYX0g1vLwsZ/JEcZHnM/WMXWFWVcdr4LCpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztEq3+rdgkBOA/54t2eYIfU/tJdma5tN9TJ2D1b5U/4dmmhe+p
	ZDkV0+JznN6aCfvxPd7WbP6Vg01VMTt7pait9Vm3HPoG0NDZgQTUVi7O8QpXsoI=
X-Gm-Gg: ASbGncu4ZcfeJmdNRaTQYv6AvSAr492H2uKfLXEUiqscn0gX7WtyaCIIhdTM2joF7SI
	hwPb8w3DPe93mJYtJZx5bjZbXAFFc0tWYxrprg7hwwl9azoNeKFdIrERqTvbNNHJkn4QSah9AEz
	Ya90FuQ6gVcGRmEQYlgQ9LZcozNcODDrgZDm7cPm/Fa+ZcXyz8y2ETanN7dDAXsyOOiEBuZ0em0
	fdg/P12vwxkME6b7FmVyhN4OEm6xzmv8hWFh2pERq0DQ1/MFvFKweKGyaClJo7IVDw12QChm/aO
	v3aKmaZQKHuJNfCZ3dRbdnry06RlpEBm7dq8tuH9CNexGkrqpbQ=
X-Google-Smtp-Source: AGHT+IFjstEHD8QIZfy3Vcgu0xcBZf8foHmRSjeb/erLHfisACTJBjUsL08PsHqNuutlSch24CFTEg==
X-Received: by 2002:a17:902:f70d:b0:220:fe36:650c with SMTP id d9443c01a7336-22df4815c21mr14342955ad.23.1745972243456;
        Tue, 29 Apr 2025 17:17:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:35 -0700
Subject: [PATCH v14 18/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-18-5239410d012a@rivosinc.com>
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
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
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


