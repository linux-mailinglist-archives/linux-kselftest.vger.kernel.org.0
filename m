Return-Path: <linux-kselftest+bounces-2010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD581460F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 11:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C31F23544
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F51BDD3;
	Fri, 15 Dec 2023 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho64YXa4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1524B42;
	Fri, 15 Dec 2023 10:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D609C433C8;
	Fri, 15 Dec 2023 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702637983;
	bh=uVJe/DTjd8KQzGT75ENPY5rY557S9U+xVVo21+MUWRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ho64YXa4J0j5IN/OXDI+PqoCnLRNHzJ37iR3IM91OtCvs+V+BzOBIVogw7EGmomo+
	 0flnx6RBmP6oJzBqPgCf5Hfr42l9adpEkzjVeYKwd2CGqevKc6dYczirngVTRTieGf
	 9eymHer16CCD3BghBPVT/gkbQ9q4FIS/KHsWy7wx7d+gu8EpgZon7oipgD7uGUCGz+
	 c336oRnLff/rUQKMni9+7AEQk4qL4k7ZiTQhchtF7kuUrzUC2vkeBvNEwsRc8FeLGq
	 JCQUqgQQPSbu4mz4yRzTMHfYlBmKSJMlMcMgmFtVhaNTIOTJNqa6pNXcdPmQ1IlqR7
	 ZmO9LYK30DKQg==
Date: Fri, 15 Dec 2023 12:59:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kernel@collabora.com, "kernelci.org bot" <bot@kernelci.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: secretmem: Floor the memory size to the
 multiple of page_size
Message-ID: <20231215105933.GO636165@kernel.org>
References: <20231214101931.1155586-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214101931.1155586-1-usama.anjum@collabora.com>

On Thu, Dec 14, 2023 at 03:19:30PM +0500, Muhammad Usama Anjum wrote:
> The "locked-in-memory size" limit per process can be non-multiple of
> page_size. The mmap() fails if we try to allocate locked-in-memory
> with same size as the allowed limit if it isn't multiple of the
> page_size because mmap() rounds off the memory size to be allocated
> to next multiple of page_size.
> 
> Fix this by flooring the length to be allocated with mmap() to the
> previous multiple of the page_size.
> 
> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/memfd_secret.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> index 957b9e18c729..9b298f6a04b3 100644
> --- a/tools/testing/selftests/mm/memfd_secret.c
> +++ b/tools/testing/selftests/mm/memfd_secret.c
> @@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
>  	char *mem;
>  
>  	len = mlock_limit_cur;
> +	if (len % page_size != 0)
> +		len = (len/page_size) * page_size;
> +

With mlock limit smaller than a page we get zero length here and mmap will
fail with -EINVAL because of it.
In this case I think we can just skip the first mmap and only check that
mmaping more than mlock limit fails.

>  	mem = mmap(NULL, len, prot, mode, fd, 0);
>  	if (mem == MAP_FAILED) {
>  		fail("unable to mmap secret memory\n");
> -- 
> 2.42.0
> 

-- 
Sincerely yours,
Mike.

