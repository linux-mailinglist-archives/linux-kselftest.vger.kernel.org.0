Return-Path: <linux-kselftest+bounces-9814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D912A8C1517
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3001EB221D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573797EEF3;
	Thu,  9 May 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKdcNaqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E103D3AC;
	Thu,  9 May 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281118; cv=none; b=Wyu7XnGam427YpoeGbD8I7KZIb6Ti5PQ87HzVXAslSjIOf9sdrJ2r6/jRsZKEtXX4+9C68pYnJIUyklgcUXGNtjghDQyWIxzK046DSL33xWiWQHoIWw7qIedRnJwAcm2OX5T27hC8kI0lI/1PIbiR/Iop6JLsIH2BulfngyAEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281118; c=relaxed/simple;
	bh=p4oBaXyGkVYUgLlgzuToc81/gEz7XSwb8iLMqTVRXmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyN+Yt+HZ28OgUCR4WzTzK2M0d3776H1x3/GqC4uxhKdm73yaavrQA+Ktm8wMij1YyAAGQxj9suEn92Bc7fNrTkrqre2wEtjFkUc7Gfsnpd4zB3eExljsVQ2wrE6VpFkDRmX6PXjI32MyLEEtyom2oVIGmIdUD+d+UBTSNJ01gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKdcNaqI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so12316085e9.0;
        Thu, 09 May 2024 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281114; x=1715885914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQhb2ZUqSRd84u3lOJdqv6+mmkos4fA3vEy49iGIxyE=;
        b=GKdcNaqISAbvajV1GKeVwuZTKPVNaIxozN6gbhAL7JvLGaFNY+oSuxzCZEa7E7DT4z
         aC5PE8JGJVJYVc9Vl4Qh+dYSz0hC/fvLv2WwZXbWg8JfP6zioGxhBKcpPbMqEV3D9p7f
         5nKYD1ub5bw/IZqOgpZDDUsUOG0qik/rbzMlvl1DJukKSgmNMZ+EkDom1wjl+Wt1BOGU
         E88lbxY8kzdIm22dh6c66x8YetJ/zxvkQFHsVRxslFnkhOp46I1/dJUUomTSFEXtx8rV
         mMvBiVt5rrw/hs/DFjJCUzbZiC87m6vTxBkjEwuN6f/Nshk7XrS7+s93ZkIr1UW4GEcy
         4wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281114; x=1715885914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gQhb2ZUqSRd84u3lOJdqv6+mmkos4fA3vEy49iGIxyE=;
        b=eWT+L7ahSoTUGEPxV+uwPxJAVPGUHva6e+U15k2400TPOkbuSEs/G2ymtQKiMVRRQm
         KRnlM6Dlj7IreD48/izpOm8Mi6kmm9d6ECn3vCfH6c2yy1KncVAo0Ep/3JeKKyUQUFpI
         zh74I3247sD/kmjhloaIuuz7qrxCfyS5YGZhUf4YdjDs7MWNHMrcxi5Ie6RbIKKffDUT
         9o6oR5wnfvGhf8jkyVdV8qQSFoIkkJBHVeeRF23Lp8V6uDhtjrSRTfHvu66QmcjEuOVp
         hu5XkEMPJHhtINpD5m3i3FaUA94fFlxksyAUwzLiVBN/ZJ6Iij8Tw1YfdsS7gxBsMccz
         dbWg==
X-Forwarded-Encrypted: i=1; AJvYcCUgwEg/TJfWNkEBxsDSolSJGNs5NCB1rThLOPxuZQY4LhJ0lM62O8HGTlH5ZhPyIbDo/+aqwhkRlA2vIOQFKYWw7cnbQHXFJ0ExHf9UVicH/zC9HUIeI3pOV87oReMF2UlmEYFBEjZvHxvOogKjfD4J+oQDfOILCsoQuUX7ni9Rh0Sq+8K+
X-Gm-Message-State: AOJu0Yz8Jxbwc2Kl6pzg629lV+ofX2PsRcq+pc94EHGeQKhyeuce1TEe
	5yE4WMQXkOz2ZQ48M2YbwYYCLy9HuaMVz6ukK/yoOzXEEn7XhtCh
X-Google-Smtp-Source: AGHT+IGQDVXk6MoDVBbf1WZaK1Gx4dmLUNtAMlkibIAOkx+WXlJjT9l8QDaGnTskOtcaRLC6juXgbw==
X-Received: by 2002:a1c:4c14:0:b0:415:540e:74e3 with SMTP id 5b1f17b1804b1-41fead6503fmr4396655e9.40.1715281114071;
        Thu, 09 May 2024 11:58:34 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f881110f9sm69748535e9.37.2024.05.09.11.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:58:33 -0700 (PDT)
Message-ID: <82f6854c-5d69-4675-8233-052a7b085cd4@gmail.com>
Date: Thu, 9 May 2024 20:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Eric Dumazet <edumazet@google.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, willemdebruijn.kernel@gmail.com
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com>
 <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Tue, May 7, 2024 at 6:30 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
>> iph->id, ...) against all packets in a loop. These flush checks are used in
>> all merging UDP and TCP flows.
>>
>> These checks need to be done only once and only against the found p skb,
>> since they only affect flush and not same_flow.
>>
>> This patch leverages correct network header offsets from the cb for both
>> outer and inner network headers - allowing these checks to be done only
>> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
>> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
>> more declarative and contained in inet_gro_flush, thus removing the need
>> for flush_id in napi_gro_cb.
>>
>> This results in less parsing code for non-loop flush tests for TCP and UDP
>> flows.
>>
>> To make sure results are not within noise range - I've made netfilter drop
>> all TCP packets, and measured CPU performance in GRO (in this case GRO is
>> responsible for about 50% of the CPU utilization).
>>
>> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
>> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
>> net-next:
>>         6.94% [kernel] [k] inet_gro_receive
>>         3.02% [kernel] [k] tcp_gro_receive
>>
>> patch applied:
>>         4.27% [kernel] [k] tcp_gro_receive
>>         4.22% [kernel] [k] inet_gro_receive
>>
>> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
>> results for any encapsulation, in this case inet_gro_receive is top
>> offender in net-next)
>> net-next:
>>         10.09% [kernel] [k] inet_gro_receive
>>         2.08% [kernel] [k] tcp_gro_receive
>>
>> patch applied:
>>         6.97% [kernel] [k] inet_gro_receive
>>         3.68% [kernel] [k] tcp_gro_receive
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  include/net/gro.h      | 78 +++++++++++++++++++++++++++++++++++++-----
>>  net/core/gro.c         |  3 --
>>  net/ipv4/af_inet.c     | 41 +---------------------
>>  net/ipv4/tcp_offload.c | 17 ++-------
>>  net/ipv4/udp_offload.c | 10 ++----
>>  net/ipv6/ip6_offload.c | 11 ------
>>  6 files changed, 76 insertions(+), 84 deletions(-)
>>
>> diff --git a/include/net/gro.h b/include/net/gro.h
>> index 3dafa0f31ae1..e0939b4b6579 100644
>> --- a/include/net/gro.h
>> +++ b/include/net/gro.h
>> @@ -36,15 +36,15 @@ struct napi_gro_cb {
>>         /* This is non-zero if the packet cannot be merged with the new skb. */
>>         u16     flush;
>>
>> -       /* Save the IP ID here and check when we get to the transport layer */
>> -       u16     flush_id;
>> -
>>         /* Number of segments aggregated. */
>>         u16     count;
>>
>>         /* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
>>         u16     proto;
>>
>> +       /* used to support CHECKSUM_COMPLETE for tunneling protocols */
>> +       __wsum  csum;
>> +
>>  /* Used in napi_gro_cb::free */
>>  #define NAPI_GRO_FREE             1
>>  #define NAPI_GRO_FREE_STOLEN_HEAD 2
>> @@ -75,8 +75,8 @@ struct napi_gro_cb {
>>                 /* Used in GRE, set in fou/gue_gro_receive */
>>                 u8      is_fou:1;
>>
>> -               /* Used to determine if flush_id can be ignored */
>> -               u8      is_atomic:1;
>> +               /* Used to determine if ipid_offset can be ignored */
>> +               u8      ip_fixedid:1;
>>
>>                 /* Number of gro_receive callbacks this packet already went through */
>>                 u8 recursion_counter:4;
>> @@ -85,9 +85,6 @@ struct napi_gro_cb {
>>                 u8      is_flist:1;
>>         );
>>
>> -       /* used to support CHECKSUM_COMPLETE for tunneling protocols */
>> -       __wsum  csum;
>> -
>>         /* L3 offsets */
>>         union {
>>                 struct {
>> @@ -442,6 +439,71 @@ static inline __wsum ip6_gro_compute_pseudo(const struct sk_buff *skb,
>>                                             skb_gro_len(skb), proto, 0));
>>  }
>>
>> +static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
>> +                                struct sk_buff *p, bool outer)
>> +{
>> +       const u32 id = ntohl(*(__be32 *)&iph->id);
>> +       const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>> +       const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>> +       const u16 count = NAPI_GRO_CB(p)->count;
>> +       const u32 df = id & IP_DF;
>> +       int flush;
>> +
>> +       /* All fields must match except length and checksum. */
>> +       flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
>> +
>> +       if (outer && df)
>> +               return flush;
>> +
>> +       /* When we receive our second frame we can make a decision on if we
>> +        * continue this flow as an atomic flow with a fixed ID or if we use
>> +        * an incrementing ID.
>> +        */
>> +       if (count == 1 && df && !ipid_offset)
>> +               NAPI_GRO_CB(p)->ip_fixedid = true;
>> +
> 
> I could not find where NAPI_GRO_CB(p)->ip_fixedid was cleared, or initialized
> if/when GRO is fed with a GRO/GSO packet.
> 

Interesting, I think that is indeed a bug, that exists also in the current
implementation.
NAPI_GRO_CB(p)->ip_fixedid (is_atomic before we renamed it in this commit)
is cleared as being part of NAPI_GRO_CB(skb)->zeroed in dev_gro_receive.
However, in cases like RSC the HW should tell us if we continue to check
against FIXEDID or not.
Ideally we could initialized ip_fixedid accordingly to skb_shinfo(skb)->gso_type,
but I looked around some drivers with RSC and it seems that not all of them
support the SKB_GSO_TCP_FIXEDID gso_type.

For example in mlx5:

static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4,
                         struct mlx5_cqe64 *cqe, bool match)
{
    ...
    skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
    if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
        skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
    ...
}

But in google's gve:

static int gve_rx_complete_rsc(struct sk_buff *skb,
                   const struct gve_rx_compl_desc_dqo *desc,
                   struct gve_ptype ptype)
{
    ...
    switch (ptype.l3_type) {
    case GVE_L3_TYPE_IPV4:
        shinfo->gso_type = SKB_GSO_TCPV4;
        break;
    ...
}
And there is no other reference to SKB_GSO_TCP_FIXEDID around the driver.

I'm not sure if we could fix this issue in software GRO in the case where
SKB_GSO_TCP_FIXEDID is not set, as we might not have enough information
about the ip ids of the hw gro packets.
Even if we could, without information from the driver it would add checks
and cancel some of the offloading advantages for drivers that assign
FIXEDID, so that is probably not ideal.
This bug should be reproducible on hw with RSC support on current
GRO implementation, as it is unrelated to this series, and be opened as a
different patch to net.

>> +       if (NAPI_GRO_CB(p)->ip_fixedid && df)
>> +               return flush | ipid_offset;
>> +
>> +       return flush | (ipid_offset ^ count);
>> +}
>> +
>> +static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct ipv6hdr *iph2)
>> +{
>> +       /* <Version:4><Traffic_Class:8><Flow_Label:20> */
>> +       __be32 first_word = *(__be32 *)iph ^ *(__be32 *)iph2;
>> +
>> +       /* Flush if Traffic Class fields are different. */
>> +       return !!((first_word & htonl(0x0FF00000)) |
>> +               (__force __be32)(iph->hop_limit ^ iph2->hop_limit));
>> +}
>> +
>> +static inline int __gro_receive_network_flush(const void *th, const void *th2,
>> +                                             struct sk_buff *p, const u16 diff,
>> +                                             bool outer)
>> +{
>> +       const void *nh = th - diff;
>> +       const void *nh2 = th2 - diff;
>> +
>> +       if (((struct iphdr *)nh)->version == 6)
>> +               return ipv6_gro_flush(nh, nh2);
>> +       else
>> +               return inet_gro_flush(nh, nh2, p, outer);
>> +}
>> +
>> +static inline int gro_receive_network_flush(const void *th, const void *th2,
>> +                                           struct sk_buff *p, int off)
>> +{
>> +       const bool encap_mark = NAPI_GRO_CB(p)->encap_mark;
>> +       int flush;
>> +
>> +       flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, encap_mark);
>> +       if (encap_mark)
>> +               flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, false);
>> +
>> +       return flush;
>> +}
>> +
>>  int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
>>
>>  /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
>> diff --git a/net/core/gro.c b/net/core/gro.c
>> index 99a45a5211c9..3e9422c23bc9 100644
>> --- a/net/core/gro.c
>> +++ b/net/core/gro.c
>> @@ -331,8 +331,6 @@ static void gro_list_prepare(const struct list_head *head,
>>         list_for_each_entry(p, head, list) {
>>                 unsigned long diffs;
>>
>> -               NAPI_GRO_CB(p)->flush = 0;
>> -
>>                 if (hash != skb_get_hash_raw(p)) {
>>                         NAPI_GRO_CB(p)->same_flow = 0;
>>                         continue;
>> @@ -472,7 +470,6 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>>                                         sizeof(u32))); /* Avoid slow unaligned acc */
>>         *(u32 *)&NAPI_GRO_CB(skb)->zeroed = 0;
>>         NAPI_GRO_CB(skb)->flush = skb_has_frag_list(skb);
>> -       NAPI_GRO_CB(skb)->is_atomic = 1;
>>         NAPI_GRO_CB(skb)->count = 1;
>>         if (unlikely(skb_is_gso(skb))) {
>>                 NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 428196e1541f..44564d009e95 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1482,7 +1482,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>>         struct sk_buff *p;
>>         unsigned int hlen;
>>         unsigned int off;
>> -       unsigned int id;
>>         int flush = 1;
>>         int proto;
>>
>> @@ -1508,13 +1507,10 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>>                 goto out;
>>
>>         NAPI_GRO_CB(skb)->proto = proto;
>> -       id = ntohl(*(__be32 *)&iph->id);
>> -       flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id & ~IP_DF));
>> -       id >>= 16;
>> +       flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (ntohl(*(__be32 *)&iph->id) & ~IP_DF));
>>
>>         list_for_each_entry(p, head, list) {
>>                 struct iphdr *iph2;
>> -               u16 flush_id;
>>
>>                 if (!NAPI_GRO_CB(p)->same_flow)
>>                         continue;
>> @@ -1531,43 +1527,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>>                         NAPI_GRO_CB(p)->same_flow = 0;
>>                         continue;
>>                 }
>> -
>> -               /* All fields must match except length and checksum. */
>> -               NAPI_GRO_CB(p)->flush |=
>> -                       (iph->ttl ^ iph2->ttl) |
>> -                       (iph->tos ^ iph2->tos) |
>> -                       ((iph->frag_off ^ iph2->frag_off) & htons(IP_DF));
>> -
>> -               NAPI_GRO_CB(p)->flush |= flush;
>> -
>> -               /* We need to store of the IP ID check to be included later
>> -                * when we can verify that this packet does in fact belong
>> -                * to a given flow.
>> -                */
>> -               flush_id = (u16)(id - ntohs(iph2->id));
>> -
>> -               /* This bit of code makes it much easier for us to identify
>> -                * the cases where we are doing atomic vs non-atomic IP ID
>> -                * checks.  Specifically an atomic check can return IP ID
>> -                * values 0 - 0xFFFF, while a non-atomic check can only
>> -                * return 0 or 0xFFFF.
>> -                */
>> -               if (!NAPI_GRO_CB(p)->is_atomic ||
>> -                   !(iph->frag_off & htons(IP_DF))) {
>> -                       flush_id ^= NAPI_GRO_CB(p)->count;
>> -                       flush_id = flush_id ? 0xFFFF : 0;
>> -               }
>> -
>> -               /* If the previous IP ID value was based on an atomic
>> -                * datagram we can overwrite the value and ignore it.
>> -                */
>> -               if (NAPI_GRO_CB(skb)->is_atomic)
>> -                       NAPI_GRO_CB(p)->flush_id = flush_id;
>> -               else
>> -                       NAPI_GRO_CB(p)->flush_id |= flush_id;
>>         }
>>
>> -       NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
>>         NAPI_GRO_CB(skb)->flush |= flush;
>>         NAPI_GRO_CB(skb)->inner_network_offset = off;
>>
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index b70ae50e658d..5f0af1338d62 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -232,9 +232,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>>         goto out_check_final;
>>
>>  found:
>> -       /* Include the IP ID check below from the inner most IP hdr */
>> -       flush = NAPI_GRO_CB(p)->flush;
>> -       flush |= (__force int)(flags & TCP_FLAG_CWR);
>> +       flush = (__force int)(flags & TCP_FLAG_CWR);
>>         flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
>>                   ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
>>         flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
>> @@ -242,16 +240,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>>                 flush |= *(u32 *)((u8 *)th + i) ^
>>                          *(u32 *)((u8 *)th2 + i);
>>
>> -       /* When we receive our second frame we can made a decision on if we
>> -        * continue this flow as an atomic flow with a fixed ID or if we use
>> -        * an incrementing ID.
>> -        */
>> -       if (NAPI_GRO_CB(p)->flush_id != 1 ||
>> -           NAPI_GRO_CB(p)->count != 1 ||
>> -           !NAPI_GRO_CB(p)->is_atomic)
>> -               flush |= NAPI_GRO_CB(p)->flush_id;
>> -       else
>> -               NAPI_GRO_CB(p)->is_atomic = false;
>> +       flush |= gro_receive_network_flush(th, th2, p, off);
>>
>>         mss = skb_shinfo(p)->gso_size;
>>
>> @@ -338,7 +327,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>                                   iph->daddr, 0);
>>
>>         skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
>> -                       (NAPI_GRO_CB(skb)->is_atomic * SKB_GSO_TCP_FIXEDID);
>> +                       (NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
>>
>>         tcp_gro_complete(skb);
>>         return 0;
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 8721fe5beca2..726565159dc7 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -466,6 +466,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>>                                                struct sk_buff *skb)
>>  {
>>         struct udphdr *uh = udp_gro_udphdr(skb);
>> +       int off = skb_gro_offset(skb);
>>         struct sk_buff *pp = NULL;
>>         struct udphdr *uh2;
>>         struct sk_buff *p;
>> @@ -505,14 +506,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>>                         return p;
>>                 }
>>
>> -               flush = NAPI_GRO_CB(p)->flush;
>> -
>> -               if (NAPI_GRO_CB(p)->flush_id != 1 ||
>> -                   NAPI_GRO_CB(p)->count != 1 ||
>> -                   !NAPI_GRO_CB(p)->is_atomic)
>> -                       flush |= NAPI_GRO_CB(p)->flush_id;
>> -               else
>> -                       NAPI_GRO_CB(p)->is_atomic = false;
>> +               flush = gro_receive_network_flush(uh, uh2, p, off);
>>
>>                 /* Terminate the flow on len mismatch or if it grow "too much".
>>                  * Under small packet flood GRO count could elsewhere grow a lot
>> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
>> index 288c7c6ea50f..bd5aff97d8b1 100644
>> --- a/net/ipv6/ip6_offload.c
>> +++ b/net/ipv6/ip6_offload.c
>> @@ -290,19 +290,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>                                    nlen - sizeof(struct ipv6hdr)))
>>                                 goto not_same_flow;
>>                 }
>> -               /* flush if Traffic Class fields are different */
>> -               NAPI_GRO_CB(p)->flush |= !!((first_word & htonl(0x0FF00000)) |
>> -                       (__force __be32)(iph->hop_limit ^ iph2->hop_limit));
>> -               NAPI_GRO_CB(p)->flush |= flush;
>> -
>> -               /* If the previous IP ID value was based on an atomic
>> -                * datagram we can overwrite the value and ignore it.
>> -                */
>> -               if (NAPI_GRO_CB(skb)->is_atomic)
>> -                       NAPI_GRO_CB(p)->flush_id = 0;
>>         }
>>
>> -       NAPI_GRO_CB(skb)->is_atomic = true;
>>         NAPI_GRO_CB(skb)->flush |= flush;
>>
>>         skb_gro_postpull_rcsum(skb, iph, nlen);
>> --
>> 2.36.1
>>

