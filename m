Return-Path: <linux-kselftest+bounces-28693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE8A5B89C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 06:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F723AE795
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6D1EBFED;
	Tue, 11 Mar 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1y8hTduw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EE18E2A
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672171; cv=none; b=Z2CTM8Sxngf5ueirATRLH7KLwpYsnFIAxrtKD6uqrYDWDgrnaLvsz274mgrr+5SAXDYcfx6OitQmboiUu040cahWHOCnRgegVd7O+kHsdVtmhKymJPqiy20I+a05Zy6/cPQ6c+1HW7+6ElRj51nTalhsOstVVtpKMYYQniM4rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672171; c=relaxed/simple;
	bh=F0Rf3FYUQ4Wxm8G4IbbPPXs7ZUEyikrp1sTNtvxY1TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzkq662P+hMEqHaTcifBDT11Z1jp9LSYCJCufwExD3fnjY1if8yeD1/TOf6lDIjJQE+e3E0cJ4cteySiA7EUFnmaHcOPxZQbdjKpRCt49qNDJ5FK2JuLI5Xr6cQB+RWc7N2W6tEsq017DXie6/DCl0fSxhyNrSJGrWls/LMMAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1y8hTduw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so60287245ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741672168; x=1742276968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv/1UMDvxFGMa83/OozIAgX6ye/3HLjoIobJiWrJB+0=;
        b=1y8hTduwqzahO7hK1NoyChMnPRx9MNMEgsL31wF4OdOzOc1oN0Gj/LCeLH7pAusHIB
         O9fmDA9vHUgsAA0WLOd4uBoDmBYg0TbJKHnc/i/Ps3aiJKHvbuu88Igerw0si5CpGUfZ
         XrBLowdrUZudXIuI30Mz/daG1hYC2tZEK3QTWJQplJB7Kpn0v1K/b7K5jfnKZGkMOBan
         K8eo/kgTCfhJ+aTliORkfjGXK7S9i3NoIPFuW9gBC9JIpUOemE8YLdBfwrFwscI+zpSL
         /zLs7jdWPpEcuvPr1SPjX1enNf/roQEizRPAdBqWaU32LB8BVxkHxQcKuxkOQi4FVaCi
         BIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672168; x=1742276968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xv/1UMDvxFGMa83/OozIAgX6ye/3HLjoIobJiWrJB+0=;
        b=VAqt+4UkDtOfazn0er5q7+vCKdT29X/mACgq89+w5WaQRtm73rb9Twt/PBH6xqUqdf
         JsdBPTWUxKzFPcRfwzXE83MB/gRgZhWt+jzRApc12ur8kKcyBOVrmA1gkU0138D5ChyR
         +LscptmGyBESkImvHxBt+ctMXEMIAETJuY5QZov9A5dktCTkjH+yqGPS8XN1gXL089gZ
         rDJtGhJIHp7KkVBYJ9dofZDuE2Z8IadabHKAqQtMECs1X+yJYTEzRPWXFXO6ok36X22g
         we+sj+G0gaITQJ0zSE6d2OsQWAN5rvf+zf/Da7xs5UsA5Zd7HgTBVX+hNxE36qtM/DPw
         M/6g==
X-Forwarded-Encrypted: i=1; AJvYcCVbjIb4N9firxQG5gTXOpU4NC9jAu0i7JOl86mojZS34QF3HTPu0izBipMB3Lj/TcPDXhYz8IwdYWSdkSgUmFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVP2VJe3/OrYcuGz/WSVGDsohUJk1V3zVhxdt7zgvlcEDqclOf
	w2E1Zl2sa7ag71Cf8VTfUx7lGsN2HbYtr1fE9k1t3UZDXkEdbljaPRSbmJ9d2tI=
X-Gm-Gg: ASbGnctw3y9nOO5pN/YXc6ERt5lEAyTF9j6y6U186TByPf3I7BmzsnwlnLkF2zmcjgY
	GuDxQn32BSFfCehom+yD1BJx334nesCBWYN8jk0o28FXRkP4+M5yri1PEnqYVvLWCwO/Z1d6/Vb
	xaqNm4t5VzndBI33yMazOiM6o9grrvispBHhEsDeIU39802atIyF+/NVlA+INcqXP97s/AaNQ5p
	NNq5+EycwlqVpiSAl/gKuh4KygZbnYstiG1CQqmwTI8r9cgiYn5vE7vIfrOHjO1kxl7CyYlzoHj
	lcJB/7vAJMRd7PcIgIq+UfM96O2QyDO83Baq9IaDCEKC6ZBMSEhXuM5pqg==
X-Google-Smtp-Source: AGHT+IFuMVZsqL3GM6lkFEYs2nSoWXK5nAJqtoL5n+wXoTsRqEscx8eUNzKeTyS2qcid35nO5n+Mtw==
X-Received: by 2002:a17:903:2405:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22428bf3ac4mr265245865ad.52.1741672168519;
        Mon, 10 Mar 2025 22:49:28 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ff204sm88876015ad.104.2025.03.10.22.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 22:49:28 -0700 (PDT)
Message-ID: <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
Date: Tue, 11 Mar 2025 14:49:23 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/6] virtio_net: Add functions for hashing
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
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-1-df76624025eb@daynix.com>
 <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
 <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
 <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/11 9:47, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 2:53 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/10 12:55, Jason Wang wrote:
>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
>>>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
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
>>>
>>> Let's explain why
>>>
>>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>
>>> are missed here.
>>
>> Because they require parsing IPv6 options and I'm not sure how many we
>> need to parse. QEMU's eBPF program has a hard-coded limit of 30 options;
>> it has some explanation for this limit, but it does not seem definitive
>> either:
>> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
>>
> 
> How about the usersapce datapath RSS in Qemu? (We probably don't need
> to align with eBPF RSS as it's just a reference implementation)

The userspace datapath RSS has no limit.

The reference implementation is the userspace datapath. The eBPF program 
  is intended to bring real performance benefit to Windows guests in 
contrary.

The userspace implementation does its best to provide defined RSS 
capabilities but may not be performant. Parsing all IPv6 options have a 
performance implication, but it is fine because it is not intended to be 
performant in the first place.

The performance problem is inherent to the userspace implementation, 
which adds an extra overhead to the datapath. The eBPF program on the 
other hand does not incur such overhead because it replaces the existing 
steering algorithm (automq) instead of adding another layer. Hence the 
eBPF program can be practical.

That said, it is not that important to align with the userspace and eBPF 
RSS in QEMU because they are still experimental anyway; the eBPF RSS has 
potential to become a practical implementation but it is still in 
development. The libvirt integration for the eBPF RSS is still not 
complete, and we occasionally add fixes for RSS and hash reporting 
without backporting to the stable branch.

I'm adding interfaces to negotiate hash types rather for the future 
extensibility. The specification may gain more hash types in the future 
and other vhost backends may have a different set of hash types 
supported. Figuring out how to deal with different sets of supported 
hash typs is essential for both the kernel and QEMU.

> 
>> In this patch series, I add an ioctl to query capability instead; it
>> allows me leaving those hash types unimplemented and is crucial to
>> assure extensibility for future additions of hash types anyway. Anyone
>> who find these hash types useful can implement in the future.
> 
> Yes, but we need to make sure no userspace visible behaviour changes
> after migration.

Indeed, the goal is to make extensibility and migration compatible.

> 
>>
>>>
>>> And explain how we could maintain migration compatibility
>>>
>>> 1) Does those three work for userspace datapath in Qemu? If yes,
>>> migration will be broken.
>>
>> They work for userspace datapath so my RFC patch series for QEMU uses
>> TUNGETVNETHASHCAP to prevent breaking migration:
>> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>>
> 
> Ok, let's mention this in the cover letter. Another interesting thing
> is the migration from 10.0 to 9.0.

The patch series is already mentioned in the cover letter. A description 
of the intended use case of TUNGETVNETHASHCAP will be a good addition. 
I'll add it to this patch so that it will be kept in tree after it gets 
merged.

Migration between two different QEMU versions should be handled with 
versioned machine types.

When a machine created in 9.0 is being migrated to 10.0, the machine 
must set the hash type properties to match with the hash types supported 
by the existing implementations, which means it sets the property for 
VIRTIO_NET_HASH_REPORT_IPv6_EX to true, for example. Because this hash 
type is currently not included in TUNGETVNETHASHCAP, the machine will 
keep using the implementation used previously. The machine can be also 
migrated back to 9.0 again.

A machine type with version 10.0 cannot be migrated to 9.0 by design so 
there is no new problem.

> 
>> This patch series first adds configuration options for users to choose
>> hash types. QEMU then automatically picks one implementation from the
>> following (the earlier one is the more preferred):
>> 1) The hash capability of vhost hardware
>> 2) The hash capability I'm proposing here
>> 3) The eBPF program
>> 4) The pure userspace implementation
>>
>> This decision depends on the following:
>> - The required hash types; supported ones are queried for 1) and 2)
>> - Whether vhost is enabled or not and what vhost backend is used
>> - Whether hash reporting is enabled; 3) is incompatible with this
>>
>> The network device will not be realized if no implementation satisfies
>> the requirements.
> 
> This makes sense, let's add this in the cover letter.

I'll add it to the QEMU patch as it's more about details of QEMU.
The message of this patch will explain how TUNGETVNETHASHCAP and 
TUNSETVNETHASH makes extensibility and migrattion compatible in general.

Regards,
Akihiko Odaki

> 
>>
>>> 2) once we support those three in the future. For example, is the qemu
>>> expected to probe this via TUNGETVNETHASHCAP in the destination and
>>> fail the migration?
>>
>> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable
>> hash types with TUNSETVNETHASH to keep migration working.
>>
>> In summary, this patch series provides a sufficient facility for the
>> userspace to make extensibility and migration compatible;
>> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
>> TUNSETVNETHASH allows the userspace to limit them.
>>
>> Regards,
>> Akihiko Odaki
> 
> Fine.
> 
> Thanks
> 
>>
>>>
>>> Thanks
>>>
>>>
>>>
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
>>>> +       }
>>>> +
>>>> +       hash->value = toeplitz_state.hash;
>>>> +       hash->report = report;
>>>> +}
>>>> +
>>>>    static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>>>>    {
>>>>           switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>>>>
>>>> --
>>>> 2.48.1
>>>>
>>>
>>
> 


