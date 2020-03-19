Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11D18B3E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Mar 2020 14:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCSNEl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 09:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgCSNEl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 09:04:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CD420722;
        Thu, 19 Mar 2020 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623080;
        bh=VvNu7YV9HwCcFGfgNoTBz+/x/ApwNNpcUctJTQTVmkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MnTkV+7qzOBg+Sk5feH2w3s3XPnKzhWJKqaXis4JzOoSpC2sx0zXmnbjddUw940eM
         s1cpvmMjRmFBNPxwOZ0p4JTojmMnP3kpaRCr+fCSb0KA1ffGzh71sBLIjTdD+nqz1V
         cy4ybiIEwEVwRBIObGKfEBMe1PeU4T7AqoIaZHns=
Date:   Thu, 19 Mar 2020 22:04:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [RFC][PATCH 12/11] selftest/ftrace: Fix function trigger test
 to handle trace not disabling the tracer
Message-Id: <20200319220435.0f1830f9d11cc05befee26e8@kernel.org>
In-Reply-To: <CAKocOOPBiHsh6Y6gVcwcaUOv7CD=eqtKM+-6L23WzuCnUyR26A@mail.gmail.com>
References: <20200317213222.421100128@goodmis.org>
        <20200318111345.0516642e@gandalf.local.home>
        <CAKocOOPBiHsh6Y6gVcwcaUOv7CD=eqtKM+-6L23WzuCnUyR26A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 18 Mar 2020 10:35:29 -0600
Shuah Khan <shuahkhan@gmail.com> wrote:

> On Wed, Mar 18, 2020 at 9:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > The ftrace selftest "ftrace - test for function traceon/off triggers"
> > enables all events and reads the trace file. Now that the trace file does
> > not disable tracing, and will attempt to continually read new data that is
> > added, the selftest gets stuck reading the trace file. This is because the
> > data added to the trace file will fill up quicker than the reading of it.
> >
> > By only enabling scheduling events, the read can keep up with the writes.
> > Instead of enabling all events, only enable the scheduler events.
> >
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!


> > ---
> >  .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc  | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> +  linux-kselttest and my LF email.
> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu <mhiramat@kernel.org>
