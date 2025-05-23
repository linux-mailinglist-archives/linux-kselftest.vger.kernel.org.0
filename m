Return-Path: <linux-kselftest+bounces-33603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D435AC1C82
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92498A45438
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124BE28D83B;
	Fri, 23 May 2025 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3F6wVaFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1828CF69
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978359; cv=none; b=Dn1GClB6HXwn1m0a+FTdlu2fnCKEHrH53FOJ3aPin+pBvTkzcUWiC4AuM74jjmsHiFutuKSKmsWB61q3c4LkmDdxkwE68fTNgQ6lJ1DhABm6S0b5ViBWMihkWm2fQKZA5VFh696XN//Jqcp/on8iydek6r+7U+ktvodUN6eTe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978359; c=relaxed/simple;
	bh=rpxI7deGxR1b1p2DEnatELgrO8HyrKziLzhoGXBzZ0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEWh0/dwbNuLXMyPodw3BVK3iuvRPjPO7oedmZxps/um+u6uCuDqsLzAguDBkpt6xVvEPBWMiYLqAgCMF4LOnTMrJcB11qr+QIS1Nvb3K+0dvWH1IVqCWFLBetDBMOQAb7b7/4NzMdxuQUEiVmzsEE613Y8D6Aesr0CpenQw/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3F6wVaFb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so4890115b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978356; x=1748583156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04baGaWIOcpAM10BsvDKc2YnzV44Y+9Sv7IQZJnFcq0=;
        b=3F6wVaFbJJUUA487gIdJ3tmZmaGq7EeCGdrwd0YnkzmpGCe+E+gMb+zWGaj6DHnoih
         UkczvAtxUaI90QJVf/9QpUBI0fnswoXJEBxMah8DYS9IwAG1fUfqEWnxY6I3FRSignmg
         33f4+AvpeJBNU/0HJapuT6jIGJR823EYyoRduS4aoInaU11Lzej2tfh16y0MAXbz5llJ
         vuMkLZBTv3ApO/ljeb1TO65gpERpebTi5FgDBxypTzJNvtvEgXJkLjylvKZXUYeBO+/h
         gaz/ENaaH+N1ikzumQxqJohKdUuLt0C7fsOEJKllK3UlBtwfu6UR06w2D/PdWLwkK2Rk
         BppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978356; x=1748583156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04baGaWIOcpAM10BsvDKc2YnzV44Y+9Sv7IQZJnFcq0=;
        b=k7fQHM9WM8ABCByvNx2XZxd1W8x8MCimw+ifR/bLoYTqeRmaFvIzttg4w7XuTMwwqW
         yd2SSohXsO7CsCzR9Bp403Jd8qR8kRQ6iZDniljKqd2ClJ1iQprGMyaeQwRrdQkl3dmd
         mDYVdkjQFYPb/GdB2LK7ngO1EMciUW/48QqleA4SLRtZ6wlw446/o8WSSVMUCRjHAZz2
         lKbX+Sobkrhii4PPBZcVbAIJd2hTI3OlkQnZqyeypW/wy995gaLcHyFHq5EeY/TdiTq8
         qhkeFV/TXT9lYlles/Phq6DidHvPgPgAbQMZSDW9tkLsYrNKFWi3TNAV/IZucouj54Fx
         pKhw==
X-Forwarded-Encrypted: i=1; AJvYcCWWn9tvQ/O4/MU1Ti+ffST+RULRRk8irQuitqHsUtrDtmEevfQB8dhtYq1BQe0n3pE2AYHfefhasw7TamvCeAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXuXgbQOq0mZ3TuE4gwFmw/YEFzec/fNj2o0tHzqmKzTd/BKP
	B3nPojw1yOnXYy49I4kKVv2P63EqiCCiaoFsx76xYmdDPK2Kd98KJ9BBS2BQL0kMr8s=
X-Gm-Gg: ASbGncvxl1d4UmXcwaQ/DWkO1xWqiuIP2jmCHsEVu/R/2OnZJPBWjzaHFneFKlzmEfW
	b6MxUN3wCo1yLZsgQUGjR2P6fau+Qpkr7FWMmwSQpYdwHD33mclmQKuHPfD3TntuPbhuXMKrwVG
	FWsOBnEFQ9DehzxvBnEjYluHNtmWTnAJXkHilb3yDe60jcjWg+KxWL4t13ylPbn9FDrTa96W+8Q
	c2u0AlGBQZ8DDNoBiMF0NSPPY2mATGlEZuJCVQWg4ySQDkq1vT5Z9f7U+g9U/xsVoJYpJnCtOPq
	qFt6epfDSfsUi4Fbk471tuMeo7ELvw97tME5Mbm5EV98rCrKbbYXGsbplsZvDQ==
X-Google-Smtp-Source: AGHT+IGY2mml7AXscMSxTVcExivaWeJQg450Faf3IiaTcz1vQGyBogO5Kxf2SHgDF5QZvOcb8ujfTA==
X-Received: by 2002:a05:6a00:982:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-742a97a2bcamr35352139b3a.9.1747978356133;
        Thu, 22 May 2025 22:32:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:32:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:28 -0700
Subject: [PATCH v16 25/27] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-25-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/index.rst   |   1 +
 Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index eecf347ce849..be7237b69682 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -14,6 +14,7 @@ RISC-V architecture
     uabi
     vector
     cmodx
+    zicfilp
 
     features
 
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..dcf43de73a06
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISC-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result into crashes, however when in hands of
+an adversary and if used creatively can result into a variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control
+transfers:
+
+- indirect control transfers must land on a landing pad instruction ``lpad``.
+  There are two exception to this rule:
+
+  - rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+    protected using shadow stack (see zicfiss.rst)
+
+  - rs1 = x7. On RISC-V compiler usually does below to reach function
+    which is beyond the offset possible J-type instruction::
+
+      auipc x7, <imm>
+      jalr (x7)
+
+	Such form of indirect control transfer are still immutable and don't rely
+    on memory and thus rs1=x7 is exempted from tracking and considered software
+    guarded jumps.
+
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate with x7. If ``imm_20bit`` == 0, CPU doesn't perform
+any comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must
+match ``x7`` else CPU will raise ``software check exception`` (``cause=18``)
+with ``*tval = 2``.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function prologues can have ``lpad`` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STATUS` /
+:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect
+branch tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfilp``
+then kernel will enable indirect branch tracking for the task. Dynamic loader
+can issue this :c:macro:`prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there
+is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
+
+* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Returns current status of indirect branch tracking. If enabled it'll return
+:c:macro:`PR_INDIR_BR_LP_ENABLE`
+
+* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Locks current status of indirect branch tracking on the task. User space may
+want to run with strict security posture and wouldn't want loading of objects
+without ``zicfilp`` support in it and thus would want to disallow disabling of
+indirect branch tracking. In that case user space can use this prctl to lock
+current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions:
+
+- missing ``lpad`` after indirect call / jmp
+- ``lpad`` not on 4 byte boundary
+- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7``
+
+In all 3 cases, ``*tval = 2`` is captured and software check exception is
+raised (``cause=18``)
+
+Linux kernel will treat this as :c:macro:`SIGSEV`` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.

-- 
2.43.0


