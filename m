Return-Path: <linux-kselftest+bounces-35536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788AAE2789
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 07:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036AB17CC13
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1131465A1;
	Sat, 21 Jun 2025 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="WE6DGVDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34094A23
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Jun 2025 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750485069; cv=none; b=noHAvFgFKYHu2X3V7a4Ng60d5oT6/58pOhjcRCplMr6rVtw0E8Ng8K35UUohziQ4SojRKL7f/jZ7hkE1TNAwmk2bhhGSowUn1I0HU8JnFS/8LAl2eFJKDZsf901v8c2u3BKYC5ywuGa2UtHqWNlDuDx4EiPCPfdJc+EitE06PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750485069; c=relaxed/simple;
	bh=yDT/id80xXeSNUY2YnDvyX6LqrVThfFRKdke6aNn2sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ9YK9pFtj1j6GzVkW+ET1zOg2iwdoSqPthdPjJTIG0UbfSVNFRHIlEsjgUFJayFygiBVJ3CTrdekYo3OgoPlxPAgUSMm5J3kJPGT57kBQZzEqKQ61Ho3bw1+85bfnSHIrYk6ILL1XFgAJgqDdRaX5yxnswvu3Nj5ZY3S+RFXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=WE6DGVDQ reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Received: from [192.168.201.189] (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L5p0jB005414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Jun 2025 14:51:01 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OBeZnHpZcIGUg/hF3jTcQ+fWKeDSdyDwRz+D01G6y+A=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:Subject:To:From;
        s=rs20250326; t=1750485064; v=1;
        b=WE6DGVDQvlAoWlsHW/22GjO58JD90b80+lvi81trD9Vir3tfETOhvySytiITGv0f
         t41DA/O48WNm1J3aqgU2EkqLu+hc9dz2mcOcevbnoUOnNLEv5wyFsS6NPQYXCbjw
         E1JMYF+h9reZyQ8j5tTpESO1SJ9oRVdWaxdvviFaYv8SBtnErXETqa0pJ6f3lpxW
         5YUIanTLcKSGl8xyXENRz7f7/as1ai+5MAvE51T4Rso6Aw38uhWME6F6LL5QRRuj
         z9+zTE0ndJxZpb8iXiVPKw23kZjIb0+kPWkqyZ90v/TOPRACHEWQqAadxKbWTE7W
         flU5Z5utNxBCwe/ecjLufw==
Message-ID: <a293b858-cbdd-436f-b3c7-389f8cbebf47@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 14:50:54 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org,
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
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com>
 <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com>
 <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/17 12:28, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 5:10 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/06/06 9:48, Jason Wang wrote:
>>> On Thu, Jun 5, 2025 at 3:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/06/05 10:53, Jason Wang wrote:
>>>>> On Wed, Jun 4, 2025 at 3:20 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/06/04 10:18, Jason Wang wrote:
>>>>>>> On Tue, Jun 3, 2025 at 1:31 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2025/06/03 12:19, Jason Wang wrote:
>>>>>>>>> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>>>>>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>       include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>       1 file changed, 188 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>>>>>>>> index 02a9f4dc594d..426f33b4b824 100644
>>>>>>>>>> --- a/include/linux/virtio_net.h
>>>>>>>>>> +++ b/include/linux/virtio_net.h
>>>>>>>>>> @@ -9,6 +9,194 @@
>>>>>>>>>>       #include <uapi/linux/tcp.h>
>>>>>>>>>>       #include <uapi/linux/virtio_net.h>
>>>>>>>>>>
>>>>>>>>>> +struct virtio_net_hash {
>>>>>>>>>> +       u32 value;
>>>>>>>>>> +       u16 report;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +struct virtio_net_toeplitz_state {
>>>>>>>>>> +       u32 hash;
>>>>>>>>>> +       const u32 *key;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>>>>>>>> +
>>>>>>>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>>>>>>>>>> +
>>>>>>>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>>>>>>>>>> +{
>>>>>>>>>> +       while (len >= sizeof(*input)) {
>>>>>>>>>> +               *input = be32_to_cpu((__force __be32)*input);
>>>>>>>>>> +               input++;
>>>>>>>>>> +               len -= sizeof(*input);
>>>>>>>>>> +       }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>>>>>>>>>> +                                           const __be32 *input, size_t len)
>>>>>>>>>> +{
>>>>>>>>>> +       while (len >= sizeof(*input)) {
>>>>>>>>>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>>>>>>>>>> +                       u32 i = ffs(map);
>>>>>>>>>> +
>>>>>>>>>> +                       state->hash ^= state->key[0] << (32 - i) |
>>>>>>>>>> +                                      (u32)((u64)state->key[1] >> i);
>>>>>>>>>> +               }
>>>>>>>>>> +
>>>>>>>>>> +               state->key++;
>>>>>>>>>> +               input++;
>>>>>>>>>> +               len -= sizeof(*input);
>>>>>>>>>> +       }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
>>>>>>>>>> +{
>>>>>>>>>> +       size_t len = 0;
>>>>>>>>>> +
>>>>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>>>>>>>>>> +               len = max(len,
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>>>>>>>>>> +
>>>>>>>>>> +       if (types &
>>>>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>>>>>>>>>> +               len = max(len,
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>>>>>> +
>>>>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>>>>>>>>>> +               len = max(len,
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>>>>>>>>>> +
>>>>>>>>>> +       if (types &
>>>>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>>>>>>>>>> +               len = max(len,
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>>>>>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>>>>>> +
>>>>>>>>>> +       return len + sizeof(u32);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline u32 virtio_net_hash_report(u32 types,
>>>>>>>>>> +                                        const struct flow_keys_basic *keys)
>>>>>>>>>> +{
>>>>>>>>>> +       switch (keys->basic.n_proto) {
>>>>>>>>>> +       case cpu_to_be16(ETH_P_IP):
>>>>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>>>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>>>>>>>>>> +
>>>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>>>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>>>>>>>>>> +               }
>>>>>>>>>> +
>>>>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>>>>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>>>>>>>>>> +
>>>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>>>> +
>>>>>>>>>> +       case cpu_to_be16(ETH_P_IPV6):
>>>>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>>>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>>>>>>>>>> +
>>>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>>>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>>>>>>>>>> +               }
>>>>>>>>>> +
>>>>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>>>>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>>>>>>>>>> +
>>>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>>>> +
>>>>>>>>>> +       default:
>>>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>>>> +       }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>>>>>>>>>> +                                      u32 types, const u32 *key,
>>>>>>>>>> +                                      struct virtio_net_hash *hash)
>>>>>>>>>> +{
>>>>>>>>>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>>>>>>>>>> +       struct flow_keys flow;
>>>>>>>>>> +       struct flow_keys_basic flow_basic;
>>>>>>>>>> +       u16 report;
>>>>>>>>>> +
>>>>>>>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>>>>>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>>>> +               return;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       flow_basic = (struct flow_keys_basic) {
>>>>>>>>>> +               .control = flow.control,
>>>>>>>>>> +               .basic = flow.basic
>>>>>>>>>> +       };
>>>>>>>>>> +
>>>>>>>>>> +       report = virtio_net_hash_report(types, &flow_basic);
>>>>>>>>>> +
>>>>>>>>>> +       switch (report) {
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>>>> +               break;
>>>>>>>>>> +
>>>>>>>>>> +       default:
>>>>>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>>>> +               return;
>>>>>>>>>
>>>>>>>>> So I still think we need a comment here to explain why this is not an
>>>>>>>>> issue if the device can report HASH_XXX_EX. Or we need to add the
>>>>>>>>> support, since this is the code from the driver side, I don't think we
>>>>>>>>> need to worry about the device implementation issues.
>>>>>>>>
>>>>>>>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> For the issue of the number of options, does the spec forbid fallback
>>>>>>>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
>>>>>>>>
>>>>>>>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
>>>>>>>>      > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>>>>>>>      > header, the hash is calculated over the following fields:
>>>>>>>>      > - Home address from the home address option in the IPv6 destination
>>>>>>>>      >   options header. If the extension header is not present, use the
>>>>>>>>      >   Source IPv6 address.
>>>>>>>>      > - IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>>>>>      >   associated extension header. If the extension header is not present,
>>>>>>>>      >   use the Destination IPv6 address.
>>>>>>>>      > - Source TCP port
>>>>>>>>      > - Destination TCP port
>>>>>>>>
>>>>>>>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6
>>>>>>>> and an home address option in the IPv6 destination options header is
>>>>>>>> present, the hash is calculated over the home address. If the hash is
>>>>>>>> not calculated over the home address in such a case, the device is
>>>>>>>> contradicting with this section and violating the spec. The same goes
>>>>>>>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
>>>>>>>
>>>>>>> Just to make sure we are one the same page. I meant:
>>>>>>>
>>>>>>> 1) If the hash is not calculated over the home address (in the case of
>>>>>>> IPv6 destination destination), it can still report
>>>>>>> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
>>>>>>> series. So the device can simply fallback to e.g TCPv6 if it can't
>>>>>>> understand all or part of the IPv6 options.
>>>>>>
>>>>>> The spec says it can fallback if "the extension header is not present",
>>>>>> not if the device can't understand the extension header.
>>>>>
>>>>> I don't think so,
>>>>>
>>>>> 1) spec had a condition beforehand:
>>>>>
>>>>> """
>>>>> If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>>>> header, the hash is calculated over the following fields:
>>>>> ...
>>>>> If the extension header is not present ...
>>>>> """
>>>>>
>>>>> So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
>>>>> spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...
>>>>>
>>>>> 2) implementation wise, since device has limited resources, we can't
>>>>> expect the device can parse arbitrary number of ipv6 options
>>>>>
>>>>> 3) if 1) and 2) not the case, we need fix the spec otherwise implement
>>>>> a spec compliant device is impractical
>>>>
>>>> The statement is preceded by the following:
>>>>    >  The device calculates the hash on IPv4 packets according to
>>>>    > ’Enabled hash types’ bitmask as follows:
>>>>
>>>> The 'Enabled hash types' bitmask is specified by the device.
>>>>
>>>> I think the spec needs amendment.
>>>
>>> Michael, can you help to clarify here?
>>>
>>>>
>>>> I wonder if there are any people interested in the feature though.
>>>> Looking at virtnet_set_hashflow() in drivers/net/virtio_net.c, the
>>>> driver of Linux does not let users configure HASH_TYPE_XXX_EX. I suppose
>>>> Windows supports HASH_TYPE_XXX_EX, but those who care network
>>>> performance most would use Linux so HASH_TYPE_XXX_EX support without
>>>> Linux driver's support may not be useful.
>>>
>>> It might be still interesting for example for the hardware virtio
>>> vendors to support windows etc.
>>
>> I don't know if Windows needs them for e.g., device/driver certification
>> so surveying Windows makes sense.
> 
> Yuri, can you help to clarify this?
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
>>>>>>> tun_vnet_ioctl_sethash(), so userspace may set
>>>>>>> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
>>>>>>> tun_vnet_ioctl_gethashtypes(). In this case they won't get
>>>>>>> VIRTIO_NET_HASH_TYPE_TCP_EX.
>>>>>>
>>>>>> That's right. It's the responsibility of the userspace to set only the
>>>>>> supported hash types.
>>>>>
>>>>> Well, the kernel should filter out the unsupported one to have a
>>>>> robust uAPI. Otherwise, we give green light to the buggy userspace
>>>>> which will have unexpected results.
>>>>
>>>> My reasoning was that it may be fine for some use cases other than VM
>>>> (e.g., DPDK); in such a use case, it is fine as long as the UAPI works
>>>> in the best-effort basis.
>>>
>>> Best-effort might increase the chance for user visisable changes after
>>> migration.
>>
>> It is a trade-off between catching a migration bug for VMM and making
>> life a bit easier for userspace programs other than VMM.
> 
> My understanding is to avoid breaking the migration compatibility as
> much as possible as fixing that would be complicated or even
> impossible.

That makes a point.

> 
>>
>>>
>>>>
>>>> For example, suppose a userspace program that processes TCP packets; the
>>>> program can enable: HASH_TYPE_IPv4, HASH_TYPE_TCPv4, HASH_TYPE_IPv6, and
>>>> HASH_TYPE_TCPv6. Ideally, the kernel should support all the hash types,
>>>> but, even if e.g., HASH_TYPE_TCPv6 is not available,
>>>
>>> For "available" did you mean it is not supported by the device?
>>>
>>>> it will fall back
>>>> to HASH_TYPE_IPv6, which still does something good and may be acceptable.
>>>
>>> This fallback is exactly the same as I said above, let
>>> VIRTIO_NET_HASH_TYPE_TCP_EX to fallback.
>>>
>>> My point is that, the implementation should either:
>>>
>>> 1) allow fallback so it can claim to support all hash types
>>>
>>> or
>>>
>>> 2) don't allow fallback so it can only support a part of the hash types
>>>
>>> If we're doing something in the middle, for example, allow part of the
>>> type to fallback.
>>
>> 1) or the middle will make it unsuitable for VM because it violates the
>> virtio spec. 2) makes sense though the trade-off I mentioned should be
>> taken into consideration.
>>
>>>
>>>>
>>>> That said, for a use case that involves VM and implements virtio-net
>>>> (e.g., QEMU), setting an unsupported hash type here is definitely a bug.
>>>> Catching the bug may outweigh the extra trouble for other use cases.
>>>>
>>>>>
>>>>>>
>>>>>>> 3) implementing part of the hash types might complicate the migration
>>>>>>> or at least we need to describe the expectations of libvirt or other
>>>>>>> management in this case. For example, do we plan to have a dedicated
>>>>>>> Qemu command line like:
>>>>>>>
>>>>>>> -device virtio-net-pci,hash_report=on,supported_hash_types=X,Y,Z?
>>>>>>
>>>>>> I posted a patch series to implement such a command line for vDPA[1].
>>>>>> The patch series that wires this tuntap feature up[2] reuses the
>>>>>> infrastructure so it doesn't bring additional complexity.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@daynix.com/
>>>>>> [2]
>>>>>> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@daynix.com/
>>>>>
>>>>> I meant, if we implement a full hash report feature, it means a single
>>>>> hash cmdline option is more than sufficient and so compatibility code
>>>>> can just turn it off when dealing with machine types. This is much
>>>>> more simpler than
>>>>>
>>>>> 1) having both hash as well as supported_hash_features
>>>>> 2) dealing both hash as well as supported_hash_features in compatibility codes
>>>>> 3) libvirt will be happy
>>>>>
>>>>> For [1], it seems it introduces a per has type option, this seems to
>>>>> be a burden to the management layer as it need to learn new option
>>>>> everytime a new hash type is supported
>>>>
>>>> Even with the command line you proposed (supported_hash_types=X,Y,Z), it
>>>> is still necessary to know the values the supported_hash_types property
>>>> accepts (X.Y,Z), so I don't think it makes difference.
>>>
>>> It could be a uint32_t.
>>
>> The management layer will need to know what bits are accepted even with
>> uint32_t.
> 
> Ease the management, basically it would be used by debugging or
> machine type only.

Users need to be able to specify hash types for the reasons same with 
virtio features (via domain XML for libvirt). In particular:

1) To ensure migration compatibility in case that hosts have different 
sets of supported hash types. This kind of situation can happen when 
vDPA devices have different capabilities or when the spec gains new hash 
types and a new version of kernel/tuntap starts to support it.

2) For debugging as you mentioned.

It makes sense to let users specify hash types with mnemonics instead of 
cryptic bitmasks. 2) is not an end-user requirement so it may be 
tolerable to expose bitmasks, but it is less so for 1). The management 
layer needs to have a list of hash types to support mnemonics whether 
QOM properties are uint32_t or not.

We can have an interface different from the one for features without 
worrying about backward compatibility, but this aspect of hash types is 
exactly same with features and does not motivate to do so.

Regards,
Akihiko Odaki

> 
>>
>>>
>>>>
>>>> The burden to the management layer is already present for features, so
>>>> it is an existing problem (or its mere extension).
>>>
>>> Yes, but since this feature is new it's better to try our best to avoid that.
>>>
>>>>
>>>> This problem was discussed in the following thread in the past, but no
>>>> solution is implemented yet, and probably solving it will be difficult.
>>>> https://lore.kernel.org/qemu-devel/20230731223148.1002258-5-yuri.benditovich@daynix.com/
>>>
>>> It's a similar issue but not the same, it looks more like a discussion
>>> on whether the fallback from vhost-net to qemu works for missing
>>> features etc.
>>
>> Perhaps we may be able to do better since this feature is new as you say
>> and we don't have to worry much about breaking change. I don't have an
>> idea for that yet.
> 
> Right.
> 
>>
>> Regards,
>> Akihiko Odaki
>>
> 
> Thanks
> 


