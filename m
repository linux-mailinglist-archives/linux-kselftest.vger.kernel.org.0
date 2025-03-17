Return-Path: <linux-kselftest+bounces-29176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E05A640C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580E53A5684
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6621507F;
	Mon, 17 Mar 2025 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZXnix3xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A27215047
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191713; cv=none; b=XMMi6mbnPdHXX3x+i6eTwVNwZzhGXDJavpHHeCrc9UB+2RQyiZlOGuPZfXh73BL7wLwSxmK/FKaM2hB7oU0t/uFJZksp9YAOGTZyRzdOFnVVTQvlTxCXGifxfGUe1wIouWRwym1v71ImAhFouxSPnBFJ4jkdqGbF8ilZnfTjq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191713; c=relaxed/simple;
	bh=IvNJR1CXhaIBt4hzQw1toiWztLSbiCGrla6GsFJVXKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H56UXv5qUJrga6uKgaO+EKGz8v2q0aLXjfYvytthWk0uYvLjfrzPRdD5GEz4m09uqt8IN1qFZN5TMUmEhi9uZWbmwuaZElx0OqOTZKb6cQwnrMqQxMmIyz7OAnc615O/TtNlK90PtLtRwv7xHBA0rQXsnBYCiP+X16caMxf9Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZXnix3xq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22580c9ee0aso66347695ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Mar 2025 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742191710; x=1742796510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBWUop9hBNztgWdtuzQCjGkKpdUlBMvpymPGtusXugE=;
        b=ZXnix3xqLhmLeuRaXUeLmZJ1HtEXgmIiQLNhkODhnfhql5OTtS3BXKoWljn8bhl21j
         LuMqVa6jkA/HEXBI37J5RBF1Jfz9oCMZXs/Ex5Lxjpeozu3Qet5vVCXFVcukU98abp01
         ouDrDEEeWbex/yMSFsVfMNWDaSNsD2xhWqgfsztZkqLRauXyRci7w+rZixrvSrhGlOLt
         FRXJp7BnMiidmf/GeAiXycCYrWv0BgIsZp8ECPKnDlqsl3DG4gem6+dKhrEVMUL0XFeA
         zYV1NnCdNu4pZvBazpNJQ9Eqwws2HTpepQE0CLk74R7HC+M9tLe8jyNwhuZcbEoDIgUq
         zNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191710; x=1742796510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBWUop9hBNztgWdtuzQCjGkKpdUlBMvpymPGtusXugE=;
        b=cGJU2UQ2nHIVV6k02aecpJoiTOgv33ZxtPHlII6yC7vLeU2sOt4pJxj2w1briRWplL
         2mmdqBDKYO6XnLIshV2PfCsTMi4QBr1VMkxywkhYQPosqdb7OfOrPMzsiuQbTTgBAhry
         pB5iX7QZyl+zlybIOlWynbXFiJPGkbrBjh96UlFZtkZYKP6cxJpobsgliqHawJqy/sx1
         ip+mhAlqad/aYtmazkAWf8lfaW38i3Sw15bZINWW3JLy6y0NG8OsCsrhEx0f2nq0t1X7
         56cftFe7lt7ykuCN6MgQkeA5gMPNdHOg/sS6zoXYwt0HRMIelmShCJ1rLQgUiO1TCYnS
         bXJg==
X-Forwarded-Encrypted: i=1; AJvYcCWNMWfeeK5REooGJkGu9fJfN6GWH0voHiu1m1INVH1TVh6SyhfJJBOokyLZgdn6J1O6nn5h5ZTXBVH1phw4lqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLXvPZmM/WTZql+pDmcwDP4c5i5nMXxDfll06gW9Tkyn8Rubk
	w5LDActLgJiMMCHRkYurSrUs7eh7cj2smVaIKTtsT2pKYB/bcMNFBber2kCvDjI=
X-Gm-Gg: ASbGnctoXh9rZLWHUi/PBoLptwv443N9XvnTYGlljxMySHHJLKI058bRgHMmVHeSWkD
	ICIubnGzH99y0ZMccwvc1wuMtUv9FJz1Khtgl4AvNNCLtdOsnCvTfZ0JJZ3DSvj677KWZAZJB+I
	sdzzMAYexzTP7nkav5fM2bSgsJYl48eedi5kxqPmuHQDP0gj1/FuSrLbUBD1VrQik9RRMtkoJSC
	3ohqHcPwMA1T0LJ336uoP0F6SSvIP0XzDG1uy1sB0bQRlvvDjfd1Ow/9J0ozGYbBNxZ9AZXE3/3
	Dn2YZeLcIWnJrx5FUxwdbQGRy/gxAoZNXzdWZi7pCnBUNrupp/X+PcAoyQ==
X-Google-Smtp-Source: AGHT+IGoQLPthZhSthgnNJ0I5Yj2jn7eld4kAuLi8jvyiFCGmV6WYXwPCIBZuiv2agvX1E5gEnyKQg==
X-Received: by 2002:a17:903:18e:b0:223:325c:89de with SMTP id d9443c01a7336-225e0a5282bmr127005685ad.1.1742191709771;
        Sun, 16 Mar 2025 23:08:29 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6dfesm67327865ad.71.2025.03.16.23.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 23:08:29 -0700 (PDT)
Message-ID: <cf4bf799-3a6e-44dc-96ca-fa8d616e6ba7@daynix.com>
Date: Mon, 17 Mar 2025 15:08:24 +0900
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
 <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
 <CACGkMEtapdjiXCPd1JZUF8JP3F1Ks-AtrbFBNGtORYnXPPrBEQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtapdjiXCPd1JZUF8JP3F1Ks-AtrbFBNGtORYnXPPrBEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/17 10:24, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 1:49 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/11 9:47, Jason Wang wrote:
>>> On Mon, Mar 10, 2025 at 2:53 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
>>>>>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
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
>>>>>
>>>>> Let's explain why
>>>>>
>>>>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>>>>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>>>>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>>>>>
>>>>> are missed here.
>>>>
>>>> Because they require parsing IPv6 options and I'm not sure how many we
>>>> need to parse. QEMU's eBPF program has a hard-coded limit of 30 options;
>>>> it has some explanation for this limit, but it does not seem definitive
>>>> either:
>>>> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
>>>>
>>>
>>> How about the usersapce datapath RSS in Qemu? (We probably don't need
>>> to align with eBPF RSS as it's just a reference implementation)
>>
>> The userspace datapath RSS has no limit.
>>
>> The reference implementation is the userspace datapath. The eBPF program
>>    is intended to bring real performance benefit to Windows guests in
>> contrary.
>>
>> The userspace implementation does its best to provide defined RSS
>> capabilities but may not be performant. Parsing all IPv6 options have a
>> performance implication, but it is fine because it is not intended to be
>> performant in the first place.
>>
>> The performance problem is inherent to the userspace implementation,
>> which adds an extra overhead to the datapath. The eBPF program on the
>> other hand does not incur such overhead because it replaces the existing
>> steering algorithm (automq) instead of adding another layer. Hence the
>> eBPF program can be practical.
>>
>> That said, it is not that important to align with the userspace and eBPF
>> RSS in QEMU because they are still experimental anyway; the eBPF RSS has
>> potential to become a practical implementation but it is still in
>> development. The libvirt integration for the eBPF RSS is still not
>> complete, and we occasionally add fixes for RSS and hash reporting
>> without backporting to the stable branch.
>>
>> I'm adding interfaces to negotiate hash types rather for the future
>> extensibility. The specification may gain more hash types in the future
>> and other vhost backends may have a different set of hash types
>> supported. Figuring out how to deal with different sets of supported
>> hash typs is essential for both the kernel and QEMU.
>>
>>>
>>>> In this patch series, I add an ioctl to query capability instead; it
>>>> allows me leaving those hash types unimplemented and is crucial to
>>>> assure extensibility for future additions of hash types anyway. Anyone
>>>> who find these hash types useful can implement in the future.
>>>
>>> Yes, but we need to make sure no userspace visible behaviour changes
>>> after migration.
>>
>> Indeed, the goal is to make extensibility and migration compatible.
> 
> So I see this part:
> 
> + uint32_t supported_hash_types = n->rss_data.supported_hash_types;
> + uint32_t peer_hash_types = n->rss_data.peer_hash_types;
> + bool use_own_hash =
> + (supported_hash_types & VIRTIO_NET_RSS_SUPPORTED_HASHES) ==
> + supported_hash_types;
> + bool use_peer_hash =
> + n->rss_data.peer_hash_available &&
> + (supported_hash_types & peer_hash_types) == supported_hash_types;
> 
> It looks like it would be a challenge to support vhost-user in the
> future if vhost-user supports hash feature others than source?

The vhost-user backend will need to retrieve the supported hash types 
with VHOST_USER_GET_CONFIG as the vhost-vdpa backend does with 
VHOST_VDPA_GET_CONFIG.

> 
>>
>>>
>>>>
>>>>>
>>>>> And explain how we could maintain migration compatibility
>>>>>
>>>>> 1) Does those three work for userspace datapath in Qemu? If yes,
>>>>> migration will be broken.
>>>>
>>>> They work for userspace datapath so my RFC patch series for QEMU uses
>>>> TUNGETVNETHASHCAP to prevent breaking migration:
>>>> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>>>>
>>>
>>> Ok, let's mention this in the cover letter. Another interesting thing
>>> is the migration from 10.0 to 9.0.
>>
>> The patch series is already mentioned in the cover letter. A description
>> of the intended use case of TUNGETVNETHASHCAP will be a good addition.
>> I'll add it to this patch so that it will be kept in tree after it gets
>> merged.
>>
>> Migration between two different QEMU versions should be handled with
>> versioned machine types.
>>
>> When a machine created in 9.0 is being migrated to 10.0, the machine
>> must set the hash type properties to match with the hash types supported
>> by the existing implementations, which means it sets the property for
>> VIRTIO_NET_HASH_REPORT_IPv6_EX to true, for example. Because this hash
>> type is currently not included in TUNGETVNETHASHCAP, the machine will
>> keep using the implementation used previously. The machine can be also
>> migrated back to 9.0 again.
>>
>> A machine type with version 10.0 cannot be migrated to 9.0 by design so
>> there is no new problem.
> 
> I meant migrate qemu 11.0 with machine type 10.0 to qemu 10.0 with
> machine 10.0 etc.

Let's assume QEMU 10.0 will support this new ioctl while QEMU 9.0 doesn't.

The description in my previous email was wrong. Checking the patch 
series again, I found I bumped the version number of 
vmstate_virtio_net_rss. So migrating QEMU 10.0 with machine type 9.0 to 
QEMU 9.0 will result in an error.

We can remove this error by introducing a compatibility property, but I 
don't think it's worth. As I noted in the previous email, the RSS 
feature is still in development and I don't think we need to support 
migrating to older QEMU versions. It gives an error instead of silently 
breaking a migrated VM at least.

Regards,
Akihiko Odaki

> 
>>
>>>
>>>> This patch series first adds configuration options for users to choose
>>>> hash types. QEMU then automatically picks one implementation from the
>>>> following (the earlier one is the more preferred):
>>>> 1) The hash capability of vhost hardware
>>>> 2) The hash capability I'm proposing here
>>>> 3) The eBPF program
>>>> 4) The pure userspace implementation
>>>>
>>>> This decision depends on the following:
>>>> - The required hash types; supported ones are queried for 1) and 2)
>>>> - Whether vhost is enabled or not and what vhost backend is used
>>>> - Whether hash reporting is enabled; 3) is incompatible with this
>>>>
>>>> The network device will not be realized if no implementation satisfies
>>>> the requirements.
>>>
>>> This makes sense, let's add this in the cover letter.
>>
>> I'll add it to the QEMU patch as it's more about details of QEMU.
>> The message of this patch will explain how TUNGETVNETHASHCAP and
>> TUNSETVNETHASH makes extensibility and migrattion compatible in general.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>>
>>>>> 2) once we support those three in the future. For example, is the qemu
>>>>> expected to probe this via TUNGETVNETHASHCAP in the destination and
>>>>> fail the migration?
>>>>
>>>> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable
>>>> hash types with TUNSETVNETHASH to keep migration working.
>>>>
>>>> In summary, this patch series provides a sufficient facility for the
>>>> userspace to make extensibility and migration compatible;
>>>> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
>>>> TUNSETVNETHASH allows the userspace to limit them.
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>
>>> Fine.
>>>
>>> Thanks
>>>
> 
> Thanks
> 


