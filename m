Return-Path: <linux-kselftest+bounces-8789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57B8B0FC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2085B2433C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173D1635AB;
	Wed, 24 Apr 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6VcMYOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF116190B
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976086; cv=none; b=BALq06w53Ejwg2NQvv0ISvsY3y0/zTDcZLyml8M8uKLE8GMC1zzs+v5rssmyDF9+RORXIZD9JV41G/oVaV2gcLVOFujarKWY908/4mT0IPkzxCtL3MLabRjn+4LN42HQASA1aADf3iD1nA/juZs3AyZ1e8soVc3vbS0bunp6fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976086; c=relaxed/simple;
	bh=V74XErXb5mOshzhsLFALwFLRBHGhL6q3WN4ByroeZdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqW9ALJ0pj9Uk5hEwg1jLReMWhBdslwZ2LEjv3W0sAhQ1VOy1xXJe8KBdWZiHVL45woyVBEIVL/lkhkzYGmG2kuNfGE2Ro4AnfBB7XvEQLdM0h2wSXR6uUjF3B1i+I1Tp6y3k0OBDHIfnAZ5/+2MwKcm4aMUERrv3UmmmYG/gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f6VcMYOv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f013c304bbso18084b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713976083; x=1714580883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dt2KVRYxDBRXLbNK/m8PvF4OR+Oty/TNCiiqaQpoANU=;
        b=f6VcMYOvL5uCOryEBMw9sLKprQ201cbcO6UMDm0li4CkuUHqswl+bHX9phTQ5/Y38n
         8qnvxoaXtlJH9BDwob03RLA5SkohiK104hFodM6QotNogJEYyGsiraQZhF1e0X6ylgtI
         RK+d+lpmqwDcmfUzM8zglbqlPjHSxj9iVR5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976083; x=1714580883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt2KVRYxDBRXLbNK/m8PvF4OR+Oty/TNCiiqaQpoANU=;
        b=abk/X6n1lw1MsPzBbwwZNiG5FGb/vugRjoEYwnSYLI2X0q8fYjYLKLOf8Ui0+GOQ2y
         KlBe8eQJSWWwcAOdFLm4E+jhBcTzhxWYfCY77canH+beMyc1m6XUVieUBWsGQer00/vp
         1p2+Ovk1+gPBsXQLkbLyfJ+rXReslfGor6Mbe+BElc9vfLshgX03fsl/VRyL7hisZQC8
         p8Cbba/uLm+xoTw1TWUwXTJC9LdQbg5ed4PCtpg5s0Dwr/weJlB0MhC+oqjY+zZoh7ha
         R95SGWadxyqz1teqJlCIML/ZOy59hJGuN/cnegqR7pZ0jjydsknLaKid3+6siqG+Ge+s
         Be9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrc0ij0oKBMgv+Ju/Ah5n/p40BoZ5P6046FajjIiZTX6C5iwITuSHI6IfbQLsqmHRwW/91u/BttgMCd53UJO3jyMRMU7gBShdGozGNFaPm
X-Gm-Message-State: AOJu0YxISS6Riw7Q3kiml8ETwe4J1tqoUHiSRt6lLdjZnKgjatm3OV19
	oKnwGr/hAKuukKw/xRJbwYxsc4yIz+wHLSsXjfUDMeNQROvMcxHGlx8dmh4CoLg=
X-Google-Smtp-Source: AGHT+IEM22IfPFG/x1imwFqf85wR7jBR5YFXWlluajTgpg+q7Vh0S2I3mIE4aEXTjGeND0JxII15uw==
X-Received: by 2002:a05:6a00:898a:b0:6ea:b1f5:8aa with SMTP id hx10-20020a056a00898a00b006eab1f508aamr3276274pfb.3.1713976083513;
        Wed, 24 Apr 2024 09:28:03 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78648000000b006eade394613sm11622481pfo.198.2024.04.24.09.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:28:03 -0700 (PDT)
Message-ID: <9cceb519-e627-4041-bbd4-227e47d5d209@linuxfoundation.org>
Date: Wed, 24 Apr 2024 10:27:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
To: Nathan Chancellor <nathan@kernel.org>
Cc: shuah@kernel.org, tglx@linutronix.de, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
 <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>
 <20240424150513.GA304587@dev-arch.thelio-3990X>
 <ba14458b-8f69-4947-ade2-d77e3290d4ed@linuxfoundation.org>
 <20240424161059.GA904896@dev-arch.thelio-3990X>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240424161059.GA904896@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 10:10, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 10:00:12AM -0600, Shuah Khan wrote:

>>>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>>>> ---

clone patch

>>>>>     tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
>>>>>     tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-

ipc patch

>>>>>     tools/testing/selftests/ipc/msgque.c                         | 11 +++++------

kselftest.h patch

>>>>>     tools/testing/selftests/kselftest.h                          | 12 ++++++------

membarrier patch   etc...

>>>>>     .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
>>>>>     .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-

>>>>>     tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
>>>>>     tools/testing/selftests/mm/cow.c                             |  2 +-
>>>>>     tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
>>>>>     tools/testing/selftests/mm/gup_test.c                        |  4 ++--
>>>>>     tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
>>>>>     tools/testing/selftests/mm/madv_populate.c                   |  2 +-
>>>>>     tools/testing/selftests/mm/mkdirty.c                         |  2 +-
>>>>>     tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
>>>>>     tools/testing/selftests/mm/soft-dirty.c                      |  2 +-

>>>>>     tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
>>>>>     tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
>>>>>     tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
>>>>>     tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-

>>>>>     tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---

>>>>>     tools/testing/selftests/sync/sync_test.c                     |  3 +--

>>>>>     tools/testing/selftests/timers/adjtick.c                     |  4 ++--
>>>>>     tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
>>>>>     tools/testing/selftests/timers/change_skew.c                 |  4 ++--
>>>>>     tools/testing/selftests/timers/freq-step.c                   |  4 ++--
>>>>>     tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
>>>>>     tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
>>>>>     tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
>>>>>     tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
>>>>>     tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
>>>>>     tools/testing/selftests/timers/set-2038.c                    |  4 ++--
>>>>>     tools/testing/selftests/timers/set-tai.c                     |  4 ++--
>>>>>     tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
>>>>>     tools/testing/selftests/timers/set-tz.c                      |  4 ++--
>>>>>     tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
>>>>>     tools/testing/selftests/timers/threadtest.c                  |  2 +-
>>>>>     tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---

>>>>>     tools/testing/selftests/x86/lam.c                            |  2 +-

>>>>>     38 files changed, 81 insertions(+), 79 deletions(-)
>>>>>
>>>>
>>>> Please generate separate patches for each test so it is easy to apply
>>>> them and also reduce merge conflicts.
>>>
>>> Is applying 30+ patches easier than applying just one? It is not a
>>> trivial amount of work for me to break this series up into individual
>>> patches but I will do so if you really want me to. I based this on the
>>> kselftest tree directly so that it would apply cleanly.
>>>
>>
>> I am not asking each file to be a separate patch.
> 
> What granularity would you like? One per folder in
> tools/testing/selftest (i.e., clone3, ipc, membarrier, etc)?

Correct. It will be 10 patches. Please see above for the split I have
in mind.

thanks,
-- Shuah


