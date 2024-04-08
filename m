Return-Path: <linux-kselftest+bounces-7392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB389BE73
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 13:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CC01C212C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9136A01B;
	Mon,  8 Apr 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LOVQ3p/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F48657CB;
	Mon,  8 Apr 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577168; cv=none; b=gbeGS662RWZiAAmiweNb8DeA+Ngw9w5f8Ner2IdAVRCRKN+yxrReVAI15PDP3eJkmc57M5YNbhJW/swibM6ykYJwN7eqOJeO2gHgNmCcI6rehrPm9cpPwtoz8uDHAl0/odIqqZcAq6NbnaToA7KfvYfOZF4OYxSIUTWRUwEjWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577168; c=relaxed/simple;
	bh=9TcqgVCdebpUEtPloXV2xwkuH5UyaU8oSE1S2N9IZMw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uKeDazVsSghEC63BCw31/7Wn9t0cto6tPzGUl0B95IVinuBtRPeMP9j+K1W0nTZCEkMuShjjm7zzB6UbAmC7nOOoTAjB7M9MYmTjZnDYHMQn1yfpchh/JyZgpLErtGnxSHkS3ADymcq2UGtuDF83j+PxRq5xamwNbRaX5lXqVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LOVQ3p/3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712577164;
	bh=9TcqgVCdebpUEtPloXV2xwkuH5UyaU8oSE1S2N9IZMw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LOVQ3p/31BEegWocwBzMmKRuGOXUjKNbDGMyX1aUKsjGFNyGJH0UFM8mCzKZb6dbz
	 AWa3bMlprII5kWnXhjSM0u6BwoHzrQGrK+YN0qvLbunMm6sntZMW3uBVTtgtvsvpku
	 TtmscyRlvZvz0a7X0jePsuQNa+6ckn5O8gxBVRM0Fx2vRYeQ7RZHLFI8yL13yr1ofl
	 ekda8FQp4FMAyocuhVl5Ai2fXshSvbqBgbaVRjf5cjqUQd2Fgkr29ugbzl5A8cizsb
	 YT0jJXE3PcAUcUFz4XuRaZYIgkLtcD7xWU0aj0nqlx1+SiqDW9wo1WyDps9brkjqLD
	 QLD9QUOmaBUUQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E5753780894;
	Mon,  8 Apr 2024 11:52:39 +0000 (UTC)
Message-ID: <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
Date: Mon, 8 Apr 2024 16:53:11 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids
 controller
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
 <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/24 4:29 PM, Michal Koutný wrote:
> On Sun, Apr 07, 2024 at 02:37:44AM +0500, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>> The
>> 	ksft_print_header();
>> 	ksft_set_plan(total_number_of_tests);
>> are missing. Please use all of the ksft APIs to make the test TAP compliant.
> 
> Will do.
> 
>>> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
>>> +		switch (tests[i].fn(root)) {
>>> +		case KSFT_PASS:
>>> +			ksft_test_result_pass("%s\n", tests[i].name);
>>> +			break;
>>> +		case KSFT_SKIP:
>>> +			ksft_test_result_skip("%s\n", tests[i].name);
>>> +			break;
>>> +		default:
>>> +			ret = EXIT_FAILURE;
>>> +			ksft_test_result_fail("%s\n", tests[i].name);
>>> +			break;
>> Use ksft_test_result_report() instead of swith-case here.
> 
> Do you mean ksft_test_result()? That one cannot distinguish the
> KSFT_SKIP case.
> Or ksft_test_result_code(tests[i].fn(root), tests[i].name)?
No, this doesn't seem useful here.

> 
> Would the existing ksft_test_resul_*() calls inside switch-case still
> TAP-work?
This part of your switch-case are correct. It just that by using
ksft_test_result_report you can achieve the same thing. It has has SKIP
support.

ksft_test_result_report(tests[i].fn(root), tests[i].name)

> 
> Thanks,
> Michal

-- 
BR,
Muhammad Usama Anjum

