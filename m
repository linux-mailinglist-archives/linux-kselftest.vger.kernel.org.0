Return-Path: <linux-kselftest+bounces-18242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044F97EF72
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D911C214F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344219F124;
	Mon, 23 Sep 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPu9a5dn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AE8821
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109887; cv=none; b=bbAGkKCd7U2W9URnW4SJ6yOHgFDEfst3twGz3NQZxThVCJKgymqWamiX3tpDeaZQeumPe+VfsAty35tBjam1XiAbGan0KJcAUIkoBFpbSnPkBWklapPqbm1P/Mi7cqYXVIpOFNC3VMcENr/ntJM/L43Ho6dzxpnuSB/XIz1yeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109887; c=relaxed/simple;
	bh=jIzpwkBvohPZ42RJk7QZSzfZGSTG+zibn9cWdNgkWoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THTajqif1BY33jzwL3+RgEsVkVh/eZWbeBpUojRo/LTfeloXPOZpQdFbL1lQTjcKcP6Y4ley6xIuL7NxxgTbQPQRYU+kWVVjD78NkkibjhVMM+eSsZEiM/nwoaM0JXQXDe8QeqIASSBfCxeSlkwRj4Au8N4V+fbV0y8Z9wUXrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPu9a5dn; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa4fd82a4so171463939f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727109885; x=1727714685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=aPu9a5dnInwWtxAExvIrXjHp0SgjGa+76XCYsAzod/b560stbR1JIWEwWEqUlHZVRS
         JlIGQUx/tL9H+mGrYA2ZaD/NYSCkh+rX50pSnzoe3HciTDXzgKffPCYrVo95rRMzLy1s
         WDU2VEou9kIkHyGp6gxV+srxYf6RfMc3j8N50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109885; x=1727714685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=bWdz3yaO6oO/FsTnUCXdgHvB0AsRf3720oRpElT1kAL5VvI5mOuBuCaVEcp5lLpbWx
         e8iwYkh3U6a2c4Fo923PdmvoVrrdF7xeCfrKOQdOdubPZUZI8cuh8Khc8ZYxqBtwFOVh
         dDZi2idWhu3X6+Je3vx0P8jgukwxFCab/JR9q6u24agVWlPiQYP5Xt4s8M/Shz5qkSBq
         YqcXkK9YOkkeTkmZ/3apyrYHof2U2M+Rfiv4u5OgopmomVHqMcsnK31i1fBHTE4s18IR
         jrGsFizR338UC4j9XSCjAY5Ty9NEG1PRR6yEjhQjZXDH3PyAliBsCSE1By6DZwdB6qHD
         5d0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVqKhUPUVVaL6v9NMusVMbBq4aBmQSny4s7xxo0Vcr7yvUujO6SjH0rakuxU+kpb4sVhF2DkyKxUkNRs8+z0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ6/zAueHXF3oKtaEgPN23909/cLOpFWWwGgoctbRSrhJi4Xv
	HhSSQPwQo5Q8a4kBjSTS5Kil06P1A60FIBdAq8jHPUcaLz44cRsr0cXRaWHdSow=
X-Google-Smtp-Source: AGHT+IFeE7PSHtYTy6cCbJSWJ5DjlBn+o1h78m0KFuLtOxLv7/WV1afXrTm5YCgUpVC62dLJGRMTmg==
X-Received: by 2002:a05:6e02:1a67:b0:3a0:451b:ade3 with SMTP id e9e14a558f8ab-3a0c8c9e4e6mr103481185ab.10.1727109885323;
        Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed597dfsm5222919173.166.2024.09.23.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:44:44 -0700 (PDT)
Message-ID: <6e71e7e2-5b69-488d-b3fc-e547d6b4b042@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:44:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] damon: access_memory_even: remove unused variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 21:43, Ba Jing wrote:
> These variables are never referenced in the code, just remove it.

remove them?

Add details on how you found this problem in the commit log.
Send v2 with these changes.

> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/damon/access_memory_even.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
> index 3be121487432..a9f4e9aaf3a9 100644
> --- a/tools/testing/selftests/damon/access_memory_even.c
> +++ b/tools/testing/selftests/damon/access_memory_even.c
> @@ -14,10 +14,8 @@
>   int main(int argc, char *argv[])
>   {
>   	char **regions;
> -	clock_t start_clock;
>   	int nr_regions;
>   	int sz_region;
> -	int access_time_ms;
>   	int i;
>   
>   	if (argc != 3) {

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

