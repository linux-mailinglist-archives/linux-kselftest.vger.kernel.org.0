Return-Path: <linux-kselftest+bounces-45225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC3EC46D15
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D339B349235
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1A1C8FBA;
	Mon, 10 Nov 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS38d2F+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E31397;
	Mon, 10 Nov 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780601; cv=none; b=newxeKB1HlO9mwxLbWK196lAMMX3SBvIFn6qbUuHFh8coBZDzQlXctD8kFYH9XxaiUg/wth9c3MlKKD6Fs5zlXmMOlI4bpUwxmbjqvjNAT6oE5yM0GP7fEz+mdJ5Bxfirf5AACe4yHW28uFl+U2r4TtsndO5M6ASLMLeBibhFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780601; c=relaxed/simple;
	bh=f0dZjtcP0vxUJBo4nfnO1ah3073NhYiLonrdArYUsXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5WBqcLl9JgVZvbQ3WANezJldCU2j9BOBHcxxCRQlRfveKS2B04S14EFqkMguqft4WBv9QQY6yQ5lPD2Oi+OzSJPlRIj/vwg2I3GIuDvEyTB7gjnkec55OYSO+Un+Btya9wtXtnPDEOanVvdpdnuLD35MdLX3ztqtj0q93lXSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS38d2F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A7FC4CEF5;
	Mon, 10 Nov 2025 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762780601;
	bh=f0dZjtcP0vxUJBo4nfnO1ah3073NhYiLonrdArYUsXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PS38d2F+HD6yJ+cCZ27VfTyu/Xb5ZNzr80MqBwuo05yeFYAXUJdvjE5nUUkXYcFFD
	 +5183EI4m7vKpS3ZZwa7ynwmCHyhTwcz+iEuPcYXMSWAvc3cub34I6kp/Cnbduib2k
	 O2om8Jm3FT/iufyjmHEZqTttkvC6e+bBJbYB2icy6vI5KYYdvLq6XlDk1bKyZZ9tZh
	 roMVdrRyxyw38iwxO2aGZ2XNKX9DBFV8xK31IMNliK86ajR/C3rW3abM/BOELVQbfR
	 C0M8uOI3syHk24+OYOUanJp+f96ijtCAJSGZ55L2Ur8Kc8x9HzduLTQ+LWWXzdhMpq
	 ipF5HIEmgZ2pA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  brauner@kernel.org,  corbet@lwn.net,  graf@amazon.com,  jgg@ziepe.ca,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  masahiroy@kernel.org,  ojeda@kernel.org,
  pratyush@kernel.org,  rdunlap@infradead.org,  rppt@kernel.org,
  tj@kernel.org
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
In-Reply-To: <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> (Zhu Yanjun's
	message of "Sun, 9 Nov 2025 16:20:56 -0800")
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-2-pasha.tatashin@soleen.com>
	<d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
	<CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
	<CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
	<029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
	<CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
	<442fa82e-16ef-4bde-84eb-743450222468@linux.dev>
Date: Mon, 10 Nov 2025 14:16:37 +0100
Message-ID: <mafs0qzu69gei.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09 2025, Zhu Yanjun wrote:

> =E5=9C=A8 2025/11/8 10:13, Pasha Tatashin =E5=86=99=E9=81=93:
>> On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev>=
 wrote:
>>>
>>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
>>>> On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatashin@=
soleen.com> wrote:
>>>>>> Hi, Pasha
>>>>>>
>>>>>> In our previous discussion, we talked about counting the number of t=
imes
>>>>>> the kernel is rebooted via kexec. At that time, you suggested adding=
 a
>>>>>> variable in debugfs to keep track of this count.
>>>>>> However, since debugfs is now optional, where would be an appropriate
>>>>>> place to store this variable?
>>>>> It is an optional config and can still be enabled if the live update
>>>>> reboot number value needs to be accessed through debugfs. However,
>>>>> given that debugfs does not guarantee a stable interface, tooling
>>>>> should not be built to require these interfaces.
>>>>>
>>>>> In the WIP LUO [1] I have, I pr_info() the live update number during
>>>>> boot and also store it in the incoming LUO FDT tree, which can also be
>>>>> accessed through this optional debugfs interface.
>>>>>
>>>>> The pr_info message appears like this during boot:
>>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: 17
>>>>>
>>>>> Pasha
>>>> Forgot to add link to WIP LUOv5:
>>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
>>>
>>> Thanks a lot. I=E2=80=99ve carefully read this commit:
>>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d83=
f0ff08fa.
>>>
>>> To be honest, I=E2=80=99d like to run some tests with who/luo, includin=
g the
>>> selftest for kho/luo. Could you please share the steps with me?
>>>
>>> If the testing steps have already been documented somewhere, could you
>>> please share the link?
>> Currently the test performs in-kernel tests for FLB data, it creates a
>> number of FLB for every registered LUO file-handler, which at the
>> moment is only memfd.
>>
>> It works together with any of the kexec based live update tests. In
>> v5, I introduce two tests:
>> luo_kexec_simple
>> luo_multi_session
>>
>> For example, with luo_multi_session:
>
> Hi, Pasha
>
> I enabled "CONFIG_LIVEUPDATE=3Dy"
>
> # ./luo_multi_session
> 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
>
> # ls /dev/liveupdate
> ls: cannot access '/dev/liveupdate': No such file or directory
>
> # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
> /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=3Dy
> /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=3Dy
>
> I made tests on FC42. But /dev/liveupdate is missing.

You need to add liveupdate=3D1 to your kernel cmdline to enable LUO and
get /dev/liveupdate.

Pasha, your LUO series doesn't add the liveupdate parameter to
kernel-parameters.txt. I think it should be done in the next version to
this parameter is discoverable.

--=20
Regards,
Pratyush Yadav

