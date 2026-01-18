Return-Path: <linux-kselftest+bounces-49308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F23D397D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B551F300B832
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F521CC60;
	Sun, 18 Jan 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEHHzb0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87819309C
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753377; cv=none; b=SV2pQVHpaQXZq6RghzfW/k5wujsEmGcl4tq6/OuHZKWSX4CTkimsbRhzBZB90Eu8f36QA1WoVHsokp+uXtrPESLoyK7n6cP2o4fxhUVG71iTFJfnevFLyj+kuPFt7mWArIOVzgpDXyb0A+00qBDd4CwzK+DWxwdnDXLLKhwzMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753377; c=relaxed/simple;
	bh=e7fUuGeW1wuNGHGepqtswibjSkdcGJ8du02jiiziGrU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G7DCKvafuQ8sFxvIUBQbqBpitbEPG4ZfHszIKE3Tm7prZ/NqFkam6OwfX177uGTENgUvNJ5DK9pewM74s89qt0easF1+EBQDnymLJGm7Ef5XDNMOvbegqhAh4qU8gH3LIuz5pq7JIlY2yi2ItTFgzq3Bq6yf5cO1LQmPy/HTKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEHHzb0s; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso2791462d50.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768753373; x=1769358173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y21NJW5o57filpmk98Y9AX6GICZPDBi95+r03OYm9wQ=;
        b=XEHHzb0soRHmqBRJWtdMlw7LB7QqJBGFfHtIGHPduOkXj6RGC0hy7s4bzdaWQBTi3K
         A+xEXFImEuduvkdJR8Ju0ImelScFj2tKuOKNEag8GzZSoCaOkzK9ixi97g+/JAYTe5IM
         CAmJENiCVTMC3bXTJ4UBAK+1bR2eSqxTtwG+nrmVv6DRvSL8Twm508mDp27LCgECNSJw
         VvCwWrWW2QMdK+ieUGh132QetKb3cQk2Bk07D4r5g8FaRCcCh/Nlea4K70PT055baqkD
         KzfeolNHbAwNoKumNx+YtA7wlBIqcR0AWeULCThapu6v63iVv7Hy0xHKZeWVgrpXvh6P
         z0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768753373; x=1769358173;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y21NJW5o57filpmk98Y9AX6GICZPDBi95+r03OYm9wQ=;
        b=FSMHnjY334iHymrhE+7ulaPoqCUxMa0NSJjWsVIYqpd39Ke84BONwgtfAFnbvcCGE0
         8aSI9BM15uLZnc0frhMNj4wd7geTgTLttvHYxvNFmb4rrYGdo6wXF5pZybZFis29xZlF
         SSJbGaSuIybeaHEnPNKAClL4wPh9wSyV+B1esd7Dt9NhiLrR+Ya3GJsIR54b1YKiV+/7
         lklP4+4cA/TZe16rgJ/nuwkI4+h1wuIRSYD5oS/Xo43+fJlL+ZlzqM9LssGtOhEaw1hD
         WTY9bpNJdoDFebKot99UupWT/G+aNsz9H2qddylzF2+0PqS1Ln1Xp4UDx+TNvq2/OsPY
         ZI2w==
X-Gm-Message-State: AOJu0YzeuZpTFWJ14F6njTE2jQi73SDicAgIPPI646riCCBbgrFerbZo
	WZd7X/AElOIqPmcKK62r+TdhJwARQlTYGuse1q00lHiEFVZAD4kKCYKcTWxkYg==
X-Gm-Gg: AY/fxX7agaDtUj0tJDGPLdDEKxuzKQkDAlbdRmCQyhMOTsHBsko7xKiC7x1scWyfajM
	Kats6jUiCUSyMN9wr/mOvSQGGk1rqAgN2MFOaH3yv2d+WhfYty5OxuTTMsm7lW5fVV8s0qoa4K4
	yHBduvnC/FlVtKVoAuhIKgv5MjurhUu2f3cU7fv2ddeHovSifiV5IAe/UB/W1F4Kzi0jQWTiI+F
	UFHlFFm68F5InWFYaSsQTOFMCt+pQh4iuBsWIkB8jUImYult/NvtMG7cHrOGujSERpwfsu3GUjN
	3U35MGzxyamwv4gJHGW1mfsaGCfoDdtFRDKPXRj/52J6rddWP60XRJg51/3ACzl759JbQECl7Xl
	GaBTuAQ51JhvVf3H2u74/5RMD4DEc8a2jY/wTZ5UPCcGVBH23GGjDOPsP5eara7ICiZ+E0kRtD/
	Fk/4Y2ja2cDh67c7gvYZT/MIjVuBxP6NziMhQXBdMrUbyPVs8T1EGCsxyAwFXXaTbUP3VM5w==
X-Received: by 2002:a53:d98a:0:b0:644:6c4e:d06a with SMTP id 956f58d0204a3-649164a0079mr5831503d50.36.1768753373029;
        Sun, 18 Jan 2026 08:22:53 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-649170ac7a1sm3926923d50.14.2026.01.18.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 08:22:52 -0800 (PST)
Date: Sun, 18 Jan 2026 11:22:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Danielle Ratson <danieller@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 mlxsw <mlxsw@nvidia.com>
Message-ID: <willemdebruijn.kernel.2ef32666cf33@gmail.com>
In-Reply-To: <DM6PR12MB451623DAE30582C45BB95A3FD88BA@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260114113141.2522209-1-danieller@nvidia.com>
 <willemdebruijn.kernel.1ad957d6f7314@gmail.com>
 <DM6PR12MB451623DAE30582C45BB95A3FD88BA@DM6PR12MB4516.namprd12.prod.outlook.com>
Subject: RE: [PATCH net-next] selftests: net: Add kernel selftest for RFC 4884
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Danielle Ratson wrote:
> > -----Original Message-----
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Sent: Thursday, 15 January 2026 16:51
> > To: Danielle Ratson <danieller@nvidia.com>; netdev@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; shuah@kernel.org; mlxsw
> > <mlxsw@nvidia.com>; Danielle Ratson <danieller@nvidia.com>
> > Subject: Re: [PATCH net-next] selftests: net: Add kernel selftest for RFC 4884
> > 
> > Danielle Ratson wrote:
> > > RFC 4884 extended certain ICMP messages with a length attribute that
> > > encodes the length of the "original datagram" field. This is needed so
> > > that new information could be appended to these messages without
> > > applications thinking that it is part of the "original datagram" field.
> > >
> > > In version 5.9, the kernel was extended with two new socket options
> > > (SOL_IP/IP_RECVERR_4884 and SOL_IPV6/IPV6_RECVERR_RFC4884) that
> > allow
> > > user space to retrieve this length which is basically the offset to
> > > the ICMP Extension Structure at the end of the ICMP message. This is
> > > required by user space applications that need to parse the information
> > > contained in the ICMP Extension Structure. For example, the RFC 5837
> > > extension for tracepath.
> > >
> > > Add a selftest that verifies correct handling of the RFC 4884 length
> > > field for both IPv4 and IPv6, with and without extension structures,
> > > and validates that malformed extensions are correctly reported as invalid.
> > >
> > > For each address family, the test creates:
> > >   - a raw socket used to send locally crafted ICMP error packets to the
> > >     loopback address, and
> > >   - a datagram socket used to receive the encapsulated original datagram
> > >     and associated error metadata from the kernel error queue.
> > >
> > > ICMP packets are constructed entirely in user space rather than
> > > relying on kernel-generated errors. This allows the test to exercise
> > > invalid scenarios (such as corrupted checksums and incorrect length
> > > fields) and verify that the SO_EE_RFC4884_FLAG_INVALID flag is set as
> > expected.
> > >
> > > Output Example:
> > >
> > > $ ./icmp_rfc4884
> > > Starting 18 tests from 18 test cases.
> > >   RUN           rfc4884.ipv4_ext_small_payload.rfc4884 ...
> > >             OK  rfc4884.ipv4_ext_small_payload.rfc4884
> > > ok 1 rfc4884.ipv4_ext_small_payload.rfc4884
> > >   RUN           rfc4884.ipv4_ext.rfc4884 ...
> > >             OK  rfc4884.ipv4_ext.rfc4884 ok 2 rfc4884.ipv4_ext.rfc4884
> > >   RUN           rfc4884.ipv4_ext_large_payload.rfc4884 ...
> > >             OK  rfc4884.ipv4_ext_large_payload.rfc4884
> > > ok 3 rfc4884.ipv4_ext_large_payload.rfc4884
> > >   RUN           rfc4884.ipv4_no_ext_small_payload.rfc4884 ...
> > >             OK  rfc4884.ipv4_no_ext_small_payload.rfc4884
> > > ok 4 rfc4884.ipv4_no_ext_small_payload.rfc4884
> > >   RUN           rfc4884.ipv4_no_ext_min_payload.rfc4884 ...
> > >             OK  rfc4884.ipv4_no_ext_min_payload.rfc4884
> > > ok 5 rfc4884.ipv4_no_ext_min_payload.rfc4884
> > >   RUN           rfc4884.ipv4_no_ext_large_payload.rfc4884 ...
> > >             OK  rfc4884.ipv4_no_ext_large_payload.rfc4884
> > > ok 6 rfc4884.ipv4_no_ext_large_payload.rfc4884
> > >   RUN           rfc4884.ipv4_invalid_ext_checksum.rfc4884 ...
> > >             OK  rfc4884.ipv4_invalid_ext_checksum.rfc4884
> > > ok 7 rfc4884.ipv4_invalid_ext_checksum.rfc4884
> > >   RUN           rfc4884.ipv4_invalid_ext_length_small.rfc4884 ...
> > >             OK  rfc4884.ipv4_invalid_ext_length_small.rfc4884
> > > ok 8 rfc4884.ipv4_invalid_ext_length_small.rfc4884
> > >   RUN           rfc4884.ipv4_invalid_ext_length_large.rfc4884 ...
> > >             OK  rfc4884.ipv4_invalid_ext_length_large.rfc4884
> > > ok 9 rfc4884.ipv4_invalid_ext_length_large.rfc4884
> > >   RUN           rfc4884.ipv6_ext_small_payload.rfc4884 ...
> > >             OK  rfc4884.ipv6_ext_small_payload.rfc4884
> > > ok 10 rfc4884.ipv6_ext_small_payload.rfc4884
> > >   RUN           rfc4884.ipv6_ext.rfc4884 ...
> > >             OK  rfc4884.ipv6_ext.rfc4884 ok 11
> > > rfc4884.ipv6_ext.rfc4884
> > >   RUN           rfc4884.ipv6_ext_large_payload.rfc4884 ...
> > >             OK  rfc4884.ipv6_ext_large_payload.rfc4884
> > > ok 12 rfc4884.ipv6_ext_large_payload.rfc4884
> > >   RUN           rfc4884.ipv6_no_ext_small_payload.rfc4884 ...
> > >             OK  rfc4884.ipv6_no_ext_small_payload.rfc4884
> > > ok 13 rfc4884.ipv6_no_ext_small_payload.rfc4884
> > >   RUN           rfc4884.ipv6_no_ext_min_payload.rfc4884 ...
> > >             OK  rfc4884.ipv6_no_ext_min_payload.rfc4884
> > > ok 14 rfc4884.ipv6_no_ext_min_payload.rfc4884
> > >   RUN           rfc4884.ipv6_no_ext_large_payload.rfc4884 ...
> > >             OK  rfc4884.ipv6_no_ext_large_payload.rfc4884
> > > ok 15 rfc4884.ipv6_no_ext_large_payload.rfc4884
> > >   RUN           rfc4884.ipv6_invalid_ext_checksum.rfc4884 ...
> > >             OK  rfc4884.ipv6_invalid_ext_checksum.rfc4884
> > > ok 16 rfc4884.ipv6_invalid_ext_checksum.rfc4884
> > >   RUN           rfc4884.ipv6_invalid_ext_length_small.rfc4884 ...
> > >             OK  rfc4884.ipv6_invalid_ext_length_small.rfc4884
> > > ok 17 rfc4884.ipv6_invalid_ext_length_small.rfc4884
> > >   RUN           rfc4884.ipv6_invalid_ext_length_large.rfc4884 ...
> > >             OK  rfc4884.ipv6_invalid_ext_length_large.rfc4884
> > > ok 18 rfc4884.ipv6_invalid_ext_length_large.rfc4884
> > >  PASSED: 18 / 18 tests passed.
> > >  Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > > Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I forgot the most obvious point earlier. Thanks for adding these
tests! It's great to have the coverage.

> > > ---
> > >  tools/testing/selftests/net/.gitignore     |   1 +
> > >  tools/testing/selftests/net/Makefile       |   1 +
> > >  tools/testing/selftests/net/icmp_rfc4884.c | 658
> > > +++++++++++++++++++++
> > >  3 files changed, 660 insertions(+)
> > >  create mode 100644 tools/testing/selftests/net/icmp_rfc4884.c
> > >
> > > diff --git a/tools/testing/selftests/net/.gitignore
> > > b/tools/testing/selftests/net/.gitignore
> > > index 6930fe926c58..97ad4d551d44 100644
> > > --- a/tools/testing/selftests/net/.gitignore
> > > +++ b/tools/testing/selftests/net/.gitignore
> > > @@ -7,6 +7,7 @@ cmsg_sender
> > >  epoll_busy_poll
> > >  fin_ack_lat
> > >  hwtstamp_config
> > > +icmp_rfc4884
> > >  io_uring_zerocopy_tx
> > >  ioam6_parser
> > >  ip_defrag
> > > diff --git a/tools/testing/selftests/net/Makefile
> > > b/tools/testing/selftests/net/Makefile
> > > index b66ba04f19d9..fe7937dc5f45 100644
> > > --- a/tools/testing/selftests/net/Makefile
> > > +++ b/tools/testing/selftests/net/Makefile
> > > @@ -166,6 +166,7 @@ TEST_GEN_PROGS := \
> > >  	bind_timewait \
> > >  	bind_wildcard \
> > >  	epoll_busy_poll \
> > > +	icmp_rfc4884 \
> > >  	ipv6_fragmentation \
> > >  	proc_net_pktgen \
> > >  	reuseaddr_conflict \
> > > diff --git a/tools/testing/selftests/net/icmp_rfc4884.c
> > > b/tools/testing/selftests/net/icmp_rfc4884.c
> > > new file mode 100644
> > > index 000000000000..043965289116
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/icmp_rfc4884.c
> > > @@ -0,0 +1,658 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/icmp.h>
> > > +#include <linux/icmpv6.h>
> > > +#include <linux/in6.h>
> > > +#include <linux/ip.h>
> > > +#include <linux/ipv6.h>
> > > +#include <linux/errqueue.h>
> > 
> > no need to respin but tiny: alphabetical ordering
> 
> Ok.
> 
> > 
> > > +#include <sched.h>
> > > +#include <stdbool.h>
> > > +#include <stdint.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <sys/ioctl.h>
> > > +#include <sys/socket.h>
> > > +#include <netinet/in.h>
> > > +#include <netinet/udp.h>
> > > +
> > > +#include "../kselftest_harness.h"
> > > +
> > > +#define SRC_PORT 44444
> > > +#define DST_PORT 55555
> > > +#define MIN_ORIG_DGRAM_LEN 128
> > > +#define MIN_PAYLOAD_LEN_V4	\
> > > +	(MIN_ORIG_DGRAM_LEN - sizeof(struct iphdr) - sizeof(struct
> > udphdr))
> > > +#define MIN_PAYLOAD_LEN_V6	\
> > > +	(MIN_ORIG_DGRAM_LEN - sizeof(struct ipv6hdr) - sizeof(struct
> > > +udphdr)) #define ORIG_PAYLOAD_BYTE 0xAA
> > 
> > only if respinning: prefer typed (const) variables over macros
> 
> Ok
> 
> > 
> > > +
> > > +struct sockaddr_inet {
> > > +	union {
> > > +		struct sockaddr_in6 v6;
> > > +		struct sockaddr_in v4;
> > > +		struct sockaddr sa;
> > > +	};
> > > +	socklen_t len;
> > > +};
> > > +
> > > +struct ip_case_info {
> > > +	int	domain;
> > > +	int	level;
> > > +	int	opt1;
> > > +	int	opt2;
> > > +	int	proto;
> > > +	int	(*build_func)(uint8_t *buf, ssize_t buflen, bool with_ext,
> > > +			      int payload_len, bool bad_csum, bool bad_len,
> > > +			      bool smaller_len);
> > > +	int	min_payload;
> > > +};
> > > +
> > > +static int bringup_loopback(void)
> > > +{
> > > +	struct ifreq ifr = {
> > > +		.ifr_name = "lo"
> > > +	};
> > > +	int fd;
> > > +
> > > +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> > > +	if (fd < 0)
> > > +		return -1;
> > > +
> > > +	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)
> > > +		goto err;
> > > +
> > > +	ifr.ifr_flags = ifr.ifr_flags | IFF_UP;
> > > +
> > > +	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
> > > +		goto err;
> > > +
> > > +	close(fd);
> > > +	return 0;
> > > +
> > > +err:
> > > +	close(fd);
> > > +	return -1;
> > > +}
> > > +
> > > +static uint16_t csum(const void *buf, size_t len) {
> > > +	const uint8_t *data = buf;
> > > +	uint32_t sum = 0;
> > > +
> > > +	while (len > 1) {
> > > +		sum += (data[0] << 8) | data[1];
> > > +		data += 2;
> > > +		len -= 2;
> > > +	}
> > > +
> > > +	if (len == 1)
> > > +		sum += data[0] << 8;
> > > +
> > > +	while (sum >> 16)
> > > +		sum = (sum & 0xFFFF) + (sum >> 16);
> > > +
> > > +	return ~sum & 0xFFFF;
> > > +}
> > > +
> > > +static void set_addr(struct sockaddr_inet *addr, int domain, int
> > > +port) {
> > > +	memset(addr, 0, sizeof(*addr));
> > > +
> > > +	switch (domain) {
> > > +	case AF_INET:
> > > +		addr->v4.sin_family = AF_INET;
> > > +		addr->v4.sin_port = htons(port);
> > > +		addr->v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> > > +		addr->len = sizeof(addr->v4);
> > > +		break;
> > > +	case AF_INET6:
> > > +		addr->v6.sin6_family = AF_INET6;
> > > +		addr->v6.sin6_port = htons(port);
> > > +		addr->v6.sin6_addr = in6addr_loopback;
> > > +		addr->len = sizeof(addr->v6);
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +static int bind_to_loopback(int fd, const struct ip_case_info *info)
> > > +{
> > > +	struct sockaddr_inet addr;
> > > +	int opt = 1;
> > > +
> > > +	set_addr(&addr, info->domain, SRC_PORT);
> > > +
> > > +	if (setsockopt(fd, info->level, info->opt1, &opt, sizeof(opt)) < 0)
> > > +		return -1;
> > > +
> > > +	if (setsockopt(fd, info->level, info->opt2, &opt, sizeof(opt)) < 0)
> > > +		return -1;
> > > +
> > 
> > no need to respin just for this but nit: this does more than the function name
> > covers. I was looking for where IPV6_RECVERR was set.
> 
> Will do.
> 
> > 
> > > +	return bind(fd, &addr.sa, addr.len); }
> > > +
> > > +static int build_rfc4884_ext(uint8_t *buf, size_t buflen, bool bad_csum,
> > > +			     bool bad_len, bool smaller_len) {
> > > +	struct icmp_extobj_hdr *objh;
> > > +	struct icmp_ext_hdr *exthdr;
> > > +	size_t obj_len, ext_len;
> > > +	uint16_t sum;
> > > +
> > > +	/* Use an object payload of 4 bytes */
> > > +	obj_len = sizeof(*objh) + sizeof(uint32_t);
> > > +	ext_len = sizeof(*exthdr) + obj_len;
> > > +
> > > +	if (ext_len > buflen)
> > > +		return -EINVAL;
> > > +
> > > +	exthdr = (struct icmp_ext_hdr *)buf;
> > > +	objh = (struct icmp_extobj_hdr *)(buf + sizeof(*exthdr));
> > > +
> > > +	exthdr->version = 2;
> > > +	/* When encoding a bad object length, either encode a length too
> > small
> > > +	 * to fit the object header or too big to fit in the packet.
> > > +	 */
> > > +	if (bad_len)
> > > +		obj_len = smaller_len ? sizeof(*objh) - 1 : obj_len * 2;
> > > +	objh->length = htons(obj_len);
> > > +
> > > +	sum = csum(buf, ext_len);
> > > +	exthdr->checksum = htons(bad_csum ? sum - 1 : sum);
> > > +
> > > +	return ext_len;
> > > +}
> > > +
> > > +static int build_orig_dgram_v4(uint8_t *buf, ssize_t buflen, int
> > > +payload_len) {
> > > +	struct udphdr *udph;
> > > +	struct iphdr *iph;
> > > +	size_t len = 0;
> > > +
> > > +	len = sizeof(*iph) + sizeof(*udph) + payload_len;
> > > +	if (len > buflen)
> > > +		return -EINVAL;
> > > +
> > > +	iph = (struct iphdr *)buf;
> > > +	udph = (struct udphdr *)(buf + sizeof(*iph));
> > > +
> > > +	iph->version = 4;
> > > +	iph->ihl = 5;
> > > +	iph->protocol = IPPROTO_UDP;
> > > +	iph->saddr = htonl(INADDR_LOOPBACK);
> > > +	iph->daddr = htonl(INADDR_LOOPBACK);
> > > +	iph->tot_len = htons(len);
> > > +	iph->check = htons(csum(iph, sizeof(*iph)));
> > > +
> > > +	udph->source = htons(SRC_PORT);
> > > +	udph->dest = htons(DST_PORT);
> > > +	udph->len = htons(sizeof(*udph) + payload_len);
> > > +
> > > +	memset(buf + sizeof(*iph) + sizeof(*udph), ORIG_PAYLOAD_BYTE,
> > > +	       payload_len);
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static int build_orig_dgram_v6(uint8_t *buf, ssize_t buflen, int
> > > +payload_len) {
> > > +	struct udphdr *udph;
> > > +	struct ipv6hdr *iph;
> > > +	size_t len = 0;
> > > +
> > > +	len = sizeof(*iph) + sizeof(*udph) + payload_len;
> > > +	if (len > buflen)
> > > +		return -EINVAL;
> > > +
> > > +	iph = (struct ipv6hdr *)buf;
> > > +	udph = (struct udphdr *)(buf + sizeof(*iph));
> > > +
> > > +	iph->version = 6;
> > > +	iph->payload_len = htons(sizeof(*udph) + payload_len);
> > > +	iph->nexthdr = IPPROTO_UDP;
> > > +	iph->saddr = in6addr_loopback;
> > > +	iph->daddr = in6addr_loopback;
> > > +
> > > +	udph->source = htons(SRC_PORT);
> > > +	udph->dest = htons(DST_PORT);
> > > +	udph->len = htons(sizeof(*udph) + payload_len);
> > > +
> > > +	memset(buf + sizeof(*iph) + sizeof(*udph), ORIG_PAYLOAD_BYTE,
> > > +	       payload_len);
> > > +
> > > +	return len;
> > > +}
> > > +
> > > +static int build_icmpv4_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
> > > +			    int payload_len, bool bad_csum, bool bad_len,
> > > +			    bool smaller_len)
> > > +{
> > > +	struct icmphdr *icmph;
> > > +	int len, ret;
> > > +
> > > +	len = sizeof(*icmph);
> > > +	memset(buf, 0, buflen);
> > > +
> > > +	icmph = (struct icmphdr *)buf;
> > > +	icmph->type = ICMP_DEST_UNREACH;
> > > +	icmph->code = ICMP_PORT_UNREACH;
> > > +	icmph->checksum = 0;
> > > +
> > > +	ret = build_orig_dgram_v4(buf + len, buflen - len, payload_len);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	len += ret;
> > > +
> > > +	icmph->un.reserved[1] = (len - sizeof(*icmph)) / sizeof(uint32_t);
> > > +
> > > +	if (with_ext) {
> > > +		ret = build_rfc4884_ext(buf + len, buflen - len,
> > > +					bad_csum, bad_len, smaller_len);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		len += ret;
> > > +	}
> > > +
> > > +	icmph->checksum = htons(csum(icmph, len));
> > > +	return len;
> > > +}
> > > +
> > > +static int build_icmpv6_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
> > > +			    int payload_len, bool bad_csum, bool bad_len,
> > > +			    bool smaller_len)
> > > +{
> > > +	struct icmp6hdr *icmph;
> > > +	int len, ret;
> > > +
> > > +	len = sizeof(*icmph);
> > > +	memset(buf, 0, buflen);
> > > +
> > > +	icmph = (struct icmp6hdr *)buf;
> > > +	icmph->icmp6_type = ICMPV6_DEST_UNREACH;
> > > +	icmph->icmp6_code = ICMPV6_PORT_UNREACH;
> > > +	icmph->icmp6_cksum = 0;
> > > +
> > > +	ret = build_orig_dgram_v6(buf + len, buflen - len, payload_len);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	len += ret;
> > > +
> > > +	icmph->icmp6_datagram_len = (len - sizeof(*icmph)) /
> > > +sizeof(uint64_t);
> > > +
> > > +	if (with_ext) {
> > > +		ret = build_rfc4884_ext(buf + len, buflen - len,
> > > +					bad_csum, bad_len, smaller_len);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		len += ret;
> > > +	}
> > > +
> > > +	icmph->icmp6_cksum = htons(csum(icmph, len));
> > > +	return len;
> > > +}
> > > +
> > > +FIXTURE(rfc4884) {};
> > > +
> > > +FIXTURE_SETUP(rfc4884)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = unshare(CLONE_NEWNET);
> > > +	ASSERT_EQ(ret, 0) {
> > > +		TH_LOG("unshare(CLONE_NEWNET) failed: %s",
> > strerror(errno));
> > > +	}
> > > +
> > > +	ret = bringup_loopback();
> > > +	ASSERT_EQ(ret, 0) TH_LOG("Failed to bring up loopback interface"); }
> > > +
> > > +FIXTURE_TEARDOWN(rfc4884)
> > > +{
> > > +}
> > > +
> > > +const struct ip_case_info ipv4_info = {
> > > +	.domain		= AF_INET,
> > > +	.level		= SOL_IP,
> > > +	.opt1		= IP_RECVERR,
> > > +	.opt2		= IP_RECVERR_RFC4884,
> > > +	.proto		= IPPROTO_ICMP,
> > > +	.build_func	= build_icmpv4_pkt,
> > > +	.min_payload	= MIN_PAYLOAD_LEN_V4,
> > > +};
> > > +
> > > +const struct ip_case_info ipv6_info = {
> > > +	.domain		= AF_INET6,
> > > +	.level		= SOL_IPV6,
> > > +	.opt1		= IPV6_RECVERR,
> > > +	.opt2		= IPV6_RECVERR_RFC4884,
> > > +	.proto		= IPPROTO_ICMPV6,
> > > +	.build_func	= build_icmpv6_pkt,
> > > +	.min_payload	= MIN_PAYLOAD_LEN_V6,
> > > +};
> > > +
> > > +FIXTURE_VARIANT(rfc4884) {
> > > +	/* IPv4/v6 related information */
> > > +	struct ip_case_info	info;
> > > +	/* Whether to append an ICMP extension or not */
> > > +	bool			with_ext;
> > > +	/* UDP payload length */
> > > +	int			payload_len;
> > > +	/* Whether to generate a bad checksum in the ICMP extension
> > structure */
> > > +	bool			bad_csum;
> > > +	/* Whether to generate a bad length in the ICMP object header */
> > > +	bool			bad_len;
> > > +	/* Whether it is too small to fit the object header or too big to fit
> > > +	 * in the packet
> > > +	 */
> > > +	bool			smaller_len;
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message with extension and the
> > > +original
> > > + * datagram is smaller than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_small_payload) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= 64,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message with extension and 128
> > > +bytes original
> > > + * datagram, generates an error with the expected offset, and does
> > > +not raise the
> > > + * SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V4,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message with extension and the
> > > +original
> > > + * datagram is larger than 128 bytes, generates an error with the
> > > +expected
> > > + * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_large_payload) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= 256,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message without extension and the
> > > +original
> > > + * datagram is smaller than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_small_payload) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= 64,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message without extension and 128
> > > +bytes
> > > + * original datagram, generates an error with zero offset, and does
> > > +not raise
> > > + * the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_min_payload) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V4,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv4 error message without extension and the
> > > +original
> > > + * datagram is larger than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_large_payload) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= 256,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that an ICMPv4 error message with extension and an invalid
> > > +checksum,
> > > + * generates an error with the expected offset, and raises the
> > > + * SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_checksum) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V4,
> > > +	.bad_csum	= true,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that an ICMPv4 error message with extension and an object
> > > +length
> > > + * smaller than the object header, generates an error with the
> > > +expected offset,
> > > + * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_small) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V4,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= true,
> > > +	.smaller_len	= true,
> > > +};
> > > +
> > > +/* Tests that an ICMPv4 error message with extension and an object
> > > +length that
> > > + * is too big to fit in the packet, generates an error with the
> > > +expected offset,
> > > + * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_large) {
> > > +	.info		= ipv4_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V4,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= true,
> > > +	.smaller_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv6 error message with extension and the
> > > +original
> > > + * datagram is smaller than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_small_payload) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= 64,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv6 error message with extension and 128
> > > +bytes original
> > > + * datagram, generates an error with the expected offset, and does
> > > +not raise the
> > > + * SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V6,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv6 error message with extension and the
> > > +original
> > > + * datagram is larger than 128 bytes, generates an error with the
> > > +expected
> > > + * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_large_payload) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= 256,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +/* Tests that a valid ICMPv6 error message without extension and the
> > > +original
> > > + * datagram is smaller than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_small_payload) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= 64,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv6 error message without extension and 128
> > > +bytes
> > > + * original datagram, generates an error with zero offset, and does
> > > +not
> > > + * raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_min_payload) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V6,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that a valid ICMPv6 error message without extension and the
> > > +original
> > > + * datagram is larger than 128 bytes, generates an error with zero
> > > +offset,
> > > + * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_large_payload) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= false,
> > > +	.payload_len	= 256,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that an ICMPv6 error message with extension and an invalid
> > > +checksum,
> > > + * generates an error with the expected offset, and raises the
> > > + * SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_checksum) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V6,
> > > +	.bad_csum	= true,
> > > +	.bad_len	= false,
> > > +};
> > > +
> > > +/* Tests that an ICMPv6 error message with extension and an object
> > > +length
> > > + * smaller than the object header, generates an error with the
> > > +expected offset,
> > > + * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_small) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V6,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= true,
> > > +	.smaller_len	= true,
> > > +};
> > > +
> > > +/* Tests that an ICMPv6 error message with extension and an object
> > > +length that
> > > + * is too big to fit in the packet, generates an error with the
> > > +expected offset,
> > > + * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
> > > + */
> > > +FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_large) {
> > > +	.info		= ipv6_info,
> > > +	.with_ext	= true,
> > > +	.payload_len	= MIN_PAYLOAD_LEN_V6,
> > > +	.bad_csum	= false,
> > > +	.bad_len	= true,
> > > +	.smaller_len	= false,
> > > +};
> > > +
> > > +static void
> > > +check_rfc4884_offset(struct __test_metadata *_metadata, int sock,
> > > +		     const FIXTURE_VARIANT(rfc4884) *v) {
> > > +	char rxbuf[1024];
> > > +	char ctrl[1024];
> > > +	struct iovec iov = {
> > > +		.iov_base = rxbuf,
> > > +		.iov_len = sizeof(rxbuf)
> > > +	};
> > > +	struct msghdr msg = {
> > > +		.msg_iov = &iov,
> > > +		.msg_iovlen = 1,
> > > +		.msg_control = ctrl,
> > > +		.msg_controllen = sizeof(ctrl),
> > > +	};
> > > +	struct cmsghdr *cmsg;
> > > +	int recv;
> > > +
> > > +	recv = recvmsg(sock, &msg, MSG_ERRQUEUE);
> > 
> > Reading from the error queue does not block.
> > 
> > Is it assured that the ICMP packet is queued on return from sendmsg?
> > Or does this need a poll to be on the safe side wrt flakes.
> 
> Will add a poll, thanks.

Thanks. The sendmsg() is not a single linear function stack up to
the enqueue to the UDP socket receive queue: xmit_loopback calls
netif_rx, which calls enqueue_to_backlog and schedules a softirq for
the Rx path.

> 
> > 
> > > +	ASSERT_GE(recv, 0) TH_LOG("recvmsg(MSG_ERRQUEUE) failed");
> > > +
> > > +	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg =
> > CMSG_NXTHDR(&msg, cmsg)) {
> > > +		bool is_invalid, expected_invalid;
> > > +		struct sock_extended_err *ee;
> > > +		int expected_off;
> > > +		uint16_t off;
> > > +
> > > +		if (cmsg->cmsg_level != v->info.level &&
> > > +		    cmsg->cmsg_type != v->info.opt1)
> > > +			continue;
> > 
> > Do we expect any other cmsg? Else just fail if encountering them, to make the
> > test more strict?
> 
> We do not expect any other control messages in this case. However, I prefer not to fail the test on unrelated ancillary data, as this would make the test more brittle.
> Ignoring unknown cmsg entries makes the test more robust against unrelated kernel behavior changes, while still validating the information we care about.

I understand. When side-effects are highly unlikely, it can be
preferable to fail hard. Or middle ground is to at least log.
Up to you.

> > 
> > > +
> > > +		ee = (struct sock_extended_err *)CMSG_DATA(cmsg);
> > > +		off = ee->ee_rfc4884.len;
> > > +		is_invalid = ee->ee_rfc4884.flags &
> > SO_EE_RFC4884_FLAG_INVALID;
> > > +
> > > +		expected_invalid = v->bad_csum || v->bad_len;
> > > +		ASSERT_EQ(is_invalid, expected_invalid) {
> > > +			TH_LOG("Expected invalidity flag to be %d, but got
> > %d",
> > > +			       expected_invalid, is_invalid);
> > > +		}
> > > +
> > > +		expected_off =
> > > +			(v->with_ext && v->payload_len >= v-
> > >info.min_payload) ?
> > > +			v->payload_len : 0;
> > > +		ASSERT_EQ(off, expected_off) {
> > > +			TH_LOG("Expected RFC4884 offset %u, got %u",
> > > +			       expected_off, off);
> > > +		}
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +TEST_F(rfc4884, rfc4884)
> > > +{
> > > +	const typeof(variant) v = variant;
> > > +	struct sockaddr_inet addr;
> > > +	uint8_t pkt[1024];
> > > +	int dgram, raw;
> > > +	int len, sent;
> > > +	int err;
> > > +
> > > +	dgram = socket(v->info.domain, SOCK_DGRAM, 0);
> > > +	ASSERT_GE(dgram, 0) TH_LOG("Opening datagram socket failed");
> > > +
> > > +	err = bind_to_loopback(dgram, &v->info);
> > > +	ASSERT_EQ(err, 0) TH_LOG("Bind failed");
> > > +
> > > +	raw = socket(v->info.domain, SOCK_RAW, v->info.proto);
> > > +	ASSERT_GE(raw, 0) TH_LOG("Opening raw socket failed");
> > > +
> > > +	len = v->info.build_func(pkt, sizeof(pkt), v->with_ext, v->payload_len,
> > > +				 v->bad_csum, v->bad_len, v->smaller_len);
> > > +	ASSERT_GT(len, 0) TH_LOG("Building packet failed");
> > > +
> > > +	set_addr(&addr, v->info.domain, 0);
> > > +	sent = sendto(raw, pkt, len, 0, &addr.sa, addr.len);
> > > +	ASSERT_EQ(len, sent) TH_LOG("Sending packet failed");
> > > +
> > > +	check_rfc4884_offset(_metadata, dgram, v);
> > > +
> > > +	close(dgram);
> > > +	close(raw);
> > > +}
> > > +
> > > +TEST_HARNESS_MAIN
> > > --
> > > 2.51.0
> > >
> > 
> 



