Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF607E041E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjKCOAG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjKCOAF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 10:00:05 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60871D45;
        Fri,  3 Nov 2023 07:00:02 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99357737980so312324666b.2;
        Fri, 03 Nov 2023 07:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699020001; x=1699624801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFh8Q4fxchaWQjUJ2QaKp0znqL3CQjIt+LE/Yj+j71I=;
        b=IxRETYRQwDZ7AVE9tND6tIUuccyhN4c3Pr33ArjEEV4aF95wLdNl6/1PmYtWANJFAY
         dqzkowZTxHqMJephErn7Mw0LMhwdVJo7qzWFHwc6nKk/II7sIFIcDNsoOpluuamBS0Rm
         GoTYH3f1txP4Nfy2FwdFlPgbh5DeU50ar6Fa0/ivrpnmKDxGY8oX9FLYTlAa7lT4lq5c
         o+rg2fIhMsgLo+dTEvawC2vFbm0vG8XEnXI1WIELL1B1N7R8hKJLDCCQpPMgvbT1M/9K
         LG1zJ7ejixCad8rmGlRPj1A4u4DZ+4ZRkqyat3yig/gIIYFo8IS7/6vEBLZs6eINhm7R
         S8aQ==
X-Gm-Message-State: AOJu0YyWOPoRBjwtT0LLDUKUpVsb9gjemuC7TopajPo2QiOTvf1m4adC
        WKbYfjw3WVvBl/JZitcnPUg=
X-Google-Smtp-Source: AGHT+IFGzlc/IgTDRXqGlgmdeETcppuMNbPEekWOYCHmrv9sNtwVq7JDon3QkWRLVaGnsGyjUHRHhg==
X-Received: by 2002:a17:907:745:b0:9dd:4811:7111 with SMTP id xc5-20020a170907074500b009dd48117111mr1171953ejb.4.1699020000550;
        Fri, 03 Nov 2023 07:00:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00977eec7b7e8sm943124ejb.68.2023.11.03.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:00:00 -0700 (PDT)
Date:   Fri, 3 Nov 2023 06:59:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, riel@surriel.com,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selftests/mm: Add a new test for madv and hugetlb
Message-ID: <ZUT83E+XvSr518Zm@gmail.com>
References: <20231005163922.87568-1-leitao@debian.org>
 <20231005163922.87568-3-leitao@debian.org>
 <662df57e-47f1-4c15-9b84-f2f2d587fc5c@arm.com>
 <84df3b17-6f3d-4e9b-94e0-88ba186207e2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84df3b17-6f3d-4e9b-94e0-88ba186207e2@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Ryan,

On Thu, Nov 02, 2023 at 12:29:54PM +0000, Ryan Roberts wrote:
> On 02/11/2023 12:24, Ryan Roberts wrote:
> > On 05/10/2023 17:39, Breno Leitao wrote:
> >> Create a selftest that exercises the race between page faults and
> >> madvise(MADV_DONTNEED) in the same huge page. Do it by running two
> >> threads that touches the huge page and madvise(MADV_DONTNEED) at the same
> >> time.
> >>
> >> In case of a SIGBUS coming at pagefault, the test should fail, since we
> >> hit the bug.
> >>
> >> The test doesn't have a signal handler, and if it fails, it fails like
> >> the following
> >>
> >>   ----------------------------------
> >>   running ./hugetlb_fault_after_madv
> >>   ----------------------------------
> >>   ./run_vmtests.sh: line 186: 595563 Bus error    (core dumped) "$@"
> >>   [FAIL]
> >>
> >> This selftest goes together with the fix of the bug[1] itself.
> >>
> >> [1] https://lore.kernel.org/all/20231001005659.2185316-1-riel@surriel.com/#r
> >>
> >> Signed-off-by: Breno Leitao <leitao@debian.org>
> >> ---
> >>  tools/testing/selftests/mm/Makefile           |  1 +
> >>  .../selftests/mm/hugetlb_fault_after_madv.c   | 73 +++++++++++++++++++
> >>  tools/testing/selftests/mm/run_vmtests.sh     |  4 +
> >>  3 files changed, 78 insertions(+)
> >>  create mode 100644 tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> >>
> >> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> >> index 6a9fc5693145..e71ec9910c62 100644
> >> --- a/tools/testing/selftests/mm/Makefile
> >> +++ b/tools/testing/selftests/mm/Makefile
> >> @@ -68,6 +68,7 @@ TEST_GEN_FILES += split_huge_page_test
> >>  TEST_GEN_FILES += ksm_tests
> >>  TEST_GEN_FILES += ksm_functional_tests
> >>  TEST_GEN_FILES += mdwe_test
> >> +TEST_GEN_FILES += hugetlb_fault_after_madv
> >>  
> >>  ifneq ($(ARCH),arm64)
> >>  TEST_GEN_PROGS += soft-dirty
> >> diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> >> new file mode 100644
> >> index 000000000000..73b81c632366
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> >> @@ -0,0 +1,73 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#include <pthread.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <sys/mman.h>
> >> +#include <sys/types.h>
> >> +#include <unistd.h>
> >> +
> >> +#include "vm_util.h"
> >> +#include "../kselftest.h"
> >> +
> >> +#define MMAP_SIZE (1 << 21)
> >> +#define INLOOP_ITER 100
> >> +
> >> +char *huge_ptr;
> >> +
> >> +/* Touch the memory while it is being madvised() */
> >> +void *touch(void *unused)
> >> +{
> >> +	char *ptr = (char *)huge_ptr;
> >> +
> >> +	for (int i = 0; i < INLOOP_ITER; i++)
> >> +		ptr[0] = '.';
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +void *madv(void *unused)
> >> +{
> >> +	usleep(rand() % 10);
> >> +
> >> +	for (int i = 0; i < INLOOP_ITER; i++)
> >> +		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >> +int main(void)
> >> +{
> >> +	unsigned long free_hugepages;
> >> +	pthread_t thread1, thread2;
> >> +	/*
> >> +	 * On kernel 6.4, we are able to reproduce the problem with ~1000
> >> +	 * interactions
> >> +	 */
> >> +	int max = 10000;
> >> +
> >> +	srand(getpid());
> >> +
> >> +	free_hugepages = get_free_hugepages();
> >> +	if (free_hugepages != 1) {
> >> +		ksft_exit_skip("This test needs one and only one page to execute. Got %lu\n",
> >> +			       free_hugepages);
> >> +	}
> >> +
> >> +	while (max--) {
> >> +		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
> >> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> >> +				-1, 0);
> >> +
> >> +		if ((unsigned long)huge_ptr == -1)
> >> +			ksft_exit_skip("Failed to allocated huge page\n");
> >> +
> >> +		pthread_create(&thread1, NULL, madv, NULL);
> >> +		pthread_create(&thread2, NULL, touch, NULL);
> >> +
> >> +		pthread_join(thread1, NULL);
> >> +		pthread_join(thread2, NULL);
> >> +		munmap(huge_ptr, MMAP_SIZE);
> >> +	}
> >> +
> >> +	return KSFT_PASS;
> >> +}
> >> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> >> index 3e2bc818d566..9f53f7318a38 100755
> >> --- a/tools/testing/selftests/mm/run_vmtests.sh
> >> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> >> @@ -221,6 +221,10 @@ CATEGORY="hugetlb" run_test ./hugepage-mremap
> >>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
> >>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
> >>  
> >> +# For this test, we need one and just one huge page
> >> +echo 1 > /proc/sys/vm/nr_hugepages
> > 
> > I've noticed that this change breaks some of the uffd-stress tests further down
> > the file, because you have freed previously reserved hugepages that the test
> > requires to run. I notice that the patch is already in mm-stable, so perhaps its
> > possible to submit a patch that does a save and restore?
> > 
> > Although I'm not sure if that might be tricky because the previous reservation
> > is per-size and per-node (our CI does this on the kernel command line), and I
> > suspect if you want just 1 huge page in the entire system you won't be able to
> > get back to the previous state by just restoring this value?
> 
> Actually on closer inspection, I don't think this will be a problem; simply
> saving and restoring the value around the test will be sufficient.

Thanks for checking it, I will prepare a patch that will restore the number
of huge pages allocated after the test.

> I also notice that the binary for the new test is not added to the .gitignore,
> which is a minor annoyance.

I will add the file to .gitignore also.

Thanks for the heads-up.
