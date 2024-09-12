Return-Path: <linux-kselftest+bounces-17848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D823C976E11
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12042824BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300F1BBBD1;
	Thu, 12 Sep 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmQvjpqN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062A1B9B33
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155862; cv=none; b=JhQHxso77het9RwC0nkx6pqFBkQOO8PfnYzazBGDpezJA2HkgRI2yGiXvqjjnuhi8C/uqVPkr1picpLpOswlv26btbVX2nL+4a7aiE3xjZuBN5vD5qhYeqA5wNQWWuiikfUO5Hzy5HtE444iETDo8daGL/lE5eQoZ9XWEz+wcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155862; c=relaxed/simple;
	bh=BIjqRB8ExX3XEMpofICKrApiJn7b9V8WKKgZqm8th1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpMSQ1CfDuKg7wEdWGHRZjpzW2hKDUBpMdENOO8MJQEwChuC/yZ88fdwzrdr1Ur3qddaIqEmBUVYUJ5tp1jIYWMuF9b8eycIvPOAWzTMjshTVZA98BI6oYtB9ATPh50Vb0NgGqThbT3NXxN7XwXaK0ea+NdvQLbUmeZodbtqZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmQvjpqN; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso52945139f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726155859; x=1726760659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xzJmJZir7SNhkzAEWBQK9iRI0VrPUIlmQ6Tc4M2oLs=;
        b=AmQvjpqNmPR7LdgktraFhKwjMaKI7xK/bIYoZcJEPdP+pHhaBFaCQGc3LusAHeOVgg
         fEsVP11BOjWDg24O4oqgG/sp9hTbhjDsPbXvwCOKPBMh41M+wqQWBTH3V6lfq4w0knNA
         RfOM/VhcC2XbViSKixDvycIvxVT/6Y7X/49aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155859; x=1726760659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xzJmJZir7SNhkzAEWBQK9iRI0VrPUIlmQ6Tc4M2oLs=;
        b=ELpDWc0Wkv344xg+AGs7dX4kYXlyLqSno/nz6S7E+ItKX7wzzLaEUxiCPIDZt8zcZm
         Y1Lyo7Laa/7Zeb8Aofom59p716IPPEiUrFEDQ7qRflmEl4mltRGxg13DHs+a51elwAds
         mPHmBj8tMcOkUl6uNb8fr90AkLGfEej9zIKVxgrO7/ySKjZZCBz/Oo9SXVepqo3dcH+1
         JMRSksxEOgXHpJKfU1Pk4zzCnEAWB/y1nvcinlSyOaeclw60RB3CmsjwjZN8Tm6U7qqm
         NhJBuHYA5izeDWLWJunWvSqGl3a8Sky5xt/RNdkIN1MaHfmEIuS4BpS9E8UFxEyniBkI
         5dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtmmh91zv/nOVNHhDaXDmOBkIf/hofnqqbS+o5rVYGZit8f8on75ZWh2Vkg3Dpz1L+Pzy6DFi94mthsm+s5C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIX84UdVTdqKk7ZTq+aPHf658RdU3dO+HZ0ZjnFi0mfekNSgU
	sEVitdnIWKT786s8Ti8VIMtYDLnoycayCnmYqR5CaNW703Hfwka2tsVQ8UoYyYM=
X-Google-Smtp-Source: AGHT+IG6esSlE2W6kArjZrA67ckcdnIzOt6LyndGjqyPFo8xbm61PKfZ5ht422I2fxHXzRSn5KH60g==
X-Received: by 2002:a05:6602:2d93:b0:82c:bdec:1c0e with SMTP id ca18e2360f4ac-82d1f8b3d81mr497735339f.2.1726155858844;
        Thu, 12 Sep 2024 08:44:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8ed815sm654814173.142.2024.09.12.08.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:44:18 -0700 (PDT)
Message-ID: <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
Date: Thu, 12 Sep 2024 09:44:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912103151.1520254-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 04:31, Muhammad Usama Anjum wrote:
> The value of __NR_userfaultfd was changed to 282 when
> asm-generic/unistd.h was included. It makes the test to fail every time
> as the correct number of this syscall on x86_64 is 323. Fix the header
> to asm/unistd.h.
> 

"please elaborate every time" - I just built on my x86_64 and built
just fine. I am not saying this isn't a problem, it is good to
understand why and how it is failing before making the change.

> Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index fc90af2a97b80..bcc73b4e805c6 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -15,7 +15,7 @@
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <math.h>
> -#include <asm-generic/unistd.h>
> +#include <asm/unistd.h>
>   #include <pthread.h>
>   #include <sys/resource.h>
>   #include <assert.h>

Also please generate a series with these two patches with cover-letter.

thanks,
-- Shuah

