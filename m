Return-Path: <linux-kselftest+bounces-37452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF8B0808A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F5A568018
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC727281F;
	Wed, 16 Jul 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHNDsdS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2F23CF12
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705063; cv=none; b=aY6gpqFTe/QB9ScWz45mujyNfFkxxdu0BcrQEedHSu2ubwFOvtur3/5d4bKL3VeviU0vuxgUVdBwd1detvF3T1I4JHAt5/TkcznLABK9243iV+ZXkB4PsF6RwSLYMs9iNqzdeQ/8ypBjQcc8CMG4yXawERziFyfPEuJjD+wQ+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705063; c=relaxed/simple;
	bh=zFDZ6jBd78CfXoOTnM1xT+gFaqaZUTFfTyekF5jYwi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WeUNPzItT/OK4r0zbgUsIbUZH3ewVf79gG1X4s94gGmF3SEG0jr/vqZm1qEsVGHEcXMhGJiU6KekQTiWoiWO7lOgKive4ZeQfLsx7AAylpUjWVmZzuGcktRUfpu9eGW3/nsanqU41Cdcrh63X8QlUBEFx67DK7dJ1hDhTHIAR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHNDsdS0; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-73ced02f415so149976a34.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752705060; x=1753309860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnL6EwkK//4BRL3fe9Zhzql5MxphF3o/wnp7Ix6fo0M=;
        b=RHNDsdS0WwhVsrrsx5p51nSlMu7WoVPDtyYJS60LQKbHrG8OsxulGDXgQ1Dxfkb2Fq
         qBGa3xdmZ7B0kdf5zRqx85j/LSXtOR4IpzMHWfNcPT7TN1XHLjo9IT5AB4oDrvr+9y06
         fT8Ty91pGUsjBEhlP+wBk/eePZBS2L3Ts3kHENElS23buCJ9H6S1ZMly7AvoOxDGOIQW
         48Tz+V83TUPdLvW/LdDrK7Zo33Cp4nZiEA8o6UYduULhTr15HaM447duOcdbBXAyh3wY
         xxTIrRUC6ere+jD6Z11p7RDDuSLg5Me+E6Tsf9evTBh422wlYo6EW/37CLytfV0XTx+v
         QBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705060; x=1753309860;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnL6EwkK//4BRL3fe9Zhzql5MxphF3o/wnp7Ix6fo0M=;
        b=gdMd8iajRCHxT5vdBsnY1hUsRWKex5B0yTpKpDTMZ9x58LivRDp54kOaLFlx1FZ/KM
         Z6NdPhaBs5ZZSCXIvMx4B9qA2bA6NRpPWD8XEppb2VLT0trib1J7DXD9Af3rDXnv8TGC
         1RLD60KO16FTdI2Bzukgy01/7V77bnNSyhN4NAj3yvKjX3gekmFAL6TqelI1vSVyP7pq
         on8jVjmRmxamEAJ1wosyZOPnw2vYB1HcNXjuj9BhUoGW5uUSrOiPpBoDlK2BXtvlddQQ
         QMPZDMh4eqt/m3yszb/9oIbnlHRSuIfN6xLfmHP6FoZ1Xhd1XVWueMShl2m/QKpv4MGJ
         eqKA==
X-Forwarded-Encrypted: i=1; AJvYcCWIzV/7RMXXCcm07T85g/0xOglaYrTH5kNV04TJw7xJ+UWrBd1PgOxkKWxG80O741M6Rc2aJQ/Si6bDkO17Dzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sdu61za7WcwVKMwXR8tzBeCcCbmoCQF0KTJlzqovvrbsJ4AS
	qz5ZHBfZGBQ/QbEYVwFlpZ53tRBzsBNJaR/zDHJs6HZ0733H77yWopVwA3ufbzDQX1X0inhx41e
	idGsbBMe/3A==
X-Google-Smtp-Source: AGHT+IGgEOrnxmdJv8AFdnIqAllBgXdIDoc04sRvyC1o2HQJ66JZ+ZGEHFGJcxigSEzomTXlRjBbf+Vir+6q
X-Received: from oabpd16.prod.google.com ([2002:a05:6870:1f10:b0:2e9:2323:d48f])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:4d86:b0:72a:1a9f:7dc7
 with SMTP id 46e09a7af769-73e64a046e7mr3896876a34.7.1752705060656; Wed, 16
 Jul 2025 15:31:00 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:30:59 -0700
In-Reply-To: <202507160743.15E8044@keescook> (Kees Cook's message of "Wed, 16
 Jul 2025 07:53:19 -0700")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-7-ynaffit@google.com>
 <202507160743.15E8044@keescook>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8jz474vks.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 6/6] binder: encapsulate individual alloc test cases
From: Tiffany Yang <ynaffit@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXY=?= =?utf-8?B?w6Vn?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Kees Cook <kees@kernel.org> writes:


> For both stringify functions, snprintf is potentially unsafe. In the
> spirit of recent string API discussions, please switch to using a
> seq_buf:


> static void stringify_free_seq(struct kunit *test, int *seq, seq_buf *buf)
> {
> 	unsigned int i;

> 	for (i = 0; i < BUFFER_NUM; i++)
> 		seq_buf_printf(buf, "[%d]", seq[i])
> 	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(buf));
> }
> ...

> 	DECLARE_SEQ_BUF(freeseq_buf, FREESEQ_BUFLEN);
> 	...
> 	stringify_free_seq(test, tc->free_sequence, &freeseq_buf);




Thanks for calling attention to this! Will be fixed for v4!


>>   static bool check_buffer_pages_allocated(struct kunit *test,
>> @@ -124,28 +164,30 @@ static bool check_buffer_pages_allocated(struct  
>> kunit *test,
>>   	return true;
>>   }

>> -static void binder_alloc_test_alloc_buf(struct kunit *test,
>> -					struct binder_alloc *alloc,
>> -					struct binder_buffer *buffers[],
>> -					size_t *sizes, int *seq)
>> +static unsigned long binder_alloc_test_alloc_buf(struct kunit *test,
>> +						 struct binder_alloc *alloc,
>> +						 struct binder_buffer *buffers[],
>> +						 size_t *sizes, int *seq)
>>   {
>> +	unsigned long failures = 0;
>>   	int i;

>>   	for (i = 0; i < BUFFER_NUM; i++) {
>>   		buffers[i] = binder_alloc_new_buf(alloc, sizes[i], 0, 0, 0);
>>   		if (IS_ERR(buffers[i]) ||
>> -		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i]))  
>> {
>> -			pr_err_size_seq(test, sizes, seq);
>> -			binder_alloc_test_failures++;
>> -		}
>> +		    !check_buffer_pages_allocated(test, alloc, buffers[i], sizes[i]))
>> +			failures++;
>>   	}
>> +
>> +	return failures;
>>   }

>> -static void binder_alloc_test_free_buf(struct kunit *test,
>> -				       struct binder_alloc *alloc,
>> -				       struct binder_buffer *buffers[],
>> -				       size_t *sizes, int *seq, size_t end)
>> +static unsigned long binder_alloc_test_free_buf(struct kunit *test,
>> +						struct binder_alloc *alloc,
>> +						struct binder_buffer *buffers[],
>> +						size_t *sizes, int *seq, size_t end)
>>   {
>> +	unsigned long failures = 0;
>>   	int i;

>>   	for (i = 0; i < BUFFER_NUM; i++)
>> @@ -153,17 +195,19 @@ static void binder_alloc_test_free_buf(struct  
>> kunit *test,

>>   	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
>>   		if (list_empty(page_to_lru(alloc->pages[i]))) {
>> -			pr_err_size_seq(test, sizes, seq);
>>   			kunit_err(test, "expect lru but is %s at page index %d\n",
>>   				  alloc->pages[i] ? "alloc" : "free", i);
>> -			binder_alloc_test_failures++;
>> +			failures++;
>>   		}
>>   	}
>> +
>> +	return failures;
>>   }

>> -static void binder_alloc_test_free_page(struct kunit *test,
>> -					struct binder_alloc *alloc)
>> +static unsigned long binder_alloc_test_free_page(struct kunit *test,
>> +						 struct binder_alloc *alloc)
>>   {
>> +	unsigned long failures = 0;
>>   	unsigned long count;
>>   	int i;

>> @@ -177,27 +221,70 @@ static void binder_alloc_test_free_page(struct  
>> kunit *test,
>>   			kunit_err(test, "expect free but is %s at page index %d\n",
>>   				  list_empty(page_to_lru(alloc->pages[i])) ?
>>   				  "alloc" : "lru", i);
>> -			binder_alloc_test_failures++;
>> +			failures++;
>>   		}
>>   	}
>> +
>> +	return failures;
>>   }

>> -static void binder_alloc_test_alloc_free(struct kunit *test,
>> +/* Executes one full test run for the given test case. */
>> +static bool binder_alloc_test_alloc_free(struct kunit *test,
>>   					 struct binder_alloc *alloc,
>> -					 size_t *sizes, int *seq, size_t end)
>> +					 struct binder_alloc_test_case_info *tc,
>> +					 size_t end)
>>   {
>> +	unsigned long pages = PAGE_ALIGN(end) / PAGE_SIZE;
>>   	struct binder_buffer *buffers[BUFFER_NUM];
>> -
>> -	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
>> -	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
>> +	unsigned long failures;
>> +	bool failed = false;
>> +
>> +	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
>> +					       tc->buffer_sizes,
>> +					       tc->free_sequence);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "Initial allocation failed: %lu/%u buffers with errors",
>> +			    failures, BUFFER_NUM);
>> +
>> +	failures = binder_alloc_test_free_buf(test, alloc, buffers,
>> +					      tc->buffer_sizes,
>> +					      tc->free_sequence, end);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "Initial buffers not freed correctly: %lu/%lu pages not on lru  
>> list",
>> +			    failures, pages);

>>   	/* Allocate from lru. */
>> -	binder_alloc_test_alloc_buf(test, alloc, buffers, sizes, seq);
>> -	if (list_lru_count(alloc->freelist))
>> -		kunit_err(test, "lru list should be empty but is not\n");
>> -
>> -	binder_alloc_test_free_buf(test, alloc, buffers, sizes, seq, end);
>> -	binder_alloc_test_free_page(test, alloc);
>> +	failures = binder_alloc_test_alloc_buf(test, alloc, buffers,
>> +					       tc->buffer_sizes,
>> +					       tc->free_sequence);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "Reallocation failed: %lu/%u buffers with errors",
>> +			    failures, BUFFER_NUM);
>> +
>> +	failures = list_lru_count(alloc->freelist);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "lru list should be empty after reallocation but still has %lu  
>> pages",
>> +			    failures);
>> +
>> +	failures = binder_alloc_test_free_buf(test, alloc, buffers,
>> +					      tc->buffer_sizes,
>> +					      tc->free_sequence, end);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "Reallocated buffers not freed correctly: %lu/%lu pages not on  
>> lru list",
>> +			    failures, pages);
>> +
>> +	failures = binder_alloc_test_free_page(test, alloc);
>> +	failed = failed || failures;
>> +	KUNIT_EXPECT_EQ_MSG(test, failures, 0,
>> +			    "Failed to clean up allocated pages: %lu/%lu pages still  
>> installed",
>> +			    failures, (alloc->buffer_size / PAGE_SIZE));
>> +
>> +	return failed;
>>   }

>>   static bool is_dup(int *seq, int index, int val)
>> @@ -213,24 +300,44 @@ static bool is_dup(int *seq, int index, int val)

>>   /* Generate BUFFER_NUM factorial free orders. */
>>   static void permute_frees(struct kunit *test, struct binder_alloc  
>> *alloc,
>> -			  size_t *sizes, int *seq, int index, size_t end)
>> +			  struct binder_alloc_test_case_info *tc,
>> +			  unsigned long *runs, unsigned long *failures,
>> +			  int index, size_t end)
>>   {
>> +	bool case_failed;
>>   	int i;

>>   	if (index == BUFFER_NUM) {
>> -		binder_alloc_test_alloc_free(test, alloc, sizes, seq, end);
>> +		char freeseq_buf[FREESEQ_BUFLEN];
>> +
>> +		case_failed = binder_alloc_test_alloc_free(test, alloc, tc, end);
>> +		*runs += 1;
>> +		*failures += case_failed;
>> +
>> +		if (case_failed || PRINT_ALL_CASES) {
>> +			stringify_free_seq(test, tc->free_sequence, freeseq_buf,
>> +					   FREESEQ_BUFLEN);
>> +			kunit_err(test, "case %lu: [%s] | %s - %s - %s", *runs,
>> +				  case_failed ? "FAILED" : "PASSED",
>> +				  tc->front_pages ? "front" : "back ",
>> +				  tc->alignments, freeseq_buf);
>> +		}
>> +
>>   		return;
>>   	}
>>   	for (i = 0; i < BUFFER_NUM; i++) {
>> -		if (is_dup(seq, index, i))
>> +		if (is_dup(tc->free_sequence, index, i))
>>   			continue;
>> -		seq[index] = i;
>> -		permute_frees(test, alloc, sizes, seq, index + 1, end);
>> +		tc->free_sequence[index] = i;
>> +		permute_frees(test, alloc, tc, runs, failures, index + 1, end);
>>   	}
>>   }

>> -static void gen_buf_sizes(struct kunit *test, struct binder_alloc  
>> *alloc,
>> -			  size_t *end_offset)
>> +static void gen_buf_sizes(struct kunit *test,
>> +			  struct binder_alloc *alloc,
>> +			  struct binder_alloc_test_case_info *tc,
>> +			  size_t *end_offset, unsigned long *runs,
>> +			  unsigned long *failures)
>>   {
>>   	size_t last_offset, offset = 0;
>>   	size_t front_sizes[BUFFER_NUM];
>> @@ -238,31 +345,45 @@ static void gen_buf_sizes(struct kunit *test,  
>> struct binder_alloc *alloc,
>>   	int seq[BUFFER_NUM] = {0};
>>   	int i;

>> +	tc->free_sequence = seq;
>>   	for (i = 0; i < BUFFER_NUM; i++) {
>>   		last_offset = offset;
>>   		offset = end_offset[i];
>>   		front_sizes[i] = offset - last_offset;
>>   		back_sizes[BUFFER_NUM - i - 1] = front_sizes[i];
>>   	}
>> +	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
>> +
>>   	/*
>>   	 * Buffers share the first or last few pages.
>>   	 * Only BUFFER_NUM - 1 buffer sizes are adjustable since
>>   	 * we need one giant buffer before getting to the last page.
>>   	 */
>> -	back_sizes[0] += alloc->buffer_size - end_offset[BUFFER_NUM - 1];
>> -	permute_frees(test, alloc, front_sizes, seq, 0,
>> +	tc->front_pages = true;
>> +	tc->buffer_sizes = front_sizes;
>> +	permute_frees(test, alloc, tc, runs, failures, 0,
>>   		      end_offset[BUFFER_NUM - 1]);
>> -	permute_frees(test, alloc, back_sizes, seq, 0, alloc->buffer_size);
>> +
>> +	tc->front_pages = false;
>> +	tc->buffer_sizes = back_sizes;
>> +	permute_frees(test, alloc, tc, runs, failures, 0, alloc->buffer_size);
>>   }

>>   static void gen_buf_offsets(struct kunit *test, struct binder_alloc  
>> *alloc,
>> -			    size_t *end_offset, int index)
>> +			    size_t *end_offset, int *alignments,
>> +			    unsigned long *runs, unsigned long *failures,
>> +			    int index)
>>   {
>>   	size_t end, prev;
>>   	int align;

>>   	if (index == BUFFER_NUM) {
>> -		gen_buf_sizes(test, alloc, end_offset);
>> +		struct binder_alloc_test_case_info tc = {0};
>> +
>> +		stringify_alignments(test, alignments, tc.alignments,
>> +				     ALIGNMENTS_BUFLEN);
>> +
>> +		gen_buf_sizes(test, alloc, &tc, end_offset, runs, failures);
>>   		return;
>>   	}
>>   	prev = index == 0 ? 0 : end_offset[index - 1];
>> @@ -276,7 +397,9 @@ static void gen_buf_offsets(struct kunit *test,  
>> struct binder_alloc *alloc,
>>   		else
>>   			end += BUFFER_MIN_SIZE;
>>   		end_offset[index] = end;
>> -		gen_buf_offsets(test, alloc, end_offset, index + 1);
>> +		alignments[index] = align;
>> +		gen_buf_offsets(test, alloc, end_offset, alignments, runs,
>> +				failures, index + 1);
>>   	}
>>   }

>> @@ -328,10 +451,15 @@ static void binder_alloc_exhaustive_test(struct  
>> kunit *test)
>>   {
>>   	struct binder_alloc_test *priv = test->priv;
>>   	size_t end_offset[BUFFER_NUM];
>> +	int alignments[BUFFER_NUM];
>> +	unsigned long failures = 0;
>> +	unsigned long runs = 0;

>> -	gen_buf_offsets(test, &priv->alloc, end_offset, 0);
>> +	gen_buf_offsets(test, &priv->alloc, end_offset, alignments, &runs,
>> +			&failures, 0);

>> -	KUNIT_EXPECT_EQ(test, binder_alloc_test_failures, 0);
>> +	KUNIT_EXPECT_EQ(test, runs, TOTAL_EXHAUSTIVE_CASES);
>> +	KUNIT_EXPECT_EQ(test, failures, 0);
>>   }

>>   /* ===== End test cases ===== */
>> --
>> 2.50.0.727.gbf7dc18ff4-goog


> Otherwise looks good to me.

-- 
Tiffany Y. Yang

