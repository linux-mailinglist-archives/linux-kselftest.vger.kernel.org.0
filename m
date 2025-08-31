Return-Path: <linux-kselftest+bounces-40383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7372B3D55D
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 23:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A44A18930A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415123C8A1;
	Sun, 31 Aug 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enjpyLlz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCE170A37;
	Sun, 31 Aug 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676501; cv=none; b=CQMG5kcoZEdEHkA39sgZkTYIYsCwzZOFhfnL4Ea5rSE0/Glzlju8Jv/QzmvB7m7f/08TB0/8ndCuQJS8+Qedp+CbVw9YqMJ2JHERx8NTvzMJZkFMWtXIrpGhRnIuvNGMp/HpP0J/e/Pz7F030EMRVeIWGAITImZUfPO2RYd+j5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676501; c=relaxed/simple;
	bh=aIWEURuWD9KzQFq1pFmO/ANHXpiwVfgMEBRySHPuCN4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EW+TJHsi0eaCW1jEyj8ZWhK2XXwMCFdE1DRxjydBNvxoVj3932N6N9ilVljGAxhjZxogN0Te4k9syvBh7H+GM2dX3RAovmT4DG5w0ZZi2OlnKM6gLRHnx58XWUvkoQdDcyvOH3sayTZ0+1HtRzJqVqzzHfov9yQ8b5RRoqRsE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enjpyLlz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c4af9eso32727321cf.3;
        Sun, 31 Aug 2025 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756676498; x=1757281298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSBRLuCgfz1Xs3OhYzPqvpwqxm+42O+Hwfj6BjpCrlY=;
        b=enjpyLlz5yaBWrqdNA6R1XJZtTvEpANugemO+4NCAwuW/IxeFbNKlQe0QlgmWsyzOD
         2ppT3RKe5wmi0N0RpiAtKmXQypXm9K6gpAZ8hiw6Tmk0diWt1/f15C+0ip4nLo6iktCU
         I/DAYPL/Uym5TgM/uYu1512mxFZAkkuMyjUq5huyZWAQYRbpyMdphkBPSDSiYafhtXOQ
         KUnl8xCQa2sMHZ1fFLaEmnFR1MZmjRBzao6PcS/UyN4lYupw7tkPaeG3J3eKASS3nJkF
         sfosMqU09wCBxU+Ai9Itl5BnwbxqqzjuYNgmaT9+qlyY1KxJeJ3Is43o4u85yMz3A37w
         qCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756676498; x=1757281298;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSBRLuCgfz1Xs3OhYzPqvpwqxm+42O+Hwfj6BjpCrlY=;
        b=id8yN/zXvS9quM4ArDtIOOkVOddSv3hO32vdyL3Zu7Rt7BB4lVQ62IRdnt8nPUeCxw
         Lr11CdNOlNRAURuPbmEUyxPFEBgkIvrxSNdDLQsvQLNiy6tVjHiGuUeX04BKkfAmp2Sb
         9QWpPPAEYV7J9KAAKywBAdvfJMKJlnz/3/zREcvLo0gTEGlODhmif37vVN45RjGiLCgR
         9MU5pd/bXyYKZ3lGSwFwNZG/POIQvCuuGhlkQshWfX37Xey0FE2W5RpzxLOS9A7AE1sB
         mMHQQo15DprR5CAAEc7PvkMJ6doFRQ9zL6WCCkfZQTr+4brOKu5r5g0g7bysh1c6pQhX
         nqJg==
X-Forwarded-Encrypted: i=1; AJvYcCURIZbh11XbccSnzxu3OWBSmbu4QMMCfQxsI4lMAOtnPWpJr8iRiKND+/hzwgRlKNhj4VRe/gpJ@vger.kernel.org, AJvYcCUs566nWrnEcnN/S1rEUDTmgYIqpd2VWkQ5ahVmQizGE7bPH1A6zXJxATob4qlLbKmJTCBJ6wFcd//V1CZs4h4g@vger.kernel.org, AJvYcCX+Nc9HBobCs4U6qJ2fWUu/IOouLAtpPIPnrgeyjjhyCkRaigwZW9KZdX7S/J3yu4+BZw8DGt5494fb+kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiChLfs5F1T+khyo0iK0a5gm7HJeFaGHznwB8OyO1pn3lJpdX
	rPw3G19GT6kehhVxcVnXpGxHG7wozKOtBHAVJ7vBH/evkWpbUXXVP8Ea
X-Gm-Gg: ASbGncv+/iQeelzi602UB+jh5Sccu+EHSg5G0TIh4lJ7UzmeiSGGqBxf+rXJkYiskQ8
	4HxNDE070LR42we3MtgWHWsaXkjrFVJrGAEB8opWsIa9+Otx7SQIKpER/jwGBBwGYwMO1M/iezv
	Y14DSA8qpwOkqxY7QarGCW+VMo5nXN+wMpaBoFfTAL2WzpJxAtkG0f/Vs5qdS5p+q4LMk526UZ+
	qlL+LEYT/Im67gAbaEES/amIRzF42XWBX1UWZTfXRPn1tzltDCMFntd5Olv8yVGxQRn8CHMZI8A
	0OVyDOrK5XSX7cmIGPaFdhlgKpBMQlQ65oDRVfZaH5E5CXc0pFSKfTqtbvGo6BL1ZUy8pNIrlLa
	vJTLcUYfbZwfPzOvELaQIueu30NQXwzsS/kRekIYYn5wsptCPcf733zWUtFO3zF6ukv1kdLoHOM
	0msQ==
X-Google-Smtp-Source: AGHT+IEm2OL+B0aTU6ThRDwwPJvPG9piqrVvg0LsycBcV1nQMtlmCuuNnuTLEiv7+YroqZEaBn7GLA==
X-Received: by 2002:a05:622a:1a98:b0:4b1:dd3:e39d with SMTP id d75a77b69052e-4b31da6df87mr72365821cf.64.1756676498315;
        Sun, 31 Aug 2025 14:41:38 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b30edd2079sm47603681cf.44.2025.08.31.14.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 14:41:37 -0700 (PDT)
Date: Sun, 31 Aug 2025 17:41:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Brett A C Sheffield <bacs@librecast.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>, 
 Greg KH <gregkh@linuxfoundation.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2eb928603b04@gmail.com>
In-Reply-To: <20250825092548.4436-3-bacs@librecast.net>
References: <20250825092548.4436-3-bacs@librecast.net>
Subject: Re: [PATCH net-next] selftests: net: add test for ipv6 fragmentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Brett A C Sheffield wrote:
> Add selftest for the IPv6 fragmentation regression which affected
> several stable kernels.
> 
> Commit a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to
> stable without some prerequisite commits.  This caused a regression when
> sending IPv6 UDP packets by preventing fragmentation and instead
> returning -1 (EMSGSIZE).
> 
> Add selftest to check for this issue by attempting to send a packet
> larger than the interface MTU. The packet will be fragmented on a
> working kernel, with sendmsg(2) correctly returning the expected number
> of bytes sent.  When the regression is present, sendmsg returns -1 and
> sets errno to EMSGSIZE.
> 
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> ---
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/ipv6_fragmentation.c        | 204 ++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 tools/testing/selftests/net/ipv6_fragmentation.c
> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 47c293c2962f..3d4b4a53dfda 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -16,6 +16,7 @@ ip_local_port_range
>  ipsec
>  ipv6_flowlabel
>  ipv6_flowlabel_mgr
> +ipv6_fragmentation
>  log.txt
>  msg_oob
>  msg_zerocopy
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index b31a71f2b372..f83f91b758ae 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
>  TEST_PROGS += tfo_passive.sh
>  TEST_PROGS += broadcast_pmtu.sh
>  TEST_PROGS += ipv6_force_forwarding.sh
> +TEST_GEN_PROGS += ipv6_fragmentation
>  
>  # YNL files, must be before "include ..lib.mk"
>  YNL_GEN_FILES := busy_poller netlink-dumps
> diff --git a/tools/testing/selftests/net/ipv6_fragmentation.c b/tools/testing/selftests/net/ipv6_fragmentation.c
> new file mode 100644
> index 000000000000..21e1a3cdc63d
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_fragmentation.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Brett A C Sheffield <bacs@librecast.net>
> + *
> + * Kernel selftest for the IPv6 fragmentation regression which affected
> + * stable kernels:
> + *
> + *   https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> + *
> + * Commit:
> + *   a18dfa9925b9 ("ipv6: save dontfrag in cork")
> + * was backported to stable without some prerequisite commits.
> + *
> + * This caused a regression when sending IPv6 UDP packets by preventing
> + * fragmentation and instead returning -1 (EMSGSIZE).
> + *
> + * This selftest demonstrates the issue. sendmsg returns correctly (8192)
> + * on a working kernel, and returns -1 (EMSGSIZE) when the regression is
> + * present.
> + *
> + * The regression was not present in the mainline kernel, but add this test to
> + * catch similar breakage in future.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <fcntl.h>
> +#include <linux/if_tun.h>
> +#include <net/if.h>
> +#include <netinet/in.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +
> +#define MTU 1500
> +#define LARGER_THAN_MTU 8192
> +
> +/* ensure MTU is smaller than what we plan to send */
> +static int set_mtu(int ctl, char *ifname, struct ifreq *ifr)
> +{
> +	ifr->ifr_mtu = MTU;
> +	return ioctl(ctl, SIOCSIFMTU, ifr);
> +}
> +
> +/* bring up interface */
> +static int interface_up(int ctl, char *ifname, struct ifreq *ifr)
> +{
> +	if (ioctl(ctl, SIOCGIFFLAGS, ifr) == -1) {
> +		perror("ioctl SIOCGIFFLAGS");
> +		return -1;
> +	}
> +	ifr->ifr_flags = ifr->ifr_flags | IFF_UP;
> +	return ioctl(ctl, SIOCSIFFLAGS, ifr);
> +}
> +
> +/* no need to wait for DAD in our namespace */
> +static int disable_dad(char *ifname)
> +{
> +	char sysvar[] = "/proc/sys/net/ipv6/conf/%s/accept_dad";
> +	char fname[IFNAMSIZ + sizeof(sysvar)];
> +	int fd;
> +
> +	snprintf(fname, sizeof(fname), sysvar, ifname);
> +	fd = open(fname, O_WRONLY);
> +	if (fd == -1) {
> +		perror("open accept_dad");
> +		return -1;
> +	}
> +	if (write(fd, "0", 1) != 1) {
> +		perror("write");
> +		return -1;
> +	}
> +	return close(fd);
> +}
> +
> +/* create TAP interface that will be deleted when this process exits */
> +static int create_interface(int ctl, char *ifname, struct ifreq *ifr)
> +{
> +	int fd;
> +
> +	fd = open("/dev/net/tun", O_RDWR);
> +	if (fd == -1) {
> +		perror("open tun");
> +		return -1;
> +	}
> +
> +	ifr->ifr_flags = IFF_TAP | IFF_NO_PI;
> +	if (ioctl(fd, TUNSETIFF, (void *)ifr) == -1) {
> +		close(fd);
> +		perror("ioctl: TUNSETIFF");
> +		return -1;
> +	}
> +	strcpy(ifname, ifr->ifr_name);
> +
> +	return fd;
> +}
> +
> +/* we need to set MTU, so do this in a namespace to play nicely */
> +static int create_namespace(void)
> +{
> +	const char *netns_path = "/proc/self/ns/net";
> +	int fd;
> +
> +	if (unshare(CLONE_NEWNET) != 0) {
> +		perror("unshare");
> +		return -1;
> +	}
> +
> +	fd = open(netns_path, O_RDONLY);
> +	if (fd == -1) {
> +		perror("open");
> +		return -1;
> +	}
> +
> +	if (setns(fd, CLONE_NEWNET)) {
> +		perror("setns");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int setup(void)
> +{
> +	struct ifreq ifr = {0};
> +	char ifname[IFNAMSIZ];
> +	int fd = -1;
> +	int ctl;
> +
> +	if (create_namespace() == -1)
> +		return -1;
> +
> +	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
> +	if (ctl == -1)
> +		return -1;
> +
> +	memset(ifname, 0, sizeof(ifname));
> +	fd = create_interface(ctl, ifname, &ifr);
> +	if (fd == -1)
> +		goto err_close_ctl;
> +	if (disable_dad(ifname) == -1)
> +		goto err_close_fd;
> +	if (interface_up(ctl, ifname, &ifr) == -1)
> +		goto err_close_fd;
> +	if (set_mtu(ctl, ifname, &ifr) == -1)
> +		goto err_close_fd;
> +	usleep(10000); /* give interface a moment to wake up */
> +	goto err_close_ctl;

We generally discourage these alternating gotos.

Since this is a test, it may be okay. Since it's a test, it is also
fine to just call error() on failures and fail hard immediately. Since
this is namespaced and thus the OS will cleanup all state correctly.

> +err_close_fd:
> +	close(fd);
> +	fd = -1;
> +err_close_ctl:
> +	close(ctl);
> +	return fd;
> +}
> +
> +int main(void)
> +{
> +	/* address doesn't matter, use an IPv6 multicast address for simplicity */
> +	struct in6_addr addr = {
> +		.s6_addr[0] = 0xff, /* multicast */
> +		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
> +	};

Does this really need tap and a multicast address? I think a send over
loopback will work too (and is more contained) after lowering its MTU.

I ran a quick test

    ip netns add test
    ip netns exec test bash

    ip link set lo mtu 1500
    ip link set lo up
    nc -u -l -p 8000 & 
    tcpdump -n -vvv -i lo &
    dd if=/dev/zero of=/home/tmp/payload bs=1 count=2000
    cat /home/tmp/payload | nc -u 127.0.0.1 8000

As a regression test this would require parsing tcpdump or something
similar (e.g., count frags). So a .c test that can test the return
from sendmsg is fine, even if a bit more verbose.

> +	struct sockaddr_in6 sa = {
> +		.sin6_family = AF_INET6,
> +		.sin6_addr = addr,
> +		.sin6_port = 4242
> +	};
> +	char buf[LARGER_THAN_MTU] = {0};
> +	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf)};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_name = (struct sockaddr *)&sa,
> +		.msg_namelen = sizeof(sa),
> +	};
> +	ssize_t rc;
> +	int ns_fd;
> +	int s;
> +
> +	printf("Testing IPv6 fragmentation\n");
> +	ns_fd = setup();
> +	if (ns_fd == -1)
> +		return 1;
> +	s = socket(AF_INET6, SOCK_DGRAM, 0);
> +	msg.msg_name = (struct sockaddr *)&sa;
> +	msg.msg_namelen = sizeof(sa);
> +	rc = sendmsg(s, &msg, 0);
> +	if (rc == -1) {
> +		perror("send");
> +		return 1;
> +	} else if (rc != LARGER_THAN_MTU) {
> +		fprintf(stderr, "send() returned %zi\n", rc);
> +		return 1;
> +	}
> +	close(s);
> +	close(ns_fd);
> +
> +	return 0;
> +}
> -- 
> 2.49.1
> 



