Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E77BF2DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 08:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442183AbjJJGTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 02:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442220AbjJJGTR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 02:19:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE19E
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 23:19:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c8a1541233so14265865ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 23:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696918753; x=1697523553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAPZ8DCPC0GVaia6mopwk3dNtRJnQ6q2SebAAWub7BY=;
        b=eIt4/LEQ28rqJmw5p72uJNKXc/CK8Ign1QPs9L9alaBoCLja8JMPNST4G9BBaY/oa6
         meoQea0ClMdjN2ejrV9x+8UzSvzF59kb2cIsAuPcVKfEV/ufD+7bQlRejpb9unxarHPD
         LxrroIerlSyfh00IBQnMH+L5CAXw/sZMkJks/pdMj/x5lKmeEKZonJST9kLgmRbhO0gq
         DhYHNAOio7dTa26+Sxo+9s8p8ERJVY5DdDR4mTDuB8v7YaQKbu0jAFamQ7Zv8LPbnGIu
         U04/Zgwh2+tD6iQ/yGQfddMqi2nHOJfx32E93b8VM17td868D1ptcKHVwIkDUWFjAr27
         q9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696918753; x=1697523553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAPZ8DCPC0GVaia6mopwk3dNtRJnQ6q2SebAAWub7BY=;
        b=TpGAu1PLBebrfWLzFTworQxZxmWL4OuZ7bFGQXX1QSHb7zeCK/QWs5ozIYXSMLeAIW
         fwYXC6Gx6vWvyu1eOOLa2U4GCO3M/WVoH9rAGd8il9RRihHPmJZHFPvbtsGOzEE8yivS
         oI34sDtkvOTT6+TS6I8tTfBrmzJaUB0Ha65Oe7H9VVj7w6i6k+N/eRey32imuvqpjLsD
         lEn/nBWWcdKIuxzCBsW4xOdWqkEZFsPD7n9pAXMzWsB142s6VwPIZ842e8WeCEfpKNuA
         NY+G37XHpIDv02+QFUPWNXVywXjtt6+Is42wOTPjq5tkbYypdQhxrbLWFToMszOTDTos
         /RQQ==
X-Gm-Message-State: AOJu0YxRIig7U14XaDVv1/4zCK5v6TCvjuMeafVJEayGsIo+QRtqNt5b
        Wa4V68iyp+IocqV66U4advm8Vw==
X-Google-Smtp-Source: AGHT+IGYEp0mWMeWf2y3yHqIksUPKKKKt8dJzKkepoawQntwAIlD5DA5SqhMbDruYf7qph2avU/sbg==
X-Received: by 2002:a17:902:6f02:b0:1b8:94e9:e7b0 with SMTP id w2-20020a1709026f0200b001b894e9e7b0mr12391394plk.9.1696918753521;
        Mon, 09 Oct 2023 23:19:13 -0700 (PDT)
Received: from [157.82.206.10] ([157.82.206.10])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001c9b70609e8sm507248plb.256.2023.10.09.23.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 23:19:13 -0700 (PDT)
Message-ID: <0d491319-8ce9-4922-89c9-a48c4c5c03bc@daynix.com>
Date:   Tue, 10 Oct 2023 15:19:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
 <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
 <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com>
 <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
 <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
 <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
 <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
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

On 2023/10/10 15:00, Jason Wang wrote:
> On Tue, Oct 10, 2023 at 1:51 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/10 14:45, Jason Wang wrote:
>>> On Tue, Oct 10, 2023 at 9:52 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/10/09 19:44, Willem de Bruijn wrote:
>>>>> On Mon, Oct 9, 2023 at 3:12 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2023/10/09 19:06, Willem de Bruijn wrote:
>>>>>>> On Mon, Oct 9, 2023 at 3:02 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2023/10/09 18:57, Willem de Bruijn wrote:
>>>>>>>>> On Mon, Oct 9, 2023 at 3:57 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 2023/10/09 17:04, Willem de Bruijn wrote:
>>>>>>>>>>> On Sun, Oct 8, 2023 at 3:46 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
>>>>>>>>>>>>> On Sun, Oct 8, 2023 at 10:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
>>>>>>>>>>>>>>> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>>>>>>>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>>>>>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>>>>>>>>>> purpose of RSS.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>>>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>>>>>>>>>> restrictive nature of eBPF.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>>>>>>>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>>>>>>>>>>>> program so that it will be able to report to the userspace, but it makes
>>>>>>>>>>>>>>>> little sense to allow to implement different hashing algorithms with
>>>>>>>>>>>>>>>> eBPF since the hash value reported by virtio-net is strictly defined by
>>>>>>>>>>>>>>>> the specification.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The hash value already stored in sk_buff is not used and computed
>>>>>>>>>>>>>>>> independently since it may have been computed in a way not conformant
>>>>>>>>>>>>>>>> with the specification.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
>>>>>>>>>>>>>>>> +       .max_indirection_table_length =
>>>>>>>>>>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +       .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> No need to have explicit capabilities exchange like this? Tun either
>>>>>>>>>>>>>>> supports all or none.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
>>>>>>>>>>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_UDP_EX.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It is because the flow dissector does not support IPv6 extensions. The
>>>>>>>>>>>>>> specification is also vague, and does not tell how many TLVs should be
>>>>>>>>>>>>>> consumed at most when interpreting destination option header so I chose
>>>>>>>>>>>>>> to avoid adding code for these hash types to the flow dissector. I doubt
>>>>>>>>>>>>>> anyone will complain about it since nobody complains for Linux.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'm also adding this so that we can extend it later.
>>>>>>>>>>>>>> max_indirection_table_length may grow for systems with 128+ CPUs, or
>>>>>>>>>>>>>> types may have other bits for new protocols in the future.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>                 case TUNSETSTEERINGEBPF:
>>>>>>>>>>>>>>>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>>>>>>>>>>>>>> +               bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>>>>>>>>>>>>>>>> +               if (IS_ERR(bpf_ret))
>>>>>>>>>>>>>>>> +                       ret = PTR_ERR(bpf_ret);
>>>>>>>>>>>>>>>> +               else if (bpf_ret)
>>>>>>>>>>>>>>>> +                       tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Don't make one feature disable another.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
>>>>>>>>>>>>>>> functions. If one is enabled the other call should fail, with EBUSY
>>>>>>>>>>>>>>> for instance.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> +       case TUNSETVNETHASH:
>>>>>>>>>>>>>>>> +               len = sizeof(vnet_hash);
>>>>>>>>>>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
>>>>>>>>>>>>>>>> +                       ret = -EFAULT;
>>>>>>>>>>>>>>>> +                       break;
>>>>>>>>>>>>>>>> +               }
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
>>>>>>>>>>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
>>>>>>>>>>>>>>>> +                     !tun_is_little_endian(tun))) ||
>>>>>>>>>>>>>>>> +                    vnet_hash.indirection_table_mask >=
>>>>>>>>>>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
>>>>>>>>>>>>>>>> +                       ret = -EINVAL;
>>>>>>>>>>>>>>>> +                       break;
>>>>>>>>>>>>>>>> +               }
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +               argp = (u8 __user *)argp + len;
>>>>>>>>>>>>>>>> +               len = (vnet_hash.indirection_table_mask + 1) * 2;
>>>>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
>>>>>>>>>>>>>>>> +                       ret = -EFAULT;
>>>>>>>>>>>>>>>> +                       break;
>>>>>>>>>>>>>>>> +               }
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +               argp = (u8 __user *)argp + len;
>>>>>>>>>>>>>>>> +               len = virtio_net_hash_key_length(vnet_hash.types);
>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, len)) {
>>>>>>>>>>>>>>>> +                       ret = -EFAULT;
>>>>>>>>>>>>>>>> +                       break;
>>>>>>>>>>>>>>>> +               }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Probably easier and less error-prone to define a fixed size control
>>>>>>>>>>>>>>> struct with the max indirection table size.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I made its size variable because the indirection table and key may grow
>>>>>>>>>>>>>> in the future as I wrote above.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Btw: please trim the CC: list considerably on future patches.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF change you
>>>>>>>>>>>>>> proposed.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To be clear: please don't just resubmit with that one change.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The skb and cb issues are quite fundamental issues that need to be resolved.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'd like to understand why adjusting the existing BPF feature for this
>>>>>>>>>>>>> exact purpose cannot be amended to return the key it produced.
>>>>>>>>>>>>
>>>>>>>>>>>> eBPF steering program is not designed for this particular problem in my
>>>>>>>>>>>> understanding. It was introduced to derive hash values with an
>>>>>>>>>>>> understanding of application-specific semantics of packets instead of
>>>>>>>>>>>> generic IP/TCP/UDP semantics.
>>>>>>>>>>>>
>>>>>>>>>>>> This problem is rather different in terms that the hash derivation is
>>>>>>>>>>>> strictly defined by virtio-net. I don't think it makes sense to
>>>>>>>>>>>> introduce the complexity of BPF when you always run the same code.
>>>>>>>>>>>>
>>>>>>>>>>>> It can utilize the existing flow dissector and also make it easier to
>>>>>>>>>>>> use for the userspace by implementing this in the kernel.
>>>>>>>>>>>
>>>>>>>>>>> Ok. There does appear to be overlap in functionality. But it might be
>>>>>>>>>>> easier to deploy to just have standard Toeplitz available without
>>>>>>>>>>> having to compile and load an eBPF program.
>>>>>>>>>>>
>>>>>>>>>>> As for the sk_buff and cb[] changes. The first is really not needed.
>>>>>>>>>>> sk_buff simply would not scale if every edge case needs a few bits.
>>>>>>>>>>
>>>>>>>>>> An alternative is to move the bit to cb[] and clear it for every code
>>>>>>>>>> paths that lead to ndo_start_xmit(), but I'm worried that it is error-prone.
>>>>>>>>>>
>>>>>>>>>> I think we can put the bit in sk_buff for now. We can implement the
>>>>>>>>>> alternative when we are short of bits.
>>>>>>>>>
>>>>>>>>> I disagree. sk_buff fields add a cost to every code path. They cannot
>>>>>>>>> be added for every edge case.
>>>>>>>>
>>>>>>>> It only takes an unused bit and does not grow the sk_buff size so I
>>>>>>>> think it has practically no cost for now.
>>>>>>>
>>>>>>> The problem is that that thinking leads to death by a thousand cuts.
>>>>>>>
>>>>>>> "for now" forces the cost of having to think hard how to avoid growing
>>>>>>> sk_buff onto the next person. Let's do it right from the start.
>>>>>>
>>>>>> I see. I described an alternative to move the bit to cb[] and clear it
>>>>>> in all code paths that leads to ndo_start_xmit() earlier. Does that
>>>>>> sound good to you?
>>>>>
>>>>> If you use the control block to pass information between
>>>>> __dev_queue_xmit on the tun device and tun_net_xmit, using gso_skb_cb,
>>>>> the field can be left undefined in all non-tun paths. tun_select_queue
>>>>> can initialize.
>>>>
>>>> The problem is that tun_select_queue() is not always called.
>>>> netdev_core_pick_tx() ensures dev->real_num_tx_queues != 1 before
>>>> calling it, but this variable may change later and result in a race
>>>> condition. Another case is that XDP with predefined queue.
>>>>
>>>>>
>>>>> I would still use skb->hash to encode the hash. That hash type of that
>>>>> field is not strictly defined. It can be siphash from ___skb_get_hash
>>>>> or a device hash, which most likely also uses Toeplitz. Then you also
>>>>> don't run into the problem of growing the struct size.
>>>>
>>>> I'm concerned exactly because it's not strictly defined. Someone may
>>>> decide to overwrite it later if we are not cautious enough. qdisc_skb_cb
>>>> also has sufficient space to contain both of the hash value and type.
>>>
>>> How about using skb extensions?
>>
>> I think it will work. I'll try it in the next version.
> 
> Btw, I still think using eBPF for hash might be better.
> 
> Though the hashing rule is defined in the spec, it may be extended in
> the future. For example, several extensions has been proposed:
> 
> 1) RSS context
> 2) encapsulated packet hashing

Looking at the proposals, I'm now more inclined to extend the BPF 
steering program.

Yuri, who wrote the RFC patches to extend the BPF steering program, also 
raised an concern that it may become hard to implement virtio-net 
extensions in the future. It is much easier to deploy a new BPF program 
to support extensions since it will be included in QEMU and can be 
deployed at once without concerning other kernel stuff.

I was still not sure how likely such an extension will emerge especially 
when the hardware RSS capability is not evolving for a decade or so. But 
those proposals show that there are more demands of new features for 
virtio-net.
