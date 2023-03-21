Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DA6C3BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 21:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCUUd2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCUUd1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 16:33:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2AA5DD;
        Tue, 21 Mar 2023 13:33:13 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1peif5-00045p-1e; Tue, 21 Mar 2023 21:32:51 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Cc:     slewis@rivosinc.com, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
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
        Dao Lu <daolu@rivosinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guo Ren <guoren@kernel.org>, Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/6] RISC-V Hardware Probing User Interface
Date:   Tue, 21 Mar 2023 21:32:49 +0100
Message-ID: <6291488.MhkbZ0Pkbq@diego>
In-Reply-To: <20230314183220.513101-1-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am Dienstag, 14. März 2023, 19:32:14 CET schrieb Evan Green:
> 
> There's been a bunch of off-list discussions about this, including at
> Plumbers.  The original plan was to do something involving providing an
> ISA string to userspace, but ISA strings just aren't sufficient for a
> stable ABI any more: in order to parse an ISA string users need the
> version of the specifications that the string is written to, the version
> of each extension (sometimes at a finer granularity than the RISC-V
> releases/versions encode), and the expected use case for the ISA string
> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
> try and keep ABI compatible and it's probably going to continue to grow,
> as even if there's no more complexity in the specifications we'll have
> to deal with the various ISA string parsing oddities that end up all
> over userspace.
> 
> Instead this patch set takes a very different approach and provides a set
> of key/value pairs that encode various bits about the system.  The big
> advantage here is that we can clearly define what these mean so we can
> ensure ABI stability, but it also allows us to encode information that's
> unlikely to ever appear in an ISA string (see the misaligned access
> performance, for example).  The resulting interface looks a lot like
> what arm64 and x86 do, and will hopefully fit well into something like
> ACPI in the future.
> 
> The actual user interface is a syscall, with a vDSO function in front of
> it. The vDSO function can answer some queries without a syscall at all,
> and falls back to the syscall for cases it doesn't have answers to.
> Currently we prepopulate it with an array of answers for all keys and
> a CPU set of "all CPUs". This can be adjusted as necessary to provide
> fast answers to the most common queries.

I've built myself a small test-program [see below], to check the feature
on the d1-nezha board. Which is how I found the tiny c-extension issue.

Series works as expected there, so patches 1-4 on a d1-nezha:

Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>



hwprobe.c:
----------------
#include <linux/types.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <unistd.h>

#define __NR_riscv_hwprobe 258

struct riscv_hwprobe {
        __s64 key;
        __u64 value;
};

#define RISCV_HWPROBE_KEY_MVENDORID     0
#define RISCV_HWPROBE_KEY_MARCHID       1
#define RISCV_HWPROBE_KEY_MIMPID        2
#define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
#define         RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
#define         RISCV_HWPROBE_IMA_FD            (1 << 0)
#define         RISCV_HWPROBE_IMA_C             (1 << 1)
#define RISCV_HWPROBE_KEY_CPUPERF_0     5
#define         RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
#define         RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
#define         RISCV_HWPROBE_MISALIGNED_SLOW           (2 << 0)
#define         RISCV_HWPROBE_MISALIGNED_FAST           (3 << 0)
#define         RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
#define         RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)

int __riscv_hwprobe (struct riscv_hwprobe *pairs, long pair_count,
  long cpu_count, unsigned long *cpus, unsigned long flags)
{

        return syscall(__NR_riscv_hwprobe, pairs, pair_count, cpu_count, cpus, flags);
}

int main(void)
{
        struct riscv_hwprobe pairs[3];

        pairs[0].key = RISCV_HWPROBE_KEY_MVENDORID;
        pairs[1].key = RISCV_HWPROBE_KEY_MARCHID;
        pairs[2].key = RISCV_HWPROBE_KEY_MIMPID;
        if (__riscv_hwprobe(pairs, 3, 0, NULL, 0) != 0) {
                printf("syscall failed");
                return -1;
        }

        printf("vendorid 0x%x, archid 0x%x, impid 0x%x\n",
               pairs[0].value, pairs[1].value, pairs[2].value);


        pairs[0].key = RISCV_HWPROBE_KEY_CPUPERF_0;
        pairs[1].key = RISCV_HWPROBE_KEY_BASE_BEHAVIOR;
        pairs[2].key = RISCV_HWPROBE_KEY_IMA_EXT_0;
        if (__riscv_hwprobe(&pairs[0], 3, 0, NULL, 0) != 0) {
                printf("syscall failed");
                return -1;
        }

        printf("ima-behavior %d, f+d %d, c %d, misaligned access: %s\n",
        ((pairs[1].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA) == RISCV_HWPROBE_BASE_BEHAVIOR_IMA),
        ((pairs[2].value & RISCV_HWPROBE_IMA_FD) == RISCV_HWPROBE_IMA_FD),
        ((pairs[2].value & RISCV_HWPROBE_IMA_C) == RISCV_HWPROBE_IMA_C),
        ((pairs[0].value & RISCV_HWPROBE_MISALIGNED_FAST) == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "not-fast"
        );

        return 0;
}



