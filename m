Return-Path: <linux-kselftest+bounces-14383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C065493F74E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1401282794
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D11514F6;
	Mon, 29 Jul 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AxDGDwdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8E1E515;
	Mon, 29 Jul 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262198; cv=none; b=roz3jVKSoy0LD7O9/hqK0uDZVGFnt1BvjP0LpuPECHbcZ24SkgYms/LV62fxRLMSDYXv7QoBTDK21J/MWqOPxMGFZ8yhh+eAHjCY9ZUeGFuv7OrffqDv0UVXEoiNuvSA5c023I6LcNaOhr8YSSk1jxMx1bgZfmh19bkU+0dKhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262198; c=relaxed/simple;
	bh=G2ICX+0B0sJ4OTP8KnB/JRwckHNWcsVzpMUwi7GmNC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG/6c94SoQa+eB3J+YrpeDch9Tslvy0HwecYMHDo9KGWtxzzxaBShV3+M1cqafsTAzgNVTRDOx7pd7tkHtkMd36UKQxea5YJWOClJqlLDWfbdSrOrCqTMrw8YhtWeIciWXJzVtmpLBW6nq1FTsp1nC0rdLidpTClQSw6aT01ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AxDGDwdQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YKMg1eR49nU9mP5BT5H80HJtVwM4UN3XCxiq9AlD6Qs=; b=AxDGDwdQkUIyPfzsG2RzIdV5Jz
	CMpT6EUqG7pfoDOQoF96JLLvy5tb4Asm5+5cSoZwrrJdg9i5CmZ9U8aTtq7VQhQaAJbYDGCkt+VvI
	jIME6iXfONJePp9guNLFtNktysPG1T8zX6EZ99tJydbg2CbCf8gd7fDLMM5dIPSYjTnc6rFhMmpca
	MU9w1vQPUUOC2SG0KNb6JXnvQRF6ulWJQtgV1x3H567bMse2x/jdm4MzAi2ih+Xa+RPEmrSTL0uQX
	/QgQfHAdY5pe2Fi2CD+7FeS89eN4nXl5/PY/MTliZ9iOKUoq3m80rd8/vSsUzadjWHme5FZOoAltJ
	vCE+TFkA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYR4U-0000000BW64-0izi;
	Mon, 29 Jul 2024 14:09:54 +0000
Message-ID: <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
Date: Mon, 29 Jul 2024 07:09:52 -0700
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
> On 7/27/24 10:35 PM, Yury Norov wrote:
>> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>>> Rename module to bitmap_kunit and rename the configuration option
>>> compliant with kunit framework.
>>
>> ... , so those enabling bitmaps testing in their configs by setting
>> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
>> not realize it until something nasty will happen.
> CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
> test and its config option would disappear. The same test can be run by
> just enabling KUNIT default config option:
> 
> KUNIT_ALL_TESTS=y enables this bitmap config by default.
> 
>>
>> Sorry, NAK for config rename.
>>  

I agree with Yury. Using KUNIT takes away test coverage for people who
are willing to run selftests but not use KUNIT.


-- 
~Randy

