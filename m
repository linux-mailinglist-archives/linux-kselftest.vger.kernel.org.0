Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD48570EF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 02:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiGLAgA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 20:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGLAgA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 20:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A8286FB;
        Mon, 11 Jul 2022 17:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EEE5614D0;
        Tue, 12 Jul 2022 00:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48765C34115;
        Tue, 12 Jul 2022 00:35:56 +0000 (UTC)
Date:   Mon, 11 Jul 2022 20:35:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: func_event_triggers: fix typo in user
 message
Message-ID: <20220711203554.0466ec53@gandalf.local.home>
In-Reply-To: <20220105185609.4ca10a41@gandalf.local.home>
References: <20211226023204.18315-1-rdunlap@infradead.org>
        <20220105185609.4ca10a41@gandalf.local.home>
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

On Wed, 5 Jan 2022 18:56:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Dec 2021 18:32:04 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > Correct typo of "it's" to "it".
> >   
> 
> Shuah, want to take this?

I guess this fell through the cracks.

Shuah?

-- Steve

> 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > ---
> >  tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next-20211224.orig/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> > +++ linux-next-20211224/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
> > @@ -85,7 +85,7 @@ run_enable_disable() {
> >  	echo $check_disable > $EVENT_ENABLE
> >      done
> >      sleep $SLEEP_TIME
> > -    echo " make sure it's still works"
> > +    echo " make sure it still works"
> >      test_event_enabled $check_enable_star
> >  
> >      reset_ftrace_filter  
> 

