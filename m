Return-Path: <linux-kselftest+bounces-30392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81125A8198A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBAE176266
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FB25522E;
	Tue,  8 Apr 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJMpo4gE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763F2505AF
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744156484; cv=none; b=mQo8HE9xHt3rKbtcNMOadAfT8uaYMhJOJ/+CSfRpHFvUoade1ZT+98/A9t1QmQ5Vf5CnnD2ey4yDl8FI4ieMcRHNiDnxFLkk7Gh9MXGBM+jxRp5yYuIBogF4hljXaIKsTRENsBzi28ln5gtWa+FNj4SBN/pDN8lvCisxalf3QBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744156484; c=relaxed/simple;
	bh=Jnx6PKKzCvL4p4g+uO/ftLP/ihvxn+++kI74c7ySLPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJHdM9IS0hCnh0dCBiNlX9GvBvTCgf8wQkYAnN531fPcFkPRMRE09Qzp4nuZTsO/21GUYqOvnS2F9O0nOHHp4x69Fk6sHI+7flC2m9CHMK7qhrOf96LjKdnpfKjaWdcaR8OerZnAvkrpSIzmf5wPHdMIiHeitb5w3u75b482GgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJMpo4gE; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e73562577so499184139f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744156481; x=1744761281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdRyBtliQ5cx07mISx4wCHyn5iramOMcxVolUqi92Io=;
        b=RJMpo4gE/CclGysCZHF4DFNZsSnXV4P4XuEjnWRUTJ9omVb675XMkP0rDKjJIXgGqR
         QLn7HxEEUlqjtQiIyOZ8RBMTzUJ/XQZB7BHuSY/olcc272F/Uxt+iYgdIMs3C+cSM3Xi
         0DvCjOUiR/VPa/tZwkgRPn6Dzl5/OVyDbKNeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744156482; x=1744761282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdRyBtliQ5cx07mISx4wCHyn5iramOMcxVolUqi92Io=;
        b=jw+9FquIALsY67T6xCKLQfDLrcV5VpdHHa1U3FgHqAw7ppe6jPf79UOVNsABE7RjNL
         T5FplWHfY0peCrNw4ViVhsEcSJfcprYIU5l5UaooSvsrlUNQ8H4hPjUkIYSMBGPmAzFN
         l8bi9PyyWAD03k8OSeZF1pA5a1sic+hB7UB72WwOLbXOMhmg5JsxBlM+GBDyfRQXQBRB
         7JkJAZZnjewV57IzSH/iflrl0y4ujFP+mJVInVqy6r/4oCVbF+JIlPbDUzJKlYLQt6bN
         53WQ8nmcbrXsSQEtF0F/HrDqPKiIP9O2Spal1ojHevJCVeoUNVVzLBYy2h3MnS1LGzUc
         Jy0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVjmJpZIWtxWKh45x6wIzQApwEeLKJeNneVzfeJYo7EOs8KZJLApjpARRtLVZI9kSmY9cqVi/pTmEvmMePXp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMVsRSeCBLSj/yYYiaCqndN+tLw/tv0guXba5SiNNm5+zhZvT
	mna7pyvWCqF0IvxHSnvVV55NX5hUsZibfrPmAZDk+W5Nl9teyqZ8x8FtQ7DefRU=
X-Gm-Gg: ASbGncsGRDbb4t1LLwuNPjTMVfdtZHi5VUuNTfTrggtLBdwGGLgD/Y14aIpRvEw6ZER
	vJySnnSYu+mwaWOVZHcc9viXs9SerDTNcHO42DZ0eaPVvg/rXelMnT9OsLvYW9m0MrHT16q+o+J
	UOuAnKQ/kheYqEx76pBdaWgTOxMg2+u5+TR0DsvLHJmxIIe0i0EejwoSC4y8UKzd3zXA6KGIY1q
	kk1dbMdVWq+jchddUBz/7RB7akAVTDBQLri9A4B3nueT0EHTnqYobEWNb+JPRoG35luLzk/sTh/
	+qyX1t3+zb1p+8MYVWvc+jHbE9mTA6nW3tH1Ds2hDmsBpxtF1wHOs0o=
X-Google-Smtp-Source: AGHT+IHrbk9mfKXAQeL9/yafdcqMUAyL8vOKCLUsGKcMZRbOPlFSarz6cufkOxtG6i0ALC59RzlGtw==
X-Received: by 2002:a05:6602:720e:b0:85b:3dcd:d8c0 with SMTP id ca18e2360f4ac-8616128f2f0mr132204539f.12.1744156481759;
        Tue, 08 Apr 2025 16:54:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f43bda91sm746758173.27.2025.04.08.16.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:54:41 -0700 (PDT)
Message-ID: <dae94ac2-63d7-419c-9bec-bea0840ea534@linuxfoundation.org>
Date: Tue, 8 Apr 2025 17:54:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ptrace/get_syscall_info: fix for MIPS n32
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Dmitry V. Levin" <ldv@strace.io>
Cc: Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 strace-devel@lists.strace.io, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250115233747.GA28541@strace.io>
 <0262acf1-4d3f-471b-bd56-4ddf8a2bc1a3@linuxfoundation.org>
 <20250329124856.GA1356@strace.io>
 <alpine.DEB.2.21.2503291345580.47733@angie.orcam.me.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <alpine.DEB.2.21.2503291345580.47733@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/25 08:02, Maciej W. Rozycki wrote:
> On Sat, 29 Mar 2025, Dmitry V. Levin wrote:
> 
>>>> +#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
>>>> +/*
>>>> + * MIPS N32 is the only architecture where __kernel_ulong_t
>>>> + * does not match the bitness of syscall arguments.
>>>> + */
>>>> +typedef unsigned long long kernel_ulong_t;
>>>> +#else
>>>> +typedef __kernel_ulong_t kernel_ulong_t;
>>>> +#endif
>>>> +
>>>
>>> What's the reason for adding these typedefs? checkpatch should
>>> have warned you about adding new typedefs.
>>>
>>> Also this introduces kernel_ulong_t in user-space test code.
>>> Something to avoid.
>>
>> There has to be a new type for this test, and the natural way to do this
>> is to use typedef.  The alternative would be to #define kernel_ulong_t
>> which is ugly.  By the way, there are quite a few typedefs in selftests,
>> and there seems to be given no rationale why adding new types in selftests
>> is a bad idea.
> 

It causes problems down the road for maintenance. I would rather not
see these types of kernel typedefs added to user-space.

>   FWIW I agree, and I fail to see a reason why this would be a problem in a
> standalone test program where the typedef does not propagate anywhere.
> 
>   The only potential issue I can identify would be a namespace clash, so
> perhaps the new type could have a name prefix specific to the test, but it
> doesn't appear to me a widespread practice across our selftests and then
> `kernel_' ought to be pretty safe against ISO C or POSIX, so perhaps let's
> leave the things alone?
> 

Can't this be solved with ifdef?

thanks,
-- Shuah

