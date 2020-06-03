Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA11ED220
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCOdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jun 2020 10:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgFCOdq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jun 2020 10:33:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183F320679;
        Wed,  3 Jun 2020 14:33:44 +0000 (UTC)
Date:   Wed, 3 Jun 2020 10:33:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Message-ID: <20200603103343.2db5b5c6@gandalf.local.home>
In-Reply-To: <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
        <159108891139.42416.16735397217311780715.stgit@devnote2>
        <20200602092145.06afaf72@gandalf.local.home>
        <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 3 Jun 2020 08:51:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 2 Jun 2020 09:21:45 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue,  2 Jun 2020 18:08:31 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > +++ b/tools/testing/selftests/ftrace/test.d/template
> > > @@ -1,6 +1,7 @@
> > >  #!/bin/sh
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  # description: %HERE DESCRIBE WHAT THIS DOES%
> > > +# requires: %HERE LIST UP REQUIRED FILES%  
> > 
> > Not sure what you mean by "LIST UP". Perhaps you mean "LIST OF"?  
> 
> Ah, perhups we don't need UP. "list the required files" will be OK?
> 
>

Yes, that sounds much better.

I tested out the patches with a few different configurations, and they all
look good.

Although I found that the irqsoff_tracer.tc (test for the preemptirqsoff
tracer) changed from UNRESOLVED to UNSUPPORTED.

I'll run a few more different configs and see what happens, but you can add:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
