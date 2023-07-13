Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081A75258D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGMOvw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjGMOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53186212D
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689259863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgY3eNWoJDyVraPgBNG0L3iaWsOramQllnR7Qbk0QsE=;
        b=iLXYufxx4qC7U9B20VuFHlhT+DVMa6VuE65PDOq6JPlPPAySUC2zKORUQgt6YV7T+QHJ1c
        jGJ6FxRbqQGbHEuw3XvTF/IjJraNWtq1sDqEG6nSav1IyC0J4PoJ3mgJlyx7+pDZ2U8fqI
        zjERfv1Ww/wsZ0pDcoBshyqwq1wZqUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Ac3gYYbLMRewFaWnUEnB_w-1; Thu, 13 Jul 2023 10:51:01 -0400
X-MC-Unique: Ac3gYYbLMRewFaWnUEnB_w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdde92299so4228695e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259860; x=1691851860;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgY3eNWoJDyVraPgBNG0L3iaWsOramQllnR7Qbk0QsE=;
        b=Lf1kY7wjuwF708P7rCzS9ZJe3rQstjZIO0V82LAU8bp/Y7CHn4Oe6fUOlBH15qCUSQ
         TuwyFACPwuDCMun7oln0R6mLYO49scRyPV72sTRqJHpNuR3JihQkJoDJxVtl3Espj1Jy
         4KKFHyZ12kV+v0oqFGBSIcmqDOICN1h/kwYt0nY08rMh1GLFuyf67LQUlXTccds4gv56
         6oOyj9EWpTxZr/RCep9DSg0ZjfweYI3nu39Oh9qkFAZCrm4Bh1+Ziar5SAWakTZIBTsc
         WE4nPWpPDVXVbKWbiDHcW3+R7hr3Ot5TGqi7GdqFMIHtkz4RQIczT3WuoRlzve6v/4al
         gGLw==
X-Gm-Message-State: ABy/qLYqm61K3QXC7goLlYxMY8qP84Ja979urfi6R9ZMVsZmzihcfdYM
        2+WDyUy7S6yCpKBxrS8HelIVqGbhR+6H6BMQd0YCWWr76XtwrlakTmhMXnGAI2B4ctJxm4PqPj5
        M1s4NeZ8DtdpW4/BomKo5GofBL2b0TuwqaqSL
X-Received: by 2002:a05:600c:d3:b0:3fb:b18e:9b1a with SMTP id u19-20020a05600c00d300b003fbb18e9b1amr1657037wmm.8.1689259860023;
        Thu, 13 Jul 2023 07:51:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWJ1q5Sz10QYtjyb+BF1nTFbYVGRnHm4ZzXGCyTFsOCHGZVg5mVEjZasw10rhoBBEJSRnsLg==
X-Received: by 2002:a05:600c:d3:b0:3fb:b18e:9b1a with SMTP id u19-20020a05600c00d300b003fbb18e9b1amr1657015wmm.8.1689259859629;
        Thu, 13 Jul 2023 07:50:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fc05b89e5bsm7999378wma.34.2023.07.13.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:50:59 -0700 (PDT)
Message-ID: <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
Date:   Thu, 13 Jul 2023 16:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
In-Reply-To: <20230713135440.3651409-10-ryan.roberts@arm.com>
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
> It is very unclear to me how one is supposed to run all the mm selftests
> consistently and get clear results.
> 
> Most of the test programs are launched by both run_vmtests.sh and
> run_kselftest.sh:
> 
>    hugepage-mmap
>    hugepage-shm
>    map_hugetlb
>    hugepage-mremap
>    hugepage-vmemmap
>    hugetlb-madvise
>    map_fixed_noreplace
>    gup_test
>    gup_longterm
>    uffd-unit-tests
>    uffd-stress
>    compaction_test
>    on-fault-limit
>    map_populate
>    mlock-random-test
>    mlock2-tests
>    mrelease_test
>    mremap_test
>    thuge-gen
>    virtual_address_range
>    va_high_addr_switch
>    mremap_dontunmap
>    hmm-tests
>    madv_populate
>    memfd_secret
>    ksm_tests
>    ksm_functional_tests
>    soft-dirty
>    cow
> 

Which run_kselftest.sh are you referring to, the one in the parent directory?

How to invoke it to run these mm tests?

(I never dared invoking something different than
run_vmtests.sh ;) )

[...]

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/Makefile       | 79 ++++++++++++-----------
>   tools/testing/selftests/mm/run_vmtests.sh | 23 +++++++
>   tools/testing/selftests/mm/settings       |  2 +-
>   3 files changed, 64 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 66d7c07dc177..881ed96d96fd 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -35,39 +35,39 @@ MAKEFLAGS += --no-builtin-rules
>   CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>   LDLIBS = -lrt -lpthread
>   
> -TEST_GEN_PROGS = cow
> -TEST_GEN_PROGS += compaction_test
> -TEST_GEN_PROGS += gup_longterm
> -TEST_GEN_PROGS += gup_test
> -TEST_GEN_PROGS += hmm-tests
> -TEST_GEN_PROGS += hugetlb-madvise
> -TEST_GEN_PROGS += hugepage-mmap
> -TEST_GEN_PROGS += hugepage-mremap
> -TEST_GEN_PROGS += hugepage-shm
> -TEST_GEN_PROGS += hugepage-vmemmap
> -TEST_GEN_PROGS += khugepaged
> -TEST_GEN_PROGS += madv_populate
> -TEST_GEN_PROGS += map_fixed_noreplace
> -TEST_GEN_PROGS += map_hugetlb
> -TEST_GEN_PROGS += map_populate
> -TEST_GEN_PROGS += memfd_secret
> -TEST_GEN_PROGS += migration
> -TEST_GEN_PROGS += mkdirty
> -TEST_GEN_PROGS += mlock-random-test
> -TEST_GEN_PROGS += mlock2-tests
> -TEST_GEN_PROGS += mrelease_test
> -TEST_GEN_PROGS += mremap_dontunmap
> -TEST_GEN_PROGS += mremap_test
> -TEST_GEN_PROGS += on-fault-limit
> -TEST_GEN_PROGS += thuge-gen
> -TEST_GEN_PROGS += transhuge-stress
> -TEST_GEN_PROGS += uffd-stress
> -TEST_GEN_PROGS += uffd-unit-tests
> -TEST_GEN_PROGS += soft-dirty
> -TEST_GEN_PROGS += split_huge_page_test
> -TEST_GEN_PROGS += ksm_tests
> -TEST_GEN_PROGS += ksm_functional_tests
> -TEST_GEN_PROGS += mdwe_test
> +TEST_GEN_FILES = cow
> +TEST_GEN_FILES += compaction_test
> +TEST_GEN_FILES += gup_longterm
> +TEST_GEN_FILES += gup_test
> +TEST_GEN_FILES += hmm-tests
> +TEST_GEN_FILES += hugetlb-madvise
> +TEST_GEN_FILES += hugepage-mmap
> +TEST_GEN_FILES += hugepage-mremap
> +TEST_GEN_FILES += hugepage-shm
> +TEST_GEN_FILES += hugepage-vmemmap
> +TEST_GEN_FILES += khugepaged
> +TEST_GEN_FILES += madv_populate
> +TEST_GEN_FILES += map_fixed_noreplace
> +TEST_GEN_FILES += map_hugetlb
> +TEST_GEN_FILES += map_populate
> +TEST_GEN_FILES += memfd_secret
> +TEST_GEN_FILES += migration
> +TEST_GEN_FILES += mkdirty
> +TEST_GEN_FILES += mlock-random-test
> +TEST_GEN_FILES += mlock2-tests
> +TEST_GEN_FILES += mrelease_test
> +TEST_GEN_FILES += mremap_dontunmap
> +TEST_GEN_FILES += mremap_test
> +TEST_GEN_FILES += on-fault-limit
> +TEST_GEN_FILES += thuge-gen
> +TEST_GEN_FILES += transhuge-stress
> +TEST_GEN_FILES += uffd-stress
> +TEST_GEN_FILES += uffd-unit-tests
> +TEST_GEN_FILES += soft-dirty
> +TEST_GEN_FILES += split_huge_page_test
> +TEST_GEN_FILES += ksm_tests
> +TEST_GEN_FILES += ksm_functional_tests
> +TEST_GEN_FILES += mdwe_test

IIRC, we recently converted all to TEST_GEN_PROGS. See

commit aef6fde75d8c6c1cad4a0e017a8d4cbee2143723
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Apr 12 12:42:18 2023 -0400

     selftests/mm: use TEST_GEN_PROGS where proper
     
     TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
     specify programs that need to build.  Logically all these binaries should
     all fall into TEST_GEN_PROGS.
     
     Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
     all the tests easily later.


Why is that change required, and how does it interact with
run_kselftest.sh? (Not clear from you patch description.)

-- 
Cheers,

David / dhildenb

