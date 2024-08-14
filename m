Return-Path: <linux-kselftest+bounces-15313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059A951A09
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258D71C213B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351361AED4C;
	Wed, 14 Aug 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6A8IUj7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CF13D52A
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635513; cv=none; b=ePkkRKwtYF3haqeyA3BKp9WJiZBW1kCvjLFWJsnLW4OJVElL/Z01QgeWSXg8UCGu1S86Tj+Avy9zLxAVZVLJ3jEWvaZEOaWuyZ8ns98/14RipfCHJwNUYRADOOAOfEepu/ofG1atFmVET/PfEB3X8IuQVmtciTu6xmh6ls0cadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635513; c=relaxed/simple;
	bh=JSPcamH+sNGiM5g1Yg2W18/X/3so4oRE7sqdh0jPD7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/hnxo361xcQKvgY650rtTPS+gzy6m3lHv2eincaxXolVuAH9s5DO9twAV6sy/Az6GBecgmG7SWGZ6JU7EF5N+T5uyhGe7/DUSrGrq141eBLRM8Py4/rBIqs+NyJ49uSuoM7wJJgsX6Z0wkSsKVSBC7iMd8AScdYnobRW2x+SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6A8IUj7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cdae2bc04dso101701a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723635510; x=1724240310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asggk/QXp9CMUZLmCX38cnR4hEwxRfJpnzjB+4PaQdM=;
        b=Y6A8IUj7nRR7RurErhYLV8NGefPwKd2K+fKfSKDierPtKYVJ2kstiV1wcxByQS/jSq
         tvW+mAyp8x0J7Hap0od/SkZwv6p9rqP+5wwSVvv0GIuGTNUAL5/EtQz0APlC81FEv2/X
         faK676Q0wXjzD19c6z8EB55LB+T28cwHxvWHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635510; x=1724240310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asggk/QXp9CMUZLmCX38cnR4hEwxRfJpnzjB+4PaQdM=;
        b=Hv8Yl6XpCaEdKDbFBwTNO/5i6lcMpLOluxrv1XfKUUD5HJJM2Oouj27vuJIY0j4kFM
         CWhCKNOzmf2w/MKpygtnhkN2vDOy5Ub8pbkUwKVOS2nUh6WC+VXkz9uy67671r7mrWgw
         VU+z33zZGYJUsH9Pd9qr/pzRRMPRusyFjsyBOzd+MKKoea7A2+ZiqLkvIR0Yhuc0+c8H
         gAd1HDRta/pYQO7za7BDj5SfoBqH//NthXGVMSBExY7Bcy7k4Y7sCxleaDqJqw2shPEH
         HYEAKV56Ng0/KuHXoblspfqQu/KjnaDnDzvROKuw6MQYY1QUjjIQ0iwFHsMYuHnJlNDp
         hdlg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Oi3oQdqQmalg28WM47nb7BJ9y2SNpzI8JRGDDJCWTMJX9X3YqkgHFmtQ7JQME97leugsMItoMwJc/xytWwh+RFj5hJHs/PiRiFQ4rXsK
X-Gm-Message-State: AOJu0YynZOWkOZWEkAaKC1OIN5jP+SakkW5oHGxdFRs1HowTmOwuqiH9
	Zo2goJeXs2p716BJ6lSWxl0CZwXna/5jx6cNmeqRaAmEu2UV7A1WdaMmejTejpT1JO9gyLIQXQ2
	b
X-Google-Smtp-Source: AGHT+IE4/SfOX9SrqC8Lo28qMZlrqPPd9smyceqkhnEHoaDeCM97VxNhJioQDkrnbMi/8elozNCKOQ==
X-Received: by 2002:a17:90a:1f42:b0:2c8:4bca:f904 with SMTP id 98e67ed59e1d1-2d3aa879f6cmr1674581a91.0.1723635509945;
        Wed, 14 Aug 2024 04:38:29 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7dd3f0sm1464865a91.18.2024.08.14.04.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:38:29 -0700 (PDT)
Message-ID: <2c13840e-2717-4f88-b613-f6a770be2d75@linuxfoundation.org>
Date: Wed, 14 Aug 2024 05:38:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/tracing: Add hist poll() support test
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <172359427367.323666.6446548762874507863.stgit@devnote2>
 <172359430351.323666.9768554440535494357.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <172359430351.323666.9768554440535494357.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 18:11, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a testcase for poll() on hist file. This introduces a helper binary
> to the ftracetest, because there is no good way to reliably execute
> poll() on hist file.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v2:
>    - Update poll command to support both of POLLIN and POLLPRI, and timeout.
>    - Identify unsupported stable kernel if poll-in returns soon.
>    - Test both of POLLIN and POLLPRI.
> ---
>   tools/testing/selftests/ftrace/Makefile            |    2 +
>   tools/testing/selftests/ftrace/poll.c              |   62 +++++++++++++++++
>   .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
>   3 files changed, 138 insertions(+)
>   create mode 100644 tools/testing/selftests/ftrace/poll.c
>   create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index a1e955d2de4c..49d96bb16355 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -6,4 +6,6 @@ TEST_PROGS := ftracetest-ktap
>   TEST_FILES := test.d settings
>   EXTRA_CLEAN := $(OUTPUT)/logs/*
>   
> +TEST_GEN_PROGS = poll
> +
>   include ../lib.mk
> diff --git a/tools/testing/selftests/ftrace/poll.c b/tools/testing/selftests/ftrace/poll.c
> new file mode 100644
> index 000000000000..8003a59fe042
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/poll.c
> @@ -0,0 +1,62 @@
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
> + *  poll <in|pri> <FILE> [timeout]
> + */
> +int main(int argc, char *argv[])
> +{
> +	struct pollfd pfd;
> +	char buf[BUFSIZE];
> +	int timeout = -1;
> +	int ret;
> +
> +	if (argc < 3)
> +		return -1;
> +
> +	if (!strcmp(argv[1], "in"))
> +		pfd.events = POLLIN;
> +	else if (!strcmp(argv[1], "pri"))
> +		pfd.events = POLLPRI;
> +
> +	pfd.fd = open(argv[2], O_RDONLY);
> +	if (pfd.fd < 0) {
> +		perror("open");
> +		return -1;
> +	}
> +
> +	if (argc == 4)
> +		timeout = atoi(argv[3]);

This code can be simpler and more maintainable using getopt.
Any reason why you didn't use it?

> +
> +	/* Reset poll by read if POLLIN is specified. */
> +	if (pfd.events & POLLIN)
> +		do {} while (read(pfd.fd, buf, BUFSIZE) == BUFSIZE);
> +
> +	ret = poll(&pfd, 1, timeout);
> +	if (ret < 0 && errno != EINTR) {
> +		perror("poll")> +		return -1;
> +	}
> +	close(pfd.fd);
> +
> +	/* If timeout happned, return code is 0 */

Spelling - happened

> +	if (ret == 0)
> +		return 1;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
> new file mode 100644
> index 000000000000..53bea74e2234
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
> +${POLL} in ${EVENT}/hist 1000
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
> +${POLL} in ${EVENT}/hist 4000
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
> +${POLL} pri ${EVENT}/hist 4000
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

thanks,
-- Shuah

