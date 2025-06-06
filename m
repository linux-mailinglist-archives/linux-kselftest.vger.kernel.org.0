Return-Path: <linux-kselftest+bounces-34418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1DACFEDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F6E169C64
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67D28641D;
	Fri,  6 Jun 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="TKbGWbGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8582857DE
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201044; cv=none; b=k1t/wD6gNS4Q4F4EDPsoJcER+iEp2WKW+uIj1T0ljfNYfj+IXMUsmNcUc0PbLU7Pm85SE+n+a/HHy4j65FE1vaHxQyuIzvoxJ/bAIly4G2AYt0D8rM+TIws2Hq5pE43fbVyKlwe7w67XXI0cEJ15ioglssIr5Pv/WH/xUzbMZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201044; c=relaxed/simple;
	bh=qFqiywumDiUWGV3Qfzn/WEVxuj/1r6hmuUTtj1s/LWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvFaTzy3JehotySmgqVeCvKzS/HV36vjy4bUXjKWMjGOZNz43qZG8hpdMMzSeR3eMaRjDOzhZbo6yfoS48HhWpTVRqRJ1k+6m9OQsR2943Xvkv8/7KrcCASvrpQZEcEh+b2b1Zlh9+iLdFEvraWlBoqxGpyo5CLzkgAhE9nTfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=TKbGWbGw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ef62066eso25252365ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Jun 2025 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749201041; x=1749805841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=II529LrSfBKzf5rw6Q8oPjlQDiZcIOucONyjTvW4SOU=;
        b=TKbGWbGwIkDuXmn0mHKj+nAS3rmGjUC9z1m9y+BtlD43+8cmCCRAyO0pMkThcSxvpw
         u/7PzaJZsFEj2HCtAM0iZ/H3T6XO5FrYuvlRdkHQPjuxLyhT6qn/0pvee7WO9y8nO1br
         yQq/cJWGRTOOc40KzRA0ah5o0E1T+Mtl7WKb/D8jjef+x1jE1DDSpJw9+L+rPpBmP+Y5
         bzzNamDPs8L89bg5FmiGTPHT+K/yAWcYKRvilsAZr+RxXOgCCQcbO/jriYqZyQm+qtNC
         KystwKtU/7g6mXH11dP3lPDWpoejRV+Nac1dYzBc8mz4B3IWcG2tzPcKxu0FeLdvE/G6
         tefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749201041; x=1749805841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=II529LrSfBKzf5rw6Q8oPjlQDiZcIOucONyjTvW4SOU=;
        b=Rlq86W6mRRchxL5PBAWH+JHpdjir5tF2BFlxNRIssLIe025kLUsKSaOcIhWhcdlXcy
         vlMarCePMN45Foykvp9APHfCxadUr8GUrs02YC7a3aeX8Y4TkxFJ5PadiIWRAvmlhyeo
         SQcMBjoyk0pUmnyMK80oPqKO1I1eYHRBkVPvI/KIr6AsFhXvoV1b8+cOtitSa65owL9c
         CcphA7K2fywJm/N/r7xSjYEsOHAsuQ7Qh6u8g7B1pn1agk9Z0cbKn1ITIJ6DhGWIC738
         MSmkiYl06/xaOy+pwN0AiXc3rhVO0sK2rYpkEcp57/DU+SEOoVAHl6OtGDvxVI7gW8L/
         Amag==
X-Forwarded-Encrypted: i=1; AJvYcCVXbQJFzmDurF5Y5t+EugC7xgXME+Z6cG11Yiiw9wfqcPbSy8j6VRv4lP24y410DG5QEEbaAK1ph2f34+xRRpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM55PTJAOgvWe/sxRr0F6XLguYaN+BLHbz+X6bAvFphSRlIKzf
	LDJr5Cv9F5ny5rNBPy4HTJ2NVlfEInXtjJIWRPzHabNofloDzhEng+jhwZyvzljlBDk=
X-Gm-Gg: ASbGncvv0MCG6N9E/7/CQvo9DsZAjPwRPs8E3WxFPZz0VFW75xFzk/ebZZ70LUccCFB
	Gkcg5fT8HIuyDVd2sgnYaxxYOyYdFz0DklhVj8ou+8hf6nX2OGdSn/grdcumKqJ+4W/ndhSaKdT
	OXpWfGCXjjPWEMKd0c0Hy66wLcU9t9kGZdYYJeLQxDL07qKc4a0X+eoXZsiejupMKmn6b/xLSw0
	gJ+mtT0gPklZH5ue9zOUnA7a9EWJwlu1Pvz6eeDSAVma3OscnHCfVJBapAjrQGkY4lt9893qGCN
	diwPqVxsOAU+O4EEaWaWeaaKZgFrAnD/wlT64chihBjBU5S5QgiBNSkYEsCJuiH5
X-Google-Smtp-Source: AGHT+IHds0yKQ5pBN+YT+u8U7ZCuK/4KsHqln7FlqIYjApddpVh8VUethz4KgV7ZC5ruqJ1+qxrsfw==
X-Received: by 2002:a17:902:f685:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23601d7182emr37579565ad.37.1749201041044;
        Fri, 06 Jun 2025 02:10:41 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077e9dsm8396765ad.1.2025.06.06.02.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 02:10:40 -0700 (PDT)
Message-ID: <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com>
Date: Fri, 6 Jun 2025 18:10:35 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
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
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com>
 <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/06 9:48, Jason Wang wrote:
> On Thu, Jun 5, 2025 at 3:58 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/06/05 10:53, Jason Wang wrote:
>>> On Wed, Jun 4, 2025 at 3:20 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/06/04 10:18, Jason Wang wrote:
>>>>> On Tue, Jun 3, 2025 at 1:31 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/06/03 12:19, Jason Wang wrote:
>>>>>>> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> They are useful to implement VIRTIO_NET_F_RSS and
>>>>>>>> VIRTIO_NET_F_HASH_REPORT.
>>>>>>>>
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>>>> ---
>>>>>>>>      include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 188 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>>>>>>>> index 02a9f4dc594d..426f33b4b824 100644
>>>>>>>> --- a/include/linux/virtio_net.h
>>>>>>>> +++ b/include/linux/virtio_net.h
>>>>>>>> @@ -9,6 +9,194 @@
>>>>>>>>      #include <uapi/linux/tcp.h>
>>>>>>>>      #include <uapi/linux/virtio_net.h>
>>>>>>>>
>>>>>>>> +struct virtio_net_hash {
>>>>>>>> +       u32 value;
>>>>>>>> +       u16 report;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct virtio_net_toeplitz_state {
>>>>>>>> +       u32 hash;
>>>>>>>> +       const u32 *key;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
>>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
>>>>>>>> +
>>>>>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
>>>>>>>> +
>>>>>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
>>>>>>>> +{
>>>>>>>> +       while (len >= sizeof(*input)) {
>>>>>>>> +               *input = be32_to_cpu((__force __be32)*input);
>>>>>>>> +               input++;
>>>>>>>> +               len -= sizeof(*input);
>>>>>>>> +       }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
>>>>>>>> +                                           const __be32 *input, size_t len)
>>>>>>>> +{
>>>>>>>> +       while (len >= sizeof(*input)) {
>>>>>>>> +               for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
>>>>>>>> +                       u32 i = ffs(map);
>>>>>>>> +
>>>>>>>> +                       state->hash ^= state->key[0] << (32 - i) |
>>>>>>>> +                                      (u32)((u64)state->key[1] >> i);
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               state->key++;
>>>>>>>> +               input++;
>>>>>>>> +               len -= sizeof(*input);
>>>>>>>> +       }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
>>>>>>>> +{
>>>>>>>> +       size_t len = 0;
>>>>>>>> +
>>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
>>>>>>>> +               len = max(len,
>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
>>>>>>>> +
>>>>>>>> +       if (types &
>>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
>>>>>>>> +               len = max(len,
>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
>>>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>>>> +
>>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
>>>>>>>> +               len = max(len,
>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
>>>>>>>> +
>>>>>>>> +       if (types &
>>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
>>>>>>>> +               len = max(len,
>>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
>>>>>>>> +                         sizeof(struct flow_dissector_key_ports));
>>>>>>>> +
>>>>>>>> +       return len + sizeof(u32);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline u32 virtio_net_hash_report(u32 types,
>>>>>>>> +                                        const struct flow_keys_basic *keys)
>>>>>>>> +{
>>>>>>>> +       switch (keys->basic.n_proto) {
>>>>>>>> +       case cpu_to_be16(ETH_P_IP):
>>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
>>>>>>>> +
>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
>>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
>>>>>>>> +
>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>> +
>>>>>>>> +       case cpu_to_be16(ETH_P_IPV6):
>>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_TCP &&
>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
>>>>>>>> +
>>>>>>>> +                       if (keys->basic.ip_proto == IPPROTO_UDP &&
>>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
>>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
>>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
>>>>>>>> +
>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>> +
>>>>>>>> +       default:
>>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>> +       }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
>>>>>>>> +                                      u32 types, const u32 *key,
>>>>>>>> +                                      struct virtio_net_hash *hash)
>>>>>>>> +{
>>>>>>>> +       struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
>>>>>>>> +       struct flow_keys flow;
>>>>>>>> +       struct flow_keys_basic flow_basic;
>>>>>>>> +       u16 report;
>>>>>>>> +
>>>>>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
>>>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>> +               return;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       flow_basic = (struct flow_keys_basic) {
>>>>>>>> +               .control = flow.control,
>>>>>>>> +               .basic = flow.basic
>>>>>>>> +       };
>>>>>>>> +
>>>>>>>> +       report = virtio_net_hash_report(types, &flow_basic);
>>>>>>>> +
>>>>>>>> +       switch (report) {
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v4addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v4addrs));
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
>>>>>>>> +                                        (__be32 *)&flow.addrs.v6addrs,
>>>>>>>> +                                        sizeof(flow.addrs.v6addrs));
>>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
>>>>>>>> +                                        sizeof(flow.ports.ports));
>>>>>>>> +               break;
>>>>>>>> +
>>>>>>>> +       default:
>>>>>>>> +               hash->report = VIRTIO_NET_HASH_REPORT_NONE;
>>>>>>>> +               return;
>>>>>>>
>>>>>>> So I still think we need a comment here to explain why this is not an
>>>>>>> issue if the device can report HASH_XXX_EX. Or we need to add the
>>>>>>> support, since this is the code from the driver side, I don't think we
>>>>>>> need to worry about the device implementation issues.
>>>>>>
>>>>>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
>>>>>>
>>>>>>>
>>>>>>> For the issue of the number of options, does the spec forbid fallback
>>>>>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
>>>>>>
>>>>>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
>>>>>>     > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>>>>>     > header, the hash is calculated over the following fields:
>>>>>>     > - Home address from the home address option in the IPv6 destination
>>>>>>     >   options header. If the extension header is not present, use the
>>>>>>     >   Source IPv6 address.
>>>>>>     > - IPv6 address that is contained in the Routing-Header-Type-2 from the
>>>>>>     >   associated extension header. If the extension header is not present,
>>>>>>     >   use the Destination IPv6 address.
>>>>>>     > - Source TCP port
>>>>>>     > - Destination TCP port
>>>>>>
>>>>>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6
>>>>>> and an home address option in the IPv6 destination options header is
>>>>>> present, the hash is calculated over the home address. If the hash is
>>>>>> not calculated over the home address in such a case, the device is
>>>>>> contradicting with this section and violating the spec. The same goes
>>>>>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
>>>>>
>>>>> Just to make sure we are one the same page. I meant:
>>>>>
>>>>> 1) If the hash is not calculated over the home address (in the case of
>>>>> IPv6 destination destination), it can still report
>>>>> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
>>>>> series. So the device can simply fallback to e.g TCPv6 if it can't
>>>>> understand all or part of the IPv6 options.
>>>>
>>>> The spec says it can fallback if "the extension header is not present",
>>>> not if the device can't understand the extension header.
>>>
>>> I don't think so,
>>>
>>> 1) spec had a condition beforehand:
>>>
>>> """
>>> If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>>> header, the hash is calculated over the following fields:
>>> ...
>>> If the extension header is not present ...
>>> """
>>>
>>> So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
>>> spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...
>>>
>>> 2) implementation wise, since device has limited resources, we can't
>>> expect the device can parse arbitrary number of ipv6 options
>>>
>>> 3) if 1) and 2) not the case, we need fix the spec otherwise implement
>>> a spec compliant device is impractical
>>
>> The statement is preceded by the following:
>>   >  The device calculates the hash on IPv4 packets according to
>>   > ’Enabled hash types’ bitmask as follows:
>>
>> The 'Enabled hash types' bitmask is specified by the device.
>>
>> I think the spec needs amendment.
> 
> Michael, can you help to clarify here?
> 
>>
>> I wonder if there are any people interested in the feature though.
>> Looking at virtnet_set_hashflow() in drivers/net/virtio_net.c, the
>> driver of Linux does not let users configure HASH_TYPE_XXX_EX. I suppose
>> Windows supports HASH_TYPE_XXX_EX, but those who care network
>> performance most would use Linux so HASH_TYPE_XXX_EX support without
>> Linux driver's support may not be useful.
> 
> It might be still interesting for example for the hardware virtio
> vendors to support windows etc.

I don't know if Windows needs them for e.g., device/driver certification 
so surveying Windows makes sense.

> 
>>
>>>
>>>>
>>>>> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
>>>>> tun_vnet_ioctl_sethash(), so userspace may set
>>>>> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
>>>>> tun_vnet_ioctl_gethashtypes(). In this case they won't get
>>>>> VIRTIO_NET_HASH_TYPE_TCP_EX.
>>>>
>>>> That's right. It's the responsibility of the userspace to set only the
>>>> supported hash types.
>>>
>>> Well, the kernel should filter out the unsupported one to have a
>>> robust uAPI. Otherwise, we give green light to the buggy userspace
>>> which will have unexpected results.
>>
>> My reasoning was that it may be fine for some use cases other than VM
>> (e.g., DPDK); in such a use case, it is fine as long as the UAPI works
>> in the best-effort basis.
> 
> Best-effort might increase the chance for user visisable changes after
> migration.

It is a trade-off between catching a migration bug for VMM and making 
life a bit easier for userspace programs other than VMM.

> 
>>
>> For example, suppose a userspace program that processes TCP packets; the
>> program can enable: HASH_TYPE_IPv4, HASH_TYPE_TCPv4, HASH_TYPE_IPv6, and
>> HASH_TYPE_TCPv6. Ideally, the kernel should support all the hash types,
>> but, even if e.g., HASH_TYPE_TCPv6 is not available,
> 
> For "available" did you mean it is not supported by the device?
> 
>> it will fall back
>> to HASH_TYPE_IPv6, which still does something good and may be acceptable.
> 
> This fallback is exactly the same as I said above, let
> VIRTIO_NET_HASH_TYPE_TCP_EX to fallback.
> 
> My point is that, the implementation should either:
> 
> 1) allow fallback so it can claim to support all hash types
> 
> or
> 
> 2) don't allow fallback so it can only support a part of the hash types
> 
> If we're doing something in the middle, for example, allow part of the
> type to fallback.

1) or the middle will make it unsuitable for VM because it violates the 
virtio spec. 2) makes sense though the trade-off I mentioned should be 
taken into consideration.

> 
>>
>> That said, for a use case that involves VM and implements virtio-net
>> (e.g., QEMU), setting an unsupported hash type here is definitely a bug.
>> Catching the bug may outweigh the extra trouble for other use cases.
>>
>>>
>>>>
>>>>> 3) implementing part of the hash types might complicate the migration
>>>>> or at least we need to describe the expectations of libvirt or other
>>>>> management in this case. For example, do we plan to have a dedicated
>>>>> Qemu command line like:
>>>>>
>>>>> -device virtio-net-pci,hash_report=on,supported_hash_types=X,Y,Z?
>>>>
>>>> I posted a patch series to implement such a command line for vDPA[1].
>>>> The patch series that wires this tuntap feature up[2] reuses the
>>>> infrastructure so it doesn't bring additional complexity.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@daynix.com/
>>>> [2]
>>>> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@daynix.com/
>>>
>>> I meant, if we implement a full hash report feature, it means a single
>>> hash cmdline option is more than sufficient and so compatibility code
>>> can just turn it off when dealing with machine types. This is much
>>> more simpler than
>>>
>>> 1) having both hash as well as supported_hash_features
>>> 2) dealing both hash as well as supported_hash_features in compatibility codes
>>> 3) libvirt will be happy
>>>
>>> For [1], it seems it introduces a per has type option, this seems to
>>> be a burden to the management layer as it need to learn new option
>>> everytime a new hash type is supported
>>
>> Even with the command line you proposed (supported_hash_types=X,Y,Z), it
>> is still necessary to know the values the supported_hash_types property
>> accepts (X.Y,Z), so I don't think it makes difference.
> 
> It could be a uint32_t.

The management layer will need to know what bits are accepted even with 
uint32_t.

> 
>>
>> The burden to the management layer is already present for features, so
>> it is an existing problem (or its mere extension).
> 
> Yes, but since this feature is new it's better to try our best to avoid that.
> 
>>
>> This problem was discussed in the following thread in the past, but no
>> solution is implemented yet, and probably solving it will be difficult.
>> https://lore.kernel.org/qemu-devel/20230731223148.1002258-5-yuri.benditovich@daynix.com/
> 
> It's a similar issue but not the same, it looks more like a discussion
> on whether the fallback from vhost-net to qemu works for missing
> features etc.

Perhaps we may be able to do better since this feature is new as you say 
and we don't have to worry much about breaking change. I don't have an 
idea for that yet.

Regards,
Akihiko Odaki

