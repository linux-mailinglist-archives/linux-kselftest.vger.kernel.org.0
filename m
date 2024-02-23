Return-Path: <linux-kselftest+bounces-5386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A93861F5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F097F1F246B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D314CAB3;
	Fri, 23 Feb 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ty/7+bV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F414CAA2
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726081; cv=none; b=OMKP9ZUZtmi4wnO2MbzDXfz5mNWfs7qrWuvqUwnq08YFJjzfNB804irSKCzDan+QmTiH+bSWyxO2ct1z4zbTge0doNqM5p9H6zji8TwLBoHHuOfdN7X1dWpnZ1ucB2671Yo55IUkYru7+8EcWLESavQsLLCe4Nq4nkUjTzqzAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726081; c=relaxed/simple;
	bh=XCkxVjJN6TdCgPtRmewiRi7q1bmPB9dwiCi4ta9RI58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPxhvswvQEzQV1qcFS/WbohJOS8JkfcfO8BKtylcLUOP+Fu1WTA330EQ9ysyTeZWVF1TF52bjlYEJI4MgqjyZZ+d/l021RUP7aBAtWEIXuf1f7GWFgMYXJae+L+EOMWuTvAyix3oFhkehIzWEiNgVAOCfrJZf+2tx8S53W1GETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ty/7+bV4; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso23244339f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708726079; x=1709330879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fdAI0DrY4+cZupo08XTufNQuBtOKpu0rrwHi//EJSU=;
        b=Ty/7+bV4BtT8sPZXsU1Hx88Mk9as271jwVWwQ4kRzfrPttCAFsOb3Lr/mTqo/HBIsh
         xpMVrTilUaw5ZhpOWJNvdTSqxxq7AnuSKjll561YXzkWicph9jiuKA3qtiLT269X7Tms
         S/A4EHKjmZGgAGEufKgSlaMK9Tm97xXl092kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726079; x=1709330879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fdAI0DrY4+cZupo08XTufNQuBtOKpu0rrwHi//EJSU=;
        b=hJT9suyS2rcO1lk+xPMnaQcY8Ss0zqzBUTovpsrM90R5hwV+53iRS9cQlsJUEdG3DL
         cL9dT5CZ4o++XpkzpKpV31GDnVWJI9ocEXBhFtG5F5f0IvJmncGzZCQF1SRyM/Ducx3X
         SleFDsecCjJo4w9oamHTo7YQ8B4f667KXrw3GpauFdEfmGMgULH64TTMn4DFFDGKdJCq
         1xaOet2MsDcIKmeTa7GUWGIipzFHnQUbkZ9E9sdmbfn28CDO30btubboiwZAU1K+XSEF
         A+l6TpbVvYoV8yYoXyGmG3uzMLJPpDmyTfW4qTYhNsAapKX3jDKRFtFtU8vhPeBOigyS
         OsXA==
X-Forwarded-Encrypted: i=1; AJvYcCWt/mDivo9LycqcSapkJQZjHVqsU9AN7gRd5S7FxnJDNSDuXlP3dRRaGX4Vk9S2mDLgzdDEt4vSIS0FCZVpMXMhwn9U828VxWo5XmmxmozB
X-Gm-Message-State: AOJu0YzKfD6vVem+8YREFXxXUOKj7BIFCClkXrat4AFw3e0HCHDyH8e/
	34llVWsAxt863QmxClU0Xr6zViRVHrXq1HgHtasTqnFlF5gMdq/acB13B+6D73Q=
X-Google-Smtp-Source: AGHT+IHiKVcuqSVcuMUfgbyF+Cd49SlDxNt5CwWlzj2tF4SXuMug78NaNUTvJkUOoYewqfd+aR+MXA==
X-Received: by 2002:a6b:6501:0:b0:7c7:7f73:d1a with SMTP id z1-20020a6b6501000000b007c77f730d1amr1276130iob.1.1708726078903;
        Fri, 23 Feb 2024 14:07:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j3-20020a05663822c300b00472f79e0001sm3950166jat.171.2024.02.23.14.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:07:58 -0800 (PST)
Message-ID: <bfec40fc-8152-4f5e-84c4-926312014322@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:07:58 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240222020456.28532-1-mpdesouza@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240222020456.28532-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 19:04, Marcos Paulo de Souza wrote:
> On Thu, 22 Feb 2024 09:28:19 +0800 Yujie Liu <yujie.liu@intel.com> wrote:
> 
>> On Wed, Feb 21, 2024 at 07:04:03PM -0300, Marcos Paulo de Souza wrote:
>>> On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>> On 2/21/24 05:26, Marcos Paulo de Souza wrote:
>>>>> On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>>> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
>>>>>>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>>>>>>>
>>>>>>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
>>>>>>>>
>>>>>>>>> Hi Marcos,
>>>>>>>>>
>>>>>>>>> kernel test robot noticed the following build errors:
>>>>>>>>>
>>>>>>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
>>>>>>>>>
>>>>>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
>>>>>>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
>>>>>>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
>>>>>>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>>>>>>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>>>>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
>>>>>>>>>
>>>>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>>>>>> the same patch/commit), kindly add following tags
>>>>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
>>>>>>>>>
>>>>>>>>> All errors (new ones prefixed by >>):
>>>>>>>>>
>>>>>>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
>>>>>>>>
>>>>>>>> We should ask the kernel test robot machine owners to install kernel-devel
>>>>>>>> package in order to have this fixed.
>>>>>>>
>>>>>>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
>>>>>>> instead of /lib/modules/?
>>>>>>>
>>>>>>
>>>>>> This would be a regression to automated test rings. Do you have any other
>>>>>> solutions?
>>>>>
>>>>> I would say that we could skip the these tests if kernel-devel package is not
>>>>> installed. Would it be acceptable? At least we would avoid such issues like this
>>>>> in the future as well.
>>>>>
>>>>
>>>> We have to check and skip build. Something we could do in the livepatch
>>>> Makefile. Can you send patch for this - I will oull this in for next
>>>> so we don't break test rings.
>>>
>>> I added a new patch in the same patchset that would cover this, skipping the
>>> build and test if kernel-devel is not installed. The patchset was sent earlier
>>> today. Please check if the new patch fixes things on the build robot.
>>
>> Hi Shuah, Hi Marcos,
>>
>> Sorry for this wrong report. The files are organized in a different way
>> in the bot and cause this issue. We have fixed the bot to explicitly
>> set KDIR to the correct path before building the selftests. The patch
>> [1] can also work well in bot's environment.
>>
>> [1] https://lore.kernel.org/all/20240221-lp-selftests-fixes-v2-2-a19be1e029a7@suse.com/
> 
> Hi Yujie, thanks for letting us know that the bot had different settings. Either
> way the patch you mentioned should help to reduce noise in the future on
> bot's that doesn't have kernel-devel installed.
> 

Marcos, If you send me the patch, I will apply it to linux-kselftest next.
> Again, thanks a lot for fixing the issue!
>    Marcos
> 

Thank you Yujie

thanks,
--- Shuah


