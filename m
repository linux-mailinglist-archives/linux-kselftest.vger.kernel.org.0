Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27768C976
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 23:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBFWd7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 17:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFWd5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 17:33:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF93166DE;
        Mon,  6 Feb 2023 14:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83E20B8162F;
        Mon,  6 Feb 2023 22:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFCEC433D2;
        Mon,  6 Feb 2023 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722833;
        bh=ZA9Xx8DGms3yzuK80v5ou07FlZ01ez04TS8bPZTxAME=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NdIUTcxsYPskCQ2Yy5lKrRaQ0IA7bSuVGirD7ueo3QUjTxMTCyebwE67MBan0Va/p
         YmVwDBFj3OC4D6K10etyu7IXq0SKoUZa8QUPQxpf47qq4/kAqunZ0yFmhcvjbiHz+z
         tuuko9d4wphr3BTuPZEN046j9OiOkAsAuioHMQR+NGSe4XyVoX7qUQgNFXyHEoHCzR
         HmT6LEvYy6GvRj43M1XgD0jYDWevOUEFT8+Qs0iZDVO1HwcES8hykWO1Zc5GBDpv8C
         fYaCv8Rcv2sdVoHsMGw7VGQrCLyjUhmfEOdyOk2Fg7IwANunOIqAyXDjjeznMgj9ix
         9N9rZUMD2Ke8A==
Date:   Mon, 06 Feb 2023 22:32:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
CC:     vineetg@rivosinc.com, heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ruizhe Pan <c141028@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        devicetree@vger.kernel.org, dram <dramforever@live.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] RISC-V Hardware Probing User Interface
User-Agent: K-9 Mail for Android
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
Message-ID: <9E71182A-BEE9-4A0D-9AF5-783F6689B90E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey Evan,
Having been talking to Palmer about this series at FOSDEM,
it was a very pleasant surprise to see this when I saw this in my inbox wh=
en I landed back home=2E
I do very much intend reviewing this, but=2E=2E=2E=20

On 6 February 2023 20:14:49 GMT, Evan Green <evan@rivosinc=2Ecom> wrote:
>
>These are very much up for discussion, as it's a pretty big new user
>interface and it's quite a bit different from how we've historically
>done things: this isn't just providing an ISA string to userspace, this
>has its own format for providing information to userspace=2E
>
>There's been a bunch of off-list discussions about this, including at
>Plumbers=2E  The original plan was to do something involving providing an
>ISA string to userspace, but ISA strings just aren't sufficient for a
>stable ABI any more: in order to parse an ISA string users need the
>version of the specifications that the string is written to, the version
>of each extension (sometimes at a finer granularity than the RISC-V
>releases/versions encode), and the expected use case for the ISA string
>(ie, is it a U-mode or M-mode string)=2E  That's a lot of complexity to
>try and keep ABI compatible and it's probably going to continue to grow,
>as even if there's no more complexity in the specifications we'll have
>to deal with the various ISA string parsing oddities that end up all
>over userspace=2E
>
>Instead this patch set takes a very different approach and provides a set
>of key/value pairs that encode various bits about the system=2E  The big
>advantage here is that we can clearly define what these mean so we can
>ensure ABI stability, but it also allows us to encode information that's
>unlikely to ever appear in an ISA string (see the misaligned access
>performance, for example)=2E  The resulting interface looks a lot like
>what arm64 and x86 do, and will hopefully fit well into something like
>ACPI in the future=2E
>
>The actual user interface is a syscall=2E  I'm not really sure that's the
>right way to go about this, but it makes for flexible prototying=2E
>Various other approaches have been talked about like making HWCAP2 a
>pointer, having a VDSO routine, or exposing this via sysfs=2E  Those seem
>like generally reasonable approaches, but I've yet to figure out a way

This all looks to be the same cover message as Palmer submitted with the v=
1,
so, as I'd mentioned to him the other day, I'd like to do a bit
of an investigation into the sysfs approach drew suggested
on the v1=2E
So, if it's a little bit before you hear - I've certainly not forgotten ab=
out the series!

Thanks,
Conor=2E

>to get the general case working without a syscall as that's the only way
>I've come up with to deal with the heterogenous CPU case=2E  Happy to hea=
r
>if someone has a better idea, though, as I don't really want to add a
>syscall if we can avoid it=2E
>
>An example series in glibc exposing this syscall and using it in an
>ifunc selector for memcpy can be found at [1]=2E
>
>[1] https://public-inbox=2Eorg/libc-alpha/20230206194819=2E1679472-1-evan=
@rivosinc=2Ecom/T/#t
>
>Changes in v2:
> - Changed the interface to look more like poll()=2E Rather than supplyin=
g
>   key_offset and getting back an array of values with numerically
>   contiguous keys, have the user pre-fill the key members of the array,
>   and the kernel will fill in the corresponding values=2E For any key it
>   doesn't recognize, it will set the key of that element to -1=2E This
>   allows usermode to quickly ask for exactly the elements it cares
>   about, and not get bogged down in a back and forth about newer keys
>   that older kernels might not recognize=2E In other words, the kernel
>   can communicate that it doesn't recognize some of the keys while
>   still providing the data for the keys it does know=2E
> - Added a shortcut to the cpuset parameters that if a size of 0 and
>   NULL is provided for the CPU set, the kernel will use a cpu mask of
>   all online CPUs=2E This is convenient because I suspect most callers
>   will only want to act on a feature if it's supported on all CPUs, and
>   it's a headache to dynamically allocate an array of all 1s, not to
>   mention a waste to have the kernel loop over all of the offline bits=
=2E
> - Fixed logic error in if(of_property_read_string=2E=2E=2E) that caused =
crash
> - Include cpufeature=2Eh in cpufeature=2Eh to avoid undeclared variable
>   warning=2E
> - Added a _MASK define
> - Fix random checkpatch complaints
> - Updated the selftests to the new API and added some more=2E
> - Fixed indentation, comments in =2ES, and general checkpatch complaints=
=2E
>
>Evan Green (4):
>  RISC-V: Move struct riscv_cpuinfo to new header
>  RISC-V: Add a syscall for HW probing
>  RISC-V: hwprobe: Support probing of misaligned access performance
>  selftests: Test the new RISC-V hwprobe interface
>
>Palmer Dabbelt (2):
>  RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
>  dt-bindings: Add RISC-V misaligned access performance
>
> =2E=2E=2E/devicetree/bindings/riscv/cpus=2Eyaml       |  15 ++
> Documentation/riscv/hwprobe=2Erst               |  66 ++++++
> Documentation/riscv/index=2Erst                 |   1 +
> arch/riscv/include/asm/cpufeature=2Eh           |  23 +++
> arch/riscv/include/asm/hwprobe=2Eh              |  13 ++
> arch/riscv/include/asm/smp=2Eh                  |   9 +
> arch/riscv/include/asm/syscall=2Eh              |   3 +
> arch/riscv/include/uapi/asm/hwprobe=2Eh         |  35 ++++
> arch/riscv/include/uapi/asm/unistd=2Eh          |   8 +
> arch/riscv/kernel/cpu=2Ec                       |  11 +-
> arch/riscv/kernel/cpufeature=2Ec                |  31 ++-
> arch/riscv/kernel/sys_riscv=2Ec                 | 192 +++++++++++++++++-
> tools/testing/selftests/Makefile              |   1 +
> tools/testing/selftests/riscv/Makefile        |  58 ++++++
> =2E=2E=2E/testing/selftests/riscv/hwprobe/Makefile  |  10 +
> =2E=2E=2E/testing/selftests/riscv/hwprobe/hwprobe=2Ec |  89 ++++++++
> =2E=2E=2E/selftests/riscv/hwprobe/sys_hwprobe=2ES     |  12 ++
> tools/testing/selftests/riscv/libc=2ES          |  46 +++++
> 18 files changed, 613 insertions(+), 10 deletions(-)
> create mode 100644 Documentation/riscv/hwprobe=2Erst
> create mode 100644 arch/riscv/include/asm/cpufeature=2Eh
> create mode 100644 arch/riscv/include/asm/hwprobe=2Eh
> create mode 100644 arch/riscv/include/uapi/asm/hwprobe=2Eh
> create mode 100644 tools/testing/selftests/riscv/Makefile
> create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
> create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe=2Ec
> create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe=2ES
> create mode 100644 tools/testing/selftests/riscv/libc=2ES
>
