Return-Path: <linux-kselftest+bounces-10895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6E8D446A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 05:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09AC1C2261C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE1142E7D;
	Thu, 30 May 2024 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WYSmuaTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D8142E6F;
	Thu, 30 May 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041574; cv=none; b=HJDRK/0HN8WDxn8wZxYmBV+6BTAVdvUqMcKieVo3e+coxo0U5J1kxFJJpcZRizsh/f5ViPpfgZGOCKkaYWFER59GaJnvnpQOP3ZM0nRakTG95/n18YjTwHd7GZdFzT/iMnsr0OFrDya2za0CYcfPt5+PoqZu/8roI9jVcX6VGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041574; c=relaxed/simple;
	bh=9gLs7dItiedAyafKsMJMGtK8+Z2kcch88RTbxpGs1p8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hr9wAgj17I7bM3RCsfMAoD40UZoPJpIcpIGk7DYgFEFUqh2dHGPY+B7HzqDUJ/RFc7FyWv6nrlcj4VsOq9EPfacq/1ZEwLW+/D1HJ0WMyN37fCsbMC80Zai4R2J2tDwn0rA3aRRqVxUamwzhX0u7elI3bk8flq6gtMvnZlcMHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WYSmuaTN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717041565;
	bh=9gLs7dItiedAyafKsMJMGtK8+Z2kcch88RTbxpGs1p8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WYSmuaTNp9CC+ndkb/1rio4Ix4NnGx/LWZ/7oTnyfv74NEaC6CfSXm2jpCN6yTbFo
	 DDogU6lcsqSfCU/7L/CiCAlzfqeAdThfqjkHytPMQghPSJAPBciZggMhxCL/VnMRdT
	 sc/yGzRqxNQ78opzlDqnaAL/tbjWfIlqj1EN+VJ2dhCVfIE9T3vjOtwCqG/RXth53c
	 6xQUsf3lVI9jbekxKww5CYKj52soDRLt8kupKFnber3P6vYqYYHFOE+9uTpsXpkWqW
	 QwTW3sQFNbW0F0TzjOIiw7BRjapmBOUyK3cSmV3hdaTvF7rqkfzWLafGlo/CYnqOVh
	 WmkfgFYwztCQg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D50B23781183;
	Thu, 30 May 2024 03:59:17 +0000 (UTC)
Message-ID: <1aec9470-9af2-4113-9cbb-9930ccd92a0b@collabora.com>
Date: Thu, 30 May 2024 08:58:46 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>, Alexey Gladkov <legion@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
To: John Hubbard <jhubbard@nvidia.com>
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
 <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/10/24 10:56 PM, John Hubbard wrote:
> On 5/10/24 4:52 AM, Ryan Roberts wrote:
>> On 04/05/2024 05:43, John Hubbard wrote:
> ...
>> It just occured to me that the bug report I was fixing with my attempt was
>> invoking make like this (see [1]):
>>
>> # tools/testing/selftests/fchmodat2$ make CC=clang
>> # tools/testing/selftests/openat2$ make CC=clang
>>
>> So LLVM is not set in this case. Perhaps my approach [2] (suggested by
>> Arnd) of
>> using cc-option is more robust? (cc-option is alredy used by other
>> selftests).
>>
> 
> Yes, I think that would better handle the two cases: setting LLVM,
> and/or setting CC (!).
> 
> For that, some nits, but only worth fussing over if the patch hasn't
> gone in yet, or if you're changing it for some other reason:
> 
> In Make, the arguments to functions include *all* spaces, so it's good
> practice to not add spaces in most function calls, unless they are
> definitely desired.
> 
> Also, you only ever want one of those $(CC) options, so saying so is a
> nice touch. Neither of these is a functional issue in [2], but you could
> do this on top of the patch (I'm only showing the openat2 case):
I was building with CC=clang and build was still failing. We should be able
to build by CC=clang and LLVM=1 both. It seems like patches still haven't
been accepted. Let's get a v2 out to fix this.

> 
> diff --git a/tools/testing/selftests/openat2/Makefile
> b/tools/testing/selftests/openat2/Makefile
> index 02af9b6ca5eb..c894778874a5 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -3,7 +3,7 @@
>  include ../../../build/Build.include
> 
>  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
> -CFLAGS += $(call cc-option, -static-libasan) $(call cc-option,
> -static-libsan)
> +CFLAGS += $(call cc-option,-static-libasan,$(call cc-option,-static-libsan))
>  TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
> 
>  include ../lib.mk
> 
> 
>>
>> [1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
>> [2]
>> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
>>
>>
>>> +
>>> +LOCAL_HDRS += helpers.h
>>> +
>>>   include ../lib.mk
>>>   -$(TEST_GEN_PROGS): helpers.c helpers.h
>>> +$(TEST_GEN_PROGS): helpers.c
>>>
>>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
>>
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

