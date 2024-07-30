Return-Path: <linux-kselftest+bounces-14455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED49940A54
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EF41F2442B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25949191F9A;
	Tue, 30 Jul 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vswtGhYZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9C191484;
	Tue, 30 Jul 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325929; cv=none; b=KakuhCykUNgpXlrysrht4yRUz0XZlmMod+EKWooLuZilowWczPc5WrRH3RT8c1/twkSyb0EVjKRj000IDMdieeKnS603IE1ddKmQZaeNmDvgTLDA/35Noiz+uelTk2VWFLQRyb+ilZjsw8RRkFicYxzlC1prQwb6Lu4EjXOrbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325929; c=relaxed/simple;
	bh=bJRHk9jqkIfKZX39JUq1bZcv7ILO8Z7yExEQEkcluwM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K8l5/YqvGKlsPXPo72vvUysc+EXt007257EfLnqLdUbfUN6cjhYMBkyXxOWydmwW9fSNu6aXTZpPUUoDy9Td3vTKVnnNt+5e9LH2VT20yPcnqcP7VBs0Xmjyw5sAHMYM0iFw17ks1e76up/JyBNgTXtJ/F5zckrdiLLwupVRjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vswtGhYZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722325919;
	bh=bJRHk9jqkIfKZX39JUq1bZcv7ILO8Z7yExEQEkcluwM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vswtGhYZFdqzdVA+QCLSmFkGSJsQYcWsBDRCSRBV4f7oh1ud0vrkbdCNvz6ioKQgb
	 a+nYKhqIM4kN9XXH3v3+A5CK1asJnE7jbR33FY16i/MXLzhUHx45/FCyWz8aefvjpq
	 AMatdCdpJFy7K0k0Y3WyI5FcqnhO3b12HAr9qW84YKyX+Cu7951bwbgBBwWcqcsJKk
	 2vVSUmYHnp7VgYoVT+XibLG3dhUGq1gLTWIlfwFay/8UpYKPEDYw9k0mERzHADqBEx
	 JQPrZY230R6n0Ak5xfnIS7dEefWDPcY/CPUz8QKXxJadKK4PbyIrH4H4DMV4KNEE1f
	 YkuA1ruU7LrsA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C87D37809CE;
	Tue, 30 Jul 2024 07:51:52 +0000 (UTC)
Message-ID: <4ed00550-dfc9-4a7b-803a-0a1f5c117d2d@collabora.com>
Date: Tue, 30 Jul 2024 12:51:46 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kees@kernel.org, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Randy Dunlap <rdunlap@infradead.org>, Yury Norov <yury.norov@gmail.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 7:09 PM, Randy Dunlap wrote:
> 
> 
> On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
>> On 7/27/24 10:35 PM, Yury Norov wrote:
>>> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>>>> Rename module to bitmap_kunit and rename the configuration option
>>>> compliant with kunit framework.
>>>
>>> ... , so those enabling bitmaps testing in their configs by setting
>>> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
>>> not realize it until something nasty will happen.
>> CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
>> test and its config option would disappear. The same test can be run by
>> just enabling KUNIT default config option:
>>
>> KUNIT_ALL_TESTS=y enables this bitmap config by default.
>>
>>>
>>> Sorry, NAK for config rename.
>>>  
> 
> I agree with Yury. Using KUNIT takes away test coverage for people who
> are willing to run selftests but not use KUNIT.
How is a kselftest useful when it doesn't even check results of the tests
and report failures when they happen?

-- 
BR,
Muhammad Usama Anjum

