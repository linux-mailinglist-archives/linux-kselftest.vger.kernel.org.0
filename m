Return-Path: <linux-kselftest+bounces-31816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F68A9FA28
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 22:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA0463006
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAD297A51;
	Mon, 28 Apr 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpkNZqCH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709717BCE;
	Mon, 28 Apr 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870788; cv=none; b=dHg+Qu1S3I2LucK1LUxx3bsHs1L2xpwkf0NElgT3vayHo8inATods1yLhBpec0R5QLmrGy/dkE4gJTQ6DJeDBQyZddZzTKXKWwnN7N3iUaRYDU6C7U3PoZFgCwNcdNARrL0esr2Rsf5yYvWtXVXdlJVPrGfF6xTrKt1tVQ3QSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870788; c=relaxed/simple;
	bh=JL45IsbMEvUYf3578oAfm2Zd40um3q1nclUnExaEMjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnNieZ5KDiVw8ItV+nItisb55vaz9o7pzWVHrJDSW71NFW3dgdrP8Em0F/C0JbP9/axkA5yHMdVGgatFl7gYG0izWkBxOwEmR10Bn4ZjWvcJj/9hYOod1OlkYU2+eTDtUpK7EOLseD+QhTkGn2yUq0Mswsfb5uN7gaXr0F6Eklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpkNZqCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFDCC4CEE4;
	Mon, 28 Apr 2025 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745870787;
	bh=JL45IsbMEvUYf3578oAfm2Zd40um3q1nclUnExaEMjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpkNZqCH6IYVHTPO1fgeVKsLENy91jyySTB+H50aC2cg+o/bXoWiRbAz/x3rsVkFl
	 3hvcr9NXo6gVfFhmAWt0eScvArmeDuopyB0AfIWLBTOU9Jz1QwvfLZJjzMWTXHUNBl
	 9jpEQTnjxcqhnTfSqyKAXJhbcyoSSzfW0WMzky0lQsYaI3gbRhTbjPNcsNiIeQvYXk
	 quFbECFCwoCMXiBLUZ6DsNzSfl60l1BaQ35iTorhrZaYggBusojNrvb8HRYPEUW9Og
	 2vbiFBxKbhVz+E+1FB/CuAIJzfMrLwktIN1XMklsM+zGGk/KGGJ/HgdupqSJwgg6ND
	 ARRXhj1tSO+fA==
Date: Mon, 28 Apr 2025 13:06:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Fix kmem_cache iterator draining
Message-ID: <aA_fwbubEEDjolYX@google.com>
References: <20250428180256.1482899-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428180256.1482899-1-tjmercier@google.com>

Hello,

On Mon, Apr 28, 2025 at 06:02:54PM +0000, T.J. Mercier wrote:
> The closing parentheses around the read syscall is misplaced, causing
> single byte reads from the iterator instead of buf sized reads. While
> the end result is the same, many more read calls than necessary are
> performed.
> 
> $ tools/testing/selftests/bpf/vmtest.sh  "./test_progs -t kmem_cache_iter"
> 145/1   kmem_cache_iter/check_task_struct:OK
> 145/2   kmem_cache_iter/check_slabinfo:OK
> 145/3   kmem_cache_iter/open_coded_iter:OK
> 145     kmem_cache_iter:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Oops, thanks for fixing this.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> index 8e13a3416a21..1de14b111931 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> @@ -104,7 +104,7 @@ void test_kmem_cache_iter(void)
>  		goto destroy;
>  
>  	memset(buf, 0, sizeof(buf));
> -	while (read(iter_fd, buf, sizeof(buf) > 0)) {
> +	while (read(iter_fd, buf, sizeof(buf)) > 0) {
>  		/* Read out all contents */
>  		printf("%s", buf);
>  	}
> 
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
> -- 
> 2.49.0.906.g1f30a19c02-goog
> 

