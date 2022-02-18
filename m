Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAB4BC278
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 23:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiBRWOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 17:14:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiBRWOi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 17:14:38 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09100282E75
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 14:14:20 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e79so9225314iof.13
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kRvh89pXNItd/x2mp6FGJjeqZnxdTeQ3cxQYYtrEKbw=;
        b=V2qD2K+qZ82ve3vVDpUVgDRSLZZ6/RjziJa3qjfSqwpi4d2+xjwJ2V3UrkZPT1pP3D
         zu9wDWN5hG+CjD7GU4mpo0E+GlVHuJR2AC2DXFiPI5AmoibIg4jq8PBr4vDYvdTZr6lx
         YQ+9OmB5EKZEt14A1ZO2UJ3UE/rOmjUKJDdEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kRvh89pXNItd/x2mp6FGJjeqZnxdTeQ3cxQYYtrEKbw=;
        b=UVP8tkuzgOPo6faPCUQpVOc6jIBpx64jKJojjkVf97fHwOqo4RIJlCSnqOXe71q2+h
         aRQ5QJybuTCLdPv2ZoSpOVZ2ULqSxTTAPb6mANI1zNj6FugRqybpCsv44T1TRak8ycVU
         DEWxSreoRkJk1vF+r8fSz7aOwyHA5htdC1kMRin79sEE9f3Jq3KS4T36jZScrZq09tpL
         ndnd/rLEc4FPiaz6tNnNPupcnpCeD8yd5xCYpZ5uPrmpbjQQ3nKhts0+l5xbvFjc53bi
         ietpqvgFKlrrtGn1KmCpDyy0UeCQWsZMcWqaALWVAnefyYyZImnwrxUXD68pKtSvbvXY
         JpKA==
X-Gm-Message-State: AOAM532bgGBfVdza56/OIVQbUGxUdoiEdxgAh7TdT83lpGP8DJoL46Tz
        FZZaL65jZgQe2hFNgEoOs84/yA==
X-Google-Smtp-Source: ABdhPJwZAZsLv0iJnbTCm0NCaL9cFbZsklqOecaqVHf9ysrqUbd4zfgrA0IyN9xeJN01Rkvnd16MhA==
X-Received: by 2002:a05:6638:2116:b0:30f:cdfc:41a4 with SMTP id n22-20020a056638211600b0030fcdfc41a4mr7043751jaj.170.1645222459283;
        Fri, 18 Feb 2022 14:14:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p5sm4480301ilo.37.2022.02.18.14.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 14:14:18 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: s390: selftests: Refactor memop test
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-2-scgl@linux.ibm.com>
 <ce27dcb4-c2a3-fad6-8277-f5b86e184892@linuxfoundation.org>
 <a1c0e067-cc6a-8edb-1fe9-4aa368aa6518@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f184f1a4-be76-0fd2-bbd7-010d1fb0ef7e@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 15:14:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a1c0e067-cc6a-8edb-1fe9-4aa368aa6518@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 5:09 AM, Janis Schoetterl-Glausch wrote:
> On 2/17/22 18:36, Shuah Khan wrote:
>> On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
>>> Introduce macro for performing MEM_OP ioctls in a concise way.
>>
>> How does this help? What is the value in re-writing existing
>> code and turning it into a macro?
> 
> I want invocations of the ioctl to be independent of each other, so the reader does not
> have to keep track of the state of the struct kvm_s390_mem_op.
> 
> So you have to specify all arguments manually like so, which is rather noisy and makes it
> hard to see what the relevant parameter is:
> 
> ksmo.gaddr = guest_mem1;
> ksmo.flags = 0;
> ksmo.size = maxsize;
> ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
> ksmo.buf = (uintptr_t)mem1;
> ksmo.ar = 17;
> rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> 
> Or you introduce an abstraction.
> Previously I used lots of functions with repeated code which got chaotic.
> I decided on the macro because it's more flexible, e.g. you don't have to pass default args.
> For example, there is only one test that passes the access register arg, so you would want
> to default it to 0 for all other test.
> For the access key argument you need to pass both a flag and the key itself, so you'd probably
> get rid of this redundancy also.
> There also might be future extensions of the ioctl that work the same way
> (not 100% but not purely theoretical either).
> 
> With the macro all that is orthogonal, you just pass the argument you need or you don't.
> With functions you'd maybe add a memop_key() variant and a _ar() variant and a _key_ar()
> variant if you need it (currently not necessary), doubling the number of functions with
> each additional argument. Another example is GADDR_V and GADDR, the first takes care of
> translating the address to an physical one, but sometimes you need to pass it untranslated,
> and we need to combine that with passing a key or not.
> 
> A big improvement was making the target of the ioctl (vm/vcpu) and the operation arguments
> instead of baking it into the function. Since they're mandatory arguments this is independent
> of the macro vs functions question.
> 
> In the end there are multiple independent but interacting improvements and it is kinda
> hard to make the call on how far to go along one dimension, e.g. I was unsure if I
> wanted to introduce the DEFAULT_READ macro, but decided for it, since, as a reviewer,
> you can see that it executes the same code with different arguments, instead of trying
> to identify the difference between 5 copy-pasted and modified lines of code. On the other
> hand you have the cost of introducing an indirection.
>>
>>

Sounds good. I am not fan of macros, however, in this case macro
helps. Please split the patches so that restructuring work is
done first and then the new code - as per my suggestion on the
second patch.

thanks,
-- Shuah
