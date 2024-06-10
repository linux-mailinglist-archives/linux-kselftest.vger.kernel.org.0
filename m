Return-Path: <linux-kselftest+bounces-11537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2776901A2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5921F217AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA00BA2F;
	Mon, 10 Jun 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="31Qqm/aa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCD1170F;
	Mon, 10 Jun 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997098; cv=none; b=rydmbZEaYwaIv5TQK32FmB1YGJ85aKJKRkn76el4pH3hQFbDKBszukpA9U23N8bSXEU/Ib7IBtrquk9W177mSwAK1NsfJkY5jzS+X+K1jWHLiHM4KaGqwxy/SAfxQ9YrGZQjMfKqco+Qlwe6ljR6r6Ixm10MGBV3IE1/nzyAmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997098; c=relaxed/simple;
	bh=KOI77uxwFc3BTNCWv6NxnxI2DLQ5EKm7zmRpPzTU9nw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=asHChNb6Pwh0JtF9rrKJ9+gKadV1UQygL1RZw+MLjnZogPrPVOH2A2gV0EUVmMXbFBrIoo9tcIzy89W17vjADkEzvMuPQiqgdlwpDdc+Ljou5eO8om2W4xXD1eaAJK9yLEqgsnKcJEq6v+vbXxJEl6PHWcP5WKhGpVsEOjUUfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=31Qqm/aa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717996712;
	bh=KOI77uxwFc3BTNCWv6NxnxI2DLQ5EKm7zmRpPzTU9nw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=31Qqm/aaSpj95Ed1A4FfL0wveS+O4AeCMjGxZsma0GGw9aZ7ULwkEoZ4m2iqy4Ojq
	 Q7/yJIY+e9JQzUx2FLWA8Xaj7LrC8JvXCIlG+m3F8ZgeJHtsy5QXWcdIbgrUIENNMK
	 AaFfgzdKs4aboEtDRCZW38m00+3uVS0ZW9p/4GPLyztyzfpowvp7DQAhlzu/U/U4uD
	 /3BoXaSpdvF262U0k9A/dIKVcnm3+ivl9rRKN+T/qtdXgj3uG18OMmx2+gx91zbeXM
	 XpsGIkTAfMih29wNKlZOLU2f7MAbQsslURf6H0sYMiTtB9WMtw4ezqAcvGjl/OdmtZ
	 diPSLjuF2gCSA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 877BF3782009;
	Mon, 10 Jun 2024 05:18:30 +0000 (UTC)
Message-ID: <386da8e3-1559-4ec2-9a66-f5f3f6405a2b@collabora.com>
Date: Mon, 10 Jun 2024 10:19:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
 <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding Borislav, Dave and x86 mailing list:
	Please review the series.

On 6/8/24 1:52 AM, Shuah Khan wrote:
> On 5/27/24 23:04, Muhammad Usama Anjum wrote:
>> Kind reminder
>>
>> On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
>>> In this series, 4 tests are being conformed to TAP.
>>>
>>> Muhammad Usama Anjum (4):
>>>    selftests: x86: check_initial_reg_state: conform test to TAP format
>>>      output
>>>    selftests: x86: corrupt_xstate_header: conform test to TAP format
>>>      output
>>>    selftests: fsgsbase_restore: conform test to TAP format output
>>>    selftests: entry_from_vm86: conform test to TAP format output
>>>
>>>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>>>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>>>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>>>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>>>   4 files changed, 139 insertions(+), 141 deletions(-)
>>>
>>
> 
> These patches usually go through x86 repo to avoid merge conflicts.
> 
> I need ack from x86 maintainers to take these. I don't see x86 list
> cc'ed.
> 
> Please make sure to include everybody on these threads to get quicker
> response.
It seems like selftests/x86 path is missing from Maintainers file and it
causes these issues. I'll look at fixing it.

> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum

