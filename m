Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF857BD01C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbjJHUqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHUqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 16:46:16 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB15B3
        for <linux-kselftest@vger.kernel.org>; Sun,  8 Oct 2023 13:46:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd54aca17cso2936782fac.3
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Oct 2023 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696797974; x=1697402774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfsry7RRRFg349Lpy0RzecaUl8H+SbsoQ6M3B1LKkpk=;
        b=y7XiJN2x2bhxMX0nu8N6qKwZNpBx6gQp9fS7IVRUzqIGUv5AYH77bJAPUrXxVeM02N
         A4oiNXlPEw3l+CEzF8kF9s10ldbGUrIJoPaaAOeMntcCIOuDZIGaU7Ph4in/ZoaqGvxr
         giY0r72cZvZYFApDmRl8TzECK8GF9t1N7KMnLh+SKtOGIdhiKTF23Lm2Nkw9XGtQWiWa
         lMxRrkhIhqLWt2nRkW+28XBsIk1J+EnlSF5UpmtJ/8rJaH0EGqSTlojs/oSn3WNJ+zTx
         k3hEzeFAo2H8/LXwbQ8kkdcdQtOOYOenlmEtqAroMWmx9sYIhSiHBHszsTys9u6BZa74
         pudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696797974; x=1697402774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfsry7RRRFg349Lpy0RzecaUl8H+SbsoQ6M3B1LKkpk=;
        b=rvE91TsZ1xGMQrOQjWgGy1MHLH4bL99AF9Ds/rRjVYnZoMwZuyjfreYTkZchEcq2Pf
         2eHReLnYgSoFi24MlljLI1eazK7uJlI9y9yH1cg5zH+jjTSc5ouWT2+Lu2IZNDUZDxuP
         Tc6eGNJga7Pvo+M5Tv1eUPwYaQdwLZ4jTovypdgwPzYPftdtPwjmCkuiZUYEJi4L3N0m
         gFMM+KU4Yvf638NIULAkfhDK3DLoZQm++k98hqWJUJGMsK/9Qa+bCWEYy6GzzQRvExBw
         sUK+6xrCymYCK0ZjtkoGYmaRpBeg+Sjbevald9BuEIr00iyIErfIrDkuAq7EdC7VveEI
         oqMA==
X-Gm-Message-State: AOJu0Yx0wdU5o/RnXUYaX0ZevFBGIq0HjcrNZ7v/Q9NVoPKm7q3tJ520
        rmu42QWqyRLA9mHdYo2KvQ65cg==
X-Google-Smtp-Source: AGHT+IEJF97ednY3hDsinvKtdS7voVn3JItzYo/nlZ1tdFFEz5UdqbQl3lRNX4+5qnwbSDOlC5F8qg==
X-Received: by 2002:a05:6870:889e:b0:1bb:c0ee:5536 with SMTP id m30-20020a056870889e00b001bbc0ee5536mr16118298oam.47.1696797973856;
        Sun, 08 Oct 2023 13:46:13 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709027c8200b001c736746d33sm7858505pll.217.2023.10.08.13.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 13:46:13 -0700 (PDT)
Message-ID: <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
Date:   Mon, 9 Oct 2023 05:46:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Content-Language: en-US
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
        gustavoars@kernel.org, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, nogikh@google.com,
        pablo@netfilter.org, decui@microsoft.com, jakub@cloudflare.com,
        elver@google.com, pabeni@redhat.com,
        Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/09 5:08, Willem de Bruijn wrote:
> On Sun, Oct 8, 2023 at 10:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/09 4:07, Willem de Bruijn wrote:
>>> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>> However, computing the hash after the queue was chosen defeats the
>>>> purpose of RSS.
>>>>
>>>> Another approach is to use eBPF steering program. This approach has
>>>> another downside: it cannot report the calculated hash due to the
>>>> restrictive nature of eBPF.
>>>>
>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>> program so that it will be able to report to the userspace, but it makes
>>>> little sense to allow to implement different hashing algorithms with
>>>> eBPF since the hash value reported by virtio-net is strictly defined by
>>>> the specification.
>>>>
>>>> The hash value already stored in sk_buff is not used and computed
>>>> independently since it may have been computed in a way not conformant
>>>> with the specification.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>
>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
>>>> +       .max_indirection_table_length =
>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
>>>> +
>>>> +       .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>>> +};
>>>
>>> No need to have explicit capabilities exchange like this? Tun either
>>> supports all or none.
>>
>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.
>>
>> It is because the flow dissector does not support IPv6 extensions. The
>> specification is also vague, and does not tell how many TLVs should be
>> consumed at most when interpreting destination option header so I chose
>> to avoid adding code for these hash types to the flow dissector. I doubt
>> anyone will complain about it since nobody complains for Linux.
>>
>> I'm also adding this so that we can extend it later.
>> max_indirection_table_length may grow for systems with 128+ CPUs, or
>> types may have other bits for new protocols in the future.
>>
>>>
>>>>           case TUNSETSTEERINGEBPF:
>>>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>> +               bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>> +               if (IS_ERR(bpf_ret))
>>>> +                       ret = PTR_ERR(bpf_ret);
>>>> +               else if (bpf_ret)
>>>> +                       tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
>>>
>>> Don't make one feature disable another.
>>>
>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
>>> functions. If one is enabled the other call should fail, with EBUSY
>>> for instance.
>>>
>>>> +       case TUNSETVNETHASH:
>>>> +               len = sizeof(vnet_hash);
>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
>>>> +                       ret = -EFAULT;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
>>>> +                     !tun_is_little_endian(tun))) ||
>>>> +                    vnet_hash.indirection_table_mask >=
>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
>>>> +                       ret = -EINVAL;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               argp = (u8 __user *)argp + len;
>>>> +               len = (vnet_hash.indirection_table_mask + 1) * 2;
>>>> +               if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
>>>> +                       ret = -EFAULT;
>>>> +                       break;
>>>> +               }
>>>> +
>>>> +               argp = (u8 __user *)argp + len;
>>>> +               len = virtio_net_hash_key_length(vnet_hash.types);
>>>> +
>>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
>>>> +                       ret = -EFAULT;
>>>> +                       break;
>>>> +               }
>>>
>>> Probably easier and less error-prone to define a fixed size control
>>> struct with the max indirection table size.
>>
>> I made its size variable because the indirection table and key may grow
>> in the future as I wrote above.
>>
>>>
>>> Btw: please trim the CC: list considerably on future patches.
>>
>> I'll do so in the next version with the TUNSETSTEERINGEBPF change you
>> proposed.
> 
> To be clear: please don't just resubmit with that one change.
> 
> The skb and cb issues are quite fundamental issues that need to be resolved.
> 
> I'd like to understand why adjusting the existing BPF feature for this
> exact purpose cannot be amended to return the key it produced.

eBPF steering program is not designed for this particular problem in my 
understanding. It was introduced to derive hash values with an 
understanding of application-specific semantics of packets instead of 
generic IP/TCP/UDP semantics.

This problem is rather different in terms that the hash derivation is 
strictly defined by virtio-net. I don't think it makes sense to 
introduce the complexity of BPF when you always run the same code.

It can utilize the existing flow dissector and also make it easier to 
use for the userspace by implementing this in the kernel.

> 
> As you point out, the C flow dissector is insufficient. The BPF flow
> dissector does not have this problem. The same argument would go for
> the pre-existing BPF steering program.
It is possible to extend the C flow dissector just as it is possible to 
implement a BPF flow dissector. The more serious problem is that 
virtio-net specification (and Microsoft RSS it follows) does not tell 
how to implement IPv6 extension support.
