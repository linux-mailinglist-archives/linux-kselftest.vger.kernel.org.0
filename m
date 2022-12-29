Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55126658C53
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Dec 2022 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiL2LmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Dec 2022 06:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2LmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Dec 2022 06:42:08 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA691EE2B;
        Thu, 29 Dec 2022 03:42:07 -0800 (PST)
Received: from [192.168.88.87] (unknown [125.160.97.236])
        by gnuweeb.org (Postfix) with ESMTPSA id CD84D7E259;
        Thu, 29 Dec 2022 11:42:03 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672314126;
        bh=Wm/M0KFPV/UrXA6Ml+ZYeaSNEGdUKJquP84+pixMr+Q=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ioEorrDULg3Vw9Qd+4LGx9rD7cCo67YGL8iFu7LH+j5isM323rjg3vzUW+u5yueMZ
         RVzN1O83fZL6I+9sCJ7M6InEbiYLXC3t1CWc9M6nJKPn2DsxlgqhnEpY00wcw86iBV
         1qhspCaMEOt5GtvxTaXjmyaDW9FnO3JGxB8VTUH1+XQEBp0mFA2OnEB9brCE6GchKr
         Fgf3BUk68UNoWamXXKM0Ubw9yMwdaimTBt4SrAZLx0fh2bv2pPap1tkLGOnxWiHsQg
         UZBD4GivfptXWNdiVmxFbjZ32PcASp6lWmb04kxQJnthS2wRMZ0UkBTt9M38uYqqSY
         OS5u22AWSGmxA==
Message-ID: <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
Date:   Thu, 29 Dec 2022 18:41:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
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
 <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
In-Reply-To: <20221228133513.GA7457@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/28/22 8:35 PM, Willy Tarreau wrote:
> OK thanks!
> 
> I've pushed for you an update which starts to do what I proposed. Errno
> and environ are now marked weak for all archs, and _auxv is set for i386,
> x86_64, arm64 and arm for now:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20221227-nolibc-weak-2
> 
> You can already use it to implement getauxval(), it will normally work
> for these archs.

Will do and be back with two patch series.

> I think we could avoid the asm specific stuff is we get rid of the frame
> pointer. Please look below:
> 
>    __attribute__((weak,unused,noreturn,optimize("omit-frame-pointer"),section(".text.nolibc_rt_sigreturn")))
>    void sys_rt_sigreturn()
>    {
>          my_syscall0(__NR_rt_sigreturn);
>          __builtin_unreachable();
>    }

Wow! You just taught me that we can force optimize a function with
optimize("omit-frame-pointer") attribute. Nice to know this one!

I compile-tested it and it indeed gives the correct code on x86-64.
Hopefully this approach works for all archs.

> It gives me the correct code for x86_64 and i586. I don't know if other
> architectures will want to add a prologue. I tried with "naked" but it's
> ignored by the compiler since the function is not purely asm. Not very
> important but given that we already have everything to perform our calls
> it would make sense to stay on this. By the way, for the sake of
> consistency with other syscalls, I do think the function (or label if
> we can't do otherwise) should be called "sys_rt_sigreturn" as it just
> performs a syscall.

Will call that 'sys_rt_sigreturn' in the next series.

Thanks!

-- 
Ammar Faizi

