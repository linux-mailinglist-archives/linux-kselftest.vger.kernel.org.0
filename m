Return-Path: <linux-kselftest+bounces-19742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89A99F13D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD42876A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56E1F6689;
	Tue, 15 Oct 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Toiw5qMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFB1F6667
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006277; cv=none; b=ErE7mGQ3X6hmjTxPzIcGtCqWmNwccaade7x+NfZYtcWDj/qzfODMcwPWze4y2NxkWzbyaAI5z2/gtrMODsJucct3+/Tp+IX6R86yPDuB4sncJa4yJjf5RRpo1u0oOKdbA0UKaQabpesldISUQN3y/yzLLLvnPy+1goc+s2SZfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006277; c=relaxed/simple;
	bh=hhDCucaZ1PzlX1SWh5P/3nZNBB7Y1Px3LSdrjKDdTjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kz5iUWZZws+CEE45n/z5vS3ovoCFQ1Altr50avzpkG6gnyoZ2cqwLlNaL2vxQiuvbanmkRl6dRCli+jUuGzjeMMYeCayrcKHQF0OI0YGoDEgk09qpHqgCQrWNA3o7P8/MWuk4/ZrkNioriX6GKuqmh4ncDsPPgKveI/DPx1jivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Toiw5qMh; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8369b14fb91so169083939f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729006273; x=1729611073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wBjrXmfB1qExnYUI70ZkbU7dHuoAtow6T1PTtZYfg0=;
        b=Toiw5qMh+kf/uOAbsiySdVrHcfoivRSct940XD3y7j4V5l1Iv3mKq8LEHX/BB5NHsT
         b7LlJfUOrxw5u50KlnPO5amJY8h9/vVJfjwn3CTZwubYiVHxWMhZJWJwmAe5iwrVS5Wi
         ropMVPjBD++IbTcRPoABG4vlUNht/CoHk6GPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006273; x=1729611073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wBjrXmfB1qExnYUI70ZkbU7dHuoAtow6T1PTtZYfg0=;
        b=Iv8zJQhvvZKBHkEhnYXlxWV5mnxpvwh0Lmapw5Tpqw6yn+IeDw2Jk5TFTJ8tj1jnga
         oEPVG7wOaBuF2AJRdO8ljEa6VyS6H2xSRNO6RBF5bAaIAdjBG9iQJyOHLDCvewOY+KI3
         orJEY03qGGolX5j+O3tieV4ZS8IY80ecv6eZ4USWZBwv1x60ebeJv4qAU2WsohRhv8JR
         zU9UCgstvJNxYzyYWToh24VJSKHLzzhvCNIluvnBcL4gmiGaUdlUIs7E7t+gVBmNw/DA
         NZVIK6iC15dpAR4jj4eO21udMYVISXDrc8/AQ1lJhcRzB/y31Kgonjc9tgaL2K0rXXOS
         mh4A==
X-Forwarded-Encrypted: i=1; AJvYcCW8RXuGSNg3K7Z1xMCMbPPz5Lesl4wUjNs7O/RmPt1uBZLdGTFqMvTFnDhHFN5Lt9qI9rHdmo9aZlpvUOF+HJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3NiKK11AfQhWJoXmkcJ4JLm+QFUF5DsfFbDcOS+7IgYn94it
	VCZIVNQ0V61g5Rtmf9tW+xIZeY2BsE27iBh+AfDxCYSCElGBaZox2r8bcJA28hA=
X-Google-Smtp-Source: AGHT+IE91cJLGTmXV+ieSM/eGbv+ULQ3XXk007BVO80y68MdV31lmqHtde5RuS0uFROozmcADM5jgA==
X-Received: by 2002:a05:6602:618c:b0:82c:edd4:f0a6 with SMTP id ca18e2360f4ac-83a946f27e5mr108236839f.12.1729006272737;
        Tue, 15 Oct 2024 08:31:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a612sm362791173.162.2024.10.15.08.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:31:12 -0700 (PDT)
Message-ID: <806bee31-d740-49c9-abe0-06820cfa7395@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:31:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015105955.126994-1-zhouyuhang1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015105955.126994-1-zhouyuhang1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 04:59, zhouyuhang wrote:
> From: zhouyuhang <zhouyuhang@kylinos.cn>
> 
> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a __u8 mutex at the beginning of the struct _cap_struct, it changes
> the offset of the members in the structure that breaks the assumption
> made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
> This will make the test fail. So use the capget and capset syscall
> directly and remove the libcap library dependency like the
> commit 663af70aabb7 ("bpf: selftests: Add helpers to directly use
> the capget and capset syscall") does.
> 
> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
> ---
>   tools/testing/selftests/clone3/Makefile       |  1 -
>   .../clone3/clone3_cap_checkpoint_restore.c    | 53 ++++++++-----------
>   .../selftests/clone3/clone3_cap_helpers.h     | 23 ++++++++
>   3 files changed, 44 insertions(+), 33 deletions(-)
>   create mode 100644 tools/testing/selftests/clone3/clone3_cap_helpers.h
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
> index 3c196fa86c99..242088eeec88 100644
> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> @@ -15,7 +15,6 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <stdbool.h>
> -#include <sys/capability.h>
>   #include <sys/prctl.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
> @@ -26,6 +25,7 @@
>   
>   #include "../kselftest_harness.h"
>   #include "clone3_selftests.h"
> +#include "clone3_cap_helpers.h"
>   
>   static void child_exit(int ret)
>   {
> @@ -87,47 +87,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
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
> diff --git a/tools/testing/selftests/clone3/clone3_cap_helpers.h b/tools/testing/selftests/clone3/clone3_cap_helpers.h
> new file mode 100644
> index 000000000000..3fa59ef68fb8
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_cap_helpers.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CLONE3_CAP_HELPERS_H
> +#define __CLONE3_CAP_HELPERS_H
> +
> +#include <linux/capability.h>
> +
> +/*
> + * Compatible with older version
> + * header file without defined
> + * CAP_CHECKPOINT_RESTORE.
> + */
> +#ifndef CAP_CHECKPOINT_RESTORE
> +#define CAP_CHECKPOINT_RESTORE 40
> +#endif
> +
> +/*
> + * Removed the libcap library dependency.
> + * So declare them here directly.
> + */
> +int capget(cap_user_header_t header, cap_user_data_t data);
> +int capset(cap_user_header_t header, const cap_user_data_t data);

Sorry you haven't addressed my comments on your v1 yet.

I repeat that this is not the right direction to define system
calls locally.

Try this:

Run make headers in the kernel repo.
Build without making any changes.
Then add you changes and add linux/capability.h to include files

Tell me what happens.

thanks,
-- Shuah

