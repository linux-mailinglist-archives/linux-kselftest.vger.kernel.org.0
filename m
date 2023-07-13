Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AA752556
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGMOkW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGMOkV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5C1991
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689259177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfVJf+CjaE6DuMWqWkr20N6XnbITZj0/2XbgRP6AAJI=;
        b=YqSu2PL1qvrRgvcr5H24ENOuZl/eIyVcVAxF/yekhuJzGAthZUNj6znW2BXWMJRnBwfQ/8
        JK48NHPSzBd+H56PyEfYuOtAPWw6rJw/LE69G99Die7O+gBfgr3mquYEF37Wwsh059Xr90
        R9EQX6CCHOSW4T2D1Qx7L9Hykfs31ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-xu_GpVfLNWGjKco712quRQ-1; Thu, 13 Jul 2023 10:39:36 -0400
X-MC-Unique: xu_GpVfLNWGjKco712quRQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so4439675e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259175; x=1691851175;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfVJf+CjaE6DuMWqWkr20N6XnbITZj0/2XbgRP6AAJI=;
        b=jMoZg33VlBWk1yuUR97KV8OaeCBBlcSrnVItHNh6gYlJhj5YgiR/cUdIpiDhJdMgzZ
         cGDyNoh+JTEIr/UrJWaF0BhA5Etlfh9a0tuNbFS2ORir66ktp6becUa2Ft/w1uSs1jLt
         HbHvwGmfggch95PRz0cM3TnvXS04xhJTgTXO1BuhgDATOAuUydIlN6erzKEIZdjOfpY0
         b4rvIfqy2eeUZc7Rbn4Nww7CT4pFypz4PYWJA/f29Xim7UetSDlYkhBQO4Ad1hxBCs1T
         JUhyNiNBTyZZ7NHGcKG7v3yC8rH6RC/5SkQ0zzVq6gkaKHE8N8k7UwvhWjMSNJD5UO6h
         on9g==
X-Gm-Message-State: ABy/qLaMpOM6eeHFhtdinOhJSYRnCIs8toXJvdsVq5uJrXyjKoeLDC2q
        6aA11sC1WzEbu8eAB973NBfJFTmj4elAgiBMOytzAyeOjvtB5+GBCmliNjkC66M15fqjxrm/R/z
        EXwE9HyD6ewFDjpwOK3atx9yvH/dE
X-Received: by 2002:adf:f887:0:b0:314:4db:e0bd with SMTP id u7-20020adff887000000b0031404dbe0bdmr1905883wrp.11.1689259175306;
        Thu, 13 Jul 2023 07:39:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSjMYfGqhv6sHrb1dNLPmiyVP/KsEwzfsp5VIi+Zc70Ljs1HbCLTVI/ixiy7GeEU81Mz2Nfw==
X-Received: by 2002:adf:f887:0:b0:314:4db:e0bd with SMTP id u7-20020adff887000000b0031404dbe0bdmr1905861wrp.11.1689259174914;
        Thu, 13 Jul 2023 07:39:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b003063a92bbf5sm8107671wrm.70.2023.07.13.07.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:39:34 -0700 (PDT)
Message-ID: <ac816a32-cea9-363f-4490-19e6f5225c3d@redhat.com>
Date:   Thu, 13 Jul 2023 16:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-3-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.07.23 15:54, Ryan Roberts wrote:
> When run under run_vmtests.sh, test scripts were failing to run with
> "permission denied" due to the scripts not being executable.
> 
> It is also annoying not to be able to directly invoke run_vmtests.sh,
> which is solved by giving also it the execute permission.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 0
>   tools/testing/selftests/mm/check_config.sh             | 0
>   tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 0
>   tools/testing/selftests/mm/run_vmtests.sh              | 0
>   tools/testing/selftests/mm/test_hmm.sh                 | 0
>   tools/testing/selftests/mm/test_vmalloc.sh             | 0
>   tools/testing/selftests/mm/va_high_addr_switch.sh      | 0
>   tools/testing/selftests/mm/write_hugetlb_memory.sh     | 0
>   8 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100644 => 100755 tools/testing/selftests/mm/charge_reserved_hugetlb.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/check_config.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/test_hmm.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/test_vmalloc.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/va_high_addr_switch.sh
>   mode change 100644 => 100755 tools/testing/selftests/mm/write_hugetlb_memory.sh
> 
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/test_hmm.sh b/tools/testing/selftests/mm/test_hmm.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/mm/write_hugetlb_memory.sh b/tools/testing/selftests/mm/write_hugetlb_memory.sh
> old mode 100644
> new mode 100755

Sounds reasonable to me.

Probably due to:

commit baa489fabd01596d5426d6e112b34ba5fb59ab82
Author: SeongJae Park <sj@kernel.org>
Date:   Tue Jan 3 18:07:53 2023 +0000

     selftests/vm: rename selftests/vm to selftests/mm
     
     Rename selftets/vm to selftests/mm for being more consistent with the
     code, documentation, and tools directories, and won't be confused with
     virtual machines.


and indeed, it contains

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
old mode 100755
new mode 100644
similarity index 100%
rename from tools/testing/selftests/vm/run_vmtests.sh
rename to tools/testing/selftests/mm/run_vmtests.sh


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

