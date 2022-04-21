Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AF509BB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387249AbiDUJJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387247AbiDUJJU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 05:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23AD922B2B
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650531989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92MeHe1O2XEwswakE1YC1636cVBjLw+9Sy+IL3NtyVk=;
        b=OyskmkGBvqm2D1jUs23VQOOBVJhA44Fvr+GPjEDj+S8LBDKwiQIctwUk64ADfbRe9MYlEi
        U/EqxHVlf93cpSJIN30EBzkKhN8z+/viiUdVqztQ5sEoof7GCu4Kvg0oL0qwJXFAg+xu2g
        1Q00hrSD63s84l/VLeqPZu8T/TW/jSo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-bj5SoH8xP66NqcN7568n9Q-1; Thu, 21 Apr 2022 05:06:27 -0400
X-MC-Unique: bj5SoH8xP66NqcN7568n9Q-1
Received: by mail-wr1-f70.google.com with SMTP id i15-20020adfa50f000000b0020ac223744aso210200wrb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=92MeHe1O2XEwswakE1YC1636cVBjLw+9Sy+IL3NtyVk=;
        b=SnMGRJ4Oz+0CzhZj+Mt1mI7oIwgWTd9p5NQLWayfEhHz2HtVYJnSFxlEdas4zLCthk
         tKbkHy/Pchq+9L6lQB7MDBDTO4EJN4FLUR1UB0iN2EmDSp34yI5xz+ykWx30bF33EEqg
         X9V0eXXYTUrHrxzVLZvAOyjJMuVogXcgE0DpuiumqRfaS7aO9YmFKXhq3vxcwm6xszTZ
         zu7i5vmwJP+wVAUudAbPCUb44UQEtgvZt73WPBmcKHFXSGSCxFBK2YiwOHZnQGO2cJ8O
         IR/nL8BBaGAGIP82D5PZXlbvLlk1VQtCXUnZSR/6Omm24gcD9T+mTVRYJ8c1DKrbLmKI
         NlxA==
X-Gm-Message-State: AOAM5315HZwz361N0ZR16yDA8nQW6nNvaZiVNPW7Reur/Okc/FDSwj3B
        3BxClXj3/VAJ7cxEw5fzSII/wjPQ4keOw4eNVuf+I36UOTFxNaGukE8cN3gsQRyX1Oy46t+S01M
        Vo3C/DrdcdxaN1kwSTDHoM6D2YFHN
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr7663490wmk.77.1650531986442;
        Thu, 21 Apr 2022 02:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwll6X4aclR/cAp2Q5uSbwuZ7wO3cz51c3cWWvwaJIW1wrvG5E24IeLoGyMjdGjZ/7adpFcg==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr7663463wmk.77.1650531986214;
        Thu, 21 Apr 2022 02:06:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm1798885wmq.40.2022.04.21.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 02:06:24 -0700 (PDT)
Message-ID: <707ad285-349c-9788-51dc-12f7caf77f11@redhat.com>
Date:   Thu, 21 Apr 2022 11:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220420084036.4101604-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 20.04.22 10:40, Muhammad Usama Anjum wrote:
> Bring common functions to a new file while keeping code as much same as
> possible. These functions can be used in the new tests. This helps in
> avoiding code duplication.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V6:
> - Correct header files inclusion
> 
> Changes in V5:
> Keep moved code as same as possible
> - Updated macros names
> - Removed macro used to show bit number of dirty bit, added a comment
>   instead
> - Corrected indentation
> ---
>  tools/testing/selftests/vm/Makefile           |   7 +-
>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
>  tools/testing/selftests/vm/vm_util.h          |   9 ++
>  5 files changed, 124 insertions(+), 113 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>  create mode 100644 tools/testing/selftests/vm/vm_util.h
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 5e43f072f5b76..4e68edb26d6b6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += hugepage-vmemmap
>  TEST_GEN_FILES += khugepaged
> -TEST_GEN_FILES += madv_populate
> +TEST_GEN_PROGS = madv_populate
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
>  TEST_GEN_FILES += map_populate
> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> -TEST_GEN_FILES += split_huge_page_test
> +TEST_GEN_PROGS += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  
>  ifeq ($(MACHINE),x86_64)
> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  

Acked-by: David Hildenbrand <david@redhat.com>

BTW, I realized that my madv_populate test fails when run without
softdirty support in the kernel. Eventually we should sense support
somehow and skip softdirty tests.

Maybe we can sense by writing to some page and then testing if the page
is reported as softdirty. If it isn't, we know the kernel doesn't
support it (or is extremely buggy :D ).

Such a sense check would be common functionality in the helper file as well.

-- 
Thanks,

David / dhildenb

