Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB54CC851
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiCCVq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 16:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiCCVq4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 16:46:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE7546B1
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 13:46:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id x14so5089156ill.12
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 13:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dK/IOow+P5v9xYBFUtB5XaIy2vFaJ6VtzofO9XJ2vLA=;
        b=iaUIzEybhNynRX57A9NPhLVQR8qWsrW87j7I2gP6PfPhB1N2KJLDGvER3L91GYIYfn
         kx4r6NK8bwnmnvZrmxOmn5r5YGx78vycqExakQs/gIf+aQtfsFWLFv7Mbo/h4kK+Fby1
         +ku6NcFXonpuW2pUXBf80x6Inw567tXGOV9Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dK/IOow+P5v9xYBFUtB5XaIy2vFaJ6VtzofO9XJ2vLA=;
        b=tq9/O/PPwasIeetWNXM7X+XKAfSUbJRBkeTwaCOy54FVCY/4Zrjw8dbmd9xM1rizDY
         sywTYQfPG9wzggKxA8QD6Dsp4GwSuSPdZQsJuZwQl5qSoZAJKYpEQeQiPba2533RsDDl
         MWlHauQDSUbA7JiNkao4m/ZE4OJ0zEby7G9vT0igY5CRlN+3pnBAMd2//6p4XLxrJ2Qs
         b0fnkQhD0RftIiIogU4/y/mHKoEnZsIBm9vMgXPYVs8Q1j8aTAr7kom7MJ5alt7ntSlN
         Nv7o76gcg7TTYnaFt4M8QOcWLlhlPEFrrZEQJHvdTfrj00lyOrMQW+FXuZ7adLUoxzDS
         H8Aw==
X-Gm-Message-State: AOAM532KWHgf1vWFrqKTQeM+wG+V6COVIaqbXc6HPDOlotAuwcHAUITo
        yUu0dXmB2bKzK5d/pSjMG0BSbQ==
X-Google-Smtp-Source: ABdhPJxFTfoJrFkecC1ukZMVcqeTeGXHhkLuHmnCG5OGT8GcD+G3FBEHb10TRMnae/SeoXVaG9ANcA==
X-Received: by 2002:a92:c888:0:b0:2c2:fb23:1cf with SMTP id w8-20020a92c888000000b002c2fb2301cfmr16145861ilo.301.1646343969977;
        Thu, 03 Mar 2022 13:46:09 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b10-20020a056602000a00b0064074921986sm2779927ioa.41.2022.03.03.13.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:46:09 -0800 (PST)
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
 <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
 <6133317f-4da0-3aae-f352-b75f0f94dbd4@linuxfoundation.org>
 <87o82mkhif.fsf@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ee9b8c8b-0d27-bd01-e10d-9062c32f2486@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 14:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87o82mkhif.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/22 11:39 AM, Gabriel Krisman Bertazi wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> On 2/28/22 2:37 AM, David Hildenbrand wrote:
>>> On 24.02.22 22:23, Muhammad Usama Anjum wrote:
>>>> This introduces three tests:
>>>> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
>>>> check if the SD bit flipped.
>>>> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
>>>> 3) Check soft-dirty on huge pages
>>>>
>>>> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
>>>> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
>>>> same issue that he fixed, and this test would have caught it.
>>>>
>>> A note that madv_populate.c already contains some SOFTDIRTY tests
>>> regarding MADV_POPULATE. Eventually we want to factor out
>>> softdirty/pagemap handling+checks for easier reuse.
>>>
>>
>> Is this patch unnecessary then?
> 
> It is not unnecessary since the madv test doesn't cover the bug tested
> here, afaik.  But, as mentioned when I originally submitted this patch,
> it should be merged into selftests/vm/madv_populate.c or, at least,
> reuse that existing infrastructure.
> 
> https://lore.kernel.org/lkml/87lf553z5g.fsf@collabora.com/
> 

Oops this one came in a few months ago and appears to have slipped
through and didn't get the right attention. Sorry about that.

Please resend the patch and cc all the everybody on this thread.

I would like to have your patch reviewed and looked at first. This
patch needs rework sine it has several comments to be addressed.

thanks,
-- Shuah
