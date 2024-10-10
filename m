Return-Path: <linux-kselftest+bounces-19458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EA998C50
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF201F2150F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0618FDAB;
	Thu, 10 Oct 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dw6PbTFy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B1190679
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575422; cv=none; b=hrkm/OiwlKJjwm1YRjoWw1XunCi5WkP1RMQT23C7MvsGZeHzsijTjI9t293bqBPd0wuTB61Y6hHp0m9jweptJM//3tFETET6maqKbTi1XbZuqHe+1nxr9BbpjpMbGL5mva+l6yDRrTnHcoyjWaOcU3eX0m9WHf40CwvnJ4wHoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575422; c=relaxed/simple;
	bh=qhOxO4ONtclTNMDXzHvaQ8+AflWsYw4+9H8QES3JtII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab5fqSIhIcA6ad9Qk1o/JxifAkLXoC2YhxRSTQEDKoiIpX+BISqwPP2k+J8TsR5ZfztRAK9klnRDNgRMeKJ3YpMKvqPHIARtsD6skwyFEoETfqVwq6IHdFxeTPA5HHcLeVrha++qIpf+1CvJwpF+ImGHJO2/O/cLcmx+nc47TnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dw6PbTFy; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8354851fbfaso46602539f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728575418; x=1729180218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg/yor8UwdQ8Oe3H/zJkreOXjYG4wInbDnh3i6jir0U=;
        b=dw6PbTFyo4A37N5Zn2qnuQSlDZYE4/hfH5sQonhCBhwj5KyUP+bHkzgFmRVOiiO3KZ
         5w9DHLX+CWqWnr0ij68izUmt5jdG/8qFKbChO8tRvaylNb6I+OTK2hGxgvxdVTFA1Ygm
         hIofXrVnbF48ozQghE/c7/8uh8MPET5LptskQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575418; x=1729180218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg/yor8UwdQ8Oe3H/zJkreOXjYG4wInbDnh3i6jir0U=;
        b=SVLsYymTojdSoGWOK9UkRN95UOdY7qUxzffHHLdrZFAUxBJO+tWqdEpboVNYGVHmU/
         KbR1VXkwyMfPaWAgNDDDeMmRAulhMQtzk6B6LAcQc8y6y7ZDtk5mj+VAs74DA8ZjsSgn
         SBxRliGC2n/g19hsl2l3pMeviFjKCoAcUBgLM6+VpXowSvmiYpXQjuDlqzag/jB2WV45
         mqf5ts2uciilKbQtYISfHp1duFHAfZCloDNjksvCmbMm+KzT9D59U7WbRNEQlH46TgnP
         BGtMEv0m8kr3EBocHz0s0VTQF/NIKpKDDsftn3/oMYaOWdCaZbnAfDpWng1beSpo32ik
         df5w==
X-Forwarded-Encrypted: i=1; AJvYcCXLoSNE0P0OWkR6zbZefM4p4klbpRZBJKsXic9+jPYZnRHC8mkQ92VedW1KyZlpv2Uz92mbFivHIb0fWAoJ1JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnXBzPu3d6NkQFwNAeKFjre0AvMQjLSRPfw/s1afGmi5OfdSC
	XrvCcLP3K56YlbMDacYix7H8jK48qviw2wFXvpo9rlMam4+dIsVzIA2w67as1KcbBvpno4Ybqvx
	d
X-Google-Smtp-Source: AGHT+IGpKaSQwpFTgwpTMojAbCcGc828CWQuH3jzfJx59SWrqRB/qdsTdBqeGXfoX6ADlOFwwF7uZQ==
X-Received: by 2002:a05:6602:1506:b0:834:f744:d067 with SMTP id ca18e2360f4ac-83547b974f8mr409994939f.8.1728575418175;
        Thu, 10 Oct 2024 08:50:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8354b9130d0sm28862439f.17.2024.10.10.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:50:16 -0700 (PDT)
Message-ID: <5b471a5c-c99d-42a5-943d-bb253127a202@linuxfoundation.org>
Date: Thu, 10 Oct 2024 09:50:15 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241010121612.2601444-1-zhouyuhang1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010121612.2601444-1-zhouyuhang1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 06:16, zhouyuhang wrote:
> From: zhouyuhang <zhouyuhang@kylinos.cn>
> 
> The libcap commit aca076443591 ("Make cap_t operations thread safe.") added a
> __u8 mutex at the beginning of the struct _cap_struct,it changes the offset of
> the members in the structure that breaks the assumption made in the "struct libcap"
> definition in clone3_cap_checkpoint_restore.c.So use the capget and capset syscall
> directly and remove the libcap library dependency like the commit 663af70aabb7
> ("bpf: selftests: Add helpers to directly use the capget and capset syscall") does.
> 

NIT: grammar and comma spacing. Please fix those for readability.
e.g: Change "struct _cap_struct,it" to "struct _cap_struct, it"
Fix others as well.

> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
> ---
>   tools/testing/selftests/clone3/Makefile       |  1 -
>   .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
>   2 files changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index 84832c369a2e..59d26e8da8d2 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -1,6 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
> -LDLIBS += -lcap
>   
>   TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
>   	clone3_cap_checkpoint_restore
> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> index 3c196fa86c99..111912e2aead 100644
> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> @@ -15,7 +15,7 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <stdbool.h>
> -#include <sys/capability.h>
> +#include <linux/capability.h>
>   #include <sys/prctl.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
> @@ -27,6 +27,13 @@
>   #include "../kselftest_harness.h"
>   #include "clone3_selftests.h"
>   
> +#ifndef CAP_CHECKPOINT_RESTORE
> +#define CAP_CHECKPOINT_RESTORE 40
> +#endif
> +

Why is this necessary? This is defined in linux/capability.h.

> +int capget(cap_user_header_t header, cap_user_data_t data);
> +int capset(cap_user_header_t header, const cap_user_data_t data);

In general prototypes such as these should be defined in header
file. Why are we defining these here?

These are defined in sys/capability.h

I don't understand this change. You are removing sys/capability.h
which requires you to add these defines here. This doesn't
sound like a correct solution to me.

> +
>   static void child_exit(int ret)
>   {
>   	fflush(stdout);
> @@ -87,47 +94,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
>   	return ret;
>   }
>   
> -struct libcap {
> -	struct __user_cap_header_struct hdr;
> -	struct __user_cap_data_struct data[2];
> -};
> -
>   static int set_capability(void)
>   {
> -	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
> -	struct libcap *cap;
> -	int ret = -1;
> -	cap_t caps;
> -
> -	caps = cap_get_proc();
> -	if (!caps) {
> -		perror("cap_get_proc");
> +	struct __user_cap_data_struct data[2];
> +	struct __user_cap_header_struct hdr = {
> +		.version = _LINUX_CAPABILITY_VERSION_3,
> +	};
> +	__u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
> +	__u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
> +	int ret;
> +
> +	ret = capget(&hdr, data);
> +	if (ret) {
> +		perror("capget");
>   		return -1;
>   	}
>   
>   	/* Drop all capabilities */
> -	if (cap_clear(caps)) {
> -		perror("cap_clear");
> -		goto out;
> -	}
> +	memset(&data, 0, sizeof(data));
>   
> -	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
> -	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
> +	data[0].effective |= cap0;
> +	data[0].permitted |= cap0;
>   
> -	cap = (struct libcap *) caps;
> +	data[1].effective |= cap1;
> +	data[1].permitted |= cap1;
>   
> -	/* 40 -> CAP_CHECKPOINT_RESTORE */
> -	cap->data[1].effective |= 1 << (40 - 32);
> -	cap->data[1].permitted |= 1 << (40 - 32);
> -
> -	if (cap_set_proc(caps)) {
> -		perror("cap_set_proc");
> -		goto out;
> +	ret = capset(&hdr, data);
> +	if (ret) {
> +		perror("capset");
> +		return -1;
>   	}
> -	ret = 0;
> -out:
> -	if (cap_free(caps))
> -		perror("cap_free");
>   	return ret;
>   }
>   

thanks,
-- Shuah


