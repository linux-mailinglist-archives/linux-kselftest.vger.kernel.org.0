Return-Path: <linux-kselftest+bounces-18937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D098E626
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9721F248B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137419ABD1;
	Wed,  2 Oct 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wqg2x1TG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57B199FA9
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908785; cv=none; b=Lebhk/w3LIUQRyBFCwGGPtAvZkOCS6YYT4/75Xd+Osqn2qSL8dQzyqRsxfDhXavBSyzPcohZDbMMTk9sZ6d+ON3UxyRWoghK1voIGS32l+q/nLIhCIIQmzIChi0vdDk8PZrQFM6782WbfcBfzEpKD6nePW8JDeg/ITBN/092W44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908785; c=relaxed/simple;
	bh=TkGpttuFdJYpTjJCIAGv72ELYF4FINoKjnORoIFn5ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pVVvwpCKrzYdJSr7pf1pXj17YtTG6A0vf2nWDfSzqhVigaDaO8i94k/iPOq2sAE7eebnvHGHWuOEffXurJTITbHc60jp6lBU2LeMuj9CQ2mNTsi27HFxUv/uqCt5FnmSOTdRfHAVJR61x3i81FW3zJLjG4g1lxSZ5rLrOgTiV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wqg2x1TG; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd869453eso15470739f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727908783; x=1728513583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QJHaRStwRtyc6nZDJ4Lw1Frf6VhBiP6/3232iO1Wm0=;
        b=Wqg2x1TGjC4MNMcmLyEJ8Rj+DLlggQOsIPaTWVEnyspUn5enSSIB0QWTj0+QPlIMFy
         sJSf2nwwN3RMJ+SXe4n6Dl8XM5P9k1m8XTw/vmXEboofZ5a5X/kAnOFIGicYs3i0PgSO
         /GNqlWOszeRLo+JcKAomxF5EyXBS6CXOLsa6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908783; x=1728513583;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QJHaRStwRtyc6nZDJ4Lw1Frf6VhBiP6/3232iO1Wm0=;
        b=WZfV9HRSO+9WB5W1FsOhsgyWoKsxPD8yvjn5CqSsqVRk56Ddpo8e0SnafNCRc2hAMI
         TaFvs0ICahjDsqfF8OtNPO2crM2cO74om+90Cyhc8Z14+qKk5PVS3ErXrozIOcaFoLK1
         B4ADPRE1mTIAbzxzMpSYE92YcvGWG7PyU0MGq3RCHGK9cBiVaOqAqHjLjyLLAYYE9v+m
         /ZVVgSj2VEYd01SyJ9rY8uTF3TfAXzvHOOIuluo4iSBM7DMiBcN4LstF7kvjWxPba639
         0J1rdU4R3s4uHgHJPa2sd5Jov8D6fzWsXNjsWGz5KQAljqiny66zycrlqr1twiSiNrcc
         yehw==
X-Gm-Message-State: AOJu0YxoQ2oa5yewBcezU1x02q2dVVK6WfumoqYCm9WUs+k47y8NUCJx
	soK5yvfDpN482B4rtZJ5nBIrXpiNanbEexiHZGGe5m8NXgbd+tve/lqxZTCS9v+ch+Ixrs01WXD
	X
X-Google-Smtp-Source: AGHT+IFjD+nQTLVS43vRwkvmLpLXSwXZtuT9VRRYi/CdLuf7UfJN6wPefLLd8ririCaPPa/96QmvOw==
X-Received: by 2002:a05:6602:140a:b0:832:40d0:901e with SMTP id ca18e2360f4ac-834d847d527mr524176939f.9.1727908783013;
        Wed, 02 Oct 2024 15:39:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55969177sm15603173.41.2024.10.02.15.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 15:39:42 -0700 (PDT)
Message-ID: <543d4b19-e530-45e3-876c-522101f9a5e6@linuxfoundation.org>
Date: Wed, 2 Oct 2024 16:39:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vdso: Add linux/sched.h to fix CLONE_NEWTIME
 build error
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, shuah@kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20241002152849.111841-1-surajsonawane0215@gmail.com>
Content-Language: en-US
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002152849.111841-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 09:28, SurajSonawane2415 wrote:
> Fix build error in vdso_test_getrandom.c due to missing CLONE_NEWTIME.
> Include linux/sched.h to define CLONE_NEWTIME.
> Ensure successful compilation by resolving the missing header issue.
> 

Did you run "make headers" before building this test? It builds
just fine for me on my system.

+ Adding Jason Donenfeld

> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 72a1d9b43..3f2a4dbf8 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -22,6 +22,7 @@
>   #include <linux/random.h>
>   #include <linux/compiler.h>
>   #include <linux/ptrace.h>
> +#include <linux/sched.h>
>   
>   #include "../kselftest.h"
>   #include "parse_vdso.h"

thanks,
-- Shuah

