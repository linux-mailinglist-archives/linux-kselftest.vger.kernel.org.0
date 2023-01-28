Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694B67F3A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 02:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjA1BQb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 20:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjA1BQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 20:16:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74D222D4;
        Fri, 27 Jan 2023 17:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 094FCB82209;
        Sat, 28 Jan 2023 01:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C029C433D2;
        Sat, 28 Jan 2023 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674868586;
        bh=1mj5p1JqgSFAq91cMLICU1M15Cyqj+sAG9pB3DcSdwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFtZUVSmOLI6M/fPc52KBzKQHWGiJSlvc7BOtEQstW2NWxrlEzfA9G8x5qkfMPgZQ
         i+ACRAQWAn+c26cm35PnmQ6HRayFlrr2UWlgLhUaHl4sUAUMbpRJwv4lDyI/uvdjF0
         plU5coibpOyOPUe60YVNowsL3PF9MKvMYPZbQEHqUk6IxK639cIpUauuFoXBdcEG2y
         94VY+gOtRJEaE1070i7L9SCnpBgEuT7nOfhAsFrRvzRJuuxJ0SqR6VJpiKO32yrFp9
         rfWVX3FzjaKg6Pwfc5Q/FYMT+DAs7iPGmAkAhn1QuEbjobqpUBItZGIAL0tQ93SpPP
         U5w63hiEBAtAg==
Date:   Sat, 28 Jan 2023 10:16:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/ftrace: Extend multiple_kprobes.tc to add
 multiple consecutive probes in a function
Message-Id: <20230128101622.ce6f8e64d929e29d36b08b73@kernel.org>
In-Reply-To: <1674629944.vwzovyd4lk.naveen@linux.ibm.com>
References: <20230112095600.37665-1-akanksha@linux.ibm.com>
        <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
        <20230113005153.c6ca2f75b9d12627eb63308a@kernel.org>
        <1673601511.tq30r5phea.naveen@linux.ibm.com>
        <20230114002126.a37640f815b74e9e78259a9f@kernel.org>
        <1673856229.a7tekgas75.naveen@linux.ibm.com>
        <20230120085554.ab4dc1b72990a4957c4c88e2@kernel.org>
        <1674629944.vwzovyd4lk.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 25 Jan 2023 12:39:36 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Hi Masami,
> 
> Masami Hiramatsu wrote:
> >> > 
> >> > Yes, please make it separate, this test case is for checking whether
> >> > the ftrace can define/enable/disable multiple kprobe events. Not for
> >> > checking kprobe with different types, nor checking interactions among
> >> > different types of kprobes.
> >> > 
> >> > (BTW, if you want to test optprobe on x86, you can not put the probes
> >> >  within the jump instruction (+5 bytes). It will unoptimize existing
> >> >  optimized kprobe in that case)
> >> 
> >> Ok, I can see why we won't be able to optimize any of the probes on x86 
> >> with this approach. But, we should be able to do so on powerpc and arm, 
> >> the only other architectures supporting OPTPROBES at this time. For x86, 
> >> we may have to extend the test to check kprobes/list.
> > 
> > Are there any instruction type specific limitation on those arch for
> > using optprobe? I guess the 'call' (branch with link register) will not
> > able to be optimized because it leaves the trampoline address on the
> > stack.
> 
> Yes, at least on powerpc, we only optimize ALU instructions and do not 
> optimize load/store instructions, among many others. This is the reason 
> we try to put a probe uptil 256 offset into a function in the proposed 
> test, which will almost certainly catch an instruction that can be 
> optimized.
> 
> > 
> >> 
> >> Crucially, I think trying to place a probe at each byte can still 
> >> exercize interactions across KPROBES_ON_FTRACE and normal kprobes, so 
> >> this test is still a good start. In addition, we get to ensure that 
> >> kprobes infrastructure is rejecting placing probes at non-instruction 
> >> boundaries.
> > 
> > The interfere between probes can be happen between kprobes and optprobe
> > (*only on x86*), but not with KPORBES_ON_FTRACE. The ftrace replaced NOP
> > will be handled as one instruction. 
> 
> Yes.
> 
> > 
> >> > And do you really need to run "multiple" kprobes at once?
> >> > I think what you need is 'kprobe_opt_types.tc'.
> >> 
> >> Yes, enabling those probes is a good stress test to ensure we are only 
> >> accepting valid probe locations.
> >> 
> >> multiple_kprobe_types.tc ? :)
> > 
> > Please don't mixed it with the concept of 'multiple' probe test.
> > It is different that
> >  - kprobes can put probes on each instruction boundary.
> >  - kprobes can allocate and enable multiple probes at the same time.
> > 
> > What the multiple_kprobes.tc tests is the latter one.
> > (This is the reason why it chooses different functions so as not to
> >  interfere with each other.)
> 
> Ok, I was coming from the point of view that both tests end up 
> installing "multiple" kprobes, but I do see your point.
> 
> How about adding two new tests:
> 1. The same test as has been proposed in this thread: trying to add a 
> kprobe at every byte within $FUNCTION_FORK upto an offset of 256 bytes. 
> We can probably call it kprobe_insn_boundary.tc

OK.

> 2. A new test to ensure we can add different kprobe types 
> (kprobe_opt_types.tc). This test will need to enable and check if each 
> probe has been optimized or not and needs arch-specific knowledge so 
> that we can take care of x86.

OK, this should be only for x86. 

> 
> Would that be ok?

Yes, this sounds good to me. 

Thank you!

> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
