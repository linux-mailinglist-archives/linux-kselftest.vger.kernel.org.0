Return-Path: <linux-kselftest+bounces-16062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46D95B647
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F090F1F26B39
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7D1C9EB2;
	Thu, 22 Aug 2024 13:19:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62E26AC1;
	Thu, 22 Aug 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332740; cv=none; b=rle6Ejl97cYJvwP44HRkXAB2cmNuG6Wmq7E67hItZkuDhtr0w4DyDXsU28OGUcr7oJ+qx13dmhjAa3Ze65mU9TolsaSZH2ACxvOsq1WDtpdPWc1tWJ4OAx++HByEjizqY8/wWg3YhJMVqGlIVeMTokvWBqVUTRbY2NIoWAaN/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332740; c=relaxed/simple;
	bh=62+kMtC6NlIJHl14fbSPfa6r/YRWOzTjAhv5+RnpJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3sgGBWuhtAP3zVaYjmo+v+7Pcj6VZwRxq7WuATOj8r+LNhVJYGMUlmUkk/GrVPtQ/dKUvkdezBjOhwSfX/BQcIS3Nd6QsZMwuQ/qpkIS4ELp3isEN/6OOkcfCzY9ikHKBwKYyfsSkZlquOPLLaaqZw4M6jQJjLWbjmcmcg2S80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4749C32782;
	Thu, 22 Aug 2024 13:18:58 +0000 (UTC)
Date: Thu, 22 Aug 2024 09:19:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-ID: <20240822091929.0db8837f@gandalf.local.home>
In-Reply-To: <3901c521-be69-4824-a571-9182b9af02b6@linuxfoundation.org>
References: <20240821150903.05c6cf96@gandalf.local.home>
	<3901c521-be69-4824-a571-9182b9af02b6@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 21:54:42 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/21/24 13:09, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Masami reported a bug when running function graph tracing then the
> > function profiler. The following commands would cause a kernel crash:
> > 
> >    # cd /sys/kernel/tracing/
> >    # echo function_graph > current_tracer
> >    # echo 1 > function_profile_enabled
> > 
> > In that order. Create a test to test this two to make sure this does not
> > come back as a regression.
> > 
> > Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >   .../ftrace/test.d/ftrace/fgraph-profiler.tc   | 30 +++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >   create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> > new file mode 100644
> > index 000000000000..62d44a1395da
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-profiler.tc
> > @@ -0,0 +1,30 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: ftrace - function profiler with function graph tracing
> > +# requires: function_profile_enabled set_ftrace_filter function_graph:tracer
> > +
> > +# The function graph tracer can now be run along side of the function
> > +# profiler. But there was a bug that caused the combination of the two
> > +# to crash. It also required the function graph tracer to be started
> > +# first.
> > +#
> > +# This test triggers that bug
> > +#
> > +# We need function_graph and profiling to to run this test
> > +
> > +fail() { # mesg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +echo "Enabling function graph tracer:"
> > +echo function_graph > current_tracer
> > +echo "enable profiler"
> > +
> > +# Older kernels do not allow function_profile to be enabled with
> > +# function graph tracer. If the below fails, mark it as unsupported
> > +echo 1 > function_profile_enabled || exit_unsupported
> > +
> > +sleep 1  
> 
> Any specific reason for this sleep 1 - can you add a comment on top?

We add sleep 1 in several locations of the ftrace selftests to let the
tracing run for a bit just to see if it triggers anything. Otherwise the
clean up can happen before anything gets traced. Although, it's highly
unlikely in this case, but still.

I could add a comment if you want of just:

# let it run for a bit
sleep 1


> > +
> > +exit 0  
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Let me know if you would like v2 for this to be taken through my tree.

I'll make a v2 if you want me to.

-- Steve

