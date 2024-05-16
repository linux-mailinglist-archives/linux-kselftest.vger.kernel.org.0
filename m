Return-Path: <linux-kselftest+bounces-10306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A068C7A09
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97F11F2327C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842214D6FE;
	Thu, 16 May 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tZ/JJNul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6714D2AE;
	Thu, 16 May 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875522; cv=none; b=ZHW1apnBkyGeHDVkczuiHJJNU0qXsFs4x2qEbEjAU6Jqa+Cu4hTwSA+dk+/pntF4JV2NrIGIcHzWC2G8jkup8vhFG4PvhOFIZtbwg7/llcIg3VvSNxGaZv/tiPIN5ajOduuPCrnSfxzKEvnVMWW1COi++zha5N55vTM67cAhGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875522; c=relaxed/simple;
	bh=qvVIUgdKJZiGKItHL5ljlIAWYoWtIMbHS5W/uycZGr4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HIN1orynwtrLkeu899H5DSLsrPPMKmYdoF+9Bd00wUHOLHBMhNrvkgwpt28RXqBPWkgA4xMrJbQuG/86Qr6oLuv0OAysvFJGxXYxqPF+kBEXGp6TMYLQ8Fkc7+ZAqspDw71YYtkoWKWvwm2/CBYPVQI6SQ+oLIljsEivCvycx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tZ/JJNul; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715875514;
	bh=qvVIUgdKJZiGKItHL5ljlIAWYoWtIMbHS5W/uycZGr4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tZ/JJNulmFExB6EaDs5oehCUbnuUs7uJafZxiojOZ8V67nHPCPWPLtP908vSN7JPE
	 tlGOnk6M5JCaHpOFl687xzLKTwn9HC6Jbl8RypFuZnOT7HxYLUuGaRqDTJjGt/dPO3
	 5zlqoPC2XW7ZR278q1CnhCzRB3NxM8JyCSEl7IdCfXu8qXE2EjSJDaOAf5azdRjcIq
	 bzEYIfo4w1StPnosIvhBgkluRsb2vslSiO4hy3mUMIufgP97PRsNJoe8/bBelQIi/L
	 6LdKtgt2O6lrwS9+G5LKHCRQirULWVmfDF7Q3Y0s7GZ3jq8YHCOgtky7ePx9Z1A5y/
	 8QvJxZgzBQpVw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45F9837821A4;
	Thu, 16 May 2024 16:05:12 +0000 (UTC)
Message-ID: <a9d2a04e-7e4f-476a-a006-ec78d56e8ea1@collabora.com>
Date: Thu, 16 May 2024 10:04:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Ensure _GNU_SOURCE is defined
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
 Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>
References: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/24 9:27 AM, Mark Brown wrote:
> The pcmtest driver tests use the kselftest harness which requires that
> _GNU_SOURCE is defined but nothing causes it to be defined.  Since the
> KHDR_INCLUDES Makefile variable has had the required define added let's
> use that, this should provide some futureproofing.
> 
> Fixes: daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/alsa/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 5af9ba8a4645..c1ce39874e2b 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  
> -CFLAGS += $(shell pkg-config --cflags alsa)
> +CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
>  LDLIBS += $(shell pkg-config --libs alsa)
>  ifeq ($(LDLIBS),)
>  LDLIBS += -lasound
> 
> ---
> base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
> change-id: 20240516-kselftest-fix-gnu-source-81ddd00870a8
> 
> Best regards,

-- 
BR,
Muhammad Usama Anjum

