Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8054CB30E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 00:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiCBXq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 18:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCBXqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C04E5F251;
        Wed,  2 Mar 2022 15:44:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6DC1139F;
        Wed,  2 Mar 2022 15:19:08 -0800 (PST)
Received: from [10.57.20.1] (unknown [10.57.20.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0FCF3F66F;
        Wed,  2 Mar 2022 15:19:05 -0800 (PST)
Message-ID: <77afb869-126d-c9e9-96a5-0aedc4e4569d@arm.com>
Date:   Wed, 2 Mar 2022 23:19:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [next] Internal error: aarch64 BRK: f20003e8 at pc :
 has_cpuid_feature
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Freescale Mailman List <freescale@lists.linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Will Deacon <will@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Qian Cai <quic_qiancai@quicinc.com>
References: <CA+G9fYuX3nM5y_VD_0menGTF0AqDOZ85=ptmQ_3XoPAAxYMWyQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CA+G9fYuX3nM5y_VD_0menGTF0AqDOZ85=ptmQ_3XoPAAxYMWyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Naresh

On 02/03/2022 21:15, Naresh Kamboju wrote:
> [Please ignore this email if it is already reported]
> 
> Linux next-20220228..next-20220302 running on Freescale Layerscape 2088A RDB
> board the following kernel crash reported [1].
> 
> This kernel crash is only seen with kselftest-merge configs.

This should be fixed by :

https://lkml.kernel.org/r/20220302134225.159217-1-broonie@kernel.org

Cheers
Suzuki


> 
> metadata:
>    git_ref: master
>    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>    git_sha: 6705cd745adbbeac6b13002c7a30060f7b2568a5
>    git_describe: next-20220228..next-20220302
>    kernel-config: https://builds.tuxbuild.com/25kHVbzi7zV3Pzb1i4scZwtXzeA/config
>    device: Freescale Layerscape 2088A RDB Board
> 
> Kernel crash:
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] Internal error: aarch64 BRK: f20003e8 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.17.0-rc6-next-20220228 #1
> [    0.000000] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
> [    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : has_cpuid_feature+0x104/0x10c
> [    0.000000] lr : has_cpuid_feature+0x58/0x10c
> [    0.000000] sp : ffffb7b2bf6b3d00
> [    0.000000] x29: ffffb7b2bf6b3d00 x28: ffffb7b2be085690 x27: 0000000000000018
> [    0.000000] x26: ffffb7b2be874e48 x25: ffffb7b2be874e70 x24: ffffb7b2beabc238
> [    0.000000] x23: 0000000000000005 x22: ffffb7b2bfc05be0 x21: ffffb7b2bfc05728
> [    0.000000] x20: 0000000000000020 x19: ffffb7b2be084950 x18: 0000000000000000
> [    0.000000] x17: 6666666666663733 x16: 000000000001f000 x15: 0126000040000000
> [    0.000000] x14: 1020110500000000 x13: 0000000002102211 x12: 0126000040000000
> [    0.000000] x11: 0000000000000000 x10: 0000000000000043 x9 : 1211111110110222
> [    0.000000] x8 : 0000000010011011 x7 : 0000013100000000 x6 : 0000000002102211
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    0.000000] x2 : 0000000000000028 x1 : 0000000000000040 x0 : 0022220000000000
> [    0.000000] Call trace:
> [    0.000000]  has_cpuid_feature+0x104/0x10c
> [    0.000000]  has_useable_gicv3_cpuif+0x24/0x94
> [    0.000000]  update_cpu_capabilities+0x90/0x144
> [    0.000000]  init_cpu_features+0x28c/0x2b4
> [    0.000000]  cpuinfo_store_boot_cpu+0x58/0x68
> [    0.000000]  smp_prepare_boot_cpu+0x4c/0x60
> [    0.000000]  start_kernel+0x20c/0x77c
> [    0.000000]  __primary_switched+0xc0/0xc8
> [    0.000000] Code: b9402260 17ffffd7 d2800000 17ffffd6 (d4207d00)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> [1] https://lavalab.nxp.com/scheduler/job/851695#L565
> [2] https://lavalab.nxp.com/scheduler/job/853258#L695

