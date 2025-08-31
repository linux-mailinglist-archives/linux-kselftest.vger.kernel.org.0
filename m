Return-Path: <linux-kselftest+bounces-40384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52AB3D569
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F791899385
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49792253A1;
	Sun, 31 Aug 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzALWsh/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03D35959;
	Sun, 31 Aug 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676871; cv=none; b=HnZ4HpSBAyrv7cXb5lKrtwPe5MaCLChdeMrp8tEXDB0edloak3OE00/7WzGMTarB7stBYzGyEju65GFTLipJ7AjpNuT2UbeRxlFG75tyzqceKRcIHgYP9+NNY8sN9cM68EKDgmXnirtu1bVkZfLLqobQNEU1RLRf4pzKmhYRy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676871; c=relaxed/simple;
	bh=9raiHXnSlrnEihDjJ9YQ7ImDp+gCn0d1n638ibAel0o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TNLxMvbowv6euvnt4ER3vBkfyXOgYXhgqeLJE0uCt2X8NZdQecm1qK6i5/7ZmFbf4f8C/K9+wtO9lkq/P5AmItGf158GpS2lkDwmBWn5uH/ZwqEBItveqSfYqL53pVbr0GqbBjd+sh/Jtufmaemx2FdkSuLBFK3jOoMrCwvwR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzALWsh/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7fa334351b1so455936585a.3;
        Sun, 31 Aug 2025 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756676868; x=1757281668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+XHNsRVBV1TFw4rANxiIPLT5DUjE4Cp87ZhX3o/1ZU=;
        b=PzALWsh/nJ2xFqf3aKp/qFqIVDv1Psf+DNyzNrwySB8OSbTX2BI2EEdqf0NUAHjmJC
         rrf8j2gOlDPNntHsfgH+OXtpsGjzp1B8OVZ2O6IBmEdlTDRG/tT6kk5VOvlEG0LfZxIU
         S2kyOOlX5yGzxfxgEFuu3suR4hVf40VeQ33xRrUWUeFPd69ie3ISkN8cV7Bduv7wD4wF
         tQ+FcpECTDgKc2PLjcDH6VGFIq+xvb2B1yJETZILGJhb2/FLUQ4gcc9/zNjS3HElQpeY
         laQsV2iHqiOv1ho4zlfF+x/rmpLQM5rtcQOA5lhl6stOgmT6Msrg5NOZ32MUJhWe66nQ
         AIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756676868; x=1757281668;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+XHNsRVBV1TFw4rANxiIPLT5DUjE4Cp87ZhX3o/1ZU=;
        b=sxC52Qk/rV4styNi5Gz97+RS9fkaNtqguawf/SR9L8KBlcKCzwaoyxqJl8k6K3wo00
         sj1CVjsfl6Xv7wDk26fjVF/XTePdLkIH8GHF2tz2XlzydUj2QkG8astACiZqqTWsOKgj
         tKO0nxdTDQuutESiZtQQoyRiBF2W/D75u51QEMVNNA5VgHmlhBkFz4dJ+8BdwBUdppdc
         zyT8wSOMDCHRST6KMnJPgwFZSJDlckhZtLHUMWwNf6DrfRxNpcabd89P91MHIzGQe7aS
         Sl8CbEJb4gpQMfi0w/kbDi62e6MM0+aY1dfJkP1lEkhx71SCnDhvKae6IH4+I6bs9O/Z
         +Piw==
X-Forwarded-Encrypted: i=1; AJvYcCUy0HcvK9wRooUwfHUVyFTWbRz17wIbFJs8OU9zwYkrI1UXg2Iy0NSx2moMwCMvjBZpj23V+GUCqseWw4efyiZ1@vger.kernel.org, AJvYcCVr6D+65dsP1/5nQlcN6b19ActPTSHIF9QnkCyzNxaQ8vVOb4XOxQAxHfVcpaZRoo48lDfWU4ZcZMG1lHA=@vger.kernel.org, AJvYcCWGaPcTecBPMpjvqyUla2eccxy4V/53wrnWCsJ7z0/uPHU0gS7kpaQyXwwpDX/whRm1gZuOesjN@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZKX+ZNdkC+8hp8oDlPtZocfQQlZ+ZmL9d2UPcMPSBm1tk+8B
	mMu0+Al1VHHWFWEuyodRChu11t7hZTGoBTlvF00Si5ODNHWogb7oRtKz
X-Gm-Gg: ASbGncsx8d5wGg9vD+aLq45uUHot0bLebFESEieuZ8MHbCGxpZlZARqkEfg4P1Cf9fa
	xc9dSHAs16cmJH5DRJ0kAV//P7e7x5uYYpgnysbznD9LlJZxyL4iGivFpK5Z0qHIovYihShtqH2
	lF0UucTTandYpUpziGN+BIJ7PSUJRTKUUpw5FIWBM5esy7RSWeg13dgTkdbd1v/JvV9bkwKOXPq
	EZI85AW4fNXprhevS4yegWGMQM1rVjXXBxoGnBIneuAA780zCJfGxS0AzkSOLUM4twF67eEENge
	oJ/orFL7U5wKD6oXf++p+XdgS3uzkyMmVAD1RGoXw3kA/IbI1HCh6rT8d3AA+i9pyYJHdsIF/yz
	Aw7TPll23WOJXMGKfXmoC0WC3CT/zOxry7TGTnXMEOO2qL6AGfA9at+aKQmwNvetloR0yiYr5hl
	I7lw==
X-Google-Smtp-Source: AGHT+IENvJz2TPwvagrAmkRYPiYqs1HbhNs9lmFPVmxBam5aeHZKNQxoLpvrWUQAg2zy11vfbg31yA==
X-Received: by 2002:a05:620a:7089:b0:7e6:261d:76fc with SMTP id af79cd13be357-7ff2a8362dbmr800872585a.40.1756676867749;
        Sun, 31 Aug 2025 14:47:47 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7fc1500901csm566334485a.46.2025.08.31.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 14:47:47 -0700 (PDT)
Date: Sun, 31 Aug 2025 17:47:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Brett A C Sheffield <bacs@librecast.net>, 
 willemdebruijn.kernel@gmail.com
Cc: bacs@librecast.net, 
 davem@davemloft.net, 
 edumazet@google.com, 
 gregkh@linuxfoundation.org, 
 horms@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.10c80f9e245b5@gmail.com>
In-Reply-To: <20250831102908.14655-1-bacs@librecast.net>
References: <willemdebruijn.kernel.143e90d593cff@gmail.com>
 <20250831102908.14655-1-bacs@librecast.net>
Subject: Re: [PATCH net-next v2] selftests: net: add test for ipv6
 fragmentation
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
> Link: https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> ---
> Willem: Thanks for the suggestion to check /sys/class/net/$DEV/operstate
> 
> I did try this but, if I call unshare() and THEN create a TAP interface in the
> new namespace, operstate no longer seems to be visible to the process?
> 
> The process can still read operstate for interfaces in the shared namespace, but
> not ones created in the unshare()d namespace.
> 
> I'm sure I'm doing something wrong there, but after trying a few different
> things including reading operstate from netlink it suddenly occurred to me that
> a simpler and more reliable way to check whether an interface is ready to send
> is to, er, send, and then handle the error for the (unlikely) failure case and
> retry.
> 
> I've incorporated your other review suggestions in this v2. Many thanks.
> 
> v2 changes:
>  - remove superfluous namespace calls - unshare(2) suffices
>  - remove usleep(). Don't wait for the interface to be ready, just send, and
>    handle the (less likely) error case by retrying.
>  - set destination address only once
>  - document our use of the IPv6 link-local source address
>  - send to port 9 (DISCARD) instead of 4242 (DONT PANIC)
>  - ensure sockets are closed on failure paths
>  - use KSFT exit codes for clarity
> 
> v1: https://lore.kernel.org/netdev/20250825092548.4436-3-bacs@librecast.net
> 
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/ipv6_fragmentation.c        | 189 ++++++++++++++++++
>  3 files changed, 191 insertions(+)
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
> index eef0b8f8a7b0..276e0481d996 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
>  TEST_PROGS += tfo_passive.sh
>  TEST_PROGS += broadcast_pmtu.sh
>  TEST_PROGS += ipv6_force_forwarding.sh
> +TEST_GEN_PROGS += ipv6_fragmentation
>  TEST_PROGS += route_hint.sh
>  
>  # YNL files, must be before "include ..lib.mk"
> diff --git a/tools/testing/selftests/net/ipv6_fragmentation.c b/tools/testing/selftests/net/ipv6_fragmentation.c
> new file mode 100644
> index 000000000000..4ba16bf56a32
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_fragmentation.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Brett A C Sheffield <bacs@librecast.net>
> + *
> + * Kernel selftest for the IPv6 fragmentation regression which affected stable
> + * kernels:
> + *
> + *   https://lore.kernel.org/stable/aElivdUXqd1OqgMY@karahi.gladserv.com
> + *
> + * Commit: a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to stable
> + * without some prerequisite commits.
> + *
> + * This caused a regression when sending IPv6 UDP packets by preventing
> + * fragmentation and instead returning -1 (EMSGSIZE).
> + *
> + * This selftest demonstrates the issue by sending an IPv6 UDP packet from
> + * the autoconfigured link-local address to an arbritrary multicast group.
> + *
> + * sendmsg(2) returns bytes sent correctly on a working kernel, and returns -1
> + * (EMSGSIZE) when the regression is present.
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
> +#include "../kselftest.h"
> +
> +#define MTU 1500
> +#define LARGER_THAN_MTU 8192
> +
> +/* ensure MTU is smaller than what we plan to send */
> +static int set_mtu(int ctl, struct ifreq *ifr)
> +{
> +	ifr->ifr_mtu = MTU;
> +	return ioctl(ctl, SIOCSIFMTU, ifr);
> +}
> +
> +/* bring up interface */
> +static int interface_up(int ctl, struct ifreq *ifr)
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
> +static int create_interface(char *ifname, struct ifreq *ifr)
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
> +static int setup(void)
> +{
> +	struct ifreq ifr = {0};
> +	char ifname[IFNAMSIZ];
> +	int fd = -1;
> +	int ctl;
> +
> +	/* we need to set MTU, so do this in a namespace to play nicely */
> +	if (unshare(CLONE_NEWNET) == -1)
> +		return -1;
> +
> +	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
> +	if (ctl == -1)
> +		return -1;
> +
> +	memset(ifname, 0, sizeof(ifname));
> +	fd = create_interface(ifname, &ifr);
> +	if (fd == -1)
> +		goto err_close_ctl;
> +	if (disable_dad(ifname) == -1)
> +		goto err_close_fd;
> +	if (interface_up(ctl, &ifr) == -1)
> +		goto err_close_fd;
> +	if (set_mtu(ctl, &ifr) == -1)
> +		goto err_close_fd;
> +	goto err_close_ctl;
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
> +	/* destination doesn't matter, use an IPv6 link-local multicast group */
> +	struct in6_addr addr = {
> +		.s6_addr[0] = 0xff, /* multicast */
> +		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
> +	};
> +	struct sockaddr_in6 sa = {
> +		.sin6_family = AF_INET6,
> +		.sin6_addr = addr,
> +		.sin6_port = 9      /* port 9/udp (DISCARD) */
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
> +	int err = KSFT_FAIL;
> +	int s;
> +
> +	printf("Testing IPv6 fragmentation\n");
> +	ns_fd = setup();
> +	if (ns_fd == -1) {
> +		printf("[FAIL] test setup failed\n");
> +		return KSFT_FAIL;
> +	}
> +	s = socket(AF_INET6, SOCK_DGRAM, 0);
> +send_again:
> +	rc = sendmsg(s, &msg, 0);
> +	if (rc == -1) {
> +		/* if interface wasn't ready, try again */
> +		if (errno == EADDRNOTAVAIL)
> +			goto send_again;

Here a usleep is in order instead of busy polling on sendmsg.

Responded to v1 earlier, sorry. Most points still hold afaik.


> +		printf("[FAIL] sendmsg: %s\n", strerror(errno));
> +		goto err_close_socket;
> +	} else if (rc != LARGER_THAN_MTU) {
> +		printf("[FAIL] sendmsg() returned %zi\n", rc);
> +		goto err_close_socket;
> +	}
> +	printf("[PASS] sendmsg() returned %zi\n", rc);
> +	err = KSFT_PASS;
> +
> +err_close_socket:
> +	close(s);
> +	close(ns_fd);
> +	return err;
> +}
> -- 
> 2.49.1
> 



