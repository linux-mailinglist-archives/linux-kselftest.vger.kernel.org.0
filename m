Return-Path: <linux-kselftest+bounces-5385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F0861F58
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0852428591B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4B14CAAB;
	Fri, 23 Feb 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJ+rMO2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA660146E81
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726044; cv=none; b=N5mesSsOVrB6Cbr9+xFoEJN0T/z8ET26jRfGcoPtvOXT6vnHDwrxFN88yr52bFTAynzBmUzqALc1LM3VJsv7SkrPvjaRl2Mq2iXmjp1XrVHNBkLffiAF1K9bSUWCZek1um72+3RgAYsEDBU0ufVeqGGgZHFCzUvDzbuuqTCtof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726044; c=relaxed/simple;
	bh=0J6B8YE1odeNkLXVvb4YcSuTvRMJz2YgyoOVBHbe++c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSx4fsQ3gqvxYha33bIs2YBwNgApDpZ4Q8hS45QGPnpZ1XKCjCwOMOMVEuZN0yBcA5QU9pyZSE7/ikWp+OSj+mMXCK7dGBws72szIG87VpnPRJXxD00ofPEBlBzPNK9Iy5rbnLvOlaaPEVkAOR2YzDJwXHW15eiCACENX1IQkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJ+rMO2X; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so725355ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708726042; x=1709330842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mERD5D5sAvS0twAioGZ9rpcPlzA/moYLeMlByp7P/lw=;
        b=BJ+rMO2XKNA6s26TR4k/hRqH4p1qdS30LUfngCsMVj5rmxSpOTgM8QzaSJbubiucqL
         7WkGm8TNo5cwH+0YzOyX/9KH2KHrFpEmdSzgqOYjd1qA2udsmFjcJuVXyzGSiV4xGrBB
         3t9QQD5XNyniGumG2No6GiziD2PEst6v8Z6GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726042; x=1709330842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mERD5D5sAvS0twAioGZ9rpcPlzA/moYLeMlByp7P/lw=;
        b=BzyR7QKZ6+9XnHUINnqZirNoY+rwMMQVuYUUUJdfueqSQVNUgz/ehmB8/f1WCAEWO3
         DUNRRxnagapomFxt8K+KeNp2M5mpJw9BQhUqhVKrBgoY44/d6yB714Gd+L6O5JJMbvut
         xzr4QtPbfQtDkicVlC9XLfKCfK44ooZjhtSIDuc5Cc8iTWctVdglShxpHff//w+hPf9I
         405jvB1aOTUQ920TaNHlyexs/xG0JmFVZsM7dmK1ixPYI22e7Bpm7eiojqnsHBWjOfVb
         PLLRLyUJnrKttaZw9XBnIbZ8iz/jKxarnQQns0Ja7nJownGeGKIY/zvkYvUhcn7EbPj/
         E15g==
X-Forwarded-Encrypted: i=1; AJvYcCUUqxAP209HL75rzdxfyYg58fjH140/Z74qfL2idrBZGI0XVeoqImNN9ISYUg8e/IcMi+ICm9dXkHs6LjVgBCFyj8WyAKpurxi04xfmF26D
X-Gm-Message-State: AOJu0Ywcyd/MliLWwBWI6EfTBSYAJ0NRkDYw/3OcQNm5FNl5VEQEbXtC
	2DBe66NEvRi6vhgOX+Bez11IAXLeLOy2ZUPYqHTMUgxk0Pgny8/3GUK8QF/BMY0=
X-Google-Smtp-Source: AGHT+IFnB9+xh0h4j2A1kk4c08JZtvb/IeiX0Y9RRmFsLOsulElYLBu1y95CDfvMQBAy/TSWr/MEJw==
X-Received: by 2002:a6b:da17:0:b0:7c7:a02d:f102 with SMTP id x23-20020a6bda17000000b007c7a02df102mr1287016iob.0.1708726042026;
        Fri, 23 Feb 2024 14:07:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j3-20020a05663822c300b00472f79e0001sm3950166jat.171.2024.02.23.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:07:21 -0800 (PST)
Message-ID: <cf6b3ca2-3996-4ebd-858d-eb71a5bd3841@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:07:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221220404.11585-1-mpdesouza@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221220404.11585-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 15:04, Marcos Paulo de Souza wrote:
> On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 2/21/24 05:26, Marcos Paulo de Souza wrote:
>>> On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>>> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
>>>>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
>>>>>
>>>>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
>>>>>>
>>>>>>> Hi Marcos,
>>>>>>>
>>>>>>> kernel test robot noticed the following build errors:
>>>>>>>
>>>>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
>>>>>>>
>>>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
>>>>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
>>>>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
>>>>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>>>>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
>>>>>>>
>>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>>>> the same patch/commit), kindly add following tags
>>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
>>>>>>>
>>>>>>> All errors (new ones prefixed by >>):
>>>>>>>
>>>>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
>>>>>>
>>>>>> We should ask the kernel test robot machine owners to install kernel-devel
>>>>>> package in order to have this fixed.
>>>>>
>>>>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
>>>>> instead of /lib/modules/?
>>>>>
>>>>
>>>> This would be a regression to automated test rings. Do you have any other
>>>> solutions?
>>>
>>> I would say that we could skip the these tests if kernel-devel package is not
>>> installed. Would it be acceptable? At least we would avoid such issues like this
>>> in the future as well.
>>>
>>
>> We have to check and skip build. Something we could do in the livepatch
>> Makefile. Can you send patch for this - I will oull this in for next
>> so we don't break test rings.
> 
> I added a new patch in the same patchset that would cover this, skipping the
> build and test if kernel-devel is not installed. The patchset was sent earlier
> today. Please check if the new patch fixes things on the build robot.
> 

Did you send the patch to me so I can apply it on top of what I have in next?

thanks,
-- Shuah


