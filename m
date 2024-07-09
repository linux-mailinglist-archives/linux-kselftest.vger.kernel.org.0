Return-Path: <linux-kselftest+bounces-13412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E592C6AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854191F22E2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13A189F25;
	Tue,  9 Jul 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwMDK9Vb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F60156C74
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568331; cv=none; b=SYq0/zhL+96ru+zzz5Ym3NFta/DuQ/qM7CeqgZPFhN64fna0k75rhrOOf8xUahu7kpg+aixRdCC0kEiHcKYYB2NQHlTIW7YFeFRnUO8TDIH2V7b6mUi47eB7hjwK4PH2viZlivGhg6TklrNMilzTWLTlf6BybGb+KqEm3fjfFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568331; c=relaxed/simple;
	bh=RuPp0plIUcm2hiUjMAHcgSlAPWRplrDAy68HI8id/lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESdoZx09QYJDU5XbM+iNJhGaDQdwE9nVT2SzCkyscY65p401cqkvQNen8Cv4qXkNZFpZGs6xrgr5rpAS/K13bITDqdVMCeVcuPBUWTLsle4U+QqTFe/klESaH0vYoGKVztWgFb578POhJkRI7yx3L+GlOMEs3p2+rYK6TMFNlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwMDK9Vb; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f70a7470d3so12805339f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568329; x=1721173129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiYRkS5dffbPdY7ESeU8dGrN5NK9uqhcG4NBsVwY9Uk=;
        b=bwMDK9VbqIguYIio6dP5yyoAlf6OC80HlVH9bk0vdfJLWesbgjvloJLO7uhg+Ijr4V
         W6B1Tc2fZ0vrPgKU73DqJN6NEFhkCk8HTcCcO0RkLqCxR6b/L04sptjiVXNpFMuzNTHr
         215nH01BCr8gkxZ2RO8VeHPWczqLzh1Dd2aS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568329; x=1721173129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiYRkS5dffbPdY7ESeU8dGrN5NK9uqhcG4NBsVwY9Uk=;
        b=e81uxS1QkkhATugkLQ1ORaw3K0DT1f3CLThVUU0Rkm3erXMc02fsKkhfTGn3mt3irS
         XLVOQYewyajCoU0rdB+br205rYpfeyDoYuJerYn7lA6KFHq4HmqVNDT6HKKBMwoZQqhP
         hlhMf/3t2ihP+5B6aRnXEnjzuqEh8uUgUpE6Zg0LAc5i7rmoss/ePLDIfeKQxY3w/Bba
         qyXZr7U4cRB1ZXKFkhjq1GSVvNCBrffVwxWY/8D/9+mknhl+IpjkEmDuafCVZC4adeVZ
         7i7oqhSJw4EA/mw2kkxL1U7NLvcoOb7giCtX3j8viGmfWRoL+TwoBy6on1wzjVf7IJHu
         YQjA==
X-Forwarded-Encrypted: i=1; AJvYcCWBw6sxwM8wF/QiqaoE8dhp0c932evB/U/wkUW06vg71ccx9sYUMVgCArsS1tkNQ7iezdagyfh6wdqAxozaaesfgIFzIjAiRLSDMTMx8tea
X-Gm-Message-State: AOJu0YyXYXAFuBCysGssjB9nXJ5eChcZaiv8q15MXHcpznNd4pY6eAef
	8hyFAH4kG5P2OTwgpq03FfOo1lDPwECWrLMCp7j83LW3cDTWYTY0kn9kZtM0Px0=
X-Google-Smtp-Source: AGHT+IHdB23dPfRVEiAyF1a/dxmrUpEj/oEeEquP9E9Sbqw7xQ+Zd1yKbrTTUgATJRc5BJA/NXcpLg==
X-Received: by 2002:a05:6602:3413:b0:7f8:bfcd:db53 with SMTP id ca18e2360f4ac-8000269672bmr455275239f.1.1720568329579;
        Tue, 09 Jul 2024 16:38:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c2b576sm764262173.177.2024.07.09.16.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:38:48 -0700 (PDT)
Message-ID: <6854f593-4607-487e-88a0-cd79b193077b@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:38:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/thermel/intel: conform the test to TAP
 output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702101259.1251377-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 04:12, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> The test has infitie loop to read the value of index_str. Break the loop
> after successfully reading the value once and finished the test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing index_str
> ---


Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah

