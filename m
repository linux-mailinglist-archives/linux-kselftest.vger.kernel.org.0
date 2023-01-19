Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B456674795
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 00:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjASX4K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 18:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjASX4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 18:56:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807B9F3A2;
        Thu, 19 Jan 2023 15:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE8561D97;
        Thu, 19 Jan 2023 23:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF130C433EF;
        Thu, 19 Jan 2023 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674172557;
        bh=zxZg2hiE8Stw/0fP14hkZkP+MdqP2TH4oH0qWoLd6dU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JvIrGA7guH/6eRFg7k1m4hiTiQdAQB9s7PVhD7nXifn4aKEAL/xuVB03ZoZUdHPVT
         MyxgNGiUS1QZ/bl0VNNczqGPh98Y+pu7n2mQ4qIZoqjbcNRoHGqpWYAi0BYlYeeBe9
         oyuVgS7hV0hgNfn+XaWr6sbFy27YDi9614UQGkAmQbDaPWpX2aWel06q7JQMDfqoZ7
         oJ5sc9nRO+vmE/7VjhxRpEmpAfvy/kw1hrUTTl6lIkCpN5dH+SAZYYaNKugavGeV3I
         LTP9K03I7IHUh6wjDpNnAnkOLx02jIMwvQ/4VBV/pekFYC0uxL4QPjvsUUtqtDRhNz
         rd6pjRX7dbnaw==
Date:   Fri, 20 Jan 2023 08:55:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/ftrace: Extend multiple_kprobes.tc to add
 multiple consecutive probes in a function
Message-Id: <20230120085554.ab4dc1b72990a4957c4c88e2@kernel.org>
In-Reply-To: <1673856229.a7tekgas75.naveen@linux.ibm.com>
References: <20230112095600.37665-1-akanksha@linux.ibm.com>
        <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
        <20230113005153.c6ca2f75b9d12627eb63308a@kernel.org>
        <1673601511.tq30r5phea.naveen@linux.ibm.com>
        <20230114002126.a37640f815b74e9e78259a9f@kernel.org>
        <1673856229.a7tekgas75.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Naveen,

On Mon, 16 Jan 2023 14:02:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Hi Naveen,
> > 
> > On Fri, 13 Jan 2023 14:59:51 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >> > On Thu, 12 Jan 2023 18:51:14 +0530
> >> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> > 
> >> >> Akanksha J N wrote:
> >> >> > Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
> >> >> > arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
> >> >> > ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
> >> >> > set to NULL.
> >> >> > Extend multiple kprobes test to add kprobes on first 256 bytes within a
> >> >> > function, to be able to test potential issues with kprobes on
> >> >> > successive instructions.
> >> > 
> >> > What is the purpose of that test? If you intended to add a kprobe events
> >> > with some offset so that it becomes ftrace-based kprobe, it should be
> >> > a different test case, because
> >> 
> >> This is a follow up to:
> >> http://lore.kernel.org/1664530538.ke6dp49pwh.naveen@linux.ibm.com
> >> 
> >> The intent is to add consecutive probes covering KPROBES_ON_FTRACE, 
> >> vanilla trap-based kprobes as well as optprobes to ensure all of those 
> >> and their interactions are good.
> > 
> > Hmm, that should be implemented for each architecture with specific
> > knowledge instead of random offset, so that we can ensure the kprobe
> > is on ftrace/optimized or using trap. Also, it should check the
> > debugfs/kprobes/list file.
> 
> ...
> 
> > 
> >> 
> >> > 
> >> >  - This is a test case for checking multiple (at least 256) kprobe events
> >> >   can be defined and enabled.
> >> > 
> >> >  - If you want to check the ftrace-based kprobe, it should be near the
> >> >    function entry, maybe within 16 bytes or so.
> >> > 
> >> >  - Also, you don't need to enable it at once (and should not for this case).
> >> > 
> >> >> > The '|| true' is added with the echo statement to ignore errors that are
> >> >> > caused by trying to add kprobes to non probeable lines and continue with
> >> >> > the test.
> >> > 
> >> > Can you add another test case for that? (and send it to the MLs which Cc'd
> >> > to this mail)
> >> > e.g. 
> >> > 
> >> >    for i in `seq 0 16`; do
> >> >      echo p:testprobe $FUNCTION_FORK+${i} >> kprobe_events || continue
> >> >      echo 1 > events/kprobes/testprobe/enable
> >> >      ( echo "forked" )
> >> >      echo 0 > events/kprobes/testprobe/enable
> >> >      echo > kprobe_events
> >> >    done
> >> 
> >> The current test to add multiple kprobes within a function also falls 
> >> under the purview of multiple_kprobes.tc, but it can be split into a 
> >> separate multiple_kprobes_func.tc if you think that will be better.
> >> 
> > 
> > Yes, please make it separate, this test case is for checking whether
> > the ftrace can define/enable/disable multiple kprobe events. Not for
> > checking kprobe with different types, nor checking interactions among
> > different types of kprobes.
> > 
> > (BTW, if you want to test optprobe on x86, you can not put the probes
> >  within the jump instruction (+5 bytes). It will unoptimize existing
> >  optimized kprobe in that case)
> 
> Ok, I can see why we won't be able to optimize any of the probes on x86 
> with this approach. But, we should be able to do so on powerpc and arm, 
> the only other architectures supporting OPTPROBES at this time. For x86, 
> we may have to extend the test to check kprobes/list.

Are there any instruction type specific limitation on those arch for
using optprobe? I guess the 'call' (branch with link register) will not
able to be optimized because it leaves the trampoline address on the
stack.

> 
> Crucially, I think trying to place a probe at each byte can still 
> exercize interactions across KPROBES_ON_FTRACE and normal kprobes, so 
> this test is still a good start. In addition, we get to ensure that 
> kprobes infrastructure is rejecting placing probes at non-instruction 
> boundaries.

The interfere between probes can be happen between kprobes and optprobe
(*only on x86*), but not with KPORBES_ON_FTRACE. The ftrace replaced NOP
will be handled as one instruction. 

> > And do you really need to run "multiple" kprobes at once?
> > I think what you need is 'kprobe_opt_types.tc'.
> 
> Yes, enabling those probes is a good stress test to ensure we are only 
> accepting valid probe locations.
> 
> multiple_kprobe_types.tc ? :)

Please don't mixed it with the concept of 'multiple' probe test.
It is different that
 - kprobes can put probes on each instruction boundary.
 - kprobes can allocate and enable multiple probes at the same time.

What the multiple_kprobes.tc tests is the latter one.
(This is the reason why it chooses different functions so as not to
 interfere with each other.)

Thank you,

> 
> 
> Thanks,
> Naveen
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
