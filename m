Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6F1B6ABF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgDXBSN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Apr 2020 21:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgDXBSM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Apr 2020 21:18:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015B32074F;
        Fri, 24 Apr 2020 01:18:10 +0000 (UTC)
Date:   Thu, 23 Apr 2020 21:18:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     <shuah@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        <mingo@redhat.com>, <ice_yangxiao@163.com>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Check the first record for
 kprobe_args_type.tc
Message-ID: <20200423211809.7cdb1f90@oasis.local.home>
In-Reply-To: <5EA23D0F.5020304@cn.fujitsu.com>
References: <20200407063419.292821-1-yangx.jy@cn.fujitsu.com>
        <20200407095400.2a13b821@gandalf.local.home>
        <20200408003026.24627a881c8f1eacb01cea48@kernel.org>
        <5E96611B.10100@cn.fujitsu.com>
        <5EA23D0F.5020304@cn.fujitsu.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 24 Apr 2020 09:12:47 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> Hi Shuah,
> 
> Ping.

Shuah usually responds to her linuxfoundation.org email a bit better [ added ].

-- Steve

> 
> Best Regards,
> Xiao Yang
> On 2020/4/15 9:19, Xiao Yang wrote:
> > Hi Shuah,
> >
> > Sorry to bother you.
> > Steven and Masami have reviewed this patch so can you apply it to your
> > tree?
> >
> > Thanks,
> > Xiao Yang
> > On 2020/4/7 23:30, Masami Hiramatsu wrote:  
> >> On Tue, 7 Apr 2020 09:54:00 -0400
> >> Steven Rostedt<rostedt@goodmis.org> wrote:
> >>  
> >>> On Tue, 7 Apr 2020 14:34:19 +0800
> >>> Xiao Yang<yangx.jy@cn.fujitsu.com> wrote:
> >>>  
> >>>> It is possible to get multiple records from trace during test and
> >>>> then more
> >>>> than 4 arguments are assigned to ARGS. This situation results in the
> >>>> failure
> >>>> of kprobe_args_type.tc. For example:
> >>>> -----------------------------------------------------------
> >>>> grep testprobe trace
> >>>> ftracetest-5902 [001] d... 111195.682227: testprobe:
> >>>> (_do_fork+0x0/0x460) arg1=334823024 arg2=334823024 arg3=0x13f4fe70
> >>>> arg4=7
> >>>> pmlogger-5949 [000] d... 111195.709898: testprobe:
> >>>> (_do_fork+0x0/0x460) arg1=345308784 arg2=345308784 arg3=0x1494fe70
> >>>> arg4=7
> >>>> grep testprobe trace
> >>>> sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2
> >>>> \3 \4/'
> >>>> ARGS='334823024 334823024 0x13f4fe70 7
> >>>> 345308784 345308784 0x1494fe70 7'
> >>>> -----------------------------------------------------------
> >>>>
> >>>> We don't care which process calls do_fork so just check the first
> >>>> record to
> >>>> fix the issue.  
> >>>
> >>> Looks good to me, but Masami will need to ack it.
> >>>  
> >>
> >> Ah, good catch! I had fixed similar issue but missed this one.
> >>
> >> Acked-by: Masami Hiramatsu<mhiramat@kernel.org>
> >>
> >> Thank you!
> >>  
> >>> -- Steve
> >>>  
> >>>>
> >>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>>> ---
> >>>> .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git
> >>>> a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >>>> b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >>>> index 1bcb67dcae26..81490ecaaa92 100644
> >>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >>>> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
> >>>> echo 0> events/kprobes/testprobe/enable
> >>>>
> >>>> : "Confirm the arguments is recorded in given types correctly"
> >>>> - ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\)
> >>>> arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> >>>> + ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.*
> >>>> arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> >>>> check_types $ARGS $width
> >>>>
> >>>> : "Clear event for next loop"  
> >>>  
> >>
> >>  
> >  
> 
> 

