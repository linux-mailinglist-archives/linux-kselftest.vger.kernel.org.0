Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209BF65B9E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jan 2023 04:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjACDyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 22:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjACDyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 22:54:40 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FF3823F;
        Mon,  2 Jan 2023 19:54:38 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3033sRQp004490;
        Tue, 3 Jan 2023 04:54:27 +0100
Date:   Tue, 3 Jan 2023 04:54:27 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Message-ID: <20230103035427.GA4474@1wt.eu>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu>
 <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu>
 <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
 <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 03, 2023 at 10:51:35AM +0700, Alviro Iskandar Setiawan wrote:
> On Thu, Dec 29, 2022 at 6:42 PM Ammar Faizi wrote:
> > On 12/28/22 8:35 PM, Willy Tarreau wrote:
> > > It gives me the correct code for x86_64 and i586. I don't know if other
> > > architectures will want to add a prologue. I tried with "naked" but it's
> > > ignored by the compiler since the function is not purely asm. Not very
> > > important but given that we already have everything to perform our calls
> > > it would make sense to stay on this. By the way, for the sake of
> > > consistency with other syscalls, I do think the function (or label if
> > > we can't do otherwise) should be called "sys_rt_sigreturn" as it just
> > > performs a syscall.
> >
> > Will call that 'sys_rt_sigreturn' in the next series.
> 
> >From glibc source code says:
> GDB needs some intimate knowledge about it to recognize them as signal
> trampolines, and make backtraces through signal handlers work right.
> Important are both the names (__restore_rt) and the exact instruction
> sequence.
> 
> link: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/x86_64/sigaction.c;h=4e6d9cc32e1e18746726fa430d092de9a19ba6c6;hb=b4a5d26d8835d972995f0a0a2f805a8845bafa0b#l34
> 
> glibc does this:
> 
>    "    .type __" #name ",@function\n" \
>    "__" #name ":\n"                    \
>    "    movq $" #syscall ", %rax\n"    \
>    "    syscall\n"                     \
> 
> where
> 
>    #name = "restore_rt"
>    #syscall = __NR_rt_sigreturn
> 
> I think it should be called "__restore_rt" instead of "sys_rt_sigreturn"?
> glibc also has unwind information, but we probably don't need to care
> with that much

OK, I wasn't aware of this. Of course, if there are some strict rules
for this, let's follow them!

Thanks,
Willy
