Return-Path: <linux-kselftest+bounces-29897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E533CA75275
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49D31893E27
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E01EB5FB;
	Fri, 28 Mar 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hQM0nIaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D219ABAC
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743200623; cv=none; b=T9bTscPX7Y8mScqxzQvYDzJWh5IaVBJS2YNKLpKQlqwfgmrllIk9XF483aN9meQG6cAYocTlXdwnGPvweE5t2jsJKXGbXVyc/M524A3eX8Xdc58omucN/oqHBJCtywUeROgXPr8NhVtgWZAHxxseBJwNSRHo4Jn6ZpZ/htxGMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743200623; c=relaxed/simple;
	bh=PBsm90GoR7tViYFpdI3XnG8Uw+mKc6knBg1pKxFjQyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdRilQWaL5edo/0Edw/m9L26EKRy4BOth85I1ZZ2OE4iHJsq5ZpLBOBt38/FU3e1f1gGntkR0jlhVl4KcHRhNmwVP5Xc6z6U5ITjHxkrq8/swgPydpOnCyKrJ4lVQqkSVAya0S3DD7688d8a1ajHUiVyb7UJ77Ee38oqtRLGbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hQM0nIaY; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f556b90790so840392b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743200621; x=1743805421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoQ3CY/UbCxQ1vfYn/wDbcVOfLwRr7UamsFPY0WiHL8=;
        b=hQM0nIaYzPPhuQF3wK334OCbFCe3x3SqOuJaMsXb0tMhcmh6ulUI69Y0wgmsUv9lh5
         5KfxARtEWWE6EizApEMKsSPZ657myd8AGWRLgImqQe4rLH0WFO+ADqkwxBbAvZV2idl7
         fA2szaiHHAaM0vbJ223VkJBBtxSAcYQAiYac8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743200621; x=1743805421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoQ3CY/UbCxQ1vfYn/wDbcVOfLwRr7UamsFPY0WiHL8=;
        b=b+BmVp7jBYvzEo88ROlZ2V7bC5mYwWMTvc95R+GZOcbgifoMP6Mb0QaJjZ6pD34nOo
         MvCmm5DS72eSG3B4i1bgCW975ISofXfg6WGCCXrxRONPhHsiC6cTGWGgNb+vk3BYNb56
         w4M5maRU9GmUmfc476iyUMZ6qblcGNYb6cAotfjyQhYX7yRj7wGmVWy0zUu5os4mUxoj
         3kv6g8clRDaogoNRT8EDEdiIh/COBldqSvwEWkhUDMLRQs61HMbZOJXOmDGBZ5SW4xV7
         3W1TMuNjGy+jimpn0Po9lcYKtUOvYdrrp/N5gYv0QVL553ev4L1wA7JHIJEWgRwsMY5Q
         S5rw==
X-Gm-Message-State: AOJu0YymGgavf6bBBD+GQtZpVWptNWRHXO0nj3gwpWmk1ol6FEH2cx1Y
	NRtKDpmNGapTQfBqYKnzDOG+sbAt7Ia5If6m6EUs0e+U9Ak1ScQI92hXqXqxf//UGIweoytVp7W
	s
X-Gm-Gg: ASbGncsj+S38NogbJKSuMX34XJ4XWmo2dhptobVpOPTtAsH4L+maf65Xf+nn4ki+Yxd
	u8JziILcKWo/CV8O/J9vHP3qbQZZj8ZCV1/Q5lQ88RqvCi8NFNA4MDNMMUaAuSkWbbPVZ8p2fFA
	N1M8fU0OuJxnxuE5JkumUPAUaiSV3JydGMwTT8Yo4jWN87BdaSWMDMD1Pafm+K+hyZyG86Kkdi7
	Wa3daHe1KuuOr9kGuvoy5A0GOncyRcHurDqM9/a1rNQgIDjAWA9tkwWXNBcWd40/dIyTjI4gzYQ
	nmHEtH1RAa2sUc5b4zr+tL/IGxqT82/CrLhSkvzIrg/T4GCFZJp08j+Vicgh02YiOA==
X-Google-Smtp-Source: AGHT+IHIHEUmNn+Ej+d4DBj6F1dLhdjYv2M3oXqEOqrgsaGxua6hF4SIr5R7CXRXG+xJlFnyff5Nwg==
X-Received: by 2002:a05:6808:14cc:b0:3fa:bead:68 with SMTP id 5614622812f47-3ff0f3cfd8fmr535368b6e.0.1743200620648;
        Fri, 28 Mar 2025 15:23:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff052799b6sm513053b6e.37.2025.03.28.15.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 15:23:40 -0700 (PDT)
Message-ID: <76eb91c8-4c66-4e2a-8d32-f2e5d545bb74@linuxfoundation.org>
Date: Fri, 28 Mar 2025 16:23:38 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/nolibc: drop unnecessary sys/io.h include
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250324-nolibc-ioperm-v1-1-8a7cfb2876ae@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250324-nolibc-ioperm-v1-1-8a7cfb2876ae@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/24/25 16:01, Thomas Weißschuh wrote:
> The include of sys/io.h is not necessary anymore since
> commit 67eb617a8e1e ("selftests/nolibc: simplify call to ioperm").
> It's existence is also problematic as the header does not exist on all
> architectures.
> 
> Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/nolibc/nolibc-test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 5884a891c491544050fc35b07322c73a1a9dbaf3..7a60b6ac1457e8d862ab1a6a26c9e46abec92111 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -16,7 +16,6 @@
>   #ifndef _NOLIBC_STDIO_H
>   /* standard libcs need more includes */
>   #include <sys/auxv.h>
> -#include <sys/io.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
>   #include <sys/mount.h>
> 
> ---
> base-commit: bceb73904c855c78402dca94c82915f078f259dd
> change-id: 20250324-nolibc-ioperm-155646560b95
> 
> Best regards,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

