Return-Path: <linux-kselftest+bounces-37590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1DB0AB41
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0D0587B93
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7B21018A;
	Fri, 18 Jul 2025 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5DFOfRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438218E20
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872628; cv=none; b=YTWrJjESqdWchQ8+MoegLpeefF3QqBMCcRg6EcJqn+9vh2aRXMyqxkCgAMFfSbguCAlDRB1j1FhoqR+rlBsy3Qq8FX73j94BirjGJhmziKi3LH8FRodKjRWPfkzA+b7m/peCa2g/x690fpDh8K1m2K/ryUvsNxB3EV1U9r7yBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872628; c=relaxed/simple;
	bh=zzDMsAr4GKtcuWrnhtEidzhWRDh+qnVii9IM37m6u1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDVE4sWy/S2qJG5xWa/uNg9MLWgmVOWRE5Pm/DRnqDlP7JIYiyKoLgCRDlbKSRqt13vspkHewNWwolhpmf2z2dYg/6Ea6eSZQFY4WAzvVV3XxS5t0ujAkwHzUda37CqDj1Xq5TBV+T1zOcklNMuiWOI8AbjmeoltPa6dLhMsoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5DFOfRg; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3de1875bf9dso21747305ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752872625; x=1753477425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5QtuVUnIsXqjvxXCcqU+T0dmbm8qNp5jDvLDftyQas=;
        b=X5DFOfRg8vBu012kibh3JARLtXO/R3QgTDdtxxkTxkSvhqx4SFq4zu0qlvqKGj2RER
         HcoJvk0x6RelKuqnLdRrkf8AbnPRifbhY/kgbYzTz/XJsV/B38c+s+8yOXlQ/Lg8oqey
         E/vKKvrtaA+cXXWlbNw7tpM8axAnblhDHefD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752872625; x=1753477425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5QtuVUnIsXqjvxXCcqU+T0dmbm8qNp5jDvLDftyQas=;
        b=nhsnfPDBfspyC4HSaIBLEgQpEn1fGlClgFJE8pOOKKUaynPBtcLWnlTsG1gfsHTiUO
         a9j7M6uacuyHJWgMHDBn+/bJ37arIVYdM9sO1nEKbyuhHw9YKphv/3s+g9mNUZznZ4rN
         mpr59OfUrhSnlhCqKWUCP0/q6xyq/CZCKXQNYkHL8oU6+U967EetFgM5P3fn69iVA4fr
         YhyTud91GjKis4KwmRxuM6yrmQAkzsZM9PHX93NyslO9zEu74G9E7hvb1D/Tg6Zi9J0z
         FSeulBf1BuOZ9UC04JKiK/nEwdzAPIiAD5gclS+r+j5tdiHXRs40k+SVYyL1iHw0k7vE
         hnog==
X-Forwarded-Encrypted: i=1; AJvYcCXpt3mINbSUHJxvs8Fu+xzr7ul8LH3lyvJYHKmMKFkWbvjwbtP1MEdATVSRwLzr4XjSq92pCqKK+uJSUfnkJmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnLaMTJCxUB9NDmKPKhrbff7iYgGHEJEJn3y/ihtFna+WJ/Iz
	o8pR2hBTRaINP8QYMMZbv8vG/A62WheihQCqVEUWplMiJm2eQpHmZQ6jjvFMM/zTzDQ=
X-Gm-Gg: ASbGncu54hbfOsY8MT6FF1iFVoW8gIF0nKwixdOzNLaagS7LfJpkU/aLEfB99FyAI6d
	oGpjW6KPak5cLHto73KntzyR+qkxGwuIyS9T1qylVfIS+Lwiu3Is0SsF0qr1lYWATtA0vqxarQe
	1V4DlV5k2LzeOJEoEValDSayijk7PGa57LpXpnOm40OxGaP86PFKFg383VAIoeoq7zkfVedwFhf
	Nb4lwyQ8Hn9YERisV1+yQUzim3OHqO4z2pSLepPIldaK2rRCAHCpBIxEBLUpMzOrDTOuxL4edon
	7Qp1DPFeAfNB8Ts2bcjDVET4hfIfbjWbV4u+bYAd4Mp5NHNskdbG9CVZnp9ZHfdRpiH1thvOq43
	xvD/zwD0rzvB7doUi5Bb233k1sb/DOeTmbg==
X-Google-Smtp-Source: AGHT+IEOA9GEgGphdbPmdovYsa3GM3V4jtxaUIbKpm4MtRPTor5ojw9boEjHzikfUxMJUDj+Bfs+yQ==
X-Received: by 2002:a05:6e02:12eb:b0:3e2:a139:9489 with SMTP id e9e14a558f8ab-3e2a1399731mr2045355ab.11.1752872625057;
        Fri, 18 Jul 2025 14:03:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2982c9ab1sm6371975ab.57.2025.07.18.14.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:03:44 -0700 (PDT)
Message-ID: <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
Date: Fri, 18 Jul 2025 15:03:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
To: paulmck@kernel.org, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 17:01, Paul E. McKenney wrote:
> The pidfd selftests run in userspace and include both userspace and kernel
> header files.  On some distros (for example, CentOS), this results in
> duplicate-symbol warnings in allmodconfig builds, while on other distros
> (for example, Ubuntu) it does not.  (This happens in recent -next trees,
> including next-20250714.)
> 
> Therefore, use #undef to get rid of the userspace definitions in favor
> of the kernel definitions.
> 
> Other ways of handling this include splitting up the selftest code so
> that the userspace definitions go into one translation unit and the
> kernel definitions into another (which might or might not be feasible)
> or to adjust compiler command-line options to suppress the warnings
> (which might or might not be desirable).
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <linux-kselftest@vger.kernel.org>
> 
> ---
>   pidfd.h |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index efd74063126eb..6ff495398e872 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -16,6 +16,10 @@
>   #include <sys/types.h>
>   #include <sys/wait.h>
>   

Please add comments here about why we are adding this so there
won't be any confusion later.

> +#undef SCHED_NORMAL
> +#undef SCHED_FLAG_KEEP_ALL
> +#undef SCHED_FLAG_UTIL_CLAMP
> +
>   #include "../kselftest.h"
>   #include "../clone3/clone3_selftests.h"
>   

With that change:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

I am assuming this will go through Christian's tree. If not I can
take it through mine.

thanks,
-- Shuah

