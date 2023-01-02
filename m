Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8265B471
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jan 2023 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjABPuG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Jan 2023 10:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABPuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Jan 2023 10:50:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C09A1AB;
        Mon,  2 Jan 2023 07:50:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z10so26621338wrh.10;
        Mon, 02 Jan 2023 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWZfcM+qssrebEF6M4iZr99iAEIr6Weo0zlGmUVXXu8=;
        b=aKhKI2lSmAEp3QUkT7GORlxGJ1l8a706SORdJiDWUfxvPW/EG03CpzXGzb7q2sG4dM
         FfyOloQqevyPCVDKJHuXOlriqAE5nHMAvQStH82vvmP8jRjRCe8fmHcZ70QYBoARLUIK
         tTgvgimuzgPD7c4R0/cNTrrfFl73FOm/ADUhy3KhIddRXnrTz0jojIpSBCGfeLbshEQy
         ew9ABndIL1Cl88HRvIF7Rqh28v4Hua7CiNbUuahMdaWWL3B2uX4CgT8UAVALYTFYB49I
         80QxDa9pk5zDBpusdCuN2Spj7+8ZZrXj9RT7Mce38GXqsU1n0v5b5uWU8DUcAkV62/tc
         RDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWZfcM+qssrebEF6M4iZr99iAEIr6Weo0zlGmUVXXu8=;
        b=A6oipWoJvqSeJ5mXvt1qO4s9+NAb5nQjzmSjGj/rFTF5vLeK89aznW3xUrPlzg8kuV
         l7iU0kRe8XLjZg0jCs47iEBlnW7igmQjAMUPaT1glEdpz7netDvqgHXCvWUqJTqa6Fni
         nixey5KOUv5BF1PNsPNbZN/SMRGnpBr5Gubicvw4fHkRlasQCqPfmAMk383HGbQ4DbaP
         Xz6qAo5tsnYIIOURH8gp1rX2qOvQPn19Ez9KsTZ69F1iVhtRFoAe37vbgSfpiDAfyXvG
         izbRZbijFwd7qGGnNCDXKdxAeaCjXN/fiWxf7suuTxdvd9H4Fr5gPejX8Zba/9RH5CfQ
         o74w==
X-Gm-Message-State: AFqh2krs3DhGeXF6JSxw8lVeLUZBiHcByLv0JP20Vt5E1R9GLN//r6BR
        wihc4eRHd4+oTFItCODCu5M=
X-Google-Smtp-Source: AMrXdXvf+K2pZoe2fyipfAZGQZ2HEV+p006VOc8BDT93uxeYhjvQ16k0Ja1hBZakggIxAVAM+wHrgQ==
X-Received: by 2002:adf:f0ca:0:b0:275:e426:4134 with SMTP id x10-20020adff0ca000000b00275e4264134mr21681792wro.51.1672674598885;
        Mon, 02 Jan 2023 07:49:58 -0800 (PST)
Received: from localhost ([2a01:4c8:469:341:d1e1:a149:58ed:f096])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b00241d544c9b1sm14497378wrj.90.2023.01.02.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 07:49:58 -0800 (PST)
Date:   Mon, 2 Jan 2023 15:49:57 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] selftest/vm: add mremap expand merge offset test
Message-ID: <Y7L9JfyQrwIRVo2A@lucifer>
References: <f132891530423f8bb72fde8169279b1c5967ec40.1672670177.git.lstoakes@gmail.com>
 <3a4fbe90-b46e-aa49-9866-e2b0cf6de38d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a4fbe90-b46e-aa49-9866-e2b0cf6de38d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 02, 2023 at 04:34:14PM +0100, David Hildenbrand wrote:
> On 02.01.23 15:44, Lorenzo Stoakes wrote:
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
> >   tools/testing/selftests/vm/mremap_test.c | 115 ++++++++++++++++++-----
> >   1 file changed, 93 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
>
>
> ...
>
> > +
> > +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> > +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +
> > +	if (start == MAP_FAILED) {
> > +		ksft_print_msg("mmap failed: %s\n", strerror(errno));
>
> I'd
>
> 	ksft_test_result_fail(...)
> 	return;
>
> > +		goto out;
> > +	}
> > +
> > +	munmap(start + page_size, page_size);
> > +	remap = mremap(start, page_size, 2 * page_size, 0);
> > +	if (remap == MAP_FAILED) {
> > +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
> > +		munmap(start, page_size);
> > +		munmap(start + 2 * page_size, page_size);
> > +		goto out;
>
> dito
>
> 	ksft_test_result_fail(...)
> 	...
> 	return;
>
> > +	}
> > +
> > +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
> > +	munmap(start, 3 * page_size);
> > +
> > +out:
>
> then you can drop the out label.
>

I have to disagree on this, to be consistent with the other tests the
failure messages should include the test name, and putting the
ksft_test_result_fail("test name") in each branch as well as the error
message would just be wilful duplication.

I do think it's a pity C lacks mechanisms such that gotos are sometimes
necessary, but I can only right so many wrongs in this patch :)

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
> > +static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
> > +{
> > +
> > +	char *test_name = "mremap expand merge offset";
> > +	bool success = false;
> > +	char *remap, *start;
> > +
> > +	start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE,
> > +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +
> > +	if (start == MAP_FAILED) {
> > +		ksft_print_msg("mmap failed: %s\n", strerror(errno));
> > +		goto out;
> > +	}
> > +
> > +	/* Unmap final page to ensure we have space to expand. */
> > +	munmap(start + 2 * page_size, page_size);
> > +	remap = mremap(start + page_size, page_size, 2 * page_size, 0);
> > +	if (remap == MAP_FAILED) {
> > +		ksft_print_msg("mremap failed: %s\n", strerror(errno));
> > +		munmap(start, 2 * page_size);
> > +		goto out;
> > +	}
> > +
> > +	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
> > +	munmap(start, 3 * page_size);
> > +
> > +out:
>
> dito.
>
> >   	if (success)
> >   		ksft_test_result_pass("%s\n", test_name);
> >   	else
> >   		ksft_test_result_fail("%s\n", test_name);
> > -	fclose(fp);
> >   }
> >   /*
> > @@ -385,6 +447,7 @@ int main(int argc, char **argv)
> >   	struct test perf_test_cases[MAX_PERF_TEST];
> >   	int page_size;
> >   	time_t t;
> > +	FILE *maps_fp;
>
> I'd simply use a global variable, same applies for page_size. But passing it
> around is also ok.
>

I am trying to keep things consistent with what's gone before in this code,
and given page_size is being passed around I think the 'when in Rome'
principle applies equally to passing the fp around I think.

> >   	pattern_seed = (unsigned int) time(&t);
> > @@ -458,7 +521,15 @@ int main(int argc, char **argv)
> >   		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
> >   				     pattern_seed);
> > -	mremap_expand_merge(page_size);
> > +	maps_fp = fopen("/proc/self/maps", "r");
> > +	if (maps_fp == NULL) {
> > +		ksft_print_msg("Failed to read /proc/self/maps: %s\n", strerror(errno));
>
> Maybe simply fail the test completely and return -errno ?
>

Ack on this one, will spin a v3 with this as otherwise we might miss test
failures here.

> > +	} else {
> > +		mremap_expand_merge(maps_fp, page_size);
> > +		mremap_expand_merge_offset(maps_fp, page_size);
> > +
> > +		fclose(maps_fp);
>
> No need to fclose, just keep it open ...
>

I'd rather we did fclose() to keep things clean, as who knows what
additional tests may be added later and to be pedantic about matching an
fopen() with an fclose().

> > +	}
> >   	if (run_perf_tests) {
> >   		ksft_print_msg("\n%s\n",
>
>
> Acked-by: David Hildenbrand <david@redhat.com>
>

Thanks!

> --
> Thanks,
>
> David / dhildenb
>
