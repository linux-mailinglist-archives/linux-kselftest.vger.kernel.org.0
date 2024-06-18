Return-Path: <linux-kselftest+bounces-12154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79990D36D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E9286BE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145831581F3;
	Tue, 18 Jun 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pckABaWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63513AD12;
	Tue, 18 Jun 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718007; cv=none; b=kdz4Zc3qPDNrhQlIPgmqEKsGlKPBNjzW/lLS1N2lVCcytsR3xCjy3ftSsOqBLrVHJ0Sghk75d4R3E2/kNaKF0Poh0aVniqlSkRQu+KTEnqyHdEoPNakJVkhyHZoZK27gAoV5cl+Okit0G96boOywifcQuh3cNutJLDe3ksP0OL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718007; c=relaxed/simple;
	bh=cAaod5HbTedft+jMo3WIKmXctomGqzUQNoSvFCGJvi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9trs+PqLcggLitcnPkuVR0lWqjAaqSs5Zw4DlFX463RQCSZJW3jcSW82iNiLfPJ7o72A3rUEcF+p7s9nfDceJ9OKs8Y/amEr4qVbNnHvYVi/iOSJnvVsEXPorbSHce1opGtghX3qcf4axLKOYBvANaHyh4iQkoCs246qe1c09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pckABaWZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718718003;
	bh=cAaod5HbTedft+jMo3WIKmXctomGqzUQNoSvFCGJvi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pckABaWZ3hVo9nTfD1W2aQXKoWjWr7T/BF35en54t45UqhduimLvtya5ZqbxEDBfi
	 fGusPlEY2UfuQNhryxE/m7vla8XrS1ahHDtjyHOdXZRYQelbMkt3HlYf32pgDA3616
	 qig8+w5KK3U3z+VO7eB56ZEW7I9Oa9C29XO3/fRsySBkQe8a66K74226VS9ki/0NLv
	 OWiG8jGnNIGz4daVfjtbEbpY7bMaMorQSSzXVZkdap5bal18QWT/et9WvI7IrYbufy
	 rWrGq10pVzGQFpw4IbnxxkPWsoIXzYIOgpt/fXp/Ax1VMe/ImcyveAwqv9SXvxGTuX
	 Cy37JPxL5Liag==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E487037811D1;
	Tue, 18 Jun 2024 13:40:02 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
Date: Tue, 18 Jun 2024 15:40:38 +0200
Message-Id: <20240618134038.54803-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <987ba13d-e645-496a-8ec8-91b6399efa4c@linuxfoundation.org>
References: <987ba13d-e645-496a-8ec8-91b6399efa4c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 6/7/24 23:07, Shuah Khan wrote:
> On 6/7/24 03:53, Laura Nao wrote:
>> Hi Shuah,
>>
>> On 6/7/24 01:03, Shuah Khan wrote:
>>> On 6/6/24 03:57, Laura Nao wrote:
>>>> Hi Shuah,
>>>>
>>>> On 5/6/24 13:13, Laura Nao wrote:
>>>>> The watchdog selftest script supports various parameters for testing
>>>>> different IOCTLs. The watchdog ping functionality is validated by
>>>>> starting
>>>>> a loop where the watchdog device is periodically pet, which can only
>>>>> be
>>>>> stopped by the user interrupting the script.
>>>>>
>>>>> This results in a timeout when running this test using the kselftest
>>>>> runner
>>>>> with no non-oneshot parameters (or no parameters at all):
>>>
>>>
>>> Sorry for the delay on this.
>>>
>>> This test isn't include in the default kselftest run? How are you
>>> running this?
>>>
>>
>> The goal of this series is to enable the test to be run using the
>> kselftest runner individually, not as part of the default run. So for
>> example w/out args:
>>
>> make -C tools/testing/selftests TARGETS=watchdog run_tests
>>
>> or with args:
>>
>> KSELFTEST_WATCHDOG_TEST_ARGS='-b -d -e -s -t 12 -T 3 -n 7 -N -L' make -C
>> tools/testing/selftests TARGETS=watchdog run_tests
>>>>>
>>>>>     TAP version 13
>>>>>     1..1
>>>>>     # timeout set to 45
>>>>>     # selftests: watchdog: watchdog-test
>>>>>     # Watchdog Ticking Away!
>>>>>     # .............................................#
>>>>>     not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>>>
>>>>> To address this issue, the first patch in this series limits the
>>>>> loop
>>>>> to 5
>>>>> iterations by default and adds support for a new '-c' option to
>>>>> customize
>>>>> the number of pings as required.
>>>>>
>>>>> The second patch conforms the test output to the KTAP format.
>>>>>
>>>>
>>>> Gentle ping - any thoughts on this series? It would simplify running
>>>> the
>>>> watchdog kselftest in CI environments by leveraging the runner.
>>>>
>>>
>>> This test isn't intended to be included in the default run. It
>>> requires
>>> loading a watchdog driver first. Do you load the driver from the
>>> runner?
>>>
>>
>> I get this test requires watchdog drivers to be loaded (which in this
>> case can't be added to a config fragment that goes with the selftest, as
>> they are platform-specific) and therefore cannot be included in the
>> default run. However, having ktap output support and limiting the ping
>> loop would allow the test to be run individually in the same way as
>> other selftests (so through the kselftest runner).
>>
>> Naturally, driver dependencies must be met for the test to run and
>> produce valid results. From my understanding the runner itself cannot
>> ensure this, so in this case it would be up to the user or CI to
>> enable/load the appropriate drivers before running the test.
>> If these dependencies are not satisfied, the test could just exit
>> with a skip code.
>>
>> Does this make sense to you? or is the kselftest runner intended to be
>> used to run exclusively a subset of tests in the selftests directory
>> (i.e. the ones that don't have platform-specific driver requirements)?
>>
> 
> There are several tests that aren't included in the default run because
> they have dependencies and potentially damaging to the running system.
> These tests are not included for a reason.
> 
> The first step would to be ensure writing shell script to load and
> unload the watchdog module and then pass in existing parameters such
> as the oneshot to run the test.
> 
> There is no need to add a new parameter yet. Also there is no need to
> convert this to ktap yet.
> 

To clarify, I understand that this test is not suitable for the default 
run, and I do not intend to change that. The patch series is meant to 
make the test usable in a non-interactive environment, such as a CI,
when explicitly enabled and with the required modules already loaded.

Thanks,

Laura


