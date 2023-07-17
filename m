Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50724756A56
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGQR20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGQR2W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2A41720
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5WtHncCWF3+ygwdoPe907VvBow+yKOAvExoyl7spoY=;
        b=CaEnGagdFmPDMXfq+9TGayNzxQytRiR1EjyZTZ+286Fd8+L43PvJmA48GtVP2elfSYDHZ6
        YRLTzD/UMMdqmz+iEvNm+9FPFp2gal2UAxsmTKegY65/cMtxKulpyjuD1YTpqDsMTERSXO
        DBVrTNi8yfFC+PYOj31CsILUwMVSlyA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Q6oVH_AbOx-aKMAAXzMHUg-1; Mon, 17 Jul 2023 13:27:17 -0400
X-MC-Unique: Q6oVH_AbOx-aKMAAXzMHUg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb76659d44so3758488e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614835; x=1692206835;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5WtHncCWF3+ygwdoPe907VvBow+yKOAvExoyl7spoY=;
        b=EemQR+BQIA53IQEkctmhWV35AS7BDJ4nrKW9P1N+yjUgIoPmirVHPUx2rowqNhlq1h
         4oTIdNwTj7tkYtymHofUmZAh1UBPgz3dzBEfDAARN4mpNTRsUKy1NI3PKwVavlBhbXx7
         Xg6q6iy1xTD47NaqRS0GbW4OV4cWgWC6MZG8hRTIikjOD53XiJpX0bl9R00JrTy4UwMh
         pXfOnYvbeGd5vSX9OuXNMAvnmJydummiX8BDJOEq1dV9UB2mWZSAufJxOljBEH1Dykq6
         nCXz1m8bSjbPfrdZdTZzUTpXDYcN3gXTtbRYAsgGDtPmvT2Kya+6BYm7Gq4PIofLwfnA
         ej5A==
X-Gm-Message-State: ABy/qLaqCkcEqBmypG0Ihv6bmIEwiBrRBcA5srRVwwVqiE28rdhGTWH0
        IuSeNRzckgcavtagr7A1/uh4+ZPb3I10P6MfOOT/N3KgmufR6HKZidG528onsHYY2cF7yz6Kgcm
        X82tNI7+jLfAzLB0eCLFu2Twn0nb5
X-Received: by 2002:a05:6512:acc:b0:4fb:8492:83fb with SMTP id n12-20020a0565120acc00b004fb849283fbmr9203907lfu.68.1689614835687;
        Mon, 17 Jul 2023 10:27:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENfHmen2cNCbd2icPUMMHdFvRR1Wfpqdk+4Ck+wP3t30aPgs1aZcy9uL2FIxVFjUn1iDZz8Q==
X-Received: by 2002:a05:6512:acc:b0:4fb:8492:83fb with SMTP id n12-20020a0565120acc00b004fb849283fbmr9203886lfu.68.1689614835294;
        Mon, 17 Jul 2023 10:27:15 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c62d6.dip0.t-ipconnect.de. [91.12.98.214])
        by smtp.gmail.com with ESMTPSA id r1-20020adfdc81000000b0031412b685d2sm36662wrj.32.2023.07.17.10.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:27:14 -0700 (PDT)
Message-ID: <5a12536a-2e33-7a68-6cfd-fd991ddf875a@redhat.com>
Date:   Mon, 17 Jul 2023 19:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 8/8] selftests/mm: Run all tests from run_vmtests.sh
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-9-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717103152.202078-9-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
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
> However, of this set, when launched by run_vmtests.sh, some of the
> programs are invoked multiple times with different arguments. When
> invoked by run_kselftest.sh, they are invoked without arguments (and as
> a consequence, some fail immediately).
> 
> Some test programs are only launched by run_vmtests.sh:
> 
>    test_vmalloc.sh
> 
> And some test programs and only launched by run_kselftest.sh:
> 
>    khugepaged
>    migration
>    mkdirty
>    transhuge-stress
>    split_huge_page_test
>    mdwe_test
>    write_to_hugetlbfs
> 
> Furthermore, run_vmtests.sh is invoked by run_kselftest.sh, so in this
> case all the test programs invoked by both scripts are run twice!
> 
> Needless to say, this is a bit of a mess. In the absence of fully
> understanding the history here, it looks to me like the best solution is
> to launch ALL test programs from run_vmtests.sh, and ONLY invoke
> run_vmtests.sh from run_kselftest.sh. This way, we get full control over
> the parameters, each program is only invoked the intended number of
> times, and regardless of which script is used, the same tests get run in
> the same way.
> 
> The only drawback is that if using run_kselftest.sh, it's top-level tap
> result reporting reports only a single test and it fails if any of the
> contained tests fail. I don't see this as a big deal though since we
> still see all the nested reporting from multiple layers. The other issue
> with this is that all of run_vmtests.sh must execute within a single
> kselftest timeout period, so let's increase that to something more
> suitable.
> 
> In the Makefile, TEST_GEN_PROGS will compile and install the tests and
> will add them to the list of tests that run_kselftest.sh will run.
> TEST_GEN_FILES will compile and install the tests but will not add them
> to the test list. So let's move all the programs from TEST_GEN_PROGS to
> TEST_GEN_FILES so that they are built but not executed by
> run_kselftest.sh. Note that run_vmtests.sh is added to TEST_PROGS, which
> means it ends up in the test list. (the lack of "_GEN" means it won't be
> compiled, but simply copied).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

