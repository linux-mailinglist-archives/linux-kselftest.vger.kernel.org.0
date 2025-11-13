Return-Path: <linux-kselftest+bounces-45503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD46C55508
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 02:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37D964E25FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA172D94A8;
	Thu, 13 Nov 2025 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aspetcsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B92E9EDA
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998118; cv=none; b=t5UAI4CF7wNn+WCMxfp+wj6Nxkz9sbHNXmf5B75qlG4trs3aruFFb8jAcZr449hp2eZ3raxS1soWrSNMPsYgwE5l4V3713fv6x0TOQnWCyNppwQ6PxcLYgijrvzBtKufF8aoZ0acGYIg74RaCGXysWfwK0WMykabrExgDvPLmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998118; c=relaxed/simple;
	bh=9ViwniV9FjvGp479W+y41NeEEmt4+EYeSsCL3B3JmNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPmEhstERPEEcwARIxGR288/IG+P5D9HEWBeGKx6KSULvfirqR9OAQ0xFQfbWzP/hsAlMpLjaK30pde0LoD1+qKr7/d+xE5tT5Eq2m365L53Y456+yEBruu3UA14Xk3u0zH4GijguPTb8oImn3GnujDBxc13Vmfr9gNZtuOyA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aspetcsn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <475ed48d-1f62-4983-94a1-64e41c463c36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762998104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZOsuzzzQHJpIeK5WeOY1LNAVB/LXukV3KrcVp6/m18=;
	b=AspetcsnJtR4NjDaUovNH2yMqZTZw0RgLT/JVL7iCXS9oi67IL2u0jl/uOr0dksqvGcvUn
	YX+fGFhLg27XpwXq2IW5geaCJE3Xio36ngY70VFJY8922A+P+lFwyw1PcZ2+dwpoMhwRKO
	R85op0rSFY5KSS5iU1NU0AgVIisSR1o=
Date: Wed, 12 Nov 2025 17:41:38 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
 brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com>
 <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
 <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev>
 <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
 <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev>
 <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/11/25 7:26 AM, Pasha Tatashin wrote:
> On Mon, Nov 10, 2025 at 11:11 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> In FC42, when I run "./luo_multi_session"
>>
>> # ./luo_multi_session
>> # [STAGE 1] Starting pre-kexec setup for multi-session test...
>> # [STAGE 1] Creating state file for next stage (2)...
>> # [STAGE 1] Creating empty sessions 'multi-test-empty-1' and
>> 'multi-test-empty-2'...
>> # [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
>> # [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
>> # [STAGE 1] Executing kexec...
>>
>> Then the system hang. And via virt-viewer, a calltrace will appear.
> Looks like mountroot fails, are you passing the same kernel parameters
> as the during cold boot?
> i.e. kexec -l -s --reuse-cmdline --initrd=[initramfs] [kernel]


Thanks a lot. It can work now.  The logs are as below:

"

# [STAGE 2] Starting post-kexec verification...
# [STAGE 2] Retrieving all sessions...
# [STAGE 2] Verifying contents of session 'multi-test-files-1'...
# [STAGE 2] Verifying contents of session 'multi-test-files-2'...
# [STAGE 2] Test data verified successfully.
# [STAGE 2] Finalizing all test sessions...
# [STAGE 2] Finalizing state session...
#
--- MULTI-SESSION KEXEC TEST PASSED ---
"

Yanjun.Zhu

>
> Pasha
>
>> The call trace is in the attachment.
>>
>> Yanjun.Zhu
>>
>> 在 2025/11/10 7:26, Pasha Tatashin 写道:
>>> On Mon, Nov 10, 2025 at 8:16 AM Pratyush Yadav <pratyush@kernel.org> wrote:
>>>> On Sun, Nov 09 2025, Zhu Yanjun wrote:
>>>>
>>>>> 在 2025/11/8 10:13, Pasha Tatashin 写道:
>>>>>> On Fri, Nov 7, 2025 at 6:36 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>>>>>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
>>>>>>>> On Fri, Nov 7, 2025 at 7:00 AM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>>>>>>>>>> Hi, Pasha
>>>>>>>>>>
>>>>>>>>>> In our previous discussion, we talked about counting the number of times
>>>>>>>>>> the kernel is rebooted via kexec. At that time, you suggested adding a
>>>>>>>>>> variable in debugfs to keep track of this count.
>>>>>>>>>> However, since debugfs is now optional, where would be an appropriate
>>>>>>>>>> place to store this variable?
>>>>>>>>> It is an optional config and can still be enabled if the live update
>>>>>>>>> reboot number value needs to be accessed through debugfs. However,
>>>>>>>>> given that debugfs does not guarantee a stable interface, tooling
>>>>>>>>> should not be built to require these interfaces.
>>>>>>>>>
>>>>>>>>> In the WIP LUO [1] I have, I pr_info() the live update number during
>>>>>>>>> boot and also store it in the incoming LUO FDT tree, which can also be
>>>>>>>>> accessed through this optional debugfs interface.
>>>>>>>>>
>>>>>>>>> The pr_info message appears like this during boot:
>>>>>>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>>>>>>>>>
>>>>>>>>> Pasha
>>>>>>>> Forgot to add link to WIP LUOv5:
>>>>>>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
>>>>>>> Thanks a lot. I’ve carefully read this commit:
>>>>>>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83f0ff08fa.
>>>>>>>
>>>>>>> To be honest, I’d like to run some tests with who/luo, including the
>>>>>>> selftest for kho/luo. Could you please share the steps with me?
>>>>>>>
>>>>>>> If the testing steps have already been documented somewhere, could you
>>>>>>> please share the link?
>>>>>> Currently the test performs in-kernel tests for FLB data, it creates a
>>>>>> number of FLB for every registered LUO file-handler, which at the
>>>>>> moment is only memfd.
>>>>>>
>>>>>> It works together with any of the kexec based live update tests. In
>>>>>> v5, I introduce two tests:
>>>>>> luo_kexec_simple
>>>>>> luo_multi_session
>>>>>>
>>>>>> For example, with luo_multi_session:
>>>>> Hi, Pasha
>>>>>
>>>>> I enabled "CONFIG_LIVEUPDATE=y"
>>>>>
>>>>> # ./luo_multi_session
>>>>> 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
>>>>>
>>>>> # ls /dev/liveupdate
>>>>> ls: cannot access '/dev/liveupdate': No such file or directory
>>>>>
>>>>> # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
>>>>> /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=y
>>>>> /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=y
>>>>>
>>>>> I made tests on FC42. But /dev/liveupdate is missing.
>>>> You need to add liveupdate=1 to your kernel cmdline to enable LUO and
>>>> get /dev/liveupdate.
>>> +1, kernel parameters require: kho=1 liveupdate=1
>>>
>>>> Pasha, your LUO series doesn't add the liveupdate parameter to
>>>> kernel-parameters.txt. I think it should be done in the next version to
>>>> this parameter is discoverable.
>>> Yeah, that is missing, I will update that in a standalone patch, or in
>>> a next version.
>>>
>>> Thanks,
>>> Pasha
>> --
>> Best Regards,
>> Yanjun.Zhu

