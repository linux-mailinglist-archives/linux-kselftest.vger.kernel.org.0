Return-Path: <linux-kselftest+bounces-40609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BFB40798
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1174D3A7F82
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F62DFA48;
	Tue,  2 Sep 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk8RuVoV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1021CC7B;
	Tue,  2 Sep 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824541; cv=none; b=fa/30UgY2cAIsgoSb174zrUNo1Tv1BZkKWHjGiHTRejavSKi8uuLhVRc8gE5AfdAvzRRrIXJjyG2W+WNTOIoXQVCyKXjzddfWxd3CKKVhCc1MuQZdEjkqXGQGbFUhi1qGN9gUeA+4xQDYYvfKjUK4YOdf3/cT5Kc+A7MdeH4Xpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824541; c=relaxed/simple;
	bh=o5QeNlLBhELx7P5EvJQo7RcnvIs+0zKwEAzjErk8gRE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RBDU+gBpKYnxqRSHmjqn8vCEw7MUIPGx3KsuLnd69tsmbK9uLi/83RxyKMdDJvnJrqdZDE6z6qBxv2n9T2JXyylDD4onR3kzR43WoXlkXIPuzl8I9DjLhYNOKSuYMSeNQdVudcIsVRjmYpvL3wHgPzHO58GtQzCbTmSNXBGuT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk8RuVoV; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70dfe0ff970so47854656d6.1;
        Tue, 02 Sep 2025 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756824539; x=1757429339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A11N5YSu22iCZXOsouhk0+bMea3SgOIXSyiPpdYylg=;
        b=fk8RuVoVQNzkdJCewvC+tZNw1UjFzA26QKpEn7w+4wUQxr31zaXUYvKKPnsyp3cZ81
         JeZkLxVTIRkUgXTqPhftRJzQLM+w2/CZn7KSi37Ek0lL2rjiWwc96E31eDkUN4k5LzBD
         QsAVqSGOXe92rcejZFnjTbsVMNLaYL1GWq4eSqUyByCXJa74h9AecaYbbMEUiXNWTIWj
         gie2tIzhU8MiMD5+TzegTWNzihSfFTOgNw+PVg9USU0R+ot7vUQCrUhq3MwRGEit+Lnf
         r34xluXnPu/5Ud6LuQw3P6GIqFMX5My911HEsUduFR1dz9dnsH68DZndOP4eHExskvr+
         TR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824539; x=1757429339;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/A11N5YSu22iCZXOsouhk0+bMea3SgOIXSyiPpdYylg=;
        b=uVifP7WuvL1WHWpZ2/KcR2hsUIYsYzRJBz1hXI/an7Y3DOe/KzGYK2OHkM+/gtPI4F
         UIoN7DZqpEAttyAaAdea4UYbY8vzqqO/3dp9EwCu+R2iSISOkR8x7bXiMBTrwv8e+IKZ
         9i481d4DOx+9hTkmgSfmm4VYkWgN4BF2Fuy0AmO2IvgXYVCibSl9GTZk/Qv7e+a8oF7g
         LvgmOUeRfKPT6At3w78Pe/PFUX4nr+jdXHKHVWZ9Y9jMpWNoVdw/3vJslwzkStxXLrhz
         Pn29BYAIMKJxTMDnX7K1fYMQTarkSVxdtEWwRLzXx074q2mrqgZOPNaRP4lo2yqznUDS
         0yQg==
X-Forwarded-Encrypted: i=1; AJvYcCVrfhCW7kPWksPGizU0VOEbxoZl2HpJFv57B8frKXEvM3jpV8GNHycZPKCcuxHQUw9VfkY9RZ8M@vger.kernel.org, AJvYcCXLhme/fiildTq/GmugkYv5iYTYuDWZeXlNHZeF7Lt5nlESbHtO9r7+a5OzGzXSnmC63lBHBtFe6xOC7adu1xP/@vger.kernel.org, AJvYcCXkQnZeNiaD63pvhcBF90YB5VBDwpLKtJESOo3uY284D78p93TrTkM5R/X1U0QdKKYTOzecKi/NcRLgW04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ub7aBXIyyCndqiZ28JfFueroFOE+FNCCkToDoEshu0Y9plPH
	YIIrfmePgSpLCm+jr1aBpg7OgSfWHczWJcpXNyvXF1hYioRFgVDUE8fi
X-Gm-Gg: ASbGncv0z07UNLwVuxD7ZkU9fPjSinJYDbqfhorBBs9YO8DOuenpJKsfD9DKkIfXeer
	xuDegRLLaIohtwGJl9SXPu7qUhb4Br58M2cWDNSBUEFpdn39Eph3KA/W2+Iqkh1Y3a/YtErFIr7
	3qh2qVCCvyXAl6s0k0uvkvb7eYbohrXhEuLY9+fvEVBu4Yx19s+7y2gzP50iCdaH3pmqR/nE8Si
	3eMQBHV6jDbPBEGPtoMMfowiGofxXwvaRKZ8CDl3T6P7ceuMY7BWxGSGcMwcqqpAE+v+HzXSkak
	TXf7CzXycLsMSrJebnHsGWj91fLaOvAa0VUyP9kABSgZzVY5N3QOeZCmrOamuiFk66QMWiE68EI
	LEDM4yTUYx0VyP3BxFv1OU9SFUP/sUs0EpJGwfCWCTp/K/bDbBxI7ubCYv/LgTjm9DxMkNowMGV
	T8Cg==
X-Google-Smtp-Source: AGHT+IG14VksUsXxMqjD97GVCE+pZda0RfMtsAp4CjwES6XT6Qq59nQ5tR14Aqp1grrmr/Oj4M4V6A==
X-Received: by 2002:a05:6214:8019:b0:710:9995:ced4 with SMTP id 6a1803df08f44-71099b45be5mr88801766d6.17.1756824538469;
        Tue, 02 Sep 2025 07:48:58 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720b475a60esm12707306d6.34.2025.09.02.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:48:57 -0700 (PDT)
Date: Tue, 02 Sep 2025 10:48:57 -0400
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
Message-ID: <willemdebruijn.kernel.e019291a1132@gmail.com>
In-Reply-To: <20250902142502.27278-1-bacs@librecast.net>
References: <20250902142502.27278-1-bacs@librecast.net>
Subject: Re: [PATCH net-next v5] selftests: net: add test for ipv6
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
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> Thanks for the reviews Willem and Jakub.
> 
> On 2025-09-01 09:45, Willem de Bruijn wrote:
> 
> > > +int main(void)
> > > +{
> > > +   struct in6_addr addr = {
> > > +           .s6_addr[15] = 0x01, /* ::1 */
> > > +   };
> > > +   struct sockaddr_in6 sa = {
> > > +           .sin6_family = AF_INET6,
> > > +           .sin6_addr = addr,
> > > +           .sin6_port = 9      /* port 9/udp (DISCARD) */
> >
> > htons
> 
> addr is already initialized in network byte order (BE) here.

My point was about port

> 
> Verified with:
> 
>         char ip6[INET6_ADDRSTRLEN];
>         inet_ntop(AF_INET6, &(sa.sin6_addr), ip6, INET6_ADDRSTRLEN);
>         printf("The address is %s\n", ip6);
> 
> which prints "The address is ::1"
> 
> All other suggestions adopted in v5.
> 
> 
> v5 changes:
>  - disable_dad: delete - not needed for lo
>  - main: simplify failure paths
>  - main: char -> static char buf
>  - setup: remove pointless return value
>  - setup: remove unused variable fd
>  - setup: merge with interface_up() to simplify
>  - setup: check all system call return values
>  - remove no longer used headers
> 
> v4 changes:
>  - fix "else should follow close brace" (checkpatch ERROR)
> 
> v3 changes:
>  - add usleep instead of busy polling on sendmsg
>  - simplify error handling by using error() and leaving cleanup to O/S
>  - use loopback interface - don't bother creating TAP
>  - send to localhost (::1)
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
> v4: https://lore.kernel.org/netdev/20250901123757.13112-1-bacs@librecast.net
> v3: https://lore.kernel.org/netdev/20250901112248.5218-1-bacs@librecast.net
> v2: https://lore.kernel.org/netdev/20250831102908.14655-1-bacs@librecast.net
> v1: https://lore.kernel.org/netdev/20250825092548.4436-3-bacs@librecast.net
> 
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/ipv6_fragmentation.c        | 115 ++++++++++++++++++
>  3 files changed, 117 insertions(+)
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
> index 000000000000..b76ce7b713fc
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_fragmentation.c
> @@ -0,0 +1,115 @@
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
> + * This selftest demonstrates the issue by sending an IPv6 UDP packet to
> + * localhost (::1) on the loopback interface from the autoconfigured link-local
> + * address.
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
> +#include <error.h>
> +#include <net/if.h>
> +#include <netinet/in.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +#include "../kselftest.h"
> +
> +#define MTU 1500
> +#define LARGER_THAN_MTU 8192
> +
> +static void setup(void)
> +{
> +	struct ifreq ifr = {
> +		.ifr_name = "lo"
> +	};
> +	int ctl;
> +
> +	/* we need to set MTU, so do this in a namespace to play nicely */
> +	if (unshare(CLONE_NEWNET) == -1)
> +		error(KSFT_FAIL, errno, "unshare");
> +
> +	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
> +	if (ctl == -1)
> +		error(KSFT_FAIL, errno, "socket");
> +
> +	/* ensure MTU is smaller than what we plan to send */
> +	ifr.ifr_mtu = MTU;
> +	if (ioctl(ctl, SIOCSIFMTU, &ifr) == -1)
> +		error(KSFT_FAIL, errno, "ioctl: set MTU");
> +
> +	/* bring up interface */
> +	if (ioctl(ctl, SIOCGIFFLAGS, &ifr) == -1)
> +		error(KSFT_FAIL, errno, "ioctl SIOCGIFFLAGS");
> +	ifr.ifr_flags = ifr.ifr_flags | IFF_UP;
> +	if (ioctl(ctl, SIOCSIFFLAGS, &ifr) == -1)
> +		error(KSFT_FAIL, errno, "ioctl: bring interface up");
> +
> +	if (close(ctl) == -1)
> +		error(KSFT_FAIL, errno, "close");
> +}
> +
> +int main(void)
> +{
> +	struct in6_addr addr = {
> +		.s6_addr[15] = 0x01, /* ::1 */
> +	};
> +	struct sockaddr_in6 sa = {
> +		.sin6_family = AF_INET6,
> +		.sin6_addr = addr,
> +		.sin6_port = 9      /* port 9/udp (DISCARD) */
> +	};
> +	static char buf[LARGER_THAN_MTU] = {0};
> +	struct iovec iov = { .iov_base = buf, .iov_len = sizeof(buf) };
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_name = (struct sockaddr *)&sa,
> +		.msg_namelen = sizeof(sa),
> +	};
> +	ssize_t rc;
> +	int err = KSFT_FAIL;
> +	int s;
> +
> +	printf("Testing IPv6 fragmentation\n");
> +	setup();
> +	s = socket(AF_INET6, SOCK_DGRAM, 0);
> +send_again:
> +	rc = sendmsg(s, &msg, 0);
> +	if (rc == -1) {
> +		/* if interface wasn't ready, try again */
> +		if (errno == EADDRNOTAVAIL) {
> +			usleep(1000);
> +			goto send_again;
> +		}
> +		error(KSFT_FAIL, errno, "sendmsg");
> +	} else if (rc != LARGER_THAN_MTU) {
> +		error(KSFT_FAIL, errno, "sendmsg returned %zi, expected %i",
> +				rc, LARGER_THAN_MTU);
> +	}
> +	printf("[PASS] sendmsg() returned %zi\n", rc);
> +	err = KSFT_PASS;

err is no longer needed, just return KSFT_PASS below

> +	close(s);

reminder to check return value of all library and system calls
> +	return err;
> +}
> 
> base-commit: cd8a4cfa6bb43a441901e82f5c222dddc75a18a3
> -- 
> 2.49.1
> 



