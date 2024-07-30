Return-Path: <linux-kselftest+bounces-14472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E29413B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5341DB295C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09B1A08AC;
	Tue, 30 Jul 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6Pjtl8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89C19D8A6;
	Tue, 30 Jul 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347602; cv=none; b=GOXCW95t4cdNZtSVVp27dCXj0vauyFneEqZZEgnD7XJ2gvGM9AwSUJurheUzZEaPsSSQr6ua6h6lok3SHWGdMc/B06zeW8bcVOYafA8G3pVh8OU7QJhT9Yi4dTZBaN9Z8XcV00o2dPfLktmmeguG/0DaFpvgMN7Eb87bbn4SBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347602; c=relaxed/simple;
	bh=1wt9tbhzxucxujPN3EJqVWuigWyV/ezHUpMX6w9628c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeIjws2jmikVOJQusFCks/5aB6tMpBFD9tsFuowQnyURsWZp4i/oFVIh0TL/65JfZTTZPqBSWMuSHVthRWrTZ6I8pnhO8ZDK+GxQHEUbZ3tMz/Kvhof1LNLvk+C4n3pyP72AReLFFSKEl/j/VEuIJsAUG6Ol0SHywUWdMeKl4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M6Pjtl8f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=C1dDtqY6wlVhNoJaxCgvs1wD1Xs/hztxRhH9qieq1dM=; b=M6Pjtl8fusPjT4FTSmaa38EvA9
	2Uv9BniiXp0x8wCeGvp9NE21prUuBB/jibyLwI3MxX5kqZKNfuSB7sFyILMvDLvrUUjSBaZ/m65+y
	raAZmTvGydkhLQ67BFD/UqkkQzeGZJSClmQQd8YJRwKOYJzIsoTWIT22U2+xVbd0BEcvT6uJrLDtw
	LEPJ99+j3+EDUK3X1rlZqxBZtWaYqxPhnPTDHCC14AZpbplXmHfFq0ZnZHjslurauQSwibsrlgBxJ
	vSC3JlTajU9fLVYhUZQ5VJVv6b27MG/8fJM0OKTzEdVNZFsrGwGl6Zrt6qFy6GV+jdlI/uSda/Z9T
	4FzGmV9Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnHz-0000000FLyf-3uoI;
	Tue, 30 Jul 2024 13:53:20 +0000
Message-ID: <2d1a2d58-d856-41c8-bc8f-c144bc7f2e81@infradead.org>
Date: Tue, 30 Jul 2024 06:53:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kees@kernel.org, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
 <4ed00550-dfc9-4a7b-803a-0a1f5c117d2d@collabora.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4ed00550-dfc9-4a7b-803a-0a1f5c117d2d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 12:51 AM, Muhammad Usama Anjum wrote:
> On 7/29/24 7:09 PM, Randy Dunlap wrote:
>>
>>
>> On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
>>> On 7/27/24 10:35 PM, Yury Norov wrote:
>>>> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>>>>> Rename module to bitmap_kunit and rename the configuration option
>>>>> compliant with kunit framework.
>>>>
>>>> ... , so those enabling bitmaps testing in their configs by setting
>>>> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
>>>> not realize it until something nasty will happen.
>>> CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
>>> test and its config option would disappear. The same test can be run by
>>> just enabling KUNIT default config option:
>>>
>>> KUNIT_ALL_TESTS=y enables this bitmap config by default.
>>>
>>>>
>>>> Sorry, NAK for config rename.
>>>>  
>>
>> I agree with Yury. Using KUNIT takes away test coverage for people who
>> are willing to run selftests but not use KUNIT.
> How is a kselftest useful when it doesn't even check results of the tests
> and report failures when they happen?

That should be an easy fix then.

-- 
~Randy

