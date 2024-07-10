Return-Path: <linux-kselftest+bounces-13449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148692CDC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FBF287596
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF516DEA5;
	Wed, 10 Jul 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mRj61KBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A416F286;
	Wed, 10 Jul 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601905; cv=none; b=o8JMEYyvw2SMiafqRQ0/m86S7PySllh1qfYRqkRDjwIYs9sGY86p8HfNLqsuttt8AUTRYssI442VfbWouYiC9WTw5m7osE4g1JTWc0vXKEWlcsiWOuOO096N+zYJpIqmHQTRvR7nZcSN+ejjTVpdusm1JCMNGrXwwdeQ3wFVLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601905; c=relaxed/simple;
	bh=+2PhsalpeHjx95bJHVCZoOhKs2TmU+L1mxe2M1LJ2J0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtdXd/ZMlw2ImsM1DLUOWMVHBiNyYU3TftCEIFtcZimUmRaLCFHqSu/Hre1bvvDisS63v2hYiMUNpydHMoIs48NsaZ3kf+udCBrj2YRYU0+K3fhYTqnR/O9NLr2Wx7PjgtjYE4s+i7+tVIDeux3blaMvp4FCjFxAApZBo7OAGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mRj61KBa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720601902;
	bh=+2PhsalpeHjx95bJHVCZoOhKs2TmU+L1mxe2M1LJ2J0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mRj61KBaYwqrWhOvdqQ8xwGYSPDB8s96ZnteWDEHusr5qyAEfaH5kySQxwYOEwvDb
	 /HahlocHXVWgOh9M9OGwsXkHV7SxoyXsj0eAwED6Z8d98BSTd/FG494bpcOS9JFl22
	 3adxMpWdtDw3k/LHpYqQk6iypCfrrH9axcCG0TVtwbcbkGU0qzIKoLksX7rpZsz2Qy
	 nLzEDka+B3AV3lONZOuVa/zKpPKZd9uTyeQooeQf7soisbpS68SXyxbiniljy3BSMr
	 p9xuvQH8tSiJhaiFENoR/ICjNiYKEr/lHCrusoOstclcdbjd9pFW7eVtEnKDKu9mIc
	 ZeTpdUCOxAwpA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C7D3637813C0;
	Wed, 10 Jul 2024 08:58:18 +0000 (UTC)
Message-ID: <f7eb356d-6fe7-4e36-9fd2-1518addc7bdb@collabora.com>
Date: Wed, 10 Jul 2024 13:58:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Shuah Khan <skhan@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
 <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
 <23db41bb-1f3b-4b7b-95ac-960b8775a062@collabora.com>
 <fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <fb305513-580a-4bac-a078-fe0170a6ffa2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shuah,

Thank you for replying.

On 7/10/24 4:39 AM, Shuah Khan wrote:
> On 7/2/24 04:17, Muhammad Usama Anjum wrote:
>> On 6/10/24 10:19 AM, Muhammad Usama Anjum wrote:
>>> Adding Borislav, Dave and x86 mailing list:
>>>     Please review the series.
>> Kind reminder
>>
> 
> Usama,
> 
> As I mentioned another TAP conversion patch from you  patch if the
> following command gives you TAP, there is  no need to convert.
> 
> make -C tools/testing/tmp2 run_tests
> make kselftest TARGETS=tmp2
> 
> kselftest framework lib.mk and runtests wrappers take care for
> TAP. The reason to take care of this at framework level is to
> avoid changes to individual tests. The wrapper keys off of
> KSFT_* codes returned from tests.
> 
> Please don't send TAP conversion patches like this one. The output
> from the commands will have duplicate messages. The reason tests
> return
> 
> make -C tools/testing/tmp2 run_tests
> make kselftest TARGETS=tmp2
The current series have several improvements which are beneficial in
several ways. I think these improvements should be included. While
conforming for TAP following improvements have been made:

*[PATCH 1/4] check_initial_reg_state*
Removes manual counting of pass and fail tests
Increase readability and maintainability of tests
Print logs in standard format (without [RUN], [OK] tags)

*[PATCH 2/4] corrupt_xstate_header*
Correct the skip, pass and fail return codes. Otherwise the test always
return 0
Returns correct number of stats about passed/failed tests
Print logs in standard format

*[PATCH 3/4] fsgsbase_restore*
Add test skip support instead of returning success at skip time for the
kselftest script to understand correct exit status
Print details about errno if error occurs
Increase readability and maintainability
Print logs in standard format

*[PATCH 4/4 entry_from_vm86*
Remove manual pass/fail tests counting
Increase readability
Print details about errno if error occurs
Print logs in standard format


These improvements aren't evident from the description of patches as I
thought converting to TAP achieves all this by default. But I can improve
the patches description and send patch revision. Thoughts?

-- 
BR,
Muhammad Usama Anjum

