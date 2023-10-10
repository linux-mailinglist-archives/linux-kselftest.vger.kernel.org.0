Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AB7BF0F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441919AbjJJCed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 22:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCec (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 22:34:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912DBA7
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 19:34:30 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af957bd7e9so3573021b6e.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696905270; x=1697510070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eyfqJMsAjtR1XTGi5WJSGOZUAbzaEU+L92vGk2MLy8=;
        b=NZN06aM8AUnsmgvJQy26qFdVqSoD8fJY8Br3ri6MwG0TFBK4RaJ8f9zJNIMDYg31f9
         zzHJ79Vv+t/GJV/ugm1QMkEVM7IhIzFUxyehxXhZ0TTd5//BbWYnOTMZFmZMqDQW1cRw
         gbxnxYB4JSffzoLXfc0W3cRNpWF39RgUnHF1kE4dDqhBjT2ID/maRi/5q5Vt50aKntzF
         +9j8pM5GWUocuTI1tWAPHXiZNoc1XmkOVEYxDepj3ccdg9yuueFXN2VZJ+OvV9VqzLJZ
         YUQblGXS9L1voCUoueZEKCSQlly/oEpDJybiSKNecq1tBKqubaKnLR2CTYHC4eZBX1OM
         MkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696905270; x=1697510070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eyfqJMsAjtR1XTGi5WJSGOZUAbzaEU+L92vGk2MLy8=;
        b=iBLaVb3kLTRNp40yQ1DkPI2zOiKNwf6GPk+nNWf3I7IINeilIKbytecrR3R5qblP7j
         LFVBBz4LEEKOM4w2qepxFg3ctFgFldANRCsENiBoMlipU0LyIYBttcPuC5CFDu5wR92S
         h3x+rJ7HeglC3Cmo5zD5zohKZS8t3WSQsyJ1OdrvmwD9oJ0z3WhDxecAGXDrGfUKlLbf
         +QtiLwS3o/u3nqnoj5+gLCg3jT/HyoIvGSRhvBM//18Sp4mgR6XcK2MPMMd2l8hixhFx
         SBoor4gQlgpfYWnYmApAlpRl2wVy3emAqorGO90mOThdvz3i8DKwKFNji1Yg20Uybn+Y
         dj0A==
X-Gm-Message-State: AOJu0YxrzlBq2jneQvIhpTY7vrHrT1RQlNdVj0ysBr12m+X7kU1XbFlu
        XoU1b1IvtrAljc9/0YhMDCzo4g==
X-Google-Smtp-Source: AGHT+IELXt5RxDd99HhYrJ2ArNSDl8Q/Eg48hdKp68VYC8fzBqBQqbw7nJq8UjoTvhZf2i/opBAQ0A==
X-Received: by 2002:a05:6358:8812:b0:139:cb15:ecd3 with SMTP id hv18-20020a056358881200b00139cb15ecd3mr16915710rwb.8.1696905269713;
        Mon, 09 Oct 2023 19:34:29 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id fa9-20020a17090af0c900b0027360359b70sm11068223pjb.48.2023.10.09.19.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 19:34:29 -0700 (PDT)
Message-ID: <14ae9e85-38da-4665-8aea-3ce93e280de2@daynix.com>
Date:   Tue, 10 Oct 2023 11:34:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
 <20231009074840-mutt-send-email-mst@kernel.org>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231009074840-mutt-send-email-mst@kernel.org>
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

On 2023/10/09 20:50, Michael S. Tsirkin wrote:
> On Mon, Oct 09, 2023 at 05:44:20PM +0900, Akihiko Odaki wrote:
>> On 2023/10/09 17:13, Willem de Bruijn wrote:
>>> On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
>>>
>>>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>>>           }
>>>>
>>>>           if (vnet_hdr_sz) {
>>>> -               struct virtio_net_hdr gso;
>>>> +               union {
>>>> +                       struct virtio_net_hdr hdr;
>>>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
>>>> +               } hdr;
>>>> +               int ret;
>>>>
>>>>                   if (iov_iter_count(iter) < vnet_hdr_sz)
>>>>                           return -EINVAL;
>>>>
>>>> -               if (virtio_net_hdr_from_skb(skb, &gso,
>>>> -                                           tun_is_little_endian(tun), true,
>>>> -                                           vlan_hlen)) {
>>>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
>>>> +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
>>>> +                   skb->tun_vnet_hash) {
>>>
>>> Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
>>> the set hash ioctl failing otherwise?
>>>
>>> Such checks should be limited to control path where possible
>>
>> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are not
>> read at once.
> 
> And then it's a complete mess and you get inconsistent
> behaviour with packets getting sent all over the place, right?
> So maybe keep a pointer to this struct so it can be
> changed atomically then. Maybe even something with rcu I donnu.

I think it's a good idea to use RCU for the vnet_hash members, but 
vnet_hdr_sz is something not specific to vnet_hash so this check will be 
still necessary.
