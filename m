Return-Path: <linux-kselftest+bounces-14362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A279D93EFE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB2A1F22C91
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4513B597;
	Mon, 29 Jul 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2GIutL1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D0130A7D;
	Mon, 29 Jul 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241796; cv=none; b=tNS238wSOYeTWOUXn9tkGi0rs+6qhkxmG2SNd89z3gSW8Hhl8BY4ov7UiDi3R03jUpnon2QeyoNrfw/AI4A27gYrBsanCX4aJBulMve+QzNayvxmwvy6F8MnrsDueuEg4fNkXnLpV8gyuzZi8OKY6Q54g9GwmipFP5/v5ELbCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241796; c=relaxed/simple;
	bh=SQtWsaa0Wk3Mf10zCh4eJU/N27v9lwbRkQk9wBgdq9Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nq7sbOfmsZ/j6+gJh0zsz2Wev3Lwh7gzJW/HadAuKiOkY3IOBP1St65DRhscHIhWQQz7v/tKmAD2N7n35PtU1XC9KesyHJOOJ77SQVDCEnqGH1svI0+/SfF1oUp/fIBpuuWdXsBrrsqATeEMCA6mlCOr3HmwMOQuaoxHu5DErJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2GIutL1H; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722241792;
	bh=SQtWsaa0Wk3Mf10zCh4eJU/N27v9lwbRkQk9wBgdq9Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=2GIutL1HBHwBMdYQm+Cmb/4ZmAR9xi5NsbFTwEEnzUAP/7gScHgUdgptT3I+RxYqh
	 PunJqO8ylVjaO1y0nhCknF5g7sAHQVXV1q6XaSdyJuhXx2lvDfL7vKfBkO60fJQr+7
	 j8GjPjlgNEy4x3dMeYZ607eNkHITmFwaxDWfX9Ag294KAk1jBrp+NwXWPipezDFHWH
	 G07Qfez35Q089pApnSNL6aFQsr6veUxDORx/IRTKRMhp0EwlSZ23IfDQgsI6VBw/l8
	 Y0OdpJiyAhcIvFLJ9iDqbvLcQVo73Q7PGIvKRGsfGk/sx4AU+m/3Jehq/0oMu/SwP9
	 N2j/ujL7DD88A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 55DF83780BC9;
	Mon, 29 Jul 2024 08:29:50 +0000 (UTC)
Message-ID: <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com>
Date: Mon, 29 Jul 2024 13:29:48 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/27/24 12:26 AM, Shuah Khan wrote:
> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>> In this series, test_bitmap is being converted to kunit test. Multiple
>> patches will make the review process smooth.
>>
>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>             configuration options
>> - Patch-3: Remove the bitmap.sh selftest
>>
>> Muhammad Usama Anjum (3):
>>    bitmap: convert test_bitmap to KUnit test
>>    bitmap: Rename module
>>    selftests: lib: remove test_bitmap
>>
>>   MAINTAINERS                           |   2 +-
>>   lib/Kconfig.debug                     |  15 +-
>>   lib/Makefile                          |   2 +-
>>   lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>   tools/testing/selftests/lib/Makefile  |   2 +-
>>   tools/testing/selftests/lib/bitmap.sh |   3 -
>>   tools/testing/selftests/lib/config    |   1 -
>>   7 files changed, 295 insertions(+), 354 deletions(-)
>>   rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>   delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>
> 
> Can you tell me how this conversion helps?
> 
> It is removing the ability to run bitmap tests during boot.
> It doesn't make sense to blindly convert all test under lib
> to kunit - Nack on this change or any change that takes away
> the ability to run tests and makes them dependent on kunit.
Let's discuss this on discussion thread [1].

[1]
https://lore.kernel.org/all/a3083ad4-e9dc-40da-bf57-8391bcd96a6c@collabora.com

> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum

