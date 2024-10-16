Return-Path: <linux-kselftest+bounces-19871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80F9A13CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C14E1F22870
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC81216A1D;
	Wed, 16 Oct 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="meQwn5kZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371B1CC893
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110501; cv=none; b=KqmF7nV4/rwoqoyoZdXfqFv5gBDklMHCrx2rcu2VeJVHkpj2dze9fkCaq7ARi1fCZ2cbAo0bYfzuSW1C7z05gnyYAVngnnz1f9GveWvCxkHqKRtOIEHJ3FFwd59NWehDrK44Vpzo5JBy7qdQVdVhIzMBrnPEByoqzO5xp2003PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110501; c=relaxed/simple;
	bh=/IaAt73yOV50Rg9XD7tq6+9kh5Tx32oTfZJbG3X6LJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMZ4RYknqIz+vMPKLRWXTRa7Ex19yoGpzpyVYsk03AESNBxvuXxtcvkoBQDVU5c4xRIj+SWhBUNnvSFyI7Zcv6zpeVYfSoQi0QNR4cBylfdrVQyoExp4QTIIatzNpST08z9ghq3xRt2yZffRTwD9JtmZW0foHLcPC7eymDQb+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=meQwn5kZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so171936a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110497; x=1729715297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEUhwJlktvJ9XLTxaEULHD6mXOGpKAbrtbb51ie7J44=;
        b=meQwn5kZPL4gTadyOGW6RP6T65gU/A6KbUonATaxVe7fd1ynAebBSu+ilB0tss0YAR
         Me2BV5lKtZg+T9ej/zWdXtVVCIOo5EiZ3m4tAzKATCL2r/rLpB1LPkqJS63FRhwr19HF
         vDoASh3XP7zXiJ4aSiGVvR6Sdrn8Alm0AF4jn0nacm4NwvZowOYWYs6tXb99V2TB7Mw3
         07OpsbaXCiWZot+Sd+1h3F1H+De/zQL79tzUHzooUOQScZXxBypTIgxg3P3CVc/uPXg3
         0TEaZBURykg3Kdg6JLN7V8T1oFDLmTnE1LQIKOygYYiEfPalX3Np/Ry+o22eqyV5S6Ll
         ljuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110497; x=1729715297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEUhwJlktvJ9XLTxaEULHD6mXOGpKAbrtbb51ie7J44=;
        b=ASxYPuhf4iYotwapP2/xYXD8jZoE3XEkEcTXs31NnICMZpIKqIMtK/WroemPBkHej5
         k8FIKkDIWdBzXmYDKZnQQhlwJSOcDhhLbTtYLL7Y4PNcxHJvTcURvYy6+8VcjrwcgH3X
         6Wbjq1gcArtPNTN0cR/TIdc14CsZOpDZHMcu1GRy+1WWI0KSpbSwVJu5FJwKSwY1pPkd
         /57x1KsTZcmT+K8De58a0EAEfJl1fSXaPvQUMUztgxB55tf3A74h+3NoidGbk+3W4a03
         Ie92g+8KD0T+6nynrk+tN86TVV983yV+PtYgpkb7wGoipzLDw3iwd1LBt5dT3bTnSCuY
         X4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXr0Uwd86omXtGnoTCzFy1OdG1IfHWPmi1Erbet8Q0NVtb/hl+NW/3ixJEE4cW6PQXO078xkgpr+ZhIhzTv3Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7k4uEjqj9aJknbiPghnIMZz47VAUqJZbJyJe5wB3oDIt0WAX
	nj5BvTeR15v3Te0igLmhXEKncsJvLqOivo72aQcgaCg2QLlnXs98oB9Wmdxn6xM=
X-Google-Smtp-Source: AGHT+IGllzymcOAYJ4F9gGwGiLHbUJdPlvukCb/zqDKpUvzRbezJlnGn7CSqgSzw6TP5Nt2/LjKHnQ==
X-Received: by 2002:a17:90b:4b8b:b0:2e2:9077:a3b4 with SMTP id 98e67ed59e1d1-2e3151b8a44mr21167547a91.7.1729110497313;
        Wed, 16 Oct 2024 13:28:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:16 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 00/10] riscv: Userspace pointer masking and tagged address ABI
Date: Wed, 16 Oct 2024 13:27:41 -0700
Message-ID: <20241016202814.4061541-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V defines three extensions for pointer masking[1]:
 - Smmpm: configured in M-mode, affects M-mode
 - Smnpm: configured in M-mode, affects the next lower mode (S or U-mode)
 - Ssnpm: configured in S-mode, affects the next lower mode (VS, VU, or U-mode)

This series adds support for configuring Smnpm or Ssnpm (depending on
which privilege mode the kernel is running in) to allow pointer masking
in userspace (VU or U-mode), extending the PR_SET_TAGGED_ADDR_CTRL API
from arm64. Unlike arm64 TBI, userspace pointer masking is not enabled
by default on RISC-V. Additionally, the tag width (referred to as PMLEN)
is variable, so userspace needs to ask the kernel for a specific tag
width, which is interpreted as a lower bound on the number of tag bits.

This series also adds support for a tagged address ABI similar to arm64
and x86. Since accesses from the kernel to user memory use the kernel's
pointer masking configuration, not the user's, the kernel must untag
user pointers in software before dereferencing them. And since the tag
width is variable, as with LAM on x86, it must be kept the same across
all threads in a process so untagged_addr_remote() can work.

[1]: https://github.com/riscv/riscv-j-extension/raw/d70011dde6c2/zjpm-spec.pdf
---
This series depends on the per-thread envcfg series in riscv/for-next.

This series can be tested in QEMU by applying a patch set[2].

KASAN_SW_TAGS using pointer masking is an independent patch series[3].

[2]: https://lore.kernel.org/qemu-devel/20240511101053.1875596-1-me@deliversmonkey.space/
[3]: https://lore.kernel.org/linux-riscv/20240814085618.968833-1-samuel.holland@sifive.com/

Changes in v5:
 - Update pointer masking spec version to 1.0 and state to ratified
 - Document how PR_[SG]ET_TAGGED_ADDR_CTRL are used on RISC-V
 - Document that the RISC-V tagged address ABI is the same as AArch64
 - Rename "pm" selftests directory to "abi" to be more generic
 - Fix -Wparentheses warnings
 - Fix order of operations when writing via the tagged pointer
 - Update pointer masking spec version to 1.0 in hwprobe documentation

Changes in v4:
 - Switch IS_ENABLED back to #ifdef to fix riscv32 build
 - Combine __untagged_addr() and __untagged_addr_remote()

Changes in v3:
 - Note in the commit message that the ISA extension spec is frozen
 - Rebase on riscv/for-next (ISA extension list conflicts)
 - Remove RISCV_ISA_EXT_SxPM, which was not used anywhere
 - Use shifts instead of large numbers in ENVCFG_PMM* macro definitions
 - Rename CONFIG_RISCV_ISA_POINTER_MASKING to CONFIG_RISCV_ISA_SUPM,
   since it only controls the userspace part of pointer masking
 - Use IS_ENABLED instead of #ifdef when possible
 - Use an enum for the supported PMLEN values
 - Simplify the logic in set_tagged_addr_ctrl()
 - Use IS_ENABLED instead of #ifdef when possible
 - Implement mm_untag_mask()
 - Remove pmlen from struct thread_info (now only in mm_context_t)

Changes in v2:
 - Drop patch 4 ("riscv: Define is_compat_thread()"), as an equivalent
   patch was already applied
 - Move patch 5 ("riscv: Split per-CPU and per-thread envcfg bits") to a
   different series[3]
 - Update pointer masking specification version reference
 - Provide macros for the extension affecting the kernel and userspace
 - Use the correct name for the hstatus.HUPMM field
 - Rebase on riscv/linux.git for-next
 - Add and use the envcfg_update_bits() helper function
 - Inline flush_tagged_addr_state()
 - Implement untagged_addr_remote()
 - Restrict PMLEN changes once a process is multithreaded
 - Rename "tags" directory to "pm" to avoid .gitignore rules
 - Add .gitignore file to ignore the compiled selftest binary
 - Write to a pipe to force dereferencing the user pointer
 - Handle SIGSEGV in the child process to reduce dmesg noise
 - Export Supm via hwprobe
 - Export Smnpm and Ssnpm to KVM guests

Samuel Holland (10):
  dt-bindings: riscv: Add pointer masking ISA extensions
  riscv: Add ISA extension parsing for pointer masking
  riscv: Add CSR definitions for pointer masking
  riscv: Add support for userspace pointer masking
  riscv: Add support for the tagged address ABI
  riscv: Allow ptrace control of the tagged address ABI
  riscv: selftests: Add a pointer masking test
  riscv: hwprobe: Export the Supm ISA extension
  RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
  KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst          |   3 +
 Documentation/arch/riscv/uabi.rst             |  16 +
 .../devicetree/bindings/riscv/extensions.yaml |  18 +
 arch/riscv/Kconfig                            |  11 +
 arch/riscv/include/asm/csr.h                  |  16 +
 arch/riscv/include/asm/hwcap.h                |   5 +
 arch/riscv/include/asm/mmu.h                  |   7 +
 arch/riscv/include/asm/mmu_context.h          |  13 +
 arch/riscv/include/asm/processor.h            |   8 +
 arch/riscv/include/asm/switch_to.h            |  11 +
 arch/riscv/include/asm/uaccess.h              |  43 ++-
 arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
 arch/riscv/include/uapi/asm/kvm.h             |   2 +
 arch/riscv/kernel/cpufeature.c                |   3 +
 arch/riscv/kernel/process.c                   | 154 ++++++++
 arch/riscv/kernel/ptrace.c                    |  42 +++
 arch/riscv/kernel/sys_hwprobe.c               |   3 +
 arch/riscv/kvm/vcpu_onereg.c                  |   4 +
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |   5 +-
 .../selftests/kvm/riscv/get-reg-list.c        |   8 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore  |   1 +
 tools/testing/selftests/riscv/abi/Makefile    |  10 +
 .../selftests/riscv/abi/pointer_masking.c     | 332 ++++++++++++++++++
 25 files changed, 712 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/pointer_masking.c

-- 
2.45.1


