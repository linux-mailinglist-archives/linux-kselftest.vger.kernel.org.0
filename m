Return-Path: <linux-kselftest+bounces-23605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260B9F7ECF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412567A075F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9822579B;
	Thu, 19 Dec 2024 16:03:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998B3D3B8;
	Thu, 19 Dec 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624235; cv=none; b=Bam8xu56QJtyaYfeKNLhDadrj1Dwxa3FfkI9KHzNGR4NTM/TNrv5YPB5LdzApF5TLDlD5L9eL9RuGzo9f0KwwnHt/5IVK1jSX5krJDepPHS1nFJgT7hzcQj+kc/8wOIACZfyRVaYijwd7ib1Cz4bszwmx+B4e9J5My1d/3xxPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624235; c=relaxed/simple;
	bh=fG/Z+aIDZ0+fikN2xWhzPiuy1wtyxIQR8qfElqPEICs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/CmcvtbctZsVvojB15sfzkf5KtMmkzI9Gtu04xFdv1jejrTVXlEaQiZj1LIN6UQNZz3Sylbdg4eMFmFTaE7bYL/YbsNhEnnCXtZIoZiWFcBL+oJkq7UbVLfjmPm5oaAB5JGOmVY+QxtlF64x2mDqeUminKGiwarYMh1sfNCKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81643C4CECE;
	Thu, 19 Dec 2024 16:03:54 +0000 (UTC)
Date: Thu, 19 Dec 2024 11:04:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/3] selftests/tracing: Add hist poll() support test
Message-ID: <20241219110434.3cb3f47c@gandalf.local.home>
In-Reply-To: <172907578159.470540.12276069200453397317.stgit@mhiramat.roam.corp.google.com>
References: <172907575534.470540.12941248697563459082.stgit@mhiramat.roam.corp.google.com>
	<172907578159.470540.12276069200453397317.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 19:49:41 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test poll wait on histogram
> +# requires: set_event events/sched/sched_process_free/trigger events/sched/sched_process_free/hist
> +# flags: instance
> +
> +POLL=${FTRACETEST_ROOT}/poll
> +
> +if [ ! -x ${POLL} ]; then
> +  echo "poll program is not compiled!"
> +  exit_unresolved
> +fi
> +
> +EVENT=events/sched/sched_process_free/
> +
> +# Check poll ops is supported. Before implementing poll on hist file, it
> +# returns soon with POLLIN | POLLOUT, but not POLLPRI.
> +
> +# This must wait >1 sec and return 1 (timeout).
> +set +e
> +${POLL} -I -t 1000 ${EVENT}/hist
> +ret=$?
> +set -e
> +if [ ${ret} != 1 ]; then
> +  echo "poll on hist file is not supported"
> +  exit_unsupported
> +fi
> +
> +# Test POLLIN
> +echo > trace
> +echo "hist:key=comm" > ${EVENT}/trigger
> +echo 1 > ${EVENT}/enable
> +
> +# This sleep command will exit after 2 seconds.
> +sleep 2 &
> +BGPID=$!
> +# if timeout happens, poll returns 1.
> +${POLL} -I -t 4000 ${EVENT}/hist
> +echo 0 > tracing_on
> +
> +if [ -d /proc/${BGPID} ]; then
> +  echo "poll exits too soon"
> +  kill -KILL ${BGPID} ||:
> +  exit_fail
> +fi
> +
> +if ! grep -qw "sleep" trace; then
> +  echo "poll exits before event happens"

I ran this and it failed here. But it wasn't because the poll failed, it's
because the test is wrong. If something else exits during the test, then
the poll function will exit early.

What the check should do is simply read the hist file, get the hist count,
and make sure it's updated after the poll is run, or at least put a filter
on it:

  echo 'hist:keys=comm if comm =="sleep"' > /sys/kernel/tracing/events/sched/sched_process_free/trigger

Which would work as long as no other "sleep" exits during the test.

-- Steve

> +  exit_fail
> +fi
> +
> +# Test POLLPRI
> +echo > trace
> +echo 1 > tracing_on
> +
> +# This sleep command will exit after 2 seconds.
> +sleep 2 &
> +BGPID=$!
> +# if timeout happens, poll returns 1.
> +${POLL} -P -t 4000 ${EVENT}/hist
> +echo 0 > tracing_on
> +
> +if [ -d /proc/${BGPID} ]; then
> +  echo "poll exits too soon"
> +  kill -KILL ${BGPID} ||:
> +  exit_fail
> +fi
> +
> +if ! grep -qw "sleep" trace; then
> +  echo "poll exits before event happens"
> +  exit_fail
> +fi
> +
> +exit_pass


