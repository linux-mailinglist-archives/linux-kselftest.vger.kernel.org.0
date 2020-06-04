Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D125E1EE763
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jun 2020 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgFDPIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Jun 2020 11:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbgFDPIy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Jun 2020 11:08:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A37206DC;
        Thu,  4 Jun 2020 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591283334;
        bh=6mDS3TUT6wjNVZsmflKzFxclSga0iqajXZohVosaTJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjJSjAa+iyhkee6DUi4Xvs/9FZDLLs+rziSU6JqT7UEqkoK38iCaW8zvWWyy7oakb
         Iz36muVvHQ1fC3z8Mo5I7/VYIDzCGDBXLI72oW/cuSDMtmtA03jydkNYn1NnTGjOgL
         TKGG6r8F+ufp0FHountJWLJBWplmBxWsMgHkyM+4=
Date:   Fri, 5 Jun 2020 00:08:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Message-Id: <20200605000850.9dc797919133e3e245ceda99@kernel.org>
In-Reply-To: <20200603103343.2db5b5c6@gandalf.local.home>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
        <159108891139.42416.16735397217311780715.stgit@devnote2>
        <20200602092145.06afaf72@gandalf.local.home>
        <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
        <20200603103343.2db5b5c6@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Steve,

On Wed, 3 Jun 2020 10:33:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 3 Jun 2020 08:51:13 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 2 Jun 2020 09:21:45 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Tue,  2 Jun 2020 18:08:31 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > +++ b/tools/testing/selftests/ftrace/test.d/template
> > > > @@ -1,6 +1,7 @@
> > > >  #!/bin/sh
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  # description: %HERE DESCRIBE WHAT THIS DOES%
> > > > +# requires: %HERE LIST UP REQUIRED FILES%  
> > > 
> > > Not sure what you mean by "LIST UP". Perhaps you mean "LIST OF"?  
> > 
> > Ah, perhups we don't need UP. "list the required files" will be OK?
> > 
> >
> 
> Yes, that sounds much better.
> 
> I tested out the patches with a few different configurations, and they all
> look good.
> 
> Although I found that the irqsoff_tracer.tc (test for the preemptirqsoff
> tracer) changed from UNRESOLVED to UNSUPPORTED.

Yes, I think it should be unsupported if the kernel doesn't configure the
feature.

> 
> I'll run a few more different configs and see what happens, but you can add:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks, and I've already sent v3.

https://lkml.kernel.org/r/159115200085.70027.6141550347953439240.stgit@devnote2


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
