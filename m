Return-Path: <linux-kselftest+bounces-19598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD0099B2FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB8A1C217A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC05154458;
	Sat, 12 Oct 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZnHzhFdB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A611531C0
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728948; cv=none; b=jPuNH1c1iY4uJvub7leqbd/8C5RAwNqehKoPpYwFFDOkr/duilJj1RVSdhL3CNauA21aFmb1EB8/yqHQEInI4qXaD9k4MCg5wcapCnVqQPXrwAza3S3ahil+qXrH9/eo8DslBDL8u/k+jUvmSstuFewpKi1fSMI0mghWFwssoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728948; c=relaxed/simple;
	bh=WiKyN1r6GQqYAkFyHWEFvYWPIZ/lS/vplAE9Zn4Qw0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q999vGjBfLs4bHXsqkbTeDLGxA85tTvn+5pKv6X4+z/HWv2E2iv+QqD3VxxvCgmd+V4p9Cm8rBSaSBSP5VZC4lK5pT1iIaC9ox/jgfKuAGU5qaDdOWaqrT/+uQZN+L0HmOTGfAfXl9AGk03ip4nsiRYDXwzhY6ZrnugEf8Q6gaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZnHzhFdB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca388d242so10509205ad.2
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728728946; x=1729333746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZvDBiukxFmcHL2yTtP3l73CJ9pdkN7XygsojY6f2k=;
        b=ZnHzhFdBYgx6AXvLCwAOLHC5livs77bmZINYJGFUuSOIL2kQWO/yNUkuqVzNF6fk3A
         /OexmZNBH/tR540WDc0eGxjMSjrA5dCnZijVA9mNqqjWLXjRTY+EDradM5ll2tkcrWra
         ZHaakKavQADpIlxB/628lktMYJAdTCkJIMwir5BSDzL0FfpRnBUK1VF2bj/72N8I7YW/
         PUXdm6OhgfJPIrT29OZ2RGfmxhEdQR7K3kf0/BsHqRUlZxzGnB0kd5vH2PLhUhhNK1WP
         IqUWDQe/huKuOebB4wJxm8SAgXg8yFyzyh3GIibga3q1jH+w+MEZt59+DhEvDjiwC3Bp
         7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728946; x=1729333746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZvDBiukxFmcHL2yTtP3l73CJ9pdkN7XygsojY6f2k=;
        b=a5TB8SllA4oj7xh/QOf7KWcaLSMEA9A+unKBsxWlfBk4xmT4Jn0bHxWba4Eh+iW1Qx
         8aF6Qwd0gZCqecMAmVICiqNKsYt1KFBCwOJSJ0sytgXvXZogJVfr695XSiNMWtdJpfUu
         NyWDWhXNPCFtT+PsiwEjVQ+RmGTYUoX7iwx+i7nOl9an5UlxgeNTicE1xZMEikNiS2Jz
         LIkDa0F8Du56QnhtKJvuJkcw0u/W8D6bswzK843LsePej+E1OQ812csq7f2Ooj2db/1J
         XwrcoIDC5zT3I+0k1PwFLQer0oxvgy/NK0KS7jihJF0b3RmMNS+s9TH2BUgN9mUwUSaw
         Yj7w==
X-Forwarded-Encrypted: i=1; AJvYcCUWuiDvyvLWPl/4AaLtVIRDdpK2T2L+H/4zwvAz57j3dKCvV0hvHi3geIKOTvnYo5QiSislDN6WuJgXJGJcfos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7PKDaTRM4+HAv0MivFQBYUeE6Ena3RmY/JowIg077ehKW3Y4
	EOyJKqYcbD7/jIq0NroXRE664jF9YDGs5/tBCWQXI5EGmfWSy5MnTuKfvDiocD0=
X-Google-Smtp-Source: AGHT+IHyzCVza25JQxIftgzAHdwfwKeAPPD4DPc7eG6fDIYxhlQN/1N003jTi2Dokjo73H9YOSYMxA==
X-Received: by 2002:a17:903:2342:b0:202:13ca:d73e with SMTP id d9443c01a7336-20cbb1a967emr40579705ad.28.1728728945900;
        Sat, 12 Oct 2024 03:29:05 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c215f0esm35124005ad.219.2024.10.12.03.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:29:05 -0700 (PDT)
Message-ID: <4bc7dfaa-a7cd-41f4-a917-e71b5c7241f7@daynix.com>
Date: Sat, 12 Oct 2024 19:29:01 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 07/10] tun: Introduce virtio-net RSS
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
 <20241008-rss-v5-7-f3cf68df005d@daynix.com>
 <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/09 17:14, Jason Wang wrote:
> On Tue, Oct 8, 2024 at 2:55 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
>> ---
>>   drivers/net/tap.c           | 11 +++++-
>>   drivers/net/tun.c           | 57 ++++++++++++++++++++-------
>>   drivers/net/tun_vnet.h      | 96 +++++++++++++++++++++++++++++++++++++++++----
>>   include/linux/if_tap.h      |  4 +-
>>   include/uapi/linux/if_tun.h | 27 +++++++++++++
>>   5 files changed, 169 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 5e2fbe63ca47..a58b83285af4 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -207,6 +207,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>           * racing against queue removal.
>>           */
>>          int numvtaps = READ_ONCE(tap->numvtaps);
>> +       struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
>>          __u32 rxq;
>>
>>          *tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
>> @@ -217,6 +218,12 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>          if (numvtaps == 1)
>>                  goto single;
>>
>> +       if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +               rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
>> +               queue = rcu_dereference(tap->taps[rxq]);
>> +               goto out;
>> +       }
>> +
>>          if (!skb->l4_hash && !skb->sw_hash) {
>>                  struct flow_keys keys;
>>
>> @@ -234,7 +241,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>
>>          /* Check if we can use flow to select a queue */
>>          if (rxq) {
>> -               tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>>                  queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>>                  goto out;
>>          }
>> @@ -1058,7 +1065,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>                  tap = rtnl_dereference(q->tap);
>>                  ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
>>                                       tap ? &tap->vnet_hash : NULL, -EINVAL,
>> -                                    cmd, sp);
>> +                                    true, cmd, sp);
>>                  rtnl_unlock();
>>                  return ret;
>>          }
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 27308417b834..18528568aed7 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -209,7 +209,7 @@ struct tun_struct {
>>          struct bpf_prog __rcu *xdp_prog;
>>          struct tun_prog __rcu *steering_prog;
>>          struct tun_prog __rcu *filter_prog;
>> -       struct tun_vnet_hash vnet_hash;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>          struct ethtool_link_ksettings link_ksettings;
>>          /* init args */
>>          struct file *file;
>> @@ -468,7 +468,9 @@ static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
>>    * the userspace application move between processors, we may get a
>>    * different rxq no. here.
>>    */
>> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>> +static u16 tun_automq_select_queue(struct tun_struct *tun,
>> +                                  const struct tun_vnet_hash_container *vnet_hash,
>> +                                  struct sk_buff *skb)
>>   {
>>          struct flow_keys keys;
>>          struct flow_keys_basic keys_basic;
>> @@ -493,7 +495,7 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>                  .control = keys.control,
>>                  .basic = keys.basic
>>          };
>> -       tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>>                               tun_add_hash);
>>
>>          return txq;
>> @@ -523,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
>> @@ -2248,6 +2257,9 @@ static void tun_free_netdev(struct net_device *dev)
>>          security_tun_dev_free_security(tun->security);
>>          __tun_set_ebpf(tun, &tun->steering_prog, NULL);
>>          __tun_set_ebpf(tun, &tun->filter_prog, NULL);
>> +       rtnl_lock();
>> +       kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
>> +       rtnl_unlock();
>>   }
>>
>>   static void tun_setup(struct net_device *dev)
>> @@ -2946,13 +2958,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
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
>> @@ -3019,6 +3027,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          int sndbuf;
>>          int ret;
>>          bool do_notify = false;
>> +       struct tun_vnet_hash_container *vnet_hash;
>>
>>          if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>>              (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
>> @@ -3078,7 +3087,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          }
>>
>>          if (!tun) {
>> -               ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, argp);
>> +               ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, cmd, argp);
>>                  goto unlock;
>>          }
>>
>> @@ -3256,11 +3265,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  break;
>>
>>          case TUNSETSTEERINGEBPF:
>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +               if (get_user(ret, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               vnet_hash = rtnl_dereference(tun->vnet_hash);
>> +               if (ret != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +                       ret = -EBUSY;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->steering_prog, ret);
>>                  break;
>>
>>          case TUNSETFILTEREBPF:
>> -               ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>> +               if (get_user(ret, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->filter_prog, ret);
>>                  break;
>>
>>          case TUNSETCARRIER:
>> @@ -3280,7 +3305,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>
>>          default:
>>                  ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
>> -                                    &tun->vnet_hash, -EINVAL, cmd, argp);
>> +                                    &tun->vnet_hash, -EINVAL,
>> +                                    !rtnl_dereference(tun->steering_prog),
>> +                                    cmd, argp);
>>          }
>>
>>          if (do_notify)
>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>> index 589a97dd7d02..f5de4fe9d14e 100644
>> --- a/drivers/net/tun_vnet.h
>> +++ b/drivers/net/tun_vnet.h
>> @@ -9,6 +9,13 @@
>>   typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>>   typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
>>
>> +struct tun_vnet_hash_container {
>> +       struct tun_vnet_hash common;
>> +       struct tun_vnet_hash_rss rss;
>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>> +       u16 rss_indirection_table[];
>> +};
>> +
>>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>   {
>>          return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
>> @@ -62,14 +69,16 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
>>   }
>>
>>   static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>> -                                 struct tun_vnet_hash *hash, long fallback,
>> +                                 struct tun_vnet_hash_container __rcu **hashp,
>> +                                 long fallback, bool can_rss,
>>                                    unsigned int cmd, void __user *argp)
>>   {
>>          static const struct tun_vnet_hash cap = {
>> -               .flags = TUN_VNET_HASH_REPORT,
>> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>>                  .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>          };
>>          struct tun_vnet_hash hash_buf;
>> +       struct tun_vnet_hash_container *hash;
>>          int __user *sp = argp;
>>          int s;
>>
>> @@ -132,13 +141,57 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>                  return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
>>
>>          case TUNSETVNETHASH:
>> -               if (!hash)
>> +               if (!hashp)
>>                          return -EBADFD;
>>
>>                  if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
>>                          return -EFAULT;
>> +               argp = (struct tun_vnet_hash __user *)argp + 1;
>> +
>> +               if (hash_buf.flags & TUN_VNET_HASH_RSS) {
>> +                       struct tun_vnet_hash_rss rss;
>> +                       size_t indirection_table_size;
>> +                       size_t key_size;
>> +                       size_t size;
>> +
>> +                       if (!can_rss)
>> +                               return -EBUSY;
>> +
>> +                       if (copy_from_user(&rss, argp, sizeof(rss)))
> 
> This seems to be a change of the uAPI of TUNSETVNETHASH.
> 
>> +                               return -EFAULT;
>> +                       argp = (struct tun_vnet_hash_rss __user *)argp + 1;
>> +
>> +                       indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
>> +                       key_size = virtio_net_hash_key_length(hash_buf.types);
>> +                       size = struct_size(hash, rss_indirection_table,
>> +                                          (size_t)rss.indirection_table_mask + 1);
>> +
>> +                       hash = kmalloc(size, GFP_KERNEL);
>> +                       if (!hash)
>> +                               return -ENOMEM;
>> +
>> +                       if (copy_from_user(hash->rss_indirection_table,
>> +                                          argp, indirection_table_size)) {
>> +                               kfree(hash);
>> +                               return -EFAULT;
>> +                       }
>> +                       argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
>> +
>> +                       if (copy_from_user(hash->rss_key, argp, key_size)) {
>> +                               kfree(hash);
>> +                               return -EFAULT;
>> +                       }
>> +
>> +                       virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
>> +                       hash->rss = rss;
>> +               } else {
>> +                       hash = kmalloc(sizeof(hash->common), GFP_KERNEL);
>> +                       if (!hash)
>> +                               return -ENOMEM;
>> +               }
>>
>> -               *hash = hash_buf;
>> +               hash->common = hash_buf;
>> +               kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
>>                  return 0;
>>
>>          default:
>> @@ -146,7 +199,7 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>          }
>>   }
>>
>> -static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
>>                                          struct sk_buff *skb,
>>                                          const struct flow_keys_basic *keys,
>>                                          u32 value,
>> @@ -154,7 +207,7 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>>   {
>>          struct virtio_net_hash *report;
>>
>> -       if (!(hash->flags & TUN_VNET_HASH_REPORT))
>> +       if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
>>                  return;
>>
>>          report = vnet_hash_add(skb);
>> @@ -162,11 +215,40 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>>                  return;
>>
>>          *report = (struct virtio_net_hash) {
>> -               .report = virtio_net_hash_report(hash->types, keys),
>> +               .report = virtio_net_hash_report(hash->common.types, keys),
>>                  .value = value
>>          };
>>   }
>>
>> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
>> +                                           const struct tun_vnet_hash_container *hash,
>> +                                           struct sk_buff *skb,
>> +                                           tun_vnet_hash_add vnet_hash_add)
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
>> +
>> +       index = ret.value & hash->rss.indirection_table_mask;
>> +       txq = READ_ONCE(hash->rss_indirection_table[index]);
>> +
>> +       return txq % numqueues;
>> +}
>> +
>>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>                                     struct iov_iter *from,
>>                                     struct virtio_net_hdr *hdr)
>> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
>> index 5bbb343a6dba..7334c46a3f10 100644
>> --- a/include/linux/if_tap.h
>> +++ b/include/linux/if_tap.h
>> @@ -4,7 +4,6 @@
>>
>>   #include <net/sock.h>
>>   #include <linux/skb_array.h>
>> -#include <uapi/linux/if_tun.h>
>>
>>   struct file;
>>   struct socket;
>> @@ -32,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
>>   #define MAX_TAP_QUEUES 256
>>
>>   struct tap_queue;
>> +struct tun_vnet_hash_container;
>>
>>   struct tap_dev {
>>          struct net_device       *dev;
>> @@ -44,7 +44,7 @@ struct tap_dev {
>>          int                     numqueues;
>>          netdev_features_t       tap_features;
>>          int                     minor;
>> -       struct tun_vnet_hash    vnet_hash;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>
>>          void (*update_features)(struct tap_dev *tap, netdev_features_t features);
>>          void (*count_tx_dropped)(struct tap_dev *tap);
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index d11e79b4e0dc..4887f97500a8 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -75,6 +75,14 @@
>>    *
>>    * The argument is a pointer to &struct tun_vnet_hash.
>>    *
>> + * The argument is a pointer to the compound of the following in order if
>> + * %TUN_VNET_HASH_RSS is set:
>> + *
>> + * 1. &struct tun_vnet_hash
>> + * 2. &struct tun_vnet_hash_rss
>> + * 3. Indirection table
>> + * 4. Key
>> + *
> 
> Let's try not modify uAPI. We can introduce new ioctl if necessary.

2, 3, and 4 are new additions. Adding a separate ioctl for them means we 
need to call two ioctls to configure RSS and it is hard to design the 
interactions with them.

For example, if we set TUN_VNET_HASH_RSS with TUNSETVNETHASH before 
setting struct tun_vnet_hash_rss with another ioctl, tuntap will enable 
RSS with undefined parameters. Setting struct tun_vnet_hash_rss with 
TUN_VNET_HASH_RSS unset also sounds unreasnoable.

Letting the new ioctl set TUN_VNET_HASH_RSS does not help either. 
TUNSETVNETHASH still sets the bitmask of allowed hash types so RSS will 
depend on two ioctls.

> 
>>    * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>>    * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>>    * to the size of &struct virtio_net_hdr_v1_hash.
>> @@ -148,6 +156,13 @@ struct tun_filter {
>>    */
>>   #define TUN_VNET_HASH_REPORT   0x0001
>>
>> +/**
>> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
>> + *
>> + * This is mutually exclusive with eBPF steering program.
>> + */
>> +#define TUN_VNET_HASH_RSS      0x0002
>> +
>>   /**
>>    * struct tun_vnet_hash - virtio_net hashing configuration
>>    * @flags:
>> @@ -163,4 +178,16 @@ struct tun_vnet_hash {
>>          __u32 types;
>>   };
>>
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
>>
>> --
>> 2.46.2
>>
> 
> Thanks
> 


