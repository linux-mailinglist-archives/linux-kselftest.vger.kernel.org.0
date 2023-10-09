Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201B77BD7D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjJIKCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346000AbjJIKCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:02:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64926D6
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 03:02:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-69101d33315so3096319b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696845722; x=1697450522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+uEygOgrXPW4eDtCPafop8WoXeQVZK0M3TvddGZIgQ=;
        b=dIXWJQU4qTh5A3ajvNU2vQXeE5sY8auZ9bHjMIoS67nntsuMYVSYTt8Do61mYgz2nk
         B7smv6G1+4dt/Q+hmGkD73kqPn1QyBCw64+Z/ZPSCrUzph4xaYvPeoMM+ODn73Hgr8r3
         VB8kBInAMZjWypcuXCMI4DiZguKpQbq2T8eopzRxpnw0kHvnPt+54ldPOmCR8MGe+XJD
         8zD+5qn+Afj9PtgGr2GsEhEhemNJdQUvTvAm8qes3N4ZB3BgLOhYdM6Q6aBdrNZv61TC
         Psu0YQlbBcZ7zABSW60fNyOKilaW+CtE3ceHq0rVYyCrsPCLntxIuThESJjB3ZJ3ulL2
         LUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845722; x=1697450522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+uEygOgrXPW4eDtCPafop8WoXeQVZK0M3TvddGZIgQ=;
        b=kzn5RG3/YWBcGCnhO+F6kjxaJtUFhMOV5EjofSlSeHT2JMfxcbctHQb/XbnMT8KQvI
         FA5GHiCQngc2jxLy3EGNUA/vOUQYbFdK3bb3T8JbDj0/70zsTL1x5n4kJNdKBk6vT/c3
         dE+apQ0AZa9KRw900Fnw3r3WMKJvZo/K9qjrUoKijHEY1AWXRAzoMTEPwuMYhyLtMKTL
         h/J6K1wrn3H+oP/L/6F1sUzFJhdlaIY01+fri8F5wRzNZL7YeaY+7B/XvIEfingfvGBf
         E+NseKINjP4FGvux21OsgGinwiq8/s5kuDSu/uCQ9r4vLZJXeuwAjL1qW8nokZ+3tE48
         a//w==
X-Gm-Message-State: AOJu0YyZoG1vyd1gwooCHKEqYvoOT+09NHU1UOxyZu2khAJ3jMxrjM4p
        /Vylq+4NNHdqV89XXzhb6CqZaA==
X-Google-Smtp-Source: AGHT+IGOE1sW8y9xH/nD3+i0oqKlIfZdC1FZ0tvg9bEPvIWr90mCClyhNCJAgIYtwoWZ3byqNxucOw==
X-Received: by 2002:a05:6a20:c518:b0:14b:7d8b:cbaf with SMTP id gm24-20020a056a20c51800b0014b7d8bcbafmr10300156pzb.57.1696845722618;
        Mon, 09 Oct 2023 03:02:02 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001b03f208323sm9099063plg.64.2023.10.09.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:02:02 -0700 (PDT)
Message-ID: <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
Date:   Mon, 9 Oct 2023 19:01:55 +0900
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
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
 <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/09 18:57, Willem de Bruijn wrote:
> On Mon, Oct 9, 2023 at 3:57 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/09 17:04, Willem de Bruijn wrote:
>>> On Sun, Oct 8, 2023 at 3:46 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
>>>>> On Sun, Oct 8, 2023 at 10:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
>>>>>>> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>> purpose of RSS.
>>>>>>>>
>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>> restrictive nature of eBPF.
>>>>>>>>
>>>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>>>> program so that it will be able to report to the userspace, but it makes
>>>>>>>> little sense to allow to implement different hashing algorithms with
>>>>>>>> eBPF since the hash value reported by virtio-net is strictly defined by
>>>>>>>> the specification.
>>>>>>>>
>>>>>>>> The hash value already stored in sk_buff is not used and computed
>>>>>>>> independently since it may have been computed in a way not conformant
>>>>>>>> with the specification.
>>>>>>>>
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> ---
>>>>>>>
>>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
>>>>>>>> +       .max_indirection_table_length =
>>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
>>>>>>>> +
>>>>>>>> +       .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>>>>>>> +};
>>>>>>>
>>>>>>> No need to have explicit capabilities exchange like this? Tun either
>>>>>>> supports all or none.
>>>>>>
>>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
>>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.
>>>>>>
>>>>>> It is because the flow dissector does not support IPv6 extensions. The
>>>>>> specification is also vague, and does not tell how many TLVs should be
>>>>>> consumed at most when interpreting destination option header so I chose
>>>>>> to avoid adding code for these hash types to the flow dissector. I doubt
>>>>>> anyone will complain about it since nobody complains for Linux.
>>>>>>
>>>>>> I'm also adding this so that we can extend it later.
>>>>>> max_indirection_table_length may grow for systems with 128+ CPUs, or
>>>>>> types may have other bits for new protocols in the future.
>>>>>>
>>>>>>>
>>>>>>>>             case TUNSETSTEERINGEBPF:
>>>>>>>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>>>>>> +               bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>>>>>> +               if (IS_ERR(bpf_ret))
>>>>>>>> +                       ret = PTR_ERR(bpf_ret);
>>>>>>>> +               else if (bpf_ret)
>>>>>>>> +                       tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
>>>>>>>
>>>>>>> Don't make one feature disable another.
>>>>>>>
>>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
>>>>>>> functions. If one is enabled the other call should fail, with EBUSY
>>>>>>> for instance.
>>>>>>>
>>>>>>>> +       case TUNSETVNETHASH:
>>>>>>>> +               len = sizeof(vnet_hash);
>>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
>>>>>>>> +                       ret = -EFAULT;
>>>>>>>> +                       break;
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
>>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
>>>>>>>> +                     !tun_is_little_endian(tun))) ||
>>>>>>>> +                    vnet_hash.indirection_table_mask >=
>>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
>>>>>>>> +                       ret = -EINVAL;
>>>>>>>> +                       break;
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               argp = (u8 __user *)argp + len;
>>>>>>>> +               len = (vnet_hash.indirection_table_mask + 1) * 2;
>>>>>>>> +               if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
>>>>>>>> +                       ret = -EFAULT;
>>>>>>>> +                       break;
>>>>>>>> +               }
>>>>>>>> +
>>>>>>>> +               argp = (u8 __user *)argp + len;
>>>>>>>> +               len = virtio_net_hash_key_length(vnet_hash.types);
>>>>>>>> +
>>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
>>>>>>>> +                       ret = -EFAULT;
>>>>>>>> +                       break;
>>>>>>>> +               }
>>>>>>>
>>>>>>> Probably easier and less error-prone to define a fixed size control
>>>>>>> struct with the max indirection table size.
>>>>>>
>>>>>> I made its size variable because the indirection table and key may grow
>>>>>> in the future as I wrote above.
>>>>>>
>>>>>>>
>>>>>>> Btw: please trim the CC: list considerably on future patches.
>>>>>>
>>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF change you
>>>>>> proposed.
>>>>>
>>>>> To be clear: please don't just resubmit with that one change.
>>>>>
>>>>> The skb and cb issues are quite fundamental issues that need to be resolved.
>>>>>
>>>>> I'd like to understand why adjusting the existing BPF feature for this
>>>>> exact purpose cannot be amended to return the key it produced.
>>>>
>>>> eBPF steering program is not designed for this particular problem in my
>>>> understanding. It was introduced to derive hash values with an
>>>> understanding of application-specific semantics of packets instead of
>>>> generic IP/TCP/UDP semantics.
>>>>
>>>> This problem is rather different in terms that the hash derivation is
>>>> strictly defined by virtio-net. I don't think it makes sense to
>>>> introduce the complexity of BPF when you always run the same code.
>>>>
>>>> It can utilize the existing flow dissector and also make it easier to
>>>> use for the userspace by implementing this in the kernel.
>>>
>>> Ok. There does appear to be overlap in functionality. But it might be
>>> easier to deploy to just have standard Toeplitz available without
>>> having to compile and load an eBPF program.
>>>
>>> As for the sk_buff and cb[] changes. The first is really not needed.
>>> sk_buff simply would not scale if every edge case needs a few bits.
>>
>> An alternative is to move the bit to cb[] and clear it for every code
>> paths that lead to ndo_start_xmit(), but I'm worried that it is error-prone.
>>
>> I think we can put the bit in sk_buff for now. We can implement the
>> alternative when we are short of bits.
> 
> I disagree. sk_buff fields add a cost to every code path. They cannot
> be added for every edge case.

It only takes an unused bit and does not grow the sk_buff size so I 
think it has practically no cost for now.
