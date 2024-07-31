Return-Path: <linux-kselftest+bounces-14516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C05942A62
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FD8B24016
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1C1AAE0F;
	Wed, 31 Jul 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G+BStfY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646417C8D;
	Wed, 31 Jul 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417931; cv=none; b=s6qK8DN+a1cGebCvrqjZeKrP3NTHgrq/v2l/UmXLKmPfYcI+lK0ftShE7YAAng1LT73IkafJ+bGGfuR5B3xgK6jUH0jG61ZpyVu6/HzrQ6CnjJ+ykOeRpLHrt1n8mq27vsqFyfEJIv6JKAfq+bxQ1oCq/ctKDXPz24Vrmwuk6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417931; c=relaxed/simple;
	bh=ue/PB64cckoJitZCyfeYBtG43Mc4aZphadG5eqHJ2u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSyD715HF233YxtJ4szF/2Z1lhwAA5aKmOLTohbKbzAdlmqjoYNF8MkiDSX6YlNjfQSHNAa85QPEZdYqAl1jOuoqGXXOPHvhHZ8bpQyeLreEstJp43uuZRzDg7HWOdbBmS7P41vHjg4XcNZ58pku5ZaB6tjfX1H5UolHEp0rBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G+BStfY4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722417927;
	bh=ue/PB64cckoJitZCyfeYBtG43Mc4aZphadG5eqHJ2u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+BStfY4MQo2fXoR2J2o9uN5ExfVzyOxhzIFoGzxg+gZEZuEjLNTg2aoTQcecst6d
	 UQthcp2UWUHHdxkv9yd4gnyhWjreuNklZ6ePx3O3rvQ8HIPEgnh+0cqQLYK4XyvUDC
	 RoPbpUFp49kBCChKyKu9UnahoP66wF4lfJb5ClwAkC1Yu5jW4aYQOQmUxCNBb6CUUW
	 zL+15vjkIcIVZiq1UD42JbpAYUXSLKYiIZ3SZbHh/IAOsZraJFrfTW7MaNKLz/SuCM
	 lXRYraR197mchH2gPHntYIp65pZNneeCvluGNgIs2UGCa7tdeFC1BvkH8giwqOh5o0
	 DqHnG+kIkCR4Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 474E73780BC9;
	Wed, 31 Jul 2024 09:25:26 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: kernel@collabora.com,
	kernelci@lists.linux.dev,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mhiramat@kernel.org,
	shuah@kernel.org,
	tim.bird@sony.com
Subject: Re: [RFC PATCH 1/1] kselftests: Add test to detect boot event slowdowns
Date: Wed, 31 Jul 2024 11:25:34 +0200
Message-Id: <20240731092534.16213-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <65c59f75-3810-4490-991e-62b5aafe1f5a@linuxfoundation.org>
References: <65c59f75-3810-4490-991e-62b5aafe1f5a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 7/25/24 17:50, Shuah Khan wrote:
> On 7/25/24 05:06, Laura Nao wrote:
>> Introduce a new kselftest to identify slowdowns in key boot events.
>> The test uses ftrace to track timings for specific boot events.
>> The kprobe_timestamps_to_yaml.py script can be run once to generate a
>> YAML file with the initial reference timestamps for these events.
>> The test_boot_time.py script can then be run on subsequent boots to
>> compare current timings against the reference values and check for
>> significant slowdowns over time.
>> The test ships with a bootconfig file for ftrace setup and a config
>> fragment for the necessary kernel configurations.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> 
> I am repeating the same comments I made on the cover letter here as
> well.
> 
> What are the dependencies if any for this new test to work?
> Please do remember that tests in default run needs to have
> minimal dependencies so they can run on systems that have
> minimal support.
>

In order to run this test the kernel needs to be compiled with the
provided config fragment, which enables tracing and embeds the provided
bootconfig file in the kernel. Additionally, a YAML file with reference 
timestamps must be supplied as input to the test.
 
> As mentioned earlier take a look at the tools/power/pm-graph
> bootgraph.py and sleepgraph.py to see if you can leverage
> them - bootgraph detects slowdowns during boot.
> 
> We don't want to add duplicate scripts if the other one
> serves the needs. Those can be moved to selftests if it
> make sense.
> 
> I will review this once we figure out if bootgraph serves
> the needs and I understand the dependencies for this test
> to work.
> 

Thanks for the pointers! 

It looks like sleepgraph.py is more focused on analyzing suspend/resume 
timings, while bootgraph.py measures boot time using the kernel log and 
ftrace. The latter might indeed come in handy.
As far as I can see, the script doesn't support automatic detection of 
boot slowdowns, and the output is in HTML format, which is meant for 
human analysis. However, I can look into adding support for a more 
machine-readable output format too. The test proposed in this patch could 
then use bootgraph.py to generate the reference file and measure current 
boot timings.

I'll look into this and report back.

Thanks,

Laura


