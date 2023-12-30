Return-Path: <linux-kselftest+bounces-2532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D78203E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4C1C20AE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A51843;
	Sat, 30 Dec 2023 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hE5CErlJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE24404;
	Sat, 30 Dec 2023 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703920671;
	bh=d1iZc91LabcnMVqjWAlFYm0XHTmeSnEeDR2JG77Ywrw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hE5CErlJG3Eniyw3kJTkZPVa7omSD2Ig6+aA5VgrEy3z0vkq4Ez7Rbo2OxxUTcXkb
	 4JFwL5vUqoXPacoLYcd/TycKljtJnf7pB5oF6TqAujgGPYS/50H9yXmXLOmSg7tE+S
	 mYxq09LroA5O8pJ3q8NT/cAEpaT2rVjychExSmJUjEy6wWjIFNiHFCoWLr/W540mk9
	 FcZug0qTq2zLB1pAvSBlwLNCBN8/4GlGFMQScI7Ez9ErGVQupmcagQCqg7TaurVzEk
	 jMbsBzvRakwt03Z3z+dFDXAOJl9UWTgPlLdUe99dmRCEjY8J9JV1gfmv000owWA5dP
	 PptrH5ANUBV0g==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ABBAF37811F1;
	Sat, 30 Dec 2023 07:17:46 +0000 (UTC)
Message-ID: <f80fafaf-41b2-4b69-a574-424c9de18fd9@collabora.com>
Date: Sat, 30 Dec 2023 12:17:49 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] kunit: Protect string comparisons against NULL
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com
References: <20231220155256.407974-1-rf@opensource.cirrus.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231220155256.407974-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 8:52 PM, Richard Fitzgerald wrote:
> Add NULL checks to KUNIT_BINARY_STR_ASSERTION() so that it will fail
> cleanly if either pointer is NULL, instead of causing a NULL pointer
> dereference in the strcmp().
> 
> A test failure could be that a string is unexpectedly NULL. This could
> be trapped by KUNIT_ASSERT_NOT_NULL() but that would terminate the test
> at that point. It's preferable that the KUNIT_EXPECT_STR*() macros can
> handle NULL pointers as a failure.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  include/kunit/test.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b163b9984b33..c2ce379c329b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -758,7 +758,7 @@ do {									       \
>  		.right_text = #right,					       \
>  	};								       \
>  									       \
> -	if (likely(strcmp(__left, __right) op 0))			       \
> +	if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
>  		break;							       \
>  									       \
>  									       \

-- 
BR,
Muhammad Usama Anjum

