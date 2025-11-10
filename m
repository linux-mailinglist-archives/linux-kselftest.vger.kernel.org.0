Return-Path: <linux-kselftest+bounces-45205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C24CC44AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 01:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E190E3AEF7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326951DDC37;
	Mon, 10 Nov 2025 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aFVEiWeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D68821
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762734071; cv=none; b=UXti1jqPubhIznYBsHlaKdEu7SZz5qp4DLe0YhYvYiWVc6h02WUhXWZJNjFqtpWV/tjgQKBq9YRLH5BI04HmM8sNhEa6BAWGK22nVSs+lwedwIMpO9/3C4QV3UTQdFKuS3C4vTwMNBpnBHNx/NQ2jTbmJ9Cm/5Aun3nwpNqeb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762734071; c=relaxed/simple;
	bh=MS7Cf/KMp3LIQkV/zy5GKazQnzumkX1n8Ct0PmoQalU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeDqBAQJtkIw2k9fxRZsG7GCzcKn/siHvwLJov/KzDXxkvnGUM6NSaDN8+qYedye7fKYfPjxamrz+86OZJO8td1Rx0zdJuzctDTiZM6bL6OMr9n47DMlLBD3g6xoe283vAucjfUTbU+bBjVZivVJrMROf4mOUP+pIEFBdqH5osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aFVEiWeL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <442fa82e-16ef-4bde-84eb-743450222468@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762734062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLBZG12EpOweg5W//dmheHVzJBlI9SLwueSdt6kZhp0=;
	b=aFVEiWeLxQUK2ISXdf52J2BDzGtfH3DLAlz7RqIMEVvL9ZhZRM6nGB2fRlFMFljDGu5yXu
	JcC07geo4luDBuNKUq/6FdonyAlA8GeAPnuUN8ofevO0Hyxet8ILg/fDdsxUkBh4xp+5kB
	9PLUGv7mP+wX6RNN85JBMCCoTtQXbfg=
Date: Sun, 9 Nov 2025 16:20:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
 graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org,
 ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org,
 rppt@kernel.org, tj@kernel.org
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com>
 <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
 <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/8 10:13, Pasha Tatashin 写道:
> On Fri, Nov 7, 2025 at 6:36 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>
>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
>>> On Fri, Nov 7, 2025 at 7:00 AM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>>>>> Hi, Pasha
>>>>>
>>>>> In our previous discussion, we talked about counting the number of times
>>>>> the kernel is rebooted via kexec. At that time, you suggested adding a
>>>>> variable in debugfs to keep track of this count.
>>>>> However, since debugfs is now optional, where would be an appropriate
>>>>> place to store this variable?
>>>> It is an optional config and can still be enabled if the live update
>>>> reboot number value needs to be accessed through debugfs. However,
>>>> given that debugfs does not guarantee a stable interface, tooling
>>>> should not be built to require these interfaces.
>>>>
>>>> In the WIP LUO [1] I have, I pr_info() the live update number during
>>>> boot and also store it in the incoming LUO FDT tree, which can also be
>>>> accessed through this optional debugfs interface.
>>>>
>>>> The pr_info message appears like this during boot:
>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>>>>
>>>> Pasha
>>> Forgot to add link to WIP LUOv5:
>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
>>
>> Thanks a lot. I’ve carefully read this commit:
>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83f0ff08fa.
>>
>> To be honest, I’d like to run some tests with who/luo, including the
>> selftest for kho/luo. Could you please share the steps with me?
>>
>> If the testing steps have already been documented somewhere, could you
>> please share the link?
> Currently the test performs in-kernel tests for FLB data, it creates a
> number of FLB for every registered LUO file-handler, which at the
> moment is only memfd.
>
> It works together with any of the kexec based live update tests. In
> v5, I introduce two tests:
> luo_kexec_simple
> luo_multi_session
>
> For example, with luo_multi_session:

Hi, Pasha

I enabled "CONFIG_LIVEUPDATE=y"

# ./luo_multi_session
1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?

# ls /dev/liveupdate
ls: cannot access '/dev/liveupdate': No such file or directory

# grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
/boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=y
/boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=y

I made tests on FC42. But /dev/liveupdate is missing.

Thanks

Yanjun.Zhu

> # ./luo_multi_session
> # [STAGE 1] Starting pre-kexec setup for multi-session test...
> # [STAGE 1] Creating state file for next stage (2)...
> # [STAGE 1] Creating empty sessions 'multi-test-empty-1' and
> 'multi-test-empty-2'...
> # [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
> # [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
> # [STAGE 1] Executing kexec...
>
> ... reboot ...
> After reboot:
>
> $ ./luo_multi_session
> # [STAGE 2] Starting post-kexec verification...
> # [STAGE 2] Retrieving all sessions...
> # [STAGE 2] Verifying contents of session 'multi-test-files-1'...
> # [STAGE 2] Verifying contents of session 'multi-test-files-2'...
> # [STAGE 2] Test data verified successfully.
> # [STAGE 2] Finalizing all test sessions...
> # [STAGE 2] Finalizing state session...
> #
> --- MULTI-SESSION KEXEC TEST PASSED ---
>
> Dmesg data, shows that in-kernel live update test was also successful:
>
> [    0.000000] luo: Retrieved live update data, liveupdate number: 1
> [    0.034513] liveupdate test: test-flb-v0: found flb data from the
> previous boot
> [    0.034517] liveupdate test: test-flb-v1: found flb data from the
> previous boot
> [    0.034518] liveupdate test: test-flb-v2: found flb data from the
> previous boot
> [    0.676891] liveupdate test: Registered 3 FLBs with file handler: [memfd-v1]
>
> Pasha
>
>> Best Regards,
>>
>> Yanjun.Zhu
>>
-- 
Best Regards,
Yanjun.Zhu


