Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CE6CAA9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC0QcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjC0QcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 12:32:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4AE2119
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 09:32:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w4so8936091plg.9
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679934732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ibFYdC69vwh3wjMmxSSppBubSMnCe0A/BNmyM8WJo=;
        b=tdDuf8vCsa1FE+tL+mI/XIjaZMDmBPF26iD2hq06oL/mfaeObs+EkJBJl8/OI5xGDL
         QpKD0qVOcJW2bv1mz39UUFW1ExIVG0NZ5BqHXapjKQ8Xvv1TqZodP1umyNUWg+dHwBTm
         eWCiLqyy/7u1C9LS14BuhKWbfB5P/FCBk9fCl+TXFPA3o0Wf7CWGGKdR1ik3oDJWJqqk
         ca18O6dxhSenEvxrqSwCH0np+jX0xjAQ3NZqoQx6HiSAk4PCZyLk8h3o+nw4g5IKcDSt
         UAyYsPgZ3dLnTuNAHzTKE6GUyYTeazWeZhK8tsuhDD8vFhVNcBPb4p0HtkMyPPRqhgNc
         yCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/ibFYdC69vwh3wjMmxSSppBubSMnCe0A/BNmyM8WJo=;
        b=rqsvqDBGW9jQVQP3GrldCQnxrQqcK1hfRZ12qlhvRrpqXtkiNWGZdOhcR4QNXcNcHf
         Rr7CrzqERBIIh6gsJcz+AHHYQeEZZqgRwe05PzrDGwFguYBqTGZtjJv5Yu4O8bgGWQzc
         AyljS3z2j93xHBXQoAobxQIsqTMfEoZ3MnLWH8hO0cN9V1vE7aV/iAZ7ifiA7YUC6Czz
         a8fKDx04fRaMNRq+LHUPsc8t9UxaYptVfkq6G0mEIVC2ROfyYABl69m2jLQl9ut4m/up
         vLEi/yVTWgS3yZuXkHJxq0gLfIED8clOfsKt3ELx/QuKZL8yNF8zWH7zFbK+/trK5V7c
         DCmQ==
X-Gm-Message-State: AAQBX9fCOBxXGHV3QBXo+unfjj4KrNtR5OlrCNMfLnwGS32Te9UFt4n3
        BLBeMyd2uJH6dxWoyPVnD2qm0g==
X-Google-Smtp-Source: AKy350ZoLUqwI2Gu38GSeNj8EmtocvW2en1v6pQ13CgZqJmkofX1ql2bIW0hKvEbNaycl0IEwZCpMA==
X-Received: by 2002:a17:90a:18e:b0:237:24eb:99d8 with SMTP id 14-20020a17090a018e00b0023724eb99d8mr13799736pjc.19.1679934732259;
        Mon, 27 Mar 2023 09:32:12 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001a1faeac240sm8963524plb.186.2023.03.27.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:32:11 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/6] RISC-V Hardware Probing User Interface
Date:   Mon, 27 Mar 2023 09:31:57 -0700
Message-Id: <20230327163203.2918455-1-evan@rivosinc.com>
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
ifunc selector for memcpy can be found at [1]. I'm about to send a v2
of that series out that incorporates the vDSO function.

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

[1] https://public-inbox.org/libc-alpha/20230206194819.1679472-1-evan@rivosinc.com/T/#t
[2] https://pastebin.com/x84NEKaS

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
 arch/riscv/kernel/sys_riscv.c                 | 225 +++++++++++++++++-
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
 28 files changed, 709 insertions(+), 14 deletions(-)
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

