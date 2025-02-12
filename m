Return-Path: <linux-kselftest+bounces-26441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E881A31B47
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370FA1667EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9A3BB48;
	Wed, 12 Feb 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTG18An4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F852B9BC;
	Wed, 12 Feb 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324511; cv=none; b=msDI3ErE57X1+GafHDFUFlTHVPp5OH1h73RunYmCWtTdoQ/yUMbp4H4s/lhhDHBYMucK2izfngijtb3iWWf1qWPOFHwh0YofHyyIFz110nM9Nliz4KNBtyCeD9htJ8MUealEzoBYfturQHyfcgcQda3MeV3+szs0KL+Ta5+fIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324511; c=relaxed/simple;
	bh=6fwSm6nIscc+0b/tBnS7OKDCum+Z41hu3YKt1cHfJsU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VdZVW6uW1PRgUjEPnLMuCKdHsHeSbawJFF3W1p0nbK7pPfh/1/Qqi4aAg6rUPzygDXrjSCbbiQ/D6U6jsoATHmgDeC/1yGjcm4Y/rRn8RDLBH6RRt4W6iGIzPKjEdyr5u1YZHH5HQA0lOkW6UuUiTdjROEXOYmci8cTN526Iu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTG18An4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7be6fdeee35so1076805485a.1;
        Tue, 11 Feb 2025 17:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739324509; x=1739929309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ergs1qzUg+U+LhdHOiAvaWmdDQV1t2zRFznEms7tt/Q=;
        b=BTG18An4HdCvT+QL+B7+12Y6Cym/Tm9sTDw/LApXpG3ejclE6K2aUdsOo0Awdbg2+U
         8D0AY1b+HbBObymP/9xe1ysnb8iWKD855Atf/shoE3n7m6JKB6yP89JtFt2XQ3lofvI3
         CVXxSyGG2PYAJ59c0xcoQdYAMpkjxJ5M9GMAAZs56rs5xkQmsiVBknNxTDh908P0nhlD
         cwVcD8iItKHjD+bHjBMCUEHlEbtgjXAPBdUdfpAkRPuexk0zByjdyG4VUGwgdvIBCyCI
         UkjAIoEsjelFoCMTJn736rA9IbjeOf09zCKJ5slBmfrEvzuUAHfJZhf0OgUX/mVBs+vD
         Vs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739324509; x=1739929309;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ergs1qzUg+U+LhdHOiAvaWmdDQV1t2zRFznEms7tt/Q=;
        b=bvG+XQTnP1Q1VInKc0Wy6cm+rOmca6UL2SYQstsucJuWcsHZ6hDlm4UwbdtUKbtFHt
         1GVw0KudP9E4ZSdq0V3/t1JxjzY4keOnAcetHkNuGgTgt0nmCoD6NFMmvyr5QNUCp0/Z
         NvB1oYDXoZ0UpeVXvamuUzqPmVskEfSyD0Z49Xcq3yWOtuDlVUD1zPtQywL869LLBbgC
         YbR4KQBLh+v0rG4klisWh+EQLwnPK4EHBeRRa0XpCXSiNcVgV2pbt60o667fQgWJsIvJ
         r5T1aOksh0v/WgcjboaGpCtAhOKK7s1ZnnQ0tXRJ8vFX8X1ZSiyATSd1Tm6oEkYXqFsQ
         MXVA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0g65TrGPUdH9vADOWTcgLGepPcQPWGzk0kAQOdW12YqE6TSMOM1zUkH13ITriw/+kbrUEybh@vger.kernel.org, AJvYcCXtKLEuNNBhFc8PFo9YaSj3mFLTJwydz4nJVo4VMgS2rm3bwp3ybQokZSmSm69SI2l4FwqlqXa6vEOmdAylIe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIac7pvscnjdsBeEFcTD6J+gjKTIu8FPL0Egt+wxK4BsjyNT1
	gOHo036HLyjMtga32YqybMMOsw1T7HLbrx8J7zjYzPZmgHxgp2X9
X-Gm-Gg: ASbGncv47/AnkurcGyXNAei1SUQHwl/yP3bCzkUEK2OovYFyGX2lz/kZMhSJRONgVAv
	Psv17Uzg85H28I0bNBQCxucyW14RvfggnLn0yiq8NKjOdpp8m3celjVS/ggJG3t+L5Q/NVwjd8F
	uBRz9Q3BIfO2NWgftNVc98JpwYDATpkrrks7qDY8D3WinWwAp5FnVxZ8kSqbvCTTURNzjcFIglL
	x/FhBB1Mep1JULurqbCgzpPUrHv8FG1uxpckqG2kGNIj7/56jSEMTX6JmpuU6QTQf29w8rMdr7W
	jSiOJp6OwsdIxXFEuFPxZXxiUmAdx2Oy7JiWVjAPRlSVncpq0z9RgDks6oDK+gk=
X-Google-Smtp-Source: AGHT+IGA7miUeeOCnPd9toDuuwTwEj0AODVtqEKrTjG1cZfsm8EC9WUZzin0Vb0s8ew5oXUV4ihlxA==
X-Received: by 2002:a05:620a:1b99:b0:7b6:d4df:2890 with SMTP id af79cd13be357-7c06fc4e466mr262745285a.4.1739324508698;
        Tue, 11 Feb 2025 17:41:48 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c06bf2c8eesm156287785a.102.2025.02.11.17.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 17:41:48 -0800 (PST)
Date: Tue, 11 Feb 2025 20:41:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 horms@kernel.org, 
 davem@davemloft.net, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <67abfc5bcb2df_155892294f7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250210192216.37756-1-annaemesenyiri@gmail.com>
References: <20250210192216.37756-1-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add support for testing
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
> v2:
> 
> - Add the C part to TEST_GEN_PROGS and .gitignore.
> - Modify buffer space and add IPv6 testing option
> in so_rcv_listener.c.
> - Add IPv6 testing, remove unnecessary comment,
> add kselftest exit codes, run both binaries in a namespace,
> and add sleep in test_so_rcv.sh.
> The sleep was added to ensure that the listener process has
> enough time to start before the sender attempts to connect.
> - Rebased on net-next.
> 
> v1:
> 
> https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   2 +
>  tools/testing/selftests/net/so_rcv_listener.c | 165 ++++++++++++++++++
>  tools/testing/selftests/net/test_so_rcv.sh    |  73 ++++++++
>  4 files changed, 241 insertions(+)
>  create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
>  create mode 100755 tools/testing/selftests/net/test_so_rcv.sh
> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 28a715a8ef2b..80dcae53ef55 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -42,6 +42,7 @@ socket
>  so_incoming_cpu
>  so_netns_cookie
>  so_txtime
> +so_rcv_listener
>  stress_reuseport_listen
>  tap
>  tcp_fastopen_backup_key
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 73ee88d6b043..fe3491dea7c5 100644
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
> @@ -89,6 +90,7 @@ TEST_GEN_FILES += sctp_hello
>  TEST_GEN_FILES += ip_local_port_range
>  TEST_GEN_PROGS += bind_wildcard
>  TEST_GEN_PROGS += bind_timewait
> +TEST_GEN_PROGS += so_rcv_listener
>  TEST_PROGS += test_vxlan_mdb.sh
>  TEST_PROGS += test_bridge_neigh_suppress.sh
>  TEST_PROGS += test_vxlan_nolocalbypass.sh
> diff --git a/tools/testing/selftests/net/so_rcv_listener.c b/tools/testing/selftests/net/so_rcv_listener.c
> new file mode 100644
> index 000000000000..693fc1e3d44d
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_rcv_listener.c
> @@ -0,0 +1,165 @@
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
> +	char cbuf[CMSG_SPACE(sizeof(__u32))];
> +	char recv_buf[CMSG_SPACE(sizeof(__u32))];
> +	struct iovec iov[1];
> +	struct msghdr msg;
> +	struct sockaddr_in recv_addr4;
> +	struct sockaddr_in6 recv_addr6;
> +
> +	parse_args(argc, argv);
> +
> +	int family = strchr(opt.host, ':') ? AF_INET6 : AF_INET;
> +
> +	recv_fd = socket(family, SOCK_DGRAM, IPPROTO_UDP);
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
> +	if (family == AF_INET) {
> +		memset(&recv_addr4, 0, sizeof(recv_addr4));
> +		recv_addr4.sin_family = family;
> +		recv_addr4.sin_port = htons(atoi(opt.service));
> +
> +		if (inet_pton(family, opt.host, &recv_addr4.sin_addr) <= 0) {
> +			perror("Invalid IPV4 address");
> +			ret_value = -errno;
> +			goto cleanup;
> +		}
> +
> +		err = bind(recv_fd, (struct sockaddr *)&recv_addr4, sizeof(recv_addr4));
> +	} else {
> +		memset(&recv_addr6, 0, sizeof(recv_addr6));
> +		recv_addr6.sin6_family = family;
> +		recv_addr6.sin6_port = htons(atoi(opt.service));
> +
> +		if (inet_pton(family, opt.host, &recv_addr6.sin6_addr) <= 0) {
> +			perror("Invalid IPV6 address");
> +			ret_value = -errno;
> +			goto cleanup;
> +		}
> +
> +		err = bind(recv_fd, (struct sockaddr *)&recv_addr6, sizeof(recv_addr6));
> +	}
> +
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

This test will return success if no cmsg of cmsg_type opt.name is
encountered. You probably want to fail in that case.

> +				goto cleanup;
> +			}
> +		}
> +	}
> +

