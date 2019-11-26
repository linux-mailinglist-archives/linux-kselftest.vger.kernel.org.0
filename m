Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA05109997
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 08:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfKZHbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 02:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfKZHbh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 02:31:37 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565512068E;
        Tue, 26 Nov 2019 07:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574753496;
        bh=pZooaciT0y37+4+FI0SqHLZWxcx11LQh0Nrdh9BgFw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgbeNQIEFyY4uAeIgo1Qa7cEJNQJ8E5xq6qCJSyxMZDVJoGC/QLiJK4cNZ1XusAKB
         rnCEaJkutjfVXn06isMyc5E3TJdl6cD0ULjfA/ip9vY4/ueIdjWuO5NdkkJqzaIGmT
         bVj8ZNF8EWJXZuONu1DVsuu9hy2ch7MHiDQrOau0=
Date:   Tue, 26 Nov 2019 16:31:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 1/4] selftests/ftrace: Fix to check the
 existence of set_ftrace_filter
Message-Id: <20191126163132.59a0c9811acdcf62a7431222@kernel.org>
In-Reply-To: <20191125205429.5c9ba8c4@gandalf.local.home>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
        <157466502067.21973.8795718044691377192.stgit@devnote2>
        <20191125094445.03d0c8df@gandalf.local.home>
        <20191126091345.e2eb722e2939864eeb01bc7e@kernel.org>
        <20191125205429.5c9ba8c4@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Nov 2019 20:54:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 26 Nov 2019 09:13:45 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > @@ -93,7 +96,6 @@ initialize_ftrace() { # Reset ftrace to initial-state
> > > >      disable_events
> > > >      [ -f set_event_pid ] && echo > set_event_pid
> > > >      [ -f set_ftrace_pid ] && echo > set_ftrace_pid
> > > > -    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*  
> > > 
> > > The above should be changed to:
> > > 
> > > 	[ -f set_ftrace_notrace ] && echo > set_ftrace_notrace  
> > 
> > Ah, good point! I think that should be done by another patch, since
> > it will improve ftracetest.
> 
> No, it belongs in this patch, because you are removing:
> 
> 	[ -f set_ftrace_filter ] && echo | tee set_ftrace_*
> 
> which is equivalent to:
> 
> 	[ -f set_ftrace_filter ] && echo > set_ftrace_filter
> 	[ -f set_ftrace_filter ] && echo > set_ftrace_notrace
> 
> as the "tee set_ftrace_*" covers both.

Ah, I see. 

> 
> Without this change, this patch removes the update to
> set_ftrace_notrace.

OK, I'll update it.

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
