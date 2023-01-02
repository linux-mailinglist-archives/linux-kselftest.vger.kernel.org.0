Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1765B2FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjABN6X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjABN6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 08:58:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1785654C;
        Mon,  2 Jan 2023 05:58:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j17so20981793wrr.7;
        Mon, 02 Jan 2023 05:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nphmtWm1iGTaK7XYzssdMMXgZVHnsgqaAFS3kznMFEA=;
        b=qm0uQwkivEm3WjQSYHXx+e/k9LfmnHS3X0LeE9N8GAMvTjcUemkm/eNEtZFY7EK8Pe
         gMMqRqHG99iQ+gbKTqQjLBAn4uuiJJHp779KhANWDk7eVJZ7VL5TCJhYKf0jWhbnYuQT
         X/DNMCmJK+RsjJJxlKnrLaCrBfmk504y8/ZJwkIA3NZKX6tk+FKo9ByX1HYzPmoBbVz2
         xq6fYsCymVN9wvkCWvHqsew7asFjsPFByFPjcEZpvZH2jaAgFJiPpFtVfHYJyRJjKG6e
         A0IRb7oWeu5DBXMYvyJzahrU8gw1ua9pYzp/0EiJJORUqcp1Ihq94AHw+e/IlfaEg5Zt
         b4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nphmtWm1iGTaK7XYzssdMMXgZVHnsgqaAFS3kznMFEA=;
        b=E52Ss9dK4cXqVTQen5NmMPFOyxl4KnHUTqvKHgqc6BAo0lwOHmJRnfLfaC6t6MnxVT
         yq3Iz4jEg5s8kfZIJenkHZ2wf1LV+vpKSCl8HM46B09tA6m9F2hEawm5P/4/3QhXAmQi
         XL0xQAsy1hOBMIK4PrtrNjYVaU9RGTxq+51/pauDs/squv64OGifhyDkODK/MM8QJwcJ
         TMrmL63rAc+R6zPp/6Da0tnGZ5iHbSbARH/IzWrKfua8Z8l+cim7EvTT9DoSmeJ/wdhl
         984SztXC5rkM5K8hX30+oVF7T4rGFy2GfaSt8uOcswQ9YXMPS7TCx+1lsSZEhcWFoltX
         7YtQ==
X-Gm-Message-State: AFqh2kr8t1T+3bJ4u5y5itRmYvbMd17H7YQf/NJvAJ0QXBqDy5Q3/dc+
        Nroozcg+ucr3H8Wq96i1k1A=
X-Google-Smtp-Source: AMrXdXtCrOpTOIXnqtvQiMQt1xQE46H9qxE/PMCzdC55OKumJTn9GnX7xKApfCKs1HkgLcxv/0StFg==
X-Received: by 2002:a5d:4b11:0:b0:242:29e9:184c with SMTP id v17-20020a5d4b11000000b0024229e9184cmr24103953wrq.29.1672667895995;
        Mon, 02 Jan 2023 05:58:15 -0800 (PST)
Received: from localhost ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b002709e616fa2sm28560707wru.64.2023.01.02.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 05:58:15 -0800 (PST)
Date:   Mon, 2 Jan 2023 13:58:14 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] selftest/vm: add mremap expand merge offset test
Message-ID: <Y7Li9kZmQ3qPRjj2@lucifer>
References: <20221216214436.405071-1-lstoakes@gmail.com>
 <d394c380-8f2c-7b8d-3915-7b8b201bb7de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d394c380-8f2c-7b8d-3915-7b8b201bb7de@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 02, 2023 at 02:32:55PM +0100, David Hildenbrand wrote:
> On 16.12.22 22:44, Lorenzo Stoakes wrote:
> > Add a test to assert that we can mremap() and expand a mapping starting
> > from an offset within an existing mapping. We unmap the last page in a 3
> > page mapping to ensure that the remap should always succeed, before
> > remapping from the 2nd page.
> >
> > This is additionally a regression test for the issue solved in "mm, mremap:
> > fix mremap() expanding vma with addr inside vma" and confirmed to fail
> > prior to the change and pass after it.
> >
> > Finally, this patch updates the existing mremap expand merge test to check
> > error conditions and reduce code duplication between the two tests.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >   tools/testing/selftests/vm/mremap_test.c | 111 +++++++++++++++++++----
> >   1 file changed, 93 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> > index 9496346973d4..28a17d4e8afd 100644
> > --- a/tools/testing/selftests/vm/mremap_test.c
> > +++ b/tools/testing/selftests/vm/mremap_test.c
> > @@ -119,30 +119,19 @@ static unsigned long long get_mmap_min_addr(void)
> >   }
> >
> >   /*
> > - * This test validates that merge is called when expanding a mapping.
> > - * Mapping containing three pages is created, middle page is unmapped
> > - * and then the mapping containing the first page is expanded so that
> > - * it fills the created hole. The two parts should merge creating
> > - * single mapping with three pages.
> > + * Using /proc/self/maps, assert that the specified address range is contained
> > + * within a single mapping.
> >    */
> > -static void mremap_expand_merge(unsigned long page_size)
> > +static bool is_range_mapped(void *start, void *end)
> >   {
> > -	char *test_name = "mremap expand merge";
> >   	FILE *fp;
> >   	char *line = NULL;
> >   	size_t len = 0;
> >   	bool success = false;
> > -	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> > -			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > -
> > -	munmap(start + page_size, page_size);
> > -	mremap(start, page_size, 2 * page_size, 0);
> >
> >   	fp = fopen("/proc/self/maps", "r");
> > -	if (fp == NULL) {
> > -		ksft_test_result_fail("%s\n", test_name);
> > -		return;
> > -	}
> > +	if (fp == NULL)
> > +		return false;
>
> This is unexpected. It would be valuable to ksft_print_msg("[INFO] .."
> something, indicating that we don't know because we cannot access that info.
>
> ksft_print_msg("[INFO] Opening /proc/self/maps failed"
>
>
> But I'd even suggest opening "/proc/self/maps" once in main() and failing
> directly there. Then we don't have to worry about it here.
>
> >
> >   	while (getline(&line, &len, fp) != -1) {
> >   		char *first = strtok(line, "- ");
> > @@ -150,16 +139,101 @@ static void mremap_expand_merge(unsigned long page_size)
> >   		char *second = strtok(NULL, "- ");
> >   		void *second_val = (void *) strtol(second, NULL, 16);
> >
> > -		if (first_val == start && second_val == start + 3 * page_size) {
> > +		if (first_val <= start && second_val >= end) {
> >   			success = true;
> >   			break;
> >   		}
> >   	}
> > +
> > +	fclose(fp);
> > +	return success;
> > +}
> > +
> > +/*
> > + * This test validates that merge is called when expanding a mapping.
> > + * Mapping containing three pages is created, middle page is unmapped
> > + * and then the mapping containing the first page is expanded so that
> > + * it fills the created hole. The two parts should merge creating
> > + * single mapping with three pages.
> > + */
> > +static void mremap_expand_merge(unsigned long page_size)
> > +{
> > +	char *test_name = "mremap expand merge";
> > +	bool success = false;
> > +	int errsv = 0;
> > +	char *remap;
> > +	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> > +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
> I'd suggest
>
>
> 	char *remap, *start;
>
> 	start = mmap()
> 	if (start == MAP_FAILED) { ...
>
> to make this easier to read.
>
> > +
> > +	if (start == MAP_FAILED) {
> > +		errsv = errno;
> > +		goto error;
> > +	}
> > +
> > +	munmap(start + page_size, page_size);
> > +	remap = mremap(start, page_size, 2 * page_size, 0);
> > +	if (remap == MAP_FAILED) {
> > +		errsv = errno;
> > +		munmap(start, page_size);
> > +		munmap(start + 2 * page_size, page_size);
> > +		goto error;
> > +	}
> > +
> > +	success = is_range_mapped(start, start + 3 * page_size);
> > +
> > +	munmap(start, 3 * page_size);
> > +	goto out;
> > +
> > +error:
> > +	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
> > +		       strerror(errsv));
>
> Please avoid the "error" label and just print proper errors directly at the
> two callsites. Then, remove the "goto out".
>
> > +out:
> > +	if (success)
> > +		ksft_test_result_pass("%s\n", test_name);
> > +	else
> > +		ksft_test_result_fail("%s\n", test_name);
> > +}
> > +
> > +/*
> > + * Similar to mremap_expand_merge() except instead of removing the middle page,
> > + * we remove the last then attempt to remap offset from the second page. This
> > + * should result in the mapping being restored to its former state.
> > + */
> > +static void mremap_expand_merge_offset(unsigned long page_size)
> > +{
> > +
> > +	char *test_name = "mremap expand merge offset";
> > +	bool success = false;
> > +	int errsv = 0;
> > +	char *remap;
> > +	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> > +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
> Dito.
>
> > +
> > +	if (start == MAP_FAILED) {
> > +		errsv = errno;
> > +		goto error;
> > +	}
> > +
> > +	/* Unmap final page to ensure we have space to expand. */
> > +	munmap(start + 2 * page_size, page_size);
> > +	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
> > +	if (remap == MAP_FAILED) {
> > +		errsv = errno;
> > +		munmap(start, 2 * page_size);
> > +		goto error;
> > +	}
> > +
> > +	success = is_range_mapped(start, start + 3 * page_size);
> > +	goto out;
> > +
> > +error:
> > +	ksft_print_msg("Unexpected mapping/remapping error: %s\n",
> > +		       strerror(errsv));
>
> Dito.
>
> > +out:
>
>
> --
> Thanks,
>
> David / dhildenb
>

Ack on all, will spin a v2. Thanks for review!
