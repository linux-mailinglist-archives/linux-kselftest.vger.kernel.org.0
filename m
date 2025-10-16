Return-Path: <linux-kselftest+bounces-43347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB93BE4E8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC761A62ECB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EA221714;
	Thu, 16 Oct 2025 17:45:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73A22129B;
	Thu, 16 Oct 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636705; cv=none; b=oi2EwefWUV+vWpd6AoyKEzIejn0hiz89NlYL+1kOMOhllXYWmcioDerl+m147M1tF3eJgp8VE+pUsKI2OZKAN1e8nHggnE4KRbqIn0b2IQxFlNn5ScDWj9jBFbJtNkBEBzgpM1v76Vis3+L+qS3K1s4hIieNIJCVQRv4PpxgPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636705; c=relaxed/simple;
	bh=ZjsupRvE0w4lygh8o8SXgqdPJ3vePjY+pR9DsG0ijvs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G8rw+p3F7Y0EctCukrEsdwLasBHR0caDNq8iFRObToXt40i0a9UX9mF7ZM/OBwyUCmY+UH3u9f40Zwalbcbckugb6YfdLAmSzOYFHl/sQzXuMJuKaaHBp+tR2eZ5f+Q4xJuJnqvqIz2KCmKMCvnAM0F3QbfrebnJRHaZK5ZgIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1001596;
	Thu, 16 Oct 2025 10:44:55 -0700 (PDT)
Received: from [10.57.35.229] (unknown [10.57.35.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9641D3F66E;
	Thu, 16 Oct 2025 10:45:01 -0700 (PDT)
Message-ID: <dbc6ec47-78a7-45bc-8df3-4f009731d302@arm.com>
Date: Thu, 16 Oct 2025 18:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: kunit: Fix kunit_device_register() example
From: Robin Murphy <robin.murphy@arm.com>
To: brendan.higgins@linux.dev, davidgow@google.com, corbet@lwn.net
Cc: rmoar@google.com, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org
References: <766a96de401a2c4361867144567bbc31edcf1a9e.1760535996.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <766a96de401a2c4361867144567bbc31edcf1a9e.1760535996.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-15 2:46 pm, Robin Murphy wrote:
> kunit_device_register() only returns error pointers, not NULL.
> Furthermore for regular users who aren't testing the KUnit API
> itself, errors most likely represent major system failure (e.g. OOM
> or sysfs collision) beyond the scope of their own test conditions.
> Replace the assert with straightforward error handling for clarity.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> This seemed the logical conclusion by inspection, but please do correct
> me if I've misunderstood the intent...
> ---
>   Documentation/dev-tools/kunit/usage.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 038f480074fd..3452c739dd44 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -873,7 +873,8 @@ For example:
>   
>   		// Create a fake device.
>   		fake_device = kunit_device_register(test, "my_device");
> -		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_device)
> +		if (IS_ERR(fake_device))
> +			return;

On further consideration, I guess kunit_skip() (as used in various other 
places) is actually what I want here?

Basically, as someone looking at KUnit with fresh eyes it seems 
intuitive to me that not being able to run a test case is a not a 
failure of the thing being tested, so shouldn't be reported as such, and 
thus this example stood out. I for one wouldn't want to be getting CI 
notifications to go and debug a "regression" in my code just because a 
runner OOM'd, for example :)

Thanks,
Robin.
  >
>   		// Pass it to functions which need a device.
>   		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");


