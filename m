Return-Path: <linux-kselftest+bounces-23780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAD9FDEE6
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Dec 2024 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982171881813
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Dec 2024 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3EF146588;
	Sun, 29 Dec 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMTmU0x6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DF1E50B;
	Sun, 29 Dec 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735477740; cv=none; b=GSkN3f2vZvJ/Z3kHqNDmwmp03lIwjXgKZ3yktWqCAQZnO5Qmxc9fbswL2ltvCr6WDtEtIi3EGvpZVSXi/DuRWnZwsqX4e3s0ZDu/Bd9DR4yJuitU6cVE2azvRLRffDKAsUp/WCXfYkQg5zNA1LxYSHde6iVKf35GQ+QvNVU2VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735477740; c=relaxed/simple;
	bh=nX2Ym4mTvkI/pH85nRszn0ivESBAPSghoKp80WFj+2k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LmiPi/NNjaAv/Yu9gu9lJUpLS/hwZ4ncu9RFKxzLPSKT8MC7cEqaL3I1KqcQF3fLElCkQrtGh2yGgCpBUXrGCB+EfC16I3QC5nUkdMTrVKAnqQSbyWkNe5RixtGNz6YqFzh7zRGIX6MvBbNfEiRYY7jgzFqwSCdT5TsMNe3aR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMTmU0x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0EFC4CED1;
	Sun, 29 Dec 2024 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735477740;
	bh=nX2Ym4mTvkI/pH85nRszn0ivESBAPSghoKp80WFj+2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMTmU0x63aJX9EtdO5IyYIrlsxreBcrfyPPcKU1SGppE1x1ARh50Zh0oqN7YFPT0D
	 IvlTNmUHnpCdHFOKxB9r0kHrDdrU16bgbGz8xRO6OKZyASsMDn6xJkV8RFpfSPGJbs
	 TlJu18NeAZvQn0ARmyMeLbHAyeX/fYvNrsu5kMAVCfcJu5WPVcwv3novIeN8XnPAyk
	 FMSeVBOwXAUaOaiMUyBstmQ2rw3vF2ilgpklovfII6EsB1bREYywZDSKC/0hoyDhNr
	 UuS+oqPYyzW2CqAw4+/A8EevbByXKTfSynYQlufrA58t+sjVVGZlUkDLuLwrrciRZL
	 874kaWaVCtDmQ==
Date: Sun, 29 Dec 2024 22:08:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Tom
 Zanussi <zanussi@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 3/3] selftests/tracing: Add hist poll() support test
Message-Id: <20241229220855.08a969021f529927c905fe57@kernel.org>
In-Reply-To: <173527249794.464571.10924229554900263368.stgit@devnote2>
References: <173527246726.464571.11533527581374142406.stgit@devnote2>
	<173527249794.464571.10924229554900263368.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 13:08:18 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a testcase for poll() on hist file. This introduces a helper binary
> to the ftracetest, because there is no good way to reliably execute
> poll() on hist file.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Changes in v7:
>   - Add comm histogram filter for specifying test sleep command.

I found I forgot to refresh the patch. (just not committed)

Sorry.

> ---
>  tools/testing/selftests/ftrace/Makefile            |    2 +
>  tools/testing/selftests/ftrace/poll.c              |   74 ++++++++++++++++++++
>  .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/poll.c
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index a1e955d2de4c..49d96bb16355 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -6,4 +6,6 @@ TEST_PROGS := ftracetest-ktap
>  TEST_FILES := test.d settings
>  EXTRA_CLEAN := $(OUTPUT)/logs/*
>  
> +TEST_GEN_PROGS = poll
> +
>  include ../lib.mk
> diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
> new file mode 100644
> index 000000000000..53258f7515e7
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/poll.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple poll on a file.
> + *
> + * Copyright (c) 2024 Google LLC.
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#define BUFSIZE 4096
> +
> +/*
> + * Usage:
> + *  poll [-I|-P] [-t timeout] FILE
> + */
> +int main(int argc, char *argv[])
> +{
> +	struct pollfd pfd = {.events = POLLIN};
> +	char buf[BUFSIZE];
> +	int timeout = -1;
> +	int ret, opt;
> +
> +	while ((opt = getopt(argc, argv, "IPt:")) != -1) {
> +		switch (opt) {
> +		case 'I':
> +			pfd.events = POLLIN;
> +			break;
> +		case 'P':
> +			pfd.events = POLLPRI;
> +			break;
> +		case 't':
> +			timeout = atoi(optarg);
> +			break;
> +		default:
> +			fprintf(stderr, "Usage: %s [-I|-P] [-t timeout] FILE\n",
> +				argv[0]);
> +			return -1;
> +		}
> +	}
> +	if (optind >= argc) {
> +		fprintf(stderr, "Error: Polling file is not specified\n");
> +		return -1;
> +	}
> +
> +	pfd.fd = open(argv[optind], O_RDONLY);
> +	if (pfd.fd < 0) {
> +		fprintf(stderr, "failed to open %s", argv[optind]);
> +		perror("open");
> +		return -1;
> +	}
> +
> +	/* Reset poll by read if POLLIN is specified. */
> +	if (pfd.events & POLLIN)
> +		do {} while (read(pfd.fd, buf, BUFSIZE) == BUFSIZE);
> +
> +	ret = poll(&pfd, 1, timeout);
> +	if (ret < 0 && errno != EINTR) {
> +		perror("poll");
> +		return -1;
> +	}
> +	close(pfd.fd);
> +
> +	/* If timeout happned (ret == 0), exit code is 1 */
> +	if (ret == 0)
> +		return 1;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> new file mode 100644
> index 000000000000..cbd01a71ecad
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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

