Return-Path: <linux-kselftest+bounces-2509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B481FA38
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC51286032
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C5F514;
	Thu, 28 Dec 2023 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCD2iVw7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E110971;
	Thu, 28 Dec 2023 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5336986cso48366705e9.1;
        Thu, 28 Dec 2023 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703783153; x=1704387953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls284Tcu8nQi61aPyCr/kOAUjlSwlnN/GodQmItK2lo=;
        b=OCD2iVw7V6bWjidAQP8aA6rWc0CxmUE+7Y3kTKVhrlp5qPrHLXsDym0MQQek3Mjnrd
         NkzTyBZ8QsHcDvZwoc3bZRTsB54BNuVcTI7Ghq5xLW49tWMRKyqh3xAhqSRuH4GPnsxB
         3lIZODSSN7WZlvC2JhjCFeBQMCBsrqgpUzE7rfuClGXPMCiqWQDKl4vxumVGANtZkI4i
         4ktLVG08OidUxIgyIHwr0TARfrGCgxeToTV5Q9GBzuzRsLlsmc0nZDd6EW/4FShUUPeU
         z/qQ6PsNHOeGhNHlasrfEbOpm857mpowYTx6kmlZEIgRg2Bg+kX32G07NHBe2q6tdiV7
         nDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703783153; x=1704387953;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ls284Tcu8nQi61aPyCr/kOAUjlSwlnN/GodQmItK2lo=;
        b=f9LTdZr99MgsUcuvm61LVlsmfhlQnCb/q+lEyMll/rpFlY4C+ftckre4hAH+1NEbJd
         SHa+W6scj04+CtRYiArsZMMQa03kcPhdrNRe7A5tHpATUfEA+DOYHwNnWNFK5CnN1QeA
         W4gOdQWAr1fy4t12hBTpblS3ZHpEIJ/cD0/VZPTbiBYDoY+4eRv9p30qsbdvM67SohA5
         AkkAuPp1ZFhtGLg1qA7MSD/eBLUNKEZKFqNkPXs4TMUSSh9vGUYzlgHeFrdzimJY/14U
         UtNVu67Q+++N/uPeFnNp3b/iKsvaovfz9HBF0WL3+N4f2+jl743PBF/Q++9dVADWfz5i
         sGcg==
X-Gm-Message-State: AOJu0YwGyn3W5ak1lWQ1ySjKWTxLEfq1+mC6uOmOTupyf5M16EpTUfz5
	FNNtJ6hCVwSC+4Q+mSQQeyU=
X-Google-Smtp-Source: AGHT+IGy5z5VYUFzo81Pdt0xbkXgssYq4QJ39RXknezCcLLOiMOHSTjdFIe3Lz4HH8BtuFD+jeFBSg==
X-Received: by 2002:a05:600c:314b:b0:40d:70c1:fce with SMTP id h11-20020a05600c314b00b0040d70c10fcemr380266wmo.109.1703783152843;
        Thu, 28 Dec 2023 09:05:52 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b003371e7113d4sm47898wrt.24.2023.12.28.09.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 09:05:52 -0800 (PST)
Message-ID: <8ff4dce9-e7c9-c0f8-5976-f34b2bc32b80@gmail.com>
Date: Thu, 28 Dec 2023 18:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] selftests/net: fix GRO coalesce test and add
 ext
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <f4eff69d-3917-4c42-8c6b-d09597ac4437@gmail.com>
 <641157c0-f224-4910-874d-7906a48d914b@gmail.com>
 <658b42a14789a_5c2a9294ee@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <658b42a14789a_5c2a9294ee@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Currently there is no test which checks that IPv6 extension header packets
>> successfully coalesce. This commit adds a test, which verifies two IPv6
>> packets with HBH extension headers do coalesce.
>>
>> I changed the receive socket filter to accept a packet with one extension
>> header. This change exposed a bug in the fragment test -- the old BPF did
>> not accept the fragment packet. I updated correct_num_packets in the
>> fragment test accordingly.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
> Thanks for adding test coverage along with the feature, and as part
> of the existing gro test too.
> 
>> ---
>>  tools/testing/selftests/net/gro.c | 78 ++++++++++++++++++++++++++++---
>>  1 file changed, 71 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>> index 30024d0ed373..4ee34dca8e5f 100644
>> --- a/tools/testing/selftests/net/gro.c
>> +++ b/tools/testing/selftests/net/gro.c
>> @@ -71,6 +71,10 @@
>>  #define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
>>  #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
>>  #define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
>> +#define MIN_EXTHDR_SIZE 8   /* minimum size of IPv6 extension header */
>> +
>> +#define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
>> +
>>  
>>  static const char *addr6_src = "fdaa::2";
>>  static const char *addr6_dst = "fdaa::1";
>> @@ -104,7 +108,7 @@ static void setup_sock_filter(int fd)
>>  	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
>>  	const int ethproto_off = offsetof(struct ethhdr, h_proto);
>>  	int optlen = 0;
>> -	int ipproto_off;
>> +	int ipproto_off, opt_ipproto_off;
>>  	int next_off;
>>  
>>  	if (proto == PF_INET)
>> @@ -116,14 +120,27 @@ static void setup_sock_filter(int fd)
>>  	if (strcmp(testname, "ip") == 0) {
>>  		if (proto == PF_INET)
>>  			optlen = sizeof(struct ip_timestamp);
>> -		else
>> -			optlen = sizeof(struct ip6_frag);
>> +		else {
>> +			// same size for HBH and Fragment extension header types
> 
> no C++ style comments
> 
> Also, instead of comments here and at the MIN_EXTHDR_SIZE definition,
> perhaps cleaner as self documenting code:
> 
>     BUILD_BUG_ON(MIN_EXTHDR_SIZE != sizeof(struct ip6_hbh));
>     BUILD_BUG_ON(MIN_EXTHDR_SIZE != sizeof(struct ip6_dest));
>     BUILD_BUG_ON(MIN_EXTHDR_SIZE < sizeof(struct ip6_frag));
> 

Thanks for the suggestion, I will add a check that the exthdr structs
are smaller than MIN_EXTHDR_SIZE bytes:

BUILD_BUG_ON(MIN_EXTHDR_SIZE < sizeof(struct ip6_hbh));
BUILD_BUG_ON(MIN_EXTHDR_SIZE < sizeof(struct ip6_dest));
BUILD_BUG_ON(MIN_EXTHDR_SIZE < sizeof(struct ip6_frag));

(The ip6_hbh and ip6_dest structs are 2 bytes long, and the ip6_frag
struct is 8 bytes long)

>> +			optlen = MIN_EXTHDR_SIZE;
>> +			opt_ipproto_off = ETH_HLEN + sizeof(struct ipv6hdr) +
>> +				offsetof(struct ip6_ext, ip6e_nxt);
>> +		}
>>  	}
>>  
>> +	/*
>> +	 * this filter validates the following:
>> +	 *	- packet is IPv4/IPv6 according to the running test.
>> +	 *	- packet is TCP. Also handles the case of one extension header and then TCP.
>> +	 *	- checks the packet tcp dport equals to DPORT.
>> +	 *     (also handles the case of one extension header and then TCP.)
>> +	 */
> 
> nit: for filewide consistency: netdev style:
> 
>        /* start comment
>         * more comment
>         */
> 
>>  	struct sock_filter filter[] = {
>>  			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, ethproto_off),
>> -			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 7),
>> +			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, ntohs(ethhdr_proto), 0, 9),
>>  			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
>> +			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
>> +			BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
>>  			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),
>>  			BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, dport_off),
>>  			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, DPORT, 2, 0),
>> @@ -576,6 +593,39 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
>>  	iph->check = checksum_fold(iph, sizeof(struct iphdr) + optlen, 0);
>>  }
>>  
>> +static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type)
>> +{
>> +	struct ipv6_opt_hdr *hbh_hdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
>> +	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
>> +	int opt_len;
>> +
>> +	hbh_hdr->hdrlen = 0;
>> +	hbh_hdr->nexthdr = IPPROTO_TCP;
>> +	opt_len = ipv6_optlen(hbh_hdr);
>> +
>> +	memcpy(optpkt, buf, tcp_offset);
>> +	memcpy(optpkt + tcp_offset + MIN_EXTHDR_SIZE, buf + tcp_offset,
>> +		sizeof(struct tcphdr) + PAYLOAD_LEN);
>> +
>> +	iph->nexthdr = exthdr_type;
>> +	iph->payload_len = htons(ntohs(iph->payload_len) + MIN_EXTHDR_SIZE);
>> +}
>> +
>> +/* Send IPv6 packet with extension header */
>> +static void send_ipv6_exthdr(int fd, struct sockaddr_ll *daddr)
>> +{
>> +	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
>> +	static char exthdr_pck[sizeof(buf) + MIN_EXTHDR_SIZE];
>> +
>> +	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
>> +	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
>> +	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
>> +
>> +	create_packet(buf, PAYLOAD_LEN * 1, 0, PAYLOAD_LEN, 0);
>> +	add_ipv6_exthdr(buf, exthdr_pck, IPPROTO_HOPOPTS);
>> +	write_packet(fd, exthdr_pck, total_hdr_len + PAYLOAD_LEN + MIN_EXTHDR_SIZE, daddr);
>> +}
>> +
>>  /* IPv4 options shouldn't coalesce */
>>  static void send_ip_options(int fd, struct sockaddr_ll *daddr)
>>  {
>> @@ -697,7 +747,7 @@ static void send_fragment6(int fd, struct sockaddr_ll *daddr)
>>  		create_packet(buf, PAYLOAD_LEN * i, 0, PAYLOAD_LEN, 0);
>>  		write_packet(fd, buf, bufpkt_len, daddr);
>>  	}
>> -
>> +	sleep(1);
> 
> Leftover debug, or necessary fix to existing test?

This sleep was necessary for the fragment test to consistently pass
as packets may arrive out-of-order on the receiving side.

>>  	create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
>>  	memset(extpkt, 0, extpkt_len);
>>  
>> @@ -760,6 +810,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
>>  	vlog("}, Total %d packets\nReceived {", correct_num_pkts);
>>  
>>  	while (1) {
>> +		ip_ext_len = 0;
>>  		pkt_size = recv(fd, buffer, IP_MAXPACKET + ETH_HLEN + 1, 0);
>>  		if (pkt_size < 0)
>>  			error(1, errno, "could not receive");
>> @@ -767,7 +818,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
>>  		if (iph->version == 4)
>>  			ip_ext_len = (iph->ihl - 5) * 4;
>>  		else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
>> -			ip_ext_len = sizeof(struct ip6_frag);
>> +			ip_ext_len = MIN_EXTHDR_SIZE;
> 
> struct ip6_frag is > MIN_EXTHDR_SIZE. Need both cases?
> 
> 	else if (ip6h->version == 6 && ip6h->nexthdr == NEXTHDR_FRAGMENT
> 		ip_ext_len = sizeof(struct ip6_frag);
> 	else if (ip6h->version == 6 && ip6h->nexthdr != IPPROTO_TCP)
> 		ip_ext_len = MIN_EXTHDR_SIZE;
> 

sizeof(struct ip6_frag) == MIN_EXTHDR_SIZE, and any other IPv6 exthdr
test uses an 8(=MIN_EXTHDR_SIZE) byte exthdr, as this is the minimum
size of a single IPv6 exthdr.

We can also see it by looking at the 'ipv6_optlen' macro copied from the
IPv6 exthdr parsing in GRO:
#define ipv6_optlen(p) (((p)->hdrlen+1) << 3)
When hdrlen == 0, the exthdr len will be (0 + 1) << 3 = 8.

>>  
>>  		tcph = (struct tcphdr *)(buffer + tcp_offset + ip_ext_len);
>>  
>> @@ -880,7 +931,14 @@ static void gro_sender(void)
>>  			sleep(1);
>>  			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>>  		} else if (proto == PF_INET6) {
>> +			sleep(1);
>>  			send_fragment6(txfd, &daddr);
>> +			sleep(1);
>> +			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>> +
>> +			sleep(1);
>> +			send_ipv6_exthdr(txfd, &daddr);
>> +			sleep(1);
> 
> For the casual reader: these sleeps are not leftover debug statements
> unfortunately. The same exists in the PF_INET branch:
> 
>         /* Modified packets may be received out of order.
>          * Sleep function added to enforce test boundaries
>          * so that fin pkts are not received prior to other pkts.
>          */
> 
>>  			write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
>>  		}
>>  	} else if (strcmp(testname, "large") == 0) {
>> @@ -997,7 +1055,13 @@ static void gro_receiver(void)
>>  			 */
>>  			printf("fragmented ip6 doesn't coalesce: ");
>>  			correct_payload[0] = PAYLOAD_LEN * 2;
>> -			check_recv_pkts(rxfd, correct_payload, 2);
>> +			correct_payload[1] = PAYLOAD_LEN;
>> +			correct_payload[2] = PAYLOAD_LEN;
>> +			check_recv_pkts(rxfd, correct_payload, 3);
>> +
>> +			correct_payload[0] = PAYLOAD_LEN * 2;
>> +			printf("ipv6 with extension header DOES coalesce: ");
>> +			check_recv_pkts(rxfd, correct_payload, 1);
> 
> It might be worth adding a test with two different extension headers.
> To verify that these should not coalesce.
> 
> Either different ipprotos, like IPPROTO_DSTOPTS vs IPPROTO_HOPOPTS.
> Perhaps more intesting are two of the same ipproto but with different
> content.
> 

Good idea, I will add this test in v2.

>>  		}
>>  	} else if (strcmp(testname, "large") == 0) {
>>  		int offset = proto == PF_INET ? 20 : 0;
>> -- 
>> 2.36.1
>>
> 
> 

