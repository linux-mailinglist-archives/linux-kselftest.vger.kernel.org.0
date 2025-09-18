Return-Path: <linux-kselftest+bounces-38164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD1B179F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C2C1C80E4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42028C874;
	Thu, 31 Jul 2025 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ESMvg57r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFC28C5C7
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004038; cv=none; b=tuGDULejK3MN7Zx0wX+JY2riDEJY1Kt7XNhXdPJ6EEhcwW1TSpAbf2DdROuwIGVagdibDF87dssgCkikD/sjVjljTKlyldEF8A1HD1v9Hg+NHHcua2mkdhM57hM78lllvys9sGIelkT1xENIF0D/iAbV4ut9ZOeRVrt4o5md6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004038; c=relaxed/simple;
	bh=rpxI7deGxR1b1p2DEnatELgrO8HyrKziLzhoGXBzZ0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYwEE0u6evbZZjvUM3/Vi3Jjy6ZrODdXaCimL/PsrzVEmv9nvYqnjO8SYXcPsLK1Nc8eGBdM2ssg2qqZwP/sRerkjD+G6gpACQerH1wEk5eQJ2bKR7hedbulH6qQakLu6CGZWeE6MbkVqw4Sgwd+wqt4VKmtiSc5TDi2+vwxQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ESMvg57r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so1337762a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004035; x=1754608835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04baGaWIOcpAM10BsvDKc2YnzV44Y+9Sv7IQZJnFcq0=;
        b=ESMvg57r+8VAodwwNbNkXtJPaERrbdDksGSrbzYDoeEK03ZK+HnPW1/n9rFyAfMZz5
         +PncdnSJIAi6X0NU8WfN0cKJKkSESo1BoDEPpnwjihqTopxueSNzqb4ocsQEXwTJy9yl
         RyYMQIP7HA9FVjEN0Lr4yylhvBdUPYkf70yrfhApVYmqP78O9Mvga3cjM1RNZ6450IA+
         AuwSDsLHHFZiRH7kBvOF8zP8hy781G2l5fkxhl3sEjpVkh2WZfuDuQLfmiT3eJQTT1jO
         yxrY0m6U6JPzinuwKjF9Dl7hjYpbr5YRxTlaKtvWlOR0J2Vnz/lrxWc+8KmMOC+56Sr0
         fH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004035; x=1754608835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04baGaWIOcpAM10BsvDKc2YnzV44Y+9Sv7IQZJnFcq0=;
        b=hisJW1c2FMmGjX4NVGHVgoXpRfPFKp/PSh/kQJoNN4BlIofNp7bmFsm/tOgqzEfYbJ
         MQe1XPgkprnCEnXlyR7qFiBMk44Nk1CtQe1Q/GLVaccXD5FF38+s9V6yNeJJgrSozyN1
         6mYETMc7+DZFA9SPkRl1ZbyhpqnBTIBoYvbaOiMzAPSXlY7vWFu2U8Kg2e9OgTUpHOtG
         RX2azW/7p+bqDtz49o//ZhW56R3Ilw/GkB2ZoRTuP4/762l+4cG/3HxoSzczM/fPbqy4
         2KRJCGSCthfIyevK2ZLY5IdJhynsjABYppUwjxkg5xaJnkZdfiUSUsp+XDbVVBNbcT6r
         nvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYYWBgD0hvEgobHPsqAnM9HVPlynj1sSjgoNFvW0G8GbQYejrVLggXtxiJ0ovwk0lbv87ufZ9XNQa36A4Of2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N8fO3IlObfaW/EJpyUBlgg0AVHi2W6BPUXdhSh/wrPLSVuLb
	Y1KENoVeutpOlZqAH4e7XzZYJQkqj7VT4ZjIzBtXLtQ7q9PT9UxunGDwtf3A7ZkQed0=
X-Gm-Gg: ASbGnctfICIFjuJIYvHXDAuE5ezuaJ9z5aBFSQY8mrFzq+QsrBCeFW2eNqJy9JZeX4i
	jYBvqTuskaZ2O1FwGf9Pr3qAVwgPlA4D8l9doWbUZdwF7FILFOXdUK35ct9Z2n/XZODwn1OjstB
	6IqPYM9riGGKwPntiOjSXMAjbhixTxuEZ3pSRBkeT7fFOyKfF9t0s+1dIlwmnIXJrqcVIhX94MV
	SiiF+8+aBvKhsBn8TTdz1QLPonNZleT2tTeP1XxV1tz/NRlwrQCCJhD1uqIjQW/S0S2/YauQwTn
	46warMhI7dQd+kn2nSuCTQsy6c6Dw7r/lWUD/frbVHLN6GpruGv26iiOMyc0E/gNffsE8az7reT
	t+dECQY+PXKCv66cZIppeV0ONuB7UfY6g
X-Google-Smtp-Source: AGHT+IEyDj4erId7aawGI/VqypIEWKc7AcRxtwEhlRwUvhT5Xgkct9IWPfC1WhG/YZBxwkqZsdc1Bw==
X-Received: by 2002:a17:90b:3d07:b0:31e:beae:2934 with SMTP id 98e67ed59e1d1-31f5de4b8f5mr13878801a91.18.1754004035067;
        Thu, 31 Jul 2025 16:20:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:35 -0700
Subject: [PATCH v19 25/27] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-25-09b468d7beab@rivosinc.com>
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


