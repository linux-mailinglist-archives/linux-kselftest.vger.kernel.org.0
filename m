Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AD280E0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgJBHc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 03:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBHc5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 03:32:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D77C2074B;
        Fri,  2 Oct 2020 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601623976;
        bh=nVKh3bIv2KzC4Dp9NwQwJe71uPOxTuhXI4m38ho/o4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M9B/cKMIpSFPNrEGBRiU1Id2VSdk+pYtpE+j4bn5sn6TF08ivgD4W4DAQgj7vA94q
         JNJ79fKiqkGr85Mh2Xo/5DlY+v538+UL2sTbCHp9O+bmETuXgVA2w2v4WotST1OTPz
         x2MLKjs4f+N0AXNdwP+CePiHQecC0dtjZ43iO+PU=
Date:   Fri, 2 Oct 2020 16:32:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
Message-Id: <20201002163253.13feb38f8a1e4f148afca5de@kernel.org>
In-Reply-To: <80cee321-d8ed-31fd-2f53-d9306b1d9545@canonical.com>
References: <20201001085641.51130-1-colin.king@canonical.com>
        <20201001104448.427a0eaa@gandalf.local.home>
        <80cee321-d8ed-31fd-2f53-d9306b1d9545@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 1 Oct 2020 16:40:33 +0100
Colin Ian King <colin.king@canonical.com> wrote:

> On 01/10/2020 15:44, Steven Rostedt wrote:
> > On Thu,  1 Oct 2020 09:56:41 +0100
> > Colin King <colin.king@canonical.com> wrote:
> > 
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> More recent libc implementations are now using openat/openat2 system
> >> calls so also add do_sys_openat2 to the tracing so that the test
> >> passes on these systems because do_sys_open may not be called.
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc  | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> >> index a30a9c07290d..cf1b4c3e9e6b 100644
> >> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> >> @@ -9,6 +9,8 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
> >>  :;: "user-memory access syntax and ustring working on user memory";:
> >>  echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
> >>  	> kprobe_events  
> >> +echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
> >> +	> kprobe_events
> >>
> > 
> > This still wont work, because the rest of the code only enables the myevent
> > event, and not the one you just added.
> 
> Yep, I botched this and tested the wrong fix.
> 
> > 
> > Did you see this broken before, and this patch fixes it?
> 
> So this test breaks with a recent libc and support tools built against
> libc.  I believe the do_sys_open is not being detected because
> do_sys_openat2 is being called instead.
> 
> Not sure now of the correct way to fix this.

Hmm, this actually just try to catch the user-string. So the another
function which accepts any user-string, is OK.
Let me try to use another one. 

Thank you for reporting!


> 
> > 
> > -- Steve
> > 
> >  
> >>  grep myevent kprobe_events | \
> >>  	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
