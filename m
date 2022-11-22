Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB0633638
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 08:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiKVHsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 02:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiKVHsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 02:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5250326E0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669103243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOlyqNEjSyWRhu789TgVJBojhnd7QCjs246Hat/OGCs=;
        b=NDvqtcoxOtHwCgmaQNu4Vy6F5sTGTDQD8pgysZcedFkf6yaOczSN9oDFXDoouaQgdyyGov
        0BP1mf8NrlajGHmQCt99dPuQH7OkEflijGDE8juFlnRc2RvIjM4t8wnMfXVag8XYVm8Wnx
        quuvnwG/8S0nCWybtsBNuLYmpnzkXaM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-j6Xyyx90NqWvNU0ZwlvZyw-1; Tue, 22 Nov 2022 02:47:21 -0500
X-MC-Unique: j6Xyyx90NqWvNU0ZwlvZyw-1
Received: by mail-wm1-f71.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so7686829wmh.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 23:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOlyqNEjSyWRhu789TgVJBojhnd7QCjs246Hat/OGCs=;
        b=nglIws9uCO2wk9Df0Gr9hA03tMJczBIQ1c23LPWM9QLcI65JFIFGNCzwjuiQZ4vqde
         dPSry5iMKh7DmE/MWN2q+ipkVaJ9aVfNSnXfqtuTJkMbVbYvQwE7KHVxZ36r76+GXrOy
         I1BgBxcn1NDYKFO1uxh5Fee2xYEI42yhzlUPSWxEirU1CDLhc6NeY/jgJkkbtd+A1xYp
         mj/jpLlFysqyFW+kNaskl+qBoZEoQ6ysYbJw2kAGsz/aNYZrnojSstles59PgEat5IGs
         826Qt5cGo/P4zYaCefcRKnNKhZnCi9vdNAigoBL65IJyQwwdCguYuihUTHjC03+QyO79
         Ka1A==
X-Gm-Message-State: ANoB5plxCLAH91kPYzzu2/S7/4U2e8f7JYi1qhrZWikeaZCIP3jACxl8
        IznqpxqpA48/8z3llch88KOca8qcx0CkesmXuVQcnm3EtvtIxjKmW7wPVkKGb6BymCd7BDh9QNY
        Bb/nSmNKnB43Q1i4Eb3BCmq0dxdZn
X-Received: by 2002:a05:600c:3492:b0:3cf:ad59:1465 with SMTP id a18-20020a05600c349200b003cfad591465mr7757614wmq.12.1669103240155;
        Mon, 21 Nov 2022 23:47:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qTCZJA4RPHbgTxYLrcLE6vAWROLjIVZidpN6a8sJSfb4cCoT7Ya0f5MC2dVrj3W0Qw/zP0A==
X-Received: by 2002:a05:600c:3492:b0:3cf:ad59:1465 with SMTP id a18-20020a05600c349200b003cfad591465mr7757600wmq.12.1669103239912;
        Mon, 21 Nov 2022 23:47:19 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-176-72.web.vodafone.de. [109.43.176.72])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm20150358wmf.8.2022.11.21.23.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:47:19 -0800 (PST)
Message-ID: <f96b50e2-24ac-4016-d3f1-ffc375516e7c@redhat.com>
Date:   Tue, 22 Nov 2022 08:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
 <20221117221758.66326-3-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
In-Reply-To: <20221117221758.66326-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/11/2022 23.17, Janis Schoetterl-Glausch wrote:
> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> absolute vm write memops which allows user space to perform (storage key
> checked) cmpxchg operations on guest memory.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
...
>   Supported flags:
>     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
>     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> +
> +The semantics of the flags common with logical acesses are as for logical
> +accesses.
> +
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.

I'd maybe merge this with the last sentence:

For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if 
KVM_CAP_S390_MEM_OP_EXTENSION has bit 1 (i.e. bit with value 2) set.

... and speaking of that, I wonder whether it's maybe a good idea to 
introduce some #defines for bit 1 / value 2, to avoid the confusion ?

> +In this case, instead of doing an unconditional write, the access occurs only
> +if the target location contains the "size" byte long value pointed to by
> +"old_p". This is performed as an atomic cmpxchg.

I had to read the first sentence twice to understand it ... maybe it's 
easier to understand if you move the "size" part to the second sentence:

In this case, instead of doing an unconditional write, the access occurs 
only if the target location contains value pointed to by "old_p". This is 
performed as an atomic cmpxchg with the length specified by the "size" 
parameter.

?

> "size" must be a power of two
> +up to and including 16.
> +The value at the target location is written to the location "old_p" points to.

IMHO something like this would be better:

The value at the target location is replaced with the value from the 
location that "old_p" points to.

> +If the exchange did not take place because the target value doesn't match the
> +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> +has bit 1 (i.e. bit with value 2) set.

  Thomas

PS: Please take my suggestions with a grain of salt ... I'm not a native 
speaker either.

