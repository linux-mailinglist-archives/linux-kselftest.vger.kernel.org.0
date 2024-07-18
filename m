Return-Path: <linux-kselftest+bounces-13859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D19346D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 05:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04605284046
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 03:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C983987D;
	Thu, 18 Jul 2024 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SUCMD5rC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A038F91;
	Thu, 18 Jul 2024 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274377; cv=none; b=k8aJD6i5Okb78Xch7urmoQ08txSh0asJPXrgfhVDnctCb0AbuCIsSSD2PR3jiCRjlYXdNfszrm7pM3axGLLbgKbJUBRMFA2bGAxaarX5qaTI/1QClDA08Eo2t1+Az4FtIbZiklH0+IxQXqx0yddlDtsNwuUOyeIgf43Q12v5EUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274377; c=relaxed/simple;
	bh=TgyDblSb6DLChmBjwwEnBre4ru3uWNRP9SsYVOSJ+vM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fJpIRjXVMLZcMDb7eeXP72G2uyBfC0vZE1RDEl8S3ZYrr53EGWzY5qx5UtAf9oN4qAD1jExjRcABUyYIhqzFZkb/bhj4kQ9kjiHNA08UdAFXrWTL79lLaa/YJQqHtqfU5WDyY/ea4bUQrjI1Dmyvak0SZuYZquwu27aNrJX+uQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SUCMD5rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A52C116B1;
	Thu, 18 Jul 2024 03:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721274377;
	bh=TgyDblSb6DLChmBjwwEnBre4ru3uWNRP9SsYVOSJ+vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SUCMD5rCWj/oJLM3Ldv8h7XQMawBx92SJwIAPYTByVK2UJEpkBnkk3NSlYWo7z2mK
	 5EciqmWn1brjUmACgkQUojIOAvnG0c8isq24sN7BXmL+KxyrfEw4wsfd1ldjXPWM9y
	 eQ0eRniOpEft0u7RUfWjGy1rEeaipAvzqeEW/0sE=
Date: Wed, 17 Jul 2024 20:46:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] selftests/mm: mseal, self_elf: Fix warning
 comparing pointer to 0
Message-Id: <20240717204616.7a3d2465272d4f8fd1736831@linux-foundation.org>
In-Reply-To: <20240718031039.69861-1-jiapeng.chong@linux.alibaba.com>
References: <20240718031039.69861-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 11:10:39 +0800 Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Avoid pointer type value compared with 0 to make code clear.
> 
> ./tools/testing/selftests/mm/mseal_test.c:486:27-28: WARNING comparing pointer to 0.
> ./tools/testing/selftests/mm/mseal_test.c:1399:29-30: WARNING comparing pointer to 0.
> 
> ...
>
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -481,9 +481,8 @@ static void test_seal_zero_address(void)
>  	int prot;
>  
>  	/* use mmap to change protection. */
> -	ptr = sys_mmap(0, size, PROT_NONE,
> -			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> -	FAIL_TEST_IF_FALSE(ptr == 0);
> +	ptr = sys_mmap(0, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +	FAIL_TEST_IF_FALSE(!ptr);
> @@ -1390,13 +1389,12 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
>  	/*
>  	 * MREMAP_FIXED can move the mapping to zero address
>  	 */
> -	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
> -			0);
> +	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED, 0);

The author of this code chose to make it tractable in an 80-column
display.  It's best not to change that, without explanation.

