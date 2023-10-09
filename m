Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F57BD834
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbjJIKLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJIKLf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:11:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527D2C6
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 03:11:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-69af8a42066so2237161b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696846290; x=1697451090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1E8Mj52Tq0fes8AMOfRByk/ed8eUOVTMuFwlcFHQa4Y=;
        b=Zu7Lao0vUUB1HOqJ2WdeeJq2H5KiheKUF5NQj+mB/Ln1punXUEvSw9VGjHdoKsLqrR
         U4B0UAACkIlFWCCQH7jm5osCCO6IKVpuDifcQ22SsxlQxHe/lw6ojO1Wh1euGHxsL7pL
         u21PkwgwntvOYCI3V8KKqqgQDDI8ydEXMJ2nMSZl4+yt8oYPR7npdQe91QdU78SZlEw6
         CaiOKHN04b6dd+8lJGc40SA7Zj2cv20Mo/S6iB4ZoEFRIetSRVzGCyCkBi5Y7bR4gC+Y
         WHYsxTv9kZpp+Bv5MQmktqJ3M/DfjTp/JRs6KBRemok8pZVIGT24rXrpW37DrCAEhxL4
         iquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846290; x=1697451090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E8Mj52Tq0fes8AMOfRByk/ed8eUOVTMuFwlcFHQa4Y=;
        b=HKGdI84zDosFucfXHR93TAdTdIBfvXTbXEdwJkZYvFgEeuHXw7Hp9m3YYRe6StKfKR
         iCQqTIgkWLwm+vFbk13sVfgOm3FXOg61hjM4M9NfAdw8KEwnoOrnagVL5aPxkhvuMO8y
         R/dhAEKhSjA/1AjWFZeExIfaceYvng8E5MOSBoSnd7EMRqY77gm76gDNsxXMHLBp2bSx
         6u0gOYzWJxQxM3Al6s0o+uhrtZ+JFTmgv+7C57FOD8wEWICb23v0zZtHXplSFyFInv6u
         M36zF8O6DlttxbM/5XEIKVEYvKxudnc6baOhwJ950kR4EvuzhSY5oWQT+6fESHjgqpNl
         yR1Q==
X-Gm-Message-State: AOJu0Yw4URqAjuQ5SefKzKqwHsdYEdpH4TyQPAdnQ/UmNVlSBUCJBdjS
        8jvoNu60mzztnKHTACDL5X3i/Q==
X-Google-Smtp-Source: AGHT+IHsaMcPfez+E1DIHvxKppgHs+8OirzIy7zBkFZFQZvWLN1/pTBSKE5ZLCeRiFpY4MfaPwetaQ==
X-Received: by 2002:a05:6a00:15c5:b0:692:b4d8:c8b4 with SMTP id o5-20020a056a0015c500b00692b4d8c8b4mr14892882pfu.21.1696846289702;
        Mon, 09 Oct 2023 03:11:29 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id fb3-20020a056a002d8300b0069ee4242f89sm4287361pfb.13.2023.10.09.03.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:11:29 -0700 (PDT)
Message-ID: <eab359ec-3bb9-4245-8ac3-097d66ef30a9@daynix.com>
Date:   Mon, 9 Oct 2023 19:11:22 +0900
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
        pablo@netfilter.org, decui@microsoft.com, cai@lca.pw,
        jakub@cloudflare.com, elver@google.com, pabeni@redhat.com,
        Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
 <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
 <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
 <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
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

On 2023/10/09 19:07, Willem de Bruijn wrote:
> On Mon, Oct 9, 2023 at 3:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>>
>>
>> On 2023/10/09 18:54, Willem de Bruijn wrote:
>>> On Mon, Oct 9, 2023 at 3:44 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/10/09 17:13, Willem de Bruijn wrote:
>>>>> On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>> purpose of RSS.
>>>>>>
>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>> restrictive nature of eBPF.
>>>>>>
>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>> program so that it will be able to report to the userspace, but it makes
>>>>>> little sense to allow to implement different hashing algorithms with
>>>>>> eBPF since the hash value reported by virtio-net is strictly defined by
>>>>>> the specification.
>>>>>>
>>>>>> The hash value already stored in sk_buff is not used and computed
>>>>>> independently since it may have been computed in a way not conformant
>>>>>> with the specification.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>>>>>            }
>>>>>>
>>>>>>            if (vnet_hdr_sz) {
>>>>>> -               struct virtio_net_hdr gso;
>>>>>> +               union {
>>>>>> +                       struct virtio_net_hdr hdr;
>>>>>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
>>>>>> +               } hdr;
>>>>>> +               int ret;
>>>>>>
>>>>>>                    if (iov_iter_count(iter) < vnet_hdr_sz)
>>>>>>                            return -EINVAL;
>>>>>>
>>>>>> -               if (virtio_net_hdr_from_skb(skb, &gso,
>>>>>> -                                           tun_is_little_endian(tun), true,
>>>>>> -                                           vlan_hlen)) {
>>>>>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
>>>>>> +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
>>>>>> +                   skb->tun_vnet_hash) {
>>>>>
>>>>> Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
>>>>> the set hash ioctl failing otherwise?
>>>>>
>>>>> Such checks should be limited to control path where possible
>>>>
>>>> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are
>>>> not read at once.
>>>
>>> It should not be possible to downgrade the hdr_sz once v1 is selected.
>>
>> I see nothing that prevents shrinking the header size.
>>
>> tun->vnet_hash.flags is read after vnet_hdr_sz so the race can happen
>> even for the case the header size grows though this can be fixed by
>> reordering the two reads.
> 
> One option is to fail any control path that tries to re-negotiate
> header size once this hash option is enabled?
> 
> There is no practical reason to allow feature re-negotiation at any
> arbitrary time.

I think it's a bit awkward interface design since tun allows to 
reconfigure any of its parameters, but it's certainly possible.
