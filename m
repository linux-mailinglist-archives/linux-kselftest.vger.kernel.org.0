Return-Path: <linux-kselftest+bounces-42589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6DBA9F3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB138171F9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB9309F03;
	Mon, 29 Sep 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+Ag0KUB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C797309F1C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162032; cv=none; b=ZNgB9FMxuOQrPBrs4H7elhEJzxeNCsy9tTuR98/X9mO6ELXQo4p5PXtL1jfPwSil5Ti6H2hm7dthdMYALxDng3Z0J+xk2ZAqUvl7Hhps7ObAsf2/rxu2P3mOnxj+jazl5H2z+jBaXOp3najGEqgilPRhAKMJ1QjD8HI3UZ0B7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162032; c=relaxed/simple;
	bh=hIk+72cnhQ/vyXYspLR5rqsPDSDikL9OCAzZiu7PCpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM9kyv7oKf5PhPYXzmOviN2UcuIVDLyC/dnDw0vqRFKJe0VY6TRCezaVh4XP7Xl4ylwCvmNsqmZBM6H9OpW+VxWfaVl17ZtRWJOGF8DzyPczOuX2kiFDDQkkYf/kkj1rLCQz5/EHMilKVn4njlXu6DizFa8/PIolmIufXniAIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+Ag0KUB; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-92b92e4b078so35590239f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759162030; x=1759766830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=929brNp38LQE1zEUdewrHj7AY0N4kam7Q/lhFDeHYEw=;
        b=C+Ag0KUBigQ64v2D9RxO/mf9l7iiV7pJooTmG8FbNaKoSzHjHvDBcOo3XIEaxNfcE9
         YQAaR8j+8iUlBNv3M34/SQLZMi5ZmBrDEBwfKr+CeprHoGXaXy3SC9B1WGbZMiwo3pRh
         A2JfNVugh5ihSVv+Mt/N6aqT6ooBRUU/yWKYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162030; x=1759766830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=929brNp38LQE1zEUdewrHj7AY0N4kam7Q/lhFDeHYEw=;
        b=aLDrRDZGFzr9dex/GtMm5glJEKemqcqtBUZW8IFNwcEwpBwjQg9tpUSp9NE6NRPDJ7
         j6ZrLXEVl6jEqu2pbD7GodOHClD2b9hvPQ6OFau4gl6bLTmEe7hH8E88PQMgUPXDfBE9
         qviMlxHovFHS+DDm6cP6OOA2is+HWRmbMk8xV9i7zWzfgGU60rPhlX2DFpP26aIzLv9T
         P1VnWJhb5fGmqYOSGsOvnw723Ta3Zbd3Chp7GqICApaUgvvB6GU2gRJcfaJpsD1ZuPyJ
         ZidnI1vUsX2xVK/6nSSveV8AbFuMUr660mNzNJKpJS1u0lE/8FTktKYCmH5qUEqbTZEH
         cP0A==
X-Forwarded-Encrypted: i=1; AJvYcCUBMEG7Xud7+i7iZZkvqQY54d4xef1gbQC6BrZ2AyRKscB4EXXiojKU4qdZI6NqLgrGFqd0zKdoTL8iYgQS4fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOp/Ln9G8k/gybu9cATC+ZZ2Dt19eC/Qe9OgOTaJ/k5NzNX8dk
	sZ5Yq2p3JHeQnU8QYZ0v/KjDGSCPU20uZDLKBymfQ1n6sisiPM+i5GQso5L4PYi+Hrc=
X-Gm-Gg: ASbGnct/NqfZPHS/qB4yLY/S6EEaw/NCnLcDIQhphde4gjv5GVXMSPDw7I1aKPfNFID
	l/VOiZ/66VmfAOhDYbHT5AFyA58h8IFrDLV3CRJzYOWgY5rYJiU2Vac4m3VwKYYzQlvedb3zlJ7
	Gvs5ieHZLp0m+DT+rP1LheUHvD4fxj0pV7/zI8TI05NdxO+eLe+1Dna3FjSt06NUqbM69mmRyud
	elOZ/ZKH6Ysal6jqwvn40YH9elsvtJ3ga3ehKxYH9H2VjXqDxz6/ro+XPjzzUU5wK02R+z7zs2G
	LN/9VdcR4Bd4mtHYfsyIO1NZw/LFIa7ag6xsAsE9XxEH+DftCOtfVBOiG3zmHzjccL1cHiPS3V9
	395qMxbdBd6M4OJe7rPiyZoMQ0cBWSQTCjfNUeT7Hmmjrfahqa110yl0+
X-Google-Smtp-Source: AGHT+IGGQnZ9lMbLnEDujEK9tAloKwXvVr7upeO6oa8FE/9AtgzYPiFIpmG1O1IA+cT7ly4JhGxJ8Q==
X-Received: by 2002:a5e:c206:0:b0:8eb:1451:91c7 with SMTP id ca18e2360f4ac-901528e52cdmr2112358139f.5.1759162030006;
        Mon, 29 Sep 2025 09:07:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-903faacabb0sm446872339f.7.2025.09.29.09.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:07:09 -0700 (PDT)
Message-ID: <31594439-66f1-42e4-b122-e5888bcf2e12@linuxfoundation.org>
Date: Mon, 29 Sep 2025 10:07:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during building on next-20250926 - kunit.py run --alltests
 run
To: "Berg, Johannes" <johannes.berg@intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 David Gow <davidgow@google.com>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: shuah <shuah@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Networking <netdev@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <47b370c2-9ab2-419f-9d43-8da310fedb4a@linuxfoundation.org>
 <6e0d5120-868c-45fd-9ec5-67764a257ab5@linuxfoundation.org>
 <PH8PR11MB8285FB2BB207666DE9814F61E91BA@PH8PR11MB8285.namprd11.prod.outlook.com>
 <0f3a1bad-4e8e-473f-8f78-92a6b96450b9@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0f3a1bad-4e8e-473f-8f78-92a6b96450b9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 10:05, Shuah Khan wrote:
> On 9/29/25 01:07, Berg, Johannes wrote:
>> +Miri
>>
>> Hi Shuah,
>>
>>>> I am seeing the following error during "kunit.py run --alltests run"
>>>> next-20250926.
>>>>
>>>> $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit
>>>> --jobs=16
>>>> ERROR:root:/usr/bin/ld: drivers/net/wireless/intel/iwlwifi/tests/devinfo.o: in
>>> function `devinfo_pci_ids_config':
>>>> devinfo.c:(.text+0x2d): undefined reference to `iwl_bz_mac_cfg'
>>>> collect2: error: ld returned 1 exit status
>>>> make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped]
>>>> Error 1
>>>> make[2]: *** [/linux/linux_next/Makefile:1242: vmlinux] Error 2
>>>> make[1]: *** [/linux/linux_next/Makefile:248: __sub-make] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> Yeah, really my mistake, I didn't consider what happens in the test there when iwlwifi is built but without CONFIG_IWLMVM and CONFIG_IWLMLD.
>>
>> I think we should add those to actually run their kunit tests too, which would fix the build issue, and maybe even CONFIG_IWLDVM to increase coverage of the tests in iwlwifi itself. I can send a patch for that.
>>
>> All that said, the patch that breaks it is in linux-next via iwlwifi-next but seems to actually have missed the cutoff for 6.18, so we're good for now and I suppose Miri can even squash the build fix into that later.
>>
> 
> Thank you. Sounds like a plan.
> 
> I will send my kunit pr to Linus then.

Later on today - I mean.

thanks,
-- Shuah

