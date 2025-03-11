Return-Path: <linux-kselftest+bounces-28695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BDAA5B918
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 07:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EF81895584
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DAA1F874E;
	Tue, 11 Mar 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="s2NAZs6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717791AC88B
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741673838; cv=none; b=uQnm2djdljlk9c5nO8cp9Ul9DhkWh0/IQDcWpWeoSo2j2XeAcsbrK4WvWoMtoNk8kjSfMkNvBu946/L8s2lowjSo7yAOaGlG8ItR+JVkTzWghQDQ/SLEOaFlyBSUjJ+oKzVcv8yqTGfl1je/ZlytgfFAkKoM3Ltr9Rges/b9ExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741673838; c=relaxed/simple;
	bh=R9r1rBWibmAv94azHudx9ivKLmzKdoBEqfAwnNuBdDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt/AqcChsvFcFHlhyYEZ+8yBP3tt+pNaBpOKWgl6HNRvoc6D8aalTkOrhb8NaHp7SyboWrJR1hoHZD7+yYFR6YHq/XCl46w2BdzTgI+bYVoI2Nu+G7upL76mud6eF4Z25Rdsi1r+pcBme4N5tibE5W+pVDbblf8AVcItUIUM0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=s2NAZs6m; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so7818817a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 23:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741673835; x=1742278635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RD7bP5pw3vbDNt310Ng13ZIsCXvFINU6btQBhbTfRaY=;
        b=s2NAZs6mTUA4/PGcoywFvKHLrJOZggNn484UEbjesbUrdBOM88XUI4EGJnpqx1eirG
         Jq31HhHFDPZ/1Z1s0DAOnwd76O0QxkAGl53gYHauZPG9ogYe+wtWZ5bQZD/bFrRype7/
         WykaNEZCbzzFmYg5vW+fuZo2xX1al7Ei4IAHgyTdZlnjxzAGRN+QiJQ7g8enyFaBl81y
         cqELFDNe/8HTLX23RLIlK5MeOr/diURAxDJIiY8P5kQO2s1Bs8DHoBOlrvt93FhpYNrJ
         R/rQw87FsldIkJ18MJ50QqB3r9x1Xjg0AntqbS4+xVbKl+izDhLqXaGrkijNiPK57jtE
         BrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741673835; x=1742278635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD7bP5pw3vbDNt310Ng13ZIsCXvFINU6btQBhbTfRaY=;
        b=SHHNzo43oj61TUjgijI6mGBY1uCf5Obm0ENso02Rg288Rq9TE/MWqahSWujuuaiTJr
         2chZCki90OJ5YwsatstSXtvRWmFbrQFQQxufWOJ1f/mjfS1judKjpcxNDOBSunDa99v4
         O4vmLgQ1lY/p7eH1hOsa7cM582MfUzHkwMEsAJOp6/CO1jVSigw9r+/aqA0rCI50Ih4g
         uW653uZZuyECz2uXG8FnzhAOE2qRuoSQjxjnldrXHTRAYiaIley+nnSZTpCp3REElcFq
         gRvuc3owsa/CkeKG63bY4gZD5+ZuXL9KZPbc+IEDDYTi6MlmXVa8at2gfNWIOtydDaUa
         gEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcvFmenyK6p/M7e46gsaWW8/55QOlmahdwIKoawECRVOQD6t573BBgu0TXA00zRcuTJ3kkBh+IGPezVUJ7do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJIkmKmtkzSS0mIaJEKE8E8K1W45riDHLfF/kDhBrgFgYBuhO
	Hbd9IWJ958AnegGVYs999o2EMhpCNIvXjmOWDdCyxZOjCxZxxQDo1u3ksS4W0bY=
X-Gm-Gg: ASbGncu4s8115OdkoeWUnzoHIQTbsOo7y4V1sGtQbSKXO0YcLmdmnVEsWfCF2BGAGBK
	WxvmcdYxY4NAJH5Eo+pzsMSmIsMFcI2jXCfogIA1N9nVG5vTceLFFCdNjEO41U1ElDHt8K7mMMz
	zo/4IHJNe2KmbL0yvbvSEgH5FhUmNtAOQv7sEtdhYi3jKJCtWqbgIDea340ForfXq8pVHSr5iOs
	xtiXkKvMRZ9sRJfcyqfWTmctB5N5u5cYdavodEhdm5DEbntc2zB4AiJeIRfRocMeoB45XlSQMVp
	ezILqTC7fTsiknNQc544ulcoA+YDjQ+DONZw/vvMlJ413DRLGlUN/rQX+A==
X-Google-Smtp-Source: AGHT+IGbbZs0QMtI1v684lzv7Afq3Pb0tTDiRSacmyYrCHehaLC7EUydEF83q+zHxNp5nqG8LnGZfw==
X-Received: by 2002:a17:90b:1f8d:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-300ff10566amr3387729a91.20.1741673834617;
        Mon, 10 Mar 2025 23:17:14 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e73eesm9101725a91.36.2025.03.10.23.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:17:14 -0700 (PDT)
Message-ID: <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
Date: Tue, 11 Mar 2025 15:17:08 +0900
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
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
 <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/11 9:38, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/10 12:55, Jason Wang wrote:
>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> Hash reporting
>>>> ==============
>>>>
>>>> Allow the guest to reuse the hash value to make receive steering
>>>> consistent between the host and guest, and to save hash computation.
>>>>
>>>> RSS
>>>> ===
>>>>
>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>> However, computing the hash after the queue was chosen defeats the
>>>> purpose of RSS.
>>>>
>>>> Another approach is to use eBPF steering program. This approach has
>>>> another downside: it cannot report the calculated hash due to the
>>>> restrictive nature of eBPF steering program.
>>>>
>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>> program so that it will be able to report to the userspace, but I didn't
>>>> opt for it because extending the current mechanism of eBPF steering
>>>> program as is because it relies on legacy context rewriting, and
>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>> UAPIs.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>> ---
>>>>    Documentation/networking/tuntap.rst |   7 ++
>>>>    drivers/net/Kconfig                 |   1 +
>>>>    drivers/net/tap.c                   |  68 ++++++++++++++-
>>>>    drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>>    drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>>    include/linux/if_tap.h              |   2 +
>>>>    include/linux/skbuff.h              |   3 +
>>>>    include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>>    net/core/skbuff.c                   |   4 +
>>>>    9 files changed, 386 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558920be42ce0d4217465 100644
>>>> --- a/Documentation/networking/tuntap.rst
>>>> +++ b/Documentation/networking/tuntap.rst
>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>>>          return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>>>      }
>>>>
>>>> +3.4 Reference
>>>> +-------------
>>>> +
>>>> +``linux/if_tun.h`` defines the interface described below:
>>>> +
>>>> +.. kernel-doc:: include/uapi/linux/if_tun.h
>>>> +
>>>>    Universal TUN/TAP device driver Frequently Asked Question
>>>>    =========================================================
>>>>
>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>> index 1fd5acdc73c6af0e1a861867039c3624fc618e25..aecfd244dd83585fea2c5b815dcd787c58166c28 100644
>>>> --- a/drivers/net/Kconfig
>>>> +++ b/drivers/net/Kconfig
>>>> @@ -395,6 +395,7 @@ config TUN
>>>>           tristate "Universal TUN/TAP device driver support"
>>>>           depends on INET
>>>>           select CRC32
>>>> +       select SKB_EXTENSIONS
>>>>           help
>>>>             TUN/TAP provides packet reception and transmission for user space
>>>>             programs.  It can be viewed as a simple Point-to-Point or Ethernet
>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>>>> index d4ece538f1b23789ca60caa6232690e4d0a4d14a..9428b63ec27e7f92e78a78afcb5e24383862c00d 100644
>>>> --- a/drivers/net/tap.c
>>>> +++ b/drivers/net/tap.c
>>>> @@ -49,6 +49,10 @@ struct major_info {
>>>>           struct list_head next;
>>>>    };
>>>>
>>>> +struct tap_skb_cb {
>>>> +       struct virtio_net_hash hash;
>>>> +};
>>>> +
>>>>    #define GOODCOPY_LEN 128
>>>>
>>>>    static const struct proto_ops tap_socket_ops;
>>>> @@ -179,6 +183,22 @@ static void tap_put_queue(struct tap_queue *q)
>>>>           sock_put(&q->sk);
>>>>    }
>>>>
>>>> +static struct tap_skb_cb *tap_skb_cb(const struct sk_buff *skb)
>>>> +{
>>>> +       BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct tap_skb_cb));
>>>> +       return (struct tap_skb_cb *)skb->cb;
>>>> +}
>>>> +
>>>> +static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
>>>> +{
>>>> +       return &tap_skb_cb(skb)->hash;
>>>> +}
>>>> +
>>>> +static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
>>>> +{
>>>> +       return &tap_skb_cb(skb)->hash;
>>>> +}
>>>> +
>>>>    /*
>>>>     * Select a queue based on the rxq of the device on which this packet
>>>>     * arrived. If the incoming device is not mq, calculate a flow hash
>>>> @@ -189,6 +209,7 @@ static void tap_put_queue(struct tap_queue *q)
>>>>    static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>>>                                          struct sk_buff *skb)
>>>>    {
>>>> +       struct flow_keys_basic keys_basic;
>>>>           struct tap_queue *queue = NULL;
>>>>           /* Access to taps array is protected by rcu, but access to numvtaps
>>>>            * isn't. Below we use it to lookup a queue, but treat it as a hint
>>>> @@ -196,17 +217,47 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>>>            * racing against queue removal.
>>>>            */
>>>>           int numvtaps = READ_ONCE(tap->numvtaps);
>>>> +       struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
>>>>           __u32 rxq;
>>>>
>>>> +       *tap_skb_cb(skb) = (struct tap_skb_cb) {
>>>> +               .hash = { .report = VIRTIO_NET_HASH_REPORT_NONE }
>>>> +       };
>>>> +
>>>>           if (!numvtaps)
>>>>                   goto out;
>>>>
>>>>           if (numvtaps == 1)
>>>>                   goto single;
>>>>
>>>> +       if (vnet_hash) {
>>>> +               if ((vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>>>> +                       rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
>>>> +                       queue = rcu_dereference(tap->taps[rxq]);
>>>> +                       goto out;
>>>> +               }
>>>> +
>>>> +               if (!skb->l4_hash && !skb->sw_hash) {
>>>> +                       struct flow_keys keys;
>>>> +
>>>> +                       skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>>>> +                       rxq = flow_hash_from_keys(&keys);
>>>> +                       keys_basic = (struct flow_keys_basic) {
>>>> +                               .control = keys.control,
>>>> +                               .basic = keys.basic
>>>> +                       };
>>>> +               } else {
>>>> +                       skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
>>>> +                                                        FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
>>>> +                       rxq = skb->hash;
>>>> +               }
>>>> +       } else {
>>>> +               rxq = skb_get_hash(skb);
>>>> +       }
>>>> +
>>>>           /* Check if we can use flow to select a queue */
>>>> -       rxq = skb_get_hash(skb);
>>>>           if (rxq) {
>>>> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>>>>                   queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>>>>                   goto out;
>>>>           }
>>>> @@ -711,11 +762,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
>>>>           int total;
>>>>
>>>>           if (q->flags & IFF_VNET_HDR) {
>>>> -               struct virtio_net_hdr vnet_hdr;
>>>> +               struct virtio_net_hdr_v1_hash vnet_hdr;
>>>>
>>>>                   vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>>>>
>>>> -               ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
>>>> +               ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
>>>> +                                           tap_find_hash, &vnet_hdr);
>>>>                   if (ret)
>>>>                           return ret;
>>>>
>>>> @@ -992,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>>>                   rtnl_unlock();
>>>>                   return ret;
>>>>
>>>> +       case TUNGETVNETHASHCAP:
>>>> +               return tun_vnet_ioctl_gethashcap(argp);
>>>> +
>>>> +       case TUNSETVNETHASH:
>>>> +               rtnl_lock();
>>>> +               tap = rtnl_dereference(q->tap);
>>>> +               ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, true, argp) : -EBADFD;
>>>> +               rtnl_unlock();
>>>> +               return ret;
>>>> +
>>>>           case SIOCGIFHWADDR:
>>>>                   rtnl_lock();
>>>>                   tap = tap_get_tap_dev(q);
>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>>> index d8f4d3e996a7a81d1f8b04635054081671a14f07..520013df416e93d3a50b46be9b53ae9ab410eab4 100644
>>>> --- a/drivers/net/tun.c
>>>> +++ b/drivers/net/tun.c
>>>> @@ -209,6 +209,7 @@ struct tun_struct {
>>>>           struct bpf_prog __rcu *xdp_prog;
>>>>           struct tun_prog __rcu *steering_prog;
>>>>           struct tun_prog __rcu *filter_prog;
>>>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>>>           struct ethtool_link_ksettings link_ksettings;
>>>>           /* init args */
>>>>           struct file *file;
>>>> @@ -451,20 +452,37 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>>>>                   e->rps_rxhash = hash;
>>>>    }
>>>>
>>>> +static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
>>>> +{
>>>> +       return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
>>>> +}
>>>> +
>>>> +static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
>>>> +{
>>>> +       return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
>>>> +}
>>>> +
>>>>    /* We try to identify a flow through its rxhash. The reason that
>>>>     * we do not check rxq no. is because some cards(e.g 82599), chooses
>>>>     * the rxq based on the txq where the last packet of the flow comes. As
>>>>     * the userspace application move between processors, we may get a
>>>>     * different rxq no. here.
>>>>     */
>>>> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>>> +static u16 tun_automq_select_queue(struct tun_struct *tun,
>>>> +                                  const struct tun_vnet_hash_container *vnet_hash,
>>>> +                                  struct sk_buff *skb)
>>>>    {
>>>> +       struct flow_keys keys;
>>>> +       struct flow_keys_basic keys_basic;
>>>>           struct tun_flow_entry *e;
>>>>           u32 txq, numqueues;
>>>>
>>>>           numqueues = READ_ONCE(tun->numqueues);
>>>>
>>>> -       txq = __skb_get_hash_symmetric(skb);
>>>> +       memset(&keys, 0, sizeof(keys));
>>>> +       skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0);
>>>> +
>>>> +       txq = flow_hash_from_keys(&keys);
>>>>           e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
>>>>           if (e) {
>>>>                   tun_flow_save_rps_rxhash(e, txq);
>>>> @@ -473,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>>>                   txq = reciprocal_scale(txq, numqueues);
>>>>           }
>>>>
>>>> +       keys_basic = (struct flow_keys_basic) {
>>>> +               .control = keys.control,
>>>> +               .basic = keys.basic
>>>> +       };
>>>> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>>>> +                            tun_add_hash);
>>>> +
>>>>           return txq;
>>>>    }
>>>>
>>>> @@ -500,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>>>>           u16 ret;
>>>>
>>>>           rcu_read_lock();
>>>> -       if (rcu_dereference(tun->steering_prog))
>>>> +       if (rcu_dereference(tun->steering_prog)) {
>>>>                   ret = tun_ebpf_select_queue(tun, skb);
>>>> -       else
>>>> -               ret = tun_automq_select_queue(tun, skb);
>>>> +       } else {
>>>> +               struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
>>>> +
>>>> +               if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
>>>> +                       ret = tun_vnet_rss_select_queue(READ_ONCE(tun->numqueues), vnet_hash,
>>>> +                                                       skb, tun_add_hash);
>>>> +               else
>>>> +                       ret = tun_automq_select_queue(tun, vnet_hash, skb);
>>>> +       }
>>>>           rcu_read_unlock();
>>>>
>>>>           return ret;
>>>> @@ -1987,7 +2019,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>>>>           ssize_t ret;
>>>>
>>>>           if (tun->flags & IFF_VNET_HDR) {
>>>> -               struct virtio_net_hdr gso = { 0 };
>>>> +               struct virtio_net_hdr_v1_hash gso = { 0 };
>>>>
>>>>                   vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>>                   ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
>>>> @@ -2040,9 +2072,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>>>           }
>>>>
>>>>           if (vnet_hdr_sz) {
>>>> -               struct virtio_net_hdr gso;
>>>> +               struct virtio_net_hdr_v1_hash gso;
>>>>
>>>> -               ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>>>> +               ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev,
>>>> +                                           skb, tun_find_hash, &gso);
>>>>                   if (ret)
>>>>                           return ret;
>>>>
>>>> @@ -2223,6 +2256,7 @@ static void tun_free_netdev(struct net_device *dev)
>>>>           security_tun_dev_free_security(tun->security);
>>>>           __tun_set_ebpf(tun, &tun->steering_prog, NULL);
>>>>           __tun_set_ebpf(tun, &tun->filter_prog, NULL);
>>>> +       kfree_rcu_mightsleep(rcu_access_pointer(tun->vnet_hash));
>>>>    }
>>>>
>>>>    static void tun_setup(struct net_device *dev)
>>>> @@ -2921,13 +2955,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>>>>    }
>>>>
>>>>    static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
>>>> -                       void __user *data)
>>>> +                       int fd)
>>>>    {
>>>>           struct bpf_prog *prog;
>>>> -       int fd;
>>>> -
>>>> -       if (copy_from_user(&fd, data, sizeof(fd)))
>>>> -               return -EFAULT;
>>>>
>>>>           if (fd == -1) {
>>>>                   prog = NULL;
>>>> @@ -2993,7 +3023,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>           int ifindex;
>>>>           int sndbuf;
>>>>           int ret;
>>>> +       int fd;
>>>>           bool do_notify = false;
>>>> +       struct tun_vnet_hash_container *vnet_hash;
>>>>
>>>>           if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>>>>               (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
>>>> @@ -3020,7 +3052,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>           rtnl_lock();
>>>>
>>>>           tun = tun_get(tfile);
>>>> -       if (cmd == TUNSETIFF) {
>>>> +       switch (cmd) {
>>>> +       case TUNSETIFF:
>>>>                   ret = -EEXIST;
>>>>                   if (tun)
>>>>                           goto unlock;
>>>> @@ -3035,8 +3068,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>                   if (copy_to_user(argp, &ifr, ifreq_len))
>>>>                           ret = -EFAULT;
>>>>                   goto unlock;
>>>> -       }
>>>> -       if (cmd == TUNSETIFINDEX) {
>>>> +
>>>> +       case TUNSETIFINDEX:
>>>>                   ret = -EPERM;
>>>>                   if (tun)
>>>>                           goto unlock;
>>>> @@ -3050,6 +3083,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>                   ret = 0;
>>>>                   tfile->ifindex = ifindex;
>>>>                   goto unlock;
>>>> +
>>>> +       case TUNGETVNETHASHCAP:
>>>> +               ret = tun_vnet_ioctl_gethashcap(argp);
>>>> +               goto unlock;
>>>>           }
>>>>
>>>>           ret = -EBADFD;
>>>> @@ -3230,11 +3267,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>                   break;
>>>>
>>>>           case TUNSETSTEERINGEBPF:
>>>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>> +               if (get_user(fd, (int __user *)argp)) {
>>>> +                       ret = -EFAULT;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               vnet_hash = rtnl_dereference(tun->vnet_hash);
>>>> +               if (fd != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>>>> +                       ret = -EBUSY;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               ret = tun_set_ebpf(tun, &tun->steering_prog, fd);
>>>>                   break;
>>>>
>>>>           case TUNSETFILTEREBPF:
>>>> -               ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>>>> +               if (get_user(fd, (int __user *)argp)) {
>>>> +                       ret = -EFAULT;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               ret = tun_set_ebpf(tun, &tun->filter_prog, fd);
>>>>                   break;
>>>>
>>>>           case TUNSETCARRIER:
>>>> @@ -3252,8 +3305,15 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>>>                   ret = open_related_ns(&net->ns, get_net_ns);
>>>>                   break;
>>>>
>>>> +       case TUNSETVNETHASH:
>>>> +               ret = tun_vnet_ioctl_sethash(&tun->vnet_hash,
>>>> +                                            !rtnl_dereference(tun->steering_prog),
>>>> +                                            argp);
>>>> +               break;
>>>> +
>>>>           default:
>>>> -               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
>>>> +               ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
>>>> +                                    cmd, argp);
>>>>                   break;
>>>>           }
>>>>
>>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>>>> index 58b9ac7a5fc4084c789fe94fe36b5f8631bf1fa4..8e7d51fb0b4742cef56e7c5ad778b156cc654bed 100644
>>>> --- a/drivers/net/tun_vnet.h
>>>> +++ b/drivers/net/tun_vnet.h
>>>> @@ -6,6 +6,16 @@
>>>>    #define TUN_VNET_LE     0x80000000
>>>>    #define TUN_VNET_BE     0x40000000
>>>>
>>>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>>>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
>>>> +
>>>> +struct tun_vnet_hash_container {
>>>> +       struct tun_vnet_hash common;
>>>
>>> I'd rename this as hash.
>>>
>>>> +       struct tun_vnet_hash_rss rss;
>>>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>>> +       u16 rss_indirection_table[];
>>>> +};
>>>
>>> Besides the separated ioctl, I'd split this structure into rss and
>>> hash part as well.
>>>
>>>> +
>>>>    static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>>>    {
>>>>           bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>>>> @@ -107,6 +117,123 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
>>>>           }
>>>>    }
>>>>
>>>> +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
>>>> +{
>>>> +       static const struct tun_vnet_hash cap = {
>>>> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>>>> +               .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>>> +       };
>>>> +
>>>> +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
>>>
>>> Let's has a consistent name for this and the uapi to be consistent
>>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
>>> tun_vnet_ioctl_gethash().
>>
>> They have different semantics so they should have different names.
>> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
>> reports the value that can be set later.
> 
> I'm not sure I will get here. I meant a symmetric name
> 
> TUNSETVNETHASH and TUNVETVNETHASH.

TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence 
of ioctl names is as follows:
TUNGETFEATURES - TUNGETVNETHASHCAP
TUNSETIFF - TUNSETVNETHASH
TUNGETIFF - no corresponding ioctl for the virtio-net hash features

Regards,
Akihiko Odaki

