Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E39690EAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBIQ4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBIQ4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:56:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C8643D6
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 08:56:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so2942491pjd.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 08:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1B0P7kRw0A7INu1hUkCmO2swChbGm7ak1r7O2nw4cg=;
        b=akGeJBJYTsZpfLpuwHKiDhUMrQmm8DSQi1b5UQd4YNoJMaxQ1z3+Ds1rMzKquS0XNM
         b77gjLHEkKB1vEyyjBmLbv11nFDzM4Y2ZPa8yGpzRRpC5vzX0noLZB+gc5AM+L/5XdhQ
         Z1JcU+eieX0oEtZ5GJrLI+8cNAi6/5geW4qvJ2lbmpWl9Hn6HAWw1cWfoKxWZy+ZAZkA
         TopR1N7Wos7UvMinYLkG9d8DxsLV9Ynu3utVnuDzoygYS1uLERX5NohGwcglMOuQaGwY
         bnjIiEgbcG/fCh/G+OME0R/CCCkm1Lpojr00P2hGxZR2vCdfR9Hs1g98rjNo60DMTnOb
         KCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1B0P7kRw0A7INu1hUkCmO2swChbGm7ak1r7O2nw4cg=;
        b=hyIQsXjo1c9ieZhpBXuEWwLr3BI/4IkRjiz8S6FE96Q08AXOULax7Oe4LftxlI8YrK
         rv3ajxgqnrn+y72oEtunyepHsYLHyGh5XwxRypkSkIFFFQlGf97Hiv362QvS89/cnhT0
         Vvr0+A/3ZC3J2s7aHF0PL/E18G7FniBgtrUYmlCcQW65AgipxTgGK0RVDEH3xQCPjXRv
         uNmXRNBcgU0A7fBjIJyd/Qs1h6Z+L39YGinHzttn/3xmc2wnxUs/cD2aWXfxa+2zaWL7
         48XD81Xzf+gWHgItaeWk6qhg4PnwdbPsioQU3M3C1lEo+KrkmPS55GwnFwylFTreQXRw
         VZKw==
X-Gm-Message-State: AO0yUKXPK7QPkLfp3AmXW4NNBgFUqwsFCsqWr+NPkq1jbiBpqxoJHFxH
        sSJfhmd8ybhWQZlPnDXyrQBBow==
X-Google-Smtp-Source: AK7set+IFIC9LYMc/R+5eflMD1UV/9SFCKBMosB4sENh4YTE84tfbEm6BKrtA0yTtNBZBE2Hh+IVNg==
X-Received: by 2002:a05:6a21:1105:b0:bc:7bdd:551b with SMTP id oh5-20020a056a21110500b000bc7bdd551bmr9708617pzb.45.1675961796995;
        Thu, 09 Feb 2023 08:56:36 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id bt19-20020a632913000000b004dea53e52desm1544467pgb.27.2023.02.09.08.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:56:36 -0800 (PST)
Date:   Thu, 09 Feb 2023 08:56:36 -0800 (PST)
X-Google-Original-Date: Thu, 09 Feb 2023 08:56:33 PST (-0800)
Subject:     Re: [PATCH v2 0/6] RISC-V Hardware Probing User Interface
In-Reply-To: <de7fec14-7c43-6584-db72-b4c3a9f1423a@canonical.com>
CC:     evan@rivosinc.com, heiko@sntech.de, jszhang@kernel.org,
        linux-doc@vger.kernel.org, catalin.marinas@arm.com,
        abrestic@rivosinc.com, Atish Patra <atishp@rivosinc.com>,
        robh+dt@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        coelacanthus@outlook.com, krzysztof.kozlowski+dt@linaro.org,
        panqinglin2020@iscas.ac.cn, bagasdotme@gmail.com, shuah@kernel.org,
        linux-riscv@lists.infradead.org, corbet@lwn.net,
        xianting.tian@linux.alibaba.com, research_trasio@irq.a4lg.com,
        tklauser@distanz.ch, ajones@ventanamicro.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vineetg@rivosinc.com>, broonie@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, c141028@gmail.com,
        apatel@ventanamicro.com, linux-kselftest@vger.kernel.org,
        slewis@rivosinc.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        dramforever@live.com, guoren@kernel.org, daolu@rivosinc.com,
        jrtc27@jrtc27.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-3155d460-77a4-4edb-8e26-db4447bce07e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 06 Feb 2023 14:47:35 PST (-0800), heinrich.schuchardt@canonical.com wrote:
> On 2/6/23 22:11, Jessica Clarke wrote:
>> On 6 Feb 2023, at 20:14, Evan Green <evan@rivosinc.com> wrote:
>>>
>>>
>>> These are very much up for discussion, as it's a pretty big new user
>>> interface and it's quite a bit different from how we've historically
>>> done things: this isn't just providing an ISA string to userspace, this
>>> has its own format for providing information to userspace.
>>>
>>> There's been a bunch of off-list discussions about this, including at
>>> Plumbers.  The original plan was to do something involving providing an
>>> ISA string to userspace, but ISA strings just aren't sufficient for a
>>> stable ABI any more: in order to parse an ISA string users need the
>>> version of the specifications that the string is written to, the version
>>> of each extension (sometimes at a finer granularity than the RISC-V
>>> releases/versions encode), and the expected use case for the ISA string
>>> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
>>> try and keep ABI compatible and it's probably going to continue to grow,
>>> as even if there's no more complexity in the specifications we'll have
>>> to deal with the various ISA string parsing oddities that end up all
>>> over userspace.
>>>
>>> Instead this patch set takes a very different approach and provides a set
>>> of key/value pairs that encode various bits about the system.  The big
>>> advantage here is that we can clearly define what these mean so we can
>>> ensure ABI stability, but it also allows us to encode information that's
>>> unlikely to ever appear in an ISA string (see the misaligned access
>>> performance, for example).  The resulting interface looks a lot like
>>> what arm64 and x86 do, and will hopefully fit well into something like
>>> ACPI in the future.
>>>
>>> The actual user interface is a syscall.  I'm not really sure that's the
>>> right way to go about this, but it makes for flexible prototying.
>>> Various other approaches have been talked about like making HWCAP2 a
>>> pointer, having a VDSO routine, or exposing this via sysfs.  Those seem
>>> like generally reasonable approaches, but I've yet to figure out a way
>>> to get the general case working without a syscall as that's the only way
>>> I've come up with to deal with the heterogenous CPU case.  Happy to hear
>>> if someone has a better idea, though, as I don't really want to add a
>>> syscall if we can avoid it.
>
> Operating systems tend to reschedule threads moving them between harts.
> New threads may be created by processes at any time.
>
> It is not clear to me what information the syscall shall convey in the
> heterogeneous case. I see the following alternatives:
>
> * The syscall describes the current hart.
> * The syscall provides individual properties of all harts.
> * The syscall provides a set of properties that is valid for any hart on
> which the thread might be scheduled.
> * The syscall provides a set of properties that is valid for any hart
> that any thread of the current process might be scheduled to.
>
> Describing only the current hart would not be helpful as the thread
> might be rescheduled to a hart with a smaller set of available extensions.
>
> Describing the properties of all harts would not be helpful if the
> thread has no control to which hart it is scheduled.
>
> Processes that don't control scheduling would most benefit from a
> guaranteed set of properties valid for all threads of the process.
>
> Processes that take control of scheduling would probably want
> information about all harts.

There's a cpu_set_t argument.  We tried to answer this via the 
Documentation patch.  It's just the single sentence

    The CPU set is defined by CPU_SET(3), the indicated features will be 
    supported on all CPUs in the set.

so maybe it needs beefing up...  Do you mind commenting on the doc diff, 
if you've got any ideas as to how to word it better?  That way anyone 
else reviewing the docs will see too.

> Best regards
>
> Heinrich
>
>>
>> Please work with https://github.com/riscv-non-isa/riscv-c-api-doc as
>> it’s crucial we have a portable standard interface for applications to
>> query this information that works on OSes other than Linux. This can be
>> backed by whatever you want, whether a syscall, magic VDSO thing,
>> sysfs, etc, but it’s key that the exposed interface outside of libc is
>> not Linux-specific otherwise we’re going to get fragmentation in this
>> space.
>>
>> I would encourage figuring out the right shape for the exposed
>> interface first before continuing to refine details of how that
>> information gets communicated between the kernel and libc.
>>
>> Jess
>>
>>> An example series in glibc exposing this syscall and using it in an
>>> ifunc selector for memcpy can be found at [1].
>>>
>>> [1] https://public-inbox.org/libc-alpha/20230206194819.1679472-1-evan@rivosinc.com/T/#t
>>>
>>> Changes in v2:
>>> - Changed the interface to look more like poll(). Rather than supplying
>>>    key_offset and getting back an array of values with numerically
>>>    contiguous keys, have the user pre-fill the key members of the array,
>>>    and the kernel will fill in the corresponding values. For any key it
>>>    doesn't recognize, it will set the key of that element to -1. This
>>>    allows usermode to quickly ask for exactly the elements it cares
>>>    about, and not get bogged down in a back and forth about newer keys
>>>    that older kernels might not recognize. In other words, the kernel
>>>    can communicate that it doesn't recognize some of the keys while
>>>    still providing the data for the keys it does know.
>>> - Added a shortcut to the cpuset parameters that if a size of 0 and
>>>    NULL is provided for the CPU set, the kernel will use a cpu mask of
>>>    all online CPUs. This is convenient because I suspect most callers
>>>    will only want to act on a feature if it's supported on all CPUs, and
>>>    it's a headache to dynamically allocate an array of all 1s, not to
>>>    mention a waste to have the kernel loop over all of the offline bits.
>>> - Fixed logic error in if(of_property_read_string...) that caused crash
>>> - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>>>    warning.
>>> - Added a _MASK define
>>> - Fix random checkpatch complaints
>>> - Updated the selftests to the new API and added some more.
>>> - Fixed indentation, comments in .S, and general checkpatch complaints.
>>>
>>> Evan Green (4):
>>>   RISC-V: Move struct riscv_cpuinfo to new header
>>>   RISC-V: Add a syscall for HW probing
>>>   RISC-V: hwprobe: Support probing of misaligned access performance
>>>   selftests: Test the new RISC-V hwprobe interface
>>>
>>> Palmer Dabbelt (2):
>>>   RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
>>>   dt-bindings: Add RISC-V misaligned access performance
>>>
>>> .../devicetree/bindings/riscv/cpus.yaml       |  15 ++
>>> Documentation/riscv/hwprobe.rst               |  66 ++++++
>>> Documentation/riscv/index.rst                 |   1 +
>>> arch/riscv/include/asm/cpufeature.h           |  23 +++
>>> arch/riscv/include/asm/hwprobe.h              |  13 ++
>>> arch/riscv/include/asm/smp.h                  |   9 +
>>> arch/riscv/include/asm/syscall.h              |   3 +
>>> arch/riscv/include/uapi/asm/hwprobe.h         |  35 ++++
>>> arch/riscv/include/uapi/asm/unistd.h          |   8 +
>>> arch/riscv/kernel/cpu.c                       |  11 +-
>>> arch/riscv/kernel/cpufeature.c                |  31 ++-
>>> arch/riscv/kernel/sys_riscv.c                 | 192 +++++++++++++++++-
>>> tools/testing/selftests/Makefile              |   1 +
>>> tools/testing/selftests/riscv/Makefile        |  58 ++++++
>>> .../testing/selftests/riscv/hwprobe/Makefile  |  10 +
>>> .../testing/selftests/riscv/hwprobe/hwprobe.c |  89 ++++++++
>>> .../selftests/riscv/hwprobe/sys_hwprobe.S     |  12 ++
>>> tools/testing/selftests/riscv/libc.S          |  46 +++++
>>> 18 files changed, 613 insertions(+), 10 deletions(-)
>>> create mode 100644 Documentation/riscv/hwprobe.rst
>>> create mode 100644 arch/riscv/include/asm/cpufeature.h
>>> create mode 100644 arch/riscv/include/asm/hwprobe.h
>>> create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
>>> create mode 100644 tools/testing/selftests/riscv/Makefile
>>> create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
>>> create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
>>> create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
>>> create mode 100644 tools/testing/selftests/riscv/libc.S
>>>
>>> --
>>> 2.25.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
