Return-Path: <linux-kselftest+bounces-15507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB249954BDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A21C212F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBE1BCA1F;
	Fri, 16 Aug 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LgJJazgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF271A7056
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817086; cv=none; b=f0VtNDtbxoZBtIXnzAVOB/yNIDNeDn1wYBHEiSb59FtnKcJVQNlSa5mZl1ijKgTu5X0vqTBx10hf7mrGki60ynAqvfFs9Uecuj8HJiMY+mMDrTJ7E/fPzt0B3e3DPD4ioeyD7FPJ8fo3BETkefd9+GMDS+tC3mi9cCWDwpYM8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817086; c=relaxed/simple;
	bh=DKdtCQNn1Ae1ClNw9sfwALxFvuUJ0xe9hgH7+K7WQNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy/gMR6Xmfa0q5K12lRRAslHBWpKiGEZsjh/6keGjbBzvkk2PCp/var4UBhalZu6ltuAhEbuHD5LYhHTBcJZTQgrN4Z0iuIqLR++sU230NJ27tGehKHMzJHhz1i2+kj9Nc3zsHRPCuMXbrDpIeqkKmLQdHhqC1gFv4FQlpuzTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LgJJazgh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201f1fe3909so849765ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723817083; x=1724421883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJx6+ABJszFBmRQz7LIBes/dgvF9i5l9+CDarpSPbAA=;
        b=LgJJazghTbBqbF3Mgv8hTOL2D+w+tefrDzZkIfq5b1Tdy2Bxh4sDz1fJPMi4EN946u
         UAgtk9dHXL6yfgmRiJXW4Ir042h8cWFrJA0DCWbb30Ac7DDvtqRuvvGknFADCTyDk/zQ
         SFMHpZRUV72LD5YneAvIRr6mCgGyWNHWGX7s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817083; x=1724421883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJx6+ABJszFBmRQz7LIBes/dgvF9i5l9+CDarpSPbAA=;
        b=eeqcoalnhdGOKJZT9AAE0rA7JQ34EPfIWFaO+pZPZZNF/YcAHlxclOn9cuS7dlMa3+
         q8aZa0+TrawDQqLGxJRDSR9jWH/tR9RhYIEJs5P+OK3DS4XPR2lHz7ioAzGvyksd0uon
         oK2rS9E2AnzMVUUxxPqBPRje4DfEz6b95UTnTlA6kbj6L1rH1u8DjfMFbXv3+gwbjQud
         Z2v8jz5oOMVf7JTvM9fjvWlfvYckoqTc9hJztI2LTqaefVhZPoghjksfboYSnUWFfnL0
         a2ADrsotCa5zx6mWpOBG/qhr2+MdNv3+NLbt++/fcQWhRaNEJ1EM6VANyssfOAWlyVTL
         zTKg==
X-Forwarded-Encrypted: i=1; AJvYcCWTH3LGpQAJVP+Ht8ZcUCqnwIXRiVf8XQSUhHmZSqmeQRwyby6K+Yyglm6pjSQUtl8bxEZbnF8Z4eQ76SByH8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/oKic/IKAMr0Rtx0YSvkwI4bx4nSMGpf53G8jCtFfUOa0uJ4
	JVuKCMFK02/wsaZYJjSilwYJgMp/AibCAdHRdjG7i6MHoA2kCoybb4ODRKZfZXg=
X-Google-Smtp-Source: AGHT+IHRjCaeXF3zQ9rBloJkIn9HWEdDyDwMW64ZBBRl6S4m9hTKrEeF/N+BLY3ZO8uBXzbJ9eEvxg==
X-Received: by 2002:a17:903:52:b0:202:c94:1462 with SMTP id d9443c01a7336-2020c941a8amr10299505ad.5.1723817082576;
        Fri, 16 Aug 2024 07:04:42 -0700 (PDT)
Received: from [192.168.23.95] ([126.249.175.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636b07fsm3035053a12.86.2024.08.16.07.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 07:04:41 -0700 (PDT)
Message-ID: <fdd141e8-337b-4f6c-a721-7d20dc63b50d@linuxfoundation.org>
Date: Fri, 16 Aug 2024 08:04:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] selftests/tracing: Add hist poll() support test
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <172377544331.67914.7474878424159759789.stgit@devnote2>
 <172377547205.67914.494998437883733530.stgit@devnote2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <172377547205.67914.494998437883733530.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 20:31, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a testcase for poll() on hist file. This introduces a helper binary
> to the ftracetest, because there is no good way to reliably execute
> poll() on hist file.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v4:
>    - Use getopt() in poll.c (command options are changed)
>    - Update test code according to the new command options.
>   Changes in v2:
>    - Update poll command to support both of POLLIN and POLLPRI, and timeout.
>    - Identify unsupported stable kernel if poll-in returns soon.
>    - Test both of POLLIN and POLLPRI.
> ---
>   tools/testing/selftests/ftrace/Makefile            |    2 +
>   tools/testing/selftests/ftrace/poll.c              |   74 ++++++++++++++++++++
>   .../ftrace/test.d/trigger/trigger-hist-poll.tc     |   74 ++++++++++++++++++++
>   3 files changed, 150 insertions(+)
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
> index 000000000000..584f159654b1
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
> +	/* If timeout happned, return code is 0 */

Looks like you missed this one :) Otherwise looks good to me.

With this fixed

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

