Return-Path: <linux-kselftest+bounces-2447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C581EA21
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 22:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF191B22044
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0A4C7D;
	Tue, 26 Dec 2023 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqKziGo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8754C6D;
	Tue, 26 Dec 2023 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f9f6caabcso34896166d6.3;
        Tue, 26 Dec 2023 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703625378; x=1704230178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7buRn9NZQ4hw320ko1FK6ix7YZOw6sxfX2YXO3Kn+VA=;
        b=EqKziGo3xo490OlLHcrPpOh+U5eYsvJmE4ksdA2BVwQSgiFYJsCXeEvRL6FhdH+PXJ
         YM4Qxwe9posNJeA2HAp2iAAQWGIn+WIbKI5f+ULaxyZJE7L0cfZJeBb5pfMULOEgzf+w
         NvUOLfOP4x0yyrocGEzf9bKGj2HeAsK3fkpxeeslSqF4iScDnny2DCzFjCkdnoPbHhbs
         uVI8KrKjdoqvpdv6IbZ9Hlf4SD6wGU2oZgx41AVeAzba2pkLTBioMyEULk/B+bWXM/f4
         lAHanaOGkX8/9MxP7wQnvsgrFomqTTbeySofrp/+KocDoUWToQWUElKNLhgbcB07L7rS
         UNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703625378; x=1704230178;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7buRn9NZQ4hw320ko1FK6ix7YZOw6sxfX2YXO3Kn+VA=;
        b=gprhWCf7oYMOQjpfQM1oYHmFhyx0M93B0irgGQ3ux1XAivnhjq/Y5WEZvhB4y83VWx
         LVZymcIEoaJQxfSXyWfSqFe2V6nTHkl8bTgP3+9PLCik5UlTxSd+H7dWNVc7sUMTK8g1
         vr4CVqva09StGLLArB6YDO5B7ah5L0QjQsV7OsyAMFLEvPSSqYTIQfVCNg3RBbH9FvjE
         jWSKneR9np23D+XacFdi8O0sbnmShbW6fNJyF252PGst9+/hanRHEiMPHc9Q0tXNWKnE
         BUG370YUmVfFd5h9RYTF22G6o7UvMdgvS95cF2LY/J+98hTKMjJGupmewv8HdXigmilO
         e6Tw==
X-Gm-Message-State: AOJu0Yxw9BU7CrCobocxS1mD3xdO5Z02FLc8P+x2HfWwzdu1utXFhbi7
	NR8NIwl9LXkFT5gDZttQkRY=
X-Google-Smtp-Source: AGHT+IFu7ItG4rHYaGV5ucly6ThlzJY/9jVUVCJej5I27QZUU6Bci4ovXZ65E+8Wep1E/ubmRAMAEQ==
X-Received: by 2002:ad4:5c8d:0:b0:67f:812b:670b with SMTP id o13-20020ad45c8d000000b0067f812b670bmr11866430qvh.23.1703625378025;
        Tue, 26 Dec 2023 13:16:18 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id x19-20020ae9f813000000b0077d66e5b2e6sm4649484qkh.3.2023.12.26.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 13:16:17 -0800 (PST)
Date: Tue, 26 Dec 2023 16:16:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <658b42a14789a_5c2a9294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <641157c0-f224-4910-874d-7906a48d914b@gmail.com>
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
 <641157c0-f224-4910-874d-7906a48d914b@gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests/net: fix GRO coalesce test and add
 ext
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently there is no test which checks that IPv6 extension header packets
> successfully coalesce. This commit adds a test, which verifies two IPv6
> packets with HBH extension headers do coalesce.
> 
> I changed the receive socket filter to accept a packet with one extension
> header. This change exposed a bug in the fragment test -- the old BPF did
> not accept the fragment packet. I updated correct_num_packets in the
> fragment test accordingly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Thanks for adding test coverage along with the feature, and as part
of the existing gro test too.

> ---
>  tools/testing/selftests/net/gro.c | 78 ++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 30024d0ed373..4ee34dca8e5f 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -71,6 +71,10 @@
>  #define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
>  #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
>  #define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
> +#define MIN_EXTHDR_SIZE 8   /* minimum size of IPv6 extension header */
> +
> +#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
> +
>  
>  static const char *addr6_src = "fdaa::2";
>  static const char *addr6_dst = "fdaa::1";
> @@ -104,7 +108,7 @@ static void setup_sock_filter(int fd)
>  	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
>  	const int ethproto_off = offsetof(struct ethhdr, h_proto);
>  	int optlen = 0;
> -	int ipproto_off;
> +	int ipproto_off, opt_ipproto_off;
>  	int next_off;
>  
>  	if (proto == PF_INET)
> @@ -116,14 +120,27 @@ static void setup_sock_filter(int fd)
>  	if (strcmp(testname, "ip") == 0) {
>  		if (proto == PF_INET)
>  			optlen = sizeof(struct ip_timestamp);
> -		else
> -			optlen = sizeof(struct ip6_frag);
> +		else {
> +			// same size for HBH and Fragment extension header types

no C++ style comments

Also, instead of comments here and at the MIN_EXTHDR_SIZE definition,
perhaps cleaner as self documenting code:

    BUILD_BUG_ON(MIN_EXTHDR_SIZE != sizeof(struct ip6_hbh));
    BUILD_BUG_ON(MIN_EXTHDR_SIZE != sizeof(struct ip6_dest));
    BUILD_BUG_ON(MIN_EXTHDR_SIZE < sizeof(struct ip6_frag));

> +			optlen = MIN_EXTHDR_SIZE;
> +			opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr) +
> +				offsetof(struct ip6_ext, ip6e_nxt);
> +		}
>  	}
>  
> +	/*
> +	 * this filter validates the following:
> +	 *	- packet is IPv4/IPv6 according to the running test.
> +	 *	- packet is TCP. Also handles the case of one extension header and then TCP.
> +	 *	- checks the packet tcp dport equals to DPORT.
> +	 *     (also handles the case of one extension header and then TCP.)
> +	 */

nit: for filewide consistency: netdev style:

       /* start comment
        * more comment
        */

>  	struct sock_filter filter[] = {
>  			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, ethproto_off),
> -			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 7),
> +			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 9),
>  			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
> +			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
> +			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
>  			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
>  			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, dport_off),
>  			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, DPORT, 2, 0),
> @@ -576,6 +593,39 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
>  	iph->check = checksum_fold(iph, sizeof(struct iphdr) + optlen, 0);
>  }
>  
> +static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type)
> +{
> +	struct ipv6_opt_hdr *hbh_hdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
> +	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
> +	int opt_len;
> +
> +	hbh_hdr->hdrlen = 0;
> +	hbh_hdr->nexthdr = IPPROTO_TCP;
> +	opt_len = ipv6_optlen(hbh_hdr);
> +
> +	memcpy(optpkt, buf, tcp_offset);
> +	memcpy(optpkt + tcp_offset + MIN_EXTHDR_SIZE, buf + tcp_offset,
> +		sizeof(struct tcphdr) + PAYLOAD_LEN);
> +
> +	iph->nexthdr = exthdr_type;
> +	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
> +}
> +
> +/* Send IPv6 packet with extension header */
> +static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr)
> +{
> +	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
> +	static char exthdr_pck[sizeof(buf) + MIN_EXTHDR_SIZE];
> +
> +	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
> +	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
> +	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
> +
> +	create_packet(buf, PAYLOAD_LEN * 1, 0, PAYLOAD_LEN, 0);
> +	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
> +	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
> +}
> +
>  /* IPv4 options shouldn't coalesce */
>  static void send_ip_options(int fd, struct sockaddr_ll *daddr)
>  {
> @@ -697,7 +747,7 @@ static void send_fragment6(int fd, struct sockaddr_ll *daddr)
>  		create_packet(buf, PAYLOAD_LEN * i, 0, PAYLOAD_LEN, 0);
>  		write_packet(fd, buf, bufpkt_len, daddr);
>  	}
> -
> +	sleep(1);

Leftover debug, or necessary fix to existing test?
>  	create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
>  	memset(extpkt, 0, extpkt_len);
>  
> @@ -760,6 +810,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
>  	vlog("}, Total %d packets\nReceived {", correct_num_pkts);
>  
>  	while (1) {
> +		ip_ext_len = 0;
>  		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
>  		if (pkt_size < 0)
>  			error(1, errno, "could not receive");
> @@ -767,7 +818,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
>  		if (iph->version == 4)
>  			ip_ext_len = (iph->ihl - 5) * 4;
>  		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
> -			ip_ext_len = sizeof(struct ip6_frag);
> +			ip_ext_len = MIN_EXTHDR_SIZE;

struct ip6_frag is > MIN_EXTHDR_SIZE. Need both cases?

	else if (ip6h->version == 6 && ip6h->nexthdr == NEXTHDR_FRAGMENT
		ip_ext_len = sizeof(struct ip6_frag);
	else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
		ip_ext_len = MIN_EXTHDR_SIZE;

>  
>  		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
>  
> @@ -880,7 +931,14 @@ static void gro_sender(void)
>  			sleep(1);
>  			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  		} else if (proto == PF_INET6) {
> +			sleep(1);
>  			send_fragment6(txfd, &daddr);
> +			sleep(1);
> +			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
> +
> +			sleep(1);
> +			send_ipv6_exthdr(txfd, &daddr);
> +			sleep(1);

For the casual reader: these sleeps are not leftover debug statements
unfortunately. The same exists in the PF_INET branch:

        /* Modified packets may be received out of order.
         * Sleep function added to enforce test boundaries
         * so that fin pkts are not received prior to other pkts.
         */

>  			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>  		}
>  	} else if (strcmp(testname, "large") == 0) {
> @@ -997,7 +1055,13 @@ static void gro_receiver(void)
>  			 */
>  			printf("fragmented ip6 doesn't coalesce: ");
>  			correct_payload[0] = PAYLOAD_LEN * 2;
> -			check_recv_pkts(rxfd, correct_payload, 2);
> +			correct_payload[1] = PAYLOAD_LEN;
> +			correct_payload[2] = PAYLOAD_LEN;
> +			check_recv_pkts(rxfd, correct_payload, 3);
> +
> +			correct_payload[0] = PAYLOAD_LEN * 2;
> +			printf("ipv6 with extension header DOES coalesce: ");
> +			check_recv_pkts(rxfd, correct_payload, 1);

It might be worth adding a test with two different extension headers.
To verify that these should not coalesce.

Either different ipprotos, like IPPROTO_DSTOPTS vs IPPROTO_HOPOPTS.
Perhaps more intesting are two of the same ipproto but with different
content.

>  		}
>  	} else if (strcmp(testname, "large") == 0) {
>  		int offset = proto == PF_INET ? 20 : 0;
> -- 
> 2.36.1
> 



