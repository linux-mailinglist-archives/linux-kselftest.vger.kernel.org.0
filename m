Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A07789CE5
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjH0KNA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjH0KMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 06:12:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B60139;
        Sun, 27 Aug 2023 03:12:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so1924210f8f.0;
        Sun, 27 Aug 2023 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693131137; x=1693735937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGly6+ZahROEoc3sjOB5m3qZerStQgRkheVYTMYF2fg=;
        b=pPur96SOWmQ1D8mFh1zIRe6H6sgtHlFCwq2oR6H8RCpxbY+k6I3EMixq/iTTq9OGqR
         ndvGDSYGdm1jIWD0e3G5Y6Oxf1Dh390NJE35sVp/67PI5TOc7Gwq2+NmLaOH7at4rVyF
         8MGlRWOwGvTPMdNirIf6m1+T7Gd+HpNW6Xv/810GT4+CkdgicBW00IEmQneaIaHtINXz
         FJZYjBFy8RVDvom82WGtP0z0TSIvh1sebPb1rS0Tvk8HfBPU+F/aDuRe5IlE6J6LbIJ7
         O5J9yCvEFqY1ul5TOk2IbhryA2fJ6TJQWUj6nzgguEGIdTYsPLDDu89+goNjPvEL33K2
         0MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693131137; x=1693735937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGly6+ZahROEoc3sjOB5m3qZerStQgRkheVYTMYF2fg=;
        b=V/SMaxlD5O/NyXv5QpB7+BCOSNbwG2bBrAfvjaXynT9Dx2oqIMwmzrVD/5Sk3p0IE9
         IFqaSVWRbkecBk0NmMGAnNucLzrVdiOFYQTv5MvXJJXzSn6vCU0F4oIFJbOo0QCkvWT0
         TJ7zGllpGZldzDQO3yFgSWACPSgwgJASP/BpseiGXsvMfZE/FLp/qtEfK/MCErWY41K/
         4zV8pRUqaDLMKvw66QHb9NPvZ0lYnLhIBuVcUZIM2C2cRjZ2LMSngX5+s0rKqCzyYTH7
         YMVTV0JX+YzQMukvKTXxgX7z6Tiu9Hv/QN/z9/yZxjaH+lvknDOk6+1KNDir9Od2D0fB
         roDA==
X-Gm-Message-State: AOJu0YwgDLTTE7/A9yxylmWzgT11ceED6sAH1oBHuY7WtLxWh5AicZNm
        yXt4NxA5NhpuZPLFbm/1d/w=
X-Google-Smtp-Source: AGHT+IHimX1d0lfBUEDephlJBGab5Vw/5YLovsV3UoHJbwnvw1cSND9Pt9rRGAsMioD8VmEqkxf/1g==
X-Received: by 2002:adf:ded1:0:b0:313:f395:f5a3 with SMTP id i17-20020adfded1000000b00313f395f5a3mr17723051wrn.38.1693131136754;
        Sun, 27 Aug 2023 03:12:16 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id r9-20020adff709000000b0031ad5a54bedsm7266756wrp.9.2023.08.27.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 03:12:15 -0700 (PDT)
Date:   Sun, 27 Aug 2023 11:12:14 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <18a2c79d-3feb-41aa-93a9-bafbfb188cbc@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-8-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:55:00AM +0000, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
>
> It is possible that the aligned address falls on no existing mapping,
> however that does not mean that we can just align it down to that.
> This test verifies that the "vma->vm_start != addr_to_align" check in
> can_align_down() prevents disastrous results if aligning down when
> source and dest are mutually aligned within a PMD but the source/dest
> addresses requested are not at the beginning of the respective mapping
> containing these addresses.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/mm/mremap_test.c | 189 ++++++++++++++++-------
>  1 file changed, 134 insertions(+), 55 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index f45d1abedc9c..c71ac8306c89 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -24,6 +24,7 @@
>
>  #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
>  #define SIZE_MB(m) ((size_t)m * (1024 * 1024))
> +#define SIZE_KB(k) ((size_t)k * 1024)

Same comment as previous re: wrapping k in parens, it doesn't really matter
here that much but for good practice (and consistency with MIN()) would be
nice to do.

>
>  struct config {
>  	unsigned long long src_alignment;
> @@ -148,6 +149,60 @@ static bool is_range_mapped(FILE *maps_fp, void *start, void *end)
>  	return success;
>  }
>
> +/*
> + * Returns the start address of the mapping on success, else returns
> + * NULL on failure.
> + */
> +static void *get_source_mapping(struct config c)
> +{
> +	unsigned long long addr = 0ULL;
> +	void *src_addr = NULL;
> +	unsigned long long mmap_min_addr;
> +
> +	mmap_min_addr = get_mmap_min_addr();
> +	/*
> +	 * For some tests, we need to not have any mappings below the
> +	 * source mapping. Add some headroom to mmap_min_addr for this.
> +	 */
> +	mmap_min_addr += 10 * _4MB;
> +
> +retry:
> +	addr += c.src_alignment;
> +	if (addr < mmap_min_addr)
> +		goto retry;
> +
> +	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
> +					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
> +					-1, 0);
> +	if (src_addr == MAP_FAILED) {
> +		if (errno == EPERM || errno == EEXIST)
> +			goto retry;
> +		goto error;
> +	}
> +	/*
> +	 * Check that the address is aligned to the specified alignment.
> +	 * Addresses which have alignments that are multiples of that
> +	 * specified are not considered valid. For instance, 1GB address is
> +	 * 2MB-aligned, however it will not be considered valid for a
> +	 * requested alignment of 2MB. This is done to reduce coincidental
> +	 * alignment in the tests.
> +	 */
> +	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
> +			!((unsigned long long) src_addr & c.src_alignment)) {
> +		munmap(src_addr, c.region_size);
> +		goto retry;
> +	}
> +
> +	if (!src_addr)
> +		goto error;
> +
> +	return src_addr;
> +error:
> +	ksft_print_msg("Failed to map source region: %s\n",
> +			strerror(errno));
> +	return NULL;
> +}
> +

A meta thing, but it'd be nice to separate out _moving_ functions into
their own patch to make reviewing easier as here it's not obvious whether
you changed anything or not (I eyeballed and seems like you didn't though!)

>  /*
>   * This test validates that merge is called when expanding a mapping.
>   * Mapping containing three pages is created, middle page is unmapped
> @@ -300,60 +355,6 @@ static void mremap_move_within_range(char pattern_seed)
>  		ksft_test_result_fail("%s\n", test_name);
>  }
>

> -/*
> - * Returns the start address of the mapping on success, else returns
> - * NULL on failure.
> - */
> -static void *get_source_mapping(struct config c)
> -{
> -	unsigned long long addr = 0ULL;
> -	void *src_addr = NULL;
> -	unsigned long long mmap_min_addr;
> -
> -	mmap_min_addr = get_mmap_min_addr();
> -	/*
> -	 * For some tests, we need to not have any mappings below the
> -	 * source mapping. Add some headroom to mmap_min_addr for this.
> -	 */
> -	mmap_min_addr += 10 * _4MB;
> -
> -retry:
> -	addr += c.src_alignment;
> -	if (addr < mmap_min_addr)
> -		goto retry;
> -
> -	src_addr = mmap((void *) addr, c.region_size, PROT_READ | PROT_WRITE,
> -					MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
> -					-1, 0);
> -	if (src_addr == MAP_FAILED) {
> -		if (errno == EPERM || errno == EEXIST)
> -			goto retry;
> -		goto error;
> -	}
> -	/*
> -	 * Check that the address is aligned to the specified alignment.
> -	 * Addresses which have alignments that are multiples of that
> -	 * specified are not considered valid. For instance, 1GB address is
> -	 * 2MB-aligned, however it will not be considered valid for a
> -	 * requested alignment of 2MB. This is done to reduce coincidental
> -	 * alignment in the tests.
> -	 */
> -	if (((unsigned long long) src_addr & (c.src_alignment - 1)) ||
> -			!((unsigned long long) src_addr & c.src_alignment)) {
> -		munmap(src_addr, c.region_size);
> -		goto retry;
> -	}
> -
> -	if (!src_addr)
> -		goto error;
> -
> -	return src_addr;
> -error:
> -	ksft_print_msg("Failed to map source region: %s\n",
> -			strerror(errno));
> -	return NULL;
> -}
> -
>  /* Returns the time taken for the remap on success else returns -1. */
>  static long long remap_region(struct config c, unsigned int threshold_mb,
>  			      char pattern_seed)
> @@ -487,6 +488,83 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>  	return ret;
>  }
>
> +/*
> + * Verify that an mremap aligning down does not destroy
> + * the beginning of the mapping just because the aligned
> + * down address landed on a mapping that maybe does not exist.
> + */
> +static void mremap_move_1mb_from_start(char pattern_seed)
> +{
> +	char *test_name = "mremap move 1mb from start at 2MB+256KB aligned src";
> +	void *src = NULL, *dest = NULL;
> +	int i, success = 1;
> +
> +	/* Config to reuse get_source_mapping() to do an aligned mmap. */
> +	struct config c = {
> +		.src_alignment = SIZE_MB(1) + SIZE_KB(256),
> +		.region_size = SIZE_MB(6)
> +	};
> +
> +	src = get_source_mapping(c);
> +	if (!src) {
> +		success = 0;
> +		goto out;
> +	}
> +
> +	c.src_alignment = SIZE_MB(1) + SIZE_KB(256);

Why are you setting this again?

> +	dest = get_source_mapping(c);
> +	if (!dest) {
> +		success = 0;
> +		goto out;
> +	}
> +
> +	/* Set byte pattern for source block. */
> +	srand(pattern_seed);
> +	for (i = 0; i < SIZE_MB(2); i++) {
> +		((char *)src)[i] = (char) rand();
> +	}
> +
> +	/*
> +	 * Unmap the beginning of dest so that the aligned address
> +	 * falls on no mapping.
> +	 */
> +	munmap(dest, SIZE_MB(1));

This actually aligns (no pun intended) with my comments on the min mmap
address + 4 MiB comments previously. But I guess for the generalised mremap
test you will still need to have that headroom...

> +
> +	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
> +						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
> +	if (new_ptr == MAP_FAILED) {
> +		perror("mremap");
> +		success = 0;
> +		goto out;
> +	}
> +
> +	/* Verify byte pattern after remapping */
> +	srand(pattern_seed);
> +	for (i = 0; i < SIZE_MB(1); i++) {
> +		char c = (char) rand();
> +
> +		if (((char *)src)[i] != c) {
> +			ksft_print_msg("Data at src at %d got corrupted due to unrelated mremap\n",
> +				       i);
> +			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
> +					((char *) src)[i] & 0xff);
> +			success = 0;
> +		}
> +	}
> +
> +out:
> +	if (src && munmap(src, c.region_size) == -1)
> +		perror("munmap src");
> +
> +	if (dest && munmap(dest, c.region_size) == -1)
> +		perror("munmap dest");
> +
> +	if (success)
> +		ksft_test_result_pass("%s\n", test_name);
> +	else
> +		ksft_test_result_fail("%s\n", test_name);
> +}
> +
>  static void run_mremap_test_case(struct test test_case, int *failures,
>  				 unsigned int threshold_mb,
>  				 unsigned int pattern_seed)
> @@ -565,7 +643,7 @@ int main(int argc, char **argv)
>  	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
>  	unsigned int pattern_seed;
>  	int num_expand_tests = 2;
> -	int num_misc_tests = 1;
> +	int num_misc_tests = 2;
>  	struct test test_cases[MAX_TEST] = {};
>  	struct test perf_test_cases[MAX_PERF_TEST];
>  	int page_size;
> @@ -666,6 +744,7 @@ int main(int argc, char **argv)
>  	fclose(maps_fp);
>
>  	mremap_move_within_range(pattern_seed);
> +	mremap_move_1mb_from_start(pattern_seed);
>
>  	if (run_perf_tests) {
>  		ksft_print_msg("\n%s\n",
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Have you verified this test fails if you eliminate the vma->vm_start !=
addr_to_align check?

Unrelated to this patch, but I guess it might be tricky to come up with a
test for the shift_arg_pages() stack case?

Irrespective of the above, this looks correct to me so,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Thanks for putting in so much effort on the testing side too! :)
