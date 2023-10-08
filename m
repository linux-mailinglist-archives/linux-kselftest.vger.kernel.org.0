Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E97BCFE4
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjJHTxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjJHTxH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 15:53:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1884DC6
        for <linux-kselftest@vger.kernel.org>; Sun,  8 Oct 2023 12:53:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-279013f9875so2886677a91.2
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Oct 2023 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696794785; x=1697399585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Uv8Y0M++mQixpZTlMb33uLQAMyKnaxhqJJACDwT/pw=;
        b=mCLHaxE2ab2ajnYex38vNuN9AqistHyuK55N+d2WFakQm4bQwtCj5vtbSlnWTHil0S
         FSoCAg9MWDQXzqIv7DEAbW6EEPNAaywyg/7rNr+X8LQ30qnVqDyK2nKRthZTmFVEjRFy
         nLsCkTE/KYjP9jQIK35L0TLJcLuzMGSXeHtIgnS4dlWS4g6OcrOt0pJ4q0IeIRxEwTJh
         yiA9B9BNVAtbZhhttbtNxbIvg+HCtsyk3evAF97CBPINAnTIq4kmosPzi4ihkpJ4+hYK
         h2t39+pP89217lvzM1maGc/vnQ4QWKypF5EkVXBE4l7NGlFqgvBtBoDYRJlBQsaDHKDO
         OZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696794785; x=1697399585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Uv8Y0M++mQixpZTlMb33uLQAMyKnaxhqJJACDwT/pw=;
        b=Kdu0mAGfd6bUJrUUTf+EKJpWl/6amt/vbhbsfZqPHq62fgZRwWZ7hjwcXfLd2JTGj2
         xfLh360C2NTp2lB1zk3ZK6iNWk6H2Dvx9b2GmZhc/Vpei61OB0X9/2l9QYhSjv7VMnhk
         NwySJ97sWzYBgZnUYgAiwLc7yw2c59QLgFVEszk3HGHTq0VObgS8YdZJcDnlRyxJcIW1
         fCCx3hQmWGP1C0Ugoa13wHmvbdzff1YpqiMcJDKLGgO1GOMYwk+vxQWI+zrae8K7aQ3t
         euc+kRPFemBzSsEHJ2HM6vl7mynNkUL5vPyhgu9z6HrEapT/CxGbf8UtoQ1JC3EgsEfQ
         2UcA==
X-Gm-Message-State: AOJu0YzTaI5fNS38INLRIvt+ZiwejCszcQE97fRGVpZJGYndMr9GOdKy
        ae21stTUV3yX6ZhNmP+cy35big==
X-Google-Smtp-Source: AGHT+IHmvYqxiZYxvjOaXv1owmEpRG5mjS+edfQG0QgyP3o61v9y0A2CZuxDZy4/qGKtNUW7lwQ4rA==
X-Received: by 2002:a17:90b:4f8c:b0:26f:f272:144c with SMTP id qe12-20020a17090b4f8c00b0026ff272144cmr11640942pjb.27.1696794785181;
        Sun, 08 Oct 2023 12:53:05 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090aeb0500b0026f90d7947csm6736541pjz.34.2023.10.08.12.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 12:53:04 -0700 (PDT)
Message-ID: <4f2ce89f-a018-4a43-97b6-e9d43020e158@daynix.com>
Date:   Mon, 9 Oct 2023 04:52:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] net: skbuff: Add tun_vnet_hash flag
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
 <20231008052101.144422-2-akihiko.odaki@daynix.com>
 <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAF=yD-K0RR5XCuPdHS8gPwppM-HAmodSOVBpS=v+j8X7=Su2Rg@mail.gmail.com>
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

On 2023/10/09 3:39, Willem de Bruijn wrote:
> On Sun, Oct 8, 2023 at 7:22 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> tun_vnet_hash can use this flag to indicate it stored virtio-net hash
>> cache to cb.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/skbuff.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 4174c4b82d13..e638f157c13c 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -837,6 +837,7 @@ typedef unsigned char *sk_buff_data_t;
>>    *     @truesize: Buffer size
>>    *     @users: User count - see {datagram,tcp}.c
>>    *     @extensions: allocated extensions, valid if active_extensions is nonzero
>> + *     @tun_vnet_hash: tun stored virtio-net hash cache to cb
>>    */
>>
>>   struct sk_buff {
>> @@ -989,6 +990,7 @@ struct sk_buff {
>>   #if IS_ENABLED(CONFIG_IP_SCTP)
>>          __u8                    csum_not_inet:1;
>>   #endif
>> +       __u8                    tun_vnet_hash:1;
> 
> sk_buff space is very limited.
> 
> No need to extend it, especially for code that stays within a single
> subsystem (tun).
> 
> To a lesser extent the same point applies to the qdisc_skb_cb.

I had to extend sk_buff because it does not stay in tun but moves back 
and forth between qdisc and tun.

The new members of sk_buff and qdisc_skb_cb are stored by tun's 
ndo_select_queue(). The control will go back to qdisc after 
ndo_select_queue() function finishes. Eventually tun's ndo_start_xmit() 
will be called by qdisc and consumes the stored members. qdisc is 
required to keep the stored members intact.

tun_vnet_hash is a bit special. It is put into sk_buff because 
ndo_select_queue() is not always called and it may be left 
uninitialized. ndo_start_xmit() may read some garbage from cb's old user 
if it is put into cb.
