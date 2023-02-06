Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798C68C84F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 22:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFVLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFVLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 16:11:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F6222F3
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 13:11:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so11708805wrv.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC86KoAvXpv+8wZFzH+REYSTORb7w+ZYErKX8Nx95k4=;
        b=aSVunq7LHPF7onCKmJhaCmW36uSCjAfmH491zyI3iOAEpcl2DjyoIWNSiSzrpS6xTN
         upTQqioc+CftRH4JrFM+YnVw1Fygwo+S/Bmeqrn+FExwLMXGhbighCEImkB3LbEHfxB3
         pPZEdv3WoqjTjdS4qov4cnpM7+NBDQNjWuCMv5+UH3CEDixCf7Lt6Xjcbj1Mzs/OZvKR
         NIrWVWjKbBThOFzik29zXn6n1X6BbSxVcjsS+gIYopq+4F5xkjuGoi/EaJf8uHQ77hTV
         DNFFo8Khah5P/qRfg9uC1+q9FUEOXdBpUgPFZDZUYtrmH9uDxG67PQD0Cf4Aw0YX5lEO
         5g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC86KoAvXpv+8wZFzH+REYSTORb7w+ZYErKX8Nx95k4=;
        b=0Ebjx//elNNHdEaD+/Ayr55dvVfIcp50wDM/U5L3eMEfJyf3Sxuf8eB+QzPwfMPxiB
         X6O5Urpw6i2P1AWie2MwfhZjVRHWQ0kTad0Fbf5ybqJjZzrdErEnnQOMoQNHN47pukyh
         WYuW10ZyRjUXa8DvXXln6Ybivq4VWRpLHyMbhB4yTE8VO9LXFyTvbqK8Of7J6W37LCon
         +jPdc51G+ynkH3KUG1Us5wizMYrmms/+qg+elNFvunuHWXaARLBT6/LVD9Be1oalRIAY
         d8YYBk8MK05inud/Fg3qtQEfDJ6J0TZ2nx+ZPvWAEYyG6i4VEatPlEEHtZfL2GbIgKqb
         S3Yg==
X-Gm-Message-State: AO0yUKVaaZBpTU/pEjw8W7UOoQmJr3xGMi4QG+1mIGUUGGS/ppCU2KK0
        +GU7gmSzM21GRHRxhqeJtkt+4g==
X-Google-Smtp-Source: AK7set+qn6JxHyM5CZ+BNMLpM0YVwl27RX//R4K9ijKxYLiMqPu6rBJSBm8bbDpbDwvYPgV3Q3MdRQ==
X-Received: by 2002:a05:6000:1378:b0:2c3:f00c:ebb5 with SMTP id q24-20020a056000137800b002c3f00cebb5mr269377wrz.47.1675717904648;
        Mon, 06 Feb 2023 13:11:44 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b002c3efee2f4bsm1530879wrw.80.2023.02.06.13.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 13:11:44 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 0/6] RISC-V Hardware Probing User Interface
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
Date:   Mon, 6 Feb 2023 21:11:42 +0000
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Andrew Jones <ajones@ventanamicro.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruizhe Pan <c141028@gmail.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kselftest@vger.kernel.org, slewis@rivosinc.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>, dram <dramforever@live.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Guo Ren <guoren@kernel.org>, Dao Lu <daolu@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <212CC1BD-31FF-4B8B-B05D-89C5245EE8A7@jrtc27.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6 Feb 2023, at 20:14, Evan Green <evan@rivosinc.com> wrote:
>=20
>=20
> These are very much up for discussion, as it's a pretty big new user
> interface and it's quite a bit different from how we've historically
> done things: this isn't just providing an ISA string to userspace, =
this
> has its own format for providing information to userspace.
>=20
> There's been a bunch of off-list discussions about this, including at
> Plumbers.  The original plan was to do something involving providing =
an
> ISA string to userspace, but ISA strings just aren't sufficient for a
> stable ABI any more: in order to parse an ISA string users need the
> version of the specifications that the string is written to, the =
version
> of each extension (sometimes at a finer granularity than the RISC-V
> releases/versions encode), and the expected use case for the ISA =
string
> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
> try and keep ABI compatible and it's probably going to continue to =
grow,
> as even if there's no more complexity in the specifications we'll have
> to deal with the various ISA string parsing oddities that end up all
> over userspace.
>=20
> Instead this patch set takes a very different approach and provides a =
set
> of key/value pairs that encode various bits about the system.  The big
> advantage here is that we can clearly define what these mean so we can
> ensure ABI stability, but it also allows us to encode information =
that's
> unlikely to ever appear in an ISA string (see the misaligned access
> performance, for example).  The resulting interface looks a lot like
> what arm64 and x86 do, and will hopefully fit well into something like
> ACPI in the future.
>=20
> The actual user interface is a syscall.  I'm not really sure that's =
the
> right way to go about this, but it makes for flexible prototying.
> Various other approaches have been talked about like making HWCAP2 a
> pointer, having a VDSO routine, or exposing this via sysfs.  Those =
seem
> like generally reasonable approaches, but I've yet to figure out a way
> to get the general case working without a syscall as that's the only =
way
> I've come up with to deal with the heterogenous CPU case.  Happy to =
hear
> if someone has a better idea, though, as I don't really want to add a
> syscall if we can avoid it.

Please work with https://github.com/riscv-non-isa/riscv-c-api-doc as
it=E2=80=99s crucial we have a portable standard interface for =
applications to
query this information that works on OSes other than Linux. This can be
backed by whatever you want, whether a syscall, magic VDSO thing,
sysfs, etc, but it=E2=80=99s key that the exposed interface outside of =
libc is
not Linux-specific otherwise we=E2=80=99re going to get fragmentation in =
this
space.

I would encourage figuring out the right shape for the exposed
interface first before continuing to refine details of how that
information gets communicated between the kernel and libc.

Jess

> An example series in glibc exposing this syscall and using it in an
> ifunc selector for memcpy can be found at [1].
>=20
> [1] =
https://public-inbox.org/libc-alpha/20230206194819.1679472-1-evan@rivosinc=
.com/T/#t
>=20
> Changes in v2:
> - Changed the interface to look more like poll(). Rather than =
supplying
>   key_offset and getting back an array of values with numerically
>   contiguous keys, have the user pre-fill the key members of the =
array,
>   and the kernel will fill in the corresponding values. For any key it
>   doesn't recognize, it will set the key of that element to -1. This
>   allows usermode to quickly ask for exactly the elements it cares
>   about, and not get bogged down in a back and forth about newer keys
>   that older kernels might not recognize. In other words, the kernel
>   can communicate that it doesn't recognize some of the keys while
>   still providing the data for the keys it does know.
> - Added a shortcut to the cpuset parameters that if a size of 0 and
>   NULL is provided for the CPU set, the kernel will use a cpu mask of
>   all online CPUs. This is convenient because I suspect most callers
>   will only want to act on a feature if it's supported on all CPUs, =
and
>   it's a headache to dynamically allocate an array of all 1s, not to
>   mention a waste to have the kernel loop over all of the offline =
bits.
> - Fixed logic error in if(of_property_read_string...) that caused =
crash
> - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>   warning.
> - Added a _MASK define
> - Fix random checkpatch complaints
> - Updated the selftests to the new API and added some more.
> - Fixed indentation, comments in .S, and general checkpatch =
complaints.
>=20
> Evan Green (4):
>  RISC-V: Move struct riscv_cpuinfo to new header
>  RISC-V: Add a syscall for HW probing
>  RISC-V: hwprobe: Support probing of misaligned access performance
>  selftests: Test the new RISC-V hwprobe interface
>=20
> Palmer Dabbelt (2):
>  RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
>  dt-bindings: Add RISC-V misaligned access performance
>=20
> .../devicetree/bindings/riscv/cpus.yaml       |  15 ++
> Documentation/riscv/hwprobe.rst               |  66 ++++++
> Documentation/riscv/index.rst                 |   1 +
> arch/riscv/include/asm/cpufeature.h           |  23 +++
> arch/riscv/include/asm/hwprobe.h              |  13 ++
> arch/riscv/include/asm/smp.h                  |   9 +
> arch/riscv/include/asm/syscall.h              |   3 +
> arch/riscv/include/uapi/asm/hwprobe.h         |  35 ++++
> arch/riscv/include/uapi/asm/unistd.h          |   8 +
> arch/riscv/kernel/cpu.c                       |  11 +-
> arch/riscv/kernel/cpufeature.c                |  31 ++-
> arch/riscv/kernel/sys_riscv.c                 | 192 +++++++++++++++++-
> tools/testing/selftests/Makefile              |   1 +
> tools/testing/selftests/riscv/Makefile        |  58 ++++++
> .../testing/selftests/riscv/hwprobe/Makefile  |  10 +
> .../testing/selftests/riscv/hwprobe/hwprobe.c |  89 ++++++++
> .../selftests/riscv/hwprobe/sys_hwprobe.S     |  12 ++
> tools/testing/selftests/riscv/libc.S          |  46 +++++
> 18 files changed, 613 insertions(+), 10 deletions(-)
> create mode 100644 Documentation/riscv/hwprobe.rst
> create mode 100644 arch/riscv/include/asm/cpufeature.h
> create mode 100644 arch/riscv/include/asm/hwprobe.h
> create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
> create mode 100644 tools/testing/selftests/riscv/Makefile
> create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
> create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
> create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
> create mode 100644 tools/testing/selftests/riscv/libc.S
>=20
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

