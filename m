Return-Path: <linux-kselftest+bounces-10325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF038C803C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 05:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1961C21114
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411F947A;
	Fri, 17 May 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g61vNCLU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C120E3
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917274; cv=none; b=ilTooRyzRWQtgyDZO42tcvkF5ll+fCgaL6Ss6PNcKgv969z8dw18J9zzAF7ykTDs3OeDnZY9Adrbk6Nk8R1HGId2k9Hsj3xAr+0YO1Ntkb7AI5xTObysDJi1FCRv46dsasoJNMWgBAdKc2Du91NS9wOQBgrkyH/3ppGn3mACfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917274; c=relaxed/simple;
	bh=3BEGxZwtyF1vRM91ndh6CJUGdhhKMSU0cO7xHvcWCuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evRpRSDft8VHPxI64sJlGEWOKN0H2uoe8Nxf8Ptsu8RqkoSGcazs/MhYmf+k+7xR0gsZWaOzRHSSNYk+CERp91jPHHge55fdH1d+IVyfMaZ12dXZXVyR1LN50QHfHR07dOqc4TZ3P7cvJrIOMQ8QJqwUYwS8Hy477bePlZRSWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g61vNCLU; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36c2cf463e3so132445ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 20:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715917271; x=1716522071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUD5o9hcxRwEXEseJIOEUO2XCi0ciQLzvPwy0xSef34=;
        b=g61vNCLUtI4DaMY4P2HjvxZ4iXQkMVMWIduKqUKvGRKG3wTppyhap4c7QOcCNZqzqv
         zvqpranUpO1nhsjSoNkgqWlqVJm02WHtvn+eX1taRbLXI/Iy3h7M6DzC5WsJX3oRkR6e
         vrHXyU9h0ZOfLxHRu4AOwzDAEJ+KswwvRdwEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715917271; x=1716522071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUD5o9hcxRwEXEseJIOEUO2XCi0ciQLzvPwy0xSef34=;
        b=ZGbLWT9UqML6toUD5VAsbJOGnW4vIMHf8G26CMR37/K15hI6ifF7MBFDwmibHjjIJd
         orwr+UBu7Doz79S+7SBkwXot2pOaPOxy6UlXxb48wMUkbLW9WzQFE45uggTB5O/skIt4
         Hm2/XcV0DRvD2OxVopQzGbmjiQdSzn6eczexxKjnC8hyYqZI8GD9i36+bpHzeY1PYZxh
         2C4Rv7JQPRcdqYVSEd/o8B0Vcs7MoXOwzqKlLCAhzpRpsVguz2+mgpZ5y4sFZW772O2D
         kWrZpG6y/89XWTKsy4mJs8q7A6z0GKYXrZLqMFrTjn72r8dvzAXK8LKZomGXtBQxrTKb
         3csA==
X-Forwarded-Encrypted: i=1; AJvYcCV347/e/3uSI9JcV3kfhhZ/agalspnV0Bnogd0g2njBPtu2weNr1y3b+1Gmf/VGWznDBV4K6KEon03ADoB0/aUi0Ju6k/YefxMTV2hRKsaB
X-Gm-Message-State: AOJu0YxksAEY6JGt8fmqz8FZJ4Yc17Rn39Q1WLVoFJzYSfqXFiqCTL3x
	Rsq+Or5TKaFezlSK5qHd8B4q3Suq7vDKMEThAK2MJYK7TdozFxe8gNkRG44N7ss=
X-Google-Smtp-Source: AGHT+IFcXrgWJlCZ6P7vFvi1UcBpEELhM8WlYfhKGL33h/k68L9JMlaraBns2HkUqKkhtvBs+LoHwA==
X-Received: by 2002:a92:d348:0:b0:36d:b8f9:4f00 with SMTP id e9e14a558f8ab-36db8f94fa7mr58665275ab.3.1715917271478;
        Thu, 16 May 2024 20:41:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d98cf1sm40303725ab.45.2024.05.16.20.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 20:41:11 -0700 (PDT)
Message-ID: <24975952-b1fa-44a5-bac5-aef538ad0c09@linuxfoundation.org>
Date: Thu, 16 May 2024 21:41:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -D_GNU_SOURCE kselftest breakage in mainline
To: Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kselftest@vger.kernel.org, torvalds@linux-foundation.org,
 shuah <shuah@kernel.org>, skhan@linuxfoundation.org
References: <d33973a1-4d49-473e-99b6-f0a5174458e7@sirena.org.uk>
 <71d1f2bf-2e18-4adb-988f-665675fc803b@linuxfoundation.org>
 <d885eba8-8fda-4e36-af5c-38eefd6f0af7@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d885eba8-8fda-4e36-af5c-38eefd6f0af7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 09:09, Mark Brown wrote:
> On Thu, May 16, 2024 at 08:53:52AM -0600, Shuah Khan wrote:
>> On 5/16/24 08:02, Mark Brown wrote:
> 
>>> I'm seeing quite a lot of breakage in mainline as a result of
>>> daef47b89efd0b7 ("selftests: Compile kselftest headers with
>>> -D_GNU_SOURCE") and daef47b89efd0 ("selftests: Compile kselftest headers
>>> with -D_GNU_SOURCE") - thus far I've found that the use of
>>> static_assert() is triggering build breaks where testsuites aren't
>>> picking up the addition of _GNU_SOURCE (including stopping installing
>>> the other tests in the same directory), and there's a bunch of tests
>>> which #define _GNU_SOURCE in their code and now trigger build warnings.
>>> I'm looking at fixes and mitigations now.
> 
>> Would it be better to revert this for now and get this for now? I wouldn't
>> want you to extra busy work to workaround this.
> 


I determined the best option now is reverting the 3 patches.

commit daef47b89efd0b745e8478d69a3ad724bd8b4dc6
"selftests: Compile kselftest headers with -D_GNU_SOURCE"

"selftests/sgx: Include KHDR_INCLUDES in Makefile"
commit 2c3b8f8f37c6c0c926d584cf4158db95e62b960c

"selftests/cgroup: Drop define _GNU_SOURCE"
commit c1457d9aad5ee2feafcf85aa9a58ab50500159d2

I have this in linux-kselftest next now and will send pull
request to Linus this weekend.

Tejun, I made sure cgroup compiles after reverting the framework
patch and the cgroup test patch.

Mark,

Thank you Mark for finding the problem and sending in mitigation
fixes. I will hold off on your alsa patch:

kselftest/alsa: Ensure _GNU_SOURCE is defined
https://patchwork.kernel.org/project/linux-kselftest/patch/20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org/

There is no need to for the following patch

kselftest: Desecalate reporting of missing _GNU_SOURCE
https://patchwork.kernel.org/project/linux-kselftest/patch/20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org/

thanks,
-- Shuah

