Return-Path: <linux-kselftest+bounces-12562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B647C915136
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC172B25FC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986F19AD81;
	Mon, 24 Jun 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="duOHb2za"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C0192B67;
	Mon, 24 Jun 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241186; cv=none; b=G518ZWZmRyX74a8764Es3je2wb4nkZABa19xouSJLCcrC3APicnqOFLV8NMJl6PpRTCJyshz/hre4HYU/UkFVo68QiNRgCcDRzZFw64sBuiz8Nn8O7Ea9716mI0waKtRl6SdAJnJtW41QswU+0H5Xcj36RqhqA9x1xe6F1HiykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241186; c=relaxed/simple;
	bh=9xaJDh1TnKMficbAlDxInx8h5y/0mTRX9rf4/9QzidI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIgESnw062mwq1TJBu+WUkVHkYuCu0AQxx6hiTnK3B4OF2AvkhwV3KzRM3YzdithnfjF08r92dFvLNdZ8LMXltl0u016cw55Ec7q4C679M9LgR86ydZdJyUr1f6qbjzUbzK7ehQIG922FkmHPRwdyZeXiLnOjK5OdAhWHS81amI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=duOHb2za; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719241182;
	bh=9xaJDh1TnKMficbAlDxInx8h5y/0mTRX9rf4/9QzidI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duOHb2zal2/Ccb+OTlEFXhUjQcuf7n8vGx5x3QJFjBLTT8QL/FFitFpWz7miBGC5p
	 gXoAzbuAftUNaEFXkwnli+TSKoHKU7lAOEjPAGIWORfMIuwdu41uGbnq/TNfHIufDP
	 s+x3bbWIAp8jxf4zrHhy+YvEYcbimiUNyZdaVeBB0QZpyibRelSqHQvgSoS5orBYqc
	 l3oxKgurQgElLqqJduuUvo+WanP/nH3cxYD6GgfgNDs3gbuprxt/x1NoeEPSk+Ljqb
	 6U8Vyq8XNPEbfCZemaW/GZ8Tz5Jf0F19KkJNC7MYpG97AdFOLPZtxZGaeonguEb6X5
	 ceM0VfDjSUO8A==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5305A378216C;
	Mon, 24 Jun 2024 14:59:41 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
Date: Mon, 24 Jun 2024 17:00:04 +0200
Message-Id: <20240624150004.116810-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <76a6a3d1-bbf7-436a-a977-4e5c49db69ac@linuxfoundation.org>
References: <76a6a3d1-bbf7-436a-a977-4e5c49db69ac@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/21/24 23:08, Shuah Khan wrote:
> On 6/18/24 07:40, Laura Nao wrote:
>> Hi Shuah,
>>
>> On 6/7/24 23:07, Shuah Khan wrote:
>>> On 6/7/24 03:53, Laura Nao wrote:
>>>> Hi Shuah,
>>>>
>>>> On 6/7/24 01:03, Shuah Khan wrote:
>>>>> On 6/6/24 03:57, Laura Nao wrote:
>>>>>> Hi Shuah,
>>>>>>
>>>>>> On 5/6/24 13:13, Laura Nao wrote:
>>>>>>> The watchdog selftest script supports various parameters for
>>>>>>> testing
>>>>>>> different IOCTLs. The watchdog ping functionality is validated
>>>>>>> by
>>>>>>> starting
>>>>>>> a loop where the watchdog device is periodically pet, which can
>>>>>>> only
>>>>>>> be
>>>>>>> stopped by the user interrupting the script.
>>>>>>>
>>>>>>> This results in a timeout when running this test using the
>>>>>>> kselftest
>>>>>>> runner
>>>>>>> with no non-oneshot parameters (or no parameters at all):
>>>>>
>>>>>
>>>>> Sorry for the delay on this.
>>>>>
>>>>> This test isn't include in the default kselftest run? How are you
>>>>> running this?
>>>>>
>>>>
>>>> The goal of this series is to enable the test to be run using the
>>>> kselftest runner individually, not as part of the default run. So
>>>> for
>>>> example w/out args:
>>>>
>>>> make -C tools/testing/selftests TARGETS=watchdog run_tests
>>>>
>>>> or with args:
>>>>
>>>> KSELFTEST_WATCHDOG_TEST_ARGS='-b -d -e -s -t 12 -T 3 -n 7 -N -L' 
>>>> make -C
>>>> tools/testing/selftests TARGETS=watchdog run_tests
>>>>>>>
>>>>>>>      TAP version 13
>>>>>>>      1..1
>>>>>>>      # timeout set to 45
>>>>>>>      # selftests: watchdog: watchdog-test
>>>>>>>      # Watchdog Ticking Away!
>>>>>>>      # .............................................#
>>>>>>>      not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 
>>>>>>> seconds
>>>>>>>
>>>>>>> To address this issue, the first patch in this series limits the
>>>>>>> loop
>>>>>>> to 5
>>>>>>> iterations by default and adds support for a new '-c' option to
>>>>>>> customize
>>>>>>> the number of pings as required.
>>>>>>>
>>>>>>> The second patch conforms the test output to the KTAP format.
>>>>>>>
>>>>>>
>>>>>> Gentle ping - any thoughts on this series? It would simplify
>>>>>> running
>>>>>> the
>>>>>> watchdog kselftest in CI environments by leveraging the runner.
>>>>>>
>>>>>
>>>>> This test isn't intended to be included in the default run. It
>>>>> requires
>>>>> loading a watchdog driver first. Do you load the driver from the
>>>>> runner?
>>>>>
>>>>
>>>> I get this test requires watchdog drivers to be loaded (which in
>>>> this
>>>> case can't be added to a config fragment that goes with the 
>>>> selftest, as
>>>> they are platform-specific) and therefore cannot be included in the
>>>> default run. However, having ktap output support and limiting the
>>>> ping
>>>> loop would allow the test to be run individually in the same way as
>>>> other selftests (so through the kselftest runner).
>>>>
>>>> Naturally, driver dependencies must be met for the test to run and
>>>> produce valid results. From my understanding the runner itself
>>>> cannot
>>>> ensure this, so in this case it would be up to the user or CI to
>>>> enable/load the appropriate drivers before running the test.
>>>> If these dependencies are not satisfied, the test could just exit
>>>> with a skip code.
>>>>
>>>> Does this make sense to you? or is the kselftest runner intended to
>>>> be
>>>> used to run exclusively a subset of tests in the selftests
>>>> directory
>>>> (i.e. the ones that don't have platform-specific driver
>>>> requirements)?
>>>>
>>>
>>> There are several tests that aren't included in the default run
>>> because
>>> they have dependencies and potentially damaging to the running
>>> system.
>>> These tests are not included for a reason.
>>>
>>> The first step would to be ensure writing shell script to load and
>>> unload the watchdog module and then pass in existing parameters such
>>> as the oneshot to run the test.
>>>
>>> There is no need to add a new parameter yet. Also there is no need
>>> to
>>> convert this to ktap yet.
>>>
>>
>> To clarify, I understand that this test is not suitable for the
>> default
>> run, and I do not intend to change that. The patch series is meant to
>> make the test usable in a non-interactive environment, such as a CI,
>> when explicitly enabled and with the required modules already loaded.
>>
> 
> The test can be with one shot timer - how is this test currently not
> usable and how are your changes making it usable?
> 

In a non-interactive environment, the current test can only be run
through the oneshot parameters, making it impossible to test the
WDIOC_KEEPALIVE ioctl (since the ping loop is only interrupted by
SIGINT). So the first patch enables testing of the WDIOC_KEEPALIVE ioctl
in such an environment, by making the ping loop finite. 
The second patch allows the reuse of the ktap result parser used for
other kselftests, eliminating the need for a custom parser for this
test.

Thanks,

Laura


