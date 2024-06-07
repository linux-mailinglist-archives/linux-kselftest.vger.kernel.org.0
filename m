Return-Path: <linux-kselftest+bounces-11347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F858FFFE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 11:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC18283BD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE315746C;
	Fri,  7 Jun 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jSkC3xvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200BDDD9;
	Fri,  7 Jun 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754005; cv=none; b=MMQsdhxzay+TswcNzMuPhW0H0/O7yFRYmC8w5NP4RwHfpAOjddQPYKUJdYeMCrTAwDMcb7TdcVryXrr1sJtKGDJoHVQD3fCSNTAE6cEw6duS3QncktIkwEW+dijtSiLjful24r/kMh8Mcmq6LXywnW7hBs/1tv2sSSXDruPiyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754005; c=relaxed/simple;
	bh=OEGZp0RgQUhhB+4aici91AXClSBltAqToX+N8t+Qx6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wlg5tX4otwdZ5VHoa299k9q3sFLHn4rQ88by8rdfAk+jyy3HvhEzV6Z18zLgZOOct3EH7mARSPOIi2kQp0lhwnLg0LmBKdarh+Y7eY66QnuptQ0srLJm585NsAJeqpCVqiQ4f4G54ISVRX/DByxSm1MXv3GG0zcvKHtkodHz3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jSkC3xvS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717754002;
	bh=OEGZp0RgQUhhB+4aici91AXClSBltAqToX+N8t+Qx6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSkC3xvSDVouWmD4Pk7BJ3si8tDuT/9kjaQ6U4KEaI15VUFfXpsRTjInbX9E4gWBF
	 NTdsbQIePCUU8SHx+xoLaDMjPnKuF+XsIjPH/zRAo+xMRurX/IDw6ZM8DsxB/EtVI1
	 d4DWvYuAE+BZYMtajFzE5uqecIV0pZfIfc7kvKBLs6tlVP/xLiniVZjF0Cwko4OFGY
	 88fKFZ1eoV/++RbwMQ6dYtwN+0wi3hd9ZG/iLjYsrvzrFNk6kJqSY3YyK56VYlgNlC
	 6VrQk6PjfkhqcCMmzsC0pJ2XpUAwnsxIr8UW0osKP7T3PBINaygvAR2UOPkdPcxucH
	 9NyAzLx0FxKTQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1D43B37811D1;
	Fri,  7 Jun 2024 09:53:22 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
Date: Fri,  7 Jun 2024 11:53:47 +0200
Message-Id: <20240607095347.127823-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <646f0597-240a-4251-b45e-e45f504734a9@linuxfoundation.org>
References: <646f0597-240a-4251-b45e-e45f504734a9@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 6/7/24 01:03, Shuah Khan wrote:
> On 6/6/24 03:57, Laura Nao wrote:
>> Hi Shuah,
>>
>> On 5/6/24 13:13, Laura Nao wrote:
>>> The watchdog selftest script supports various parameters for testing
>>> different IOCTLs. The watchdog ping functionality is validated by
>>> starting
>>> a loop where the watchdog device is periodically pet, which can only
>>> be
>>> stopped by the user interrupting the script.
>>>
>>> This results in a timeout when running this test using the kselftest
>>> runner
>>> with no non-oneshot parameters (or no parameters at all):
> 
> 
> Sorry for the delay on this.
> 
> This test isn't include in the default kselftest run? How are you
> running this?
>

The goal of this series is to enable the test to be run using the
kselftest runner individually, not as part of the default run. So for
example w/out args:

make -C tools/testing/selftests TARGETS=watchdog run_tests

or with args:

KSELFTEST_WATCHDOG_TEST_ARGS='-b -d -e -s -t 12 -T 3 -n 7 -N -L' make -C
tools/testing/selftests TARGETS=watchdog run_tests
 
>>>
>>>    TAP version 13
>>>    1..1
>>>    # timeout set to 45
>>>    # selftests: watchdog: watchdog-test
>>>    # Watchdog Ticking Away!
>>>    # .............................................#
>>>    not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>
>>> To address this issue, the first patch in this series limits the
>>> loop
>>> to 5
>>> iterations by default and adds support for a new '-c' option to
>>> customize
>>> the number of pings as required.
>>>
>>> The second patch conforms the test output to the KTAP format.
>>>
>>
>> Gentle ping - any thoughts on this series? It would simplify running
>> the
>> watchdog kselftest in CI environments by leveraging the runner.
>>
> 
> This test isn't intended to be included in the default run. It
> requires
> loading a watchdog driver first. Do you load the driver from the
> runner?
>

I get this test requires watchdog drivers to be loaded (which in this
case can't be added to a config fragment that goes with the selftest, as
they are platform-specific) and therefore cannot be included in the
default run. However, having ktap output support and limiting the ping
loop would allow the test to be run individually in the same way as
other selftests (so through the kselftest runner). 

Naturally, driver dependencies must be met for the test to run and
produce valid results. From my understanding the runner itself cannot
ensure this, so in this case it would be up to the user or CI to
enable/load the appropriate drivers before running the test.
If these dependencies are not satisfied, the test could just exit
with a skip code.

Does this make sense to you? or is the kselftest runner intended to be
used to run exclusively a subset of tests in the selftests directory
(i.e. the ones that don't have platform-specific driver requirements)?

Thanks,

Laura

