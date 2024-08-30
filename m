Return-Path: <linux-kselftest+bounces-16796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860759661ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABED11C21D73
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986519ABCD;
	Fri, 30 Aug 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBR6NGeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276C17B4FF;
	Fri, 30 Aug 2024 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021913; cv=none; b=hSoCoK2OwqpAJX0iBtQWUdQgNUa0uwhB+fXcWiQ5EOy0VscAyUe3Yc6eah7GUAGPT0giYa76PmU70Irdd8LKGnXqOSTDSHoT7mphVYsU2jojXKdtIu+YCq8cJPfSfVhhKq3Yvcu0bUGIpgcuNWpCBfPZs2jz8qF5W4gAK3iZXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021913; c=relaxed/simple;
	bh=C4udB2LI/3VdVul4ZdAzm5x934DsC4t/ofP/Rykzolo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJQzRUE9iCRafjYoDwWIua3Qgy7ZZrRO/Z8vYIezhgf4ajUbNUCzPPkGB1+MFbaoxHvuFN0LM7+47Q59g5Q8Sbw+3qozXicCbgUJUAs6139C+YcZuWix857uof9nWFNVm+1uP8YaKjAPR5QHlbItANAYe0vHUdeC6IijOLmpAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBR6NGeZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428e0d18666so14910665e9.3;
        Fri, 30 Aug 2024 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725021909; x=1725626709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHI4f6UL8o/xAjeqhdRt5ePuagdwc9Vu7QLE1T70+iY=;
        b=cBR6NGeZdQtDbeZaG6itv23UrdnAjl+VBUF+bat8M1wXaDDDwbMwP2kCseY9EJhye8
         fJ83PEGKsTj/IEt47K91l76x5Ozj4RSCcttxJNETnJUURmiqLUFMbL8b+0683Igz4m2j
         DVZFpB0+4TjxAjaTTVgwJT9Y6KTybcOQoQ5HfsIXY2J9P7dTfU5iOKV5+O1WR0dCpD2u
         NX3tQJvtl7N+bMDWYLKZ/FOcYjJ6Dec7o+UmHPMryzhKb1Zkq6Z4a2YOh1YJkbwitNK8
         bKaQBpi1WGBUumTWVbPkrdLnSOvlHX8QYsl4RhN77Xx97YQsvVCTq1T5OKdcF7BEGA7Y
         Vhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725021909; x=1725626709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHI4f6UL8o/xAjeqhdRt5ePuagdwc9Vu7QLE1T70+iY=;
        b=MiybwaeuR8HOBDf10d+tJjFTnEjNWb6MnJKefrFXFJNN5rGgPYHsVp1abdk/ytHszU
         Moicd3wizO/9/+w25LASFlA5LnmMOxzit/n1Su7DZkeen9Y+mzdIbWrYkDQe1T0YIKPV
         RJIZHlm3qcFfPPbjuE6EwjHWSXKTmXf2enUPNKwHYCWjgaTBoAMeUAOaqE3phY/OazMZ
         pvTC1ZMBVBZkjc08+o2mGhTJzpJO+hEnCETTfFzsrDeW2D1oW5kfcQajBXcR2APxQ83z
         1ev92j2bUH2yke9r7+edEp+wBbEZl/BAk5D3deVdjwYkBuimubmKLbhdDUO4wmforU5y
         /EYA==
X-Forwarded-Encrypted: i=1; AJvYcCURTq9celsGm5gnKaPweqYyVChG7AzxiC3onVkVyfI/1RGZr0U331x4ug5cNNdxA7CZR0YzCprGGpQu7RDOl4nB@vger.kernel.org, AJvYcCWQUBHGSUC7tT7i2+ieN49MSh9Lo1YLV2+sAZFh035fUPX7II4gjrx5GezqI19fIkLKpdt8t74RyyYdn3iDibQ=@vger.kernel.org, AJvYcCWc3T9sR1ZbC7hIeEeYp+j4FSWPDtde/kd0w92YOln8bdVZETYrTchME0YfPvUQCpz8tv1mG19ZNLF6KL9/@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdYrlwH/3im/MLu8OobknRrddW6c0qcUlIaRfW5pAPSBcY0gV
	HFZ7A4k4LdimE+zLMDT/ObMWDqUpy0G85/HbnJ98YCtsbg5NTfb2
X-Google-Smtp-Source: AGHT+IGJK4GUGGa4GBeBW6LZpq8mQ/Nd15wwl3rhczUclSey00gnP4dpwPTgTVpihdfXiOF0WLqo4A==
X-Received: by 2002:a05:600c:4683:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42bbb436e2emr17818045e9.27.1725021908023;
        Fri, 30 Aug 2024 05:45:08 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:8a0:7862:ea00:1d36:5f53:3f57:14ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639da86sm78280295e9.20.2024.08.30.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:45:07 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:45:05 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/4] selftests/mm: mseal_test, add vma size check
Message-ID: <r4afvwpehewar3eeqp7vn5tx25mld4y5ub7bngwqzeozoibiq7@6crbbgfwbign>
References: <20240829214352.963001-1-jeffxu@chromium.org>
 <20240829214352.963001-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829214352.963001-2-jeffxu@chromium.org>

On Thu, Aug 29, 2024 at 09:43:49PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add check for vma size, prot bits and error return.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 398 ++++++++++++++++++++----
>  1 file changed, 332 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index e7991e5fdcf3..adc646cf576c 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -170,18 +170,31 @@ static void set_pkey(int pkey, unsigned long pkey_value)
>  static void setup_single_address(int size, void **ptrOut)
>  {
>  	void *ptr;
> +	unsigned long page_size = getpagesize();
>  
> -	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -	*ptrOut = ptr;
> +	*ptrOut = (void *)-1;
> +	ptr = mmap(NULL, size + 2 * page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (ptr != (void *) -1) {

MAP_FAILED, not (void *) -1

> +		/* add 2 page at the beginning and end to avoid auto-merge of mapping */
> +		sys_mprotect(ptr, page_size, PROT_NONE);
> +		sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
> +		*ptrOut = ptr + page_size;
> +	}
>  }
>  
>  static void setup_single_address_rw(int size, void **ptrOut)
>  {
>  	void *ptr;
>  	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	unsigned long page_size = getpagesize();
>  
> -	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
> -	*ptrOut = ptr;
> +	*ptrOut = (void *)-1;
> +	ptr = mmap(NULL, size + 2 * page_size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
> +	if (ptr != (void *) -1) {

Same here.
> +		sys_mprotect(ptr, page_size, PROT_NONE);
> +		sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
> +		*ptrOut = ptr + page_size;
> +	}
>  }
>  
>  static int clean_single_address(void *ptr, int size)
> @@ -226,6 +239,21 @@ bool pkey_supported(void)
>  	return false;
>  }
>  
> +bool get_vma_size_supported(void)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	size = get_vma_size(ptr, &prot);
> +	if (size == 4 * page_size && prot == 0x4)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void test_seal_addseal(void)
>  {
>  	int ret;
> @@ -419,11 +447,17 @@ static void test_seal_invalid_input(void)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  
> -	setup_single_address(8 * page_size, &ptr);
> +	setup_single_address(9 * page_size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> -	ret = clean_single_address(ptr + 4 * page_size, 4 * page_size);
> +
> +	ret = clean_single_address(ptr, page_size);
>  	FAIL_TEST_IF_FALSE(!ret);
>  
> +	ret = clean_single_address(ptr + 5 * page_size, 4 * page_size);
> +	FAIL_TEST_IF_FALSE(!ret);
> +
> +	ptr = ptr + page_size;
> +
>  	/* invalid flag */
>  	ret = syscall(__NR_mseal, ptr, size, 0x20);
>  	FAIL_TEST_IF_FALSE(ret < 0);
> @@ -523,6 +557,7 @@ static void test_seal_mprotect(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -533,9 +568,14 @@ static void test_seal_mprotect(bool seal)
>  	}
>  
>  	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -547,6 +587,7 @@ static void test_seal_start_mprotect(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -558,9 +599,14 @@ static void test_seal_start_mprotect(bool seal)
>  
>  	/* the first page is sealed. */
>  	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	/* pages after the first page is not sealed. */
> @@ -577,6 +623,7 @@ static void test_seal_end_mprotect(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -593,9 +640,14 @@ static void test_seal_end_mprotect(bool seal)
>  	/* last 3 page are sealed */
>  	ret = sys_mprotect(ptr + page_size, page_size * 3,
>  			PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr + page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -607,6 +659,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -618,9 +671,14 @@ static void test_seal_mprotect_unalign_len(bool seal)
>  
>  	/* 2 pages are sealed. */
>  	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	ret = sys_mprotect(ptr + page_size * 2, page_size,
> @@ -636,6 +694,7 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -646,9 +705,14 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
>  
>  	/* 3 pages are sealed. */
>  	ret = sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	ret = sys_mprotect(ptr + page_size * 3, page_size,
> @@ -664,6 +728,7 @@ static void test_seal_mprotect_two_vma(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -678,16 +743,26 @@ static void test_seal_mprotect_two_vma(bool seal)
>  	}
>  
>  	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
>  			PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr + page_size * 2, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -699,6 +774,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -719,17 +795,27 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
>  
>  	/* the second page is sealed. */
>  	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	/* the third page is sealed. */
>  	ret = sys_mprotect(ptr + 2 * page_size, page_size,
>  			PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr + 2 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	/* the fouth page is not sealed. */
> @@ -746,6 +832,7 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -758,9 +845,14 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
>  
>  	/* mprotect first 2 page will fail, since the first page are sealed. */
>  	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -783,15 +875,15 @@ static void test_seal_mprotect_partial_mprotect_tail(bool seal)
>  	}
>  
>  	ret = sys_mprotect(ptr, size, PROT_EXEC);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> -		FAIL_TEST_IF_FALSE(!ret);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
>  
> -	if (seal) {
> -		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
> +		size = get_vma_size(ptr + page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
>  		FAIL_TEST_IF_FALSE(prot == 0x4);
> -	}
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
>  }
> @@ -846,6 +938,7 @@ static void test_seal_mprotect_split(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -862,16 +955,34 @@ static void test_seal_mprotect_split(bool seal)
>  
>  	/* mprotect is sealed. */
>  	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +
> +		size = get_vma_size(ptr + page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  
>  	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +
> +		size = get_vma_size(ptr + page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -883,6 +994,7 @@ static void test_seal_mprotect_merge(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -899,9 +1011,18 @@ static void test_seal_mprotect_merge(bool seal)
>  
>  	/* 2 pages are sealed. */
>  	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +
> +		size = get_vma_size(ptr + page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 1 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	/* last 2 pages are not sealed. */
> @@ -917,6 +1038,7 @@ static void test_seal_munmap(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -928,9 +1050,14 @@ static void test_seal_munmap(bool seal)
>  
>  	/* 4 pages are sealed. */
>  	ret = sys_munmap(ptr, size);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -948,6 +1075,7 @@ static void test_seal_munmap_two_vma(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -962,15 +1090,33 @@ static void test_seal_munmap_two_vma(bool seal)
>  	}
>  
>  	ret = sys_munmap(ptr, page_size * 2);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +
> +		size = get_vma_size(ptr + 2 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	ret = sys_munmap(ptr + page_size, page_size * 2);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x6);
> +
> +		size = get_vma_size(ptr + 2 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -1018,33 +1164,75 @@ static void test_seal_munmap_partial_across_vmas(bool seal)
>  {
>  	void *ptr;
>  	unsigned long page_size = getpagesize();
> -	unsigned long size = 2 * page_size;
> +	unsigned long size = 12 * page_size;
>  	int ret;
>  	int prot;
>  
> -	/*
> -	 * Check if a partial mseal (that results in two vmas) works correctly.
> -	 * It might unmap the first, but it'll never unmap the second (msealed) vma.
> -	 */
> -
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
>  
>  	if (seal) {
> -		ret = sys_mseal(ptr + page_size, page_size);
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
>  		FAIL_TEST_IF_FALSE(!ret);
>  	}
>  
> -	ret = sys_munmap(ptr, size);
> -	if (seal)
> +	ret = sys_munmap(ptr, 12 * page_size);
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
> +
> +	ret = sys_munmap(ptr, 6 * page_size);
>  	if (seal) {
> -		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
>  		FAIL_TEST_IF_FALSE(prot == 0x4);
> -	}
> +
> +		size = get_vma_size(ptr + 8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	ret = sys_munmap(ptr + 6 * page_size, 6 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret < 0);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +
> +		size = get_vma_size(ptr + 8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
>  }
> @@ -1074,9 +1262,11 @@ static void test_munmap_start_freed(bool seal)
>  	ret = sys_munmap(ptr, size);
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
>  
>  		size = get_vma_size(ptr + page_size, &prot);
> -		FAIL_TEST_IF_FALSE(size == page_size * 3);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		/* note: this will be OK, even the first page is */
>  		/* already unmapped. */
> @@ -1095,6 +1285,7 @@ static void test_munmap_end_freed(bool seal)
>  	unsigned long page_size = getpagesize();
>  	unsigned long size = 4 * page_size;
>  	int ret;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1111,9 +1302,14 @@ static void test_munmap_end_freed(bool seal)
>  
>  	/* unmap all pages. */
>  	ret = sys_munmap(ptr, size);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 3 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	REPORT_TEST_PASS();
> @@ -1144,12 +1340,15 @@ static void test_munmap_middle_freed(bool seal)
>  	ret = sys_munmap(ptr, size);
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
>  
>  		size = get_vma_size(ptr, &prot);
>  		FAIL_TEST_IF_FALSE(size == page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  
>  		size = get_vma_size(ptr + page_size * 3, &prot);
>  		FAIL_TEST_IF_FALSE(size == page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		FAIL_TEST_IF_FALSE(!ret);
>  
> @@ -1170,6 +1369,7 @@ static void test_seal_mremap_shrink(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1184,6 +1384,10 @@ static void test_seal_mremap_shrink(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
>  
> @@ -1199,6 +1403,7 @@ static void test_seal_mremap_expand(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1216,6 +1421,10 @@ static void test_seal_mremap_expand(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 2 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		FAIL_TEST_IF_FALSE(ret2 == ptr);
>  
> @@ -1231,6 +1440,7 @@ static void test_seal_mremap_move(bool seal)
>  	unsigned long size = page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1249,10 +1459,12 @@ static void test_seal_mremap_move(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> -	} else {
> -		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
>  
> -	}
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size ==  page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
> +		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
>  
>  	REPORT_TEST_PASS();
>  }
> @@ -1264,6 +1476,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
>  	unsigned long size = page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1279,6 +1492,10 @@ static void test_seal_mmap_overwrite_prot(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == ptr);
>  
> @@ -1292,6 +1509,7 @@ static void test_seal_mmap_expand(bool seal)
>  	unsigned long size = 12 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1310,6 +1528,10 @@ static void test_seal_mmap_expand(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 8 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == ptr);
>  
> @@ -1323,6 +1545,7 @@ static void test_seal_mmap_shrink(bool seal)
>  	unsigned long size = 12 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1338,6 +1561,10 @@ static void test_seal_mmap_shrink(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 12 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == ptr);
>  
> @@ -1352,6 +1579,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1369,6 +1597,10 @@ static void test_seal_mremap_shrink_fixed(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == newAddr);
>  
> @@ -1383,6 +1615,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(page_size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1400,6 +1633,10 @@ static void test_seal_mremap_expand_fixed(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(newAddr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == newAddr);
>  
> @@ -1414,6 +1651,7 @@ static void test_seal_mremap_move_fixed(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1430,6 +1668,10 @@ static void test_seal_mremap_move_fixed(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(newAddr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else
>  		FAIL_TEST_IF_FALSE(ret2 == newAddr);
>  
> @@ -1443,6 +1685,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1460,9 +1703,12 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> -	} else {
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
> +	} else
>  		FAIL_TEST_IF_FALSE(ret2 == 0);
> -	}
>  
>  	REPORT_TEST_PASS();
>  }
> @@ -1474,6 +1720,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1488,6 +1735,10 @@ static void test_seal_mremap_move_dontunmap(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		/* kernel will allocate a new address */
>  		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
> @@ -1503,6 +1754,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
>  	unsigned long size = 4 * page_size;
>  	int ret;
>  	void *ret2;
> +	int prot;
>  
>  	setup_single_address(size, &ptr);
>  	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> @@ -1529,6 +1781,10 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
>  	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
>  		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 0x4);
>  	} else {
>  		/* remap success and return ptr2 */
>  		FAIL_TEST_IF_FALSE(ret2 ==  ptr2);
> @@ -1690,9 +1946,10 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
>  	/* sealing will take effect if PKRU deny write. */
>  	set_pkey(pkey, PKEY_DISABLE_WRITE);
>  	ret = sys_madvise(ptr, size, MADV_DONTNEED);
> -	if (seal)
> +	if (seal) {
>  		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +	} else
>  		FAIL_TEST_IF_FALSE(!ret);
>  
>  	/* base seal still apply. */

FWIW I can't review any of the above. It's still a hard to review patch with a bunch of unrelated changes
including VMA size, random errno checks, random vma size checks, etc.

Maybe break this down in separate patches.

> @@ -1876,6 +2133,15 @@ int main(int argc, char **argv)
>  	if (!pkey_supported())
>  		ksft_print_msg("PKEY not supported\n");
>  
> +	/*
> +	 * Possible reasons:
> +	 * - unable to read /proc/pid/maps (unlikely)
> +	 * - parsing error when reading /proc/pid/maps,e.g. len is not expected.
> +	 *   Is this "TOPDOWN" mapping or format change in /proc/pid/maps ?

Why do we care? I don't think running selftests without a procfs mount is supported in any way...
Format won't change.

-- 
Pedro

