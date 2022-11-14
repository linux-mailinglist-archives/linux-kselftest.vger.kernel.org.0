Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6456287E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiKNSJ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiKNSJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 13:09:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C4DDF55;
        Mon, 14 Nov 2022 10:09:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDA26B810FB;
        Mon, 14 Nov 2022 18:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B53C433D6;
        Mon, 14 Nov 2022 18:09:47 +0000 (UTC)
Date:   Mon, 14 Nov 2022 13:10:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yipeng Zou <zouyipeng@huawei.com>, <shuah@kernel.org>,
        <rdunlap@infradead.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: event_triggers: wait longer for
 test_event_enable
Message-ID: <20221114131028.110a91c4@gandalf.local.home>
In-Reply-To: <20221105175241.858bbd5b5337fc2b8a075ee9@kernel.org>
References: <20221104020931.231090-1-zouyipeng@huawei.com>
        <20221105175241.858bbd5b5337fc2b8a075ee9@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 5 Nov 2022 17:52:41 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Yipeng,
> 
> On Fri, 4 Nov 2022 10:09:31 +0800
> Yipeng Zou <zouyipeng@huawei.com> wrote:
> 
> > In some platform, the schedule event may came slowly, delay 100ms can't
> > cover it.
> > 
> > I was notice that on my board which running in low cpu_freq,and this
> > selftests allways gose fail.  
> 
> This looks good to me, since this can just extend the waiting time to 1 sec.
> (and most of the platforms have no effect)
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Care to take this through your tree?

Thanks,

-- Steve


> Thank you!
> 
> > 
> > So maybe we can check more times here to wait longer.
> > 
> > Fixes: 43bb45da82f9 ("selftests: ftrace: Add a selftest to test event enable/disable func trigger")
> > Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> > ---
> >  .../ftrace/test.d/ftrace/func_event_triggers.tc   | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> > index 8d26d5505808..3eea2abf68f9 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> > @@ -38,11 +38,18 @@ cnt_trace() {
> >  
> >  test_event_enabled() {
> >      val=$1
> > +    check_times=10		# wait for 10 * SLEEP_TIME at most
> >  
> > -    e=`cat $EVENT_ENABLE`
> > -    if [ "$e" != $val ]; then
> > -	fail "Expected $val but found $e"
> > -    fi
> > +    while [ $check_times -ne 0 ]; do
> > +	e=`cat $EVENT_ENABLE`
> > +	if [ "$e" == $val ]; then
> > +	    return 0
> > +	fi
> > +	sleep $SLEEP_TIME
> > +	check_times=$((check_times - 1))
> > +    done
> > +
> > +    fail "Expected $val but found $e"
> >  }
> >  
> >  run_enable_disable() {
> > -- 
> > 2.17.1
> >   
> 
> 

