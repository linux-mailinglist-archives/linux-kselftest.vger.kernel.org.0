Return-Path: <linux-kselftest+bounces-28630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A46A59947
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D237A2EA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE122C34A;
	Mon, 10 Mar 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="05HQMVCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3332F22B584
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619569; cv=none; b=qc3Zx66JGDj3DQTLGF+ZZtwr/7kxJmgdO1G9t+3V/sniG7JTpF9GLwptIRJnpTTI6Nw8XBc+zFFFH0IHhcjGkRolbNwdpuvISBbc4cq9c8smWRcXF7cX/iCQJqaEIArCOh4RdwxMyTb8+4djMgBtwU0s2EEJrwyxX/wq97yEVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619569; c=relaxed/simple;
	bh=1qnx4OrvHqAIC29AcSnbIqDkJTwGbkzUZMhfXmg4zZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PWnRZZGnsu5DkM9sLlDMhsmALbeFLpE7PYGvJi1cVQ1iaImQx+yfVV5e/I3PSl/lQSOicwjfSEad69yqowdtLwtWEPsHy+mgrcL9TIbQ/Kt8CDNC/lD4dA8k7I55pPawkeBkdtRvfs5A1lVpmKEQs5Wuy9Wl1HhM3x6VEoujlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=05HQMVCv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239c066347so74840675ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619566; x=1742224366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WET834fPtyfjXUSYYGbdV0Bszy0RPsJUskkYImXS/yw=;
        b=05HQMVCvOgyk3ien7Ecn04rtqVILOsyeoEDUVYu/3pSaGApVbkZLVqI2MOSwhJ6epU
         Ud8VUSNEkXaubsK5pbGnrqsPmV2EP1wtzFjZ71x4BNjMJBeTiKBxtMtUZKqW+2Let/iD
         Rs9iL0hIiqNip+ZBHie2dnHf3EDpFnDbWCtxKqLTmjIiAZMSkCy63ckC17Im3YYgnC5M
         JALTVNhmsLV+eW0R+N9Vrj3SyJQemCiVp0AxOT2goSivP6LdXY0l5CgYefY8qKghFzXk
         F3CTEs6dJad470Jwnweai5Zj+wdQ1ynf0J2zXehnfz4zDjhuNhVcdjBgSckWCYIFOWiR
         piTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619566; x=1742224366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WET834fPtyfjXUSYYGbdV0Bszy0RPsJUskkYImXS/yw=;
        b=SRDR6Vnm3Gt2Z1jexHOrMbEmQLatFsgV+A+SEJ7f1Tcl9gp0/RHa1c2GuIuiPPwie3
         dq37nkPPfRoAp4Es2xTB9QQo0H+9QOZE5xD+vdpxvZDwcXnGtWxRQOkPsA3t7HUO1und
         0seYt/nEeRBU9CJuaVmJbsjiPvvKU/vGu4tgI+s2ogrX4TzIlOqTtYHO0ONC+vXYashe
         lXk0wNzN2/KgmE1OWQZ2POr/jDduIY+LF1WIwbu25l9WdH9MRfkCJ9HSdG7vaKnkDPBD
         +aBalLomXHqG17ckRGbqRx4NKeNO1n5TRywfeGJiFaCaqgKkmSXv5XHQOrv7N9sbtk1b
         hbkA==
X-Forwarded-Encrypted: i=1; AJvYcCV+rL2oLV6CzmWHctew+vvjPYzZWQwiRfwm5Ulecb75mNnMh2FVLm1k71io8RZu8GyqXX6DoYlu44epONWNilQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4qgv0iaWb397G8zpYa057e051QQ0KL4o32F2hC0Hchpf00tR
	EVaKD3pjYs9uGyk5FNQ/sNBswUkZ6pAH6sIyIeQDoqBtAhimqFBsj7z2YZvL3Gw=
X-Gm-Gg: ASbGncudFVfLtDxSVrnQ+gAXkGKF27IhWm5a/LmmtwJ+1cmV8hygk4qfmqpD5+ZVUvA
	OdWkG0wKA1+d3rJyzZvCHSlSA/I8qmf2vacOxoRSh8gS5aEhp4qHGvslI/X8ACfZh28nhbGfUtT
	Javf1Tl0+vJUjg5MeMVvX4sOy+lc/6Vu2O0qU7HpZcMBZZdaRvp2o72kYACRE0r6nQYTplgJgBH
	4mFCORu75280ZUs+seEvpINxSKLJDj/CDMWgf/vBoNqxItpEvx2hZmBTJ2tBhJXu7l2SArDQFbF
	ofFNGURfCYzNFC4a7INesVgrZcPo01m/J7U8JutkgKxbKQ==
X-Google-Smtp-Source: AGHT+IEDrhoKW7rr9/McSHUbkOLSWYi1sSzsVFxLf+Ak7uOZ2UAbwnGmTpmu6+G3w62SnxldCFFNoA==
X-Received: by 2002:a17:902:e5d2:b0:224:160d:3f5b with SMTP id d9443c01a7336-22428c1169cmr234143285ad.49.1741619566397;
        Mon, 10 Mar 2025 08:12:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:12:45 -0700 (PDT)
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
Subject: [PATCH v3 00/17] riscv: add SBI FWFT misaligned exception delegation support
Date: Mon, 10 Mar 2025 16:12:07 +0100
Message-ID: <20250310151229.2365992-1-cleger@rivosinc.com>
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

Note: Since SBI V3.0 is not yet ratified, FWFT extension API is split
between interface only and implementation, allowing to pick only the
interface which do not have hard dependencies on SBI.

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

Clément Léger (17):
  riscv: add Firmware Feature (FWFT) SBI extensions definitions
  riscv: sbi: add FWFT extension interface
  riscv: sbi: add SBI FWFT extension calls
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
 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |  31 +++
 arch/riscv/include/asm/sbi.h                  |  38 +++
 arch/riscv/include/uapi/asm/kvm.h             |   1 +
 arch/riscv/kernel/sbi.c                       | 123 +++++++++
 arch/riscv/kernel/traps.c                     |  57 ++--
 arch/riscv/kernel/traps_misaligned.c          | 119 +++++++-
 arch/riscv/kernel/unaligned_access_speed.c    |  11 +-
 arch/riscv/kvm/Makefile                       |   1 +
 arch/riscv/kvm/vcpu.c                         |   7 +-
 arch/riscv/kvm/vcpu_sbi.c                     |  57 ++++
 arch/riscv/kvm/vcpu_sbi_fwft.c                | 251 +++++++++++++++++
 arch/riscv/kvm/vcpu_sbi_sta.c                 |   3 +-
 .../selftests/riscv/misaligned/.gitignore     |   1 +
 .../selftests/riscv/misaligned/Makefile       |  12 +
 .../selftests/riscv/misaligned/common.S       |  33 +++
 .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
 tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
 .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
 22 files changed, 1264 insertions(+), 47 deletions(-)
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


