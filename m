Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1B4B1135
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiBJPFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 10:05:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243394AbiBJPFi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B7C53;
        Thu, 10 Feb 2022 07:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9B861B03;
        Thu, 10 Feb 2022 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C73C340E5;
        Thu, 10 Feb 2022 15:05:37 +0000 (UTC)
Date:   Thu, 10 Feb 2022 10:05:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <20220210100535.01ad4978@gandalf.local.home>
In-Reply-To: <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
        <YgUXcGC1mH7VX1d9@linutronix.de>
        <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
        <YgUc5HxfIdJ0Z5AN@linutronix.de>
        <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Feb 2022 15:13:15 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

  
> >> The implementation detail is that do_softirq() is in ifndef.  
> > 
> > So let me ask again.  We have
> >    FUNC1="schedule"
> >    FUNC2="do_softirq"
> > 
> > What is the purpose of this? Do you need FUNC2 when ksoftirqd is run or
> > when softirqs are served? Not sure how scheduler_tick fits in all this.  
> 
> I guess this is more a question to the author of the test. Unless you
> are now questioning the entire purpose of this test?

The test is just a smoke test on function triggers. These two functions
have various triggers attached to them to see if it causes any harm (the
test was added after some strange bugs happened in the past).

Now, if "_printk" worked, it suggests that I need to look into this test
because I'm guessing _printk would never trigger during the test. The
reason we picked schedule and do_softirq was to get triggers in different
contexts (do_softirq was in the softirq context, and schedule is in the
normal context). The reason I suggested to pick "schedule_tick" is because
that should happen in the interrupt context.

But if _printk worked, then it probably didn't test that part. But that's a
different bug than what this patch is addressing.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

And I need to add to my TODO list, to look at this test and probably
rewrite. it. :-p

-- Steve
