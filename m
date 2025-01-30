Return-Path: <linux-kselftest+bounces-25427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE183A230E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 16:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C94D188905B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045401E9B1C;
	Thu, 30 Jan 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGme9gIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301F1AA78E;
	Thu, 30 Jan 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250151; cv=none; b=Z7EM16sFRsu9BjHN9yRQymSRM8P7haz1bBu9I3MdLiA0X+TD9Y/dAcPeiPSJ+zTXejcFjLLO54bPE7/uGYIDr3gw0FkChsOLKlfkkUxTB75SPZsuV6sdUqVZedHihEWke0ldDQ+d/mkizDF87mJxW9YQBZ51TZ7h0UxOoitEqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250151; c=relaxed/simple;
	bh=+9mnqBrvd5SjuJajBafVNf2yQkwHvsne7SRWTmMI+hw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UK3zfBGsN/YKReGr0yrWHv69sPEAJMnzYGRlP95sgs+e6X8oHFYP7wWVRJzoLfDJ8q+BtvHlRADlle/6P/yQmPYJYlT+54ekRtG0VZbrlRp2QzvgQO1dgK9TUdVlLXEsJ99mwMHcP5cX3jpAP4SkXYTMKBjgj7NNoVGPY8r7dAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGme9gIv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b9bc648736so98868985a.1;
        Thu, 30 Jan 2025 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738250149; x=1738854949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m7wJzESF4WTMqUDkNEvtQp5Udo1Cl2C5LfjBRC6rV8=;
        b=UGme9gIvYDy49IU5HzoOkFZbMoZgyb2OWXSIQqRsSgowA9XeIgEwIyYwv9lQZmvC22
         evpRpV7pn0oypAXIDfcb4xARAEBjMyxe+ZOtyEasY8Xd6rScHr7NPAjunOXcjVenkgFM
         vDPfMu+Q4zm7a0SMU2MIH4REoINEFaojcwBAA+4n21iOG9cIef7uJVLfSMcLiDxysbDy
         R0OTm+VszY6toiC6Io/S07dExigNyrsY2FNjWjWAUb2ckEYF2qaUXIsmm+nMH3l2aEEC
         OkdgwCLJWKrwNc5gkof7dTZataRlDF5KsWIk39p6w0UUynwVmBmsciIo4LVz2DUCzhiS
         IR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738250149; x=1738854949;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5m7wJzESF4WTMqUDkNEvtQp5Udo1Cl2C5LfjBRC6rV8=;
        b=NI2obTF9It7evv5vLBjoB9/P55ixR+A8aWGkDqx2DfkRz6xJ1ZNbSthti73Dmdzmdm
         1PKroFMKOFKITZ7M9vzIOmi4zcG4xXDIfmK5aMsizSkUFCYSDZGDuRFtmzaGrEGRbNcg
         yO1APDp6ZEJSH4E9tUyRTz668gZ+EV3DXdtxOd7e3dD3brC/RheuuEqzOK2Alg++TYvA
         wnDYevWJnkqBw4lCNRUyITWWnCrweNWOwHDra2ce4EgkcuWss6CyESDvhc6big6lK8N7
         dHdIIyXB4EBXsiOwqs34jTAgQ8rYNiDwutS/25MkYayrbl7hRjC5fWg1BJ6bit4+IWf4
         7dqA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xFNb9ICtWMXD87IihjEIvyVNWlj6TNJwPtITNSPcMDR6GkYWXTUiQN/Lf3RWAfbwk0Cq+P9k2ctiFu3h90I=@vger.kernel.org, AJvYcCVlvSEfmTzUm17IK4muv/fZyF9Jysyjy1GU1cdSb1Rh2Stai7KGTmPcKyalbxjdBoXBgirOHzFg@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJMxSocbaDuYfbAgwfIW8JGJvx5iE8DmJDlBdnu9qe43FEMEz
	udwr7chq3n2A6xz9v5k4pUlIw8IyKSaxGhemk+8Hwn0+gbi3+sIh
X-Gm-Gg: ASbGncsCb4JzY1QWvXjz3KsX9Dg/XQhBRnfRFjv+10SX/m1bcFEKL9a9S02nKny3TiF
	hPXTg3s0ClaBTnOzwze9PYfa2C1RBBfw6qzotiWPdNbkLOmAxqWIsFKeJBY3zdMG8jYA8EoS6Tn
	wxoJKrxrIdn43R21eIixb77SMjTpRRixzFSNhzZzRPyTcBTNQze6Q5X9Enga1KVJdNwcPdshBcr
	LDe8Pg1cYUFqYurYzlTgXimltUXAlBakZ5Wixrf+oSqfGJ1Wg4JCBUyZIrJeZk8OwtTCDIXMSt5
	LPWYdtn1vPDFRJHWJhohl9PAtdqMs4F30V/E0+dpMJo0QUrwAND65iJrdFnE9NA=
X-Google-Smtp-Source: AGHT+IFlaGqc/5Wc1nD3alBZCIgo92aRGcOJ4Y7WWAc1xi9ter4yrYqpffOUNfOdhZn5nnHJCbtkNg==
X-Received: by 2002:a05:620a:439c:b0:7b6:c93a:7f2f with SMTP id af79cd13be357-7bffcce4a1amr1055568785a.14.1738250148864;
        Thu, 30 Jan 2025 07:15:48 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941da05dsm271165241.21.2025.01.30.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 07:15:48 -0800 (PST)
Date: Thu, 30 Jan 2025 10:15:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 davem@davemloft.net, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <679b97a391c2c_1c776329467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250129143601.16035-2-annaemesenyiri@gmail.com>
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
 <20250129143601.16035-2-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and 
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct 
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

No need for a cover letter to a single patch.

net-next is closed.

> 
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/so_rcv_listener.c | 147 ++++++++++++++++++
>  tools/testing/selftests/net/test_so_rcv.sh    |  56 +++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
>  create mode 100755 tools/testing/selftests/net/test_so_rcv.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 73ee88d6b043..98f05473e672 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -33,6 +33,7 @@ TEST_PROGS += gro.sh
>  TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_so_priority.sh
> +TEST_PROGS += test_so_rcv.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
>  TEST_PROGS += nl_netdev.py
> diff --git a/tools/testing/selftests/net/so_rcv_listener.c b/tools/testing/selftests/net/so_rcv_listener.c
> new file mode 100644
> index 000000000000..53b09582a7e3
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_rcv_listener.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>
> +#include <netdb.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/types.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +
> +#ifndef SO_RCVPRIORITY
> +#define SO_RCVPRIORITY 82
> +#endif
> +
> +struct options {
> +	__u32 val;
> +	int name;
> +	int rcvname;
> +	const char *host;
> +	const char *service;
> +} opt;
> +
> +static void __attribute__((noreturn)) usage(const char *bin)
> +{
> +	printf("Usage: %s [opts] <dst host> <dst port / service>\n", bin);
> +	printf("Options:\n"
> +		"\t\t-M val  Test SO_RCVMARK\n"
> +		"\t\t-P val  Test SO_RCVPRIORITY\n"
> +		"");
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void parse_args(int argc, char *argv[])
> +{
> +	int o;
> +
> +	while ((o = getopt(argc, argv, "M:P:")) != -1) {
> +		switch (o) {
> +		case 'M':
> +			opt.val = atoi(optarg);
> +			opt.name = SO_MARK;
> +			opt.rcvname = SO_RCVMARK;
> +			break;
> +		case 'P':
> +			opt.val = atoi(optarg);
> +			opt.name = SO_PRIORITY;
> +			opt.rcvname = SO_RCVPRIORITY;
> +			break;
> +		default:
> +			usage(argv[0]);
> +			break;
> +		}
> +	}
> +
> +	if (optind != argc - 2)
> +		usage(argv[0]);
> +
> +	opt.host = argv[optind];
> +	opt.service = argv[optind + 1];
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int err = 0;
> +	int recv_fd = -1;
> +	int ret_value = 0;
> +	__u32 recv_val;
> +	struct cmsghdr *cmsg;
> +	char cbuf[1024];

Please use CMSG_SPACE and anticipate the minimum required space needed.

> +	char recv_buf[1024];
> +	struct iovec iov[1];
> +	struct msghdr msg;
> +	struct sockaddr_in recv_addr;

In general code should not be IPv4 only. In this case the logic in the
kernel is the same for IPv4 and IPv6, so I guess it's okay. If
explicitly testing only one of the two, I would suggest IPv6.

> +
> +	parse_args(argc, argv);
> +
> +	recv_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +	if (recv_fd < 0) {
> +		perror("Can't open recv socket");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}
> +
> +	err = setsockopt(recv_fd, SOL_SOCKET, opt.rcvname, &opt.val, sizeof(opt.val));
> +	if (err < 0) {
> +		perror("Recv setsockopt error");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}
> +
> +	memset(&recv_addr, 0, sizeof(recv_addr));
> +	recv_addr.sin_family = AF_INET;
> +	recv_addr.sin_port = htons(atoi(opt.service));
> +
> +	if (inet_pton(AF_INET, opt.host, &recv_addr.sin_addr) <= 0) {
> +		perror("Invalid address");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}
> +
> +	err = bind(recv_fd, (struct sockaddr *)&recv_addr, sizeof(recv_addr));
> +	if (err < 0) {
> +		perror("Recv bind error");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}
> +
> +	iov[0].iov_base = recv_buf;
> +	iov[0].iov_len = sizeof(recv_buf);
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.msg_iov = iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_control = cbuf;
> +	msg.msg_controllen = sizeof(cbuf);
> +
> +	err = recvmsg(recv_fd, &msg, 0);
> +	if (err < 0) {
> +		perror("Message receive error");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}
> +
> +	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +		if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == opt.name) {
> +			recv_val = *(__u32 *)CMSG_DATA(cmsg);
> +			printf("Received value: %u\n", recv_val);
> +
> +			if (recv_val != opt.val) {
> +				fprintf(stderr, "Error: expected value: %u, got: %u\n",
> +					opt.val, recv_val);
> +				ret_value = -EINVAL;
> +				goto cleanup;
> +			}
> +		}
> +	}
> +
> +cleanup:
> +	if (recv_fd >= 0)
> +		close(recv_fd);
> +
> +	return ret_value;
> +}
> diff --git a/tools/testing/selftests/net/test_so_rcv.sh b/tools/testing/selftests/net/test_so_rcv.sh
> new file mode 100755
> index 000000000000..12d37f9ab905
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_so_rcv.sh
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +HOST=127.0.0.1
> +PORT=1234
> +TOTAL_TESTS=0
> +FAILED_TESTS=0
> +
> +declare -A TESTS=(
> +	["SO_RCVPRIORITY"]="-P 2"
> +	["SO_RCVMARK"]="-M 3"
> +)
> +
> +check_result() {
> +	((TOTAL_TESTS++))
> +	if [ "$1" -ne 0 ]; then
> +		((FAILED_TESTS++))
> +	fi
> +}
> +
> +for test_name in "${!TESTS[@]}"; do
> +	echo "Running $test_name test"
> +	arg=${TESTS[$test_name]}
> +
> +	./so_rcv_listener $arg $HOST $PORT &
> +	LISTENER_PID=$!
> +
> +	if ./cmsg_sender $arg $HOST $PORT; then
> +		echo "Sender succeeded for $test_name"

nit: such verbose comments are not very informative.

> +	else
> +		echo "Sender failed for $test_name"
> +		kill "$LISTENER_PID" 2>/dev/null
> +		wait "$LISTENER_PID"
> +		check_result 1
> +		continue
> +	fi
> +
> +	wait "$LISTENER_PID"
> +	LISTENER_EXIT_CODE=$?
> +
> +	if [ "$LISTENER_EXIT_CODE" -eq 0 ]; then
> +		echo "Rcv test OK for $test_name"
> +		check_result 0
> +	else
> +		echo "Rcv test FAILED for $test_name"
> +		check_result 1
> +	fi
> +done
> +
> +if [ "$FAILED_TESTS" -ne 0 ]; then
> +	echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> +	exit 1

please use kselftest exit codes: KSFT_FAIL

> +else
> +	echo "OK - All $TOTAL_TESTS tests passed"
> +	exit 0

KSFT_PASS

> +fi
> -- 
> 2.43.0
> 



