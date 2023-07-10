Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9747674E07A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGJVyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJVyl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9412F;
        Mon, 10 Jul 2023 14:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3702C6121C;
        Mon, 10 Jul 2023 21:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7294C433C8;
        Mon, 10 Jul 2023 21:54:37 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:54:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Test toplevel-enable for instance
Message-ID: <20230710175415.2ec0061f@gandalf.local.home>
In-Reply-To: <20230609174626.66659892@gandalf.local.home>
References: <20230509203659.1173917-1-zhengyejian1@huawei.com>
        <20230609174626.66659892@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi Shuah,

I think this dropped through the cracks. Can you take this through your
tree?

-- Steve

On Fri, 9 Jun 2023 17:46:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 10 May 2023 04:36:59 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
> > 'available_events' is actually not required by
> > 'test.d/event/toplevel-enable.tc' and its Existence has been tested in
> > 'test.d/00basic/basic4.tc'.
> > 
> > So the require of 'available_events' can be dropped and then we can add
> > 'instance' flag to test 'test.d/event/toplevel-enable.tc' for instance.
> > 
> > Test result show as below:
> >  # ./ftracetest test.d/event/toplevel-enable.tc
> >  === Ftrace unit tests ===
> >  [1] event tracing - enable/disable with top level files [PASS]
> >  [2] (instance)  event tracing - enable/disable with top level files [PASS]
> > 
> >  # of passed:  2
> >  # of failed:  0
> >  # of unresolved:  0
> >  # of untested:  0
> >  # of unsupported:  0
> >  # of xfailed:  0
> >  # of undefined(test bug):  0
> > 
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>  
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> > ---
> >  tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > index 93c10ea42a68..8b8e1aea985b 100644
> > --- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
> > @@ -1,7 +1,8 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0
> >  # description: event tracing - enable/disable with top level files
> > -# requires: available_events set_event events/enable
> > +# requires: set_event events/enable
> > +# flags: instance
> >  
> >  do_reset() {
> >      echo > set_event  

