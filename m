Return-Path: <linux-kselftest+bounces-3393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFE838850
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2938BB234A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32352F8A;
	Tue, 23 Jan 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z0shAASS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72C6121;
	Tue, 23 Jan 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996444; cv=none; b=EXQKceJzVYzKesaiiHS5PchQPwh51p9TrgfkEylrYYht6ZulnqUPAFN0Nnco7PGgAehs/SAHdLmRFm0hmUDPLeGVW+hCnTCWIH/H6XaxpcG/AOwjSmM0uRevb9mUbRmBE7Ex8PznKN3C2xGE4n9UTDyyNs4+uYe/3wsOOQW82mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996444; c=relaxed/simple;
	bh=Ocj0vO0Q0SnGr1J7ff2nfnaqMFo06Q5kW8VNcZ01sao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NBOqhOIU4lw8rm7fMcCejQmA3QXYEWE8ZqHS8XBdmaBWJfv+C64OGG8G/VLmmCQSTqjzZFof/yAajBkWEQpDYpClksvILDLsaDReWVDiTLEq01yicnjLKg0gueDJX2f7HQuETdv7WIVpXG7zDU/HBvmZmPNZMIQIeHkKKIyU68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z0shAASS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705996441;
	bh=Ocj0vO0Q0SnGr1J7ff2nfnaqMFo06Q5kW8VNcZ01sao=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Z0shAASSnWuibm/24jq9wPgvwMESwktIz9xMv8QSorYEc+YOVg5XiNfha2mc2Od9F
	 hKcLB+Di0ybtLPsX4q/mGkTl0pPWJ9de2NAUgPMXAF7ld/W+cMI/lY/jKo2LjdMvg8
	 +U8GrrE6M/CeXrJPvVZnrucX+ZDR4VbWrzztZynBHT6FnsrrpfHYpgadNcXIeFFnAt
	 AAWd9pr4u4q+S7D1AMfeyCbb05gs13wj2WGEQGUtpxHqnLvU8GqjvjPohtG61g0jnM
	 POoQki1iMlk4hi45l3wvrwOr5U2IDL8FQWd8rqJNOPRFQM+VrM2p6wjXkA9Jnk0jvH
	 a9C5EglB/22bQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64FC43782039;
	Tue, 23 Jan 2024 07:53:59 +0000 (UTC)
Message-ID: <b9bccbc0-1f04-4d60-9a82-2688da82d436@collabora.com>
Date: Tue, 23 Jan 2024 12:54:12 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests: core: include linux/close_range.h for
 CLOSE_RANGE_* macros
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20231024155137.219700-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231024155137.219700-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can anybody please pick this patch? This was fixing genuine regression in
some build system.

Thanks,

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

