Return-Path: <linux-kselftest+bounces-6769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0889A890871
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 19:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB8A1F2417E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7D137746;
	Thu, 28 Mar 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewl3DB2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F752F62
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651336; cv=none; b=KaRVrapEChK1Y93ya6SLusaoAiMuCpKiV2SiSORRTCO87PckKNGgZpPzjgUvrgZhXUW17RoI9HZsZ3LyzTUxqt8NAfRdTJokUwKSO2bVkH3/aiJFyFi9e5DrigVME+STrJ7jh+vZr6YgJYgciw+RHbKyEC3wE4BsUTnxionLFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651336; c=relaxed/simple;
	bh=8yTekIG0Z2yIlKq0G56+dY2VrHhUCmwbc3p0S+Eyh6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6vYzOW8jO1rupy29GhaWbLYqf1EGpFKAfn6CFPpr0UXLZS+6cznmr9T8AKq9mTEPhptGaT6Lt29NP9n2yoq8II1X4GJecWo1T2VdW1gUVtLzCMIhsBn2mQ4YSNjBlpmtLW4ODScOKJ4R4Eo51eio4RiODQnkoD9nux8gXmj4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewl3DB2C; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366b8b0717cso1660255ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711651333; x=1712256133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJZy6XzF+M+z3gDLwuRgmmyGNjTRkpELLUKGZKjiEGk=;
        b=ewl3DB2Cf1VJpv+3cQWyndNa0hAxHchQouqxKlVKaOzhV2AZFOjFfs9S1a9/mQJvZe
         I3Hdix+hH1l8wmLe+fBTswiuA0WTfxzExqwUFEMttMWk6ZWwapet0qYDHQ0n7UfGcLB2
         JbjL1H1WWPkVVsTBg4g2uaboSwi2wghT6q3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651333; x=1712256133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJZy6XzF+M+z3gDLwuRgmmyGNjTRkpELLUKGZKjiEGk=;
        b=LEpJMFlNwf/22UwERfRK9BR70axhLxRuBPoDrghy4DHkcvtofstyNDy+JjXYjss5Hu
         qsO7GZKXyAJd5LqZXpDhiJfWRx08iR6vp0ztNfxcxZKKhPbiChfoxcsuitfGfu2NsYOv
         n+dmLHRzYbHRVCK2axZGIsBiBT+LQJwhF7DOQ47TTDxcty6p+EDfZelXuK+bu+Wi0Fe/
         2ZkPDEp/r1dIOpw6RvvXOdGe6QDQ4bFMwsOab8cgHUmdvmpfZ08Bx6L41vag0JeF9nvz
         qGnOCOr3Nahm2gFsTBMqVQK3HOvdZa9fArTrByv1iXq0hJDzazo7RLspDlcRxXiBuuyR
         qBFg==
X-Forwarded-Encrypted: i=1; AJvYcCWXO68//XslgR6Fwo4Pc3fAVjk5G5C1fgb/1RVm/NZirhIqrK0VwKHs+N5pnW3Y/Nawmmnoxo3NlVK+4iuG5GTlBLcq8t69dJd1a9kuJd78
X-Gm-Message-State: AOJu0YyKFgEyA9pbdyIVtpTkafO8bkbawrYn6TsXDEHbkzQbsrWt2QD4
	RVkGIGPzecsXR8wVJAMZIhEwGjDaEKfI1lBh4QLnNHhnpR5bY6Li29QqCfDkU5E=
X-Google-Smtp-Source: AGHT+IEPs+I7KZ45OLibFFl60nDnptka/BC8PT36XkjIpLFwzJ9mY8syrmn9bysPWe1yMUbihkcMaQ==
X-Received: by 2002:a92:d58e:0:b0:368:b289:38b9 with SMTP id a14-20020a92d58e000000b00368b28938b9mr4079695iln.3.1711651333097;
        Thu, 28 Mar 2024 11:42:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l12-20020a92280c000000b00366c4a8990asm568855ilf.27.2024.03.28.11.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 11:42:12 -0700 (PDT)
Message-ID: <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
Date: Thu, 28 Mar 2024 12:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327111720.3509180-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 05:17, Muhammad Usama Anjum wrote:
> Skip instead of failing when prerequisite conditions aren't fulfilled,
> such as invalid xstate values etc. This patch would make the tests show
> as skip when run by:
>    make -C tools/testing/selftests/ TARGETS=x86 run_tests
> 
>    ...
>    # timeout set to 45
>    # selftests: x86: amx_64
>    # # xstate cpuid: invalid tile data size/offset: 0/0
>    ok 42 selftests: x86: amx_64 # SKIP
>    # timeout set to 45
>    # selftests: x86: lam_64
>    # # Unsupported LAM feature!
>    ok 43 selftests: x86: lam_64 # SKIP
>    ...
> 
> In amx test, Move away from check_cpuid_xsave() and start using
> arch_prctl() to find out if amx support is present or not. In the
> kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
> backward compatible.
> 
> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - Update the changelog
> 

Thank you - applied to linux-kselftest next for 6.10-rc1

thanks,
-- Shuah


