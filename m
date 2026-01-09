Return-Path: <linux-kselftest+bounces-48637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A4D0C91D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5C230255A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF92EDD62;
	Fri,  9 Jan 2026 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppZ3pm0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B5253950;
	Fri,  9 Jan 2026 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002702; cv=none; b=ZjjVj5BqKc2bOhFyOsBSBmOKd0+7BOX0EktF9flywrgX/1uhJPQdLQvotEHFmQ3ae0Mne4SZSLlElxKSJ/BEN3+5W5i5P5x7xaM63cSg1dJH1A+qjb972xG6k1zvW2BQCzPow+HBj12bv3WAVrhEIM2Dz7kSEulxFmYYCHiyIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002702; c=relaxed/simple;
	bh=cGjPthbQutvG5xFLlcwjuXKwp0hbnSQtg9LnfpnTQ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pa+JGkrnvaAVszBR9IFNqaiiktAsLYB1/SGF7JgO6QeL+mqSSSb3gbzMP9n3IvLv7T5LaB+n7MbLz1PJeXs3ldjpfe7SyN5bhw6+DrLM7buHMCB+cDbfJ2OhGZY0UHpOGnmeIp3PHUoGufIeKeX0oa06kgEApCybs1M9ObFZwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppZ3pm0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE7DC4CEF1;
	Fri,  9 Jan 2026 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768002702;
	bh=cGjPthbQutvG5xFLlcwjuXKwp0hbnSQtg9LnfpnTQ5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ppZ3pm0dSiCsvTQq3Kr+8rcqkTsfOP/JAZ4rl8h162hYyMUuHZkIA0QuZOknfp3X+
	 px/eH/rQl4RgVZ2MqJHj53W6ba0xQHdvuLFbabhytwfQi5aKkMSyTc1EIP7cJdX4mU
	 uOnU0G0AquIq9TeP9Zh3TJrdRkW0Y5SoUs9iVEpUXTVCByN6itu8TbFjmKVjYFOLLr
	 js6l+9mL0GLFchx0cgBEzA9EId5rnVz3vGwJ4/NEnsrtc5dkn2GWy6QloVBcwKREET
	 xva7g1V+HCrbB6IKOy2hgo3cQGCwbGeQz+efbEJ397CnRBFUPqqAlB1dbc/ZBfdkPa
	 qDNFFzPWnOgrw==
Message-ID: <3692e9fb-b827-413f-902e-a57d6d3aca20@kernel.org>
Date: Fri, 9 Jan 2026 16:51:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] selftests/resctrl: Add Hygon CPUs support and bug
 fixes
To: Reinette Chatre <reinette.chatre@intel.com>,
 Xiaochen Shen <shenxiaochen@open-hieco.net>, tony.luck@intel.com,
 bp@alien8.de, fenghuay@nvidia.com, shuah@kernel.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
 <bdecae64-5f6e-42d4-a05b-3334b95e6ec0@intel.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <bdecae64-5f6e-42d4-a05b-3334b95e6ec0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 1/8/26 09:02, Reinette Chatre wrote:
> Dear Shuah,
> 
> Could you please consider this series for inclusion?
> 
> Thank you very much.
> 
> Reinette
> 
> On 12/16/25 7:04 PM, Xiaochen Shen wrote:
>> The resctrl selftest currently exhibits several failures on Hygon CPUs
>> due to missing vendor detection and edge-case handling specific to
>> Hygon's architecture.
>>
>> This patch series addresses three distinct issues:
>> 1. A division-by-zero crash in SNC detection on some platforms (e.g.,
>>     Hygon).
>> 2. Missing CPU vendor detection, causing the test to fail with
>>     "# Can not get vendor info..." on Hygon CPUs.
>> 3. Incorrect handling of non-contiguous CBM support on Hygon CPUs.
>>
>> These changes enable resctrl selftest to run successfully on
>> Hygon CPUs that support Platform QoS features.
>>
>> Maintainer notes:
>> -----------------
>> Patch 1: selftests/resctrl: Fix a division by zero error on Hygon
>>   - This is a candidate for backport with "Fixes:" tag.
>>
>> Patch 2: selftests/resctrl: Define CPU vendor IDs as bits to match usage
>>   - This is *not* a candidate for backport since it is an enhancement and
>>     preparatory patch for patch 3.
>>
>> Patch 3: selftests/resctrl: Add CPU vendor detection for Hygon
>> Patch 4: selftests/resctrl: Fix non-contiguous CBM check for Hygon
>>   - Even though they are fixes they are *not* candidates for backport
>>     since they are based on another patch series (x86/resctrl: Fix
>>     Platform QoS issues for Hygon) which is in process of being added to
>>     resctrl.
>> -----------------

Applied to linux-kselftest next branch for Linux 6.20-rc1

thanks,
-- Shuah

