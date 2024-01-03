Return-Path: <linux-kselftest+bounces-2611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B1822DFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B00528420C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A521946F;
	Wed,  3 Jan 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be4k8Y9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1E1944C;
	Wed,  3 Jan 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336c5b5c163so261471f8f.1;
        Wed, 03 Jan 2024 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704287320; x=1704892120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+E6QcjAYA11vs3Rp1E6NcIULNumFumjIbOzut1MN1o=;
        b=Be4k8Y9hL1XyEQWtAl01WCEgziEJX3YoJkLD7uATB+CwWuB8izu6MKQ2jCuuanBwS5
         ObXUFDP+KrpGBkzu6MivCbPZwEq3u+Sb9nzbb2O2vn/WnvH9lp5fY70046iO3gjxhGei
         CJy7Bog4i65XHSa2GmfY58eNopwErvAFFLIFQvH9Kipd9PB1rBBoZGsUeRR/QEwzcLKQ
         GJhjABXKI19zuVMwmyAu2XFnUML4XrDec6v37/bFN56+mAQMwIwiNb3p2C11LpoHdtVz
         mSaETr7fD9tdISfSHoXXMHu9+ODknjnOCja2TZcpKgqdfnhBYJLzWycX/UrLJs3Cd6Fm
         Rbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287320; x=1704892120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+E6QcjAYA11vs3Rp1E6NcIULNumFumjIbOzut1MN1o=;
        b=U2k99ABmHrWQMXNfIdsPU0dzPonhR12EpAk0wstySdZSydA8Olq8RLt9rh39+9ogni
         hCOW1BrxM5oAXiwTRIU00oV67UUzzMALep3c2S4H9l9jNHLpe4pADMv8k8eKCZRryUmh
         gvM5rUMOmvPUYGhyVOflqICf0xzFMh4fezMGZOArVaiUatGB09mNqOI2IKCGjt5xrI1t
         MOVAZgiQiNUbhyb0dVJM0b5BgyvoYpPDqp+Z/pbAHyU+BcVAvu1nsGwy96tUCe7wvCq4
         Q/kyV2RruKP3NcsP3QO1UdPqdGIrFYVsFFYbo9baX4zhTNLb41CAeLdpYsImPnlQ+2PY
         dUBA==
X-Gm-Message-State: AOJu0YxzUQmacsxTEdZd0keeYxJ/Q9Nx/PcZAnmQKQfjmEcV0wqW0kIU
	XzbrDt4vvqJfRaIzqHWsHkk=
X-Google-Smtp-Source: AGHT+IEHNseMKZWGxt834g4VKrXkRrJsFyU57vwKh8E7gQkFokNFLyheQbhs3qvdOY74FLKZNx6PQw==
X-Received: by 2002:a5d:4fd1:0:b0:337:4fa5:f378 with SMTP id h17-20020a5d4fd1000000b003374fa5f378mr125924wrw.52.1704287320213;
        Wed, 03 Jan 2024 05:08:40 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id dr16-20020a5d5f90000000b003373ef060d5sm8091435wrb.113.2024.01.03.05.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:08:39 -0800 (PST)
Message-ID: <9419df03-a203-4b73-91a6-f008076c29b4@gmail.com>
Date: Wed, 3 Jan 2024 14:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
 <CANn89i+GJOgcDWK=C0+vmomt2ShotrOKyLiXzFkfT1W8vpJv1Q@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89i+GJOgcDWK=C0+vmomt2ShotrOKyLiXzFkfT1W8vpJv1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Eric Dumazet wrote:
> On Tue, Jan 2, 2024 at 2:25 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>> The existing code always pulls the IPv6 header and sets the transport
>> offset initially. Then optionally again pulls any extension headers in
>> ipv6_gso_pull_exthdrs and sets the transport offset again on return from
>> that call. skb->data is set at the start of the first extension header
>> before calling ipv6_gso_pull_exthdrs, and must disable the frag0
>> optimization because that function uses pskb_may_pull/pskb_pull instead of
>> skb_gro_ helpers. It sets the GRO offset to the TCP header with
>> skb_gro_pull and sets the transport header. Then returns skb->data to its
>> position before this block.
>>
>> This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
>> which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
>> ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, all
>> operations use skb_gro_* helpers, and the frag0 fast path can be taken for
>> IPv6 packets with ext headers.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> ---
>>  include/net/ipv6.h     |  1 +
>>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
>>  2 files changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
>> index 78d38dd88aba..217240efa182 100644
>> --- a/include/net/ipv6.h
>> +++ b/include/net/ipv6.h
>> @@ -26,6 +26,7 @@ struct ip_tunnel_info;
>>  #define SIN6_LEN_RFC2133       24
>>
>>  #define IPV6_MAXPLEN           65535
>> +#define IPV6_MIN_EXTHDR_LEN    8
> 
> // Hmm see my following comment.
> 
>>
>>  /*
>>   *     NextHeader field of IPv6 header
>> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
>> index 0e0b5fed0995..c07111d8f56a 100644
>> --- a/net/ipv6/ip6_offload.c
>> +++ b/net/ipv6/ip6_offload.c
>> @@ -37,6 +37,40 @@
>>                 INDIRECT_CALL_L4(cb, f2, f1, head, skb);        \
>>  })
>>
>> +static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>> +{
>> +       const struct net_offload *ops = NULL;
>> +       struct ipv6_opt_hdr *opth;
>> +
>> +       for (;;) {
>> +               int len;
>> +
>> +               ops = rcu_dereference(inet6_offloads[proto]);
>> +
>> +               if (unlikely(!ops))
>> +                       break;
>> +
>> +               if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
>> +                       break;
>> +
>> +               opth = skb_gro_header(skb, off + IPV6_MIN_EXTHDR_LEN, off);
> 
> I do not see a compelling reason for adding yet another constant here.
> 
> I would stick to
> 
>    opth = skb_gro_header(skb, off + sizeof(*opth), off);
> 
> Consistency with similar helpers is desirable.
> 

In terms of consistency - similar helper functions (ipv6_gso_pull_exthdrs,
ipv6_parse_hopopts) also pull 8 bytes at the beginning of every IPv6
extension header, because the minimum extension header length is 8 bytes.

sizeof(*opth) = 2, so for an IPv6 packet with one extension header with a
common length of 8 bytes, pskb_may_pull will be called twice: first with
length = 2 and again with length = 8, which might not be ideal when parsing
non-linear packets.

Willem suggested adding a constant to make the code more self-documenting.

>> +               if (unlikely(!opth))
>> +                       break;
>> +
>> +               len = ipv6_optlen(opth);
>> +
>> +               opth = skb_gro_header(skb, off + len, off);
> 
> Note this call will take care of precise pull.
> 
>> +               if (unlikely(!opth))
>> +                       break;
>> +               proto = opth->nexthdr;
>> +
>> +               off += len;
>> +       }
>> +
>> +       skb_gro_pull(skb, off - skb_network_offset(skb));
>> +       return proto;
>> +}
>> +
>>  static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
>>  {
>>         const struct net_offload *ops = NULL;
>> @@ -203,28 +237,25 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>                 goto out;
>>
>>         skb_set_network_header(skb, off);
>> -       skb_gro_pull(skb, sizeof(*iph));
>> -       skb_set_transport_header(skb, skb_gro_offset(skb));
>>
>> -       flush += ntohs(iph->payload_len) != skb_gro_len(skb);
>> +       flush += ntohs(iph->payload_len) != skb->len - hlen;
>>
>>         proto = iph->nexthdr;
>>         ops = rcu_dereference(inet6_offloads[proto]);
>>         if (!ops || !ops->callbacks.gro_receive) {
>> -               pskb_pull(skb, skb_gro_offset(skb));
>> -               skb_gro_frag0_invalidate(skb);
>> -               proto = ipv6_gso_pull_exthdrs(skb, proto);
>> -               skb_gro_pull(skb, -skb_transport_offset(skb));
>> -               skb_reset_transport_header(skb);
>> -               __skb_push(skb, skb_gro_offset(skb));
>> +               proto = ipv6_gro_pull_exthdrs(skb, hlen, proto);
>>
>>                 ops = rcu_dereference(inet6_offloads[proto]);
>>                 if (!ops || !ops->callbacks.gro_receive)
>>                         goto out;
>>
>> -               iph = ipv6_hdr(skb);
>> +               iph = skb_gro_network_header(skb);
>> +       } else {
>> +               skb_gro_pull(skb, sizeof(*iph));
>>         }
>>
>> +       skb_set_transport_header(skb, skb_gro_offset(skb));
>> +
>>         NAPI_GRO_CB(skb)->proto = proto;
>>
>>         flush--;
>> --
>> 2.36.1
>>

