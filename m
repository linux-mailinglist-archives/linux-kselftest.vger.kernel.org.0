Return-Path: <linux-kselftest+bounces-31047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A6A91BD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428CC19E44C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6C24291E;
	Thu, 17 Apr 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E/hxaD8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F923FC7D
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892643; cv=none; b=hMhmJPBrMoeRXM2RBUu3FHXy2tBK1MonpVmdQXFCdwWPeN2cpKR1KcbesqY4PJ5qkNhsCvGn1Wi162UtSw8QJ1rQK/Uab0CwD0eF4+Ai2KYO37i6u/0LRrnZuO9tM61CXT93bQEnYNDOVnuv3gN/gWhXWwTEM4vHxRINBuQhd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892643; c=relaxed/simple;
	bh=Q+sBsPv9OaCNYi+DWXPtzAoJfNmpvcjXW23vs36lO2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEN/YUu5/GwyeKJqB6APxLtDfNAUwBKQZu1/qdEFWMxYZz3YYWRA1W6wzdDlfPnxy8vJ49eRNEqdORMxMtxuuQlk9Anvh29lcxQPx8cqTHI4j69S/tsbaGuhKjEiLJNLbrSOfzGUvNwWT1TogpxSutXS0CguEdRQIsxmahLjLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E/hxaD8l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so7765555ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892640; x=1745497440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phEa7dcEzmBTgDMqbJRuOlR5YT1C9gMt2qJgUlEtugc=;
        b=E/hxaD8lUzPvZn8+SZ3cTjrpAEdsscNM9WwMSNhdxsaLO0fNYREIsQx0Z8Rk5DSmSj
         1+5WwJTzRYOCNVba554siqeRQPq2zcNyVwDTo6shyFIRfa2WEPqC+/OzofUjKNL/j/ti
         43CzhvEvWnXeOlkhpJ/oWuUlL31Md+rqgoxH8nnh4ldgvS6m2ZSJjd9flos3DVhryB3V
         KJjEaUvXC1NZj7QVkfRseHqGG8L5G7BYKhLWRJxSsBaukEtarPhJuLqlHOf119CKO7TO
         apn847Ts1/za/jXPIsHUQnu+l6oaC6hr9aBCg+dMoL50hDTd0EblFgbk5yPSQUxgq9jB
         qssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892640; x=1745497440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phEa7dcEzmBTgDMqbJRuOlR5YT1C9gMt2qJgUlEtugc=;
        b=Itv6vM8yTxuLNfJZ0MUsoZn6TcdW7EH6nf+VqbCJh41NkFDyAzdl4tnf8FIUwEzmGD
         A+/40HEjOxr0dqe3LhIszA6dv1N4KskSzb2ldPzCW1qjA8Uf8pK0zJoCzz4cl1hoDfsR
         0znCI2PLUGKA4DLmaxgS0IkEVXN3CCX+DIWbyYkBxMYixfBwvgvuOnKssLf6r6TBNHt8
         oBi6PF5cxxQQ2RBXSFP5u6+a2Id6LMzjnkHbFiQ0CEguTR0Xbk8DTrXicf0LWHcfgOD8
         RLqmcXrh88l38ueCFvFtjJMfS+H4qoNSQZ9iLEq+nLXQJD2agVU+NOfRbnsralfcdQ6v
         iFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwftBlEIWRvxXTpq5nr18KKRnwljQNX/rBKp0MBMp9BQlo0vmnPSShY6EWjrAPSsDftU2LkvVtpOVduF0DuTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF60gL3a7ZHiGuNeAvmLLZfjDy4fguUKXsKNKQupqk+L7IiQB8
	kJtG4o/8fYbgD83fIOsu8eBD5rXDG7mGPSpT3S6TY6xFjpO9vfIPUrA4K6xMpzE=
X-Gm-Gg: ASbGncsrifsYIXmbeSYcLEBwgxVHV4UQHgLUQhQCT9SdvAZrHYuDSCZ3LsQTsMSxRS7
	+SNjP7fPxht661i2ACY1EgTbRh/qccEreDmb52j65JuxR7h0eR8+yW7jwJq7QKMGI/XjFvZS/uA
	3hHimqA9N/rJ6l8dVy/TcjIuX0iGsoB5lSAYk1jkDxwxtIY/EG5A+bhszLPcRD0JzigMUf1hjVI
	gi1b03oULEtphp6EYhSY2P33wo8AeDTkw+bKINL5TujjSK5JM16TMR7YVCY6LjohRoTQviP0f8K
	il23nLDkkv5F6a5+XDsaUs2ov920fLychiEAqVMV2g==
X-Google-Smtp-Source: AGHT+IFlc3NJ/iHnmfj5+tOAWrw6nyRe244Guo/NDK5DYXnnNzYpSWLwODKvV6ATsQsDyZwCjTnoTw==
X-Received: by 2002:a17:903:2383:b0:229:1717:8826 with SMTP id d9443c01a7336-22c358fd48bmr94947295ad.28.1744892639855;
        Thu, 17 Apr 2025 05:23:59 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:23:58 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 00/13] riscv: add SBI FWFT misaligned exception delegation support
Date: Thu, 17 Apr 2025 14:19:47 +0200
Message-ID: <20250417122337.547969-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SBI Firmware Feature extension allows the S-mode to request some
specific features (either hardware or software) to be enabled. This
series uses this extension to request misaligned access exception
delegation to S-mode in order to let the kernel handle it. It also adds
support for the KVM FWFT SBI extension based on the misaligned access
handling infrastructure.

FWFT SBI extension is part of the SBI V3.0 specifications [1]. It can be
tested using the qemu provided at [2] which contains the series from
[3]. Upstream kvm-unit-tests can be used inside kvm to tests the correct
delegation of misaligned exceptions. Upstream OpenSBI can be used.

Note: Since SBI V3.0 is not yet ratified, FWFT extension API is split
between interface only and implementation, allowing to pick only the
interface which do not have hard dependencies on SBI.

The tests can be run using the kselftest from series [4].

$ qemu-system-riscv64 \
	-cpu rv64,trap-misaligned-access=true,v=true \
	-M virt \
	-m 1024M \
	-bios fw_dynamic.bin \
	-kernel Image
 ...

 # ./misaligned
 TAP version 13
 1..23
 # Starting 23 tests from 1 test cases.
 #  RUN           global.gp_load_lh ...
 #            OK  global.gp_load_lh
 ok 1 global.gp_load_lh
 #  RUN           global.gp_load_lhu ...
 #            OK  global.gp_load_lhu
 ok 2 global.gp_load_lhu
 #  RUN           global.gp_load_lw ...
 #            OK  global.gp_load_lw
 ok 3 global.gp_load_lw
 #  RUN           global.gp_load_lwu ...
 #            OK  global.gp_load_lwu
 ok 4 global.gp_load_lwu
 #  RUN           global.gp_load_ld ...
 #            OK  global.gp_load_ld
 ok 5 global.gp_load_ld
 #  RUN           global.gp_load_c_lw ...
 #            OK  global.gp_load_c_lw
 ok 6 global.gp_load_c_lw
 #  RUN           global.gp_load_c_ld ...
 #            OK  global.gp_load_c_ld
 ok 7 global.gp_load_c_ld
 #  RUN           global.gp_load_c_ldsp ...
 #            OK  global.gp_load_c_ldsp
 ok 8 global.gp_load_c_ldsp
 #  RUN           global.gp_load_sh ...
 #            OK  global.gp_load_sh
 ok 9 global.gp_load_sh
 #  RUN           global.gp_load_sw ...
 #            OK  global.gp_load_sw
 ok 10 global.gp_load_sw
 #  RUN           global.gp_load_sd ...
 #            OK  global.gp_load_sd
 ok 11 global.gp_load_sd
 #  RUN           global.gp_load_c_sw ...
 #            OK  global.gp_load_c_sw
 ok 12 global.gp_load_c_sw
 #  RUN           global.gp_load_c_sd ...
 #            OK  global.gp_load_c_sd
 ok 13 global.gp_load_c_sd
 #  RUN           global.gp_load_c_sdsp ...
 #            OK  global.gp_load_c_sdsp
 ok 14 global.gp_load_c_sdsp
 #  RUN           global.fpu_load_flw ...
 #            OK  global.fpu_load_flw
 ok 15 global.fpu_load_flw
 #  RUN           global.fpu_load_fld ...
 #            OK  global.fpu_load_fld
 ok 16 global.fpu_load_fld
 #  RUN           global.fpu_load_c_fld ...
 #            OK  global.fpu_load_c_fld
 ok 17 global.fpu_load_c_fld
 #  RUN           global.fpu_load_c_fldsp ...
 #            OK  global.fpu_load_c_fldsp
 ok 18 global.fpu_load_c_fldsp
 #  RUN           global.fpu_store_fsw ...
 #            OK  global.fpu_store_fsw
 ok 19 global.fpu_store_fsw
 #  RUN           global.fpu_store_fsd ...
 #            OK  global.fpu_store_fsd
 ok 20 global.fpu_store_fsd
 #  RUN           global.fpu_store_c_fsd ...
 #            OK  global.fpu_store_c_fsd
 ok 21 global.fpu_store_c_fsd
 #  RUN           global.fpu_store_c_fsdsp ...
 #            OK  global.fpu_store_c_fsdsp
 ok 22 global.fpu_store_c_fsdsp
 #  RUN           global.gen_sigbus ...
 [12797.988647] misaligned[618]: unhandled signal 7 code 0x1 at 0x0000000000014dc0 in misaligned[4dc0,10000+76000]
 [12797.988990] CPU: 0 UID: 0 PID: 618 Comm: misaligned Not tainted 6.13.0-rc6-00008-g4ec4468967c9-dirty #51
 [12797.989169] Hardware name: riscv-virtio,qemu (DT)
 [12797.989264] epc : 0000000000014dc0 ra : 0000000000014d00 sp : 00007fffe165d100
 [12797.989407]  gp : 000000000008f6e8 tp : 0000000000095760 t0 : 0000000000000008
 [12797.989544]  t1 : 00000000000965d8 t2 : 000000000008e830 s0 : 00007fffe165d160
 [12797.989692]  s1 : 000000000000001a a0 : 0000000000000000 a1 : 0000000000000002
 [12797.989831]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffffdeadbeef
 [12797.989964]  a5 : 000000000008ef61 a6 : 626769735f6e0000 a7 : fffffffffffff000
 [12797.990094]  s2 : 0000000000000001 s3 : 00007fffe165d838 s4 : 00007fffe165d848
 [12797.990238]  s5 : 000000000000001a s6 : 0000000000010442 s7 : 0000000000010200
 [12797.990391]  s8 : 000000000000003a s9 : 0000000000094508 s10: 0000000000000000
 [12797.990526]  s11: 0000555567460668 t3 : 00007fffe165d070 t4 : 00000000000965d0
 [12797.990656]  t5 : fefefefefefefeff t6 : 0000000000000073
 [12797.990756] status: 0000000200004020 badaddr: 000000000008ef61 cause: 0000000000000006
 [12797.990911] Code: 8793 8791 3423 fcf4 3783 fc84 c737 dead 0713 eef7 (c398) 0001
 #            OK  global.gen_sigbus
 ok 23 global.gen_sigbus
 # PASSED: 23 / 23 tests passed.
 # Totals: pass:23 fail:0 xfail:0 xpass:0 skip:0 error:0

With kvm-tools:

 # lkvm run -k sbi.flat -m 128
  Info: # lkvm run -k sbi.flat -m 128 -c 1 --name guest-97
  Info: Removed ghost socket file "/root/.lkvm//guest-97.sock".

 ##########################################################################
 #    kvm-unit-tests
 ##########################################################################

 ... [test messages elided]
 PASS: sbi: fwft: FWFT extension probing no error
 PASS: sbi: fwft: get/set reserved feature 0x6 error == SBI_ERR_DENIED
 PASS: sbi: fwft: get/set reserved feature 0x3fffffff error == SBI_ERR_DENIED
 PASS: sbi: fwft: get/set reserved feature 0x80000000 error == SBI_ERR_DENIED
 PASS: sbi: fwft: get/set reserved feature 0xbfffffff error == SBI_ERR_DENIED
 PASS: sbi: fwft: misaligned_deleg: Get misaligned deleg feature no error
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature invalid value error
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature invalid value error
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value no error
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value 0
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value no error
 PASS: sbi: fwft: misaligned_deleg: Set misaligned deleg feature value 1
 PASS: sbi: fwft: misaligned_deleg: Verify misaligned load exception trap in supervisor
 SUMMARY: 50 tests, 2 unexpected failures, 12 skipped

This series is available at [5].

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/vv3.0-rc2/riscv-sbi.pdf [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/misaligned [2]
Link: https://lore.kernel.org/all/20241211211933.198792-3-fkonrad@amd.com/T/ [3]
Link: https://lore.kernel.org/linux-riscv/20250414123543.1615478-1-cleger@rivosinc.com [4]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/fwft [5]
---

V5:
 - Return ERANGE as mapping for SBI_ERR_BAD_RANGE
 - Removed unused sbi_fwft_get()
 - Fix kernel for sbi_fwft_local_set_cpumask()
 - Fix indentation for sbi_fwft_local_set()
 - Remove spurious space in kvm_sbi_fwft_ops.
 - Rebased on origin/master
 - Remove fixes commits and sent them as a separate series [4]

V4:
 - Check SBI version 3.0 instead of 2.0 for FWFT presence
 - Use long for kvm_sbi_fwft operation return value
 - Init KVM sbi extension even if default_disabled
 - Remove revert_on_fail parameter for sbi_fwft_feature_set().
 - Fix comments for sbi_fwft_set/get()
 - Only handle local features (there are no globals yet in the spec)
 - Add new SBI errors to sbi_err_map_linux_errno()

V3:
 - Added comment about kvm sbi fwft supported/set/get callback
   requirements
 - Move struct kvm_sbi_fwft_feature in kvm_sbi_fwft.c
 - Add a FWFT interface

V2:
 - Added Kselftest for misaligned testing
 - Added get_user() usage instead of __get_user()
 - Reenable interrupt when possible in misaligned access handling
 - Document that riscv supports unaligned-traps
 - Fix KVM extension state when an init function is present
 - Rework SBI misaligned accesses trap delegation code
 - Added support for CPU hotplugging
 - Added KVM SBI reset callback
 - Added reset for KVM SBI FWFT lock
 - Return SBI_ERR_DENIED_LOCKED when LOCK flag is set

Clément Léger (13):
  riscv: sbi: add Firmware Feature (FWFT) SBI extensions definitions
  riscv: sbi: add new SBI error mappings
  riscv: sbi: add FWFT extension interface
  riscv: sbi: add SBI FWFT extension calls
  riscv: misaligned: request misaligned exception from SBI
  riscv: misaligned: use on_each_cpu() for scalar misaligned access
    probing
  riscv: misaligned: use correct CONFIG_ ifdef for
    misaligned_access_speed
  riscv: misaligned: move emulated access uniformity check in a function
  riscv: misaligned: add a function to check misalign trap delegability
  RISC-V: KVM: add SBI extension init()/deinit() functions
  RISC-V: KVM: add SBI extension reset callback
  RISC-V: KVM: add support for FWFT SBI extension
  RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG

 arch/riscv/include/asm/cpufeature.h        |   8 +-
 arch/riscv/include/asm/kvm_host.h          |   5 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h      |  12 +
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  29 +++
 arch/riscv/include/asm/sbi.h               |  60 +++++
 arch/riscv/include/uapi/asm/kvm.h          |   1 +
 arch/riscv/kernel/sbi.c                    |  75 ++++++
 arch/riscv/kernel/traps_misaligned.c       | 110 ++++++++-
 arch/riscv/kernel/unaligned_access_speed.c |   8 +-
 arch/riscv/kvm/Makefile                    |   1 +
 arch/riscv/kvm/vcpu.c                      |   7 +-
 arch/riscv/kvm/vcpu_sbi.c                  |  54 +++++
 arch/riscv/kvm/vcpu_sbi_fwft.c             | 252 +++++++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_sta.c              |   3 +-
 14 files changed, 610 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
 create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c

-- 
2.49.0


