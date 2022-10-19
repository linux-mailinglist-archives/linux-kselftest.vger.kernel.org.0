Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3C604608
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 14:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJSMzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiJSMyp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 08:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C45973D
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666183021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mboaMe9gaID9QBKkicmcYb6FMJMHWN52iMVH+ykHQY=;
        b=Jxs9wlo3cQ8Y5b7hSVNXXa/lvw/ShTEEn6+zZOpkmf4OaOJn1KRgA7En6frM1vum2C/J+W
        2LCH7m+jwZzhzl8GxptmyfughykAaTmYHRl34iu21+t+CzHjI4wYktaJuHU7r4wWal+vsi
        MneYBJWsc8pdLB09pxMt/bcwjtOhFpg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-om9sa7FwOgmlgUu-l_i30g-1; Wed, 19 Oct 2022 08:33:20 -0400
X-MC-Unique: om9sa7FwOgmlgUu-l_i30g-1
Received: by mail-wr1-f69.google.com with SMTP id s30-20020adfa29e000000b002302b9671feso5576452wra.20
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Oct 2022 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mboaMe9gaID9QBKkicmcYb6FMJMHWN52iMVH+ykHQY=;
        b=WBWmctP1bgt6Biox8NjpY492fx12nrbqR4wRA6rfe5WbMKdh09kCeRT41EFhauL4cW
         Clpm5MZZxCjluDbbB9QlxM/02f5NZ47zsMVcbesYB2gKTvICrIupmx9LNn+TNLy9O1bH
         gf/YJI9lFCWK2/9/+0ofe1605puopEe8IKopJOuwMhAu05mPGiMt0cQZO/mtV19+IvsY
         bSALVdyhqzkT/eFuk1uqeEG1fYcbnzV8KTXhQWI0CL4CtXQBppE4xlfYiVPg0BbzRCk9
         1pIvWzMr24jMymqMXQQVK3YtpkyvPYqClbYd0pv2K0Ra8WDc3qso5ORuiS5Sl04tDT41
         QInw==
X-Gm-Message-State: ACrzQf2WzwL34+GKejXQmflWEihMmPCivLQlnfK7fubCcwTRbbYKOIdg
        PDGNiNpiUgYruwSZgVl9z7l9rH4kL31QywLl41t5Qf550fsBClqdAGPyVYuB7a+AKtUfN42zMIS
        agduc8GMOJ3CuHz9gI+b4fn92D6aQ
X-Received: by 2002:a5d:4748:0:b0:22e:32c1:d11e with SMTP id o8-20020a5d4748000000b0022e32c1d11emr5097436wrs.672.1666182799548;
        Wed, 19 Oct 2022 05:33:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ZCpAtby+E6unN5Wy+u9IszQTZYL2BSwB5rLUNO2OIQj+D41SXgbcnflDb4tj98oOc8cmhlQ==
X-Received: by 2002:a5d:4748:0:b0:22e:32c1:d11e with SMTP id o8-20020a5d4748000000b0022e32c1d11emr5097411wrs.672.1666182799220;
        Wed, 19 Oct 2022 05:33:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2c00:d4ac:d2c:4aee:dac1? (p200300cbc7072c00d4ac0d2c4aeedac1.dip0.t-ipconnect.de. [2003:cb:c707:2c00:d4ac:d2c:4aee:dac1])
        by smtp.gmail.com with ESMTPSA id j30-20020adfa55e000000b0021e51c039c5sm14342243wrb.80.2022.10.19.05.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:33:18 -0700 (PDT)
Message-ID: <c1bcb281-c4ef-3b7d-f24d-82569602939b@redhat.com>
Date:   Wed, 19 Oct 2022 14:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 7/7] selftests/vm: anon_cow: add R/O longterm tests via
 gup_test
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>
References: <20220927110120.106906-1-david@redhat.com>
 <20220927110120.106906-8-david@redhat.com>
 <74adbb51-6e33-f636-8a9c-2ad87bd9007e@redhat.com>
Organization: Red Hat
In-Reply-To: <74adbb51-6e33-f636-8a9c-2ad87bd9007e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.10.22 14:31, David Hildenbrand wrote:
> On 27.09.22 13:01, David Hildenbrand wrote:
>> Let's trigger a R/O longterm pin on three cases of R/O mapped anonymous
>> pages:
>> * exclusive (never shared)
>> * shared (child still alive)
>> * previously shared (child no longer alive)
>>
>> ... and make sure that the pin is reliable: whatever we write via the page
>> tables has to be observable via the pin.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> The following on top should silence the warning on 32bit:
> 
> https://lore.kernel.org/all/202210182101.XOyPZEQV-lkp@intel.com/T/#u
> 
> 
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index 2bbfacd31f5a..57c343f2dc51 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -299,7 +299,8 @@ static inline int pin_longterm_test_read(unsigned long arg)
>           for (i = 0; i < pin_longterm_test_nr_pages; i++) {
>                   void *addr = page_to_virt(pin_longterm_test_pages[i]);
>    
> -               if (copy_to_user((void __user *)user_addr, addr, PAGE_SIZE))
> +               if (copy_to_user((void __user *)(unsigned long)user_addr, addr,
> +                                PAGE_SIZE))
>                           return -EFAULT;
>                   user_addr += PAGE_SIZE;
>           }
> 
> 

Ehm, wrong patch, it actually belongs into #6/7

https://lkml.kernel.org/r/20220927110120.106906-7-david@redhat.com

@Andrew, if your confused, I can just resend the whole thing.

-- 
Thanks,

David / dhildenb

