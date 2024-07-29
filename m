Return-Path: <linux-kselftest+bounces-14352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5990193EF26
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B4D1F21CC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAB12C530;
	Mon, 29 Jul 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nrFoZ15u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25761EB2C;
	Mon, 29 Jul 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239759; cv=none; b=CVbrZSpePhFxQ978BcvXkYBQaOJf7f8D3bjmPXBPKuRpG1etP4BZd6w5y8v/Cn8PXyK45U4l0tfZnYg3NZRYxiJzc3ecxiEnJtDBjuZdeY2jz5vgGRt0bftnvOoZ6lxL7cLMs4sZi20NhnO9hLYEdr8gbNFoeMg4ldFbdlNPGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239759; c=relaxed/simple;
	bh=8GFkxSadx10rFZuzZEfW0t56ehKdFZhS465NJerFFgQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QU52aJprBSzPVBvLluz79vI7szYJ/TA/ndzzmVq8v/NrMRjZjz9fJoEblLqbVTafOyaXVSzbJcwy1sZwzs8VN7jjOWi27Rv8F+Fj+0C+PqfA/vQx8lqRx9w874eiyplng/fXuS628T1exoqjYDrKccs1LCz5iKbp+srLEKmCc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nrFoZ15u; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722239756;
	bh=8GFkxSadx10rFZuzZEfW0t56ehKdFZhS465NJerFFgQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nrFoZ15uEUpOcs8OtdCV0HndWpeUdk79EDpiwP1MdJ7+YpEPZAbXM9Bwi4Bld2Ewv
	 YTFgGmZ98OUv7ug98hpexOnBVBNC7J7R5fuWeFau6Ck4JjJhOsbVBEXP4nKkdZLu/5
	 cDgtf64t2If9OCwl8Hm7yText0TydPXoAO6UOCEAVnW7uqy3t93mdoXg4qXY683Heu
	 Pj1ncV9/rIUs/CxBk5L5XoDjXp58aRvCccF0mZw+ocnNo7BRr99oIeV8+sPe7CVCRE
	 pCCLua65hZetARCVaBG11CpkoCX4Di9+vJQsibXYk1aBvY8yQv3YioH5/xyZKRUb/i
	 RmvNocRDaTW7w==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B5F5437809CE;
	Mon, 29 Jul 2024 07:55:53 +0000 (UTC)
Message-ID: <a3083ad4-e9dc-40da-bf57-8391bcd96a6c@collabora.com>
Date: Mon, 29 Jul 2024 12:55:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: Converting kselftest test modules to kunit
To: Shuah Khan <skhan@linuxfoundation.org>, Kees Cook
 <keescook@chromium.org>, davidgow@google.com
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/27/24 12:35 AM, Shuah Khan wrote:
> On 7/15/24 04:09, Muhammad Usama Anjum wrote:
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
>> Kselftest:    Test user facing APIs from userspace
>> Kunit:        Test kernel's internal functions from kernelspace
>>
>> This brings me to conclusion that kselftest which are loading modules to
>> test kernelspace should be converted to kunit tests. I've noted several
>> such kselftests.
>>
>> This is just my understanding. Please mention if I'm correct above or more
>> reasons to support kselftest test modules transformation into kunit test.
>>
>> [1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/
>>
> 
> Please make sure you aren't taking away the ability to run these tests during
> boot. 
The kunit tests are usually run at boot time. They can be run later as
well. So I'm not trying to remove any functionality. Rather adding a way
where failures would actually be detected.

> It doesn't make sense to convert every single test especially when it
> is intended to be run during boot without dependencies - not as a kunit test
> but a regression test during boot.
I started investigating when these lib kselftests were just loading the
test module without checking if test actually passed/failed (which proves
that this type of kselftests can never detect regression as it doesn't
process the results). It was strange. Hence I found out the conversion of
such kselftests to kunit tests done by Kees and started this thread for
discussion before doing actual work and sending patches.

> 
> bitmap is one example - pay attention to the config help test - bitmap
> one clearly states it runs regression testing during boot. Any test that
> says that isn't a candidate for conversion.
Please can you explain what do you mean by bitmap testing during boot? As
far as I understand, the kselftests are usespace tests and are run after
kernel has booted completely and userspace has started. It cannot be
regarded as testing during boot.

> 
> I am going to nack any such conversions.
> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

