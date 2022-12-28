Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD431657642
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiL1MDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 07:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiL1MC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 07:02:29 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492A2AEE;
        Wed, 28 Dec 2022 04:01:42 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id E0E6A7E258;
        Wed, 28 Dec 2022 12:01:38 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672228902;
        bh=Yw3TuLngTSu3YPEHEdu5NGY2ZRCtBOIME+CW2blUEs8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=MjNkG8lxgq2o1fPcIbFjRNB7VWK9krBeq3aNDYaLcqFQKPdejJx74tVrBb5T5s4au
         eTO2mkcJrwlA2NKG760KjK0uzSTTSCCXHnlSgHxFQtSGRD/s8tPnFTOchu/ZtFIGRK
         R1xXc3B7k09S33iZD5WoZjdWgCAdDy4zsH8h/5OYuMH21VXqgDtBQeXgREv0yG5dwL
         PO1PV0PUqkoTzNikbTKrlLOKFC47nkWAaYh1Rf5j3QsHru4h4e78sA8tm6ZfvkgVdT
         7/+n+TudLNq68SljvWnDkPkVDulQz+wsCyEGJRPrV5fEHWkzpTmy1oL637AXb5w5Xb
         5Mu8vAkMPnxCQ==
Message-ID: <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
Date:   Wed, 28 Dec 2022 19:01:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
In-Reply-To: <20221227184902.GA6287@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/28/22 1:49 AM, Willy Tarreau wrote:
> I'll try to do it but do not want to make you wait too long in case it
> gets delayed. In the worst case we should only postpone the getauxval()
> patch and not the other ones.

I will split it into 2 patchset then.

> BTW, do you think your arch-specific changes for sigaction() will be
> easily portable to other architectures ? I feel a bit wary of starting
> to have different features per architecture given the purpose of the
> lib, so the more uniform the coverage the better.

The 'rt_sigaction()' itself doesn't seem to be an arch specific, but
the way it resumes the execution needs to call 'rt_sigreturn()' which
is arch specific. I took a look at the kernel source code, most
architectures read 'struct rt_sigframe' from the stack pointer.

https://github.com/torvalds/linux/blob/631aa744423173bf921191ba695bbc7c1aabd9e0/arch/x86/kernel/signal_32.c#L145
https://github.com/torvalds/linux/blob/631aa744423173bf921191ba695bbc7c1aabd9e0/arch/x86/kernel/signal_64.c#L243-L271
https://github.com/torvalds/linux/blob/a6b450573b912316ad36262bfc70e7c3870c56d1/arch/arm64/kernel/signal.c#L668-L699
https://github.com/torvalds/linux/blob/a6b450573b912316ad36262bfc70e7c3870c56d1/arch/arm64/kernel/signal32.c#L259
https://github.com/torvalds/linux/blob/eb67d239f3aa1711afb0a42eab50459d9f3d672e/arch/riscv/kernel/signal.c#L101

On the x86-64 arch, the implementation is just like this:

    __arch_restore_rt:
        #
        # ((%rsp - sizeof(long)) must point to 'struct rt_sigframe')
        #
        # 'struct rt_sigframe' is automatically constructed by
        # the kernel when a signal is caught.
        #
        movl       $0xf, %eax // __NR_rt_sigreturn == 0xf
        syscall

I believe aarch64 and RISCV don't behave differently, but different
registers.

Not sure what PowerPC does here, it seems a bit different:
https://github.com/torvalds/linux/blob/1612c382ffbdf1f673caec76502b1c00e6d35363/arch/powerpc/kernel/signal_64.c#L744

I haven't taken a look at other archs.

What do you think? Is it affordable for nolibc to implement all of
these?

-- 
Ammar Faizi

