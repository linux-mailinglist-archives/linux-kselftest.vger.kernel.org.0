Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABA37A8A94
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjITR1j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjITR1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 13:27:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9679AF;
        Wed, 20 Sep 2023 10:27:32 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1247C20C1461;
        Wed, 20 Sep 2023 10:27:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1247C20C1461
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695230852;
        bh=CdjNAAQI9rDAO2aGgTHU9OUaCjVaEdkcivKez+VgMug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeQgq7gS01268FpA5iDSgN779IED27xIBmUyX6BlwMCOtTEbiAi4dlv6/9mBHwdFb
         bvig9hFnzbuD18mM5qVoXg4+cZIs/aa0Yg3s5Qau62q7ddeDlOVc6PTJ4kt2K1KFKy
         pHcPnnv2HEIDH/Yhjz77trwGH5vPxp0Spa7NNSbI=
Date:   Wed, 20 Sep 2023 10:27:29 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: selftests: user_events: ftrace_test: Internal error: Oops:
 0000000096000021
Message-ID: <20230920172729.GB467-beaub@linux.microsoft.com>
References: <CA+G9fYtio=EY-fitOJZgAWsgVHX8XhgdNQnfMoUBVFrnSP5TZg@mail.gmail.com>
 <ZQr_yqLJHesRRMjR@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQr_yqLJHesRRMjR@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 03:20:58PM +0100, Mark Rutland wrote:
> Hi Naresh,
> 
> As a general thing, for arm64 issues could you please Cc the linux-arm-kernel
> mailing list?
> 
> On Wed, Sep 20, 2023 at 02:40:24PM +0200, Naresh Kamboju wrote:
> > Following selftests: user_events: ftrace_test running on arm64 Juno-r2
> > Linux next-20230919.
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > kselftest: Running tests in user_events
> > TAP version 13
> > 1..4
> > # timeout set to 90
> > # selftests: user_events: ftrace_test
> > [ 1138.755735] Unable to handle kernel paging request at virtual address ffff00082fc89ed4
> > [ 1138.763768] Mem abort info:
> > [ 1138.766692]   ESR = 0x0000000096000021
> > [ 1138.770495]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [ 1138.775879]   SET = 0, FnV = 0
> > [ 1138.779018]   EA = 0, S1PTW = 0
> > [ 1138.782264]   FSC = 0x21: alignment fault
> 
> So this is an alignment fault, to a 4-byte aligned address...
> 
> > [ 1138.786399] Data abort info:
> > [ 1138.789356]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
> > [ 1138.794969]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [ 1138.800095]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [ 1138.805436] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000008265b000
> > [ 1138.812175] [ffff00082fc89ed4] pgd=18000009ffdf8003,
> > p4d=18000009ffdf8003, pud=18000009ffa0e003, pmd=18000009ff88f003,
> > pte=00680008afc89707
> > [ 1138.824824] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
> > # TAP[ 1138.831117] Modules linked in: tda998x hdlcd onboard_usb_hub
> > crct10dif_ce cec drm_dma_helper drm_kms_helper drm fuse backlight
> > dm_mod ip_tables x_tables
> > [ 1138.845227] CPU: 1 PID: 4752 Comm: ftrace_test Not tainted
> > 6.6.0-rc2-next-20230919 #1
> > v[e r1s1i3o8n. 81533080] Hardware name: ARM Juno development board (r2) (DT)
> > 
> > # 1..6
> > # # Starting 6 tests from 1 test cases.
> > # #  RUN           user.register_events ...
> > [ 1138.868317] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 1138.875291] pc : user_event_enabler_write
> > (arch/arm64/include/asm/atomic_ll_sc.h:210 (discriminator 2)
> > arch/arm64/include/asm/atomic.h:64 (discriminator 2)
> > include/linux/atomic/atomic-arch-fallback.h:3656 (discriminator 2)
> > include/linux/atomic/atomic-long.h:964 (discriminator 2)
> 
> ... as part of some atomic_long_*() operation, where atomic_long_t should be
> 8-byte aligned, so we've got a dodgy address.
> 

This appears to be the same issue [1] that was sent to linux-trace-kernel.
There's a proposal [2] there to get a generic set_bit_aligned() function to
ensure alignment for both little and big endian devices.

Thanks,
-Beau

1. https://lore.kernel.org/linux-trace-kernel/20230914131102.179100-1-cleger@rivosinc.com/
2. https://lore.kernel.org/linux-trace-kernel/20230915115449.3d7103b841cd593d1a09a129@kernel.org/
