Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54EE5E85EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Sep 2022 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiIWWfw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWWfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 18:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58812646F
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663972549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J+2c5YW+EA7plWyqyC2+l7gyp9odW6tPIthlfYxVMK0=;
        b=g4KQQ1m8oiEuT61KMxYw2hCfd4ZwVHmPR+SC0IHI+DEtumrq/eV0mhjfCkzsbgAWO2Kwm4
        JR/usFt05F6opkOmw76ihTrKqJJfeAa9R6aOZpEeJiP8hR2aFx3UJxiTDTskTZ7JMSZzYY
        TFVOOJwpE6KUg5YLzmzPDsWxTOrWzv4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-rHnxTKRCMrekggEnTjihGg-1; Fri, 23 Sep 2022 18:35:47 -0400
X-MC-Unique: rHnxTKRCMrekggEnTjihGg-1
Received: by mail-ed1-f69.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so888255eda.19
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 15:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J+2c5YW+EA7plWyqyC2+l7gyp9odW6tPIthlfYxVMK0=;
        b=mbhfZ3h59FIeYy5/hDgS9ub3eEn9FlLuE9EkmCX73J4FofZKQ2BVxDY+XZFDbWZVQm
         9KBga4yG6giia+L3TN+aeleus+FxqIqKBgcXow3CxmfSnJBZDlaAk5hkCtX6bou81OzN
         YDtupYz+x6QMPCDOXvYZwJFHqHGpoEb6ChvyalTQ4meZbr+o0FOLf8IMMNdEvx1NQgs5
         hSL9Odio5lDEFHmbLWEuDKOG5tBs0esiL1mt8W1uruU0vmuHP89gh+Oaj7cOQjvkYI78
         h/WVLKqsjIDABzRWfcKOYg0Lw5OTv8Odoz8CKSZcfqam3DPp3fdv8U5l5oCxHwWbvU/g
         /k4w==
X-Gm-Message-State: ACrzQf3e119reZX6kJQetCwCMPcXgaxDS8SwrRR+CcRObJO8TRnGwVTJ
        UOQuS1wsYoXSc5GkDSBHgH0K7bUSvCb01T2RiZrDnBHbzEz+IsMfZdwl8eTh6+agkt+8uHy0uBY
        Lx5qYUCd0mZyddoEZY6H1w2HYQPCXqR4rwxVH5HUnJUzu
X-Received: by 2002:a05:6402:43cf:b0:450:eae1:c9d3 with SMTP id p15-20020a05640243cf00b00450eae1c9d3mr10723239edc.231.1663972546216;
        Fri, 23 Sep 2022 15:35:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61hUVlIihf1mB+9peSUfCPpl2lY1axiVlb+Hc695DbpTg/y1XovHLdPOCHpv2yeQfoafdsaHoX9kl8fnmcvjE=
X-Received: by 2002:a05:6402:43cf:b0:450:eae1:c9d3 with SMTP id
 p15-20020a05640243cf00b00450eae1c9d3mr10723224edc.231.1663972545995; Fri, 23
 Sep 2022 15:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
 <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com> <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
In-Reply-To: <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
From:   Nico Pache <npache@redhat.com>
Date:   Fri, 23 Sep 2022 16:35:19 -0600
Message-ID: <CAA1CXcAMeoaSTc3Oa-ZppX9GqpDRH=cJ+aLnTgWU1-=OEcwTsw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new file
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 21, 2022 at 5:06 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 9/9/22 8:06 AM, Nico Pache wrote:
> >
> >
> > On 4/20/22 04:40, Muhammad Usama Anjum wrote:
> >> Bring common functions to a new file while keeping code as much same as
> >> possible. These functions can be used in the new tests. This helps in
> >> avoiding code duplication.
> >
> > This commit breaks a pattern in the way tests are run in the current scheme.
> > Before this commit the only executable (or TEST_PROGS) that was executed was
> > run_vmselftests.sh. Now both madv_populate and split_huge_page_test are being
> > run as well.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> Changes in V6:
> >> - Correct header files inclusion
> >>
> >> Changes in V5:
> >> Keep moved code as same as possible
> >> - Updated macros names
> >> - Removed macro used to show bit number of dirty bit, added a comment
> >>   instead
> >> - Corrected indentation
> >> ---
> >>  tools/testing/selftests/vm/Makefile           |   7 +-
> >>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
> >>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
> >>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
> >>  tools/testing/selftests/vm/vm_util.h          |   9 ++
> >>  5 files changed, 124 insertions(+), 113 deletions(-)
> >>  create mode 100644 tools/testing/selftests/vm/vm_util.c
> >>  create mode 100644 tools/testing/selftests/vm/vm_util.h
> >>
> >> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> >> index 5e43f072f5b76..4e68edb26d6b6 100644
> >> --- a/tools/testing/selftests/vm/Makefile
> >> +++ b/tools/testing/selftests/vm/Makefile
> >> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
> >>  TEST_GEN_FILES += hugepage-shm
> >>  TEST_GEN_FILES += hugepage-vmemmap
> >>  TEST_GEN_FILES += khugepaged
> >> -TEST_GEN_FILES += madv_populate
> >> +TEST_GEN_PROGS = madv_populate
> > madv_populate is already being run in run_vmselftests.sh
> >>  TEST_GEN_FILES += map_fixed_noreplace
> >>  TEST_GEN_FILES += map_hugetlb
> >>  TEST_GEN_FILES += map_populate
> >> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
> >>  TEST_GEN_FILES += thuge-gen
> >>  TEST_GEN_FILES += transhuge-stress
> >>  TEST_GEN_FILES += userfaultfd
> >> -TEST_GEN_FILES += split_huge_page_test
> >> +TEST_GEN_PROGS += split_huge_page_test
> >>  TEST_GEN_FILES += ksm_tests
> >>
> >>  ifeq ($(MACHINE),x86_64)
> >> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
> >>  KSFT_KHDR_INSTALL := 1
> >>  include ../lib.mk
> >>
> >> +$(OUTPUT)/madv_populate: vm_util.c
> >> +$(OUTPUT)/split_huge_page_test: vm_util.c
> > Not sure what this does but if we add a run entry for split_huge_page_test in
> > run_vmselftests.sh we wont really need this patch.
> >
> > I'm not sure the reduction in code size is worth the change in run behavior.
> >
> > Unless I'm missing something I suggest we revert this patch and add a run entry
> > for split_huge_page_test in run_vmselftests.sh. I can do this if no one objects.
> The run behavior isn't being changed here. Only the build behavior is
> being changed as we want to keep the common code in one file. You can
> add the run entry as required. I don't know why do you think the
> Makefile has changed the run behavior.

Before your commit running
    `make TARGETS=vm; make TARGETS=vm run_tests`
had the following run behavior:
    - The only thing executed via the run_tests wrapper is run_vmtests.sh
    - TAP output is 1/1:
        TAP version 13
        1..1
        # selftests: vm: run_vmtests.sh
        # arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64
sparc64 x86_64
        # -----------------------
        # running ./hugepage-mmap
        # -----------------------
        ....

After your commit:
    - Multiple executables (madv_populate, soft-dirty,
split_huge_page_test, run_vmtests.sh) are defined and ran:
         # selftests: vm: madv_populate
         not ok 1 selftests: vm: madv_populate # exit=1
         # selftests: vm: soft-dirty
         ok 2 selftests: vm: soft-dirty
         # selftests: vm: split_huge_page_test
         ok 3 selftests: vm: split_huge_page_test
         # selftests: vm: run_vmtests.sh
         ok 4 selftests: vm: run_vmtests.sh # SKIP

I'm not saying utilizing the TEST_GEN_PROG variable is incorrect, I'm
just pointing out that we have a sudden change in run behavior via the
run_test wrapper. I personally think the TEST_GEN_PROG output is
cleaner, but having two different ways of outputting results may be
harder/confusing to parser. Additionally there is still the issue that
madv_populate is being run twice for no reason.

Cheers,
-- Nico

>
> >
> > Cheers,
> > -- Nico
> >
>
> --
> Muhammad Usama Anjum
>

