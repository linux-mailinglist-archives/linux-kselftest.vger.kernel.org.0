Return-Path: <linux-kselftest+bounces-43236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1789BE01CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8051481D34
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2D34DCC7;
	Wed, 15 Oct 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="N6GdJLk+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2F34AAEF
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552068; cv=none; b=blOQDcWSJIHMMkPM7aDT45rALP4G1UHd+BTWdrbpP+wnwcLDxl2MwDo3TencYMD8+BJ+e/Mvh4FgoMmLRzap9ONBygHWFxamwePZQz3aEd8+GMVakJtahpwd82sTCFlbfNsepT7GTl7XLmw3mdRyJ2B01xIT6OcSDCdcNM3FSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552068; c=relaxed/simple;
	bh=wP5UX7zWs0Sv1DUPgXKgMTygpamqW2/FxBkyaeLpPmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ujhh8gcJIEMfJZhiso/01HMiSVxHrCJSZw6dagni6mwWL/szg3OGAbZL2EiirZ/cG/nf014u3fr2zHYJLEtAm6UAhN0Q9lkd+mPe5AbA9gViyevQ6y3EUeINCYEAxRxVLAIDKL6VAESC2JhQCK/rsVBAovhXKx4YXdGsCEmXxqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=N6GdJLk+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so92355305ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552065; x=1761156865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tg1KhEMZfMefo+THEb4ueoLXzfJu3WY6LEuxXprwk8=;
        b=N6GdJLk+J7nbk2G2CeAp3gSTDE30HTW52rRb2yNSnfwuI9IvLXrhRJLgg3r9cC0eVT
         9u4zH4/XVOhXM5VbeebL96pYT9SNfEuM6tJ/h2rh1Wi1zs2jbVpFcZNkDAV0GRW07fBp
         IkYi1gSnziecLzIYw3X6Y4er6mUzAe2hCTCsu3IuQSPmCtQ0bVlWy73Zp197cgK4FMFO
         jcdptpHNcdNvly5vguVLoXcc6DG86TSEdz/XPuZyA5PF322IwbwK7+PdO5Ob5KxexGbt
         8U9N3atmVzGfIFZ5H2592DlpMCMtE2ry2EloD4yWAK2iJRbe0VcAMxALi+xIclzHNv2x
         B7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552065; x=1761156865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tg1KhEMZfMefo+THEb4ueoLXzfJu3WY6LEuxXprwk8=;
        b=FAtfo8Dw+8zBIoSUNi15fSES+xfuxJFEYPSaPgDcdxJrK7zhDdxmjALckelN8FyTfc
         oO8MAyml9RUgNmjn/mHXvHtsEXREs1gbcb+Mofqe0qn2rNmClNsyqbpskrnmLzqV12VG
         nKNYvJB/0vi5xSV7lXBuWGn3TRGq+S+Pyq8xswHPUC9SXxyN9GGs9lT4FpCyc2QL5Pal
         9zVW7EPj8RgmulSz4Ele6TtNgz549pbYTAr02vhIkE3sFlCqRbXjTh9V/I+0oG2fR7JE
         zroXPCQzw3zVaJ7tL18v/GulNQY6k5q6//JnEoVLZ1CRlskeYjRA5A7mknFWRCcstUSk
         Ah0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvi7B6Rur6rNJE7dqWROszuMK4HLtIfSJjl1nGi2VSX1+YIdLMetgPEo0de5P4mqdAGucoMlfDLyri7fnLwBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0h4H1LtasO4m5IOYw3qhCt0V+6hNaBIefBxPObUjazjsXCVMe
	wYnF7xwd0q4DkAlFERiYYuZLy/+M1gnAq7vToZNpj3l3nBgJUE6o+PgicXWuxKB0lo0=
X-Gm-Gg: ASbGncvNZ7pt1pobtkRMtl8FA4Z3n0+RCdUt20cA2HfoIw3y2pQ1ldxrjaGuT4/K3rz
	zgU90p6zSAVAzy5rAbEAlVvbauGU95AuDRvF51Qlhm7mRQxXLoi4hJgLN5F0++JVrZ1QQyEG6FS
	Tsr65EEg0tqtGsloZSh88hV50flNbz+jZY2ezH4p4V+y7LebDON14gShRUx/ptW2ojKlP1V8iRz
	Pf4bK7D7FZkUJhq/xmKRwQV8Entn7fiuxvnE5cLMr8xI4+yuIRtEN69wscCBxcR5oQIRCT0wmjD
	9t1VTP1GkEi+kC4Ho1HK3QQGMjACUFvA8RDhOUERldkP/5xtskr3v50vEITjfbdn3wSNTfEoGvV
	YinKW73wJhbA03TJq9jEp9QrxWHJewKmpbFLrhZpYMttvOoqLL3w=
X-Google-Smtp-Source: AGHT+IFJldQrTahc3Q8sVNu0r3ng0kmfHptGVJgLteMAPNepRvaTO19nK3n/je32vdUKI1tH6x0IYQ==
X-Received: by 2002:a17:903:2f84:b0:28c:834f:d855 with SMTP id d9443c01a7336-290272667bcmr408470055ad.27.1760552064765;
        Wed, 15 Oct 2025 11:14:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:24 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:50 -0700
Subject: [PATCH v21 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-18-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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
index 49f527e3acfd..aacb23978f93 100644
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


