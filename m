Return-Path: <linux-kselftest+bounces-34360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9447ACEB5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B062167C04
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79971FFC49;
	Thu,  5 Jun 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NXt9gKdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CD1FF1AD
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110267; cv=none; b=S/YlfdEU0VtGsAvBSWd+S9D7UBStCc+3HFwzCgY3tNkI1WjxxI0MWlPbid/K2ZLdLu7v9SsphTD7wITQ8c3ddXWrQ5cFV3MyHiLa6CRO3WBXIjS08KVybNFLVP3glQp2+OoJwGYnvtEEocDJ2TH/WVJ1vnNBg1lj7G3rSz2t8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110267; c=relaxed/simple;
	bh=lTA9zjNN3JRVFRXQw/iswVkI+O61SyCDwuvCfwwT6sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe/crtlVBVl9TFWM5DxqVW5FG/RV49XxfMFZP7HfahPDbJuSdpdiJ5KXErtInAQV8JvTUho+gw/ZCe1HeVdC3GvNT2WZ2qmgkinw2kEDisUMMjeEFHOEEsvdGdJo4POg8UrZsBllk7c8TXEjJoZmavTMxvjLmsyeVkEJQYj6hT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NXt9gKdx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7481600130eso872362b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749110265; x=1749715065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zZl2dXMX0VDVWJAsL+cjXNr7Ok2fg0ZVvzGEGrTbrE=;
        b=NXt9gKdxkt0smYROeldepk+OBONg+wK+WS6irmFMbuM5Yh956ve7YzQQThj09ZtyLd
         tC0ohv+QpIcX54RX+u4zxAzBcKY8SCyY+zIDBrh+ArwSMgsS01HIWxXHImNzbSN3MfnN
         2dLcfDCQIeCETU3DCYbUZjF/0/NEgsTXk6TqYlZuNIxZ42b9lLUEpUnK4nWl9gqY67BC
         w010AwWppj0xupGkvLBW6P2m4khin3x511BgNQlulo599MxmtuPR73Vwi2tUXeK0tvLF
         rohAoI9wro61NXLBho8oHW6/Ypts8waiCScBfnfs8jG+TXWqFQSDU3RR1fUJkbaGXkTS
         +xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110265; x=1749715065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zZl2dXMX0VDVWJAsL+cjXNr7Ok2fg0ZVvzGEGrTbrE=;
        b=Gnzdu3+87o4eKA80XQ3rWIdp6TrKfjUO4gNDqXBIH45cHqHCGnXwJ+wE2fZ9rwye6j
         VwsGRggv8LvCgElmMZ2Ta9tHiJwoBX+MqDL86t6Xty0VQrJVhiKR5z40fsANU6kC7NsF
         BXmMnqBzEtp/yi+bfQmQbdZHMyky03jP3KAhWdQOLMp3DNx25lc/qW3DyTShiiNOkH9B
         QAsWcBSoA0phRJW017GCb8wtrIy/K63++bUeDsMZzjs3oQ0mpFKL+iHP8xphMLkqTlac
         OpjSOQ4YhZ6KRJ4PbjqYaS7yAdCm8TH/gZraLi0nqA5n5eUTwOXUrDvmFnN2L27xeN2g
         4wBA==
X-Forwarded-Encrypted: i=1; AJvYcCXYKptc51pvAjQjA+dV3JcsjGZwX43dW1cn+SDvZHjsPvbKEjsmzgSEJuXda6q6BKVmFpcO0m6N9Aojf1Lz7mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPGaqaCgCshFC5NUY9BN/koydUzpixo6GIPr2ZV4qBqWnmTrF
	KjnmqOXaNsIH2FWBUNW4PeSvmx9kYkS1sHLL+ZkQpgIm3BHShUgCIlNCt4eNb/e4Bbo=
X-Gm-Gg: ASbGncukpX2QULyD2H3ssjTIhYhxvWX4HKwyUo/aAOvFRjhnIBv/+MgG+x+34QLEq0f
	Qrkbo9JH75NI9HXT7yexlHN548E1glPECE2vGwH+EcMtE23e9XNvhxsp3qnsoJD7rNvipFkq89o
	UWUXOqdT2Htb7sFSwVvgZc/LzcmAe48BWBK95RP29hWkxMuUFleCw7XlJCK3Akmnle6pzLKV8Dr
	BQNGGKnvqsfvdxGE5NbLCCnxxeEbCGyHLp5itQ4ngecrWTnGdrBRBo3pskkSgYhxeRQTK7rqUzU
	cB/N59/7IlVsZ+SJbCJ3ret/KMW3bWcjj6YI471KL10Jkvsdb0KxjRht/8E0iMuo
X-Google-Smtp-Source: AGHT+IFSoebIZPWJ4N4NNYcabgJf1nxLz3d3ke91Rf5CUCkTc2VJbpBBnWqg7beTFgdLDU7v3xdgJA==
X-Received: by 2002:a05:6a00:3d13:b0:742:362c:d2e4 with SMTP id d2e1a72fcca58-7480b226180mr7583905b3a.5.1749110264898;
        Thu, 05 Jun 2025 00:57:44 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affcf703sm12228046b3a.129.2025.06.05.00.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 00:57:44 -0700 (PDT)
Message-ID: <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com>
Date: Thu, 5 Jun 2025 16:57:39 +0900
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
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com>
 <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/05 10:53, Jason Wang wrote:
> On Wed, Jun 4, 2025 at 3:20 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/06/04 10:18, Jason Wang wrote:
>>> On Tue, Jun 3, 2025 at 1:31 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/06/03 12:19, Jason Wang wrote:
>>>>> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>> ---
>>>>>>     include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 188 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>>>> index 02a9f4dc594d..426f33b4b824 100644
>>>>>> --- a/include/linux/virtio_net.h
>>>>>> +++ b/include/linux/virtio_net.h
>>>>>> @@ -9,6 +9,194 @@
>>>>>>     #include <uapi/linux/tcp.h>
>>>>>>     #include <uapi/linux/virtio_net.h>
>>>>>>
>>>>>> +struct virtio_net_hash {
>>>>>> +       u32 value;
>>>>>> +       u16 report;
>>>>>> +};
>>>>>> +
>>>>>> +struct virtio_net_toeplitz_state {
>>>>>> +       u32 hash;
>>>>>> +       const u32 *key;
>>>>>> +};
>>>>>> +
>>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>>>> +
>>>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>>>>>> +
>>>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>>>>>> +{
>>>>>> +       while (len >= sizeof(*input)) {
>>>>>> +               *input = be32_to_cpu((__force __be32)*input);
>>>>>> +               input++;
>>>>>> +               len -= sizeof(*input);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>>>>>> +                                           const __be32 *input, size_t len)
>>>>>> +{
>>>>>> +       while (len >= sizeof(*input)) {
>>>>>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>>>>>> +                       u32 i = ffs(map);
>>>>>> +
>>>>>> +                       state->hash ^= state->key[0] << (32 - i) |
>>>>>> +                                      (u32)((u64)state->key[1] >> i);
>>>>>> +               }
>>>>>> +
>>>>>> +               state->key++;
>>>>>> +               input++;
>>>>>> +               len -= sizeof(*input);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
>>>>>> +{
>>>>>> +       size_t len = 0;
>>>>>> +
>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>>>>>> +               len = max(len,
>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>>>>>> +
>>>>>> +       if (types &
>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>>>>>> +               len = max(len,
>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>> +
>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>>>>>> +               len = max(len,
>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>>>>>> +
>>>>>> +       if (types &
>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>>>>>> +               len = max(len,
>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>> +
>>>>>> +       return len + sizeof(u32);
>>>>>> +}
>>>>>> +
>>>>>> +static inline u32 virtio_net_hash_report(u32 types,
>>>>>> +                                        const struct flow_keys_basic *keys)
>>>>>> +{
>>>>>> +       switch (keys->basic.n_proto) {
>>>>>> +       case cpu_to_be16(ETH_P_IP):
>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>>>>>> +
>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>>>>>> +               }
>>>>>> +
>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>>>>>> +
>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>> +
>>>>>> +       case cpu_to_be16(ETH_P_IPV6):
>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>>>>>> +
>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>>>>>> +               }
>>>>>> +
>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>>>>>> +
>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>> +
>>>>>> +       default:
>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>>>>>> +                                      u32 types, const u32 *key,
>>>>>> +                                      struct virtio_net_hash *hash)
>>>>>> +{
>>>>>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>>>>>> +       struct flow_keys flow;
>>>>>> +       struct flow_keys_basic flow_basic;
>>>>>> +       u16 report;
>>>>>> +
>>>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>> +               return;
>>>>>> +       }
>>>>>> +
>>>>>> +       flow_basic = (struct flow_keys_basic) {
>>>>>> +               .control = flow.control,
>>>>>> +               .basic = flow.basic
>>>>>> +       };
>>>>>> +
>>>>>> +       report = virtio_net_hash_report(types, &flow_basic);
>>>>>> +
>>>>>> +       switch (report) {
>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>> +               break;
>>>>>> +
>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>> +               break;
>>>>>> +
>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>> +               break;
>>>>>> +
>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>> +               break;
>>>>>> +
>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>> +               break;
>>>>>> +
>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>> +               break;
>>>>>> +
>>>>>> +       default:
>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>> +               return;
>>>>>
>>>>> So I still think we need a comment here to explain why this is not an
>>>>> issue if the device can report HASH_XXX_EX. Or we need to add the
>>>>> support, since this is the code from the driver side, I don't think we
>>>>> need to worry about the device implementation issues.
>>>>
>>>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
>>>>
>>>>>
>>>>> For the issue of the number of options, does the spec forbid fallback
>>>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
>>>>
>>>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
>>>>    > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>>>    > header, the hash is calculated over the following fields:
>>>>    > - Home address from the home address option in the IPv6 destination
>>>>    >   options header. If the extension header is not present, use the
>>>>    >   Source IPv6 address.
>>>>    > - IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>    >   associated extension header. If the extension header is not present,
>>>>    >   use the Destination IPv6 address.
>>>>    > - Source TCP port
>>>>    > - Destination TCP port
>>>>
>>>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6
>>>> and an home address option in the IPv6 destination options header is
>>>> present, the hash is calculated over the home address. If the hash is
>>>> not calculated over the home address in such a case, the device is
>>>> contradicting with this section and violating the spec. The same goes
>>>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
>>>
>>> Just to make sure we are one the same page. I meant:
>>>
>>> 1) If the hash is not calculated over the home address (in the case of
>>> IPv6 destination destination), it can still report
>>> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
>>> series. So the device can simply fallback to e.g TCPv6 if it can't
>>> understand all or part of the IPv6 options.
>>
>> The spec says it can fallback if "the extension header is not present",
>> not if the device can't understand the extension header.
> 
> I don't think so,
> 
> 1) spec had a condition beforehand:
> 
> """
> If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
> header, the hash is calculated over the following fields:
> ...
> If the extension header is not present ...
> """
> 
> So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
> spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...
> 
> 2) implementation wise, since device has limited resources, we can't
> expect the device can parse arbitrary number of ipv6 options
> 
> 3) if 1) and 2) not the case, we need fix the spec otherwise implement
> a spec compliant device is impractical

The statement is preceded by the following:
 >  The device calculates the hash on IPv4 packets according to
 > ’Enabled hash types’ bitmask as follows:

The 'Enabled hash types' bitmask is specified by the device.

I think the spec needs amendment.

I wonder if there are any people interested in the feature though. 
Looking at virtnet_set_hashflow() in drivers/net/virtio_net.c, the 
driver of Linux does not let users configure HASH_TYPE_XXX_EX. I suppose 
Windows supports HASH_TYPE_XXX_EX, but those who care network 
performance most would use Linux so HASH_TYPE_XXX_EX support without 
Linux driver's support may not be useful.

> 
>>
>>> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
>>> tun_vnet_ioctl_sethash(), so userspace may set
>>> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
>>> tun_vnet_ioctl_gethashtypes(). In this case they won't get
>>> VIRTIO_NET_HASH_TYPE_TCP_EX.
>>
>> That's right. It's the responsibility of the userspace to set only the
>> supported hash types.
> 
> Well, the kernel should filter out the unsupported one to have a
> robust uAPI. Otherwise, we give green light to the buggy userspace
> which will have unexpected results.

My reasoning was that it may be fine for some use cases other than VM 
(e.g., DPDK); in such a use case, it is fine as long as the UAPI works 
in the best-effort basis.

For example, suppose a userspace program that processes TCP packets; the 
program can enable: HASH_TYPE_IPv4, HASH_TYPE_TCPv4, HASH_TYPE_IPv6, and 
HASH_TYPE_TCPv6. Ideally, the kernel should support all the hash types, 
but, even if e.g., HASH_TYPE_TCPv6 is not available, it will fall back 
to HASH_TYPE_IPv6, which still does something good and may be acceptable.

That said, for a use case that involves VM and implements virtio-net 
(e.g., QEMU), setting an unsupported hash type here is definitely a bug. 
Catching the bug may outweigh the extra trouble for other use cases.

> 
>>
>>> 3) implementing part of the hash types might complicate the migration
>>> or at least we need to describe the expectations of libvirt or other
>>> management in this case. For example, do we plan to have a dedicated
>>> Qemu command line like:
>>>
>>> -device virtio-net-pci,hash_report=on,supported_hash_types=X,Y,Z?
>>
>> I posted a patch series to implement such a command line for vDPA[1].
>> The patch series that wires this tuntap feature up[2] reuses the
>> infrastructure so it doesn't bring additional complexity.
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@daynix.com/
>> [2]
>> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@daynix.com/
> 
> I meant, if we implement a full hash report feature, it means a single
> hash cmdline option is more than sufficient and so compatibility code
> can just turn it off when dealing with machine types. This is much
> more simpler than
> 
> 1) having both hash as well as supported_hash_features
> 2) dealing both hash as well as supported_hash_features in compatibility codes
> 3) libvirt will be happy
> 
> For [1], it seems it introduces a per has type option, this seems to
> be a burden to the management layer as it need to learn new option
> everytime a new hash type is supported

Even with the command line you proposed (supported_hash_types=X,Y,Z), it 
is still necessary to know the values the supported_hash_types property 
accepts (X.Y,Z), so I don't think it makes difference.

The burden to the management layer is already present for features, so 
it is an existing problem (or its mere extension).

This problem was discussed in the following thread in the past, but no 
solution is implemented yet, and probably solving it will be difficult.
https://lore.kernel.org/qemu-devel/20230731223148.1002258-5-yuri.benditovich@daynix.com/

Regards,
Akihiko Odaki

