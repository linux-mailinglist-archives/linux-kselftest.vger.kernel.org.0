Return-Path: <linux-kselftest+bounces-45280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B92F4C4B6DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 05:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EF554F2088
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03CD272E6E;
	Tue, 11 Nov 2025 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dZbP0CYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9033987
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834300; cv=none; b=rGeHjFP2bC4av4osDcGdxpFzJPP9bX/isUcpKl/FKS0OxszhFSJrB8p2AMz0wQAcKSgQw3ldyFhQXzH556xoRZshifrRZrOyhW1564ygvXZzLgrvx2qdpCtjoJT2l9CNQ2lqLs7j/vMcBPZSHAJVUJ2zXxjm4FD5h7usGsEMXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834300; c=relaxed/simple;
	bh=rctsnyEpr1HHmNAlwxjlzC2Wu3ws7kCoKrmHhli8KoI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=fnc4furKihO9foXZNKtVZn/vgEDW9zqToddgICm1QKO39bJ1Vyc4K9ATRfIZVjb3hmfFx/mGWR18i4a6JB2dylZNRmyAe3/UHdPPT7a1R5GgmJ77mKlcLl2DVB+d7BOdzeaBhi8XBHkBju+DlxrL2q/2bvhgWN9l9T0rBTU3rS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dZbP0CYH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: multipart/mixed; boundary="------------vPtFjGXfGdqM0WPMfpQkHXZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762834291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RPXv3kMp4ktZGiovTZ2Rm3ZdEP+JMTUAVb9siAQ89gg=;
	b=dZbP0CYHJFYdzQdvzKZeriHEQbnDRQBjp4LdiYigfpEgfvq+nAVHc5bKgQlE8bbuXgFf5B
	OCQiZ+aFMh5RCgpe6GpqGZ9N5qKv7Vz0jp/MHrAbx1s/igtxK/77qs7DOxWNvqxu8+3GFY
	cq5laEyu9Ys25Exd0ojWQsY9cTeC8/o=
Message-ID: <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev>
Date: Mon, 10 Nov 2025 20:11:23 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

This is a multi-part message in MIME format.
--------------vPtFjGXfGdqM0WPMfpQkHXZ4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

In FC42, when I run "./luo_multi_session"

# ./luo_multi_session
# [STAGE 1] Starting pre-kexec setup for multi-session test...
# [STAGE 1] Creating state file for next stage (2)...
# [STAGE 1] Creating empty sessions 'multi-test-empty-1' and 
'multi-test-empty-2'...
# [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
# [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
# [STAGE 1] Executing kexec...

Then the system hang. And via virt-viewer, a calltrace will appear.

The call trace is in the attachment.

Yanjun.Zhu

在 2025/11/10 7:26, Pasha Tatashin 写道:
> On Mon, Nov 10, 2025 at 8:16 AM Pratyush Yadav <pratyush@kernel.org> wrote:
>> On Sun, Nov 09 2025, Zhu Yanjun wrote:
>>
>>> 在 2025/11/8 10:13, Pasha Tatashin 写道:
>>>> On Fri, Nov 7, 2025 at 6:36 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>>>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
>>>>>> On Fri, Nov 7, 2025 at 7:00 AM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>>>>>>>> Hi, Pasha
>>>>>>>>
>>>>>>>> In our previous discussion, we talked about counting the number of times
>>>>>>>> the kernel is rebooted via kexec. At that time, you suggested adding a
>>>>>>>> variable in debugfs to keep track of this count.
>>>>>>>> However, since debugfs is now optional, where would be an appropriate
>>>>>>>> place to store this variable?
>>>>>>> It is an optional config and can still be enabled if the live update
>>>>>>> reboot number value needs to be accessed through debugfs. However,
>>>>>>> given that debugfs does not guarantee a stable interface, tooling
>>>>>>> should not be built to require these interfaces.
>>>>>>>
>>>>>>> In the WIP LUO [1] I have, I pr_info() the live update number during
>>>>>>> boot and also store it in the incoming LUO FDT tree, which can also be
>>>>>>> accessed through this optional debugfs interface.
>>>>>>>
>>>>>>> The pr_info message appears like this during boot:
>>>>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>>>>>>>
>>>>>>> Pasha
>>>>>> Forgot to add link to WIP LUOv5:
>>>>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
>>>>> Thanks a lot. I’ve carefully read this commit:
>>>>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83f0ff08fa.
>>>>>
>>>>> To be honest, I’d like to run some tests with who/luo, including the
>>>>> selftest for kho/luo. Could you please share the steps with me?
>>>>>
>>>>> If the testing steps have already been documented somewhere, could you
>>>>> please share the link?
>>>> Currently the test performs in-kernel tests for FLB data, it creates a
>>>> number of FLB for every registered LUO file-handler, which at the
>>>> moment is only memfd.
>>>>
>>>> It works together with any of the kexec based live update tests. In
>>>> v5, I introduce two tests:
>>>> luo_kexec_simple
>>>> luo_multi_session
>>>>
>>>> For example, with luo_multi_session:
>>> Hi, Pasha
>>>
>>> I enabled "CONFIG_LIVEUPDATE=y"
>>>
>>> # ./luo_multi_session
>>> 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
>>>
>>> # ls /dev/liveupdate
>>> ls: cannot access '/dev/liveupdate': No such file or directory
>>>
>>> # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
>>> /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=y
>>> /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=y
>>>
>>> I made tests on FC42. But /dev/liveupdate is missing.
>> You need to add liveupdate=1 to your kernel cmdline to enable LUO and
>> get /dev/liveupdate.
> +1, kernel parameters require: kho=1 liveupdate=1
>
>> Pasha, your LUO series doesn't add the liveupdate parameter to
>> kernel-parameters.txt. I think it should be done in the next version to
>> this parameter is discoverable.
> Yeah, that is missing, I will update that in a standalone patch, or in
> a next version.
>
> Thanks,
> Pasha

-- 
Best Regards,
Yanjun.Zhu

--------------vPtFjGXfGdqM0WPMfpQkHXZ4
Content-Type: image/png; name="Screenshot.png"
Content-Disposition: attachment; filename="Screenshot.png"
Content-Transfer-Encoding: base64

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
AAAAAElFTkSuQmCC

--------------vPtFjGXfGdqM0WPMfpQkHXZ4--

