Return-Path: <linux-kselftest+bounces-23111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D79EB772
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FAD162D39
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE5233D96;
	Tue, 10 Dec 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fbNc3w+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281562343D8
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850534; cv=none; b=YC4eZpDNjhceaFNrGu9GTq1bBuo2OGsTZBlsQ/OkhmAs6waCb5HlIkRsxNHaQWD3JKhCNfi0AtiXSUro/CEbxpGMgkGolB04eYbv/g2begU5H4m51A5NHA5Hwoe1XLkKcWxfe7qgvyiEJkzCSwuwjyDcxN33RLGPI/dpNwY8llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850534; c=relaxed/simple;
	bh=vqnBy2TUzl5VEh6Ll+x+Xk8e1C2DbaIVDVhMQuQ/vzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i89IN8mk39/Q8EgkPXN1b5RflpH8mqmICHxwB4srGkKmdv0nQVIUx62Mxwm+ChEc+lwx9GCsYI4n+k9FLpI/2mXsrnQU09yE/9Uz2e4VyIGa7/GNlcA56fuklHJI6AdYc3936oEVRs/aF8u5SkQ2U+PNypAOYEUm/CoQz4m0V9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fbNc3w+K; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8419d05aa66so400264339f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850532; x=1734455332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=fbNc3w+Km/yqjUHcR4q0Yw23p971vs1gYm7T0EeLW8sDF0dExjAKQqp4P7N6RbF01X
         XdNolJsaUKonfeSuqix2Vl9Ffb8nBSyISOmNcIQp0lggxp/U+YnhJXLhOacxHg8yxMX1
         kikdLbqsPLEbWlgxEapR2IW52icNC9GE1/oUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850532; x=1734455332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5PJ17q8lD7k4hVY6ctGVVWNwOwWO51bb5PDCcKGo6o=;
        b=KsuypetFtRXxOh2wnTcvb3s/hp/V5zTwF9L7YKIwCejfOaXWcfxoO0e4SJ+9p+IXsW
         MuPwnL1b8j7e9kDvyKNz4n84d8qW3PehYLMtcWSHixciKxKfZXgBp6656v+3PM4ovMU2
         qWuw5/wg66sWlx0aA+FQzuMTuGfsLsvzdKzGbUfO7ym2M4T/W3+iYPg/IB2S3ZufDaJQ
         GkqtMaiNJHHBz8G+j+ym4Lcjd2K14t7eppAW23ySAzFBj6WJN/7xj+yiZUFTRdOC03Lt
         U4UBgaGom03YgXcQNpxxe8p+0lPyo9REJ/avBSnBCY40hMPpSztMaRbDPaKhRP7z5ESX
         h0Cw==
X-Gm-Message-State: AOJu0Yzjo1YRdCfapUSkWuGoe7Lm+G0lBeS1ybqYo6j5zLrg8q+DBxEP
	NbsbjVdoeiwQfuzpV8DUzF2HfPd3dmgP3yFu3Izp/UvY53w6T5+cceUW3GYNLCA=
X-Gm-Gg: ASbGncse1DGlwY7gMwrl6YWmkBn8kweixFWCxYw/i0YG+bBclwunRe/DkOH36jGnoZ/
	uzVyeDlsc5oNAXUwRdPFvusrbSEL2WXkS2gRENrnzKuO78+Vq/ar2OU/AW1xaDOv910j7q3GUzP
	fYDY405qlXU6DzOMKl6Kt07ZZHcbX+9yvkdoPJBJDwhWyMO4bT9oyRVTG8OO8wQB4o3tKUtgQk3
	oQZg9tvCT3+7pT98XawNnntsVKEm+4lmGeEQ2ep1r+yabQSfYiLUel8XXEZek+idg==
X-Google-Smtp-Source: AGHT+IG/gkZmbkJxGMdHnI+Js79ydu8p5QIVfUBfMDkz2ZNcb9kT6//CIdURU7BGEZClLOWq6Kg11w==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:dfe4:bd33 with SMTP id e9e14a558f8ab-3a811d98e10mr213572065ab.6.1733850532088;
        Tue, 10 Dec 2024 09:08:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ca310cfbsm701831173.152.2024.12.10.09.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:08:51 -0800 (PST)
Message-ID: <1e61303f-69b7-47e1-863f-1d52ac6c3ec7@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files and
 clean them in make clean
To: Viresh Kumar <viresh.kumar@linaro.org>, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
 <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 01:13, Viresh Kumar wrote:
> On 22-11-24, 15:47, Li Zhijian wrote:
>> After `make run_tests`, the git status complains:
>> Untracked files:
>>      (use "git add <file>..." to include in what will be committed)
>>          cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>>          cpufreq/cpufreq_selftest.dmesg_full.txt
>>          cpufreq/cpufreq_selftest.txt
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for next pull request to Rafael.

thanks,
-- Shuah

