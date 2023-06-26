Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0274173DC11
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFZKNB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFZKNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 06:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278D18E;
        Mon, 26 Jun 2023 03:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC11E60DCF;
        Mon, 26 Jun 2023 10:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57FCC433C0;
        Mon, 26 Jun 2023 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687774379;
        bh=kpLEOgBekJKzTbb19C33i9D78u2j2+zBDjlD73GNP94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KJWphZS2G90c951n2Z7eKff79huYUejh1Jx/pPWoxCPR3p9tT5v2uMhIvZd/WnkpJ
         NN8msgtncrcjrNn6hUfdSTgdn0MCx2ZS4aKXNwE+a1WQ1rmjWXdV2pcshaoBPSCCjM
         BvDCy0mFCm4DdeKIAQZa4aVkgbuTbPvZmozjjBJ93DKXpWOgt3Cynqnc4ksGp971t2
         bfQv/MJGtfzHQ1R0hfA6KDf827wknEXU1azFM9mNUzjqTO3dyaYQQj36wbbl1h0Vtr
         6J48VtjklBSd6LdstUV/oANBd4IvLn0ArIWtyIh+zK9dG4wSEvZC5rWGG8qUwYI3uT
         Xegc0+dzWq9fQ==
Date:   Mon, 26 Jun 2023 19:12:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <rostedt@goodmis.org>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-Id: <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
In-Reply-To: <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 26 Jun 2023 19:11:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 26 Jun 2023 08:11:44 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
> > Function instance_set() expects to enable event 'sched_switch', so we
> > should set 1 to its 'enable' file.
> > 
> > Testcase passed after this patch:
> >   # ./ftracetest test.d/instances/instance-event.tc
> >   === Ftrace unit tests ===
> >   [1] Test creation and deletion of trace instances while setting an event
> >   [PASS]
> > 
> >   # of passed:  1
> >   # of failed:  0
> >   # of unresolved:  0
> >   # of untested:  0
> >   # of unsupported:  0
> >   # of xfailed:  0
> >   # of undefined(test bug):  0
> > 
> 
> Good catch!
> 
> Fixes: 91e6f1ce8657 ("ftracetest: Add instance created, delete, read and enable event test")
> 
> It seems this tests internally broken but the result is same because this disabled
> error checking ('set +e').

And

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> 
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > ---
> >  .../testing/selftests/ftrace/test.d/instances/instance-event.tc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > index 0eb47fbb3f44..42422e425107 100644
> > --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > @@ -39,7 +39,7 @@ instance_read() {
> >  
> >  instance_set() {
> >          while :; do
> > -                echo 1 > foo/events/sched/sched_switch
> > +                echo 1 > foo/events/sched/sched_switch/enable
> >          done 2> /dev/null
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
