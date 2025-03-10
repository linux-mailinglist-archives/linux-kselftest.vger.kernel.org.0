Return-Path: <linux-kselftest+bounces-28586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C741A58D30
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBB07A3B04
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4070222575;
	Mon, 10 Mar 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kU9D/LXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E42222CE
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592711; cv=none; b=p6GqexlcR+Fz0Mu+Nkp08QJa7caF88mPfhnPeDhOkHapwPo2oHBr51cJYTmrZsR1qKL5DAK3urQiB1SMealLfc4neyp3/JwGMTyetCXVnOvMMSma3HwNeqD9hnC68OphHrovBGtQ0atO9XLvxWpxPA/ZdT0rFfn30w4t4DJhT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592711; c=relaxed/simple;
	bh=tHiHn3s9vD0nLGAqUJPxoU7l5rggJB8iHytXk8ikjYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xe+W+UeFM5BSRwqpED/S8Yolt5frfiY7Ya/FPb+Dw9ia2/L51dVM89mkhUq0b/tg9XLlWTG0+PHeVjsNZuPwXbHS6rlSKE9+ierdVYCF02xU0X+2MM0l1TP/4fvKnCWBEzYwZRktcAuw28dLrR3iXDf8PNogtXNaYliY7IFi43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=kU9D/LXj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so19766805ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741592708; x=1742197508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pY68u9Ou8/riV0dmStydkY3YDCSuwxcU9M4Zvwz340=;
        b=kU9D/LXjGDWBFh3tKc2aqcLL47lbZz4pr0aumyXaq1YCOs1QX85L1hePth8NpQxjTX
         cVYExYUo2a/ZeskgtaEM4W4k5mt/fK2pEnheQyrTpJW86+tRtiYAsg/Db2EvTrOCrzF2
         R9GcgoTVrdmb9RrOPVTdKHnLXzF2cdnzOaHxLAtrdTCN4QLqG4D/GW+U9YodSP/rZt5I
         b4eOzDs9h9QsDIe5wi5QG+FFgHtNIMd7C24wXUvyJAX1LlGYb7Xo4dt+HKvpZuNRdE9X
         LQdEoIEvcP1pnfqHUOr9U2kpXEfa5SVhLrIBcCJfCPVRVlbt7b7YvXc5VKTR6Q1nuhYO
         GlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592708; x=1742197508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pY68u9Ou8/riV0dmStydkY3YDCSuwxcU9M4Zvwz340=;
        b=AB+8XQ7ohR6DdzZRslO7OBEOWWdWj9xK7I/HhVBFVKCUJ455dGXK3KkSvN69pb6/+N
         GYcE6YW18PIuqwv4jcEP70ccpFYE5KHnRPLDTGkzNDWMzEZPXwlYCTXbCpO1tVTXpHtg
         zwGWS8S2gSk1IRQKsFcZLOixIj+VAtxy68H0v1FwNncF4VCCJ2GvP2LS+Yoj09ebpWqj
         Agbqtu1ztEcVxbNPuK3rwJJ94Js0HPgOaR/Sf0BLQUA/obBBY0IMcWAl18z/AUA+FXSu
         UBm6ohNAeEIPlxwTWjFRRVg6F/6xTqIE4kvbBgGIh3fvStzbaqH0B9uNhrKN8aY5ZEyI
         rIVA==
X-Forwarded-Encrypted: i=1; AJvYcCUAi1yJrNuJkdv+siyGL1v9O7ddfNRnEVKaAth/SuoSVksocXCSZ6ev22gXIIBbhTTkXBDoy8tzVhl2vK/9VGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefjUQUZhgdjKxA4//KsPQ7qPEfrxbgc9XwRkHTdhVL7BbuLr9
	x1MtSRWsla+pvBDSohtZcQRLlYhKrGbH69CurnnYSbFLpxIa586R3D562ZZAHH0=
X-Gm-Gg: ASbGncsEFd6ZSrh7nqOyClIMuj+ij7Gn5/q3c78RAx7JY8hx5GqWThyjhr31Mk7zHNM
	SfSggtokuVlv8RPiMG7kJZeErnl1qeGuPva3cEzgQ/2zhIcI+LPHSfhXMV7SiCeVjmyxlw3Rn8B
	qadm0Ser29sSwanlq4CpHdIxQNRd0X/njLqFGlDuhUfxCkXCMTVyi2UJs2UeDJro5lXPH+GlzsF
	o2DNYC+/3iUIpEXfXM1scZ+wFXSeWo1mRGHxr8Ncmn+/0tFirxdXggIO/JvrZcGZqJd9S9gy401
	9BC08XjQ9HB9sAQmfPyj/GkQU6LKky88MgLTc2JVEcCRTlYwcaYxtwsCUg==
X-Google-Smtp-Source: AGHT+IH5OnNTMQMwrNlPP4KvzwEZBP42Z/Nth++O8tP5+uA86E+EDheMj8ptxmDf6vBXBNBY+MsPuw==
X-Received: by 2002:aa7:8d11:0:b0:736:ba49:97bb with SMTP id d2e1a72fcca58-736ba499889mr10689952b3a.5.1741592707659;
        Mon, 10 Mar 2025 00:45:07 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a7d6e54bsm6291666b3a.44.2025.03.10.00.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:45:07 -0700 (PDT)
Message-ID: <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
Date: Mon, 10 Mar 2025 16:45:02 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
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
 <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 12:55, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Hash reporting
>> ==============
>>
>> Allow the guest to reuse the hash value to make receive steering
>> consistent between the host and guest, and to save hash computation.
>>
>> RSS
>> ===
>>
>> RSS is a receive steering algorithm that can be negotiated to use with
>> virtio_net. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF steering program.
>>
>> Introduce the code to perform RSS to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but I didn't
>> opt for it because extending the current mechanism of eBPF steering
>> program as is because it relies on legacy context rewriting, and
>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>> the other relevant virtualization APIs such as KVM and vhost_net are
>> UAPIs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   Documentation/networking/tuntap.rst |   7 ++
>>   drivers/net/Kconfig                 |   1 +
>>   drivers/net/tap.c                   |  68 ++++++++++++++-
>>   drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>   drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>   include/linux/if_tap.h              |   2 +
>>   include/linux/skbuff.h              |   3 +
>>   include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>   net/core/skbuff.c                   |   4 +
>>   9 files changed, 386 insertions(+), 31 deletions(-)
>>
>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558920be42ce0d4217465 100644
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
>> index 1fd5acdc73c6af0e1a861867039c3624fc618e25..aecfd244dd83585fea2c5b815dcd787c58166c28 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>          tristate "Universal TUN/TAP device driver support"
>>          depends on INET
>>          select CRC32
>> +       select SKB_EXTENSIONS
>>          help
>>            TUN/TAP provides packet reception and transmission for user space
>>            programs.  It can be viewed as a simple Point-to-Point or Ethernet
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index d4ece538f1b23789ca60caa6232690e4d0a4d14a..9428b63ec27e7f92e78a78afcb5e24383862c00d 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -49,6 +49,10 @@ struct major_info {
>>          struct list_head next;
>>   };
>>
>> +struct tap_skb_cb {
>> +       struct virtio_net_hash hash;
>> +};
>> +
>>   #define GOODCOPY_LEN 128
>>
>>   static const struct proto_ops tap_socket_ops;
>> @@ -179,6 +183,22 @@ static void tap_put_queue(struct tap_queue *q)
>>          sock_put(&q->sk);
>>   }
>>
>> +static struct tap_skb_cb *tap_skb_cb(const struct sk_buff *skb)
>> +{
>> +       BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct tap_skb_cb));
>> +       return (struct tap_skb_cb *)skb->cb;
>> +}
>> +
>> +static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
>> +{
>> +       return &tap_skb_cb(skb)->hash;
>> +}
>> +
>> +static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
>> +{
>> +       return &tap_skb_cb(skb)->hash;
>> +}
>> +
>>   /*
>>    * Select a queue based on the rxq of the device on which this packet
>>    * arrived. If the incoming device is not mq, calculate a flow hash
>> @@ -189,6 +209,7 @@ static void tap_put_queue(struct tap_queue *q)
>>   static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>                                         struct sk_buff *skb)
>>   {
>> +       struct flow_keys_basic keys_basic;
>>          struct tap_queue *queue = NULL;
>>          /* Access to taps array is protected by rcu, but access to numvtaps
>>           * isn't. Below we use it to lookup a queue, but treat it as a hint
>> @@ -196,17 +217,47 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>           * racing against queue removal.
>>           */
>>          int numvtaps = READ_ONCE(tap->numvtaps);
>> +       struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
>>          __u32 rxq;
>>
>> +       *tap_skb_cb(skb) = (struct tap_skb_cb) {
>> +               .hash = { .report = VIRTIO_NET_HASH_REPORT_NONE }
>> +       };
>> +
>>          if (!numvtaps)
>>                  goto out;
>>
>>          if (numvtaps == 1)
>>                  goto single;
>>
>> +       if (vnet_hash) {
>> +               if ((vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +                       rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
>> +                       queue = rcu_dereference(tap->taps[rxq]);
>> +                       goto out;
>> +               }
>> +
>> +               if (!skb->l4_hash && !skb->sw_hash) {
>> +                       struct flow_keys keys;
>> +
>> +                       skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>> +                       rxq = flow_hash_from_keys(&keys);
>> +                       keys_basic = (struct flow_keys_basic) {
>> +                               .control = keys.control,
>> +                               .basic = keys.basic
>> +                       };
>> +               } else {
>> +                       skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
>> +                                                        FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>> +                       rxq = skb->hash;
>> +               }
>> +       } else {
>> +               rxq = skb_get_hash(skb);
>> +       }
>> +
>>          /* Check if we can use flow to select a queue */
>> -       rxq = skb_get_hash(skb);
>>          if (rxq) {
>> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>>                  queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>>                  goto out;
>>          }
>> @@ -711,11 +762,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
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
>>                  if (ret)
>>                          return ret;
>>
>> @@ -992,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>                  rtnl_unlock();
>>                  return ret;
>>
>> +       case TUNGETVNETHASHCAP:
>> +               return tun_vnet_ioctl_gethashcap(argp);
>> +
>> +       case TUNSETVNETHASH:
>> +               rtnl_lock();
>> +               tap = rtnl_dereference(q->tap);
>> +               ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, true, argp) : -EBADFD;
>> +               rtnl_unlock();
>> +               return ret;
>> +
>>          case SIOCGIFHWADDR:
>>                  rtnl_lock();
>>                  tap = tap_get_tap_dev(q);
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index d8f4d3e996a7a81d1f8b04635054081671a14f07..520013df416e93d3a50b46be9b53ae9ab410eab4 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -209,6 +209,7 @@ struct tun_struct {
>>          struct bpf_prog __rcu *xdp_prog;
>>          struct tun_prog __rcu *steering_prog;
>>          struct tun_prog __rcu *filter_prog;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>          struct ethtool_link_ksettings link_ksettings;
>>          /* init args */
>>          struct file *file;
>> @@ -451,20 +452,37 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
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
>>    * the userspace application move between processors, we may get a
>>    * different rxq no. here.
>>    */
>> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>> +static u16 tun_automq_select_queue(struct tun_struct *tun,
>> +                                  const struct tun_vnet_hash_container *vnet_hash,
>> +                                  struct sk_buff *skb)
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
>> @@ -473,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>                  txq = reciprocal_scale(txq, numqueues);
>>          }
>>
>> +       keys_basic = (struct flow_keys_basic) {
>> +               .control = keys.control,
>> +               .basic = keys.basic
>> +       };
>> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>> +                            tun_add_hash);
>> +
>>          return txq;
>>   }
>>
>> @@ -500,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>>          u16 ret;
>>
>>          rcu_read_lock();
>> -       if (rcu_dereference(tun->steering_prog))
>> +       if (rcu_dereference(tun->steering_prog)) {
>>                  ret = tun_ebpf_select_queue(tun, skb);
>> -       else
>> -               ret = tun_automq_select_queue(tun, skb);
>> +       } else {
>> +               struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
>> +
>> +               if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
>> +                       ret = tun_vnet_rss_select_queue(READ_ONCE(tun->numqueues), vnet_hash,
>> +                                                       skb, tun_add_hash);
>> +               else
>> +                       ret = tun_automq_select_queue(tun, vnet_hash, skb);
>> +       }
>>          rcu_read_unlock();
>>
>>          return ret;
>> @@ -1987,7 +2019,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>>          ssize_t ret;
>>
>>          if (tun->flags & IFF_VNET_HDR) {
>> -               struct virtio_net_hdr gso = { 0 };
>> +               struct virtio_net_hdr_v1_hash gso = { 0 };
>>
>>                  vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>                  ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
>> @@ -2040,9 +2072,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>          }
>>
>>          if (vnet_hdr_sz) {
>> -               struct virtio_net_hdr gso;
>> +               struct virtio_net_hdr_v1_hash gso;
>>
>> -               ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>> +               ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev,
>> +                                           skb, tun_find_hash, &gso);
>>                  if (ret)
>>                          return ret;
>>
>> @@ -2223,6 +2256,7 @@ static void tun_free_netdev(struct net_device *dev)
>>          security_tun_dev_free_security(tun->security);
>>          __tun_set_ebpf(tun, &tun->steering_prog, NULL);
>>          __tun_set_ebpf(tun, &tun->filter_prog, NULL);
>> +       kfree_rcu_mightsleep(rcu_access_pointer(tun->vnet_hash));
>>   }
>>
>>   static void tun_setup(struct net_device *dev)
>> @@ -2921,13 +2955,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>>   }
>>
>>   static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
>> -                       void __user *data)
>> +                       int fd)
>>   {
>>          struct bpf_prog *prog;
>> -       int fd;
>> -
>> -       if (copy_from_user(&fd, data, sizeof(fd)))
>> -               return -EFAULT;
>>
>>          if (fd == -1) {
>>                  prog = NULL;
>> @@ -2993,7 +3023,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          int ifindex;
>>          int sndbuf;
>>          int ret;
>> +       int fd;
>>          bool do_notify = false;
>> +       struct tun_vnet_hash_container *vnet_hash;
>>
>>          if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>>              (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
>> @@ -3020,7 +3052,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          rtnl_lock();
>>
>>          tun = tun_get(tfile);
>> -       if (cmd == TUNSETIFF) {
>> +       switch (cmd) {
>> +       case TUNSETIFF:
>>                  ret = -EEXIST;
>>                  if (tun)
>>                          goto unlock;
>> @@ -3035,8 +3068,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  if (copy_to_user(argp, &ifr, ifreq_len))
>>                          ret = -EFAULT;
>>                  goto unlock;
>> -       }
>> -       if (cmd == TUNSETIFINDEX) {
>> +
>> +       case TUNSETIFINDEX:
>>                  ret = -EPERM;
>>                  if (tun)
>>                          goto unlock;
>> @@ -3050,6 +3083,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  ret = 0;
>>                  tfile->ifindex = ifindex;
>>                  goto unlock;
>> +
>> +       case TUNGETVNETHASHCAP:
>> +               ret = tun_vnet_ioctl_gethashcap(argp);
>> +               goto unlock;
>>          }
>>
>>          ret = -EBADFD;
>> @@ -3230,11 +3267,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  break;
>>
>>          case TUNSETSTEERINGEBPF:
>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +               if (get_user(fd, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               vnet_hash = rtnl_dereference(tun->vnet_hash);
>> +               if (fd != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +                       ret = -EBUSY;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->steering_prog, fd);
>>                  break;
>>
>>          case TUNSETFILTEREBPF:
>> -               ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>> +               if (get_user(fd, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->filter_prog, fd);
>>                  break;
>>
>>          case TUNSETCARRIER:
>> @@ -3252,8 +3305,15 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  ret = open_related_ns(&net->ns, get_net_ns);
>>                  break;
>>
>> +       case TUNSETVNETHASH:
>> +               ret = tun_vnet_ioctl_sethash(&tun->vnet_hash,
>> +                                            !rtnl_dereference(tun->steering_prog),
>> +                                            argp);
>> +               break;
>> +
>>          default:
>> -               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
>> +               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
>> +                                    cmd, argp);
>>                  break;
>>          }
>>
>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>> index 58b9ac7a5fc4084c789fe94fe36b5f8631bf1fa4..8e7d51fb0b4742cef56e7c5ad778b156cc654bed 100644
>> --- a/drivers/net/tun_vnet.h
>> +++ b/drivers/net/tun_vnet.h
>> @@ -6,6 +6,16 @@
>>   #define TUN_VNET_LE     0x80000000
>>   #define TUN_VNET_BE     0x40000000
>>
>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
>> +
>> +struct tun_vnet_hash_container {
>> +       struct tun_vnet_hash common;
> 
> I'd rename this as hash.
> 
>> +       struct tun_vnet_hash_rss rss;
>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>> +       u16 rss_indirection_table[];
>> +};
> 
> Besides the separated ioctl, I'd split this structure into rss and
> hash part as well.
> 
>> +
>>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>   {
>>          bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> @@ -107,6 +117,123 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
>>          }
>>   }
>>
>> +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
>> +{
>> +       static const struct tun_vnet_hash cap = {
>> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>> +               .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>> +       };
>> +
>> +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
> 
> Let's has a consistent name for this and the uapi to be consistent
> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
> tun_vnet_ioctl_gethash().

They have different semantics so they should have different names. 
TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP 
reports the value that can be set later.

> 
>> +}
>> +
>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_container __rcu **hashp,
>> +                                         bool can_rss, void __user *argp)
> 
> So again, can_rss seems to be tricky. Looking at its caller, it tires
> to make eBPF and RSS mutually exclusive. I still don't understand why
> we need this. Allow eBPF program to override some of the path seems to
> be common practice.
> 
> What's more, we didn't try (or even can't) to make automq and eBPF to
> be mutually exclusive. So I still didn't see what we gain from this
> and it complicates the codes and may lead to ambiguous uAPI/behaviour.

automq and eBPF are mutually exclusive; automq is disabled when an eBPF 
steering program is set so I followed the example here.

We don't even have an interface for eBPF to let it fall back to another 
alogirhtm. I could make it fall back to RSS if the eBPF steeering 
program is designed to fall back to automq when it returns e.g., -1. But 
such an interface is currently not defined and defining one is out of 
scope of this patch series.

> 
>> +{
>> +       struct tun_vnet_hash hash_buf;
>> +       struct tun_vnet_hash_container *hash;
>> +
>> +       if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
>> +               return -EFAULT;
>> +       argp = (struct tun_vnet_hash __user *)argp + 1;
>> +
>> +       if (hash_buf.flags & TUN_VNET_HASH_RSS) {
>> +               struct tun_vnet_hash_rss rss;
>> +               size_t indirection_table_size;
>> +               size_t key_size;
>> +               size_t size;
>> +
>> +               if (!can_rss)
>> +                       return -EBUSY;
>> +
>> +               if (copy_from_user(&rss, argp, sizeof(rss)))
>> +                       return -EFAULT;
>> +               argp = (struct tun_vnet_hash_rss __user *)argp + 1;
>> +
>> +               indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
>> +               key_size = virtio_net_hash_key_length(hash_buf.types);
>> +               size = struct_size(hash, rss_indirection_table,
>> +                                  (size_t)rss.indirection_table_mask + 1);
>> +
>> +               hash = kmalloc(size, GFP_KERNEL);
>> +               if (!hash)
>> +                       return -ENOMEM;
>> +
>> +               if (copy_from_user(hash->rss_indirection_table,
>> +                                  argp, indirection_table_size)) {
>> +                       kfree(hash);
>> +                       return -EFAULT;
>> +               }
>> +               argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
>> +
>> +               if (copy_from_user(hash->rss_key, argp, key_size)) {
>> +                       kfree(hash);
>> +                       return -EFAULT;
>> +               }
>> +
>> +               virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
>> +               hash->rss = rss;
>> +       } else {
>> +               hash = kmalloc(sizeof(hash->common), GFP_KERNEL);
>> +               if (!hash)
>> +                       return -ENOMEM;
> 
> Do we need to validate the hash here (at least against the types we supported?)
> 
>> +       }
>> +
>> +       hash->common = hash_buf;
>> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
> 
> I still didn't understand the trick here. E.g we use very simple
> primitives in synchronizing ebpf program through RCU in
> __tun_set_ebpf().

It is even simpler than __tun_set_ebpf(). The differences from 
__tun_set_ebpf() are:
1. This uses the rtnl lock instead of TUN-specific one. It makes the 
code simpler as the rtnl lock is already taken in __tun_chr_ioctl().
2. This does not add rcu_head and uses blocking APIs for simplicity.

> 
>> +       return 0;
>> +}
>> +
>> +static void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
>> +                                struct sk_buff *skb,
>> +                                const struct flow_keys_basic *keys,
>> +                                u32 value,
>> +                                tun_vnet_hash_add vnet_hash_add)
>> +{
>> +       struct virtio_net_hash *report;
>> +
>> +       if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
>> +               return;
>> +
>> +       report = vnet_hash_add(skb);
>> +       if (!report)
>> +               return;
>> +
>> +       *report = (struct virtio_net_hash) {
>> +               .report = virtio_net_hash_report(hash->common.types, keys),
>> +               .value = value
>> +       };
> 
> What's the advantage of using Designated Initializers here? Simple
> assignment can save two lines of code.

It automatically fills other fileds with zero. Simple assignments will 
need more tokens for zeroing.

> 
>> +}
>> +
>> +static u16 tun_vnet_rss_select_queue(u32 numqueues,
>> +                                    const struct tun_vnet_hash_container *hash,
>> +                                    struct sk_buff *skb,
>> +                                    tun_vnet_hash_add vnet_hash_add)
>> +{
>> +       struct virtio_net_hash *report;
>> +       struct virtio_net_hash ret;
>> +       u16 txq, index;
>> +
>> +       if (!numqueues)
>> +               return 0;
>> +
>> +       virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &ret);
>> +
>> +       if (!ret.report)
>> +               return hash->rss.unclassified_queue % numqueues;
>> +
>> +       if (hash->common.flags & TUN_VNET_HASH_REPORT) {
>> +               report = vnet_hash_add(skb);
>> +               if (report)
>> +                       *report = ret;
>> +       }
> 
> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT?
> If yes, it should be a bug.

It is possible to use RSS without TUN_VNET_HASH_REPORT. It is more of a 
feature instead of a bug; it behaves like QEMU's eBPF program but 
requires no privilege and is more optimized with native code and ffs().

> 
>> +
>> +       index = ret.value & hash->rss.indirection_table_mask;
>> +       txq = READ_ONCE(hash->rss_indirection_table[index]);
> 
> So vnet_hash is accessed via rcu_dereference(), I don't get any reason
> we need READ_ONCE here, is this paired with something? If yes, let's
> add a comment here. If rss_indirection_table need why
> indirection_table_mask doesn't need this?

I'll drop it. I think it's just a left-over of previous versions without 
RCU.

> 
>> +
>> +       return txq % numqueues;
>> +}
>> +
>>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>                                     struct iov_iter *from,
>>                                     struct virtio_net_hdr *hdr)
>> @@ -135,15 +262,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>   }
>>
>>   static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>> -                                  const struct virtio_net_hdr *hdr)
>> +                                  const struct virtio_net_hdr_v1_hash *hdr)
>>   {
> 
> To be more robust, we can tweak the function to accept a vnet_hdr_len
> parameter then we can avoid touching this every time when we need to
> extend vnet hdr in the future?

I think you meant vnet_hdr_sz instead of vnet_hdr_len. It is already 
passed just as "sz" here as the function name already says it's about 
the header.

It is possible to add another parameter for sizeof(*hdr) and convert the 
hdr parameter to void * to avoid future changes. But I rather keep it as 
is because the current form ensures the hdr is large enough and 
statically avoids buffer overrun.

> 
>> +       int content_sz = MIN(sizeof(*hdr), sz);
>> +
>>          if (unlikely(iov_iter_count(iter) < sz))
>>                  return -EINVAL;
>>
>> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
>> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) != content_sz))
>>                  return -EFAULT;
>>
>> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>> +       if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
>>                  return -EFAULT;
>>
>>          return 0;
>> @@ -155,26 +284,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
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
>> +
>> +       *hdr = (struct virtio_net_hdr_v1_hash) {
>> +               .hash_report = VIRTIO_NET_HASH_REPORT_NONE
>> +       };
>> +
>> +       if (report) {
>> +               hdr->hash_value = cpu_to_le32(report->value);
>> +               hdr->hash_report = cpu_to_le16(report->report);
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
>> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
>> index 553552fa635c3e1e53d1a63c203d32e4c4fd5a4f..7334c46a3f101675a0d4e5a036987cfe18842f9f 100644
>> --- a/include/linux/if_tap.h
>> +++ b/include/linux/if_tap.h
>> @@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
>>   #define MAX_TAP_QUEUES 256
>>
>>   struct tap_queue;
>> +struct tun_vnet_hash_container;
>>
>>   struct tap_dev {
>>          struct net_device       *dev;
>> @@ -43,6 +44,7 @@ struct tap_dev {
>>          int                     numqueues;
>>          netdev_features_t       tap_features;
>>          int                     minor;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>
>>          void (*update_features)(struct tap_dev *tap, netdev_features_t features);
>>          void (*count_tx_dropped)(struct tap_dev *tap);
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index bb2b751d274acff931281a72e8b4b0c699b4e8af..cdd793f1c360ad5f63fcc4cbf67d845f5e2ccf6f 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -4842,6 +4842,9 @@ enum skb_ext_id {
>>   #endif
>>   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>>          SKB_EXT_MCTP,
>> +#endif
>> +#if IS_ENABLED(CONFIG_TUN)
>> +       SKB_EXT_TUN_VNET_HASH,
>>   #endif
>>          SKB_EXT_NUM, /* must be last */
>>   };
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c9390c289a30545aa7ed23d81c3329d3..4887f97500a870c7ef3c96a5837b2d0a5a225040 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -62,6 +62,42 @@
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
>> + * The argument is a pointer to the compound of the following in order if
>> + * %TUN_VNET_HASH_RSS is set:
>> + *
>> + * 1. &struct tun_vnet_hash
>> + * 2. &struct tun_vnet_hash_rss
>> + * 3. Indirection table
>> + * 4. Key
>> + *
>> + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>> + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>> + * to the size of &struct virtio_net_hdr_v1_hash.
> 
> So you had a dependency check already for vnet hdr len. I'd still
> suggest to split this into rss and hash as they are separated
> features. Then we can use separate data structure for them instead of
> a container struct.

I added a dependency check and found it is complicating the code and 
requires additional tests. I need a reason to justify the complexity if 
we are going to split it.

Regards,
Akihiko Odaki

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
>> + */
>> +#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
>> +
>>   /* TUNSETIFF ifr flags */
>>   #define IFF_TUN                0x0001
>>   #define IFF_TAP                0x0002
>> @@ -115,4 +151,43 @@ struct tun_filter {
>>          __u8   addr[][ETH_ALEN];
>>   };
>>
>> +/**
>> + * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
>> + */
>> +#define TUN_VNET_HASH_REPORT   0x0001
>> +
>> +/**
>> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
>> + *
>> + * This is mutually exclusive with eBPF steering program.
>> + */
>> +#define TUN_VNET_HASH_RSS      0x0002
>> +
>> +/**
>> + * struct tun_vnet_hash - virtio_net hashing configuration
>> + * @flags:
>> + *             Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
>> + * @pad:
>> + *             Should be filled with zero before passing to %TUNSETVNETHASH
>> + * @types:
>> + *             Bitmask of allowed hash types
>> + */
>> +struct tun_vnet_hash {
>> +       __u16 flags;
>> +       __u8 pad[2];
>> +       __u32 types;
>> +};
> 
> Padding in the middle of the structure is not elegant. Any reason for this?
> 
> And hash->types seems never used.
> 
>> +
>> +/**
>> + * struct tun_vnet_hash_rss - virtio_net RSS configuration
>> + * @indirection_table_mask:
>> + *             Bitmask to be applied to the indirection table index
>> + * @unclassified_queue:
>> + *             The index of the queue to place unclassified packets in
>> + */
>> +struct tun_vnet_hash_rss {
>> +       __u16 indirection_table_mask;
>> +       __u16 unclassified_queue;
>> +};
>> +
>>   #endif /* _UAPI__IF_TUN_H */
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 7b03b64fdcb276f68ce881d1d8da8e4c6b897efc..aa2a091b649f0c9d6e0196f34f345ba78b5498fb 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -64,6 +64,7 @@
>>   #include <linux/mpls.h>
>>   #include <linux/kcov.h>
>>   #include <linux/iov_iter.h>
>> +#include <linux/virtio_net.h>
>>
>>   #include <net/protocol.h>
>>   #include <net/dst.h>
>> @@ -4969,6 +4970,9 @@ static const u8 skb_ext_type_len[] = {
>>   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>>          [SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
>>   #endif
>> +#if IS_ENABLED(CONFIG_TUN)
>> +       [SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct virtio_net_hash),
>> +#endif
>>   };
>>
>>   static __always_inline unsigned int skb_ext_total_length(void)
>>
>> --
>> 2.48.1
>>
> 
> Thanks
> 


