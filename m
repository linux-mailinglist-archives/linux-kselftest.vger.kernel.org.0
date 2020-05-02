Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978931C226B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 May 2020 05:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgEBDFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 23:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgEBDFn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 23:05:43 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A8720857;
        Sat,  2 May 2020 03:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588388742;
        bh=whnRbEL8VMPFploT9OMFbLOr5/cBg0hfDQ+sF+5UN/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu+idBLfSXLHIdDePFtX9lmD55VCxnpVkMnzmWd5K5D+NHWFseCDotsWOyw+ieSOI
         sa9Yu3ipnEbPQgyA4qsUMXNa1M7v0v7Ft+xx7Wcuk8nG1A4ndb8MA+2n8o1ziElyMH
         IreWuCtd6Q76feVs/WmHHIn/jKYD6cGBPUZU5sFc=
Date:   Sat, 2 May 2020 12:05:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event
 to test
Message-Id: <20200502120537.cfa3cdc1d898a12dc0c15471@kernel.org>
In-Reply-To: <7751734b-83f1-bf14-9d8e-9092b0b7be3e@kernel.org>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834027133.28357.11196486193798517250.stgit@devnote2>
        <20200501101718.5a15e557@gandalf.local.home>
        <7751734b-83f1-bf14-9d8e-9092b0b7be3e@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 1 May 2020 09:38:59 -0600
shuah <shuah@kernel.org> wrote:

> On 5/1/20 8:17 AM, Steven Rostedt wrote:
> > On Fri,  1 May 2020 22:37:51 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> Since the kprobe/kprobe_args_type.tc reads out all event logs
> >> from the trace buffer, the test can fail if there is another
> >> fork event happens.
> >> Use head command to pick only the first kprobe event from
> >> the trace buffer to test the argument types.
> >>
> >> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> ---
> >>   .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >> index 1bcb67dcae26..81490ecaaa92 100644
> >> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> >> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
> >>     echo 0 > events/kprobes/testprobe/enable
> >>   
> >>     : "Confirm the arguments is recorded in given types correctly"
> >> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> >> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> >>     check_types $ARGS $width
> >>   
> >>     : "Clear event for next loop"
> > 
> > I think I've manually added this exact change to my tests to keep it from
> > failing.
> > 
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> 
> Does this conflict with:
> 
> Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Date:   Tue Apr 7 14:34:19 2020 +0800
> 
>      selftests/ftrace: Check the first record for kprobe_args_type.tc
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba
> 
> I went into mainline yesterday in my rc4 pull request.
> 
> Exact change it appears.
> 
> diff --git 
> a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc 
> b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> index 1bcb67dcae26..81490ecaaa92 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>     echo 0 > events/kprobes/testprobe/enable
> 
>     : "Confirm the arguments is recorded in given types correctly"
> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) 
> arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) 
> arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>     check_types $ARGS $width
> 
>     : "Clear event for next loop"

Oops, yes, please drop this patch.

Thank you,

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu <mhiramat@kernel.org>
