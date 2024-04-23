Return-Path: <linux-kselftest+bounces-8715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 262678AEAB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DB4B21BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC213C3CC;
	Tue, 23 Apr 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZyvvSgpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAE5820E;
	Tue, 23 Apr 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885418; cv=none; b=Niz4XSU0rbzHyYYD4rzfDT6g/ytAO+XlxjriMPpTuXcZp5X+z2QOzCKbY9ZmKDeozZLsuapERrRBNpU1u0mL0kxVUf3c6iOS+cCIXdwQfg9rYLcnqiSyF9oTErRtedfZ9I+gGDsIsaMBU6s01bmu+kxhB8eeWW5VYxUmW18x1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885418; c=relaxed/simple;
	bh=h4yQKZsodwASQ8BaWwplG73xDGyXx08Io8ws3yHb43k=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=IHk2xpZGR5VkFiGcU0bAKXH3pZM5x9tBy/0uB8yZ7/33Tz0b+3E68/MGguCBxB6WEAFhlgH6siUoyfVR9sJmq6EJPsAsMZXrcuy/60ABrh7DMGFs8fskSstitKlzt4sln6X05w2qaOukpms2i4+OOcxVcO3T1Nyys5pQ/yD/q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZyvvSgpz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713885413;
	bh=h4yQKZsodwASQ8BaWwplG73xDGyXx08Io8ws3yHb43k=;
	h=Date:Cc:To:From:Subject:From;
	b=ZyvvSgpzomYyJOPD5OJaqVcG/9zmB0NKqRCIboLLNkHkNpvggR7JbbJMXNckipZci
	 wJg66TIZOOBf+DFQ9fOkSala8QAu0vnDDKlI+IGG8+iwNTpan0OSMC76ZsHHfotZkF
	 X9IyhcCfyfXjoadBS+Pzr3s/V1iE1A54TUaG+EfzhyJycL6uDyKcq69uC6l+VQL0e1
	 faMnqXVkHCQrWhvlruBdwDeELAuM0FcBju/dnNu7iNYP9YGh74D9IFh+5CEeJIC9re
	 aUU37CgTkP3pOw0Hv8QfPxl9S2ge/Yku/kbMw/MgGs0FNPaOHj06t8NKmAtLAzyHe7
	 JNDeqd9nzAbUw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B7CE37811D1;
	Tue, 23 Apr 2024 15:16:49 +0000 (UTC)
Message-ID: <02c3926c-84fe-4526-a746-6964f5290c14@collabora.com>
Date: Tue, 23 Apr 2024 20:17:18 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 automated-testing@lists.yoctoproject.org,
 "kernel@collabora.com" <kernel@collabora.com>, kernelci@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>, gustavo.padovan@collabora.com,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Laura Nao <laura.nao@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Helen Mae Koike Fornazier <helen.koike@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Improving the testing quality of the kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I've been working with colleagues at Collabora to improve the testing
quality overall for kselftests since several months. We had identified
following key points to improve:
* Make non-TAP conformant tests, TAP conformant to catch the bugs/failures
in the CI and non-CI environment. Without clear success or failure message,
it is difficult and at times impossible to notice the bugs and which part
of the test or sub-test has failed.
* Add config fragment if it is already isn't present.
* Improve ancient tests to be robust. KernelCI helps a lot in finding
flakiness or non-robust pieces of code by building it in range of
configurations and running it on range of hardware.

As new KernelCI is in works, we are identifying which kselftest suites
could be most suitable to be enabled in the start to keep the noise to a
minimum. The criteria to enable a suite on KernelCI is:
* The test suite is TAP compliant
* The test suite passes in preliminary testing on x86_64 and ARM64 platforms
* The test suite builds fine with Clang in-addition to gcc

To facilitate transparency and track our progress, I am diligently
maintaining a spreadsheet [1] with detailed information about each suite's
status and requirements.

Furthermore, I have commenced exploration into KUnit testing, and initial
results are promising. I plan to delve deeper into KUnit testing and will
provide further updates in the coming days.

Your feedback, insights and collaboration on any aspect of these
initiatives would be highly valuable. We greatly appreciate your
collaboration and support as we continue to enhance the testing quality of
kselftests.

[1]
https://docs.google.com/spreadsheets/d/1XRCgxlY1b74aIOIXQ7qDR-62KTJmuV1ow9st4fpeVhA/edit?usp=sharing

-- 
BR,
Muhammad Usama Anjum

