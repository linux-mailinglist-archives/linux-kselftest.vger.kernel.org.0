Return-Path: <linux-kselftest+bounces-816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410357FD5D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 12:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F93E1C20BEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE431CAA3;
	Wed, 29 Nov 2023 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F38TCO+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4FFB5;
	Wed, 29 Nov 2023 03:34:43 -0800 (PST)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D16316601F02;
	Wed, 29 Nov 2023 11:34:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701257682;
	bh=tRhepYPNdHA/lUETHFHwOvj00O+K6y9mXjcxMrTkqzU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F38TCO+ZCcv8thAbgr+2IWP0WtXlpbyPTn57B5TJAAd/cr1xDrsgLwRErdzwXYLWP
	 X8k3aNUaPL8Sc6ftCsgBZ3YfEPcLm7GFWuIJgVH+2AdfX7Np35qIxH3MzcJLy1iWmz
	 YG3Mnfk/U1mxeKxdEng9vkVqfEAGSXL6kJVRIpsjNUy+v3lakEteXL9XeQxvp8/CmE
	 61SJ/tWK3M82OezYCRZ3A5955LKK+TSNLQrkNFVzAs1nk0ZCHlG7+8cCLk8MSR2V/S
	 cDax9ZfRgrHKDvbKmCCt253laGDQFtObTsDMxFuPf/tqnhPocRil6htifpwnyDdpC+
	 hevWfrDz0DEnA==
Message-ID: <9dbda2f9-2bb2-4e79-976a-12856ab6936a@collabora.com>
Date: Wed, 29 Nov 2023 16:34:34 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: core: include linux/close_range.h for
 CLOSE_RANGE_* macros
To: Shuah Khan <shuah@kernel.org>
References: <20231024155137.219700-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231024155137.219700-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 10/24/23 8:51 PM, Muhammad Usama Anjum wrote:
> Correct header file is needed for getting CLOSE_RANGE_* macros.
> Previously it was tested with newer glibc which didn't show the need to
> include the header which was a mistake.
> 
> Fixes: ec54424923cf ("selftests: core: remove duplicate defines")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Link: https://lore.kernel.org/all/7161219e-0223-d699-d6f3-81abd9abf13b@arm.com
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/core/close_range_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
> index 534576f06df1c..c59e4adb905df 100644
> --- a/tools/testing/selftests/core/close_range_test.c
> +++ b/tools/testing/selftests/core/close_range_test.c
> @@ -12,6 +12,7 @@
>  #include <syscall.h>
>  #include <unistd.h>
>  #include <sys/resource.h>
> +#include <linux/close_range.h>
>  
>  #include "../kselftest_harness.h"
>  #include "../clone3/clone3_selftests.h"

-- 
BR,
Muhammad Usama Anjum

