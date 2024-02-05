Return-Path: <linux-kselftest+bounces-4167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1684AA3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092541C246E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84D482F5;
	Mon,  5 Feb 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKzJc/BO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDE482F7
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174308; cv=none; b=DgxwzBIsx3Jomwk2m5nsSb8UjKbk/v4loh5o3Sfbg5MT82K9OnLukPN4w83OmxhXmUquO0CCP3DUw4nqbMcNjHh/oo6n8CZlZBDLBqWOQrjYON+PARk46Vqcmde333LnHYUzh35Ywo0VizQD9TyioGCxGBn4W1vGqmCLNECHBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174308; c=relaxed/simple;
	bh=r7hwl9FZPSbwtzf91HLG2uYS3wWs5xJYPgd288Oe7tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WwtOgaS3v8qyKxeou6GOBps5BpdgOoA5dHuw/0YkeYjNaBdBtGvU3i/vQiwXlKi2lNwsXv1Yb/9FPxYVjWQJcVqg1n3FKvGNqFP4YlHcCo+B6GgpTTLXa4+FkwDZtPQ4oqA0o42XxYCnc7vck3t4pcrz7kdGUGu32+N99x5+5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKzJc/BO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60416f4cba4so91547887b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 15:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707174304; x=1707779104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZxrWnq5zjsPkEKkrjYrS8M9CKMdrdKLinApXAx16Nw=;
        b=TKzJc/BOKkbOwVMIjJZKR3Q42nBn6EtR2HouUMZRJtZRYg1hL3dyfIKLoB3+WLFf9m
         TwFjk4kud47L02YJEss4rYDWIOB1nZ0mt2MyxaCKobGqRaucivPsKa3xpyGILWIGIkth
         ANlZzzdkse0Tvz0ed6qMKEdb2TTeAQLPLUgRNlTzV7MuLxDN4Mh9DdCyohry80dAa2Y7
         YLqtnMbNELFIlBqc/eeqYVCsLE11u8bXtPn58In7nIEtJdUzENUOMcKhinH8LOi2j7gv
         z0kZbwkCfNUJQj5S8rWQAZwP/5qXOBClEo/eCMsVK37Ebg6VnSaN7BwI3SLwjGzIVtLt
         zBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174304; x=1707779104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZxrWnq5zjsPkEKkrjYrS8M9CKMdrdKLinApXAx16Nw=;
        b=nuP9XBnQ28YXXq0cIVIf4nLk43mZVB6qZcgKV9KRwyL7qWQZ5SqctSUKFPF/rbsIfG
         Cp4hHD5CXN6Gm6DRYTQF30ra8X2XI3457whVpSmdiiZM47njBLbldAkJ8/zaxVgN10Y6
         XsJVwX2jVtf6wSOSsUBTLoXhXNSb3CcR7iYM/+VOEojFKsQVgojHeyCBMrMguoVNES0z
         PZjueixq6kWEfhF+6/de/8iLoLLUQGbcNkQlY023CJ3z1699oJjpccThgv73rpNMdn5W
         2S/yY09ZUTM/kmZ6yJEc0AlXWZgHkFKCBdScQ3KU7TvOGdBjjOEnJS96YbQrTcWrHuvX
         mHXA==
X-Gm-Message-State: AOJu0YyQGomVAzarEyLLFlSuiP93djQ9ybdxoaF5EIh3IMc9nnVbwyPR
	+u2xMzHVqvrIjdNBydVWjYe3gc4ITggyZdrZKeAZDRvNzqSuEt1DKvQYy7046t55Zz5mheskTdW
	1Z2sLUbNsSjN1bXsxKA==
X-Google-Smtp-Source: AGHT+IEUIGBmonf8OUL3+nxDnw4mX6xBUsQEC+uMCjLlLfEloLx4Ka+Rv5WbqnXlV8aBShzzt7LSfSBY3cgF6gyX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:e04:b0:dc6:af9a:8cfa with SMTP
 id df4-20020a0569020e0400b00dc6af9a8cfamr225097ybb.6.1707174304249; Mon, 05
 Feb 2024 15:05:04 -0800 (PST)
Date: Mon, 5 Feb 2024 23:05:02 +0000
In-Reply-To: <20240205225608.3083251-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205225608.3083251-1-nphamcs@gmail.com> <20240205225608.3083251-4-nphamcs@gmail.com>
Message-ID: <ZcFpnokh3W1DFBCj@google.com>
Subject: Re: [PATCH v3 3/3] selftests: add zswapin and no zswap tests
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, shuah@kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 05, 2024 at 02:56:08PM -0800, Nhat Pham wrote:
> Add a selftest to cover the zswapin code path, allocating more memory
> than the cgroup limit to trigger swapout/zswapout, then reading the
> pages back in memory several times. This is inspired by a recently
> encountered kernel crash on the zswapin path in our internal kernel,
> which went undetected because of a lack of test coverage for this path.
> 
> Add a selftest to verify that when memory.zswap.max = 0, no pages can go
> to the zswap pool for the cgroup.
> 
> Suggested-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

LGTM with a few nits below:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 120 +++++++++++++++++++-
>  1 file changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index 32ce975b21d1..c263610a4a60 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
>  	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
>  }
>  
> +static int allocate_and_read_bytes(const char *cgroup, void *arg)
> +{
> +	size_t size = (size_t)arg;
> +	char *mem = (char *)malloc(size);
> +	int ret = 0;
> +
> +	if (!mem)
> +		return -1;
> +	for (int i = 0; i < size; i += 4095)
> +		mem[i] = 'a';
> +
> +	/* go through the allocated memory to (z)swap in and out pages */

nit: s/go/Go

> +	for (int i = 0; i < size; i += 4095) {
> +		if (mem[i] != 'a')
> +			ret = -1;
> +	}
> +
> +	free(mem);
> +	return ret;
> +}
> +
>  static int allocate_bytes(const char *cgroup, void *arg)
>  {
>  	size_t size = (size_t)arg;
> @@ -100,7 +121,6 @@ static int test_zswap_usage(const char *root)
>  	int ret = KSFT_FAIL;
>  	char *test_group;
>  
> -	/* Set up */

We removed this comment here.

>  	test_group = cg_name(root, "no_shrink_test");
>  	if (!test_group)
>  		goto out;
> @@ -133,6 +153,102 @@ static int test_zswap_usage(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * Check that when memory.zswap.max = 0, no pages can go to the zswap pool for
> + * the cgroup.
> + */
> +static int test_swapin_nozswap(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +	long swap_peak, zswpout;
> +
> +	test_group = cg_name(root, "no_zswap_test");
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "8M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.zswap.max", "0"))
> +		goto out;
> +
> +	/* Allocate and read more than memory.max to trigger swapin */
> +	if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
> +		goto out;
> +
> +	/* Verify that pages are swapped out, but no zswap happened */
> +	swap_peak = cg_read_long(test_group, "memory.swap.peak");
> +	if (swap_peak < 0) {
> +		ksft_print_msg("failed to get cgroup's swap_peak\n");
> +		goto out;
> +	}
> +
> +	if (swap_peak == 0) {
> +		ksft_print_msg("pages should be swapped out\n");
> +		goto out;
> +	}

We can actually check that this number is >= 24M instead. Not a big
deal, but might as well.

> +
> +	zswpout = get_zswpout(test_group);
> +	if (zswpout < 0) {
> +		ksft_print_msg("failed to get zswpout\n");
> +		goto out;
> +	}
> +
> +	if (zswpout > 0) {
> +		ksft_print_msg("zswapout > 0 when memory.zswap.max = 0\n");
> +		goto out;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
> +/* Simple test to verify the (z)swapin code paths */
> +static int test_zswapin(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +	long zswpin;
> +
> +	/* Set up */

Yet we added a similar one here :)

> +	test_group = cg_name(root, "zswapin_test");
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "8M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.zswap.max", "max"))
> +		goto out;
> +
> +	/* Allocate and read more than memory.max to trigger (z)swap in */
> +	if (cg_run(test_group, allocate_and_read_bytes, (void *)MB(32)))
> +		goto out;
> +
> +	zswpin = cg_read_key_long(test_group, "memory.stat", "zswpin ");
> +	if (zswpin < 0) {
> +		ksft_print_msg("failed to get zswpin\n");
> +		goto out;
> +	}
> +
> +	if (zswpin == 0) {
> +		ksft_print_msg("zswpin should not be 0\n");
> +		goto out;
> +	}

Same here, we can check that zswpin is at least 24M worth of events.
Again, not a big deal, but might as well.

