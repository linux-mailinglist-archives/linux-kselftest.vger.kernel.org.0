Return-Path: <linux-kselftest+bounces-15583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DB95587E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DB61C20C10
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A507442F;
	Sat, 17 Aug 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk5YTgyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDD1E481;
	Sat, 17 Aug 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907185; cv=none; b=bQAcvX8OcMM8FuVBxARBiZNentgxzb8/RB79NOiMgFPNEc/QLXp2Q/0cl6FF+2qKRxp1jnGL+88dxKavU5RJcKtBeAZfnXBd6NNT+R/5KnFiLbIfMwYZ2aA3H69IJoP9MI19mL2SwilKDd9bLlsTRLERUKvGGB3W0IOAM84gxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907185; c=relaxed/simple;
	bh=zbn0E1B0YyTqAT0fzHzfqPqipnMKY9cP86kkdSsHEOc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p/dwpYr+RYstOk85C79ThLJq0/gqIbxDwu/+ZSLbc8gI9pZGzWCZUwubOSZlCaqorzVfNz5ucTLUvk+6w7TRRZvatAWNiCy3TaKzv8ydHFHa4yUdXn551AWl0KnvkyhdZZGYB5jNYHZHHqjN6ySdS1hzi7B1wCkmLoMdJctixfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk5YTgyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73FDC116B1;
	Sat, 17 Aug 2024 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723907184;
	bh=zbn0E1B0YyTqAT0fzHzfqPqipnMKY9cP86kkdSsHEOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mk5YTgyuHWuXeyFhYAJDDz6hmUyxTPU+qYGnNdFM9El07nhxbwkvp8rEPdkYcOh0j
	 62rzPZmE+uR6hmAvlZNRZz8p/lmsV5z+kYI8zVZE+DgnxpYrknlglnsRETns7pcBNy
	 x/aQuQptBX8lkf/chxIlRLqcEjOM9oFevTC8Eu6FqB/yPYhYzZMKmQdL5CAEWpKLvo
	 RUlQXmfzYpxCr8Ap+bgU4sh679WEVqbJluhLuNsxmaY0v4TBBchODkjT2SPtp91dBh
	 6gvf43PEt2iSqP5r0PhAgOCPuLqW/Ec5MEp1+mliAhou7iLuRHR1xK4bb3HK9+6O/W
	 ZHK616u8hjg9Q==
Date: Sun, 18 Aug 2024 00:06:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Tom
 Zanussi <zanussi@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/3] selftests/tracing: Add hist poll() support test
Message-Id: <20240818000620.ba9a93ccb82bc48cd3155cc7@kernel.org>
In-Reply-To: <fdd141e8-337b-4f6c-a721-7d20dc63b50d@linuxfoundation.org>
References: <172377544331.67914.7474878424159759789.stgit@devnote2>
	<172377547205.67914.494998437883733530.stgit@devnote2>
	<fdd141e8-337b-4f6c-a721-7d20dc63b50d@linuxfoundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 08:04:41 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/15/24 20:31, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a testcase for poll() on hist file. This introduces a helper binary
> > to the ftracetest, because there is no good way to reliably execute
> > poll() on hist file.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   Changes in v4:
> >    - Use getopt() in poll.c (command options are changed)
> >    - Update test code according to the new command options.
> >   Changes in v2:
> >    - Update poll command to support both of POLLIN and POLLPRI, and timeout.
> >    - Identify unsupported stable kernel if poll-in returns soon.
> >    - Test both of POLLIN and POLLPRI.
> > ---
> >   tools/testing/selftests/ftrace/Makefile            |    2 +
> >   tools/testing/selftests/ftrace/poll.c              |   74 ++++++++++++++++++++
> >   .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
> >   3 files changed, 150 insertions(+)
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
> > index 000000000000..584f159654b1
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/poll.c
> > @@ -0,0 +1,74 @@
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
> > + *  poll [-I|-P] [-t timeout] FILE
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	struct pollfd pfd = {.events = POLLIN};
> > +	char buf[BUFSIZE];
> > +	int timeout = -1;
> > +	int ret, opt;
> > +
> > +	while ((opt = getopt(argc, argv, "IPt:")) != -1) {
> > +		switch (opt) {
> > +		case 'I':
> > +			pfd.events = POLLIN;
> > +			break;
> > +		case 'P':
> > +			pfd.events = POLLPRI;
> > +			break;
> > +		case 't':
> > +			timeout = atoi(optarg);
> > +			break;
> > +		default:
> > +			fprintf(stderr, "Usage: %s [-I|-P] [-t timeout] FILE\n",
> > +				argv[0]);
> > +			return -1;
> > +		}
> > +	}
> > +	if (optind >= argc) {
> > +		fprintf(stderr, "Error: Polling file is not specified\n");
> > +		return -1;
> > +	}
> > +
> > +	pfd.fd = open(argv[optind], O_RDONLY);
> > +	if (pfd.fd < 0) {
> > +		fprintf(stderr, "failed to open %s", argv[optind]);
> > +		perror("open");
> > +		return -1;
> > +	}
> > +
> > +	/* Reset poll by read if POLLIN is specified. */
> > +	if (pfd.events & POLLIN)
> > +		do {} while (read(pfd.fd, buf, BUFSIZE) == BUFSIZE);
> > +
> > +	ret = poll(&pfd, 1, timeout);
> > +	if (ret < 0 && errno != EINTR) {
> > +		perror("poll");
> > +		return -1;
> > +	}
> > +	close(pfd.fd);
> > +
> > +	/* If timeout happned, return code is 0 */
> 
> Looks like you missed this one :) Otherwise looks good to me.
> 
Oops, indeed.

> With this fixed
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks!

> 
> thanks,
> -- Shuah


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

