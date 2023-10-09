Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DD7BD57A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjJIIoc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345482AbjJIIoa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:44:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9BAC
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Oct 2023 01:44:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-694ed84c981so3088943b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Oct 2023 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696841068; x=1697445868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NgGjX5YpaL52FNYH4ty5Y7bA0h/vA8gQAgoFoY58+k=;
        b=qJFvg8/1UQjpzWGLwmhfH00/0lkT4jImKvjzwp2hDS/aOBQNVTpG0POeQ6cKGGPK8p
         rf7z2ZsEpX3gloi21jYM4THdYPgLGsgZKZUcALwD+rNztpgZhfDe57/2FdP2yszVkB0K
         vUhepehp2OvuSv71WfEGXL8l+HOb/zLXGJvc945HB4/13JTnixq3wzPer1D+KsVICzAT
         qi3zRPO+DwUU9lT4FkOTExfcW5WCxnEfl3/o9cq9mTf9bP13Th4KkCbwCks/S73A+f1v
         Q4pkncYWHMRQMYhb5b1qp2sqqXdTXV/yDAhEL25srHWBDymeQIs+jQs+JhFO1eYoOCEl
         0wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841068; x=1697445868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NgGjX5YpaL52FNYH4ty5Y7bA0h/vA8gQAgoFoY58+k=;
        b=djjAwj9Ldbe3mTpJpzk+r9BlAtbVCpzRiW6bHcGEkUr6yOoLEJPLlgsWUvRZ2lqoqE
         CQhpGErUh7Wh87nOLYg02SF+sVN64ykXvCvCH9QVG88pnTKSaSfvVeYgXTsvAh7gc1RP
         dINO4qtuhSdSiCBRcLmbr0UXBHSL0kKe6Wt8B7NsYAkBfw8v+voj1rtaVJEf3Om1fSCq
         NmAic55VVuLnef3Nblj+Y1b5QB1QSM7tc0x3IG3sS7uxLYO6J8I9KdBL8TvOhW07es6Y
         ydO75xJSv7tPmT/J5bbikYjfZfM9kh3/4xP+ehXZUj06mKLTUKiLPWFdV9DjN6nIcnoB
         32AA==
X-Gm-Message-State: AOJu0Yx1/SuNkp/fo7cwcHQB2jGR7XQlpENtrmsHWu7CpuJiCokB5TK+
        AHEDwrmiGy6fehLYM36CqHFD7Q==
X-Google-Smtp-Source: AGHT+IEcrHvp+wzPkmT4qVttYLRxHzYhOeFcQDW6k9Tp2oL71t/M9yU8JDgBz9yQNjgE76O5vK0sAA==
X-Received: by 2002:a05:6a20:2445:b0:14e:3ba7:2933 with SMTP id t5-20020a056a20244500b0014e3ba72933mr14489341pzc.54.1696841068641;
        Mon, 09 Oct 2023 01:44:28 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id h19-20020aa786d3000000b0068ff267f092sm5777762pfo.216.2023.10.09.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:44:28 -0700 (PDT)
Message-ID: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
Date:   Mon, 9 Oct 2023 17:44:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
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
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
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

On 2023/10/09 17:13, Willem de Bruijn wrote:
> On Sun, Oct 8, 2023 at 12:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
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
> 
>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>          }
>>
>>          if (vnet_hdr_sz) {
>> -               struct virtio_net_hdr gso;
>> +               union {
>> +                       struct virtio_net_hdr hdr;
>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
>> +               } hdr;
>> +               int ret;
>>
>>                  if (iov_iter_count(iter) < vnet_hdr_sz)
>>                          return -EINVAL;
>>
>> -               if (virtio_net_hdr_from_skb(skb, &gso,
>> -                                           tun_is_little_endian(tun), true,
>> -                                           vlan_hlen)) {
>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
>> +                   vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
>> +                   skb->tun_vnet_hash) {
> 
> Isn't vnet_hdr_sz guaranteed to be >= hdr.v1_hash_hdr, by virtue of
> the set hash ioctl failing otherwise?
> 
> Such checks should be limited to control path where possible

There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz are 
not read at once.
