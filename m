Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC3667A23
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjALQAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 11:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALP7n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 10:59:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981384FCED;
        Thu, 12 Jan 2023 07:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 564FAB81EBD;
        Thu, 12 Jan 2023 15:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAECC433EF;
        Thu, 12 Jan 2023 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673538717;
        bh=yTTb2Tm+5+3xMGeFN/U2gUsQGw74zuDp1qN2tQFtvZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q9RZ/4cZNvwQ/2InsNasQMBAY2PsqCImDaXEPkTDxFENN1J/trHfYW+X+aRu2OIF3
         PcITO8JK3/iQgHnKdTxl2eKkPL5NsAKN7XKbaCugZx7dGXHWb2PyoAJ+6xomgHethw
         rNj0gBpCPRqi4bcnDlEZhJ7ncdWM7h99PWNgBbjZmdId2NqEjHa8TKrh21ddCSBMgv
         CnW1RL5kRgwo9LB9CO0HTp50JPF4udILV53qGcFZGPlx27SlojaJNC8HpS/clhVzl1
         3DT8ln1dPZ5YPUk1eMiA2LYkIW0G3BFy+MeOPWmAwLRURULD0by7JXn9dyOSw40tJM
         Ky88arOiAPu/w==
Date:   Fri, 13 Jan 2023 00:51:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/ftrace: Extend multiple_kprobes.tc to add
 multiple consecutive probes in a function
Message-Id: <20230113005153.c6ca2f75b9d12627eb63308a@kernel.org>
In-Reply-To: <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
References: <20230112095600.37665-1-akanksha@linux.ibm.com>
        <1673529279.3c5f8oes3z.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 12 Jan 2023 18:51:14 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Akanksha J N wrote:
> > Commit 97f88a3d723162 ("powerpc/kprobes: Fix null pointer reference in
> > arch_prepare_kprobe()") fixed a recent kernel oops that was caused as
> > ftrace-based kprobe does not generate kprobe::ainsn::insn and it gets
> > set to NULL.
> > Extend multiple kprobes test to add kprobes on first 256 bytes within a
> > function, to be able to test potential issues with kprobes on
> > successive instructions.

What is the purpose of that test? If you intended to add a kprobe events
with some offset so that it becomes ftrace-based kprobe, it should be
a different test case, because

 - This is a test case for checking multiple (at least 256) kprobe events
  can be defined and enabled.

 - If you want to check the ftrace-based kprobe, it should be near the
   function entry, maybe within 16 bytes or so.

 - Also, you don't need to enable it at once (and should not for this case).

> > The '|| true' is added with the echo statement to ignore errors that are
> > caused by trying to add kprobes to non probeable lines and continue with
> > the test.

Can you add another test case for that? (and send it to the MLs which Cc'd
to this mail)
e.g. 

   for i in `seq 0 16`; do
     echo p:testprobe $FUNCTION_FORK+${i} >> kprobe_events || continue
     echo 1 > events/kprobes/testprobe/enable
     ( echo "forked" )
     echo 0 > events/kprobes/testprobe/enable
     echo > kprobe_events
   done


BTW, after we introduce the fprobe event (https://lore.kernel.org/linux-trace-kernel/166792255429.919356.14116090269057513181.stgit@devnote3/) that test case may be
update to check fprobe events.

Thank you,

> > 
> > Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> > ---
> >  .../selftests/ftrace/test.d/kprobe/multiple_kprobes.tc        | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Thanks for adding this test!
> 
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > index be754f5bcf79..f005c2542baa 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > @@ -25,6 +25,10 @@ if [ $L -ne 256 ]; then
> >    exit_fail
> >  fi
> > 
> > +for i in `seq 0 255`; do
> > +  echo p $FUNCTION_FORK+${i} >> kprobe_events || true
> > +done
> > +
> >  cat kprobe_events >> $testlog
> > 
> >  echo 1 > events/kprobes/enable
> 
> Thinking about this more, I wonder if we should add an explicit fork 
> after enabling the events, similar to kprobe_args.tc:
> 	( echo "forked" )
> 
> That will ensure we hit all the probes we added. With that change:
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> 
> - Naveen


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
