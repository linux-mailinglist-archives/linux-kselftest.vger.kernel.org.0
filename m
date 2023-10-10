Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD07BF0EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379411AbjJJCcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 22:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379358AbjJJCcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 22:32:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D5B4
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 19:32:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692c02adeefso3740843b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696905137; x=1697509937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9I+zfgX9j2x9LylYNRgY5HzP9BCRmQBo6uYgvGA/Jlw=;
        b=0gxkrYJyduboVx6jh49WR79v4XZw3eR8gNnGPdxBljt6LxyONKuNLyWMlQDuWl678B
         jXYFz01HzcSOQTAd220P/5a2dGbe7CsbtyBDgX5HOFG1J3lzqzfKOPaXwdtX0k9Fj5Q/
         t7+OcSARcBfF0/tNXUjETf68dbUzwvLjuURmEVt1wt7q5wyzp+jQrDF7LCgcjDZeqEdJ
         VyqBDo7Tox/GNo1w7ACIbqQFYv0zBVLFlEiW3SzdmvzPxFfx9cp2CfVQpZnE5PXpw4bE
         ut8KiVII9tJtUV0GjIoya9UkU0NbcqACWTMON0apgkrjXiIR+f3WD/UKIvJniS11m1bZ
         RN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696905137; x=1697509937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9I+zfgX9j2x9LylYNRgY5HzP9BCRmQBo6uYgvGA/Jlw=;
        b=rZJYWAN+x1Cx7KXvvISiQWEvlLug1FAeJQ/YQWkez7Ev5GXkY+Mmx8LuFoPdoIepLP
         VjcaWUUIVpRJ1p7+yTL9uIMdtNbkyRJBVzs1kDEd+NBsoxNPEPwR3V4JTb9P7ghGaVHN
         5SULRWvJwr3rheskjMeEnGpiHBofLDtEjW5nqrSt++heEXr81iCDgcHcgbOaFC763E1I
         QsaTNfYLrvneahJBwC3cRUqu0oAIocgssB/62VIABhhj59tTy3I8eFWjv8VQgr4c5pT/
         r9sBv68q6/Osfpa2q89Vuo363v7o/SX1OQ37aMiLi5wYj3RABsGL+sCFf+aw7K/lMF/J
         S3pg==
X-Gm-Message-State: AOJu0Yz7BIJc2Ofixgp3ZbrjcUWJHdrnuwxbZTy3/4woZDCJ0IXPocrw
        RQasjRxCqWq4SMug+X2nbRlX3Q==
X-Google-Smtp-Source: AGHT+IGuDA71Hv3GREOgVgWEXcyWCTYcPiBv5aMEGNXLR6ZwL15KGl6Avv8qALsS+dN66fMgzZjizQ==
X-Received: by 2002:a05:6a00:16cd:b0:68b:a137:3739 with SMTP id l13-20020a056a0016cd00b0068ba1373739mr17602163pfc.4.1696905136991;
        Mon, 09 Oct 2023 19:32:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b00689f5940061sm7249229pfn.17.2023.10.09.19.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 19:32:16 -0700 (PDT)
Message-ID: <62db1804-586f-4fcd-a6e8-124d86b6797e@daynix.com>
Date:   Tue, 10 Oct 2023 11:32:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
        gustavoars@kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, nogikh@google.com,
        pablo@netfilter.org, decui@microsoft.com, cai@lca.pw,
        jakub@cloudflare.com, elver@google.com, pabeni@redhat.com,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     xuanzhuo@linux.alibaba.com, shuah@kernel.org
References: <20231009071226-mutt-send-email-mst@kernel.org>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231009071226-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/09 20:38, Michael S. Tsirkin wrote:
> Akihiko Odaki sorry about reposts.
> Having an email with two "@" in the CC list:
> 	 xuanzhuo@linux.alibaba.comshuah@kernel.org
> tripped up mutt's reply-all for me and made it send to you only.
> 
> I am guessing you meant two addresses: xuanzhuo@linux.alibaba.com
> and shuah@kernel.org.

Oops, I'll send the future versions with corrected addresses (and fewer 
CCs).

> 
> 
> On Sun, Oct 08, 2023 at 02:20:49PM +0900, Akihiko Odaki wrote:
>> virtio-net have two usage of hashes: one is RSS and another is hash
>> reporting. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF.
>>
>> Introduce the code to compute hashes to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but it makes
>> little sense to allow to implement different hashing algorithms with
>> eBPF since the hash value reported by virtio-net is strictly defined by
>> the specification.
>>
>> The hash value already stored in sk_buff is not used and computed
>> independently since it may have been computed in a way not conformant
>> with the specification.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/tun.c           | 187 ++++++++++++++++++++++++++++++++----
>>   include/uapi/linux/if_tun.h |  16 +++
>>   2 files changed, 182 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 89ab9efe522c..561a573cd008 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -171,6 +171,9 @@ struct tun_prog {
>>   	struct bpf_prog *prog;
>>   };
>>   
>> +#define TUN_VNET_HASH_MAX_KEY_SIZE 40
>> +#define TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH 128
>> +
> 
> where do these come from?

TUN_VNET_HASH_MAX_KEY_SIZE is the total size of IPv6 addresses and 
TCP/UDP ports.

TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH is from the following 
statement in VIRTIO Version 1.2 clause 5.1.4.1:
 > The device MUST set rss_max_indirection_table_length to at least 128,
 > if it offers VIRTIO_NET_F_RSS.

> 
>>   /* Since the socket were moved to tun_file, to preserve the behavior of persist
>>    * device, socket filter, sndbuf and vnet header size were restore when the
>>    * file were attached to a persist device.
>> @@ -209,6 +212,9 @@ struct tun_struct {
>>   	struct tun_prog __rcu *steering_prog;
>>   	struct tun_prog __rcu *filter_prog;
>>   	struct ethtool_link_ksettings link_ksettings;
>> +	struct tun_vnet_hash vnet_hash;
>> +	u16 vnet_hash_indirection_table[TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH];
>> +	u32 vnet_hash_key[TUN_VNET_HASH_MAX_KEY_SIZE / 4];
> 
> That's quite a lot of data to add in this struct, and will be used
> by a small minority of users. Are you pushing any hot data out of cache
> with this? Why not allocate these as needed?

I put this here just because it's convenient. It would be better to have 
a separate structure.

> 
>>   	/* init args */
>>   	struct file *file;
>>   	struct ifreq *ifr;
>> @@ -219,6 +225,13 @@ struct veth {
>>   	__be16 h_vlan_TCI;
>>   };
>>   
>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
>> +	.max_indirection_table_length =
>> +		TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
>> +
>> +	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>> +};
>> +
>>   static void tun_flow_init(struct tun_struct *tun);
>>   static void tun_flow_uninit(struct tun_struct *tun);
>>   
>> @@ -320,10 +333,16 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>>   	if (get_user(be, argp))
>>   		return -EFAULT;
>>   
>> -	if (be)
>> +	if (be) {
>> +		if (!(tun->flags & TUN_VNET_LE) &&
>> +		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT)) {
>> +			return -EINVAL;
>> +		}
>> +
>>   		tun->flags |= TUN_VNET_BE;
>> -	else
>> +	} else {
>>   		tun->flags &= ~TUN_VNET_BE;
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -558,15 +577,47 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>   	return ret % numqueues;
>>   }
>>   
>> +static u16 tun_vnet_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>> +{
>> +	u32 value = qdisc_skb_cb(skb)->tun_vnet_hash_value;
>> +	u32 numqueues;
>> +	u32 index;
>> +	u16 queue;
>> +
>> +	numqueues = READ_ONCE(tun->numqueues);
>> +	if (!numqueues)
>> +		return 0;
>> +
>> +	index = value & READ_ONCE(tun->vnet_hash.indirection_table_mask);
>> +	queue = READ_ONCE(tun->vnet_hash_indirection_table[index]);
>> +	if (!queue)
>> +		queue = READ_ONCE(tun->vnet_hash.unclassified_queue);
> 
> Apparently 0 is an illegal queue value? You are making this part
> of UAPI better document things like this.

Well, I don't think so. I naively copied this from QEMU's eBPF steering 
program but I think this should check tun_vnet_hash_report == 
VIRTIO_NET_HASH_REPORT_NONE. I'll fix it.

> 
>> +
>> +	return queue % numqueues;
>> +}
>> +
>>   static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>>   			    struct net_device *sb_dev)
>>   {
>>   	struct tun_struct *tun = netdev_priv(dev);
>> +	u8 vnet_hash_flags = READ_ONCE(tun->vnet_hash.flags);
>> +	struct virtio_net_hash hash;
>>   	u16 ret;
>>   
>> +	if (vnet_hash_flags & (TUN_VNET_HASH_RSS | TUN_VNET_HASH_REPORT)) {
>> +		virtio_net_hash(skb, READ_ONCE(tun->vnet_hash.types),
>> +				tun->vnet_hash_key, &hash);
>> +
> 
> What are all these READ_ONCE things doing?
> E.g. you seem to be very content to have tun->vnet_hash.types read twice apparently?
> This is volatile which basically breaks all compiler's attempts
> to optimize code - needs to be used judiciously.

I'll replace them with one RCU dereference once I extract them into a 
structure.

> 
> 
> 
>> +		skb->tun_vnet_hash = true;
>> +		qdisc_skb_cb(skb)->tun_vnet_hash_value = hash.value;
>> +		qdisc_skb_cb(skb)->tun_vnet_hash_report = hash.report;
>> +	}
>> +
>>   	rcu_read_lock();
>>   	if (rcu_dereference(tun->steering_prog))
>>   		ret = tun_ebpf_select_queue(tun, skb);
>> +	else if (vnet_hash_flags & TUN_VNET_HASH_RSS)
>> +		ret = tun_vnet_select_queue(tun, skb);
>>   	else
>>   		ret = tun_automq_select_queue(tun, skb);
>>   	rcu_read_unlock();
>> @@ -2088,10 +2139,15 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>   			    struct iov_iter *iter)
>>   {
>>   	struct tun_pi pi = { 0, skb->protocol };
>> +	struct virtio_net_hash vnet_hash = {
>> +		.value = qdisc_skb_cb(skb)->tun_vnet_hash_value,
>> +		.report = qdisc_skb_cb(skb)->tun_vnet_hash_report
>> +	};
>>   	ssize_t total;
>>   	int vlan_offset = 0;
>>   	int vlan_hlen = 0;
>>   	int vnet_hdr_sz = 0;
>> +	size_t vnet_hdr_content_sz;
>>   
>>   	if (skb_vlan_tag_present(skb))
>>   		vlan_hlen = VLAN_HLEN;
>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>   	}
>>   
>>   	if (vnet_hdr_sz) {
>> -		struct virtio_net_hdr gso;
>> +		union {
>> +			struct virtio_net_hdr hdr;
>> +			struct virtio_net_hdr_v1_hash v1_hash_hdr;
>> +		} hdr;
>> +		int ret;
>>   
>>   		if (iov_iter_count(iter) < vnet_hdr_sz)
>>   			return -EINVAL;
>>   
>> -		if (virtio_net_hdr_from_skb(skb, &gso,
>> -					    tun_is_little_endian(tun), true,
>> -					    vlan_hlen)) {
>> +		if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
>> +		    vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
>> +		    skb->tun_vnet_hash) {
>> +			vnet_hdr_content_sz = sizeof(hdr.v1_hash_hdr);
>> +			ret = virtio_net_hdr_v1_hash_from_skb(skb,
>> +							      &hdr.v1_hash_hdr,
>> +							      true,
>> +							      vlan_hlen,
>> +							      &vnet_hash);
>> +		} else {
>> +			vnet_hdr_content_sz = sizeof(hdr.hdr);
>> +			ret = virtio_net_hdr_from_skb(skb, &hdr.hdr,
>> +						      tun_is_little_endian(tun),
>> +						      true, vlan_hlen);
>> +		}
>> +
>> +		if (ret) {
>>   			struct skb_shared_info *sinfo = skb_shinfo(skb);
>>   			pr_err("unexpected GSO type: "
>>   			       "0x%x, gso_size %d, hdr_len %d\n",
>> -			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
>> -			       tun16_to_cpu(tun, gso.hdr_len));
>> +			       sinfo->gso_type, tun16_to_cpu(tun, hdr.hdr.gso_size),
>> +			       tun16_to_cpu(tun, hdr.hdr.hdr_len));
>>   			print_hex_dump(KERN_ERR, "tun: ",
>>   				       DUMP_PREFIX_NONE,
>>   				       16, 1, skb->head,
>> -				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
>> +				       min((int)tun16_to_cpu(tun, hdr.hdr.hdr_len), 64), true);
>>   			WARN_ON_ONCE(1);
>>   			return -EINVAL;
>>   		}
>>   
>> -		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
>> +		if (copy_to_iter(&hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
>>   			return -EFAULT;
>>   
>> -		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
>> +		iov_iter_advance(iter, vnet_hdr_sz - vnet_hdr_content_sz);
>>   	}
>>   
>>   	if (vlan_hlen) {
>> @@ -3007,24 +3081,27 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>>   	return ret;
>>   }
>>   
>> -static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
>> -			void __user *data)
>> +static struct bpf_prog *tun_set_ebpf(struct tun_struct *tun,
>> +				     struct tun_prog __rcu **prog_p,
>> +				     void __user *data)
>>   {
>>   	struct bpf_prog *prog;
>>   	int fd;
>> +	int ret;
>>   
>>   	if (copy_from_user(&fd, data, sizeof(fd)))
>> -		return -EFAULT;
>> +		return ERR_PTR(-EFAULT);
>>   
>>   	if (fd == -1) {
>>   		prog = NULL;
>>   	} else {
>>   		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
>>   		if (IS_ERR(prog))
>> -			return PTR_ERR(prog);
>> +			return prog;
>>   	}
>>   
>> -	return __tun_set_ebpf(tun, prog_p, prog);
>> +	ret = __tun_set_ebpf(tun, prog_p, prog);
>> +	return ret ? ERR_PTR(ret) : prog;
>>   }
>>   
>>   /* Return correct value for tun->dev->addr_len based on tun->dev->type. */
>> @@ -3082,6 +3159,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   	int le;
>>   	int ret;
>>   	bool do_notify = false;
>> +	struct bpf_prog *bpf_ret;
>> +	struct tun_vnet_hash vnet_hash;
>> +	u16 vnet_hash_indirection_table[TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH];
>> +	u8 vnet_hash_key[TUN_VNET_HASH_MAX_KEY_SIZE];
>> +	size_t len;
>>   
>>   	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>>   	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
>> @@ -3295,7 +3377,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   			ret = -EFAULT;
>>   			break;
>>   		}
>> -		if (vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr)) {
>> +		if (vnet_hdr_sz <
>> +		    (int)((tun->vnet_hash.flags & TUN_VNET_HASH_REPORT) ?
>> +			  sizeof(struct virtio_net_hdr_v1_hash) :
>> +			  sizeof(struct virtio_net_hdr))) {
>>   			ret = -EINVAL;
>>   			break;
>>   		}
>> @@ -3314,10 +3399,16 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   			ret = -EFAULT;
>>   			break;
>>   		}
>> -		if (le)
>> +		if (le) {
>>   			tun->flags |= TUN_VNET_LE;
>> -		else
>> +		} else {
>> +			if (!tun_legacy_is_little_endian(tun)) {
>> +				ret = -EINVAL;
>> +				break;
>> +			}
>> +
>>   			tun->flags &= ~TUN_VNET_LE;
>> +		}
>>   		break;
>>   
>>   	case TUNGETVNETBE:
>> @@ -3360,11 +3451,17 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   		break;
>>   
>>   	case TUNSETSTEERINGEBPF:
>> -		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +		bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +		if (IS_ERR(bpf_ret))
>> +			ret = PTR_ERR(bpf_ret);
>> +		else if (bpf_ret)
>> +			tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
> 
> what is this doing?

It's unsetting RSS because steering eBPF is incompatible with RSS. 
Willem proposed to return EBUSY instead so I'll do so in the future.

> 
>>   		break;
>>   
>>   	case TUNSETFILTEREBPF:
>> -		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>> +		bpf_ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>> +		if (IS_ERR(bpf_ret))
>> +			ret = PTR_ERR(bpf_ret);
>>   		break;
>>   
>>   	case TUNSETCARRIER:
>> @@ -3382,6 +3479,54 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>   		ret = open_related_ns(&net->ns, get_net_ns);
>>   		break;
>>   
>> +	case TUNGETVNETHASHCAP:
>> +		if (copy_to_user(argp, &tun_vnet_hash_cap,
>> +				 sizeof(tun_vnet_hash_cap)))
>> +			ret = -EFAULT;
>> +		break;
>> +
>> +	case TUNSETVNETHASH:
>> +		len = sizeof(vnet_hash);
>> +		if (copy_from_user(&vnet_hash, argp, len)) {
>> +			ret = -EFAULT;
>> +			break;
>> +		}
> 
> 
> what if flags has some bits set you don't know how to handle?
> should these be ignored as now or cause a failure?
> these decisions all affect uapi.

Currently they are ignored.

> 
>> +
>> +		if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
>> +		     (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
>> +		      !tun_is_little_endian(tun))) ||
>> +		     vnet_hash.indirection_table_mask >=
>> +		     TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
> 
> Given this is later used to index within an array one has to
> be very careful about spectre things here, which this code isn't.

I have totally forgotten that. Thanks for pointing this out.

> 
> 
>> +
>> +		argp = (u8 __user *)argp + len;
>> +		len = (vnet_hash.indirection_table_mask + 1) * 2;
> 
> comment pointer math tricks like this extensively please.

Ok, I will.

> 
>> +		if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
>> +			ret = -EFAULT;
>> +			break;
>> +		}
>> +
>> +		argp = (u8 __user *)argp + len;
>> +		len = virtio_net_hash_key_length(vnet_hash.types);
>> +
>> +		if (copy_from_user(vnet_hash_key, argp, len)) {
>> +			ret = -EFAULT;
>> +			break;
>> +		}
>> +
>> +		tun->vnet_hash = vnet_hash;
>> +		memcpy(tun->vnet_hash_indirection_table,
>> +		       vnet_hash_indirection_table,
>> +		       (vnet_hash.indirection_table_mask + 1) * 2);
>> +		memcpy(tun->vnet_hash_key, vnet_hash_key, len);
>> +
>> +		if (vnet_hash.flags & TUN_VNET_HASH_RSS)
>> +			__tun_set_ebpf(tun, &tun->steering_prog, NULL);
>> +
>> +		break;
>> +
>>   	default:
>>   		ret = -EINVAL;
>>   		break;
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c939..dc591cd897c8 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -61,6 +61,8 @@
>>   #define TUNSETFILTEREBPF _IOR('T', 225, int)
>>   #define TUNSETCARRIER _IOW('T', 226, int)
>>   #define TUNGETDEVNETNS _IO('T', 227)
>> +#define TUNGETVNETHASHCAP _IO('T', 228)
>> +#define TUNSETVNETHASH _IOW('T', 229, unsigned int)
>>   
>>   /* TUNSETIFF ifr flags */
>>   #define IFF_TUN		0x0001
>> @@ -115,4 +117,18 @@ struct tun_filter {
>>   	__u8   addr[][ETH_ALEN];
>>   };
>>   
>> +struct tun_vnet_hash_cap {
>> +	__u16 max_indirection_table_length;
>> +	__u32 types;
>> +};
>> +
> 
> There's hidden padding in this struct - not good, copy
> will leak kernel info out.

I'll add an explicit padding.

> 
> 
> 
>> +#define TUN_VNET_HASH_RSS	0x01
>> +#define TUN_VNET_HASH_REPORT	0x02
> 
> 
> Do you intend to add more flags down the road?
> How will userspace know what is supported?

I don't intend to do so, but perhaps it may be better to return EINVAL 
when an unknown flag is set.

> 
>> +struct tun_vnet_hash {
>> +	__u8 flags;
>> +	__u32 types;
>> +	__u16 indirection_table_mask;
>> +	__u16 unclassified_queue;
>> +};
>> +
> 
> Padding here too. Best avoided.

Perhaps it may be easier just to grow flags into u32.

> 
> In any case, document UAPI please.

Sure, I'll.
