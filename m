Return-Path: <linux-kselftest+bounces-26245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251DA2FC26
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36E9166D59
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960324CEE9;
	Mon, 10 Feb 2025 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IOYvdsU7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164631A3159
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223367; cv=none; b=ZIPPjJpp55uRvl3EieQ3+Bwr1Gcjr+Sl9wG2u9cJEbGlgPLNwoXHBjzYHPWgYR7yzEh/iRCNyyzrRO4cVyCE5QAt78PFLqJG97ZikBc5kBvAI6wXIM95yw7um6Im9qQoUvbJmDvzRGWMcI6BgK9EMPBGbnCc33mdM9ucIJgeiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223367; c=relaxed/simple;
	bh=jEkz+QiOaYAp2NfnlBujqXjuCX/+tViBFGDnVxkoxC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgwdKkdpwCId4hxsvaCx5ETD0m+bpnHg5CsvQd9vZwgqULCHlYNVIj3I2MOdRXHWAXL00rqhGkQ9Urs3BC+5uTE6qh+ZWyNif6PxGwSfkSQBwV62fXrXKBWXZf/yn4jxEiyWBbsJ3smRQXhxLdAhvTWTO0omtmGymA4FAxNGumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IOYvdsU7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438a39e659cso33490285e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223363; x=1739828163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yU4FXNF/aJSJZFUWClLEZsdkRc6GvSutSyHshCkXTg=;
        b=IOYvdsU7o1daVRWPRJIkDlbnwjPe7RxQ5oZRSKAlxgxeDXGTAy/QIanfvFP39UQsVy
         mVjSkslH4g5au9cbxigEMh4s0L43szU6FD/IpT/RETK+MMQHfdVWJjoV6f8aXpQb/EHm
         AOx5JOrDEbwEPefTDr5qHGTG0dIow0HEoT6O06laK2EhyTT/8qYuOXANYyBpyhn6YP1Q
         /031nuuqcJlIp+refzQU2t6DHwm8uoSciQSHPfg7K3MEJNribRHz37/Ag4Sw2pAvXglX
         7mit9sPEtP/ddrhcuXfTx53NkB9Qiw/W7asL9NpCKody4j80PziEycDmsPXCpKkkWnn4
         aNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223363; x=1739828163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yU4FXNF/aJSJZFUWClLEZsdkRc6GvSutSyHshCkXTg=;
        b=NUz+6g6NrDBm3CVYGPhW7VhyRPivnMRWUAgpxztXipGtu1LPip5lN3T5H0fvjy61hE
         xyA0n6qY3If45+uB4oZ2yP3GJDR03DFj0vymt15aFnWlRKeTyoobd8fQKqAynnLX+Xoj
         gOUWyPBjKwmOciMnqUDlC17ckJ473SlFlX+SHJaDLluLg8rsp7PQTTLDjMSt27O3AwUg
         k9aevxGdXXsvuWyb0NqBuIhjZjW64r+CCzqnsBkBGG/C8KpYEvNadh7AJxuDJT2zHofs
         bi0nt+nlY/SknNfGVg71ceEjxHP03jnHDY7zJpKgZuKN4DTNLekI/kjNRhea0Q853bDt
         gLfg==
X-Forwarded-Encrypted: i=1; AJvYcCWRIaBWk4Ajg1wJHjpgzodwSPaFMTvfg1j03nNKbvrF4HtOkhTikl2qiKZpDAPeqGjZ+d4Mlpr/Lzj5opLOzlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5kXsLh3erO8BbAWbn/4Sg6YYKm189KacseLaOIWOVG8Ut0Bl
	Ho9pX2P0OhBgPWT7jty6HyAi4llDZI6n6AZUrMIti59yaiUXunmk2f5okgGBb6c=
X-Gm-Gg: ASbGnctjFQ7wu0YvgkJl7A2Fp8aWhEztrH16xNuegNKBulu2Y79PqsSiQFHgHKX1AtZ
	eB8B86JlHe76fE5SQi2mM+dDSl7rwSjeOh8ducOhO9kszHcs/VG9n96qLU22SKm5aiMcUAWcowS
	+u6eE7oZm7H2ZQ2ZaBkt2a3QfTpwpTZ0rvrmkoFdkRrb0ONk3tQfOzZZlOXsxI0oSKrvSjrZwUp
	qWMGLCw2lBsqGBbws0i04TuDRBPBEO+vg1jk1y5QjEprFkhPhvUgoq66E/BqiaNi2Zi2vmv0ko1
	HEMJJMj6P6cYhfnZ
X-Google-Smtp-Source: AGHT+IFdcS4HQCNhje+KNC3N8lAKJy2LPgA9t1uWAzjtM8uA+e8s58Wwe4c6e5iEnxu0WhpQbc7aeg==
X-Received: by 2002:a05:600c:56d0:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-4392dfbd5d8mr96573665e9.13.1739223363313;
        Mon, 10 Feb 2025 13:36:03 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:02 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 00/15] riscv: add SBI FWFT misaligned exception delegation support
Date: Mon, 10 Feb 2025 22:35:33 +0100
Message-ID: <20250210213549.1867704-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
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
[3]. kvm-unit-tests [4] can be used inside kvm to tests the correct
delegation of misaligned exceptions. Upstream OpenSBI can be used.

The tests can be run using the included kselftest:

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

This series is available at [6].

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/vv3.0-rc2/riscv-sbi.pdf [1]
Link: https://github.com/rivosinc/qemu/tree/dev/cleger/misaligned [2]
Link: https://lore.kernel.org/all/20241211211933.198792-3-fkonrad@amd.com/T/ [3]
Link: https://github.com/clementleger/kvm-unit-tests/tree/dev/cleger/fwft_v1 [4]
Link: https://github.com/clementleger/unaligned_test [5]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/fwft_v1 [6]
---

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

Clément Léger (15):
  riscv: add Firmware Feature (FWFT) SBI extensions definitions
  riscv: misaligned: request misaligned exception from SBI
  riscv: misaligned: use on_each_cpu() for scalar misaligned access
    probing
  riscv: misaligned: use correct CONFIG_ ifdef for
    misaligned_access_speed
  riscv: misaligned: move emulated access uniformity check in a function
  riscv: misaligned: add a function to check misalign trap delegability
  riscv: misaligned: factorize trap handling
  riscv: misaligned: enable IRQs while handling misaligned accesses
  riscv: misaligned: use get_user() instead of __get_user()
  Documentation/sysctl: add riscv to unaligned-trap supported archs
  selftests: riscv: add misaligned access testing
  RISC-V: KVM: add SBI extension init()/deinit() functions
  RISC-V: KVM: add SBI extension reset callback
  RISC-V: KVM: add support for FWFT SBI extension
  RISC-V: KVM: add support for SBI_FWFT_MISALIGNED_DELEG

 Documentation/admin-guide/sysctl/kernel.rst   |   4 +-
 arch/riscv/include/asm/cpufeature.h           |   8 +-
 arch/riscv/include/asm/kvm_host.h             |   5 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  12 +
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |  37 +++
 arch/riscv/include/asm/sbi.h                  |  33 +++
 arch/riscv/include/uapi/asm/kvm.h             |   1 +
 arch/riscv/kernel/traps.c                     |  57 ++--
 arch/riscv/kernel/traps_misaligned.c          | 138 +++++++++-
 arch/riscv/kernel/unaligned_access_speed.c    |  11 +-
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu.c                         |   7 +-
 arch/riscv/kvm/vcpu_sbi.c                     |  58 ++++
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 226 ++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_sta.c                 |   3 +-
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 +++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
 21 files changed, 1137 insertions(+), 47 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
 create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
 create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
 create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
 create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
 create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c

-- 
2.47.2


