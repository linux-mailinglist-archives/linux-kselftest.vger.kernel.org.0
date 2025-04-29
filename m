Return-Path: <linux-kselftest+bounces-31964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE940AA3C4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 01:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38269A0BA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B102DCB4D;
	Tue, 29 Apr 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvOjz2Z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2E25F794
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969591; cv=none; b=HlMu//q9KKfVAazwquOs3tdRK/YoLQ6F2ijwwq5pO8+t3oZZ+BG6oTuxt659Vp5nxJpZTeknmqcxvzT7iU9wF38KAU3/rjGKhbcX0HX/DQvmZDPNmyhVJ6nSv8IF2z1XwNaYOkKmzWLXWbmlMyZAqPpZMAqSh2lpEltTi6hB4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969591; c=relaxed/simple;
	bh=91lQyvhQ0vUeR2C5rjMPbLayVwhJTn0+N8ztV6/O+FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMX4w3aJOxubJCV9f00iBEODN2h+vG85AC2gTcM5CPhqBTmCZFwS6+oWyzffivrzwHuETHRmGSDDT9zKfKdKbA1AZRn5Ljsxkh8siNQBstSvzXrzUwZmPiNpOhtunubvWP3Tg1BmHKjdCIWMYpDiMv5W7SIU35oPLwX8uHkMFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvOjz2Z6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so29652935ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745969587; x=1746574387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57VBGGVBY85MK2UKVXxeo+EoMCdb9fTe1GaMwG8NQ00=;
        b=XvOjz2Z62vKzRHJ1GfxUhlkG3jS/VRjAY2VIOgqSyZilWjplmYeE53Db7viuRjL6c6
         eOrcu5fM+5unfQ4ty9Dm6OYlI7J3C/eej/8cKvYjx4CF9TIB/OlO1S5/mg5bQYdPLW8h
         UZZ9khG30C3crwfmvY8SunPMacIi1jDIV+TA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969587; x=1746574387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57VBGGVBY85MK2UKVXxeo+EoMCdb9fTe1GaMwG8NQ00=;
        b=KvDSIMsb9T0riYYK5Uem9KqgdG4+0PUi7V3MCUM4q7ia9DOztTXHtSr3JQh9a4XqG3
         zl6S9SGEELRCP7ow9D+UYiazgTFsTxRSLti2emwddA0p+7pyadYpnJvyQdtVFpC5kHI5
         7FLU0GztskEnDLEQcnnlotnNIlYFq0g9Vt9M7NIJzBeImk/BWpc1IdE6Uxu/xbJDQqk6
         Gu3ktSGX6voiQZF3FTunEqzmI+NupuDaD9uP5uYaXgPcFKfHjseItdVmZl7KvBFKycSA
         4KN6vIFksAoaVm0eXgbQgcJpV3VagC97GxSEQvq9KZztZYGza6r8ARZnH8orKrG2JA0R
         Jljw==
X-Gm-Message-State: AOJu0Ywm6kxwLN85N8r8BN/aSGRzcLS9KkzW9ylT0SJbE3VmqO75n8JY
	lRTZcEI8ss+TiuGDeJOV7XMZWnnpYnaYMCcVs+oNyH/XuzhQmwdsf21wFJHPTk4=
X-Gm-Gg: ASbGncv7Y6X3E8FKK+KoQiylUiCN4A1KzsQdQv2zljVXzW4PoDJlqWGQaaahbg2F2q+
	rmqMQvsDLU2zunM4IRA5TGkin8npQAXZ15kHawZU4vyK006cyNWUOdYCGV3JRDJ9nobTgkvysYw
	LR5tSnPmcC6s6E+ME7Q+HV8yTRpfixzf0i5mPotdkH/kQaAXlh2LkB+yCZ5NgJAieAVMuoAX6U7
	K5P3vGoZbIG6YEz5HbxYMa20R43IuYMS1pCj85H9X85IsJMTtQkLxONElaay4UndLlR/TUmm9uW
	tOIGEEIPfsuhToQR0arkJvVHZdPNHPbuwehd9YkIgXj4hS7apOI=
X-Google-Smtp-Source: AGHT+IGmi1rtml3AlLb1Q65Dbn3WTPaIc0r44Elktf5kpSPRnHKwm8fFiAMDfsyaGULJj9rb9LE01w==
X-Received: by 2002:a05:6e02:2502:b0:3d6:d145:3006 with SMTP id e9e14a558f8ab-3d968009f6amr4296895ab.20.1745969587055;
        Tue, 29 Apr 2025 16:33:07 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f476892sm5211075ab.65.2025.04.29.16.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 16:33:06 -0700 (PDT)
Message-ID: <589336a3-4df5-4f58-a627-2b75716f7b61@linuxfoundation.org>
Date: Tue, 29 Apr 2025 17:33:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: kunit: add information about cleaning source
 trees
To: Randy Dunlap <rdunlap@infradead.org>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <7104475f60568f6a580b03d84e61abe311d63e46.1745965121.git.skhan@linuxfoundation.org>
 <c3333ef9-f266-4260-8f75-0da65bcff1da@infradead.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c3333ef9-f266-4260-8f75-0da65bcff1da@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 16:29, Randy Dunlap wrote:
> 
> 
> On 4/29/25 3:27 PM, Shuah Khan wrote:
>> If kunit run happens in a tree in which a x86_64 kernel was built,
>> the source tree could be dirty.
>>
>> "make ARCH=um mrproper" will not clean the x86_64 build artifacts.
>> Running "make ARCH=x86_64 mrproper" is necessary to clean them.
>>
>> Add this information to the documentation.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   Documentation/dev-tools/kunit/start.rst | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
>> index a98235326bab..568e29aebd6e 100644
>> --- a/Documentation/dev-tools/kunit/start.rst
>> +++ b/Documentation/dev-tools/kunit/start.rst
>> @@ -39,6 +39,18 @@ can run kunit_tool:
>>   	``make ARCH=um mrproper``, just be aware that this will delete the
>>   	current configuration and all generated files.
>>   
>> +	You may see the following error if a prior build leaves behind
>> +	header files which 'make ARCH=um mrproper' fails to clean:
>> +
>> +	"undefined symbol sev_es_trampoline_start referenced ..."
>> +
>> +	This is special case scenario when a prior x86_64 build populates
>> +	the source tree with arch/x86/realmode/rm/pasyms.h. This header
>> +	will not be cleaned by 'make ARCH=um mrproper'
>> +
>> +	If you encouter this problem, run 'make ARCH=x86_64 mrproper' to
> 
> 	       encounter

Thank you. Will fix it.

thanks,
-- Shuah

