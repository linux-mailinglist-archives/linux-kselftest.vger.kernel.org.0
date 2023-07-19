Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BF75A020
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGSUqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSUqs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 16:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A119E
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689799560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b12/aDc/W25MU+G31DwKlpA3J3XW9Rd+FvX9Yt4/KPo=;
        b=CqYwjMOmEDR/wK6jZ9QNIRljoYNZgWbc72WZGa16hBXx4cL6YwC8lZrorjLh+HAzKlTPSh
        iJIkc3g0fAzvW6QCypYC9eGeqhtvYxUPGpBtit9KT1Cv5pwPgk68xYPwmIJgwOUS6D2dEz
        WtPPblhjTyb4I044DKNwvwiGxBmoVPc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-REp2_PLuPFe30MpKnb3IxA-1; Wed, 19 Jul 2023 16:45:58 -0400
X-MC-Unique: REp2_PLuPFe30MpKnb3IxA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403a1b0e259so317691cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 13:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799558; x=1690404358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b12/aDc/W25MU+G31DwKlpA3J3XW9Rd+FvX9Yt4/KPo=;
        b=HNuCujJhyd463lwV0XCCByb1iOmWLPSRbracclbL22rdv7vfzyzSLkgGRqCK5PAO0l
         L81EoSGhLhpghvwePDfngWes5HcGl/JmybJHXpxJxU5c8fPm1Sr2nEUvc3LjzNThVOqV
         h7iBdLbm4IMDbVStDr6hp5RyDbnad3BUCx6pQEGeIQBch5k2Lh49o1hXMDdwcr+AQnIl
         hs6DTf8CCQFmgN+5Ag+iMAk223WdD3bgCHzPnFTaQWnzj492QyozqJb5t1HPT8oAYTAz
         yKG+Af1CFJ+1IDmT/sS45P2xs1L2K0FFa0PW8tDRVO0hDYDDbA345co9uvRJErldfydd
         DI8g==
X-Gm-Message-State: ABy/qLY90+FQzMGvuy/qou0fRCrl0F6l5iWspeFgThn+vhNnFqt3YJNS
        didCUlPWdCk1hOmkfT9rdemLPp4tolqw4R81bYoBrVkJ7ZB4kK9WTKBE7HBTHu/lRDqf+VkU+ed
        DC8PZLUNuNfpdp+U6Uq3BloLVea2B
X-Received: by 2002:ac8:5a8d:0:b0:400:8036:6f05 with SMTP id c13-20020ac85a8d000000b0040080366f05mr1056335qtc.2.1689799558106;
        Wed, 19 Jul 2023 13:45:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSHzDb9t3k9dqegflbS3XBeYFDxCtTpS4UPlvDTuKAeHWVA2dhbsFeIaJTUjfOppuCRIL0qg==
X-Received: by 2002:ac8:5a8d:0:b0:400:8036:6f05 with SMTP id c13-20020ac85a8d000000b0040080366f05mr1056324qtc.2.1689799557835;
        Wed, 19 Jul 2023 13:45:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ci23-20020a05622a261700b004037cd9bd40sm1592793qtb.15.2023.07.19.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:45:57 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:45:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests/mm: Run all tests from run_vmtests.sh
Message-ID: <ZLhLeSLgYgqSMSEA@x1n>
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-9-ryan.roberts@arm.com>
 <5a12536a-2e33-7a68-6cfd-fd991ddf875a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a12536a-2e33-7a68-6cfd-fd991ddf875a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 17, 2023 at 07:27:13PM +0200, David Hildenbrand wrote:
> On 17.07.23 12:31, Ryan Roberts wrote:
> > It is very unclear to me how one is supposed to run all the mm selftests
> > consistently and get clear results.
> > 
> > Most of the test programs are launched by both run_vmtests.sh and
> > run_kselftest.sh:
> > 
> >    hugepage-mmap
> >    hugepage-shm
> >    map_hugetlb
> >    hugepage-mremap
> >    hugepage-vmemmap
> >    hugetlb-madvise
> >    map_fixed_noreplace
> >    gup_test
> >    gup_longterm
> >    uffd-unit-tests
> >    uffd-stress
> >    compaction_test
> >    on-fault-limit
> >    map_populate
> >    mlock-random-test
> >    mlock2-tests
> >    mrelease_test
> >    mremap_test
> >    thuge-gen
> >    virtual_address_range
> >    va_high_addr_switch
> >    mremap_dontunmap
> >    hmm-tests
> >    madv_populate
> >    memfd_secret
> >    ksm_tests
> >    ksm_functional_tests
> >    soft-dirty
> >    cow
> > 
> > However, of this set, when launched by run_vmtests.sh, some of the
> > programs are invoked multiple times with different arguments. When
> > invoked by run_kselftest.sh, they are invoked without arguments (and as
> > a consequence, some fail immediately).
> > 
> > Some test programs are only launched by run_vmtests.sh:
> > 
> >    test_vmalloc.sh
> > 
> > And some test programs and only launched by run_kselftest.sh:
> > 
> >    khugepaged
> >    migration
> >    mkdirty
> >    transhuge-stress
> >    split_huge_page_test
> >    mdwe_test
> >    write_to_hugetlbfs
> > 
> > Furthermore, run_vmtests.sh is invoked by run_kselftest.sh, so in this
> > case all the test programs invoked by both scripts are run twice!
> > 
> > Needless to say, this is a bit of a mess. In the absence of fully
> > understanding the history here, it looks to me like the best solution is
> > to launch ALL test programs from run_vmtests.sh, and ONLY invoke
> > run_vmtests.sh from run_kselftest.sh. This way, we get full control over
> > the parameters, each program is only invoked the intended number of
> > times, and regardless of which script is used, the same tests get run in
> > the same way.
> > 
> > The only drawback is that if using run_kselftest.sh, it's top-level tap
> > result reporting reports only a single test and it fails if any of the
> > contained tests fail. I don't see this as a big deal though since we
> > still see all the nested reporting from multiple layers. The other issue
> > with this is that all of run_vmtests.sh must execute within a single
> > kselftest timeout period, so let's increase that to something more
> > suitable.
> > 
> > In the Makefile, TEST_GEN_PROGS will compile and install the tests and
> > will add them to the list of tests that run_kselftest.sh will run.
> > TEST_GEN_FILES will compile and install the tests but will not add them
> > to the test list. So let's move all the programs from TEST_GEN_PROGS to
> > TEST_GEN_FILES so that they are built but not executed by
> > run_kselftest.sh. Note that run_vmtests.sh is added to TEST_PROGS, which
> > means it ends up in the test list. (the lack of "_GEN" means it won't be
> > compiled, but simply copied).
> > 
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for letting me know, David.  Sorry for the late response, still
catching up things.

I used to justify that from mm/ itself that everything should be PROG, but
I see that from higher level where TEST_GEN_FILE|PROG is really used this
makes sense.  As long as vm_utils.o will be properly linked I'll be happy
enough..

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

