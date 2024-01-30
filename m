Return-Path: <linux-kselftest+bounces-3726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DF84183F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA72B222AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F933CD0;
	Tue, 30 Jan 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIFPOvKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFB2E40E
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577878; cv=none; b=NK0ABknkyN4YiQcn5mkFMHHfHLXMvAgLMztt33Qpj+Or1Tw66aPuuvQUDHa0koagUHWlf9YTJXru841TSiuqZfVz/Lm23svphMNUXi3wm8FLGYXVSFwS5hgEJRSLZUWiPy2lGT9nMVnd58tl605hd4q/uGbHS7g5G9eNCT9l1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577878; c=relaxed/simple;
	bh=j+GJVbuTueC426ARuRfLk+gzmDWC3BNHlZo/pA4JSTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DlV81eJoi0LQlgOQuDn6ipoHLcM8emJ670wA/oRTh4yEuixz/kGr2pINTafxMzYfnVQV9egE8CXa923dQ1wbgwuNdue0o11nIdnRRc4nUqG3QcVcatqMBoujPgFeb/2qIDVlt9rcaT2Qh5YT6MbVQvo2X+5c11hdaffuVkqu9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIFPOvKO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602d563287cso53516327b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706577874; x=1707182674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKsXe4d9eEU7eWHhf0dKSX3npO3wX+Yxof1zu2c6dBc=;
        b=bIFPOvKO/PiGZUcCID68Ss+DeTwpL7G42Yj9IOWzUpnWzbUnffpvjnjcnf5dapJbCO
         Zhhp+fAyoVXQkFLQ+xlHiwt0JM1IQPC7pKbM0cCVJyygcofGsvlNjEUdjzVRHv7/nKmA
         r3Wcl3ShXMR3a9qFs7or8bRAzVFyzTK6G1kRM9pZ0zICtJiJioYf3fyF2QkgHFWL7kMT
         mfSuk5Nnf9HFoUqq4d/D3YhjFYjT39RpDn2pLs23CZSB1vjE+NkEoNs0Sg9x9rJlH0up
         8uFUjNsgro/YWHB9mmasLzaiDXAX2efhNTYLyHnTQoq7bHyA/9R8FtfvTtMdEMTsYVwZ
         Ui9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706577874; x=1707182674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKsXe4d9eEU7eWHhf0dKSX3npO3wX+Yxof1zu2c6dBc=;
        b=dSoDOgrmZcGM8p30prNDkhVbQsftBUVVwsXf7cLVw8y7TyslDLUakLAGDoDtDeM1vq
         x3+nJT5Lu759Z/FxbC+pHhhbsMzprRTu2hc0msvxafSKJlvKSoD2H8UTAsBbVE6d5DwD
         Lopfo538o8y4/Jc+8E1tjJ/eQbyLz4Z5DMHDObFXCGxg6KmdsyZ7C47BwJm0BkX/t3Zu
         FCLrQ3oxj01qLDvx8iEAP0v+hgo4YlbtazJXh2Gau2+uQNxCQCPkkwj1h7G5h02PIpi/
         PWSCMNxujFINmw/4IV/m5eWupxliUyJnE18YJ5B3GVGAdm55K/oUhGwDumyw8NctjIIm
         j3Vg==
X-Gm-Message-State: AOJu0YxMwdYR4ZVegq76FWiAkFf+QKLjLcgv1kXzkCW8T+dtbL/FZaL6
	M3hWAQdn7tiJ+ymwPiR/bnrrlKZP/Xao6+Fsa0KAFjFgHMqc2jPKzncSdK5JYpHjSuSbkyUxu7U
	hT8V0jZllkbXMeseALw==
X-Google-Smtp-Source: AGHT+IGZLdTuoOjw1Nr7qvD+0vkkEzceltDuyoLOLKxYHKXc2jfBWkBY2f8WOz+VnouBav8ifONTd0ShyTcuOUOT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:10d:b0:5ff:96b6:8ee1 with SMTP
 id bd13-20020a05690c010d00b005ff96b68ee1mr2302301ywb.7.1706577874343; Mon, 29
 Jan 2024 17:24:34 -0800 (PST)
Date: Tue, 30 Jan 2024 01:24:32 +0000
In-Reply-To: <20240129224542.162599-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-4-nphamcs@gmail.com>
Message-ID: <ZbhP0JkEe39g3yqk@google.com>
Subject: Re: [PATCH 3/3] selftests: add test for zswapin
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 02:45:42PM -0800, Nhat Pham wrote:
> We recently encountered a kernel crash on the zswapin path in our
> internal kernel, which went undetected because of a lack of test
> coverage for this path. Add a selftest to cover this code path,
> allocating more memories than the cgroup limit to trigger

s/memories/memory

> swapout/zswapout, then reading the pages back in memories several times.
> 
> Also add a variant of this test that runs with zswap disabled, to verify
> swapin correctness as well.
> 
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 67 ++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index 32ce975b21d1..86231c86dc89 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -60,17 +60,39 @@ static long get_zswpout(const char *cgroup)
>  	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
>  }
>  
> -static int allocate_bytes(const char *cgroup, void *arg)
> +static int allocate_bytes_and_read(const char *cgroup, void *arg, bool read)
>  {
>  	size_t size = (size_t)arg;
>  	char *mem = (char *)malloc(size);
> +	int ret = 0;
>  
>  	if (!mem)
>  		return -1;
>  	for (int i = 0; i < size; i += 4095)
>  		mem[i] = 'a';
> +
> +	if (read) {
> +		/* cycle through the allocated memory to (z)swap in and out pages */
> +		for (int t = 0; t < 5; t++) {

What benefit does the iteration serve here? I would guess one iteration
is enough to swap everything in at least once, no?

> +			for (int i = 0; i < size; i += 4095) {
> +				if (mem[i] != 'a')
> +					ret = -1;
> +			}
> +		}
> +	}
> +
>  	free(mem);
> -	return 0;
> +	return ret;
> +}
> +
> +static int allocate_bytes(const char *cgroup, void *arg)
> +{
> +	return allocate_bytes_and_read(cgroup, arg, false);
> +}
> +
> +static int read_bytes(const char *cgroup, void *arg)
> +{
> +	return allocate_bytes_and_read(cgroup, arg, true);
>  }

I don't like how we reuse allocate_bytes_and_read(), we are not saving
much. Let's keep allocate_bytes() as-is and add a separate helper. Also,
I think allocate_and_read_bytes() is easier to read.

>  
>  static char *setup_test_group_1M(const char *root, const char *name)
> @@ -133,6 +155,45 @@ static int test_zswap_usage(const char *root)
>  	return ret;
>  }
>  
> +/* Simple test to verify the (z)swapin code paths */
> +static int test_zswapin_size(const char *root, char *zswap_size)
> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +
> +	/* Set up */
> +	test_group = cg_name(root, "zswapin_test");
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "8M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.zswap.max", zswap_size))
> +		goto out;
> +
> +	/* Allocate and read more than memory.max to trigger (z)swap in */
> +	if (cg_run(test_group, read_bytes, (void *)MB(32)))
> +		goto out;
> +
> +	ret = KSFT_PASS;
> +
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
> +static int test_swapin(const char *root)
> +{
> +	return test_zswapin_size(root, "0");
> +}

Why are we testing the no zswap case? I am all for testing but it seems
out of scope here. It would have been understandable if we are testing
memory.zswap.max itself, but we are not doing that.

FWIW, I think the tests here should really be separated from cgroup
tests, but I understand why they were added here. There is a lot of
testing for memcg interface and control for zswap, and a lot of nice
helpers present.


