Return-Path: <linux-kselftest+bounces-10688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A68CEDDC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 06:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECA11F219A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829E2F3B;
	Sat, 25 May 2024 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uLGOzZwJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB4691;
	Sat, 25 May 2024 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611569; cv=none; b=ZzBlo/i8hekd7YW8DGT6eKEP3KzYPZih8XTVQRYqjz/Dvysu9+o27fbtYn3CmdEOQsFU8483z3qLTsO5aLDF/+Lffv+TpdWdgaYNT/iOw/2U09i9YsT0Y2czEh4/hL9fGizpyARC5MSZTGKkims3+hXH66bJngZ0fDLHhEKA9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611569; c=relaxed/simple;
	bh=mla9/6MWVvFTkGR018Hqe//h65qdGPgHc26QyuTvYVI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l3DOlee1sXrW+d86fzRaOjIyYOdf7EOEjkhLLYDSfYVgAcrQS5NbcXR0NKORZryVkOnVa0AlnxRRue4KfnQy/OH+9Mp16Utjf5+8qMfe7vwcWTUjNv9W0GaeY0mdmfRvu434mr0IZ9JGi14fDKaWOtsJINs7QMRj9v/HPDwv8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uLGOzZwJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716611566;
	bh=mla9/6MWVvFTkGR018Hqe//h65qdGPgHc26QyuTvYVI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uLGOzZwJziYYaReuCZP41kdo/7KY1AqmQoffffhNZ/c2oeTog0OBD+2U+2gUDVeJp
	 LJTvzHVnCC2Sk9zwokxKWpWGvNUdNXak+uVoD8XHA1SAL5Fgg9DKJeSVXkgWQgRfKW
	 wJiGULnndLJTwK+lnU2hOXwCbNKGYWW/KBgldCiwY/NnJw8waTDDT2WLKXIRjXcqQO
	 S1M17y5E0rErqYsRHKZhOueljqWywQkLO8ygo99IlJFqBCbV4I8W3o3bCqgJwUjaLs
	 P7BQll0ZUDwY3wjmKob60wfKa1zexxjA+9401Gm2ue4eLd7woAH86b8/aCFspSkGCy
	 FChlupYiiFs9w==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 34D483782085;
	Sat, 25 May 2024 04:32:45 +0000 (UTC)
Message-ID: <94964224-1796-4610-a42d-3aacb4d47341@collabora.com>
Date: Fri, 24 May 2024 21:32:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/openat2: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I was looking at if we can add this flag for ppc64 for all selftests
somewhere. But there isn't any suitable place other than in KHDR_INCLUDES.
But there is a series already trying to add _GNU_SOURCE to it. Once that
gets accepted, we may add this flag there by removing the definitions from
individual files. But until then the current solution seems fine:

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

On 5/20/24 8:03 PM, Michael Ellerman wrote:
> Fix warnings like:
> 
>   openat2_test.c: In function ‘test_openat2_flags’:
>   openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
>   ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
>   unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/openat2/openat2_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 9024754530b2..5790ab446527 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <sys/stat.h>

-- 
BR,
Muhammad Usama Anjum

