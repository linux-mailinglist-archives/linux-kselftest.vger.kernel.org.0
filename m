Return-Path: <linux-kselftest+bounces-6667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7A88CE2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75AC1F6833D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486113D2A2;
	Tue, 26 Mar 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fovfPeXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13913D250
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484412; cv=none; b=mVbKUc5Dy5m9nQCAxqwLzu6YJ0yUbQ3Qz6YvvBTczOzrn2a03RYkSUfeYgnpBvbMfLWqqGhrcgHJCqbbHEJZHgFmbWTsvKaZg9YJ/ebVw+/fCU/DkrE72XOwMBchIt6IKB4ogimlSHudEsQwhLXeopsOZOTJPUY5Q5hl6E00w6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484412; c=relaxed/simple;
	bh=WdTVzGbYBU83Xj49U54/sNSOFS0096DdrMcZAb/ZR7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw9flsChkg1CDpukgpxJlCEgxYnCqUPXG4Q6xXlyHug00e7L1TrN+cUKxf7bXvMkh0+RbNn77o4hVp3Mg6EL2xDl3NwTIHP2+z2QK7T+z4XWvyDaS2bxWhJZdpsBzCPpnR01f0hHUDQTKFFZp1sjdWhIf1IwjfmC5rn3H4Lqljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fovfPeXR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc67249181so4679739f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711484409; x=1712089209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI+ANmKI38SB+G1ldu6RHNJOsvZO06CcYftV9TojULA=;
        b=fovfPeXRcryhHamnAEl2/k0J6miaesgO7xnx3VEOt17vdeWq7QX9Z1+HXYFvO4odSB
         F8V675eo8sbGHDlmUtZuPoPINScUsFV6CDNCHcIDW+UFvfv2UKP4F8IxAFKu8dAeSQUE
         hl5rQJrAIfRCfUtuVK08Ipmy5wu3SJ+iB+HfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484409; x=1712089209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI+ANmKI38SB+G1ldu6RHNJOsvZO06CcYftV9TojULA=;
        b=gFyu55kTKFmsRoVSNOfoSM4JBtT0ETFZtJyR7+OiUqCg6dNANpY/ZcusZN20O4l5QS
         qKRMsScwAW3LtwFJu/E+kIeU+N0alw15HBa8aZ6XiGtJfVXL9LLr6th1XcZmL4KovWh5
         E9rfH+dWMzCrwrr8SY6UwLlh9HpME0blaxQwNvqgIdN9Oj8XbJcn3qNQpWeJKbYh0zWn
         3g2H9x8ux1Jwk/ic+s657SavVJk3Vdc9lzN/8sIIvQ/+HbnLDj+/iJ69HLTmM7HJRrUL
         QNpu93b3eGS7ktuspTO1PeXOKDCnwAC2acpuU0nUCY7ZqAGdCGUioUJU23iwLYRvNvTI
         2pUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9CSeA7NW2WRVCzoF3tP5FnWMGDGmy9XXUL4aKJkKQofM0WetUvO+Upyf5hGvkTbocJdiocq+c5tPTMcgr0eoO1EcB0NugbiKMxDRwQDQK
X-Gm-Message-State: AOJu0Yz6ineeZ0YSKItUM46w+efIesVPmfZzCuMzKCzCRUQo+h8ZWNIx
	sp5G9ReNHrXQmm74XeCHK9ggHhm3iRnopsmgjNmCdNBjeyMOuACpAY3ITlukORw=
X-Google-Smtp-Source: AGHT+IEeYQSyK17YBl+U+tvoZOMjMKwL2UrahcoOzwyD1lTh7xUyy0SiAWRclW+KgU5X/fe3zma58A==
X-Received: by 2002:a5e:c302:0:b0:7c8:789b:b3d8 with SMTP id a2-20020a5ec302000000b007c8789bb3d8mr10366765iok.0.1711484409484;
        Tue, 26 Mar 2024 13:20:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y205-20020a6bc8d6000000b007d0648c020asm829969iof.49.2024.03.26.13.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:20:09 -0700 (PDT)
Message-ID: <91f2e916-2f90-4970-9448-09f821597083@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:20:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
 <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/24 13:17, Shuah Khan wrote:
> On 3/25/24 08:29, Mark Brown wrote:
>> The test results reported for the clone3_set_tid tests interact poorly with
>> automation for running kselftest since the reported test names include TIDs
>> dynamically allocated at runtime. A lot of automation for running kselftest
>> will compare runs by looking at the test name to identify if the same test
>> is being run so changing names make it look like the testsuite has been
>> updated to include new tests. This makes the results display less clearly
>> and breaks cases like bisection.
>>
>> Address this by providing a brief description of the tests and logging that
>> along with the stable parameters for the test currently logged. The TIDs
>> are already logged separately in existing logging except for the final test
>> which has a new log message added. We also tweak the formatting of the
>> logging of expected/actual values for clarity.
>>
>> There are still issues with the logging of skipped tests (many are simply
>> not logged at all when skipped and all are logged with different names) but
>> these are less disruptive since the skips are all based on not being run as
>> root, a condition likely to be stable for a given test system.
>>
>> Acked-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>> Changes in v3:
>> - Rebase onto v6.9-rc1.
>> - This is the second release I've posted this for with no changes or
>>    review comments.
>> - Link to v2: https://lore.kernel.org/r/20240122-kselftest-clone3-set-tid-v2-1-72af5d7dbae8@kernel.org
>>
> 
> Thank you for patience. Applied now to linux-kselftest fixes for
> next rc.
> 

Mark,

I am seeing the following compile warnings. Please fix and send patch
on top pf linux-kselftest fixes.

clone3_set_tid.c: In function ‘test_clone3_set_tid’:
clone3_set_tid.c:136:43: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t’ {aka ‘long unsigned int’} [-Wformat=]
   136 |         ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   137 |                          desc, set_tid_size, flags);
       |                                ~~~~~~~~~~~~
       |                                |
       |                                size_t {aka long unsigned int}
../kselftest.h:210:39: note: in definition of macro ‘ksft_test_result’
   210 |                 ksft_test_result_pass(fmt, ##__VA_ARGS__);\
       |                                       ^~~
clone3_set_tid.c:136:53: note: format string is defined here
   136 |         ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
       |                                                    ~^
       |                                                     |
       |                                                     int
       |                                                    %ld
clone3_set_tid.c:136:43: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t’ {aka ‘long unsigned int’} [-Wformat=]
   136 |         ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   137 |                          desc, set_tid_size, flags);
       |                                ~~~~~~~~~~~~
       |                                |
       |                                size_t {aka long unsigned int}
../kselftest.h:212:39: note: in definition of macro ‘ksft_test_result’
   212 |                 ksft_test_result_fail(fmt, ##__VA_ARGS__);\
       |                                       ^~~
clone3_set_tid.c:136:53: note: format string is defined here
   136 |         ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
       |                                                    ~^
       |                                                     |
       |                                                     int
       |                                                    %ld

thanks,
-- Shuah



