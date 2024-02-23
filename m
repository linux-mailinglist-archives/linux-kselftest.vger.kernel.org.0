Return-Path: <linux-kselftest+bounces-5384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4B861F4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAB5284C9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1D14CAA7;
	Fri, 23 Feb 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ca1Up2on"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF81482E6
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725751; cv=none; b=CzJ+1FX+LLtIk6QyJA0VidTE3i1lv+SsEGuQgF7VjrZh0e9knktkVSWIi4WmJvO+E9Sa1qsq7bKNkQB9r9mNSsx0u5Ao7o0yIvFzt3nEyTZMlhIyWlAlXOe+qmjiiJuh+ZfABXJ8X6m5sPbLQNGmDjrQ7jMVI8Q/2FVHMGi+RTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725751; c=relaxed/simple;
	bh=OxuxrEWZFLmd9bVvllL0cDqo3Qro+iCmjrAkC+i8LtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htsyB5DhDz4XxPwPQQflplsNqLQx1Y5/UD7Dn423yiVmSA+G5fDWz//uP58JZV6avqPmsGOuhPpTo/swgKQb024K5+3bEVIy7WZIYQ8gPQRYIc1NuBJq83hVs3wasxxfmmkvb8IP1dvZOlgsm3FyCaq2dD/kQ4LJbQmqoalRECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ca1Up2on; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c495be1924so20297339f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 14:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708725749; x=1709330549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dO5uxANb6KhoFhAZhuWxdF4f1WkNSLPqmHQVMIujpc=;
        b=ca1Up2on7z7dE4dtnBiWQCFtuo5LnkzSa7BdIj2/JFouHPDNantTY6AG3ajjNeszEH
         lPmhVSNNAuP0a6ZVjx/6RYIrckcdhSk30qfrJztMT/IjiTeSa6zPdST4pWyQoZ/PlBVs
         Q5BGIbSyr/6ovyNnI86NRXba7Gs3Fhl+819xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708725749; x=1709330549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dO5uxANb6KhoFhAZhuWxdF4f1WkNSLPqmHQVMIujpc=;
        b=tv1WfbO986ZkbWz3ocnoXvPcIpSptufsfTeD4jhKfZloTWb9W/6F7CsZs1PeUEvpty
         L2isee6L1HMRksE8VRDOhxO/MjNyKydmy9TMfEdI7xhoTv2Zr9pkWBjfvItBXNZxbd2j
         K+nMhgJfmGPkdeVAalrK/oOAjzpEYGkDXhXvLiwVN1A2WSGdYOAzvTy4ZreCuhMe2UxX
         DCGkyiEtA9whMtKuBj+EQrwYutcumwVIc6ZCkyuhG0hqoZ/kSZJhcAzwrcDhUtaOQz5e
         XKHe3NCTPv+KLVt79x9AlVpW/13cxjnXr6uI1hzMXU8x17naD1VyUbDmHy7ka3PP3oiP
         n9eg==
X-Forwarded-Encrypted: i=1; AJvYcCVWp392it2UPJhFmPvZbvqGbzK5KCHRfHbI8xVEp4zN9QV3AETUHifjOYZWCMXn+d9Uy0mLxq31ZflrLIxXdQn7NpfihmhYlKWGEYpBk7kz
X-Gm-Message-State: AOJu0YxqfNQGoAywNQlc/u4k2yYA90kux+kVOd1l4s39AXAc0dFGqFOh
	0g7OdZjI55cbN35dEvWDt9QxFX28A6WMYexAT4C6HuN5FXt8YVOWWoNjsNzN2Eg=
X-Google-Smtp-Source: AGHT+IERZo8E9m1EGVtoEcqCl+qpo29VVrQyzIz0yZSgzKLzC3fQ3HVY78TWD4zIJBlLjlYuudMkEg==
X-Received: by 2002:a5e:de08:0:b0:7c7:951a:a4cb with SMTP id e8-20020a5ede08000000b007c7951aa4cbmr1177605iok.1.1708725748777;
        Fri, 23 Feb 2024 14:02:28 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q26-20020a02cf1a000000b00471346c4225sm4015616jar.7.2024.02.23.14.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:02:28 -0800 (PST)
Message-ID: <8fe544e1-ac1c-4edf-81e9-fc0992b6bbc4@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:02:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest: Add basic test for probing the rust sample
 modules
Content-Language: en-US
To: Laura Nao <laura.nao@collabora.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, shuah@kernel.org
Cc: usama.anjum@collabora.com, a.hindborg@samsung.com, aliceryhl@google.com,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@valentinobst.de, Sergio Gonzalez Collado <sergio.collado@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240222162913.498197-1-laura.nao@collabora.com>
 <bb4c94f5-082d-48d8-9d4c-099375603f9f@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bb4c94f5-082d-48d8-9d4c-099375603f9f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/24 14:48, Shuah Khan wrote:
> On 2/22/24 09:29, Laura Nao wrote:
>> Add new basic kselftest that checks if the available rust sample modules
>> can be added and removed correctly.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
>> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v3:
>> - Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
>> - Used ktap_finished to print the results summary and handle the return code
>> Changes in v2:
>> - Added missing SPDX line
>> - Edited test_probe_samples.sh script to use the common KTAP helpers file
>> ---
>>   MAINTAINERS                                   |  1 +
>>   tools/testing/selftests/Makefile              |  1 +
>>   tools/testing/selftests/rust/Makefile         |  4 +++
>>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>>   4 files changed, 40 insertions(+)
>>   create mode 100644 tools/testing/selftests/rust/Makefile
>>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
>>
> 
> Looks good to me. Don't you need a config file for this test?
> Refer to config files for existing tests as a reference.
> 
make kselftest TARGETS=rust
or
make run_tests

On Linux 6.8-rc5 give the following? Doesn't look right.
  
TAP version 13
1..1
# timeout set to 45
# selftests: rust: test_probe_samples.sh
# ./test_probe_samples.sh: line 12: /linux/linux_6.8/tools/testing/selftests/rust/../kselftest/ktap_helpers.sh: No such file or directory
# ./test_probe_samples.sh: line 16: ktap_print_header: command not found
# ./test_probe_samples.sh: line 18: ktap_set_plan: command not found
# ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
# ./test_probe_samples.sh: line 22: ktap_test_skip: command not found
# ./test_probe_samples.sh: line 34: ktap_finished: command not found
not ok 1 selftests: rust: test_probe_samples.sh # exit=127

thanks,
-- Shuah


