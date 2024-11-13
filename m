Return-Path: <linux-kselftest+bounces-21963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5069C7A7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE41F2358F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343742038D4;
	Wed, 13 Nov 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4QEt6nj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F7202659;
	Wed, 13 Nov 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520714; cv=none; b=Q74kkzRk0Y9T2hSNhulakEIe1/xa60wZiEKOGFk64UeVGc1lWWK63MaiXmVz1NeER38YlS9JTcH7Ow+OHNlqIRqMNa919ZKi6Lz9ZtWcxeMsGLyShw+KucWNd8KO4gHcW6Lam/k7bnWAYFez3sricAqKt71HDyKzQuRFt2GJC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520714; c=relaxed/simple;
	bh=Reqt0QbHf5uJjl6woIlCH6ijcLh9gnw6YjUOrbCW7sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugmDMxg3dJ1KLZMXipz2zHShLUn67U9z6XW7l8OXl4ZYcsFc9ar/OpDaffIApymcpOprOWU3m3SqnlPLE2WI4CduCYlQBhk2B4q0skr2rWvcieeDKb3bIxz7vlBDojUBrAIOKKlv7qn1gY9FIucF1rIlle7yFZoLmZkoMdCvXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4QEt6nj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e576dbc42so76136175ad.0;
        Wed, 13 Nov 2024 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731520711; x=1732125511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aXkVb4KuO4Cshr9t/Xg+SiyZPZHwSnYieA7oZfHEyJk=;
        b=P4QEt6njx9WMT/1mTHtkGt27HMrmr7ZYin08AJnUFiyKyf+Z+CPnMLkxlU9iG23zVo
         whHMzy9F4hwiM/NTljt5ou7rVEN1tLyVsCo05CrK6VvHf5cxhewdzzmPizeIkPNcVGdp
         jhFDaF7x9LJNtWCG1uZl+H1zWRc+joeTBxdU2k0HoQ6v8IjX0n9CilKB09w2beueauF3
         HUongAgd/n5p5QjJEM/u7hIvA6s7JnkoQe8FibSSMMgjo7cQgokpAdIhb9QyJ9mk5COh
         eNr/QON56IHFYDzPFstD/Si74qEl+rVTLjyG+iXU7jrznO6rQKuM4VTUUF0OmJcmHj/+
         3qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520711; x=1732125511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXkVb4KuO4Cshr9t/Xg+SiyZPZHwSnYieA7oZfHEyJk=;
        b=c5ggxlSI8+MIhL+Luaq5kn711Uqm+//er+RU9VoJB8NZRwGVFpxUZ7P9/aJJQ2y6Uk
         14mpyCe6ZkcAKf8bojkiW3i1ZfgWgQNbKucWBwl2fMF+oegvmWJinArwjLF5nuY0lBKF
         OB5RmofWll/xkiKEKlnnDjYAouBikFOq8GpWI4OWv8by9Nl217Yw2VhPIAnF7sqVPadq
         aMwn+k+LnoPZBP29eZjDNhrYpwJASB/9Oz91zEWxrNJehXlcCSi9mKoS0po4DCOBCIt1
         6OizLxV9JLK+vWbDBA5iAxvcfKWpwL4DuDq88jTCZDgipamSE9Ckvgy2DnHS4bP8PATN
         q7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBNdmCh34FnCo9siXX3NyaUW5352REHN6pYqWvqUaKrAU3hz/deIMTWUgTJ+DD8bPJQFcZCKA7jHdLk+E@vger.kernel.org, AJvYcCWS+8A+O+rq9ECALcijaGAz78schT2b4IxNXsdR2z029bF1xZ5hDZ++T0t8MxdYZsuMUjg=@vger.kernel.org, AJvYcCXUefTU4cLmqcFEcyWCgRdTZtm26bROMMoSJdh8Lt8WxN7AbKEtv4MU2PFAeM6Ay/55oTlOfJJ2i7cR5Jrjprwt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DOzYKkxkDn4wdrjmDSk1iDvWSfoqGPla1xQs/L8Ei5bgUhcS
	XTFZ6nUkRn/eJEH6T4bN7Rk0OJzLWCJYcm3hWeIvmRw5S+AQm7I=
X-Google-Smtp-Source: AGHT+IGpQa59tKHsHVrahZ+fS2cIh9OzT0Nar8FkmhxsxATVAGm5x0x4wW79deW0Ti+66YsDf09nkg==
X-Received: by 2002:a17:902:f611:b0:20b:c258:2a74 with SMTP id d9443c01a7336-211b663cfdamr45288985ad.29.1731520711481;
        Wed, 13 Nov 2024 09:58:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407862f0fsm13392856b3a.38.2024.11.13.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:58:31 -0800 (PST)
Date: Wed, 13 Nov 2024 09:58:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: migrate bpf flow
 dissectors tests to test_progs
Message-ID: <ZzToxolRWf2uieWP@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-9-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-9-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> test_flow_dissector.sh loads flow_dissector program and subprograms,
> creates and configured relevant tunnels and interfaces, and ensure that
> the bpf dissection is actually performed correctly. Similar tests exist
> in test_progs (thanks to flow_dissector.c) and run the same programs,
> but those are only executed with BPF_PROG_RUN: those tests are then
> missing some coverage (eg: coverage for flow keys manipulated when the
> configured flower uses a port range, which has a dedicated test in
> test_flow_dissector.sh)
> 
> Convert test_flow_dissector.sh into test_progs so that the corresponding
> tests are also run in CI.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> The content of this new test is heavily based on the initial
> test_flow_dissector.c. I have kept most of the packet build function
> (even if not all packet types are used for the test) to allow extending
> the test later if needed.
> 
> The new test has been executed in a local x86 qemu environment as well
> as in CI:
> 
>   # ./test_progs -a flow_dissector_classification
>   #102/1   flow_dissector_classification/ipv4:OK
>   #102/2   flow_dissector_classification/ipv4_continue_dissect:OK
>   #102/3   flow_dissector_classification/ipip:OK
>   #102/4   flow_dissector_classification/gre:OK
>   #102/5   flow_dissector_classification/port_range:OK
>   #102/6   flow_dissector_classification/ipv6:OK
>   #102     flow_dissector_classification:OK
> ---
>  .../bpf/prog_tests/flow_dissector_classification.c | 851 +++++++++++++++++++++
>  1 file changed, 851 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..de90c3e7b6a4b1890c380e384a255b030014a21d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
> @@ -0,0 +1,851 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <bpf/bpf.h>
> +#include <linux/bpf.h>
> +#include <bpf/libbpf.h>
> +#include <arpa/inet.h>
> +#include <asm/byteorder.h>
> +#include <netinet/udp.h>
> +#include <poll.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +#include "test_progs.h"
> +#include "bpf_util.h"
> +#include "bpf_flow.skel.h"
> +
> +#define CFG_PORT_INNER 8000
> +#define CFG_PORT_GUE 6080
> +#define SUBTEST_NAME_MAX_LEN 32
> +#define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
> +#define MAX_SOURCE_PORTS 3
> +#define TEST_PACKETS_COUNT 10
> +#define TEST_PACKET_LEN 100
> +#define TEST_PACKET_PATTERN 'a'
> +#define TEST_IPV4 "192.168.0.1/32"
> +#define TEST_IPV6 "100::a/128"
> +#define TEST_TUNNEL_REMOTE "127.0.0.2"
> +#define TEST_TUNNEL_LOCAL "127.0.0.1"
> +
> +#define INIT_ADDR4(addr4, port)					\
> +	{							\
> +		.sin_family = AF_INET,				\
> +		.sin_port = __constant_htons(port),		\
> +		.sin_addr.s_addr = __constant_htonl(addr4),	\
> +	}
> +
> +#define INIT_ADDR6(addr6, port)				\
> +	{						\
> +		.sin6_family = AF_INET6,		\
> +		.sin6_port = __constant_htons(port),	\
> +		.sin6_addr = addr6,			\
> +	}
> +#define TEST_IN4_SRC_ADDR_DEFAULT INIT_ADDR4(INADDR_LOOPBACK + 2, 0)
> +#define TEST_IN4_DST_ADDR_DEFAULT INIT_ADDR4(INADDR_LOOPBACK, CFG_PORT_INNER)
> +#define TEST_OUT4_SRC_ADDR_DEFAULT INIT_ADDR4(INADDR_LOOPBACK + 1, 0)
> +#define TEST_OUT4_DST_ADDR_DEFAULT INIT_ADDR4(INADDR_LOOPBACK, 0)
> +
> +#define TEST_IN6_SRC_ADDR_DEFAULT INIT_ADDR6(IN6ADDR_LOOPBACK_INIT, 0)
> +#define TEST_IN6_DST_ADDR_DEFAULT \
> +	INIT_ADDR6(IN6ADDR_LOOPBACK_INIT, CFG_PORT_INNER)
> +#define TEST_OUT6_SRC_ADDR_DEFAULT INIT_ADDR6(IN6ADDR_LOOPBACK_INIT, 0)
> +#define TEST_OUT6_DST_ADDR_DEFAULT INIT_ADDR6(IN6ADDR_LOOPBACK_INIT, 0)
> +
> +#define TEST_IN4_SRC_ADDR_DISSECT_CONTINUE INIT_ADDR4(INADDR_LOOPBACK + 126, 0)
> +#define TEST_IN4_SRC_ADDR_IPIP INIT_ADDR4((in_addr_t)0x01010101, 0)
> +#define TEST_IN4_DST_ADDR_IPIP INIT_ADDR4((in_addr_t)0xC0A80001, CFG_PORT_INNER)
> +
> +struct grehdr {
> +	uint16_t unused;
> +	uint16_t protocol;
> +} __packed;
> +
> +struct guehdr {
> +	union {
> +		struct {
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +			__u8 hlen : 5, control : 1, version : 2;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +			__u8 version : 2, control : 1, hlen : 5;
> +#else
> +#error "Please fix <asm/byteorder.h>"
> +#endif
> +			__u8 proto_ctype;
> +			__be16 flags;
> +		};
> +		__be32 word;
> +	};
> +};
> +
> +static char buf[ETH_DATA_LEN];
> +
> +struct test_configuration {
> +	char name[SUBTEST_NAME_MAX_LEN];
> +	int (*test_setup)(void);
> +	void (*test_teardown)(void);
> +	int source_ports[MAX_SOURCE_PORTS];
> +	int cfg_l3_inner;
> +	struct sockaddr_in in_saddr4;
> +	struct sockaddr_in in_daddr4;
> +	struct sockaddr_in6 in_saddr6;
> +	struct sockaddr_in6 in_daddr6;
> +	int cfg_l3_outer;
> +	struct sockaddr_in out_saddr4;
> +	struct sockaddr_in out_daddr4;
> +	struct sockaddr_in6 out_saddr6;
> +	struct sockaddr_in6 out_daddr6;
> +	int cfg_encap_proto;
> +	uint8_t cfg_dsfield_inner;
> +	uint8_t cfg_dsfield_outer;
> +	int cfg_l3_extra;
> +	struct sockaddr_in extra_saddr4;
> +	struct sockaddr_in extra_daddr4;
> +	struct sockaddr_in6 extra_saddr6;
> +	struct sockaddr_in6 extra_daddr6;
> +};
> +
> +static unsigned long util_gettime(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
> +}

[..]

> +static unsigned long add_csum_hword(const uint16_t *start, int num_u16)
> +{
> +	unsigned long sum = 0;
> +	int i;
> +
> +	for (i = 0; i < num_u16; i++)
> +		sum += start[i];
> +
> +	return sum;
> +}
> +
> +static uint16_t build_ip_csum(const uint16_t *start, int num_u16,
> +			      unsigned long sum)
> +{
> +	sum += add_csum_hword(start, num_u16);
> +
> +	while (sum >> 16)
> +		sum = (sum & 0xffff) + (sum >> 16);
> +
> +	return ~sum;
> +}
> +
> +static void build_ipv4_header(void *header, uint8_t proto, uint32_t src,
> +			      uint32_t dst, int payload_len, uint8_t tos)
> +{
> +	struct iphdr *iph = header;
> +
> +	iph->ihl = 5;
> +	iph->version = 4;
> +	iph->tos = tos;
> +	iph->ttl = 8;
> +	iph->tot_len = htons(sizeof(*iph) + payload_len);
> +	iph->id = htons(1337);
> +	iph->protocol = proto;
> +	iph->saddr = src;
> +	iph->daddr = dst;
> +	iph->check = build_ip_csum((void *)iph, iph->ihl << 1, 0);
> +}
> +
> +static void ipv6_set_dsfield(struct ipv6hdr *ip6h, uint8_t dsfield)
> +{
> +	uint16_t val, *ptr = (uint16_t *)ip6h;
> +
> +	val = ntohs(*ptr);
> +	val &= 0xF00F;
> +	val |= ((uint16_t)dsfield) << 4;
> +	*ptr = htons(val);
> +}
> +
> +static void build_ipv6_header(void *header, uint8_t proto,
> +			      struct sockaddr_in6 *src,
> +			      struct sockaddr_in6 *dst, int payload_len,
> +			      uint8_t dsfield)
> +{
> +	struct ipv6hdr *ip6h = header;
> +
> +	ip6h->version = 6;
> +	ip6h->payload_len = htons(payload_len);
> +	ip6h->nexthdr = proto;
> +	ip6h->hop_limit = 8;
> +	ipv6_set_dsfield(ip6h, dsfield);
> +
> +	memcpy(&ip6h->saddr, &src->sin6_addr, sizeof(ip6h->saddr));
> +	memcpy(&ip6h->daddr, &dst->sin6_addr, sizeof(ip6h->daddr));
> +}
> +
> +static uint16_t build_udp_v4_csum(const struct iphdr *iph,
> +				  const struct udphdr *udph, int num_words)
> +{
> +	unsigned long pseudo_sum;
> +	int num_u16 = sizeof(iph->saddr); /* halfwords: twice byte len */
> +
> +	pseudo_sum = add_csum_hword((void *)&iph->saddr, num_u16);
> +	pseudo_sum += htons(IPPROTO_UDP);
> +	pseudo_sum += udph->len;
> +	return build_ip_csum((void *)udph, num_words, pseudo_sum);
> +}
> +
> +static uint16_t build_udp_v6_csum(const struct ipv6hdr *ip6h,
> +				  const struct udphdr *udph, int num_words)
> +{
> +	unsigned long pseudo_sum;
> +	int num_u16 = sizeof(ip6h->saddr); /* halfwords: twice byte len */
> +
> +	pseudo_sum = add_csum_hword((void *)&ip6h->saddr, num_u16);
> +	pseudo_sum += htons(ip6h->nexthdr);
> +	pseudo_sum += ip6h->payload_len;
> +	return build_ip_csum((void *)udph, num_words, pseudo_sum);
> +}

I remember adding a bunch of similar code to tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
and tools/testing/selftests/bpf/network_helpers.h. The csum handling in
particular (csum_tcpudp_magic/etc for pseudo headers).
Can you see if something can be reused? Maybe something we
can move into network_helpers.h? For example build_ip_csum/ip_csum.

