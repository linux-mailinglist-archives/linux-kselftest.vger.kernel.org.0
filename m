Return-Path: <linux-kselftest+bounces-27668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C0A46D2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4397C16B6F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376C25A2C0;
	Wed, 26 Feb 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELirHwpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B052586CD
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604368; cv=none; b=chOP3kMToXzW/ovT9+fudHpdiKqbynBGtXek2ENoGVPicabCIBLvgKSNp1C0J9Xg9nNgD+uym4EtdDKxG2kHYyyANWeFuCYEuPFEuDTS51FTODm801UAGbjx6ZL+pvJt6SLlepwEDAgw6iDw37vqhqz5OQk6MQFeWFS55MIzu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604368; c=relaxed/simple;
	bh=a7D2XYmGoeKdz24VpbFVPzI8X7fRpawKWQ3rHB/7Fk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLG5UGQpQRzNt9Mn4T5vqwHh08VLUgWEXUTdh9rvkOOjOnv/Yu1AcF8IroXLZZpjn+1zs614wx82/lp4je12liR/sZqf4nXItFlLW4pWvdeklBpnj7fUgRGdkseOtCIiGhPELaLPcFFO5stnWXyj2UGUuuy5LmlRD01VbJMajQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELirHwpV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855b09fca35so16682439f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740604365; x=1741209165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzp4vdXBmVandIjCD1Ph9v4wYVEYC392IHskVG+hw1s=;
        b=ELirHwpVFWYsKNSXB3ZBKfx2hsFddLVs2ILPr9kqE0pr7PVGPPQf6+cEIv4pYv9geV
         jPcxRHYKWCzBPYmqHq1kAw6EQpgyjyDdMQWz6e6zkIOBsHnfpxWmjEfFOYC65pKuycbQ
         9m/KB08VBTTRqwZD5/lCX43Bk5jpf9IqUa1HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604365; x=1741209165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzp4vdXBmVandIjCD1Ph9v4wYVEYC392IHskVG+hw1s=;
        b=h5hdnbdR3Xz48/VQ0lhxHn5owMSPAZYgiMqi81tTwFBxGoqXqQ5wwwrBIRdQ1k3ref
         K5PTpTcNb+E25IMevQJ2ARMQqJnzWf6WdrDSmeQh3Bek0q3wbI19opRA9rftL8ujuKYE
         iDUT+VimvQmH9jmLf+/iXF/hYErer/t7gUK1Snotp/U48uwcPfNS4nL8LOgjCov69UQw
         TFPLOfhskjHZtsT7LB+Y4XWyQqmmdIkpPblzWOhWZtYgKgIGB08XBoXQhmliGoN5pVL2
         HJOUnlx/OikZk0l55WSKuvBzLoGEcgszelS7HGA3+56J9vT2tmmzscf46FJ5cravWSkj
         c2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW9aehhAsiIWRXbYIx7cteE6KkLt0wV2E9rW+g1OWnY+nF/QoDr9K/TsoHb0+Pu/U1aDzClA+iKdB2zolGN4eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYP6UEGNAmFjcPcPSB9OA5ijt6lIxjj/dUuAQuHDTZrBOwH06
	fdHFB34VCn610eXPA8sr83VVPOS13lxQYpUEw8O1N9lymYOi9p95yKu3FOzueVE=
X-Gm-Gg: ASbGncvvY/AWlExttZclnZqKC0GTmJ0vMy9kxrx9QQBZPOzUpRfIUIMOhfPjxw6v5VP
	tDcKMamNY9inTY+lD8jlgfDgviuxMoe5k99rqLNyGP5efQAb8Y0MUyREub7hzgFTPhXKms1mAZv
	9Y5bLdODpQ8h38tjXCI/BUaK7LHetQARnwmCBkgG5GkeVDrmsA+VaTuc4kgpTdu68yXOWin1Yg1
	WnwXY5WPvl/aVRPv9aLHjI211cui/m6kQekyhig0Z4ufEAzoBa14jqB2ZwDG4429qAXo0Hl0Tvw
	yBp65BS0sbmzLRD+E0Hd1DvRUOJhLzwpU5mP
X-Google-Smtp-Source: AGHT+IFsXTQa1QaEqW6angF6LEd2bWKQxCM0gljjbQUjyQ2/aOGSMQuuVwDAAa1K/hkVZRGORxpUug==
X-Received: by 2002:a05:6602:2d94:b0:855:bcc9:a8d0 with SMTP id ca18e2360f4ac-855dac845b6mr2369569739f.11.1740604365049;
        Wed, 26 Feb 2025 13:12:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-858753f0a0csm1013139f.44.2025.02.26.13.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:12:44 -0800 (PST)
Message-ID: <9abade09-4186-4730-b197-91d9fd622b1d@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:12:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Revert "selftests: kselftest: Fix build failure
 with NOLIBC"
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
 <20250209-nolibc-scanf-v2-2-c29dea32f1cd@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250209-nolibc-scanf-v2-2-c29dea32f1cd@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/9/25 13:27, Thomas Weißschuh wrote:
> This reverts commit 16767502aa990cca2cb7d1372b31d328c4c85b40.
> 
> Nolibc gained support for uname(2) and sscanf(3) which are the
> dependencies of ksft_min_kernel_version().
> 
> So re-enable support for ksft_min_kernel_version() under nolibc.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/kselftest.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index cdf91b0ca40fbdc4fb825b86d4dc547b5afa673c..c3b6d2604b1e486af5a224a11386f75fe0a83495 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -444,10 +444,6 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
>   static inline int ksft_min_kernel_version(unsigned int min_major,
>   					  unsigned int min_minor)
>   {
> -#ifdef NOLIBC
> -	ksft_print_msg("NOLIBC: Can't check kernel version: Function not implemented\n");
> -	return 0;
> -#else
>   	unsigned int major, minor;
>   	struct utsname info;
>   
> @@ -455,7 +451,6 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
>   		ksft_exit_fail_msg("Can't parse kernel version\n");
>   
>   	return major > min_major || (major == min_major && minor >= min_minor);
> -#endif
>   }
>   
>   #endif /* __KSELFTEST_H */
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

