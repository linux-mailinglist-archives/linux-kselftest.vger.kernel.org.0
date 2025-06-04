Return-Path: <linux-kselftest+bounces-34285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC7ACD870
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B211E3A3D1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EE1F3BA2;
	Wed,  4 Jun 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="3PGeeKuZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E601E7C11
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021627; cv=none; b=cN9etecMiXB2anGYYMOSXehFvL+RfFG4kfDXsUiDMwZ3Rltqo1E+ObUkzJXyHGPN6FzdOztDIAxl0Jz2s5Czqfi3l6TOOfNYLK17tNgG3tfb5y70cljZj4KEnTFplG/mmtx1//moa7vPQD4ug8CzUXEzd0ToTRNewuH79vgmRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021627; c=relaxed/simple;
	bh=CoNrdnc6X9j5mb16cuhbS2/jy4Vn6l91fAZq7pL+id0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bti+KZdlYFuiIfAAGUbb7DoP1sAjCDv6jUSfEV/B+fUb2qFCWiAljwhDaq+Rg2x06sVHvr0fnfPzL/EaCMzqnQK8TmkLmHCvdJCkgfARyIdqcLrNgd1QqNTFEYqhMzO8J+rIuCP/4eMiZrEzVTG+7rbA+BmkFPxaHFAoiu5x/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=3PGeeKuZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c4476d381so614059a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749021625; x=1749626425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3TC5/Hjkq6deseTVI7A5AjPKuWoBhaI4EXWiXp4yFM=;
        b=3PGeeKuZ745PJFnnOgYdJz6mmXq7K8cpnP17FAD+8Z+OAn9Y8gDgnIiRBHFZ4KIZlj
         9qGDWEeBtWjhODl9MXzzyH2GrYcgA2jd+Ma2G0h+QWVrgXLvQoSrokjN9zbpA/4kjS1T
         SYGgtjLVnuhKcJJSjNrYsHh4nU5yxi5pq4SM9jdqQ5OhJjP3ixvTfVc0yVo1FQxvDswr
         rfopC0zov21pBCVCnrtPLA0yjqKnHpRW6XyUqziA3qJBNH7rdfcMyrf4MwJ7ie1Toswp
         CnPcdRodvSciiUw2i6pffIz4ikALFvaQoBzwCHF/4HtVWcDtHhlK8mIOpJyo2nE/pPrc
         LSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021625; x=1749626425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3TC5/Hjkq6deseTVI7A5AjPKuWoBhaI4EXWiXp4yFM=;
        b=EbuXB6pMgUAP8W5ioIbyBgMK/vS8UXwNm0r53tGVnyl4jsQO4jkmyyrr65qzHe1XV1
         ahbxi0ErjpMYX4uKevBzkm+9h+4hvYjnJXrFDYW63UR4W3NTcDrkgl08yvV1on1kj3gD
         S2fhN33AMKIRWFtCR7o7a72pyYCVvOcX+6by6iXsjIn/uuRCWlEegF+/UnkHaPa2DUtl
         1jEX70ui3QS8ixGqBi8moOIs+ChPIWUrGaF5qMZq2tWFsLaEywHJkToqe74LKT8u8s1T
         cSQVNY6wTXUvqIdZXZaYBgDe2rJNtQ9EqoEyWaAvjfRdwmgt1cqSbDojU8meiDpJi/aF
         9sDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMgYgKyIwu/eJa2XvxVxJXKnohP73WT49bTYJgrDNemPCxDnDv6R9Tiyy//di16rS8lF7wydUx8Y7xpKuSvyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwboU28444F2pJX0YGnL/jZLGO6xBUpfYUx1/gMRqLc2donU7g7
	iqWL53ikfgI+cYbCZAaspgRSpMofvdsSUQTl3XuezInT5bORmKPhZli/kYFm08Dcfis=
X-Gm-Gg: ASbGncudTV7TQ06xHXSxMq82P6chTuHXZDPFUbc8N0nU2PiM/L7cbuoxLKfFFN7hgAP
	Q3K2791B+Z00TysHe1ccVMoosW0N6mh4ZFHMkopBzC+tSBGERQ6eafOCotVL3BvWjz3zujIEEbq
	Eirf6FTZRUJhN6GkUKy817AZ+hwVuNyjAUIsXbX9JSsNap5wKP505PIzQrmr3UOgL5rbgyobmMM
	Wm68BTkaynYU4xy7bzSRAZaaG4kEtalYz9vnUe//BZEBFoZArcr34kSM/He7Iv5ZZf6OImeIO39
	z1tTLgWAZPKTerXyzeHVUwZu3DoeC3exVii2gshm7KG0gh+vdAFsGWaFi9lDK81o
X-Google-Smtp-Source: AGHT+IE2BRh/MglJ9V195eNxt03lKS0lhV6PrN7oMp4p/kXcqiakMlT3TicLz7R+1Kqejajqr+TIvg==
X-Received: by 2002:a05:6a21:1796:b0:21a:de8e:5c53 with SMTP id adf61e73a8af0-21d22716cbfmr2946484637.12.1749021625063;
        Wed, 04 Jun 2025 00:20:25 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4c0dsm10504856b3a.78.2025.06.04.00.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:20:24 -0700 (PDT)
Message-ID: <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com>
Date: Wed, 4 Jun 2025 16:20:18 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
 <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com>
 <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/04 10:18, Jason Wang wrote:
> On Tue, Jun 3, 2025 at 1:31 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/06/03 12:19, Jason Wang wrote:
>>> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>> ---
>>>>    include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 188 insertions(+)
>>>>
>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>> index 02a9f4dc594d..426f33b4b824 100644
>>>> --- a/include/linux/virtio_net.h
>>>> +++ b/include/linux/virtio_net.h
>>>> @@ -9,6 +9,194 @@
>>>>    #include <uapi/linux/tcp.h>
>>>>    #include <uapi/linux/virtio_net.h>
>>>>
>>>> +struct virtio_net_hash {
>>>> +       u32 value;
>>>> +       u16 report;
>>>> +};
>>>> +
>>>> +struct virtio_net_toeplitz_state {
>>>> +       u32 hash;
>>>> +       const u32 *key;
>>>> +};
>>>> +
>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>> +
>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>>>> +
>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>>>> +{
>>>> +       while (len >= sizeof(*input)) {
>>>> +               *input = be32_to_cpu((__force __be32)*input);
>>>> +               input++;
>>>> +               len -= sizeof(*input);
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>>>> +                                           const __be32 *input, size_t len)
>>>> +{
>>>> +       while (len >= sizeof(*input)) {
>>>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>>>> +                       u32 i = ffs(map);
>>>> +
>>>> +                       state->hash ^= state->key[0] << (32 - i) |
>>>> +                                      (u32)((u64)state->key[1] >> i);
>>>> +               }
>>>> +
>>>> +               state->key++;
>>>> +               input++;
>>>> +               len -= sizeof(*input);
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
>>>> +{
>>>> +       size_t len = 0;
>>>> +
>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>>>> +
>>>> +       if (types &
>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>> +
>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>>>> +
>>>> +       if (types &
>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>>>> +               len = max(len,
>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>> +
>>>> +       return len + sizeof(u32);
>>>> +}
>>>> +
>>>> +static inline u32 virtio_net_hash_report(u32 types,
>>>> +                                        const struct flow_keys_basic *keys)
>>>> +{
>>>> +       switch (keys->basic.n_proto) {
>>>> +       case cpu_to_be16(ETH_P_IP):
>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>>>> +
>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>>>> +               }
>>>> +
>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>>>> +
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +
>>>> +       case cpu_to_be16(ETH_P_IPV6):
>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>>>> +
>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>>>> +               }
>>>> +
>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>>>> +
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +
>>>> +       default:
>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>> +       }
>>>> +}
>>>> +
>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>>>> +                                      u32 types, const u32 *key,
>>>> +                                      struct virtio_net_hash *hash)
>>>> +{
>>>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>>>> +       struct flow_keys flow;
>>>> +       struct flow_keys_basic flow_basic;
>>>> +       u16 report;
>>>> +
>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       flow_basic = (struct flow_keys_basic) {
>>>> +               .control = flow.control,
>>>> +               .basic = flow.basic
>>>> +       };
>>>> +
>>>> +       report = virtio_net_hash_report(types, &flow_basic);
>>>> +
>>>> +       switch (report) {
>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>> +                                        sizeof(flow.ports.ports));
>>>> +               break;
>>>> +
>>>> +       default:
>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>> +               return;
>>>
>>> So I still think we need a comment here to explain why this is not an
>>> issue if the device can report HASH_XXX_EX. Or we need to add the
>>> support, since this is the code from the driver side, I don't think we
>>> need to worry about the device implementation issues.
>>
>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
>>
>>>
>>> For the issue of the number of options, does the spec forbid fallback
>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
>>
>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
>>   > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>   > header, the hash is calculated over the following fields:
>>   > - Home address from the home address option in the IPv6 destination
>>   >   options header. If the extension header is not present, use the
>>   >   Source IPv6 address.
>>   > - IPv6 address that is contained in the Routing-Header-Type-2 from the
>>   >   associated extension header. If the extension header is not present,
>>   >   use the Destination IPv6 address.
>>   > - Source TCP port
>>   > - Destination TCP port
>>
>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6
>> and an home address option in the IPv6 destination options header is
>> present, the hash is calculated over the home address. If the hash is
>> not calculated over the home address in such a case, the device is
>> contradicting with this section and violating the spec. The same goes
>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
> 
> Just to make sure we are one the same page. I meant:
> 
> 1) If the hash is not calculated over the home address (in the case of
> IPv6 destination destination), it can still report
> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
> series. So the device can simply fallback to e.g TCPv6 if it can't
> understand all or part of the IPv6 options.

The spec says it can fallback if "the extension header is not present", 
not if the device can't understand the extension header.

> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
> tun_vnet_ioctl_sethash(), so userspace may set
> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
> tun_vnet_ioctl_gethashtypes(). In this case they won't get
> VIRTIO_NET_HASH_TYPE_TCP_EX.

That's right. It's the responsibility of the userspace to set only the 
supported hash types.

> 3) implementing part of the hash types might complicate the migration
> or at least we need to describe the expectations of libvirt or other
> management in this case. For example, do we plan to have a dedicated
> Qemu command line like:
> 
> -device virtio-net-pci,hash_report=on,supported_hash_types=X,Y,Z?

I posted a patch series to implement such a command line for vDPA[1]. 
The patch series that wires this tuntap feature up[2] reuses the 
infrastructure so it doesn't bring additional complexity.

[1] 
https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@daynix.com/
[2] 
https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@daynix.com/

Regards,
Akihiko Odaki

