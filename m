Return-Path: <linux-kselftest+bounces-39859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF8B346EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85E67A4549
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AB2FA0CC;
	Mon, 25 Aug 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgSLtGmQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D82F3633;
	Mon, 25 Aug 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138616; cv=none; b=j7TxotFUn/PnBIemctvi4bdw+q5wy75liP+n+hi6UA01ez4mYw1IkRHONi+AHONSRTYCYrHXxU5gpHXUhXSA1suykQzu5g5gpAUT0mrEpjYCCjZ6nJNAXHTIpGkkc8wcGJS8fb9MCEFwwWd4gV5quPB/7w9MdLJk2IV2mYBZNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138616; c=relaxed/simple;
	bh=TDLfIWRFwwC3Dx3jliWqTXEQ28lSr9bcRJA/957/60I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Lb98fOinU3hUTYq53G3Xt2ou2eMsKvRSrZY6zgxaKshSvmwvx/myrYG6s8b6fjY+FVH9ree8zrHssUydaGC000CvlD7/GBSxD+baTlvMCUW+8AzN1I/4RJhpkXVWBTUGHUz7mL5/sXhr1FvO6PaLkM31l426t4f7cjohmXxj0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgSLtGmQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-523011c7489so206198137.1;
        Mon, 25 Aug 2025 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756138614; x=1756743414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q0gIgfUdfzXjLWY/5e4i6y//L3MRBinZoAMQYO2NI4=;
        b=IgSLtGmQ/mxRr+jNu3YmkZAKr5KRoxWq+bkyb40IF8F3c9xOwr+l/IiKwpyuDkjvR0
         yUgTNfvi61CZXnKcB3Y6/IfDElzc28B180EyhSXPx1O5TfCaFFaQDwnxo2uA2eX07t73
         Z36Tgkhmr+DsMNig9obEP9rmDp7j1KaL9Zy/F/ZkLKvX9A76sxtSPeuSac39jyysFnR6
         HJLrU6adw+25MdjwfMqQdqLFM+obpv4hcemHGf+MHI8WPLeBBz5JhbKA51CDJpN2HaKU
         Cc2XxlHDLNPtEtzow+LFGAo/Yww6LQUg/RG2D9flItG9V3e6DLb+mYsp6YxNzQU4tItT
         aFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138614; x=1756743414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3q0gIgfUdfzXjLWY/5e4i6y//L3MRBinZoAMQYO2NI4=;
        b=A6Nf46gH9AKmjYtxf+m0AaCZZ5gT04Tkz0PVrVjf9iKGJd8CZ46b42KIonECKi+9pU
         kpmcMxaQUgMt3NxBiXScO06qXLAaAyD1rE05Ak2Wl1luwcz+mz623Vhmrfg+rLyj3wEn
         WDwlOdka4LUKA6l0PApUrhS5J5Vt/JixCRh5u+bKNLV4fQfzV3t1Aaw+RIw+QbkTkxyf
         8C4gHFpT127fBcWWdHw2sZkprOiaR3Iw2PNn3Q4WskbayWlOP03HM31MkvwXDTObhjQy
         caVIw4S8Ls5yvlIU1s8EixwXP40fU9tkelG/ypFaPU82HmZ4YG5Qu+d7rQZDK2meYF1t
         teAw==
X-Forwarded-Encrypted: i=1; AJvYcCV4IwCAGwpznIRbAwhKyFidHHWKx/dBFrrgYQ7dfZ6EKbRfs/8fsDToCwfNuJXPTbheRyR4ssc5a/Sp4Zk=@vger.kernel.org, AJvYcCVk1LlThQRx5sXs5l/9ltl+qRfpnSwv/cwI1eGMMyDWzBHvtaP94B0FlOg11vkwdmpksGaEzEsQ@vger.kernel.org, AJvYcCXbC0gDoHDWTHaE+714Fj/1092qQ09xXKgJ2PZbGxkcij35xhm1lrM7RR/9bim+7BQrHk32TrKd7Ec0pj9kku77@vger.kernel.org
X-Gm-Message-State: AOJu0YzigYjGb73ponIsnCnlkWYcVbBfgDxKnSCqlYJCx7tqlHk/evc/
	RwD6NTY+lxetMT0yv9dh2LP7Sc29f/zTtZDyJIqHKFSvcHArUpJA+FtW
X-Gm-Gg: ASbGncuA9SkmgqB4Um/EtGNHYwaywFR45p1u6HPgQgIKYPHDBkWBEKrBQj87fAvfxMy
	qjTvvBpqlXY3q+PyO11ERKyGPv5O4J+An4f7jEG5/2UkGchPMlhAHGdXbhbyvIT55A9ljXPvMLU
	HfvuGf5J67/xUHN7LjIUkRQL9N2p954fL8peDaLJXp+BhmQEGxOETurtBZFxVdOWJYJne/0j+vC
	xzTpHaP4+yzDKwyry5Ri25V7QhBg3OgteZpzNU11Wa8cmq6tKZa8JThuzKpugI/WKCql893fOcW
	0ik8dnrvCMPjKXYnJU3LoSYqwGTdqP1BNpvEFhoFDDAb0pEhWSZ2dqpIU7Dy096dYiVlATfOSZ+
	YkqQDuXDeZB7NXwZBCuMLkDuQrOwAGR6hjbKlUALPP01yktayB+kR+smtrYXIrXMWFZQAEQ==
X-Google-Smtp-Source: AGHT+IGkT4GwkOKBU6QvAEO4wgFdzVC3ttH/lDlWPOkolxnrPDydRtNZaN37go/mkOzg4VN+tRE3Ng==
X-Received: by 2002:a05:6102:38d1:b0:4eb:eede:ec61 with SMTP id ada2fe7eead31-51d0c6bf425mr3973257137.1.1756138613478;
        Mon, 25 Aug 2025 09:16:53 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-51e4b2a85ddsm1539488137.4.2025.08.25.09.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:16:52 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:16:52 -0400
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
Message-ID: <willemdebruijn.kernel.143e90d593cff@gmail.com>
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

Thanks for adding a regression test for this.

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

Is this not sufficient to move the current process in its own netns?

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

This may be racy. Wait on a more explicit signal? E.g.,
/sys/class/net/$DEV/operstate.

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
> +	/* address doesn't matter, use an IPv6 multicast address for simplicity */
> +	struct in6_addr addr = {
> +		.s6_addr[0] = 0xff, /* multicast */
> +		.s6_addr[1] = 0x12, /* set flags (T, link-local) */
> +	};
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

nit: duplicate?

Also, no local address is set. This uses the IPv6 auto assigned
address?

> +	rc = sendmsg(s, &msg, 0);
> +	if (rc == -1) {
> +		perror("send");
> +		return 1;

Probably want to cleanup state both on success and failure.

Could use KSFT_.. exit codes, though 0/1 works just as well for
kselftests in practice.

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



