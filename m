Return-Path: <linux-kselftest+bounces-3926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178D84536A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E78288364
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995215AADC;
	Thu,  1 Feb 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi0HgEBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80415AABD
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778520; cv=none; b=SkDPzC77F2yCm+SnQH541cdzJeF+8R+gn6MEpfFIOJkw+fThfUDsVn+DJxh4YaHWYsmFNHzwKKKLHu1bZucR35hWw3kUmd2WoOxObvlEdGKymzUmI7WnMC14as21uxz+qLl8moIpluGrMwZQDlgjG+gkBQcjXJF0WvtYuZG3R1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778520; c=relaxed/simple;
	bh=ruPq2pvkVk8s24AfuKHQzLcgDuuIniLumwcZJ8iyy3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvGGDvV7BRQvNaehimTB7kgjo/ZoM5FbAJJXTCCHTjPThkW/JQod65ZzkbI4UgpaenfzeHxkQWh9iWosovwScMPT+YPqY5FzccIsGVSmHL75S0LFRrimEklLV5/qYgX8zI8oYAxdYthTDwI1W3YtYdmKjYOJuKVlDbma/DZooj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yi0HgEBy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60402c8d651so12472407b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 01:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706778516; x=1707383316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyPRSJB8R7sstDIzxYvvLOQP9nz0Xs4tmV9kMbdp44Y=;
        b=Yi0HgEBypSrfhcSIHIr19OeVet4Sd/Q20A6xGxzPj6qgBCLXCGe0iisIBZh0Gg/Z/V
         BqDBQ3VAxjO+9DGqoUmldOXdzfpYy2HR6lA/LHTqRAyIxcF1oiPnLXt2yesTEbWjgZYK
         nx+ORVSL+JJcbcwl216iT6AtKzulXobY85PHVHyNXuLS9uEQkeuCNYDjvP2Q1DP3cUlU
         jWQplqsag0enGZ0S9Nsu+YdymLDR5DwZl66/hCUScKYd2gQ2JatZB8xPcAfAifpw6nVk
         4MLqagyaLQEGzTeCFOLcnU2SfH8GOtnHZvCFOIrQzK3+ZcqnaK0n3xT/eGPQTkB7t9uR
         BfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778516; x=1707383316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyPRSJB8R7sstDIzxYvvLOQP9nz0Xs4tmV9kMbdp44Y=;
        b=kuoIo3V5IljdSyA9M+TTO6Jk/aQRlnQHKbBdHjmbLpgwTvdFXgHa1C7mY1rMPix14T
         bX0AjVSYTDXB1RcQbbqK6ZbUU0JPmIcGpBRm6OFSTSglIWj7bCnZFMmFZFOBKdpK0dUf
         6MiAYv4JX8FJZALjasVZXSER1p2nCMODdcYXNmx1WMvJfrBRvvih+913J82f0GxkLfDS
         Xk5pBlT25d3kMlG7uLGUe1TxzjP1D4hft8lqAAVvkO0sz9EtPPAnGt6uhcuhtu9oeNTq
         o6PMfzfXYNWMvQYzBroI0Nl5mW8Kezfhmat2M67J9VFBzwRF4dQ0vW0cC+HUf7N33hUV
         N12A==
X-Gm-Message-State: AOJu0Ywe+pj89WvDt9mYgXqhITdlMbnS87adJ0oYZdhr5SU5AbWEMLej
	pYMVHtY6CNxnDxNrnvJ/UnFfjeMkxBMyoICBcTGihXjStX6o2qrmn1BfFe3aWhcNQuA2FkT4mPX
	nlw6xL5RkLl2eqDb/Ig==
X-Google-Smtp-Source: AGHT+IEal3S+0/LT8L/+ihFESpfF3v8jase7MpGggk1/LchQ6suhlyF5F50sZ3ZPPJU5OFZDNh2MSLQST8IUcSCG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:ec5:b0:5ee:2b5:7d75 with SMTP
 id cs5-20020a05690c0ec500b005ee02b57d75mr276209ywb.8.1706778516753; Thu, 01
 Feb 2024 01:08:36 -0800 (PST)
Date: Thu, 1 Feb 2024 09:08:34 +0000
In-Reply-To: <20240201032718.1968208-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201032718.1968208-1-nphamcs@gmail.com> <20240201032718.1968208-4-nphamcs@gmail.com>
Message-ID: <Zbtfku0wVGXBHDTD@google.com>
Subject: Re: [PATCH v2 3/3] selftests: add zswapin and no zswap tests
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, shuah@kernel.org, 
	hannes@cmpxchg.org, tj@kernel.org, lizefan.x@bytedance.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Hey Nhat,

I have a few more comments, sorry for not catching everything the first
time around.

Adding Roman to CC.

On Wed, Jan 31, 2024 at 07:27:18PM -0800, Nhat Pham wrote:
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
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 97 +++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index 32ce975b21d1..14d1f18f1098 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -60,6 +60,27 @@ static long get_zswpout(const char *cgroup)
>  	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
>  }
>  
> +static int allocate_bytes_and_read(const char *cgroup, void *arg)

I think allocate_and_read_bytes() is easier to read, but I don't feel
strongly about it.

> +{
> +	size_t size = (size_t)arg;
> +	char *mem = (char *)malloc(size);
> +	int ret = 0;
> +
> +	if (!mem)
> +		return -1;
> +	for (int i = 0; i < size; i += 4095)
> +		mem[i] = 'a';

cgroup_util.h defines PAGE_SIZE, see alloc_anon() for example.

On that note, alloc_anon() is awfully close to allocate_bytes() below,
perhaps we should consolidate them. The only difference I see is that
alloc_anon() does not check for the allocation failure, but a lot of
functions in cgroup_helpers.c don't, so it seems intentional for
simplification.

> +
> +	/* go through the allocated memory to (z)swap in and out pages */
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
> @@ -133,6 +154,80 @@ static int test_zswap_usage(const char *root)
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
> +	long zswpout;
> +
> +	/* Set up */

I think this comment is unnecessary.

> +	test_group = cg_name(root, "no_zswap_test");
> +
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "8M"))
> +		goto out;
> +	/* Disable zswap */

I think this comment is unnecessary.

> +	if (cg_write(test_group, "memory.zswap.max", "0"))
> +		goto out;
> +
> +	/* Allocate and read more than memory.max to trigger swapin */
> +	if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> +		goto out;
> +
> +	/* Verify that no zswap happened */

If we want to be really meticulous, we can verify that we did swap out,
but not to zswap. IOW, we can check memory.swap.current or something.

> +	zswpout = get_zswpout(test_group);
> +	if (zswpout < 0) {
> +		ksft_print_msg("Failed to get zswpout\n");
> +		goto out;
> +	} else if (zswpout > 0) {

nit: This can be a separate if condition, I think it would be more
inline with the style of separate consecutive if blocks we are
following.

> +		ksft_print_msg(
> +			"Pages should not go to zswap when memory.zswap.max = 0\n");

We can probably avoid the line break with something more concise, for
example:
"zswapout > 0 when zswap is disabled"
or "zswapout > 0 when memory.zswap.max = 0"

> +		goto out;
> +	}
> +	ret = KSFT_PASS;
> +
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
> +/* Simple test to verify the (z)swapin code paths */
> +static int test_zswapin_no_limit(const char *root)

I think test_zswapin() is enough to be distinct from
test_swapin_nozswap(). The limit is not a factor here AFAICT.

> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +
> +	/* Set up */

I think this comment is unnecessary.

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
> +	if (cg_run(test_group, allocate_bytes_and_read, (void *)MB(32)))
> +		goto out;

We should probably check for a positive zswapin here, no?

> +
> +	ret = KSFT_PASS;
> +
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its memory
>   * limit in zswap, writeback should affect only the zswapped pages of that
> @@ -309,6 +404,8 @@ struct zswap_test {
>  	const char *name;
>  } tests[] = {
>  	T(test_zswap_usage),
> +	T(test_swapin_nozswap),
> +	T(test_zswapin_no_limit),
>  	T(test_no_kmem_bypass),
>  	T(test_no_invasive_cgroup_shrink),
>  };
> -- 
> 2.39.3

