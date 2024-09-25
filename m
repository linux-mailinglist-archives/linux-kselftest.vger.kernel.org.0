Return-Path: <linux-kselftest+bounces-18363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C9986590
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF882871E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2764AEF2;
	Wed, 25 Sep 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEp+GMnE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C7210E9
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285183; cv=none; b=Feip42mywzPEIQdYipMkGTesFdFaY0Rqkt8K3GLL4mka6iATmowRSiIHQ9fYzL1AJRui1hagzFFloY4dcZX/1wRIhQJiE8P11QTJkDoviOh5LNCxYSEOW7/Lzy62ZC9+1XASiFNErg+OG0r7zEv6aDh18YaIX79MoEoh8DtWwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285183; c=relaxed/simple;
	bh=S/MhFgcRKcARF4C/WkE2tB9txWJI/GeERMG8nD/tZck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO9sfiKK/+TunMzgybu8zlTL7bfDQqOTNvuFl14gaDPEmdR6IuyiY+0QjBH5JDMU9Z3CrdLBSU2+bxYDoieget/OK3mknnRs+y6CT6r4On2l9xsOv3r/RPglw3u2zRjegC79wYGc7svIa972LuKjpAzAIUWDSKvdh3pSXepJcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEp+GMnE; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82ab349320fso3384039f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285181; x=1727889981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsw+zRp/Ze7eW9+6epMJhd53fkKQRkg9ETNvRz5Ml1s=;
        b=DEp+GMnEaQdkwIxuRnR/Q4BUn+p0hZvjX3hJYuW7J2OaX0HuYCylpUGmbDDkH76DeO
         lDDKTb/cVv/+A0wttuGZI2VuytfETI6dYFA2FEzgEF+bqFaCUtvCQ1p+jnj+BvF30zKz
         4N94GA9MNoH63l871adHrqMDocKdPGecr+0Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285181; x=1727889981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsw+zRp/Ze7eW9+6epMJhd53fkKQRkg9ETNvRz5Ml1s=;
        b=aeraALF4JpKHlOXmCqCs6sw+o0Znagzd3d5yT6bphB29kxwl0W1NQplMAJRcnhNA0S
         NpNZm5umpfJ+C0LLNDb/DFV83voPWt04jcWVb372P4Rwng9b4IReHz8jBpc/cqnY4FOO
         e+B5TL/Qh9KAVOMqMr+XB4fGd70GzSoSX9kfJLOm6M1/LjuNQ7a2dF83HG0A+z7N0+CX
         qfmzZ3mLY4YI2R1G5Eg9Fh1p1EcsCtUdsYlaJrVdsUi3nBSEeqQYng2tRe2X/yEiKRW3
         y5dQGVFMUqjuhNj4WbgS3Z6w6SG+8Xz3oRzmrmT1qU6gXC/irwtCN6aPOG1xmNo03Cs6
         v5FA==
X-Forwarded-Encrypted: i=1; AJvYcCXHjb0YjrlNxjbKAva92snfUOzlFm8dyNaEQ7Ty5NbCv3GeCMt5tp8xyXM5fWse0AFCLHU6mMMxuvDoU5Gbxpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9H3Le0JOK6PHqZ7HMaJyEJZTM1S7KmJqG4XRn6XGKzIZbWvD
	0zHKrm6jd81a6/M0gF/R6s6r4DpmmNTgOHq4H1RmGP6UA9vHvmauBzvs9fLaPB8CeNuiyT7KbeF
	Y
X-Google-Smtp-Source: AGHT+IGmRIDkJ5EYcMz5zDv+p0A3MLFtNlRBHwMyJenq92Hsd1XC41WvVZMfEbFtv+gq53kcE8kOfQ==
X-Received: by 2002:a05:6602:2c01:b0:82a:7181:200f with SMTP id ca18e2360f4ac-83247d26137mr450776739f.9.1727285181091;
        Wed, 25 Sep 2024 10:26:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bcd9asm1181347173.95.2024.09.25.10.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:26:20 -0700 (PDT)
Message-ID: <3f0d12ba-0e52-41f9-9cbd-34bc1225121e@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:26:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Jakub Kicinski <kuba@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
 <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
 <20240920123827.715ff109@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240920123827.715ff109@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 04:38, Jakub Kicinski wrote:
> On Thu, 19 Sep 2024 09:51:47 -0600 Shuah Khan wrote:
>>> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>>>    	@ret=1;	\
>>>    	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>>>    		BUILD_TARGET=$$BUILD/$$TARGET;	\
>>> +		mkdir -p $$BUILD_TARGET;	\
>>>    		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>>>    				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
>>>    				SRC_PATH=$(shell readlink -e $$(pwd)) \
>>
>> Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?
> 
> I was wondering about that, too. Looks like the code from the all
> target is copy/pasted in the install target except the mkdir line.
> Best fix would be to make the dependency work, I don't understand
> why it doesn't already, tho.

I think this could be the issue:

net main Makefile doesn't have handling for subdirs. It looks
like the way this is handled is by adding an entry to the main
Makefile:

TARGETS += net/af_unix
TARGETS += net/forwarding
TARGETS += net/hsr
TARGETS += net/mptcp
TARGETS += net/openvswitch
TARGETS += net/tcp_ao
TARGETS += net/netfilter

So the solution would be similar adding net/lib to the main
Makefile.

Anders, can you try the above and see if it works.

Another issue - lib/Makefile
TEST_GEN_FILES += csum needs to be TEST_GEN_FILES = csum

thanks,
-- Shuah


