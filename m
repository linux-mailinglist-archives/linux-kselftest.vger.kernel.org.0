Return-Path: <linux-kselftest+bounces-11348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE490003E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C888B248F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BBB15D5CC;
	Fri,  7 Jun 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ajVnsIr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439215CD78;
	Fri,  7 Jun 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754576; cv=none; b=DkYHWYLvPzX2U3p095bmekmLBLseCeCpC4hNjMAl50SebzjdCRoXIZOIm+OXQlkFrIeWyeBs4i8wo6rUIDEHV5f7G3PLpeEwVUkJrXw2teD4L2iBiGnHv7FbgJrFptb5/+6d3csvHRx87ZLGqmTnqOHMGfmvN15dyJ6qB1Bm3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754576; c=relaxed/simple;
	bh=bQZfRikp0XaQ/p3RakIToc8GJdOFn84FFCuIKg/+PCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YWqyysvpqhkEq34V1A60BHLiZah2JZh7MGzdajpXCt3vWXNHF5H9Ffvj4H7PcaDuuU7mqVqzJKcN0rh6ivvlRiOdIO7nyJNcD5817Atnz1q6g2ehiZ44VpOqn86QJBdCJF9wjC1EYHDUzGPmPneaPcWhhBx32sCVMXY378mc6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ajVnsIr8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717754573;
	bh=bQZfRikp0XaQ/p3RakIToc8GJdOFn84FFCuIKg/+PCA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ajVnsIr8i7bbAzgO6uA7fVnMDe+6SYpx92/ThQ+tiItDTrLFGzqOTohjG/hOnNnb4
	 aBRZyEO9TZjpGzGJqC8J72AFms4HKjVGv7XJc/bdQbMLO/b4HEgcKhcqYwdCDoeRM2
	 1+D5Njj2ew3LG+3H+WVYrieod8zsS5N0coVQX7VxsrxwD1G4ibTda/WqffDKgoBR+u
	 GWjmXIYpP2k3vC4bT4iSCWYXZRto3qcG5jldjRQBup5COciitA5wGdik8tNEVfWLAL
	 VGn7xLFn/AsSJX6KfoRPvaEMeLz7s/Hi33Nb0ko7RaNS6mCvqFZqonwk/dusLSjRSU
	 /PZa5LHIWdcaA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CF78037811D1;
	Fri,  7 Jun 2024 10:02:49 +0000 (UTC)
Message-ID: <407efa7a-79b8-43ec-8466-8b2222f4dee9@collabora.com>
Date: Fri, 7 Jun 2024 15:03:23 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, cmllamas@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/2] selftests/mm: Guard defines from shm
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-3-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240605223637.1374969-3-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/6/24 3:36 AM, Edward Liaw wrote:
> thuge-gen.c defines SHM_HUGE_* macros that are provided by the uapi
> since 4.14. These macros get redefined when compiling with Android's
> bionic because its sys/shm.h will import the uapi definitions.
> 
> However if linux/shm.h is included, with glibc, sys/shm.h will clash on
> some struct definitions:
> 
>   /usr/include/linux/shm.h:26:8: error: redefinition of ‘struct shmid_ds’
>      26 | struct shmid_ds {
>         |        ^~~~~~~~
>   In file included from /usr/include/x86_64-linux-gnu/bits/shm.h:45,
>                    from /usr/include/x86_64-linux-gnu/sys/shm.h:30:
>   /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:24:8: note: originally defined here
>      24 | struct shmid_ds
>         |        ^~~~~~~~
> 
> For now, guard the SHM_HUGE_* defines with ifndef to prevent
> redefinition warnings on Android bionic.
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 034635317935..d50dc71cac32 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -34,10 +34,18 @@
>  #endif
>  
>  #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
> +#ifndef SHM_HUGE_SHIFT
>  #define SHM_HUGE_SHIFT  26
> +#endif
> +#ifndef SHM_HUGE_MASK
>  #define SHM_HUGE_MASK   0x3f
> +#endif
> +#ifndef SHM_HUGE_2MB
>  #define SHM_HUGE_2MB    (21 << SHM_HUGE_SHIFT)
> +#endif
> +#ifndef SHM_HUGE_1GB
>  #define SHM_HUGE_1GB    (30 << SHM_HUGE_SHIFT)
> +#endif
>  
>  #define NUM_PAGESIZES   5
>  #define NUM_PAGES 4

-- 
BR,
Muhammad Usama Anjum

