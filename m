Return-Path: <linux-kselftest+bounces-19596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3699B2DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 12:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272501C20F01
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278671537C9;
	Sat, 12 Oct 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xWv8Wyj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB014F9F7
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728727994; cv=none; b=QpUhp57VkYbh939QVVq28gL/nJ6tWN6nldlERlaPHKmbH3Ku+kFdO0r1gunz3IB9DBCRsvSMv6vX/gooL3jnM+PV+lLCDSUNXYVHtjHaGHf99N9fVQlaXTC4kmQFKc3U8Tv1L1pKCOCFX9CaL8B68nsGmEQZJlXgpyJ6HvaFi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728727994; c=relaxed/simple;
	bh=bhbCpWap9rKrMby3/z8g4oHNqnksOXSERwcpIUiPYgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za0GLIfwPTHlndtMQupQubiSmNOaEkhM3pScvXgXtqNE0numtpBRcQTfABNRjT2jBlzdwXLc9mO/yCxZVKWgXbdODMuILNM006hOFe8HzqqEr/HekcN/iqOHOY3adlrRPnxFVwCcTXJ0fa/wdCTkTn6w+0goR7MjuXBcosjCI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xWv8Wyj2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso282880b3a.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728727991; x=1729332791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCaJSWLJti8WQIhytX3+bnL62tnw2fcPub/ouH3fJyk=;
        b=xWv8Wyj2UlMaNNDVC7SSOTCUgWR4aYyMaO8NLXMc7XsVZJQte1pcMHJVKAI94j5LQN
         NstQaZTNepPEWFXq9hpwFhHVTB7bfVwEMISIGNMEv54y0stSfKlP7BW3RpD15fAnprb5
         8l7B+fVo6+pptPqExun1xnQJxlGPQ07dn1MLEkL8rAKRus4zOXjQx2TmVQkXE9bfc/fH
         M0yvrcVturC+VSxtjYM9KOrmaJs7uo7f2q1kGCffb1oNapGee/LLDFk440DxCOWdsh1/
         QziScmhv8sIkp5h7m3NMTOP5662tt77UWouRm56DIFKoZDnHVGEY1RkXfmUmw4LYWtPY
         1oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728727991; x=1729332791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCaJSWLJti8WQIhytX3+bnL62tnw2fcPub/ouH3fJyk=;
        b=QocQD+7vwOJaXbUo0GOnDQA/HPBTD3IUXHsRinWMM7800EHEWhks41azIpOy2wxwR9
         1uUZUscgv8CPSEK0IUDLTewsRhn4LSgzhQkHz8pInXC2qmEkXKs4Fbtk2eYi1Jx6B9BX
         9Em8+1+ThivO3BEKDlR/5W+QXtZyJvccdHEzy8FTGdTNWACbhFYUbIPj+hM1/GIG/yFX
         EldThS8ZJ13qE8KlxyRTobQTqCAa3bs+nUlJRZkNzX0CkLoUJLn08+d+egB2Hwzh0zYR
         f1YwbYO0jgFsrJvfGOnO3WB1NYlhRBad8NT8pc9ey6uaabkyTDVh/SM8FKErkwDBmA2o
         1Gww==
X-Forwarded-Encrypted: i=1; AJvYcCXhFqiIZWMQS8oGI1oBz/qrUcC3roVtuCBxVJGvNSwDdXGGyTqbdNLpE7z/kRzlWMXSSEmBAgnfWh+vz0rLlQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFJcEFaLp2v/i8Z9zUWXIkfm1Jdmy7kj+VGf5TRlD2zsn46O7
	WEUaghq/9oj6+pBa6CGoRZDraHI4BkmDqH4rUPf93/Ki1qAnO8T4aQd52l5qViQ=
X-Google-Smtp-Source: AGHT+IG2KYgu6x1Z/X115flMduGchaq54geGKudBwaZLm17YYGBycqp1gqBB61LiyJ1Okcf2fTfh/w==
X-Received: by 2002:a05:6a00:14c8:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-71e4c151388mr3662935b3a.8.1728727990972;
        Sat, 12 Oct 2024 03:13:10 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e47a5bec6sm1732065b3a.72.2024.10.12.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:13:10 -0700 (PDT)
Message-ID: <1d1e680a-fc27-48b9-973b-408c5c7c1342@daynix.com>
Date: Sat, 12 Oct 2024 19:13:05 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 06/10] tun: Introduce virtio-net hash reporting
 feature
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-6-f3cf68df005d@daynix.com>
 <CACGkMEtExrXA-fz1pBCoGHE8JoxbXumALd8OXWDNv3NCtzZXsQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtExrXA-fz1pBCoGHE8JoxbXumALd8OXWDNv3NCtzZXsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/09 17:05, Jason Wang wrote:
> On Tue, Oct 8, 2024 at 2:55 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Allow the guest to reuse the hash value to make receive steering
>> consistent between the host and guest, and to save hash computation.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I wonder if this would cause overhead when hash reporting is not enabled?

It only adds two branches in the data path. The first one is in 
tun_vnet_hash_report(), which determines to add the hash value to 
sk_buff. The second one is in tun_vnet_hdr_from_skb(), which determines 
to report the added hash value.

> 
>> ---
>>   Documentation/networking/tuntap.rst |   7 +++
>>   drivers/net/Kconfig                 |   1 +
>>   drivers/net/tap.c                   |  45 ++++++++++++++--
> 
> Tile should be for tap as well or is this just for tun?

It is also for tap. I will update the title in v6.

> 
>>   drivers/net/tun.c                   |  46 ++++++++++++----
>>   drivers/net/tun_vnet.h              | 102 +++++++++++++++++++++++++++++++-----
>>   include/linux/if_tap.h              |   2 +
>>   include/uapi/linux/if_tun.h         |  48 +++++++++++++++++
>>   7 files changed, 223 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>> index 4d7087f727be..86b4ae8caa8a 100644
>> --- a/Documentation/networking/tuntap.rst
>> +++ b/Documentation/networking/tuntap.rst
>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>     }
>>
>> +3.4 Reference
>> +-------------
>> +
>> +``linux/if_tun.h`` defines the interface described below:
>> +
>> +.. kernel-doc:: include/uapi/linux/if_tun.h
>> +
>>   Universal TUN/TAP device driver Frequently Asked Question
>>   =========================================================
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 9920b3a68ed1..e2a7bd703550 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>          tristate "Universal TUN/TAP device driver support"
>>          depends on INET
>>          select CRC32
>> +       select SKB_EXTENSIONS
> 
> Then we need this for macvtap at least as well?
> 
>>          help
>>            TUN/TAP provides packet reception and transmission for user space
>>            programs.  It can be viewed as a simple Point-to-Point or Ethernet
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 9a34ceed0c2c..5e2fbe63ca47 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -179,6 +179,16 @@ static void tap_put_queue(struct tap_queue *q)
>>          sock_put(&q->sk);
>>   }
>>
>> +static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
>> +{
>> +       return (struct virtio_net_hash *)skb->cb;
> 
> Any reason that tap uses skb->cb but not skb extensions? (And is it
> safe to use that without cloning?)

tun adds virtio_net_hash to a skb in ndo_select_queue(), but it does not 
immediately put it into its ptr_ring; instead ndo_start_xmit() does so. 
It is hard to ensure that nobody modifies skb->cb between the two calls.

The situation is different for tap. tap_handle_frame() adds 
virtio_net_hash to a skb and immediately adds it in its ptr_ring so 
nobody should touch it between that.

> 
>> +}
>> +
>> +static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
>> +{
>> +       return (const struct virtio_net_hash *)skb->cb;
>> +}
>> +
>>   /*
>>    * Select a queue based on the rxq of the device on which this packet
>>    * arrived. If the incoming device is not mq, calculate a flow hash
>> @@ -189,6 +199,7 @@ static void tap_put_queue(struct tap_queue *q)
>>   static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>                                         struct sk_buff *skb)
>>   {
>> +       struct flow_keys_basic keys_basic;
>>          struct tap_queue *queue = NULL;
>>          /* Access to taps array is protected by rcu, but access to numvtaps
>>           * isn't. Below we use it to lookup a queue, but treat it as a hint
>> @@ -198,15 +209,32 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>          int numvtaps = READ_ONCE(tap->numvtaps);
>>          __u32 rxq;
>>
>> +       *tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
>> +
>>          if (!numvtaps)
>>                  goto out;
>>
>>          if (numvtaps == 1)
>>                  goto single;
>>
>> +       if (!skb->l4_hash && !skb->sw_hash) {
>> +               struct flow_keys keys;
>> +
>> +               skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>> +               rxq = flow_hash_from_keys(&keys);
>> +               keys_basic = (struct flow_keys_basic) {
>> +                       .control = keys.control,
>> +                       .basic = keys.basic
>> +               };
>> +       } else {
>> +               skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
>> +                                                FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>> +               rxq = skb->hash;
>> +       }
>> +
>>          /* Check if we can use flow to select a queue */
>> -       rxq = skb_get_hash(skb);
>>          if (rxq) {
>> +               tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>>                  queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>>                  goto out;
>>          }
>> @@ -713,15 +741,16 @@ static ssize_t tap_put_user(struct tap_queue *q,
>>          int total;
>>
>>          if (q->flags & IFF_VNET_HDR) {
>> -               struct virtio_net_hdr vnet_hdr;
>> +               struct virtio_net_hdr_v1_hash vnet_hdr;
>>
>>                  vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>>
>> -               ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
>> +               ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
>> +                                           tap_find_hash, &vnet_hdr);
>>                  if (ret < 0)
>>                          goto done;
>>
>> -               ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
>> +               ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr, ret);
>>                  if (ret < 0)
>>                          goto done;
>>          }
>> @@ -1025,7 +1054,13 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>                  return ret;
>>
>>          default:
>> -               return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
>> +               rtnl_lock();
>> +               tap = rtnl_dereference(q->tap);
>> +               ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
>> +                                    tap ? &tap->vnet_hash : NULL, -EINVAL,
>> +                                    cmd, sp);
>> +               rtnl_unlock();
>> +               return ret;
>>          }
>>   }
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index dd8799d19518..27308417b834 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -209,6 +209,7 @@ struct tun_struct {
>>          struct bpf_prog __rcu *xdp_prog;
>>          struct tun_prog __rcu *steering_prog;
>>          struct tun_prog __rcu *filter_prog;
>> +       struct tun_vnet_hash vnet_hash;
>>          struct ethtool_link_ksettings link_ksettings;
>>          /* init args */
>>          struct file *file;
>> @@ -451,6 +452,16 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>>                  e->rps_rxhash = hash;
>>   }
>>
>> +static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
>> +{
>> +       return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
>> +}
>> +
>> +static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
>> +{
>> +       return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
>> +}
>> +
>>   /* We try to identify a flow through its rxhash. The reason that
>>    * we do not check rxq no. is because some cards(e.g 82599), chooses
>>    * the rxq based on the txq where the last packet of the flow comes. As
>> @@ -459,12 +470,17 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>>    */
>>   static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>   {
>> +       struct flow_keys keys;
>> +       struct flow_keys_basic keys_basic;
>>          struct tun_flow_entry *e;
>>          u32 txq, numqueues;
>>
>>          numqueues = READ_ONCE(tun->numqueues);
>>
>> -       txq = __skb_get_hash_symmetric(skb);
>> +       memset(&keys, 0, sizeof(keys));
>> +       skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0);
>> +
>> +       txq = flow_hash_from_keys(&keys);
>>          e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
>>          if (e) {
>>                  tun_flow_save_rps_rxhash(e, txq);
>> @@ -473,6 +489,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>                  txq = reciprocal_scale(txq, numqueues);
>>          }
>>
>> +       keys_basic = (struct flow_keys_basic) {
>> +               .control = keys.control,
>> +               .basic = keys.basic
>> +       };
>> +       tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>> +                            tun_add_hash);
> 
> Is using txq required when not l4_hash is required by the virtio-spec?

It is a limitation of the implementation. A hardware driver may set a 
hash value with skb_set_hash(), which takes enum pkt_hash_types. The 
enum is defined as follows:
enum pkt_hash_types {
	PKT_HASH_TYPE_NONE,	/* Undefined type */
	PKT_HASH_TYPE_L2,	/* Input: src_MAC, dest_MAC */
	PKT_HASH_TYPE_L3,	/* Input: src_IP, dst_IP */
	PKT_HASH_TYPE_L4,	/* Input: src_IP, dst_IP, src_port, dst_port */
};

A hash value with PKT_HASH_TYPE_L2 must be ignored as the virtio spec 
does not have a corresponding hash type. The virtio spec has 
corresponding hash types for PKT_HASH_TYPE_L3 and PKT_HASH_TYPE_L4 so we 
should report them with the virtio_net header.

However, skb only tells whether the hash is PKT_HASH_TYPE_L4 or not. So 
tun reports skb->hash with a L4 hash type if the hash is 
PKT_HASH_TYPE_L4. Otherwise it ignores skb->hash and uses the hash value 
computed its own because it cannot tell if skb->hash is PKT_HASH_TYPE_L2 
or PKT_HASH_TYPE_L3.

> 
>> +
>>          return txq;
>>   }
>>
>> @@ -1990,10 +2013,8 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>>          size_t total;
>>
>>          if (tun->flags & IFF_VNET_HDR) {
>> -               struct virtio_net_hdr gso = { 0 };
>> -
>>                  vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>> -               ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
>> +               ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, NULL, 0);
>>                  if (ret < 0)
>>                          return ret;
>>          }
>> @@ -2018,7 +2039,6 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>          int vlan_offset = 0;
>>          int vlan_hlen = 0;
>>          int vnet_hdr_sz = 0;
>> -       int ret;
>>
>>          if (skb_vlan_tag_present(skb))
>>                  vlan_hlen = VLAN_HLEN;
>> @@ -2043,13 +2063,15 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>          }
>>
>>          if (vnet_hdr_sz) {
>> -               struct virtio_net_hdr gso;
>> +               struct virtio_net_hdr_v1_hash gso;
>> +               int ret;
>>
>> -               ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>> +               ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev, skb,
>> +                                           tun_find_hash, &gso);
>>                  if (ret < 0)
>>                          goto done;
>>
>> -               ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
>> +               ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso, ret);
>>                  if (ret < 0)
>>                          goto done;
>>          }
>> @@ -3055,9 +3077,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  goto unlock;
>>          }
>>
>> -       ret = -EBADFD;
>> -       if (!tun)
>> +       if (!tun) {
>> +               ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, argp);
> 
> This seems not elegant (passing three NULL pointers). Any reason we
> can't just modify __tun_chr_ioctl() instead of introducing things like
> tun_vnet_ioctl()?

tun_vnet_ioctl() is introduced with patch "tun: Unify vnet 
implementation". We can abandon unifying the ioctl handling if the 
interface looks too awkward.

> 
>>                  goto unlock;
>> +       }
>>
>>          netif_info(tun, drv, tun->dev, "tun_chr_ioctl cmd %u\n", cmd);
>>
>> @@ -3256,7 +3279,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  break;
>>
>>          default:
>> -               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
>> +               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
>> +                                    &tun->vnet_hash, -EINVAL, cmd, argp);
>>          }
>>
>>          if (do_notify)
>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>> index c40bde0fdf8c..589a97dd7d02 100644
>> --- a/drivers/net/tun_vnet.h
>> +++ b/drivers/net/tun_vnet.h
>> @@ -6,6 +6,9 @@
>>   #define TUN_VNET_LE 0x80000000
>>   #define TUN_VNET_BE 0x40000000
>>
>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
>> +
>>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>   {
>>          return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
>> @@ -59,18 +62,31 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
>>   }
>>
>>   static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>> -                                 unsigned int cmd, int __user *sp)
>> +                                 struct tun_vnet_hash *hash, long fallback,
>> +                                 unsigned int cmd, void __user *argp)
>>   {
>> +       static const struct tun_vnet_hash cap = {
>> +               .flags = TUN_VNET_HASH_REPORT,
>> +               .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>> +       };
> 
> Let's find a way to reuse virtio-net uAPI instead of introducing new
> stuff to stress the management layer.

I found include/uapi/linux/virtio_net.h inappropriate for this ioctl.

It has the following structure for hash reporting:

struct virtio_net_hash_config {
	__le32 hash_types;
	/* for compatibility with virtio_net_rss_config */
	__le16 reserved[4];
	__u8 hash_key_length;
	__u8 hash_key_data[/* hash_key_length */];
};

We do not care hash_key_length and hash_key_data.

It has the following structure for RSS and hash reporting when RSS is 
enabled:

struct virtio_net_rss_config {
	__le32 hash_types;
	__le16 indirection_table_mask;
	__le16 unclassified_queue;
	__le16 indirection_table[1/* + indirection_table_mask */];
	__le16 max_tx_vq;
	__u8 hash_key_length;
	__u8 hash_key_data[/* hash_key_length */];
};

This structure is hard to use as it has data members after the 
indirection_table flexible array. max_tx_vq is not our interest either.

I tested the usability of ioctl by actually using it in QEMU. The RFC 
patch series is available at:
https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/

> 
>> +       struct tun_vnet_hash hash_buf;
>> +       int __user *sp = argp;
>>          int s;
>>
>>          switch (cmd) {
>>          case TUNGETVNETHDRSZ:
>> +               if (!sz)
>> +                       return -EBADFD;
>> +
>>                  s = *sz;
>>                  if (put_user(s, sp))
>>                          return -EFAULT;
>>                  return 0;
>>
>>          case TUNSETVNETHDRSZ:
>> +               if (!sz)
>> +                       return -EBADFD;
>> +
>>                  if (get_user(s, sp))
>>                          return -EFAULT;
>>                  if (s < (int)sizeof(struct virtio_net_hdr))
>> @@ -80,12 +96,18 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>                  return 0;
>>
>>          case TUNGETVNETLE:
>> +               if (!flags)
>> +                       return -EBADFD;
>> +
>>                  s = !!(*flags & TUN_VNET_LE);
>>                  if (put_user(s, sp))
>>                          return -EFAULT;
>>                  return 0;
>>
>>          case TUNSETVNETLE:
>> +               if (!flags)
>> +                       return -EBADFD;
>> +
>>                  if (get_user(s, sp))
>>                          return -EFAULT;
>>                  if (s)
>> @@ -95,16 +117,56 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>                  return 0;
>>
>>          case TUNGETVNETBE:
>> +               if (!flags)
>> +                       return -EBADFD;
>> +
>>                  return tun_vnet_get_be(*flags, sp);
>>
>>          case TUNSETVNETBE:
>> +               if (!flags)
>> +                       return -EBADFD;
>> +
>>                  return tun_vnet_set_be(flags, sp);
>>
>> +       case TUNGETVNETHASHCAP:
>> +               return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
>> +
>> +       case TUNSETVNETHASH:
>> +               if (!hash)
>> +                       return -EBADFD;
>> +
>> +               if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
>> +                       return -EFAULT;
>> +
>> +               *hash = hash_buf;
>> +               return 0;
>> +
>>          default:
>> -               return -EINVAL;
>> +               return fallback;
>>          }
>>   }
>>
>> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>> +                                       struct sk_buff *skb,
>> +                                       const struct flow_keys_basic *keys,
>> +                                       u32 value,
>> +                                       tun_vnet_hash_add vnet_hash_add)
>> +{
>> +       struct virtio_net_hash *report;
>> +
>> +       if (!(hash->flags & TUN_VNET_HASH_REPORT))
>> +               return;
>> +
>> +       report = vnet_hash_add(skb);
>> +       if (!report)
>> +               return;
>> +
>> +       *report = (struct virtio_net_hash) {
>> +               .report = virtio_net_hash_report(hash->types, keys),
>> +               .value = value
>> +       };
>> +}
>> +
>>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>                                     struct iov_iter *from,
>>                                     struct virtio_net_hdr *hdr)
>> @@ -130,15 +192,15 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>   }
>>
>>   static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>> -                                  const struct virtio_net_hdr *hdr)
>> +                                  const void *hdr, int content_sz)
>>   {
>>          if (iov_iter_count(iter) < sz)
>>                  return -EINVAL;
>>
>> -       if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>> +       if (copy_to_iter(hdr, content_sz, iter) != content_sz)
>>                  return -EFAULT;
>>
>> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>> +       if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
>>                  return -EFAULT;
>>
>>          return 0;
>> @@ -151,32 +213,48 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags,
>>          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
>>   }
>>
>> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
>>                                          const struct net_device *dev,
>>                                          const struct sk_buff *skb,
>> -                                       struct virtio_net_hdr *hdr)
>> +                                       tun_vnet_hash_find vnet_hash_find,
>> +                                       struct virtio_net_hdr_v1_hash *hdr)
>>   {
>>          int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>> +       const struct virtio_net_hash *report = sz < sizeof(struct virtio_net_hdr_v1_hash) ?
>> +                                              NULL : vnet_hash_find(skb);
>> +       int content_sz;
>> +
>> +       if (report) {
>> +               content_sz = sizeof(struct virtio_net_hdr_v1_hash);
>> +
>> +               *hdr = (struct virtio_net_hdr_v1_hash) {
>> +                       .hdr = { .num_buffers = __cpu_to_virtio16(true, 1) },
>> +                       .hash_value = cpu_to_le32(report->value),
>> +                       .hash_report = cpu_to_le16(report->report)
>> +               };
>> +       } else {
>> +               content_sz = sizeof(struct virtio_net_hdr);
>> +       }
>>
>> -       if (virtio_net_hdr_from_skb(skb, hdr,
>> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>>                                      tun_vnet_is_little_endian(flags), true,
>>                                      vlan_hlen)) {
>>                  struct skb_shared_info *sinfo = skb_shinfo(skb);
>>
>>                  if (net_ratelimit()) {
>>                          netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
>> -                                  sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
>> -                                  tun_vnet16_to_cpu(flags, hdr->hdr_len));
>> +                                  sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->hdr.gso_size),
>> +                                  tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len));
>>                          print_hex_dump(KERN_ERR, "tun: ",
>>                                         DUMP_PREFIX_NONE,
>>                                         16, 1, skb->head,
>> -                                      min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
>> +                                      min(tun_vnet16_to_cpu(flags, hdr->hdr.hdr_len), 64), true);
>>                  }
>>                  WARN_ON_ONCE(1);
>>                  return -EINVAL;
>>          }
>>
>> -       return 0;
>> +       return content_sz;
>>   }
>>
>>   #endif /* TUN_VNET_H */
>> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
>> index 553552fa635c..5bbb343a6dba 100644
>> --- a/include/linux/if_tap.h
>> +++ b/include/linux/if_tap.h
>> @@ -4,6 +4,7 @@
>>
>>   #include <net/sock.h>
>>   #include <linux/skb_array.h>
>> +#include <uapi/linux/if_tun.h>
>>
>>   struct file;
>>   struct socket;
>> @@ -43,6 +44,7 @@ struct tap_dev {
>>          int                     numqueues;
>>          netdev_features_t       tap_features;
>>          int                     minor;
>> +       struct tun_vnet_hash    vnet_hash;
>>
>>          void (*update_features)(struct tap_dev *tap, netdev_features_t features);
>>          void (*count_tx_dropped)(struct tap_dev *tap);
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c939..d11e79b4e0dc 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -62,6 +62,34 @@
>>   #define TUNSETCARRIER _IOW('T', 226, int)
>>   #define TUNGETDEVNETNS _IO('T', 227)
>>
>> +/**
>> + * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capability.
>> + *
>> + * The argument is a pointer to &struct tun_vnet_hash which will store the
>> + * maximal virtio_net hashing configuration.
>> + */
>> +#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
>> +
>> +/**
>> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
>> + *
>> + * The argument is a pointer to &struct tun_vnet_hash.
>> + *
>> + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>> + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>> + * to the size of &struct virtio_net_hdr_v1_hash.
> 
> I think we don't need & here.

Documentation/doc-guide/kernel-doc.rst says &struct is a token for 
struct cross-reference.

> 
>> + *
>> + * The members added to the legacy header by %TUN_VNET_HASH_REPORT flag will
>> + * always be little-endian.
>> + *
>> + * This ioctl results in %EBADFD if the underlying device is deleted. It affects
>> + * all queues attached to the same device.
>> + *
>> + * This ioctl currently has no effect on XDP packets and packets with
>> + * queue_mapping set by TC.
> 
> This needs to be fixed?

We don't use a hash value to select a queue in such a case so there is 
no point to report one.

> 
>> + */
>> +#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
>> +
>>   /* TUNSETIFF ifr flags */
>>   #define IFF_TUN                0x0001
>>   #define IFF_TAP                0x0002
>> @@ -115,4 +143,24 @@ struct tun_filter {
>>          __u8   addr[][ETH_ALEN];
>>   };
>>
>> +/**
>> + * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
>> + */
>> +#define TUN_VNET_HASH_REPORT   0x0001
>> +
>> +/**
>> + * struct tun_vnet_hash - virtio_net hashing configuration
>> + * @flags:
>> + *             Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
> 
> Could we reuse TUNGETIFF by introduce new IFF_XXX stuffs?

That's certainly doable though I'm a bit worrying that exhausting all 
bits of IFF_XXX.

> 
>> + * @pad:
>> + *             Should be filled with zero before passing to %TUNSETVNETHASH
>> + * @types:
>> + *             Bitmask of allowed hash types
> 
> What are they?

They are defined in the virtio spec and include/uapi/linux/virtio_net.h 
contains them:
#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)

> 
>> + */
>> +struct tun_vnet_hash {
>> +       __u16 flags;
>> +       __u8 pad[2];
>> +       __u32 types;
>> +};
>> +
>>   #endif /* _UAPI__IF_TUN_H */
>>
>> --
>> 2.46.2
>>
> 
> Thanks
> 


