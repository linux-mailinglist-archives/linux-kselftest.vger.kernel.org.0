Return-Path: <linux-kselftest+bounces-10689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F58CEDDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 06:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1800B282053
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F32F3B;
	Sat, 25 May 2024 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LQUHY/SU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E90BE4B;
	Sat, 25 May 2024 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611585; cv=none; b=R7jApHwhmQij685z+QJVl/MN4VPbwd8F5lnJtFSPvMaSUMR4x9WukjhHbHzixly26TQo/HsCHHbHEXHZTIUG2yAaNal0LyJxAVP/LIKN6tQCxqwu4QzpIVpws8TeuEiipqRZDXfptsCTCZfaxRRwkqfJShwyz+z50VVpAv7c9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611585; c=relaxed/simple;
	bh=VdZ3ZkVDoMmOUPpYGpxwg0tdv3KvlTxSUGRQXFANGLA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kjw7+weMJ6UindqGgQm/YtGdRPQ6pu87e5C/xI5akqwx4Oe3IbFAGLT1ZTfohEIfuAaG9lLF6mDY3wAGdagD2SCoG4s6VMPXnSWQGHmD2NTxVQJo/rEnQeEY1jkkSyMDCDW26BnXt5A07oLyyEyvoUjDvP2M7fbuiQazXKdCxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LQUHY/SU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716611582;
	bh=VdZ3ZkVDoMmOUPpYGpxwg0tdv3KvlTxSUGRQXFANGLA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LQUHY/SUh+v6SkttUeAbv2lyIGF2c8PC82u9hZ0d34n1qUhEYyuTfWcLusrsk87eV
	 TgumHvVVRCQeL8glSF0geZSTOCmAs/eyqNgimJFMk/ngjv5IbPqH5UbsDCQINgoZAM
	 gvtVf8odHwfozFmtIJaKICOtf+XfvfAnqg8P2//MSGd7Dpm9x9lxTohUayB8et8NxM
	 z678v0i2n2PH9okYSneaqB0F2Zv5QHYScxj3e87HnuaXNdW1HyWGqbkkydSBk+qn44
	 DA5Ckk2sQTkc+do0VPX9RJgcZZHwQuC06At3IIGrZtDHXTK1CiRGyFP+NpCiSsHXRo
	 UKh8ROJfEJLvw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A827637820A4;
	Sat, 25 May 2024 04:33:00 +0000 (UTC)
Message-ID: <c6a02989-b50b-4cb3-891e-a45be9391731@collabora.com>
Date: Fri, 24 May 2024 21:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH] selftests/mm: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20240521030219.57439-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240521030219.57439-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/24 8:02 PM, Michael Ellerman wrote:
> Fix warnings like:
> 
>   In file included from uffd-unit-tests.c:8:
>   uffd-unit-tests.c: In function ‘uffd_poison_handle_fault’:
>   uffd-common.h:45:33: warning: format ‘%llu’ expects argument of type
>   ‘long long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long
>   unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/gup_test.c    | 1 +
>  tools/testing/selftests/mm/uffd-common.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
> index bd335cf9bc0e..bdeaac67ff9a 100644
> --- a/tools/testing/selftests/mm/gup_test.c
> +++ b/tools/testing/selftests/mm/gup_test.c
> @@ -1,3 +1,4 @@
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>  #include <fcntl.h>
>  #include <errno.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index cc5629c3d2aa..a70ae10b5f62 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -8,6 +8,7 @@
>  #define __UFFD_COMMON_H__
>  
>  #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>

-- 
BR,
Muhammad Usama Anjum

