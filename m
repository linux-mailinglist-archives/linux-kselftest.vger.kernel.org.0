Return-Path: <linux-kselftest+bounces-13769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76429321AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6650B282C58
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8264D8B8;
	Tue, 16 Jul 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AGzU49HM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9E2EAEA;
	Tue, 16 Jul 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117484; cv=none; b=uoSBZNVHvhIbHffHS8y548ALi2qvvcRH1hd564dktXiVTyA6OPViMytk3PCuOLPoEtLcXBSp0zlL4wuzo+EZlOj/1yxvGm4fKyn8nr97wHEqxXUR73+0zUAf73pg71Hdzxl6f59GBc/0Ghvf1wLEoTgAXzEtX7nJbt2/KgjKJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117484; c=relaxed/simple;
	bh=JcEKvum93tFQ5UN8u/IXgPRWHhTy03d1OeuFF6uaO+o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WH09Aikw0FZ3owj5UNzLob5xdfxyflQDbey8Nl9wlwx3ngtHZe+cpD+4DgfGmsc56MSQKpb6T/yz3lmoV9Jok5kzv/IRLdFahdbJSYZucl0Et1t9NxHleSjImWK8DnI2W0xLjUBPPbDwYMB0CEihewFU1OOVYsu55lNG5Rb/yLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AGzU49HM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721117481;
	bh=JcEKvum93tFQ5UN8u/IXgPRWHhTy03d1OeuFF6uaO+o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AGzU49HMaw2yj9jTPWsIUMVJjy46sMJZb3y/TqSOmkuFyX8ji8F+nbXVXPWz30LSA
	 6hp+W8kw22Agjr1hzyBgNvRMrFSsb833/vOpfLRmVuZ6broPZlr8G5v/zHLpnib0H/
	 wpcGv8ZRWwzUjeCzsOclZlUmkBnVbLZgNoPLs5xHhGNpasJlykg4PmyDqJxbbbQLTM
	 b34dCE4AfbT7NvkB5SmOGUbeVlPjCbjuFkhuk1Gf3yVzP3FsOd0OcUHRMZVT6wX6nG
	 UFRN5oKGi6gAqTDR6uQ1RathJATCJzDtAISJQ8SNrfYhfXr2w29hG3CAV97CR0xWNc
	 U9Zcr0whT4fEg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F1C53782180;
	Tue, 16 Jul 2024 08:11:18 +0000 (UTC)
Message-ID: <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
Date: Tue, 16 Jul 2024 13:11:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, davidgow@google.com,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
To: Kees Cook <kees@kernel.org>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202407150936.C32FE24CA@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/24 9:40 PM, Kees Cook wrote:
> On Mon, Jul 15, 2024 at 03:09:24PM +0500, Muhammad Usama Anjum wrote:
>> Hi Kees and All,
>>
>> There are several tests in kselftest subsystem which load modules to tests
>> the internals of the kernel. Most of these test modules are just loaded by
>> the kselftest, their status isn't read and reported to the user logs. Hence
>> they don't provide benefit of executing those tests.
>>
>> I've found patches from Kees where he has been converting such kselftests
>> to kunit tests [1]. The probable motivation is to move tests output of
>> kselftest subsystem which only triggers tests without correctly reporting
>> the results. On the other hand, kunit is there to test the kernel's
>> internal functions which can't be done by userspace.
>>
>> Kselftest:	Test user facing APIs from userspace
>> Kunit:		Test kernel's internal functions from kernelspace
> 
> I would say this is a reasonable guide to how these things should
> be separated, yes. That said, much of what was kind of ad-hoc kernel
> internals testing that was triggered via kselftests is better done via
> KUnit these days, but not everything.
I started investigated when I found that kselftest doesn't parse the kernel
logs to mark these tests pass/fail. (kselftest/lib is good example of it)

> 
>> This brings me to conclusion that kselftest which are loading modules to
>> test kernelspace should be converted to kunit tests. I've noted several
>> such kselftests.
> 
> I would tend to agree, yes. Which stand out to you? I've mainly been
> doing the conversions when I find myself wanting to add new tests, etc.
lib
	test_bitmap
	prime_numbers
	test_printf
	test_scanf
	test_strscpy (already converted, need to remove this test)
lock
	test-ww_mutex module
net
	test_blackhole_dev
user
	test_user_copy (probably already converted, need to remove this test)
firmware
	test_firmware
fpu
	test_fpu

Most of these modules are found in lib/*.

Would it be desired to move these to kunit?

-- 
BR,
Muhammad Usama Anjum

