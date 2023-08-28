Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799A078B973
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjH1USC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjH1URw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 16:17:52 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F6E4A
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:17:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34cc0ad6f61so12958805ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693253837; x=1693858637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlISlEu0cpqO/RX5l1LnfQgs++xGajM2SUCs3sXlUpk=;
        b=c60Co+cegI9Y5Q06F0dfQqmtsy8XO3MinrtOd5T4Wr8llpp3kf8lsIiTUQ2ny+Tsff
         vb2fqKfRRLLySM6YB4OJkwvrJfZ2OFxBxI8+gFZicRH+x7Jrt7s2nUzpZC/c+FZMiD1M
         UoZjfR8H7TFg6onETibCksfLS7nkY/LRgfxUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253837; x=1693858637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlISlEu0cpqO/RX5l1LnfQgs++xGajM2SUCs3sXlUpk=;
        b=fuMcckzGr9pCTvbwIYINA3oxdcafiUpJ2RPesgsX3VznB7XeyUOxa9mSu762aLt7DJ
         mP++KO/JI0zbnqQJ7agT70yU76uVubrFGXChlIVVFaVSC12cSEtePlOkd1XFXLvd47gl
         9PTpXoqawXok4z12vok37qOYECRcUmqqwyDsnyIBTx9Kzt/RTKrvzxXCE0Mjq60U0Bci
         qVS8sLeilfS+3F/bZbKOv+UqlA+Stff76EzHrijR1+MNPc7YN50eQ4CvYWMz3uuHHocU
         mvlAYxrjykEKoP7Fj46PPD6nc8DjRZ5YMWPt65SSpNRxS3Bu2dw+CBBT07YieiUgc8IK
         3G0A==
X-Gm-Message-State: AOJu0Yza8fLqMJncGagD9WIeUyZn0xvJlT9F+Xf6TTD/PlTYSLZnVEuV
        Sfx4dV7oFh32QKGnfzvpCdT4UQ==
X-Google-Smtp-Source: AGHT+IEUkxyBcdQwHwcAHtd1mz/VK3GZ/7Kg1/s7WFmrBaImGhpJQ7c/cZC6UaAAd1SZ+hyLWMl9hA==
X-Received: by 2002:a05:6e02:152f:b0:34c:b981:52d4 with SMTP id i15-20020a056e02152f00b0034cb98152d4mr20217007ilu.31.1693253837442;
        Mon, 28 Aug 2023 13:17:17 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id i6-20020a92c946000000b0034cac5ced38sm2663157ilq.13.2023.08.28.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:17:16 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:17:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 7/7] selftests: mm: Add a test for moving from an
 offset from start of mapping
Message-ID: <20230828201716.GF1621761@google.com>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-8-joel@joelfernandes.org>
 <18a2c79d-3feb-41aa-93a9-bafbfb188cbc@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a2c79d-3feb-41aa-93a9-bafbfb188cbc@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 11:12:14AM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 22, 2023 at 01:55:00AM +0000, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> >
> > It is possible that the aligned address falls on no existing mapping,
> > however that does not mean that we can just align it down to that.
> > This test verifies that the "vma->vm_start != addr_to_align" check in
> > can_align_down() prevents disastrous results if aligning down when
> > source and dest are mutually aligned within a PMD but the source/dest
> > addresses requested are not at the beginning of the respective mapping
> > containing these addresses.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  tools/testing/selftests/mm/mremap_test.c | 189 ++++++++++++++++-------
> >  1 file changed, 134 insertions(+), 55 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> > index f45d1abedc9c..c71ac8306c89 100644
> > --- a/tools/testing/selftests/mm/mremap_test.c
> > +++ b/tools/testing/selftests/mm/mremap_test.c
> > @@ -24,6 +24,7 @@
> >
> >  #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> >  #define SIZE_MB(m) ((size_t)m * (1024 * 1024))
> > +#define SIZE_KB(k) ((size_t)k * 1024)
> 
> Same comment as previous re: wrapping k in parens, it doesn't really matter
> here that much but for good practice (and consistency with MIN()) would be
> nice to do.

Ack.

> >
> >  struct config {
> >  	unsigned long long src_alignment;
> > @@ -148,6 +149,60 @@ static bool is_range_mapped(FILE *maps_fp, void *start, void *end)
> >  	return success;
> >  }
> >
> > +/*
> > + * Returns the start address of the mapping on success, else returns
> > + * NULL on failure.
> > + */
> > +static void *get_source_mapping(struct config c)
> > +{
> > +	unsigned long long addr = 0ULL;
> > +	void *src_addr = NULL;
> > +	unsigned long long mmap_min_addr;
> > +
> > +	mmap_min_addr = get_mmap_min_addr();
> > +	/*
> > +	 * For some tests, we need to not have any mappings below the
> > +	 * source mapping. Add some headroom to mmap_min_addr for this.
> > +	 */
> > +	mmap_min_addr += 10 * _4MB;
> > +
> > +retry:
> > +	addr += c.src_alignment;
> > +	if (addr < mmap_min_addr)
> > +		goto retry;
> > +
> > +	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
> > +					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
> > +					-1, 0);
> > +	if (src_addr == MAP_FAILED) {
> > +		if (errno == EPERM || errno == EEXIST)
> > +			goto retry;
> > +		goto error;
> > +	}
> > +	/*
> > +	 * Check that the address is aligned to the specified alignment.
> > +	 * Addresses which have alignments that are multiples of that
> > +	 * specified are not considered valid. For instance, 1GB address is
> > +	 * 2MB-aligned, however it will not be considered valid for a
> > +	 * requested alignment of 2MB. This is done to reduce coincidental
> > +	 * alignment in the tests.
> > +	 */
> > +	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
> > +			!((unsigned long long) src_addr & c.src_alignment)) {
> > +		munmap(src_addr, c.region_size);
> > +		goto retry;
> > +	}
> > +
> > +	if (!src_addr)
> > +		goto error;
> > +
> > +	return src_addr;
> > +error:
> > +	ksft_print_msg("Failed to map source region: %s\n",
> > +			strerror(errno));
> > +	return NULL;
> > +}
> > +
> 
> A meta thing, but it'd be nice to separate out _moving_ functions into
> their own patch to make reviewing easier as here it's not obvious whether

Sure, good point and I'll give that a shot.

[..]
> > +/*
> > + * Verify that an mremap aligning down does not destroy
> > + * the beginning of the mapping just because the aligned
> > + * down address landed on a mapping that maybe does not exist.
> > + */
> > +static void mremap_move_1mb_from_start(char pattern_seed)
> > +{
> > +	char *test_name = "mremap move 1mb from start at 2MB+256KB aligned src";
> > +	void *src = NULL, *dest = NULL;
> > +	int i, success = 1;
> > +
> > +	/* Config to reuse get_source_mapping() to do an aligned mmap. */
> > +	struct config c = {
> > +		.src_alignment = SIZE_MB(1) + SIZE_KB(256),
> > +		.region_size = SIZE_MB(6)
> > +	};
> > +
> > +	src = get_source_mapping(c);
> > +	if (!src) {
> > +		success = 0;
> > +		goto out;
> > +	}
> > +
> > +	c.src_alignment = SIZE_MB(1) + SIZE_KB(256);
> 
> Why are you setting this again?

Yes, I may not need to but since 'c' is passed to a function, I just do it
for robustness. If you'd like, I can drop it.

> > +	dest = get_source_mapping(c);
> > +	if (!dest) {
> > +		success = 0;
> > +		goto out;
> > +	}
> > +
> > +	/* Set byte pattern for source block. */
> > +	srand(pattern_seed);
> > +	for (i = 0; i < SIZE_MB(2); i++) {
> > +		((char *)src)[i] = (char) rand();
> > +	}
> > +
> > +	/*
> > +	 * Unmap the beginning of dest so that the aligned address
> > +	 * falls on no mapping.
> > +	 */
> > +	munmap(dest, SIZE_MB(1));
> 
> This actually aligns (no pun intended) with my comments on the min mmap
> address + 4 MiB comments previously. But I guess for the generalised mremap
> test you will still need to have that headroom...

Yes, I guess the situation you are validly concerned about is if someone
mapped something just when I unmapped. However, as this is test code it
probably should be OK?

> > +
> > +	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
> > +						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
> > +	if (new_ptr == MAP_FAILED) {
> > +		perror("mremap");
> > +		success = 0;
> > +		goto out;
> > +	}
> > +
> > +	/* Verify byte pattern after remapping */
> > +	srand(pattern_seed);
> > +	for (i = 0; i < SIZE_MB(1); i++) {
> > +		char c = (char) rand();
> > +
> > +		if (((char *)src)[i] != c) {
> > +			ksft_print_msg("Data at src at %d got corrupted due to unrelated mremap\n",
> > +				       i);
> > +			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
> > +					((char *) src)[i] & 0xff);
> > +			success = 0;
> > +		}
> > +	}
> > +
> > +out:
> > +	if (src && munmap(src, c.region_size) == -1)
> > +		perror("munmap src");
> > +
> > +	if (dest && munmap(dest, c.region_size) == -1)
> > +		perror("munmap dest");
> > +
> > +	if (success)
> > +		ksft_test_result_pass("%s\n", test_name);
> > +	else
> > +		ksft_test_result_fail("%s\n", test_name);
> > +}
> > +
> >  static void run_mremap_test_case(struct test test_case, int *failures,
> >  				 unsigned int threshold_mb,
> >  				 unsigned int pattern_seed)
> > @@ -565,7 +643,7 @@ int main(int argc, char **argv)
> >  	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
> >  	unsigned int pattern_seed;
> >  	int num_expand_tests = 2;
> > -	int num_misc_tests = 1;
> > +	int num_misc_tests = 2;
> >  	struct test test_cases[MAX_TEST] = {};
> >  	struct test perf_test_cases[MAX_PERF_TEST];
> >  	int page_size;
> > @@ -666,6 +744,7 @@ int main(int argc, char **argv)
> >  	fclose(maps_fp);
> >
> >  	mremap_move_within_range(pattern_seed);
> > +	mremap_move_1mb_from_start(pattern_seed);
> >
> >  	if (run_perf_tests) {
> >  		ksft_print_msg("\n%s\n",
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
> 
> Have you verified this test fails if you eliminate the vma->vm_start !=
> addr_to_align check?

Yes. When Linus found the issue, I wrote this very test to ensure that
we caught it and that the fix made the test pass.

> Unrelated to this patch, but I guess it might be tricky to come up with a
> test for the shift_arg_pages() stack case?

Yes I think so, at the moment I am resorting to manually hacking the kernel to
test that which is not ideal but..

> Irrespective of the above, this looks correct to me so,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Thanks for putting in so much effort on the testing side too! :)

My pleasure, and thanks for the awesome review! I'll get to work on it and
post a new version soon.

thanks,

 - Joel


