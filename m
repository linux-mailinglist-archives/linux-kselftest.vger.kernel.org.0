Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828425B37AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 14:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiIIMVA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIIMUn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7831EFD
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Sep 2022 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662725922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1UePzLOz1wZO53Q7qIAQAN+1mLe/XFxJBDYGz76QS8=;
        b=Qeytg9/BO0qXTWoCArJi8AwRp+KWpyMpshDExzdcsHI5hwHnO9WkKwIO3438onAZq9VM8M
        E8H8ph8w9OKCauURi2olgoUKKK1jfBSoau89x/DhHVLawRzaS3wiQQKKFg1mxNd0HfK47f
        2nESQo4RyreKgdNT4VTINXEmrc7zQlo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-liOy2fSSPPi3hOSm8IFJXg-1; Fri, 09 Sep 2022 08:18:40 -0400
X-MC-Unique: liOy2fSSPPi3hOSm8IFJXg-1
Received: by mail-wm1-f70.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so771035wmq.9
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Sep 2022 05:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=C1UePzLOz1wZO53Q7qIAQAN+1mLe/XFxJBDYGz76QS8=;
        b=3uoCDLvdxd0NPmD4ILDe1nU8XHo07oqrE+WW79hXJNy+2QF7NZJim5j1J6AxF/0U++
         2oADQYc085prh/JsKxw8HM7oebs0KFGVH4F+nnwTI12Vo/qSw5cEjep3Sb+UndQu2Up2
         qef/jvSm8JA8O6Ny8IB2SKBJ/atK0g3PCR9WP27Wukzq1MQiR45WpT2yWcR3joZLWY4Z
         G1Mx007kyZS2s16qI5Jk8pqeqE5e7FEzFGMFfxmT/Jn0KQBinriSDKdMPiRoKGHbOOU2
         cTWAFdNlOef8C2yPeHPFYuD6CpMA1tjDqwkHEjZiYo0H8a2xde+iE9IQpIAvbeDDpXIM
         ohOg==
X-Gm-Message-State: ACgBeo2OpNbudJ8d3WO2tQw5Bb9ChPXGlJ/6AF1OOnCxYsOcHKLqthZx
        8nTefw+rdM36brIIgBqmMCZmkQNSx1N9oDOYGJkEdxR+KTxIzQeew3Ib1kguq/nvPyYvqU3tz89
        eb/y2+lca0RAd/jUpCAmeRvbJfOEA
X-Received: by 2002:adf:aad8:0:b0:228:da00:72ed with SMTP id i24-20020adfaad8000000b00228da0072edmr7790410wrc.483.1662725919599;
        Fri, 09 Sep 2022 05:18:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5tMHThzhDM9UmbRu652GEnmckUCr5U/s1IUwwqCuZv5g0XbC/1Nbh7KIdE4A7S+yBwuQn5xQ==
X-Received: by 2002:adf:aad8:0:b0:228:da00:72ed with SMTP id i24-20020adfaad8000000b00228da0072edmr7790394wrc.483.1662725919361;
        Fri, 09 Sep 2022 05:18:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b003a5c1e916c8sm1711870wmb.1.2022.09.09.05.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:18:38 -0700 (PDT)
Message-ID: <8b36d6dd-5973-e9c3-0a5d-2521753d04bd@redhat.com>
Date:   Fri, 9 Sep 2022 14:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 5/5] docs: notifier-error-inject: Correct test's
 name
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220909075200.198363-1-zhaogongyi@huawei.com>
 <20220909075200.198363-6-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909075200.198363-6-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09.09.22 09:52, Zhao Gongyi wrote:
> Correct test's name for mem-on-off-test.sh/cpu-on-off-test.sh.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   Documentation/fault-injection/notifier-error-inject.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fault-injection/notifier-error-inject.rst b/Documentation/fault-injection/notifier-error-inject.rst
> index 0e2790122166..170c583eb5bc 100644
> --- a/Documentation/fault-injection/notifier-error-inject.rst
> +++ b/Documentation/fault-injection/notifier-error-inject.rst
> @@ -95,8 +95,8 @@ For more usage examples
>   There are tools/testing/selftests using the notifier error injection features
>   for CPU and memory notifiers.
> 
> - * tools/testing/selftests/cpu-hotplug/on-off-test.sh
> - * tools/testing/selftests/memory-hotplug/on-off-test.sh
> + * tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> + * tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> 
>   These scripts first do simple online and offline tests and then do fault
>   injection tests if notifier error injection module is available.
> --
> 2.17.1
> 
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

