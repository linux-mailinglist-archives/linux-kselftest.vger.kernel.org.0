Return-Path: <linux-kselftest+bounces-21244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139339B821E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC911282229
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6271BC9FB;
	Thu, 31 Oct 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZZsznaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7E19CC24
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397805; cv=none; b=NWpodtml4yB+Y4pzsVAlE47bXlRoA/2gnMlIVIHgQ0wC8q38if89ngVkn1UTlOcHi3fD7c+CDzlzDUNR0od8ijOZ/jo1aGmKhgRG96niZ9+Pr0TrAFKgJOAZIwSMHcooTwtVA7Z15BFRyCuxkn/HVJYaHnWdCGl/P6RE1MNh/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397805; c=relaxed/simple;
	bh=G8yAkXEkB7ESX+4dpwShN5jHc+uy2dh0rZ5h9auy8U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJnsFTkpZM2N4xyyyhNXqZrMCt3bShpR72DMDOLBm7ayCHJLE8W4qJPe/OiXtZ+djwGWWMvi9N+YdHemhl94ivuLx316/VdZ+kwzbl786tyJzdlF3hqKBa+55skIGLmegzpjeid9thTmjhMM1fGBQFBJ22g9GQKLgw4ZQmgyGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZZsznaP; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so45617539f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730397802; x=1731002602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqFVHirLhrZ+YFiVZAcY6QE2WmjZdVsPtC7OHYHxAto=;
        b=iZZsznaPmHhHghEOnY6GmD1hLfAhGuZIlpZtZVQgvjjOGDBd6kN5U4rsmjyB5lwnYT
         IjJz6ZVQD1/bcqMjvjLinLzg5Kuu1y/H+QZQ43wP9wpcuxEdH0Xcscbsr6bc5hIhj2fL
         iR+ib3nJA9dLZXYocVZbuna5pNASqiwZKYEn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397802; x=1731002602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqFVHirLhrZ+YFiVZAcY6QE2WmjZdVsPtC7OHYHxAto=;
        b=S+lAFs6nSIvzFZ8pzxY2AK6L64SGJnwEg/qrHJSzdJ7yu/fmPvKBQHG1v7YcXVy5H9
         j0m78d1lAflao8yYPm4XWGNShh/IY685JdqrMC4nF4C6FDTjRVmQ1Xtsj6e77Nn/sPcX
         OY9O1NZ4Ey1bZNWdlsJoptqu90x2e3FjMdzwgxoTmg3eOA6Layx8khBxNL3gR0BiB7zg
         jl3/5tul3Sh3KI0Pf13Mj+Bmyf6w9mblREglyrCIqOVFLTbJXq8iqgMTPhk2/miEb+u+
         UVtwIzlXPL0dcojwEZ/HcvFMnxdlL/ulC4DrvNiglEkyIb9VtTDqdsvzZsSh6HK0+nyd
         bPOA==
X-Forwarded-Encrypted: i=1; AJvYcCUhiBaZAfY8fVlwYQw0V0gcsgl1V8NJ3s9whfURAL5ro9QEhmjvrshNhAMHashrBowsuDMHmLjJVHAN209gBAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDauBLZ38z/RRLiXecdLS/iXrmge5Lc2uJlPbaOYbk5AQ+/eg
	IsdIeEBpollheygbC1YjvHONW5crvB6KabM0g38kxRJsH/NWuVHBz6XsGjJPAUA=
X-Google-Smtp-Source: AGHT+IE/2tMHtynRkwFoEe4g15eKesbze+UUZeNHxyrhBMlrKzOpbj1uiD8+ldwsn9EFl+/fSR/Tfw==
X-Received: by 2002:a05:6602:3fc5:b0:83a:db84:41a8 with SMTP id ca18e2360f4ac-83b1c4b4febmr2360267439f.10.1730397801962;
        Thu, 31 Oct 2024 11:03:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de0497785esm380041173.89.2024.10.31.11.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 11:03:21 -0700 (PDT)
Message-ID: <4703b646-3df4-43d3-ad75-92a38f5574c3@linuxfoundation.org>
Date: Thu, 31 Oct 2024 12:03:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] kselftest/arm64: Add 2024 dpISA extensions to
 hwcap test
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
 <20241030-arm64-2024-dpisa-v2-9-b6601a15d2a5@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241030-arm64-2024-dpisa-v2-9-b6601a15d2a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 09:34, Mark Brown wrote:
> We don't actually test SIGILL generation for CMPBR since the need to
> branch makes it a pain to generate and the SIGILL detection would be
> unreliable anyway. Since this should be very unusual we provide a stub
> function rather than supporting a missing function.
> 
> The sigill functions aren't well sorted in the file so the ordering is a
> bit random.
This is talking about the one that isn't implemented. Can you add
a sentence or two about the ones that this patch adds?

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/abi/hwcap.c | 273 +++++++++++++++++++++++++++++-
>   1 file changed, 271 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
> index f2d6007a2b983eba77a880ec7e614396a6cb1377..beb380bc09b0d07269a85a60e5d2977367740473 100644
> --- a/tools/testing/selftests/arm64/abi/hwcap.c
> +++ b/tools/testing/selftests/arm64/abi/hwcap.c
> @@ -46,6 +46,12 @@ static void atomics_sigill(void)
>   	asm volatile(".inst 0xb82003ff" : : : );
>   }
>   
> +static void cmpbr_sigill(void)
> +{
> +	/* Not implemented, too complicated and unreliable anyway */
> +}
> +

You anticpated "not used" messages looks like. I see that
this gets called - thanks.

Looks good to me. With the change to change log

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

