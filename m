Return-Path: <linux-kselftest+bounces-23760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490D9FCF71
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B91883592
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2E79C4;
	Fri, 27 Dec 2024 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI9dHQoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE872F28;
	Fri, 27 Dec 2024 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735263019; cv=none; b=itvvy+EuQE+lX1zxeyeLNsEThxUTmP6sRqesTCJcRKMQFco8TjB/qbvIifuMiFCy3X3TN6HNHSLDC0ERDsNWLffuNsxcKqPY/KO5jaI/Cd3FErWlIgbkM9ixvkcHr8gKBeHPpfXFTDlEpmFSXbaa0ZKKQtF/qkZH54t3lLRyNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735263019; c=relaxed/simple;
	bh=bL7mFjSQiSMajR8ODJjm4NG1hBy2Xt2yRNQr3SGvySg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n3637hxW9NsxsllYyGPeuGPgnEgX5spv8M718skokpAGu5f66QFgppjQ8/wfiXsSUKjCQ+b27StYnijUkdU7NiTLRh44/I9f2PkEaquWcaMOUQNjhwZ5SbXA/CQ/Wthh9NE3Bw1ps9tLW/F1mEBKeGQQ3FVoVPWFDl7qgPAoGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI9dHQoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B103C4CED1;
	Fri, 27 Dec 2024 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735263019;
	bh=bL7mFjSQiSMajR8ODJjm4NG1hBy2Xt2yRNQr3SGvySg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YI9dHQoZotb0MpOXZ73KXiUDXiBlOMBcWKFwgXaNnpVX10ZrFtkUonlMzE6x1Ok1R
	 yZEP+vRh7tHnnPrDFuaNDCPPYMcvfy9ZL+Y/C/TYsyWYJJFfNnJuyQL4Qt5oM6dNKI
	 5iJarl4ksMd5/6fLtkB+16Z+9CXuNuS/xHN2kzapxz1AKtsSIRDSKM6nVZPd3rmS+O
	 P+aGQ1vg7QR0VZN1afvX3vI0CHZWqiMn5F0mYo2GRKXo2/G3q84+ol/53bwrw4AvYS
	 9qIKENGuEnmCspAUa0yrOpbwdEA6cA3qnl9lMdMmtsUcd0rnWaZV/qBYcohvfop9ah
	 7LckEZBNd5EoA==
Date: Fri, 27 Dec 2024 10:30:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/3] selftests/tracing: Add hist poll() support test
Message-Id: <20241227103015.eabeef287a1af23c0810ea51@kernel.org>
In-Reply-To: <20241219110434.3cb3f47c@gandalf.local.home>
References: <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
	<172907578159.470540.12276069200453397317.stgit@mhiramat.roam.corp.google.com>
	<20241219110434.3cb3f47c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 19 Dec 2024 11:04:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 16 Oct 2024 19:49:41 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > @@ -0,0 +1,74 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test poll wait on histogram
> > +# requires: set_event events/sched/sched_process_free/trigger events/sched/sched_process_free/hist
> > +# flags: instance
> > +
> > +POLL=${FTRACETEST_ROOT}/poll
> > +
> > +if [ ! -x ${POLL} ]; then
> > +  echo "poll program is not compiled!"
> > +  exit_unresolved
> > +fi
> > +
> > +EVENT=events/sched/sched_process_free/
> > +
> > +# Check poll ops is supported. Before implementing poll on hist file, it
> > +# returns soon with POLLIN | POLLOUT, but not POLLPRI.
> > +
> > +# This must wait >1 sec and return 1 (timeout).
> > +set +e
> > +${POLL} -I -t 1000 ${EVENT}/hist
> > +ret=$?
> > +set -e
> > +if [ ${ret} != 1 ]; then
> > +  echo "poll on hist file is not supported"
> > +  exit_unsupported
> > +fi
> > +
> > +# Test POLLIN
> > +echo > trace
> > +echo "hist:key=comm" > ${EVENT}/trigger
> > +echo 1 > ${EVENT}/enable
> > +
> > +# This sleep command will exit after 2 seconds.
> > +sleep 2 &
> > +BGPID=$!
> > +# if timeout happens, poll returns 1.
> > +${POLL} -I -t 4000 ${EVENT}/hist
> > +echo 0 > tracing_on
> > +
> > +if [ -d /proc/${BGPID} ]; then
> > +  echo "poll exits too soon"
> > +  kill -KILL ${BGPID} ||:
> > +  exit_fail
> > +fi
> > +
> > +if ! grep -qw "sleep" trace; then
> > +  echo "poll exits before event happens"
> 
> I ran this and it failed here. But it wasn't because the poll failed, it's
> because the test is wrong. If something else exits during the test, then
> the poll function will exit early.

Hmm, so another process exits before sleep exits, it fails, yes.

> 
> What the check should do is simply read the hist file, get the hist count,
> and make sure it's updated after the poll is run, or at least put a filter
> on it:
> 
>   echo 'hist:keys=comm if comm =="sleep"' > /sys/kernel/tracing/events/sched/sched_process_free/trigger
> 
> Which would work as long as no other "sleep" exits during the test.

OK, let me update the series.

Thanks!

> 
> -- Steve
> 
> > +  exit_fail
> > +fi
> > +
> > +# Test POLLPRI
> > +echo > trace
> > +echo 1 > tracing_on
> > +
> > +# This sleep command will exit after 2 seconds.
> > +sleep 2 &
> > +BGPID=$!
> > +# if timeout happens, poll returns 1.
> > +${POLL} -P -t 4000 ${EVENT}/hist
> > +echo 0 > tracing_on
> > +
> > +if [ -d /proc/${BGPID} ]; then
> > +  echo "poll exits too soon"
> > +  kill -KILL ${BGPID} ||:
> > +  exit_fail
> > +fi
> > +
> > +if ! grep -qw "sleep" trace; then
> > +  echo "poll exits before event happens"
> > +  exit_fail
> > +fi
> > +
> > +exit_pass
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

