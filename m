Return-Path: <linux-kselftest+bounces-2530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC78203DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F245D1C20B3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DE1843;
	Sat, 30 Dec 2023 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D5e8Uz0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680523AE;
	Sat, 30 Dec 2023 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703920023;
	bh=CxlImPBq53eZem5Et6yBckyx0PnHoMgFMsFpjlSIejE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D5e8Uz0PeLBwDcLY7fbsI0z23YVblUvbcsD9J7qHRtU8xuH82viTwf7dO+jProDBo
	 DbHm9sE5+epJUxb1+iinKgCN4f7m9Hjo6R6emk7p4L8dNGLJs8MI38dMnLgTXKBSqd
	 FLNvIE7RUxMzTfr5Lat447BWzW/XV/mRju9OsFO/Nxlts8KRIWmh/XESOGO8Kuj0RZ
	 VdDfj3kSz8qdo+u6PBnA4Vsn3uAQI/kTb1TuPK+gkJ+QHofKJPYn9F+L3ltkdDp5hp
	 q0azNFo6x8T81HzINRYFSFXfi8Hea9inPco72cHo2yc6yZenzZM6eD0eJ38i/eqW4a
	 gKzVnD/iwhN0A==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4DF6C378105A;
	Sat, 30 Dec 2023 07:06:59 +0000 (UTC)
Message-ID: <d3dd3a6c-ae60-48c9-945b-40aa18ccad86@collabora.com>
Date: Sat, 30 Dec 2023 12:07:00 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/27/23 12:55 PM, Tiezhu Yang wrote:
> + Andrew Morton <akpm@linux-foundation.org>
> + Mark Brown <broonie@kernel.org>
> 
> On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
>> v3: Rebase on the next branch of linux-kselftest.git,
>>     modify the patch title and update the commit message
>>
>> v2: Rebase on 6.5-rc1 and update the commit message
>>
>> Tiezhu Yang (2):
>>   selftests/vDSO: Fix building errors on LoongArch
>>   selftests/vDSO: Fix runtime errors on LoongArch
>>
>>  tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>>  3 files changed, 18 insertions(+), 30 deletions(-)
>>
> 
> Hi Shuah, Andrew and Mark,
> 
> The patches still seem to apply cleanly.
> Could you please review and merge them for the upcoming merge window?
People may be on vacation. I'm also waiting to hear back on my patches.
Lets see when they get back and start picking up patches.

> 
> https://lore.kernel.org/lkml/20231213012300.5640-1-yangtiezhu@loongson.cn/
> 
> Thanks,
> Tiezhu
> 
> 

-- 
BR,
Muhammad Usama Anjum

