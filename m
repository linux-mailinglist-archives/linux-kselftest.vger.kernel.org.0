Return-Path: <linux-kselftest+bounces-21623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7309C0BF7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 17:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E811C21AF9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C46216A2F;
	Thu,  7 Nov 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMTzcpwK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD021621D
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998224; cv=none; b=RSwHh4aM0MWx4DqJi6mFGa9QzOkyU16IBnQIU8NkxeNl/lC1lXZaHDxWHybaIF7xsNHqOb8N73qt5teizHe75aU+lvtu6rIlDuW9W7+QRXvHBkhQypkIG8BUbyqm01v+ObIlGMdrXMuq5MrAsS3WOMV/lDf+qWPvhIqbXE95d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998224; c=relaxed/simple;
	bh=Go25yxnJIDquQSDueHhlrUidmW7oVvRZY71bnAVo97k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLDx9+QZ1FIVjHaxhaduDyYGuUYI31zTeZzKnbObWOrhY/Q7LFoQ0D0ZY40xJjegWBtexARaJQ6P9FK6yTrlYjmEh8FLT2ZZWAm2aAi6VPjieYSXaHIvc+OA2duhU7vtsVcEabjJoR+pVxdg1m9/j4ovHz9AwRs7MLW/ne3Om14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BMTzcpwK; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e60fca5350so724707b6e.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2024 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730998222; x=1731603022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nH0O+1ikWMG8QC8IE2A8+a7BT7IU8/OaYlea9rc3Ptc=;
        b=BMTzcpwKNJWqQTcwjJjb424yYXhNt7woiDldbRvWh9p6ZPKQ4ONVhKTDGlQNnvIkZp
         2eX7hleNs1CLbpFzBx87hQosRMPhbxBDG9MlAiqzoKshhYZb+yGjGvdbhi/gBsz3LYWP
         bMJGv2kQzhI69FXbJAKYKr+02SNK0/NmM1VSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730998222; x=1731603022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH0O+1ikWMG8QC8IE2A8+a7BT7IU8/OaYlea9rc3Ptc=;
        b=UEPBdtuYYwAtu+JdE3e98l6/McESIp5kIYDmobNMevjRRwW1nrCWN44yqya7lsKhOV
         PDHOcp4z7OPFr8cBVxyyT+mZPnEaCvubWqAaxHGvgXUAiXBENk/G4lJdsMkQDjKBIfBa
         +9iTeeOBs7I4qZ9C9fy7Sccvc4FpfZ94IOYktHUka27zjzPw0NuHVD2kuidE6Fz2HQvs
         WdQMwn47x7aJ15kRWUP608a9CGrSga98BicvEG1m6T3HNFJUgtad/a2+Fd3QBAjanlFU
         T3Pe8HYPYtkvPYLwzWrpW5l4DilA/YXzYzd/zpSTuCJPaWysvWaZ8ScseqS2yGd8BVcY
         P3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqcocrwhhRXvMRggyvfKyXRoCpf16nfr/cZe56s/7b1RmxKsOtFperJ23OWGNx295bcwCg/qC1WAWU1ZZ204=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOFf7jo3RXnLkPbtFKaFhHF3FvNsWB9cwLQtYfkjOT4WZ8YW5
	B9QMJk89ov2YnsWn7iKPjhQzMZ0kvvXBG+4/aKwGk0pXdhhlcG+8pabMo4UF6Cc=
X-Google-Smtp-Source: AGHT+IFyR0ojR5woZ+2sRiyIAtT6NrnlTxRk6o3IwcKgmMiBK8pN+bSw5rHmGwTuEAWjxtrJMD1uaQ==
X-Received: by 2002:a05:6808:338b:b0:3e6:2a7c:837f with SMTP id 5614622812f47-3e63849ee59mr41268395b6e.39.1730998221897;
        Thu, 07 Nov 2024 08:50:21 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8335d6sm375540173.74.2024.11.07.08.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 08:50:21 -0800 (PST)
Message-ID: <96cc8ce1-1f64-45d5-8567-eb2adba1b47a@linuxfoundation.org>
Date: Thu, 7 Nov 2024 09:50:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for
 pkey_sighandler_tests
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 yury.khrustalev@arm.com, will@kernel.org, linux-kselftest@vger.kernel.org,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241107131640.650703-1-kevin.brodsky@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241107131640.650703-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 06:16, Kevin Brodsky wrote:
> Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
> manipulation") makes use of PKEY_UNRESTRICTED in
> pkey_sighandler_tests. The macro has been proposed for addition to
> uapi headers [1], but the patch hasn't landed yet.
> 
> Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
> the build.

What does mean to say "time being" - can this be removed in the
future. If so please add a FIXME so this define can be removed
later.

> 
> [1] https://lore.kernel.org/all/20241028090715.509527-2-yury.khrustalev@arm.com/
> 
> Fixes: 6e182dc9f268 ("selftests/mm: Use generic pkey register
> manipulation")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
> 
> Based on arm64 for-next/pkey-signal (49f59573e9e0).
> 
> ---
>   tools/testing/selftests/mm/pkey-helpers.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
> index 9ab6a3ee153b..319f5b6b7132 100644
> --- a/tools/testing/selftests/mm/pkey-helpers.h
> +++ b/tools/testing/selftests/mm/pkey-helpers.h
> @@ -112,6 +112,10 @@ void record_pkey_malloc(void *ptr, long size, int prot);
>   #define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
>   #endif
>   
> +#ifndef PKEY_UNRESTRICTED
> +#define PKEY_UNRESTRICTED 0x0
> +#endif

Where would this be defined in the future? I couldn't find it
in any kernel header files on linux-next.


> +
>   #ifndef set_pkey_bits
>   static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
>   {

thanks,
-- Shuah

