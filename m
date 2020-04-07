Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05811A1036
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgDGPab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 11:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgDGPaa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 11:30:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDAE20748;
        Tue,  7 Apr 2020 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586273430;
        bh=hJoHzjqxSreSAAmQbaDkwgj4+XIVyLQU6f9ubRsQwkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DKc5VqQnfLsPw50LHhnq2BgQCl3JIWgrohPhxAGhueTYWaVPWXkDzbtNaZ0F4e72i
         dIr/WWlMY2F5BXaz+RpJSjx7/5yMakWIml3eB5Pl45FlnXnC2ebXWKzHDNnl9P9L+z
         bFRviMdOG9J66c1Ma1mt88azu0xsIxr7T0w1U0zY=
Date:   Wed, 8 Apr 2020 00:30:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, <mingo@redhat.com>,
        <shuah@kernel.org>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Check the first record for
 kprobe_args_type.tc
Message-Id: <20200408003026.24627a881c8f1eacb01cea48@kernel.org>
In-Reply-To: <20200407095400.2a13b821@gandalf.local.home>
References: <20200407063419.292821-1-yangx.jy@cn.fujitsu.com>
        <20200407095400.2a13b821@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Apr 2020 09:54:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 7 Apr 2020 14:34:19 +0800
> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
> > It is possible to get multiple records from trace during test and then more
> > than 4 arguments are assigned to ARGS.  This situation results in the failure
> > of kprobe_args_type.tc.  For example:
> > -----------------------------------------------------------
> > grep testprobe trace
> >    ftracetest-5902  [001] d... 111195.682227: testprobe: (_do_fork+0x0/0x460) arg1=334823024 arg2=334823024 arg3=0x13f4fe70 arg4=7
> >      pmlogger-5949  [000] d... 111195.709898: testprobe: (_do_fork+0x0/0x460) arg1=345308784 arg2=345308784 arg3=0x1494fe70 arg4=7
> >  grep testprobe trace
> >  sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'
> > ARGS='334823024 334823024 0x13f4fe70 7
> > 345308784 345308784 0x1494fe70 7'
> > -----------------------------------------------------------
> > 
> > We don't care which process calls do_fork so just check the first record to
> > fix the issue.
> 
> Looks good to me, but Masami will need to ack it.
> 

Ah, good catch! I had fixed similar issue but missed this one.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> -- Steve
> 
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc  | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> > index 1bcb67dcae26..81490ecaaa92 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> > @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
> >    echo 0 > events/kprobes/testprobe/enable
> >  
> >    : "Confirm the arguments is recorded in given types correctly"
> > -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> > +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> >    check_types $ARGS $width
> >  
> >    : "Clear event for next loop"
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
