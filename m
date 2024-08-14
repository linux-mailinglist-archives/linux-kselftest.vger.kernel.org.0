Return-Path: <linux-kselftest+bounces-15328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D115951F03
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853141F24293
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378271B5836;
	Wed, 14 Aug 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWkWPtjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C71B580E;
	Wed, 14 Aug 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650455; cv=none; b=gSy+yglBUerXEls91pNvBvRTvrvQoXycXlsyC4+KKPasNZyy+CLYKmysqJ8xfdSqu/xAABPPnjGDgzqFwAlM8UFGTH/0pM4+g8x8BBokLRdz6hVAjGkCLLShzxs4WeTv8Tlsy4xe1as1FadYE/eX+BAnpm1l/RDk8/MZt6KFHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650455; c=relaxed/simple;
	bh=VWXqPii6p9P30d6ou5jZRjbh7KsFz67dSp0w6vZgo9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iV/OiGBIyGmV5OqUbijDyR+ZBgdSsqiwACStVhVcJQVVxPfSshlNS3B1zj4CzVbStuUQZSdcHL4YcE9Ain4U3fUjlVZERAyYfGndG/zadoW7emSEsYjWkKFY/t95i8Ju62H2pSv9SKr8Jr8I04vpagJRHP1AL5hiutBwhzjkoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWkWPtjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB6C116B1;
	Wed, 14 Aug 2024 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723650454;
	bh=VWXqPii6p9P30d6ou5jZRjbh7KsFz67dSp0w6vZgo9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWkWPtjCPKbqOUZeACcYSLnXpJgj9h9N/x1Ba9nLw5woFkFoze1ZiNLumjhTOX3p9
	 pb/huT2uc8P6ugu9LyRz8XTe+5eKojPwv9Hmm93zcDgU9C2dfwLfJxpPWv+16qd7oV
	 G+insdxBDurDR1iKnEK6TLouMlumyIrPmrJyNYuWm4J31ZQUp7IpF4bezWcUOa7xTK
	 siYzZWgWvZMYhxp0cbrb5FRRKF1idYlTduqiTVF67lGVYuYmkoRhOzrlRRUFZVu5nW
	 N3qWb7XnzL9wh5LGzuYW2X6/be2kVf54VY1IsOq65NQBikiFy+8rLKxLXkryq3joAX
	 +lx5oGFOGZf/g==
Date: Thu, 15 Aug 2024 00:47:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Tom
 Zanussi <zanussi@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/tracing: Add hist poll() support test
Message-Id: <20240815004730.180bf760e27cb5a6959898ee@kernel.org>
In-Reply-To: <2c13840e-2717-4f88-b613-f6a770be2d75@linuxfoundation.org>
References: <172359427367.323666.6446548762874507863.stgit@devnote2>
	<172359430351.323666.9768554440535494357.stgit@devnote2>
	<2c13840e-2717-4f88-b613-f6a770be2d75@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 05:38:24 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/13/24 18:11, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a testcase for poll() on hist file. This introduces a helper binary
> > to the ftracetest, because there is no good way to reliably execute
> > poll() on hist file.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   Changes in v2:
> >    - Update poll command to support both of POLLIN and POLLPRI, and timeout.
> >    - Identify unsupported stable kernel if poll-in returns soon.
> >    - Test both of POLLIN and POLLPRI.
> > ---
> >   tools/testing/selftests/ftrace/Makefile            |    2 +
> >   tools/testing/selftests/ftrace/poll.c              |   62 +++++++++++++++++
> >   .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 tools/testing/selftests/ftrace/poll.c
> >   create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> > index a1e955d2de4c..49d96bb16355 100644
> > --- a/tools/testing/selftests/ftrace/Makefile
> > +++ b/tools/testing/selftests/ftrace/Makefile
> > @@ -6,4 +6,6 @@ TEST_PROGS := ftracetest-ktap
> >   TEST_FILES := test.d settings
> >   EXTRA_CLEAN := $(OUTPUT)/logs/*
> >   
> > +TEST_GEN_PROGS = poll
> > +
> >   include ../lib.mk
> > diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
> > new file mode 100644
> > index 000000000000..8003a59fe042
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/poll.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Simple poll on a file.
> > + *
> > + * Copyright (c) 2024 Google LLC.
> > + */
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <poll.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#define BUFSIZE 4096
> > +
> > +/*
> > + * Usage:
> > + *  poll <in|pri> <FILE> [timeout]
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	struct pollfd pfd;
> > +	char buf[BUFSIZE];
> > +	int timeout = -1;
> > +	int ret;
> > +
> > +	if (argc < 3)
> > +		return -1;
> > +
> > +	if (!strcmp(argv[1], "in"))
> > +		pfd.events = POLLIN;
> > +	else if (!strcmp(argv[1], "pri"))
> > +		pfd.events = POLLPRI;
> > +
> > +	pfd.fd = open(argv[2], O_RDONLY);
> > +	if (pfd.fd < 0) {
> > +		perror("open");
> > +		return -1;
> > +	}
> > +
> > +	if (argc == 4)
> > +		timeout = atoi(argv[3]);
> 
> This code can be simpler and more maintainable using getopt.
> Any reason why you didn't use it?

There is no reason. OK, let me use getopt to clean it up.

> 
> > +
> > +	/* Reset poll by read if POLLIN is specified. */
> > +	if (pfd.events & POLLIN)
> > +		do {} while (read(pfd.fd, buf, BUFSIZE) == BUFSIZE);
> > +
> > +	ret = poll(&pfd, 1, timeout);
> > +	if (ret < 0 && errno != EINTR) {
> > +		perror("poll")> +		return -1;
> > +	}
> > +	close(pfd.fd);
> > +
> > +	/* If timeout happned, return code is 0 */
> 
> Spelling - happened

Oops, thanks!

> 
> > +	if (ret == 0)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> > new file mode 100644
> > index 000000000000..53bea74e2234
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
> > +${POLL} in ${EVENT}/hist 1000
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
> > +${POLL} in ${EVENT}/hist 4000
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
> > +# Test POLLPRI
> > +echo > trace
> > +echo 1 > tracing_on
> > +
> > +# This sleep command will exit after 2 seconds.
> > +sleep 2 &
> > +BGPID=$!
> > +# if timeout happens, poll returns 1.
> > +${POLL} pri ${EVENT}/hist 4000
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
> > 
> 
> thanks,
> -- Shuah
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

