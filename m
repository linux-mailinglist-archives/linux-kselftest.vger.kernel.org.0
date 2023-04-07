Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF906DB6ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 01:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDGXLP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDGXLP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 19:11:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C827A97
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Apr 2023 16:11:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so100660pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Apr 2023 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680909070; x=1683501070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rocRuzEBIvz/WJE6JRALdje/n5RMMD8SqL7OOf3w8UA=;
        b=bSyFeUK2s/cbL4N3XEY21Oky33cnHHSeqr65+TI6idzeev3fVhrk7/ceIaDaugZA9r
         pioYtG61oiFqvED2GoFc4YqJaoLpkiNwBnlBAGyBAQiJCK57Lz6MjK1n1U1lHFzWUJvz
         Lkil9Fvjdot12d7MOatulLPBTz3acxVEPJlTdQSKkUhovfXWJWjSnNPJnk5avD9/xT1A
         kREG2lBpdBDBJGWjEelv+Jg3kuoO9S/Q/w9PVBz7jQ93NbSGFhLGfQhJ5QYH0d4dAU3F
         zISqWk5BvpFbbtXHm65RbhFmEd37CoHjoPWXTxmg1KQBzgMl1FTHBI0ucoutC/pLlFK5
         dLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909070; x=1683501070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rocRuzEBIvz/WJE6JRALdje/n5RMMD8SqL7OOf3w8UA=;
        b=WBM9Si6dG1lj2kzFgHZ85hWVpPTau1p66Zox0lAeb+dRRhm68jWUFqm/ZgDhgiT087
         G97oF0LLJavcegGCW/ws1lJkA2FUkthRwsrrZ2d5CJxUauh6LeHP6XTYxd/rSUK1ftoh
         mlvsToWmp8q/In2OLZR5YghpfItTZWsgwjdzd0UogbYTOBkccTihLlMfFgnEcfqNUxuQ
         djX0Squ8Q5U0oXOOW/AIvUOv7D8H6h/qyih3g4lrSbdFJ/i81jvbyyoqRgzuCyZFQ/MR
         W8e0AQq6Di2jvFuthn7rAfw13SWLXUGV30CQRx2YV4bsdj08fCMqI7m8nQKqRNbsuaoa
         eeIg==
X-Gm-Message-State: AAQBX9fNpcMFNP+Va+v8PFrmSZZgbRVJM/CB2lgBPvz33uE3h/wqWpxD
        1unFgmZUZ3nVq/K0C4SgbBmIjQ==
X-Google-Smtp-Source: AKy350Y5i+h1yHva73VwDp0Oc4DjyjVhD+PWIs2OnwnJsGLEOJtWc6IabUoQm5VwnlHHMNAO/wtiew==
X-Received: by 2002:a17:903:234c:b0:1a1:9787:507d with SMTP id c12-20020a170903234c00b001a19787507dmr3835653plh.3.1680909069797;
        Fri, 07 Apr 2023 16:11:09 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm3361526pls.216.2023.04.07.16.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:11:09 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v6 0/6] RISC-V Hardware Probing User Interface
Date:   Fri,  7 Apr 2023 16:10:57 -0700
Message-Id: <20230407231103.2622178-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


There's been a bunch of off-list discussions about this, including at
Plumbers.  The original plan was to do something involving providing an
ISA string to userspace, but ISA strings just aren't sufficient for a
stable ABI any more: in order to parse an ISA string users need the
version of the specifications that the string is written to, the version
of each extension (sometimes at a finer granularity than the RISC-V
releases/versions encode), and the expected use case for the ISA string
(ie, is it a U-mode or M-mode string).  That's a lot of complexity to
try and keep ABI compatible and it's probably going to continue to grow,
as even if there's no more complexity in the specifications we'll have
to deal with the various ISA string parsing oddities that end up all
over userspace.

Instead this patch set takes a very different approach and provides a set
of key/value pairs that encode various bits about the system.  The big
advantage here is that we can clearly define what these mean so we can
ensure ABI stability, but it also allows us to encode information that's
unlikely to ever appear in an ISA string (see the misaligned access
performance, for example).  The resulting interface looks a lot like
what arm64 and x86 do, and will hopefully fit well into something like
ACPI in the future.

The actual user interface is a syscall, with a vDSO function in front of
it. The vDSO function can answer some queries without a syscall at all,
and falls back to the syscall for cases it doesn't have answers to.
Currently we prepopulate it with an array of answers for all keys and
a CPU set of "all CPUs". This can be adjusted as necessary to provide
fast answers to the most common queries.

An example series in glibc exposing this syscall and using it in an
ifunc selector for memcpy can be found at [1].

I was asked about the performance delta between this and something like
sysfs. I created a small test program [2] and ran it on a Nezha D1
Allwinner board. Doing each operation 100000 times and dividing, these
operations take the following amount of time:
 - open()+read()+close() of /sys/kernel/cpu_byteorder: 3.8us
 - access("/sys/kernel/cpu_byteorder", R_OK): 1.3us
 - riscv_hwprobe() vDSO and syscall: .0094us
 - riscv_hwprobe() vDSO with no syscall: 0.0091us

These numbers get farther apart if we query multiple keys, as sysfs will
scale linearly with the number of keys, where the dedicated syscall
stays the same. To frame these numbers, I also did a tight
fork/exec/wait loop, which I measured as 4.8ms. So doing 4
open/read/close operations is a delta of about 0.3%, versus a single vDSO
call is a delta of essentially zero.

[1] https://patchwork.ozlabs.org/project/glibc/list/?series=343050
[2] https://pastebin.com/x84NEKaS

Changes in v6:
 - Remove spurious blank line (Conorbot)
 - Update copyrights (Paul)
 - Update copyrights (Paul)
 - Wrap init_hwprobe_vdso_data() in CONFIG_MMU to fix nommu build break
   (Conorbot)
 - Update copyrights (Paul)

Changes in v5:
 - Added tags
 - Fixed misuse of ISA_EXT_c as bitmap, changed to use
   riscv_isa_extension_available() (Heiko, Conor)
 - Document the alternatives approach in the commit message (Conor and
   Heiko).
 - Fix __init call warnings by making probe_vendor_features() and
   thead_feature_probe_func() __init_or_module.
 - Fixed compat vdso compilation failure (lkp).

Changes in v4:
 - Used real types in syscall prototypes (Arnd)
 - Fixed static line break in do_riscv_hwprobe() (Conor)
 - Added newlines between documentation lists (Conor)
 - Crispen up size types to size_t, and cpu indices to int (Joe)
 - Fix copy_from_user() return logic bug (found via kselftests!)
 - Add __user to SYSCALL_DEFINE() to fix warning
 - More newlines in BASE_BEHAVIOR_IMA documentation (Conor)
 - Add newlines to CPUPERF_0 documentation (Conor)
 - Add UNSUPPORTED value (Conor)
 - Switched from DT to alternatives-based probing (Rob)
 - Crispen up cpu index type to always be int (Conor)
 - Fixed selftests commit description, no more tiny libc (Mark Brown)
 - Fixed selftest syscall prototype types to match v4.
 - Added a prototype to fix -Wmissing-prototype warning (lkp@intel.com)
 - Fixed rv32 build failure (lkp@intel.com)
 - Make vdso prototype match syscall types update

Changes in v3:
 - Updated copyright date in cpufeature.h
 - Fixed typo in cpufeature.h comment (Conor)
 - Refactored functions so that kernel mode can query too, in
   preparation for the vDSO data population.
 - Changed the vendor/arch/imp IDs to return a value of -1 on mismatch
   rather than failing the whole call.
 - Const cpumask pointer in hwprobe_mid()
 - Embellished documentation WRT cpu_set and the returned values.
 - Renamed hwprobe_mid() to hwprobe_arch_id() (Conor)
 - Fixed machine ID doc warnings, changed elements to c:macro:.
 - Completed dangling unistd.h comment (Conor)
 - Fixed line breaks and minor logic optimization (Conor).
 - Use riscv_cached_mxxxid() (Conor)
 - Refactored base ISA behavior probe to allow kernel probing as well,
   in prep for vDSO data initialization.
 - Fixed doc warnings in IMA text list, use :c:macro:.
 - Have hwprobe_misaligned return int instead of long.
 - Constify cpumask pointer in hwprobe_misaligned()
 - Fix warnings in _PERF_O list documentation, use :c:macro:.
 - Move include cpufeature.h to misaligned patch.
 - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
 - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
 - Break early in misaligned access iteration (Conor)
 - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED future
   value (Conor)
 - Introduced vDSO function

Changes in v2:
 - Factored the move of struct riscv_cpuinfo to its own header
 - Changed the interface to look more like poll(). Rather than supplying
   key_offset and getting back an array of values with numerically
   contiguous keys, have the user pre-fill the key members of the array,
   and the kernel will fill in the corresponding values. For any key it
   doesn't recognize, it will set the key of that element to -1. This
   allows usermode to quickly ask for exactly the elements it cares
   about, and not get bogged down in a back and forth about newer keys
   that older kernels might not recognize. In other words, the kernel
   can communicate that it doesn't recognize some of the keys while
   still providing the data for the keys it does know.
 - Added a shortcut to the cpuset parameters that if a size of 0 and
   NULL is provided for the CPU set, the kernel will use a cpu mask of
   all online CPUs. This is convenient because I suspect most callers
   will only want to act on a feature if it's supported on all CPUs, and
   it's a headache to dynamically allocate an array of all 1s, not to
   mention a waste to have the kernel loop over all of the offline bits.
 - Fixed logic error in if(of_property_read_string...) that caused crash
 - Include cpufeature.h in cpufeature.h to avoid undeclared variable
   warning.
 - Added a _MASK define
 - Fix random checkpatch complaints
 - Updated the selftests to the new API and added some more.
 - Fixed indentation, comments in .S, and general checkpatch complaints.

Evan Green (6):
  RISC-V: Move struct riscv_cpuinfo to new header
  RISC-V: Add a syscall for HW probing
  RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
  RISC-V: hwprobe: Support probing of misaligned access performance
  selftests: Test the new RISC-V hwprobe interface
  RISC-V: Add hwprobe vDSO function and data

 Documentation/riscv/hwprobe.rst               |  86 +++++++
 Documentation/riscv/index.rst                 |   1 +
 arch/riscv/Kconfig                            |   1 +
 arch/riscv/errata/thead/errata.c              |  10 +
 arch/riscv/include/asm/alternative.h          |   5 +
 arch/riscv/include/asm/cpufeature.h           |  23 ++
 arch/riscv/include/asm/hwprobe.h              |  13 +
 arch/riscv/include/asm/syscall.h              |   4 +
 arch/riscv/include/asm/vdso/data.h            |  17 ++
 arch/riscv/include/asm/vdso/gettimeofday.h    |   8 +
 arch/riscv/include/uapi/asm/hwprobe.h         |  37 +++
 arch/riscv/include/uapi/asm/unistd.h          |   9 +
 arch/riscv/kernel/alternative.c               |  19 ++
 arch/riscv/kernel/compat_vdso/Makefile        |   2 +-
 arch/riscv/kernel/cpu.c                       |   8 +-
 arch/riscv/kernel/cpufeature.c                |   3 +
 arch/riscv/kernel/smpboot.c                   |   1 +
 arch/riscv/kernel/sys_riscv.c                 | 228 +++++++++++++++++-
 arch/riscv/kernel/vdso.c                      |   6 -
 arch/riscv/kernel/vdso/Makefile               |   4 +
 arch/riscv/kernel/vdso/hwprobe.c              |  52 ++++
 arch/riscv/kernel/vdso/sys_hwprobe.S          |  15 ++
 arch/riscv/kernel/vdso/vdso.lds.S             |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/riscv/Makefile        |  58 +++++
 .../testing/selftests/riscv/hwprobe/Makefile  |  10 +
 .../testing/selftests/riscv/hwprobe/hwprobe.c |  90 +++++++
 .../selftests/riscv/hwprobe/sys_hwprobe.S     |  12 +
 28 files changed, 712 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/riscv/hwprobe.rst
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/include/asm/hwprobe.h
 create mode 100644 arch/riscv/include/asm/vdso/data.h
 create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
 create mode 100644 arch/riscv/kernel/vdso/hwprobe.c
 create mode 100644 arch/riscv/kernel/vdso/sys_hwprobe.S
 create mode 100644 tools/testing/selftests/riscv/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
 create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
 create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S

-- 
2.25.1

