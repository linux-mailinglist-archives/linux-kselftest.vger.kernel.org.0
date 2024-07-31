Return-Path: <linux-kselftest+bounces-14514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8594293D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5691F23B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28951A7F90;
	Wed, 31 Jul 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mglWlz8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37B1A7F88;
	Wed, 31 Jul 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414778; cv=none; b=Fl4MfY1W1/dd6YwHz6j+yp3z6OuxA9bFiQb1mXFvbNghdax5sGf+1cAwwrFP2y0BAATwG9KZbs5fEBX32nUKYZkW10RnI/655QRfw5+q+rZ4MS3kCZb1MXquW3EUFcht/2geXewpb6zj7ipjajE+SuEQ3TkewgCBEeOtnAvomDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414778; c=relaxed/simple;
	bh=BT5OMlEAinKUsmKz9lIJ/tsSgv8Sb9+xPMgHxyDr6LQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OiCMUEYoKJrJ92nn5e5PQe3oxYkWh2RE+jlJ49C9HiuE/BAomJ5K5qq4eTLzats4I4GqtfTbx32P8h1VAXVmdhVZPXHwR7wbkaWgZZMYYf66AcLhL6mTSAzG18Aj9J6EXTFeNtaESCmR2oNSnqzLVKpYp4e5szPcsm+R0b0U0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mglWlz8x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722414775;
	bh=BT5OMlEAinKUsmKz9lIJ/tsSgv8Sb9+xPMgHxyDr6LQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mglWlz8xqJee68O0XScP32fP0eqSNP7Azio7VUcMinctOSw4IewSs7IgnAF3vV+eM
	 j8h4w8YUvr1Qhjnb9E7EKJ/E8nzLEUOSlTHZlTRmARDkqCt/EBF2N8LPnu6vcRqaXX
	 qgmezealPtIFlO4a7XBC9fBfxBFqecugsjedkmUktQoYCWFXCJbYPgHbfP06lfcHRQ
	 SkouYx3J+2+Nc+Wh1J6hbxCTX4msMiT/G6CrsEXYIcxDfhDm2Su/Hyedj4GMcU6hC5
	 TQZ8GbPt1AvcVFv97kIeBUOUePhZjLhX2ugha56JnyR3j2c9T7Tzt2oGUsXRY0obpo
	 Gbjd6d90xpjAA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6AF75378000B;
	Wed, 31 Jul 2024 08:32:53 +0000 (UTC)
Message-ID: <d26b317b-edda-4bb8-a022-912cd1f76b3a@collabora.com>
Date: Wed, 31 Jul 2024 13:32:48 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] selftests: lib: remove strscpy test
To: Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>
References: <20240725121212.808206-1-usama.anjum@collabora.com>
 <9d5c0793-e90a-4549-92b1-41ad06b85de6@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9d5c0793-e90a-4549-92b1-41ad06b85de6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 3:37 AM, Shuah Khan wrote:
> On 7/25/24 06:11, Muhammad Usama Anjum wrote:
>> The strscpy test loads test_strscpy module for testing. But test_strscpy
>> was converted to Kunit (see fixes). Hence remove strscpy.
>>
>> Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Remove from Makefile and config file as well
>> ---
> 
> As mentioned in other threads on this conversion to kunit and removal
> of kselfttest - NACK on this patch.
> 
> Please don't send me any more of these conversion and removal patches.
This patch is removing a dead kselftest as its corresponding test module
was moved years ago (in 2022). This test has been failing since then. It
seems like misunderstanding that I'm removing something.

> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

