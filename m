Return-Path: <linux-kselftest+bounces-12180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843DA90E020
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 01:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FAD287A00
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1E185E6C;
	Tue, 18 Jun 2024 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ol9kNRlN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61563185E5C
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754205; cv=none; b=lG83Td847+sSF80ZF76rvXXhn/JQFeLyj2qHmv8rKdklESNK9TAf9NWrcivNvwa8z4pKUWTsBgK66j/dbuFfKMV6oBHbdwnXF5OIVcam7P9fUBgfxTH5U5PAMi32jyTtm4SO94uB694tSzkc9meLo8ncXd62LkvbGEeerJXj0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754205; c=relaxed/simple;
	bh=JT0JNMECrMy4aw7rVvFRZG20IaWqJPqXWXGxA66HJeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4EPHkXOo8qJq9p2uMlt06c5tkpQt/vJiC++AihXJXonIuwmLLg4kou/PKucDy3S0FgmVWtizv6I/yGmrQxtdXA603TvkMMHO0Bi0D1AloA0pKg2fkyniv2J6yIsEdS86Lkj6owdsUBr03KgfoY6GmIZ39GlrOkConWF/abqOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ol9kNRlN; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eedf4ae265so13448439f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718754202; x=1719359002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9rdpOi8JxshyFAFLpU0e93AbZSOreFpEAXGG+8lytk=;
        b=Ol9kNRlNADQJOtPfcsG4RIDEu+bn9L+7JKSX0SdFlwA0YUIeCBaYg3KWREAaPfoGCP
         dMD3V+h079qFeBSWzPPO5edNqxLYX72fxwICjP9Q3REOhEt0zqqVTglj4mrF+voi9uz3
         l6tKkGnS6mfkiIM3eT/2dXcvguqYI8DMgUqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754202; x=1719359002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9rdpOi8JxshyFAFLpU0e93AbZSOreFpEAXGG+8lytk=;
        b=OHwPb+xqNHmX3hP8ZTn+Na9BHmKMkMPhOM0WFG05FJUZ0bsWNMPz+cRNYqYEPWx2Jq
         0AnzV3cwyWId8CkZcRtWRqy8ijXbIkiS7Xv78iA9DmCF9DdjzLzWVBTAT6upUNJCnC/R
         Z/kyLSDfJH8fYY7kWH3WSfz3e+3bN6Y0bgPj2DoKrjUX8cpLmnN39jp8m3+rZqsCF2oV
         JRPmQNu4AiQntX94OfIrTLrzzRAiHCdx45FguLatFe0CMDGvxeZom3PnMMMMo92c8ei0
         YU6V5Px8axSikFFr6ZuWHtFaPk5m2SsHRBcqg7CVJAoEyl4nRkfFl6op3zh2Ogj6Brpw
         FjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGLq7tM2aUvSEorq4ULRUecC54szdCRstOlMXhXWL4SMJUZDZPzuUGYiR66UX0I4slbDj/gep4H/ymTCENEJj3IKPYiXXWA1CU1wuJX/rw
X-Gm-Message-State: AOJu0YwB2tu89kRobmQIGDXJMiIcX9yFskQ9l0Q17Yu55sCoN1ta/wqY
	WxxlAlsWXW7SUSaTrgMPHDvYJ4QqXOZ5XMrRUyvX3ls+8w53J9iuHhaGfNRRANI=
X-Google-Smtp-Source: AGHT+IEgfEraUGp1/3xnWYLSv3mJ38I1Ff4QXvB7oYKTwoEfflkOmUybcJqiu3mfAAj807U7pdxcgg==
X-Received: by 2002:a5e:8e42:0:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7f13ee72e28mr135187939f.1.1718754202422;
        Tue, 18 Jun 2024 16:43:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569ef9d8sm3424643173.95.2024.06.18.16.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:43:22 -0700 (PDT)
Message-ID: <f28f4dea-f72b-4266-b415-55fed737d073@linuxfoundation.org>
Date: Tue, 18 Jun 2024 17:43:21 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Add information about TAP conformance in
 tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240612072723.4146613-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240612072723.4146613-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 01:27, Muhammad Usama Anjum wrote:
> Although "TAP" word is being used already in documentation, but it hasn't
> been defined in informative way for developers that how to write TAP
> conformant tests and what are the benefits. Write a short brief about it.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Update documentation by modifying and removing sentences

This described what you did which isn't very useful for reviewers.
In the future mention why you made these changes instead. Something
like "addressed review comments by <reviewer's name>"

> ---
>   Documentation/dev-tools/kselftest.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index dcf634e411bd9..f3766e326d1e3 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -228,6 +228,13 @@ In general, the rules for selftests are
>    * Don't cause the top-level "make run_tests" to fail if your feature is
>      unconfigured.
>   
> + * The output of tests must conform to the TAP standard to ensure high
> +   testing quality and to capture failures/errors with specific details.
> +   The kselftest.h and kselftest_harness.h headers provide wrappers for
> +   outputting test results. These wrappers should be used for pass,
> +   fail, exit, and skip messages. CI systems can easily parse TAP output
> +   messages to detect test results.
> +
>   Contributing new tests (details)
>   ================================
>   

Thank you for this patch. Applied to linux-kselftest next for Linux  6.11-rc1

thanks,
-- Shuah

