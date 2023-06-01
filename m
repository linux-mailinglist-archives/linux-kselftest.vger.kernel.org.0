Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84F71F4EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjFAVla (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 17:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjFAVl0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 17:41:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D61AB;
        Thu,  1 Jun 2023 14:41:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30adc51b65cso1284117f8f.0;
        Thu, 01 Jun 2023 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685655679; x=1688247679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axm7gWfA5Bz2zISfLReqOuWM4uugQUqN8yYC/Fksz6E=;
        b=YZSlWv4ZRTQrtBhg3PQzZua0HI+2SFQ6DVd2Bx8xgGekGmRuK9f8yJ5kXzevfEebGJ
         bucJgtW1H96KQ9FvVilYQGKt3XZoTwjQEwF2O0W1xpw1L8r/MC8vgMaeBIF52HNhL50P
         /NSkVOvlvcL0qcW8QPRHK71tAbxiyBwhld75ewICg7hsBYfqExnDnK7hzYW7vWyaMVIK
         9fwPDib6jPpa7owSGwZfa/cyHecswJxl8TExBrc1+4kpqHQoOJkAeESleA6xKBT3YB2W
         msg6fEThLJQo/ha+hc6/maQT3ptl156aGXgRK3enrAhrHR2yzAcpY3ONhaXCn0H2vIxo
         e0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655679; x=1688247679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axm7gWfA5Bz2zISfLReqOuWM4uugQUqN8yYC/Fksz6E=;
        b=jhnfS260KmITXM/KTGxhPDiCHyKQgW9bJzCuec8UEIiv7Gl0vMYjLU+LV+vakqhthl
         3LHhRUNECVOifuwzDOJhtxuoXYStG1xgEQretJugWUZFyujrLt4MaCeWzbAr56FDtBxW
         wN575bbxD0iBXJfUVY2Pd255v2XHCWeFrWekNchoDqIYyeud9Qx2ViVkjVeOqTANZ3zS
         MPWdcY8IH4Ez4HRoCKJ1aaD3/dAev0doScogj1SJyc8f49KEsfhrnctRn/HVLY+Xihc/
         Y6WrzZlUTR3/2nbher86zvTvukVychZf7EX0JLvAnenj7p/3W5db/ql6fWXnw9fz1wn7
         c32A==
X-Gm-Message-State: AC+VfDzDNjALw/jaF9qMFScPgZYMA3Ci1yZP+j1cCXfT70Uou0bhoIAV
        9Ty5xFFcjYokj66Dp77z0VF2W8ML9v8=
X-Google-Smtp-Source: ACHHUZ7LYqeF93KRE7QDwkmLW/473nUeONnAulQMEPgBiMAGpBIIpvYu2qiK+F5rppMScPdQKgWYKg==
X-Received: by 2002:adf:ce81:0:b0:306:30ea:a060 with SMTP id r1-20020adfce81000000b0030630eaa060mr2860269wrn.51.1685655678619;
        Thu, 01 Jun 2023 14:41:18 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe589000000b00307c8d6b4a0sm11440534wrm.26.2023.06.01.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:41:17 -0700 (PDT)
Date:   Thu, 1 Jun 2023 22:41:16 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
Message-ID: <85dc50c7-459a-4cbb-abd3-16f35a8e10b0@lucifer.local>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-3-david@redhat.com>
 <be2346e4-e8c0-4470-9bf4-59eb864063a8@lucifer.local>
 <fa6009d4-643e-97ec-5317-a57a535e0495@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6009d4-643e-97ec-5317-a57a535e0495@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 01, 2023 at 10:16:41AM +0200, David Hildenbrand wrote:
> On 28.05.23 17:03, Lorenzo Stoakes wrote:
> > On Fri, May 19, 2023 at 12:27:22PM +0200, David Hildenbrand wrote:
> > > Let's add a new test for checking whether GUP long-term page pinning
> > > works as expected (R/O vs. R/W, MAP_PRIVATE vs. MAP_SHARED, GUP vs.
> > > GUP-fast). Note that COW handling with long-term R/O pinning in private
> > > mappings, and pinning of anonymous memory in general, is tested by the
> > > COW selftest. This test, therefore, focuses on page pinning in
> > > file mappings.
> > >
> > > The most interesting case is probably the "local tmpfile" case, as that
> > > will likely end up on a "real" filesystem such as ext4 or xfs, not on a
> > > virtual one like tmpfs or hugetlb where any long-term page pinning is
> > > always expected to succeed.
> > >
> > > For now, only add tests that use the "/sys/kernel/debug/gup_test"
> > > interface. We'll add tests based on liburing separately next.
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
>
> [...]
>
> > > +static void do_test(int fd, size_t size, enum test_type type, bool shared)
> > > +{
> > > +	__fsword_t fs_type = get_fs_type(fd);
> > > +	bool should_work;
> > > +	char *mem;
> > > +	int ret;
> > > +
> > > +	if (ftruncate(fd, size)) {
> > > +		ksft_test_result_fail("ftruncate() failed\n");
> > > +		return;
> > > +	}
> > > +
> > > +	if (fallocate(fd, 0, 0, size)) {
> > > +		if (size == pagesize)
> > > +			ksft_test_result_fail("fallocate() failed\n");
> > > +		else
> > > +			ksft_test_result_skip("need more free huge pages\n");
> > > +		return;
> > > +	}
> > > +
> > > +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
> > > +		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
> > > +	if (mem == MAP_FAILED) {
> > > +		if (size == pagesize || shared)
> > > +			ksft_test_result_fail("mmap() failed\n");
> > > +		else
> > > +			ksft_test_result_skip("need more free huge pages\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Fault in the page writable such that GUP-fast can eventually pin
> > > +	 * it immediately.
> > > +	 */
> > > +	memset(mem, 0, size);
> >
>
> For shared mappings, MAP_POPULATE will not fault-in the pages writable. See
> mm/gup.c:populate_vma_page_range().

Ughhh yeah, I was aware but hadn't considered the shared case, here. Fair
enough.

>
> [There is also the case that mmap() doesn't fail if populate fails, but
> that's only a side note regarding weird semantics of MAP_POPULATE]

Yes this is... a thing. And mm_populate() explicitly (void)-casting
__mm_populate() is the cherry on that particular cake :)

>
> [...]
>
> > > +	int flags = MFD_HUGETLB;
> > > +	int fd;
> > > +
> > > +	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
> > > +		       hugetlbsize / 1024);
> > > +
> > > +	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
> >
> > Hm this feels a little cute :)
>
> It's a weird interfacing, having to specify the desired size via flags ...
> see the man page of memfd_create, which links to the man page of mmap: "the
> desired huge page size can be configured by encoding the base-2 logarithm of
> the desired page size in the six bits at the offset MAP_HUGE_SHIFT".
>
> FWIW, we're using the same approach in cow.c already [and other memfd users
> like QEMU do it just like that, using ctz].

Ack, yeah I had assumed so, just felt slightly odd. Thanks for the
explanation!

>
> [...]
>
> > > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> > > index 4893eb60d96d..b6b1eb6a8a6b 100644
> > > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > > @@ -24,7 +24,7 @@ separated by spaces:
> > >   - mmap
> > >   	tests for mmap(2)
> > >   - gup_test
> > > -	tests for gup using gup_test interface
> > > +	tests for gup
> >
> > Super nitty again, but I'm guessing this means the CONFIG_GUP_TEST
> > interface, perhaps worth keeping?
>
> With this patch, agreed. But not longer with the next patch -- guess I
> simplified when splitting it up. If there are no strong feelings I'll leave
> it in this patch.
>
> [...]
>
> > >
> >
> > OK this patch is really nice + well implemented, I can only point out a
> > couple EXTREMELY nitty comments :) Thanks very much for adding a test for
> > this, it's super useful!
> >
> > Therefore,
> >
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
>
> Thanks for the review! My selftest patches rarely get that much attention,
> so highly appreciated :)

No worries, this is very much in my wheelhouse (relating directly to my
recent GUP series) so this is actually very useful and relevant to me. Also
I am very much in favour of improved test coverage, is a bug bear of mine.

>
> --
> Thanks,
>
> David / dhildenb
>
