Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488AF628F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2019 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfGHTHE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Jul 2019 15:07:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHTHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Jul 2019 15:07:04 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1hkYyc-0002yW-96; Mon, 08 Jul 2019 19:07:02 +0000
Date:   Mon, 8 Jul 2019 16:06:57 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: avoid failure when trying to probe a
 notrace function
Message-ID: <20190708190656.GR4306@calabresa>
References: <20190708181933.10286-1-cascardo@canonical.com>
 <20190708145618.6649f397@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708145618.6649f397@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 08, 2019 at 02:56:18PM -0400, Steven Rostedt wrote:
> On Mon,  8 Jul 2019 15:19:33 -0300
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> 
> > Check that the function is on available_filter_functions. If it's not,
> > mark the test as unresolved, instead of failing it.
> > 
> 
> Actually, I sent this out a while ago:
> 
>   http://lkml.kernel.org/r/20190322150923.1b58eca5@gandalf.local.home
> 
> Does that fix it for you?
> 
> -- Steve

Yes, that fix it for me, let me reply to the original message.

Thanks!
Cascardo.

> 
> 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > index 3fb70e01b1fe..e4dff034da12 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > @@ -26,6 +26,7 @@ test -d events/kprobes2/event2 || exit_failure
> >  
> >  FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> >  [ "x" != "x$FUNC" ] || exit_unresolved
> > +grep -n "$FUNC" available_filter_functions || exit_unresolved
> >  echo "p $FUNC" > kprobe_events
> >  EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
> >  [ "x" != "x$EVENT" ] || exit_failure
> 
