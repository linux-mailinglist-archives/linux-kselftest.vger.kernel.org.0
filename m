Return-Path: <linux-kselftest+bounces-6891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C19892454
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2594282231
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B410131E59;
	Fri, 29 Mar 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PkKa/jn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1557BB0F;
	Fri, 29 Mar 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740765; cv=none; b=ZUGzYuoxJw2d0myKoqadoFZrjnEQLlqWKOR1bbew4R5g22Cdy2tLgZwR/rfTMvCQ/hDxnHzAWr6gVpKz9NBs9DoYu/9FFf3Xxrir2uPsCmEh5cXZMx3V7VsYReJ3qyK+Pm02hCjOAnVSmHKwhSVrvhkBYItvTQgvpx+3XyteiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740765; c=relaxed/simple;
	bh=ABw+QBv24OmmzeZvXk5GjaZd8mv1dTdo+bCseQXgfLE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDPcQ7z1zE0R9CePW++PBAAtAKdoPTd221IFrBANkxFxeYqBAvE75C1700+2NSbmXE9XnOF6wwGKg6e2q9VPsIEP+USHiQ39H55A1Wk3O+2cZclcomFOqKZvK6EGWf6c6EROrp9i1xY/RVRGmUUB50mxX3BF+oIKGFujvU98kIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PkKa/jn1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711740760;
	bh=ABw+QBv24OmmzeZvXk5GjaZd8mv1dTdo+bCseQXgfLE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PkKa/jn1KWDEc+iH3q+Xazj6/Hji8DFGrvqM9t+M2HbjMYDX8Cgsiu4XuLNwNexrN
	 v+LS5EpkY9YXB+uut4ctWXOVx3hLwTVkUvOouwf3flCyispTiwguVA/EIUjgMzd7pE
	 m6ryqr7RHibXfsqpheOoMU4+B3Gi1Mpo+V2ETH8fbKKoOGA+jP46YAY0R/EQwguY+q
	 QPtECq3OQ/o163img4RyQH3Hs7zHoDX8NNUJ2wJvMzzRcYWdNS5f6/HOghYI9FiZlW
	 5TbkbfanCHx2OJF6RBV98ob5rAD9bNp/H9jYmbiupDR8ne4y0iAiTn1xIiKONs1n6m
	 kDSmnxE8jTVRQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 311623780C22;
	Fri, 29 Mar 2024 19:32:34 +0000 (UTC)
Message-ID: <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
Date: Sat, 30 Mar 2024 00:33:05 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: import strings.h for ffsl
To: Edward Liaw <edliaw@google.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20240329174236.2278217-1-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240329174236.2278217-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 10:42 PM, Edward Liaw wrote:
> Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fix
> map_hugetlb failure on 64K page size systems") imported vm_util.h.
> 
> Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
Why do you think this Fixes tag is needed? This refers to a patch which is
just moving code. It doesn't seem to have any thing related to strings.h.

Other than that, LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/vm_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index c02990bbd56f..9007c420d52c 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -3,7 +3,7 @@
>  #include <stdbool.h>
>  #include <sys/mman.h>
>  #include <err.h>
> -#include <string.h> /* ffsl() */
> +#include <strings.h> /* ffsl() */
>  #include <unistd.h> /* _SC_PAGESIZE */
>  
>  #define BIT_ULL(nr)                   (1ULL << (nr))

-- 
BR,
Muhammad Usama Anjum

