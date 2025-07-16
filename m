Return-Path: <linux-kselftest+bounces-37438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78081B078AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A043BB5C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38112620FC;
	Wed, 16 Jul 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfleh06H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDD2236E3;
	Wed, 16 Jul 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677600; cv=none; b=YW1t87m3mrE82HryStScEBSrqvIozXXjm9tkfroAusiScbWzYj8+J9iKLRF5mvp4ROtJstlZUUA4ZQkmxPcyWie9gHfymK7HHTpayYjqrFzxxHJTeabSUKRMKcbuD4NLGQ51a8JTpceUtzUaBEOLcamRsvsdzwBOqLGopf+RhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677600; c=relaxed/simple;
	bh=tjBIkOcDJ6yyvvaX5mZQqHQR0lbb8AXk9MaeiLCxRm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO2vCG46da9cmFEThwu+LAlYWgRgbJ8TLthtP61KpXctOVrMXhz58+QrbL8ek7tYnbhp1+vgSNk3nJcE+PDoYoS1TilcVqG9Q6iaFNWHKvfiY/OWNpXLeKOqT2ePL7K1MTv+M4TLCcPBE8nZkV4vh0BaEUJgnNEQbUG3dHu6dLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfleh06H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2BCC4CEEB;
	Wed, 16 Jul 2025 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752677600;
	bh=tjBIkOcDJ6yyvvaX5mZQqHQR0lbb8AXk9MaeiLCxRm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xfleh06HWjK38dlpTLwEBM/U8phRilJ6y/3k8wR9d4JJXQFemrJ2Xb0R0zVaIGZh1
	 kWGVMB/F0zWXm5rFwDGB+sB9c2C0T05NzkAQOxB+gWm8s1DdisllH1sjZro8tsuZKU
	 ujNNgUeOjGkUG2Q9uHtPVxYsBjNaE62eBA0WKyX7KFdLqNH5c5WmE3Q2QtFnaT0UiW
	 sbYUMZykz5r1EvhTzS6llVSYhH1OoTu0pZRRv0Zck5FDMtvrZy79VLqXrXB9+0zYyJ
	 bhIaH2PrIwiO2WYXdrcznOyohLgGHotkmwfPIDlPjc/LcHgcMPjziU4aFYz+6xbYRc
	 gAumSafVIV8MQ==
Date: Wed, 16 Jul 2025 07:53:19 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 6/6] binder: encapsulate individual alloc test cases
Message-ID: <202507160743.15E8044@keescook>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-7-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714185321.2417234-7-ynaffit@google.com>

On Mon, Jul 14, 2025 at 11:53:19AM -0700, Tiffany Yang wrote:
> Each case tested by the binder allocator test is defined by 3 parameters:
> the end alignment type of each requested buffer allocation, whether those
> buffers share the front or back pages of the allotted address space, and
> the order in which those buffers should be released. The alignment type
> represents how a binder buffer may be laid out within or across page
> boundaries and relative to other buffers, and it's used along with
> whether the buffers cover part (sharing the front pages) of or all
> (sharing the back pages) of the vma to calculate the sizes passed into
> each test.
> 
> binder_alloc_test_alloc recursively generates each possible arrangement
> of alignment types and then tests that the binder_alloc code tracks pages
> correctly when those buffers are allocated and then freed in every
> possible order at both ends of the address space. While they provide
> comprehensive coverage, they are poor candidates to be represented as
> KUnit test cases, which must be statically enumerated. For 5 buffers and
> 5 end alignment types, the test case array would have 750,000 entries.
> This change structures the recursive calls into meaningful test cases so
> that failures are easier to interpret.
> 
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
> v2:
> * Fix build warning Reported-by: kernel test robot <lkp@intel.com>
>   Closes: https://lore.kernel.org/oe-kbuild-all/202506281959.hfOTIUjS-lkp@intel.com/
> ---
>  drivers/android/tests/binder_alloc_kunit.c | 234 ++++++++++++++++-----
>  1 file changed, 181 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/android/tests/binder_alloc_kunit.c b/drivers/android/tests/binder_alloc_kunit.c
> index 9e185e2036e5..02aa4a135eb5 100644
> --- a/drivers/android/tests/binder_alloc_kunit.c
> +++ b/drivers/android/tests/binder_alloc_kunit.c
> @@ -24,7 +24,16 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>  #define BUFFER_NUM 5
>  #define BUFFER_MIN_SIZE (PAGE_SIZE / 8)
>  
> -static int binder_alloc_test_failures;
> +#define FREESEQ_BUFLEN ((3 * BUFFER_NUM) + 1)
> +
> +#define ALIGN_TYPE_STRLEN (12)
> +
> +#define ALIGNMENTS_BUFLEN (((ALIGN_TYPE_STRLEN + 6) * BUFFER_NUM) + 1)
> +
> +#define PRINT_ALL_CASES (0)
> +
> +/* 5^5 alignment combinations * 2 places to share pages * 5! free sequences */
> +#define TOTAL_EXHAUSTIVE_CASES (3125 * 2 * 120)
>  
>  /**
>   * enum buf_end_align_type - Page alignment of a buffer
> @@ -86,18 +95,49 @@ enum buf_end_align_type {
>  	LOOP_END,
>  };
>  
> -static void pr_err_size_seq(struct kunit *test, size_t *sizes, int *seq)
> +static const char *const buf_end_align_type_strs[LOOP_END] = {
> +	[SAME_PAGE_UNALIGNED] = "SP_UNALIGNED",
> +	[SAME_PAGE_ALIGNED]   = " SP_ALIGNED ",
> +	[NEXT_PAGE_UNALIGNED] = "NP_UNALIGNED",
> +	[NEXT_PAGE_ALIGNED]   = " NP_ALIGNED ",
> +	[NEXT_NEXT_UNALIGNED] = "NN_UNALIGNED",
> +};
> +
> +struct binder_alloc_test_case_info {
> +	size_t *buffer_sizes;
> +	int *free_sequence;
> +	char alignments[ALIGNMENTS_BUFLEN];
> +	bool front_pages;
> +};
> +
> +static void stringify_free_seq(struct kunit *test, int *seq, char *buf,
> +			       size_t buf_len)
>  {
> +	size_t bytes = 0;
>  	int i;
>  
> -	kunit_err(test, "alloc sizes: ");
> -	for (i = 0; i < BUFFER_NUM; i++)
> -		pr_cont("[%zu]", sizes[i]);
> -	pr_cont("\n");
> -	kunit_err(test, "free seq: ");
> -	for (i = 0; i < BUFFER_NUM; i++)
> -		pr_cont("[%d]", seq[i]);
> -	pr_cont("\n");
> +	for (i = 0; i < BUFFER_NUM; i++) {
> +		bytes += snprintf(buf + bytes, buf_len - bytes, "[%d]", seq[i]);
> +		if (bytes >= buf_len)
> +			break;
> +	}
> +	KUNIT_EXPECT_LT(test, bytes, buf_len);
> +}
> +
> +static void stringify_alignments(struct kunit *test, int *alignments,
> +				 char *buf, size_t buf_len)
> +{
> +	size_t bytes = 0;
> +	int i;
> +
> +	for (i = 0; i < BUFFER_NUM; i++) {
> +		bytes += snprintf(buf + bytes, buf_len - bytes, "[ %d:%s ]", i,
> +				  buf_end_align_type_strs[alignments[i]]);
> +		if (bytes >= buf_len)
> +			break;
> +	}
> +
> +	KUNIT_EXPECT_LT(test, bytes, buf_len);
>  }

For both stringify functions, snprintf is potentially unsafe. In the
spirit of recent string API discussions, please switch to using a
seq_buf:


static void stringify_free_seq(struct kunit *test, int *seq, seq_buf *buf)
{
	unsigned int i;

	for (i = 0; i < BUFFER_NUM; i++)
		seq_buf_printf(buf, "[%d]", seq[i])
	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(buf));
}
...

	DECLARE_SEQ_BUF(freeseq_buf, FREESEQ_BUFLEN);
	...
	stringify_free_seq(test, tc->free_sequence, &freeseq_buf);



>  
>  static bool check_buffer_pages_allocated(struct kunit *test,
> @@ -124,28 +164,30 @@ static bool check_buffer_pages_allocated(struct kunit *test,
>  	return true;
>  }
>  
> -static void binder_alloc_test_alloc_buf(struct kunit *test,
> -					struct binder_alloc *alloc,
> -					struct binder_buffer *buffers[],
> -					size_t *sizes, int *seq)
> +static unsigned long binder_alloc_test_alloc_buf(struct kunit *test,
> +						 struct binder_alloc *alloc,
> +						 struct binder_buffer *buffers[],
> +						 size_t *sizes, int *seq)
>  {
> +	unsigned long failures = 0;
>  	int i;
>  
>  	for (i = 0; i < BUFFER_NUM; i++) {
>  		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
>  		if (IS_ERR(buffers[i]) ||
> -		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i])) {
> -			pr_err_size_seq(test, sizes, seq);
> -			binder_alloc_test_failures++;
> -		}
> +		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i]))
> +			failures++;
>  	}
> +
> +	return failures;
>  }
>  
> -static void binder_alloc_test_free_buf(struct kunit *test,
> -				       struct binder_alloc *alloc,
> -				       struct binder_buffer *buffers[],
> -				       size_t *sizes, int *seq, size_t end)
> +static unsigned long binder_alloc_test_free_buf(struct kunit *test,
> +						struct binder_alloc *alloc,
> +						struct binder_buffer *buffers[],
> +						size_t *sizes, int *seq, size_t end)
>  {
> +	unsigned long failures = 0;
>  	int i;
>  
>  	for (i = 0; i < BUFFER_NUM; i++)
> @@ -153,17 +195,19 @@ static void binder_alloc_test_free_buf(struct kunit *test,
>  
>  	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
>  		if (list_empty(page_to_lru(alloc->pages[i]))) {
> -			pr_err_size_seq(test, sizes, seq);
>  			kunit_err(test, "expect lru but is %s at page index %d\n",
>  				  alloc->pages[i] ? "alloc" : "free", i);
> -			binder_alloc_test_failures++;
> +			failures++;
>  		}
>  	}
> +
> +	return failures;
>  }
>  
> -static void binder_alloc_test_free_page(struct kunit *test,
> -					struct binder_alloc *alloc)
> +static unsigned long binder_alloc_test_free_page(struct kunit *test,
> +						 struct binder_alloc *alloc)
>  {
> +	unsigned long failures = 0;
>  	unsigned long count;
>  	int i;
>  
> @@ -177,27 +221,70 @@ static void binder_alloc_test_free_page(struct kunit *test,
>  			kunit_err(test, "expect free but is %s at page index %d\n",
>  				  list_empty(page_to_lru(alloc->pages[i])) ?
>  				  "alloc" : "lru", i);
> -			binder_alloc_test_failures++;
> +			failures++;
>  		}
>  	}
> +
> +	return failures;
>  }
>  
> -static void binder_alloc_test_alloc_free(struct kunit *test,
> +/* Executes one full test run for the given test case. */
> +static bool binder_alloc_test_alloc_free(struct kunit *test,
>  					 struct binder_alloc *alloc,
> -					 size_t *sizes, int *seq, size_t end)
> +					 struct binder_alloc_test_case_info *tc,
> +					 size_t end)
>  {
> +	unsigned long pages = PAGE_ALIGN(end) / PAGE_SIZE;
>  	struct binder_buffer *buffers[BUFFER_NUM];
> -
> -	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
> -	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
> +	unsigned long failures;
> +	bool failed = false;
> +
> +	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
> +					       tc->buffer_sizes,
> +					       tc->free_sequence);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "Initial allocation failed: %lu/%u buffers with errors",
> +			    failures, BUFFER_NUM);
> +
> +	failures = binder_alloc_test_free_buf(test, alloc, buffers,
> +					      tc->buffer_sizes,
> +					      tc->free_sequence, end);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "Initial buffers not freed correctly: %lu/%lu pages not on lru list",
> +			    failures, pages);
>  
>  	/* Allocate from lru. */
> -	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
> -	if (list_lru_count(alloc->freelist))
> -		kunit_err(test, "lru list should be empty but is not\n");
> -
> -	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
> -	binder_alloc_test_free_page(test, alloc);
> +	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
> +					       tc->buffer_sizes,
> +					       tc->free_sequence);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "Reallocation failed: %lu/%u buffers with errors",
> +			    failures, BUFFER_NUM);
> +
> +	failures = list_lru_count(alloc->freelist);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "lru list should be empty after reallocation but still has %lu pages",
> +			    failures);
> +
> +	failures = binder_alloc_test_free_buf(test, alloc, buffers,
> +					      tc->buffer_sizes,
> +					      tc->free_sequence, end);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "Reallocated buffers not freed correctly: %lu/%lu pages not on lru list",
> +			    failures, pages);
> +
> +	failures = binder_alloc_test_free_page(test, alloc);
> +	failed = failed || failures;
> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
> +			    "Failed to clean up allocated pages: %lu/%lu pages still installed",
> +			    failures, (alloc->buffer_size / PAGE_SIZE));
> +
> +	return failed;
>  }
>  
>  static bool is_dup(int *seq, int index, int val)
> @@ -213,24 +300,44 @@ static bool is_dup(int *seq, int index, int val)
>  
>  /* Generate BUFFER_NUM factorial free orders. */
>  static void permute_frees(struct kunit *test, struct binder_alloc *alloc,
> -			  size_t *sizes, int *seq, int index, size_t end)
> +			  struct binder_alloc_test_case_info *tc,
> +			  unsigned long *runs, unsigned long *failures,
> +			  int index, size_t end)
>  {
> +	bool case_failed;
>  	int i;
>  
>  	if (index == BUFFER_NUM) {
> -		binder_alloc_test_alloc_free(test, alloc, sizes, seq, end);
> +		char freeseq_buf[FREESEQ_BUFLEN];
> +
> +		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
> +		*runs += 1;
> +		*failures += case_failed;
> +
> +		if (case_failed || PRINT_ALL_CASES) {
> +			stringify_free_seq(test, tc->free_sequence, freeseq_buf,
> +					   FREESEQ_BUFLEN);
> +			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
> +				  case_failed ? "FAILED" : "PASSED",
> +				  tc->front_pages ? "front" : "back ",
> +				  tc->alignments, freeseq_buf);
> +		}
> +
>  		return;
>  	}
>  	for (i = 0; i < BUFFER_NUM; i++) {
> -		if (is_dup(seq, index, i))
> +		if (is_dup(tc->free_sequence, index, i))
>  			continue;
> -		seq[index] = i;
> -		permute_frees(test, alloc, sizes, seq, index + 1, end);
> +		tc->free_sequence[index] = i;
> +		permute_frees(test, alloc, tc, runs, failures, index + 1, end);
>  	}
>  }
>  
> -static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
> -			  size_t *end_offset)
> +static void gen_buf_sizes(struct kunit *test,
> +			  struct binder_alloc *alloc,
> +			  struct binder_alloc_test_case_info *tc,
> +			  size_t *end_offset, unsigned long *runs,
> +			  unsigned long *failures)
>  {
>  	size_t last_offset, offset = 0;
>  	size_t front_sizes[BUFFER_NUM];
> @@ -238,31 +345,45 @@ static void gen_buf_sizes(struct kunit *test, struct binder_alloc *alloc,
>  	int seq[BUFFER_NUM] = {0};
>  	int i;
>  
> +	tc->free_sequence = seq;
>  	for (i = 0; i < BUFFER_NUM; i++) {
>  		last_offset = offset;
>  		offset = end_offset[i];
>  		front_sizes[i] = offset - last_offset;
>  		back_sizes[BUFFER_NUM - i - 1] = front_sizes[i];
>  	}
> +	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
> +
>  	/*
>  	 * Buffers share the first or last few pages.
>  	 * Only BUFFER_NUM - 1 buffer sizes are adjustable since
>  	 * we need one giant buffer before getting to the last page.
>  	 */
> -	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
> -	permute_frees(test, alloc, front_sizes, seq, 0,
> +	tc->front_pages = true;
> +	tc->buffer_sizes = front_sizes;
> +	permute_frees(test, alloc, tc, runs, failures, 0,
>  		      end_offset[BUFFER_NUM - 1]);
> -	permute_frees(test, alloc, back_sizes, seq, 0, alloc->buffer_size);
> +
> +	tc->front_pages = false;
> +	tc->buffer_sizes = back_sizes;
> +	permute_frees(test, alloc, tc, runs, failures, 0, alloc->buffer_size);
>  }
>  
>  static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
> -			    size_t *end_offset, int index)
> +			    size_t *end_offset, int *alignments,
> +			    unsigned long *runs, unsigned long *failures,
> +			    int index)
>  {
>  	size_t end, prev;
>  	int align;
>  
>  	if (index == BUFFER_NUM) {
> -		gen_buf_sizes(test, alloc, end_offset);
> +		struct binder_alloc_test_case_info tc = {0};
> +
> +		stringify_alignments(test, alignments, tc.alignments,
> +				     ALIGNMENTS_BUFLEN);
> +
> +		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
>  		return;
>  	}
>  	prev = index == 0 ? 0 : end_offset[index - 1];
> @@ -276,7 +397,9 @@ static void gen_buf_offsets(struct kunit *test, struct binder_alloc *alloc,
>  		else
>  			end += BUFFER_MIN_SIZE;
>  		end_offset[index] = end;
> -		gen_buf_offsets(test, alloc, end_offset, index + 1);
> +		alignments[index] = align;
> +		gen_buf_offsets(test, alloc, end_offset, alignments, runs,
> +				failures, index + 1);
>  	}
>  }
>  
> @@ -328,10 +451,15 @@ static void binder_alloc_exhaustive_test(struct kunit *test)
>  {
>  	struct binder_alloc_test *priv = test->priv;
>  	size_t end_offset[BUFFER_NUM];
> +	int alignments[BUFFER_NUM];
> +	unsigned long failures = 0;
> +	unsigned long runs = 0;
>  
> -	gen_buf_offsets(test, &priv->alloc, end_offset, 0);
> +	gen_buf_offsets(test, &priv->alloc, end_offset, alignments, &runs,
> +			&failures, 0);
>  
> -	KUNIT_EXPECT_EQ(test, binder_alloc_test_failures, 0);
> +	KUNIT_EXPECT_EQ(test, runs, TOTAL_EXHAUSTIVE_CASES);
> +	KUNIT_EXPECT_EQ(test, failures, 0);
>  }
>  
>  /* ===== End test cases ===== */
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

Otherwise looks good to me.

-- 
Kees Cook

