Return-Path: <linux-kselftest+bounces-34238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB1ACCDD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3442173C5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794B221DB6;
	Tue,  3 Jun 2025 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rj+0GeOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E9221727
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980605; cv=none; b=f/mYAOwr3aozWwdYYOsr86a0Ti7PsXhYxFyqEhw7yC3prMKSa8KLdCfee+WvVluWW4LT5+3jX6PsmGUaw6RmwaW4sEFdPO0kwTqCMd7ht4ZQDycpW1+0RqGIlsWDn0Z0iJmVwPNSykZOsEJagpsxgQweRYAcc+qOl5hbaR2c1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980605; c=relaxed/simple;
	bh=MBHvsPqLN43xkFuBcIrA2Mx8sNirdLFvv+sbxgKdLnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjGLLR4w551uLCUu/aJqp76ncEsdG118y7m5QUcrbvimmuUXGV6vNUnYEZVQJKNea5rDjfISRfuujCdFdArFWzk2uWIButoBEFGuWpxUfLV1WYnDOaxY/EsPqpOSTkiaFl8rvIomX6+D/xTz2t6hhVb27IiNSDxSGGNcKKv0P68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rj+0GeOZ; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86cef0b4d96so139210539f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748980602; x=1749585402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5u6OWYlzDc1r2jn1fmfgfB/4o5raE1Ta4oX5ByxSCk=;
        b=Rj+0GeOZQGXMhYB6yNsBWlogkXQi9XRgqPc4mjxcmK6aBhkZOAivRg1OEfWX+Iy0RA
         WOVv2yRbolDY++vIqgO7Ftm9exoOfDChBYOqrAhjMTSwpPjZYUd93HYxLx30vzdjMcXF
         Gxd2It4ox7PHEUiZsYxQZ6ATIKoIpmePOr0jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748980602; x=1749585402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5u6OWYlzDc1r2jn1fmfgfB/4o5raE1Ta4oX5ByxSCk=;
        b=uAsvJXdEw15gTU/j3TNuBQvzmzzBh6ixAEsBEU0EsAWbKND+gE+qvkc6Z6U8HNwSBL
         2OzJkXnSA95M+Wly7WCTZmowRRpR5aU27MQy6Eu7bvwOv0ZZL/LGHoD9sNwU1VEErHqY
         G1vhFYTI3pATSBjh4FH/DPMmcAtmIdR769+I+7qph9C7KriTmPZ0odxRugPXlvHCCxh1
         8yskR52NR4SiIEnJ5ehgzK7bMYeiWCKNz7hOlyB5V1O5ckFoaXLtQdTZpXBq+V0mgEEF
         HL6NjUukIe45RJhLRmWnL92rVLmFPf2hjr6mBJqOa88fCSx4KEYiaGK4Zre4lIXEMkZA
         FO0w==
X-Gm-Message-State: AOJu0YyOE2m6ZsmJ/tcixxq1DDfpJKqA6J++3gtIA+vumVMr+652Yxi1
	ioXyWl2XmQ+ME+eTBeKx2yxRNvY+uf4g4O0A70+o7VxTDBvAK6/v4ru9GeGndaLvnHoLBWUKb1u
	N345j
X-Gm-Gg: ASbGnctSLyVJNq2gPoyNavqFiwdZ4WZGoA844Pt7eiUrEKAwAyhwgPOQCcbWXSLu6Ag
	uj/RqapICEwd4E/KskHI4YLQEGUWakzAYO5L7u6LZwBVQPsN9cNPIPYndsNXViIXH4eQQFR8pDB
	7JT6Z108z5dfWnKjn6WblRo1eYDIc2+eU9JgIq9q07hKXsQW7jBSNgUFbxerbjCwGrW4UJHx73f
	dcMLUfuij0OEdLjhUu+eUDP091ytRxkcVbZ240LDehBYyGTKECizKprpdH7BKd/id3qjDyXSomL
	sglxOK8zC8wYbWym7vfjU0um1ceuhTb2jHmJXflmSY+imf/IjIhb9diYQtEl+Q==
X-Google-Smtp-Source: AGHT+IFy5GLJWHFh8Lt3t78XkxeHDflX85Ik4jxEhVm2uHr2zRJEI/xgrIiCR4nT8+zefTt5WmNzlQ==
X-Received: by 2002:a05:6602:3f09:b0:86c:f3aa:8199 with SMTP id ca18e2360f4ac-8731c5d2a88mr36409639f.11.1748980602420;
        Tue, 03 Jun 2025 12:56:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f22536sm2472425173.134.2025.06.03.12.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 12:56:41 -0700 (PDT)
Message-ID: <328326d7-a72c-4fae-bd39-af4d89666a91@linuxfoundation.org>
Date: Tue, 3 Jun 2025 13:56:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add version file to kselftest installation dir
To: Tianyi Cui <1997cui@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250529003417.468478-1-1997cui@gmail.com>
 <4a28c302-b37e-4963-86c2-87c5793c2661@linuxfoundation.org>
 <11d3be92-a934-439e-be36-6d898b437681@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <11d3be92-a934-439e-be36-6d898b437681@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 19:13, Tianyi Cui wrote:
> On 6/2/25 3:48 PM, Shuah Khan wrote:
>> On 5/28/25 18:33, Tianyi Cui wrote:
>>> As titled, adding version file to kselftest installation dir, so the user
>>> of the tarball can know which kernel version the tarball belongs to.
>>>
>>> Signed-off-by: Tianyi Cui <1997cui@gmail.com>
>>> ---
>>>    tools/testing/selftests/Makefile | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/
>>> selftests/Makefile
>>> index a0a6ba47d600..246e9863b45b 100644
>>> --- a/tools/testing/selftests/Makefile
>>> +++ b/tools/testing/selftests/Makefile
>>> @@ -291,6 +291,12 @@ ifdef INSTALL_PATH
>>>            $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET
>>> COLLECTION=$$TARGET \
>>>                -C $$TARGET emit_tests >> $(TEST_LIST); \
>>>        done;
>>> +    @if git describe HEAD > /dev/null 2>&1; then \
>>> +        git describe HEAD > $(INSTALL_PATH)/VERSION; \
>>> +        printf "Version saved to $(INSTALL_PATH)/VERSION\n"; \
>>> +    else \
>>> +        printf "Unable to get version from git describe\n"; \

How does "git describe HEAD" here in this path?

>>> +    fi
>>>    else
>>>        $(error Error: set INSTALL_PATH to use install)
>>>    endif
>>
>> Why not use "make kernelrelease" to get the version?
> 
> Thank you for your attention for my first patch! There are mainly two
> reasons:
> 
>   1. We'd like to have the `VERSION` file written to to the tarball. This
> is because driver hardware tests needs to be run on specific hardware so
> that tarball is copied onto the DUT and we can compare the running

Okay - you want to save the version in tarball. No problem there.

> kernel version and the test version.`make kernelrelease` only print it
> on screen, 

This doesn't make sense to me. "git describe HEAD" also prints it
on the screen.

so we still need a way to store it into the tarball.

You can do the same thing you are doing running "git describe HEAD"
and create VERSION file?

> 
>   2. `make kernelrelease` requires the kernel repo to be configured and
> prepared, while `make -C tools/testing/selftests` can run standalone. As
> a result, I don't want above to depend on `make kernelrelease`, which
> may break compatibility of people's existing CI systems.

Yes "make kernelrelease" requires repo to be set up.

thanks,
-- Shuah

