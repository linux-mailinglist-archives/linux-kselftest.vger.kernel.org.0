Return-Path: <linux-kselftest+bounces-13999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C271D9393BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649D11F22081
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45417108A;
	Mon, 22 Jul 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSTUdhrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E717083F
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673728; cv=none; b=Z6uYUt0NmN1e3Z8f6OwBH8Y6jiquAtDUAxyCMKRlvSQEkGgoj/YMj3Fp1ppKULn3oRcH8gVBoMk+QerCBx+P9Evbk5G9SDTSx4z5nm/Y+BagFFyirI86NtymDMYcO0+ARHFl8pyF9OsltSfOhgN19HvM6eg1DSLp6cyKZdASS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673728; c=relaxed/simple;
	bh=0E1fNsDif3VQXgBcyMnbWqtdpW+WZ9QRELLlUphu3v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6BAdQLbXG6oWJLKwwS+4gHWFmkvb9gSmLkgMVGXXEtHY14oHUR6zwgxcbC68NYitPzOcvz6V//1+8qT4q6Tvy+fPhuCJfnDIJzfBjNcxCMqmlAka59mTMI4i0AqaZB7FHHwwojQwjt0gv5dGMJqL1orT4ea5QbWIKa/jr8m6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSTUdhrv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39905225cadso645945ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721673724; x=1722278524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fXwDk328PWlLbWRpQs1+cfkwX+2wF82ZM6SOq+7S10=;
        b=HSTUdhrvpvUIMO7Ob6rr4JCXcXbW7bw7zmgoLrNKrR+VIr8B4Vs9tAca0LACZ/uO6t
         9qwDuvQK/3sJ9aOWkQrdHejpAtrKhqKnAZmklmso7RXe+H0gyBtg5K4zWsNkVBNAn3aP
         C9om1LOgcVkqlAJpkA0DNv49LXN8anu4dIcHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673724; x=1722278524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fXwDk328PWlLbWRpQs1+cfkwX+2wF82ZM6SOq+7S10=;
        b=uxK7M7Y+yvygSurmbx54aJSjjywso473shR4DaKnnW3QaGW0BPdsV2v7OWHUAs+oV8
         9Qksn3dA9VM5ckFMx3L9F5GEM5o8lBgX87+4rIZZSuhPpJ7W850fD61MxGblGAjwdOXv
         todFb0gIwt8OuKH7gpnIJ4aHsJig5OxN4TR1nXa1sdWZ5UnVjIcN5BCupzdh/2h1npXL
         VNXKwAemLxYxFIU77I+o0+s173fzacNE5PM8N7WxR9he/7VZmIN3v1xfB2BlcXaCsx7Q
         gqz+WXlqL9Fc7FwMrbLbM4MepY3NtdE23awZJSVGMCxOT4uU1Q/iq1Cc6U6mObMt6jLG
         e+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWTR3KwTHXakwShhLj16YEcUvxtmxqlfcX0NkEtg1WDoNCDHuWOVDrYNZW57PhALv9AdqREm69XPV8bY8HE536/d431omeoFijoposG4TrU
X-Gm-Message-State: AOJu0YxhTWkcKF5kM8wSweJfO0t5L7ElUrpjA7FMBDscFg6f+IwEOKu7
	Cj1armQmi5VG8sP9w/RWBSUJrv+9fmvRXWz2FzevkszktSxqcL6Mo7RuoUO7pvEH9l0q7JR+kHE
	D
X-Google-Smtp-Source: AGHT+IFY4lRe7g4vBeCyqyzghwmKnXlwRNyo4g8Qu9oGXhbrhUa7NUUCi5GcqzC+1V3HqAjYxSLXKw==
X-Received: by 2002:a05:6e02:1d8a:b0:38e:cdf9:8878 with SMTP id e9e14a558f8ab-398e7446c00mr39082535ab.5.1721673724442;
        Mon, 22 Jul 2024 11:42:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-397f5c2b5aasm26785885ab.38.2024.07.22.11.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 11:42:04 -0700 (PDT)
Message-ID: <6f599bfe-3d54-4972-aa06-c987c0bb65b0@linuxfoundation.org>
Date: Mon, 22 Jul 2024 12:42:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
 <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 11:32, Shuah Khan wrote:
> On 7/22/24 09:43, Laura Nao wrote:
>> Consider skipped tests in addition to passed tests when evaluating the
>> overall result of the test suite in the finished() helper.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
>> index cd89fb2bc10e..bf215790a89d 100644
>> --- a/tools/testing/selftests/kselftest/ksft.py
>> +++ b/tools/testing/selftests/kselftest/ksft.py
>> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>>   def finished():
>> -    if ksft_cnt["pass"] == ksft_num_tests:
>> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
> 
> Please don't. Counting skips in pass or fail isn't accurate
> reporting. skips need to be reported as skips.
> 

More on this since I keep seeing patches like this one that
make the reporting confusing.

There is a reason why you don't want to mark a test passed
when there are several skips. Skips are an indication that
there are several tests and/or test cases that couldn't not
be run because of unmet dependencies. This condition needs
to be investigated to see if there are any config options
that could be enabled to get a better coverage.

Including skips to determine pass gives a false sense security
that all is well when it isn't

thanks,
-- Shuah


