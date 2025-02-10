Return-Path: <linux-kselftest+bounces-26142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7CA2E390
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 06:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577037A37DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 05:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C219F43A;
	Mon, 10 Feb 2025 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Nk8l3Yxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECC18BB8E;
	Mon, 10 Feb 2025 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164944; cv=pass; b=bZ5c95HWQk6wVMVrCIh97owhs+JQwNy3IzXWNXKltOphVMofiqoqJg1uICbv3v6f6PJjnrz9KoRD/ITrWdY19vDYpyxTmzFu5UXwUY2FUP6iO402ITSmPBQsxc9u4vPEEhcUtRNO3u/fJSjajF6WrauW+hZj3Q0yjXNl+OeDOJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164944; c=relaxed/simple;
	bh=R0eBzRRFdeUOJgsEoBUE994luOouNUfEqzxR8MPtXU0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GuQoaR7CBN8WGEV+RK7qMIaoDP8fo0RcZ65G1RzS+4IyA9+YTpdHdxBRkpd6DxiaH5z40KvN3bZqmlsIQYepd38Gz5u+BzkJxsUtoxFxtaT4z9cbWRhTqkA6w9kPXIaa+GVum55NKhjYsLCNIeCCAJcLYbpA7Da5536FE852YpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Nk8l3Yxd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739164906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WKmHX2b6i1OdXX89VJx3mXatPfyAW9fmZWnWbHWD+xapjDMY/0ZlWWJw9360xlc5pip1arTzhNZCJ3KE9UZgTiTD8Ddbq4yTj3AK9ZkeiUx+D1sU2ErfSXoVxUFnsJhfVAoxcb6wD4gP3i58nYnB5UhUJtx8ED9ul0FpcaiPPNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739164906; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LZKYeceqEF9quM6A8CMj12KwUl60fxWcDy6hwWwYScQ=; 
	b=U0NHTZ783VuZXXd9HjHbxJRsFlAbc99aAOSnQyFXZnYvZ5/vlhue/xP/vQHp60ARAr5Ypk449mMqnzAWyqQDEnlkh4jrXS4JwVgFzfh0MZxDxZZaom8Ep2MEBwW9ezto/tN3Gjcgv6sROimpaFfjc6G3KY63I4VKxjWTv7vmxfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739164906;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LZKYeceqEF9quM6A8CMj12KwUl60fxWcDy6hwWwYScQ=;
	b=Nk8l3Yxd7gQHDLc+DnKZhXLIy1UPWk7RB4/KnqK37lO0x8JQpQm1VdcOfgZQZ73e
	sENxy1P25yej0hZVQkKxapJx5gCVWQ3938NyE1ma/FyQrjRRozwWTtsbC06Ai36v4Lf
	TClCBHw6h+FgfFKkuRyK04nquVqVq0Ghad4nqP0A=
Received: by mx.zohomail.com with SMTPS id 1739164903782624.1070733407311;
	Sun, 9 Feb 2025 21:21:43 -0800 (PST)
Message-ID: <3145dde7-0a34-4929-9ad3-45de91850580@collabora.com>
Date: Mon, 10 Feb 2025 10:22:19 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] bitmap: remove _check_eq_u32_array
To: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <20250207-bitmap-kunit-convert-v1-1-c520675343b6@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-1-c520675343b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/8/25 1:14 AM, Tamir Duberstein wrote:
> This has been unused since commit 3aa56885e516 ("bitmap: replace
> bitmap_{from,to}_u32array") in 2018. Remove it to avoid the need to port
> it to KUnit in this series.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  lib/test_bitmap.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 65a75d58ed9e..c83829ef557f 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -100,34 +100,6 @@ __check_eq_pbl(const char *srcfile, unsigned int line,
>  	return true;
>  }
>  
> -static bool __init
> -__check_eq_u32_array(const char *srcfile, unsigned int line,
> -		     const u32 *exp_arr, unsigned int exp_len,
> -		     const u32 *arr, unsigned int len) __used;
> -static bool __init
> -__check_eq_u32_array(const char *srcfile, unsigned int line,
> -		     const u32 *exp_arr, unsigned int exp_len,
> -		     const u32 *arr, unsigned int len)
> -{
> -	if (exp_len != len) {
> -		pr_warn("[%s:%u] array length differ: expected %u, got %u\n",
> -			srcfile, line,
> -			exp_len, len);
> -		return false;
> -	}
> -
> -	if (memcmp(exp_arr, arr, len*sizeof(*arr))) {
> -		pr_warn("[%s:%u] array contents differ\n", srcfile, line);
> -		print_hex_dump(KERN_WARNING, "  exp:  ", DUMP_PREFIX_OFFSET,
> -			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), false);
> -		print_hex_dump(KERN_WARNING, "  got:  ", DUMP_PREFIX_OFFSET,
> -			       32, 4, arr, len*sizeof(*arr), false);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
>  				    const unsigned int offset,
>  				    const unsigned int size,
> 


-- 
BR,
Muhammad Usama Anjum

