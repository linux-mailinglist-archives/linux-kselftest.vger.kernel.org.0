Return-Path: <linux-kselftest+bounces-14261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9AE93CF6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3831C20F79
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71860EC4;
	Fri, 26 Jul 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E5LWkObD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951572B9DB;
	Fri, 26 Jul 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981793; cv=none; b=idPDFz+NZjpdgNZn844m/Zv48IBlsW8wQ1KmEa3lkfhJoBBifTWjZzHOq6+u5eCaBvmCeJ59gaufecYKNYRjihJrw3UE/ccHypDzbdTx6PrPF8AQuWucXfOIjKMG39bauXDmjBgXAe1OQy+88VTvL+lp9sedoSYtfmBFenFxs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981793; c=relaxed/simple;
	bh=yB//hvBISxwzKl/gZ78yInunpVRnG/3tOdysMpcClLw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VohHBGpTn00ZvdBycihtludaIdDjnH2jODcnymE/mPbU/xVfKXvzKN62ek98fFhIdlkw7pj4j/HUfuK6aMKy5Ukk6i7JTV9XxDj+muHv2o2YnUGz+RhuvNkK2MAniry8GlJ+JVD2QY0tMQ/WszT/jS0RZ4hedCgs6SNLIJDWClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E5LWkObD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721981783;
	bh=yB//hvBISxwzKl/gZ78yInunpVRnG/3tOdysMpcClLw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=E5LWkObDKLgZ7QRyeOYP/t2OT83yQShvkL5q9tc1hdKJvCSmHhDjrPpqRYC+ALNHL
	 678YaiEfqK2axif8GxOSvBz1DFV0PscYMOChkaJhQC5JcueY165CKyE5otCDtk5yU5
	 85FJqrqqQko1p+ApdAv3ZNMTGBCwePrGCocCmpnU1ogjzgiFnxQGWZgXZwNjWggFIF
	 RljI3R31j6IeRfQ0cBZJ1d031eJrqvsZthKtWPSS4/Iy7GfmjkbYTNfZDGGDs7zs9f
	 z2eYFue0KM+UzchDTUGgBISV7uM3ooAx1vCuKGuk0lJJtjMi3bDifs+F24W3gerEcP
	 UuJ/vnjklguHw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0A42C3780C6C;
	Fri, 26 Jul 2024 08:16:19 +0000 (UTC)
Message-ID: <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
Date: Fri, 26 Jul 2024 13:16:15 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: user: remove user suite
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>,
 Vitor Massaru Iha <vitor@massaru.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/24 7:44 PM, Shuah Khan wrote:
> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>> The user test suite has only one test, test_user_copy which loads
>> test_user_copy module for testing. But test_user_copy module has already
>> been converted to kunit (see fixes). Hence remove the entire suite.
>>
>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
> 
> Remove fixes tag - this isn't a fix and we don't want this propagating
> to stable releases without kunit test for this.
The user test suite has been failing since cf6219ee889f as the test module
wasn't found. So this is fixing the failure of kselftest. It just causes
noise and may mask other failures. If you still think that fixes isn't
needed, I can send a new version by removing the fixes tag.

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
> 
> Thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum

