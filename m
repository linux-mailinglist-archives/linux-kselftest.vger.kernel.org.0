Return-Path: <linux-kselftest+bounces-8769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A769D8B0B69
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1DB1C20E77
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739D15B0EE;
	Wed, 24 Apr 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lf0Y/i09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D415B98B
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966279; cv=none; b=iV1dkrzH02UNpm3Fsqu571nCnay+ihrCrCV0vTAKFB9kd4jn1VG5NuQc+pkan3srfVLIPDEGcguisUUwaHjw7Fd0790E3npHOpw3WM21yWX0ATXNKQyfNbBJKQxn3pZ7aqpG1DSR3HAQpDsGKJndywwBO1c0skp8fceTKgI7vEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966279; c=relaxed/simple;
	bh=ihIvZQ1lhIayeVVoC4jmqBSdep063fytTukLDdx9yZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+mWnbfXQWamjRVrFSUOW5ak54GnB54FZDGz1DM4n2QvpurrIHQ4OVtAaM2P+vbVHN7p6BT+ikivarCmkWeOBknj8q+m0OtO0NfYVSZP9tsGFDwwuhkKc5aRLnB2baj/7wxMDi3iz0AfoIrNo2ewzQb6gf/2kjnGgFbFo+KopnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lf0Y/i09; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ab6f586602so217231a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713966277; x=1714571077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/KNDSFclfAattMPcaLu4xqVUcBUQTMHdrpQhgD6K8U=;
        b=Lf0Y/i09ZT65h/ZO3rpunkp13TtlWGB+JTpr4WWdMiTz6EOhFh+Xs73erB8OGifTfc
         POTwGkYXL0EoalEL1tdd1hvQqQPnlPQ3qOJa0JgTdrFcxlwkJW0Dtdxe0xDSfsBZItjY
         jv2MPbj6KRyDgDp01sLi5IHjlSHtddxbCN13c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966277; x=1714571077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/KNDSFclfAattMPcaLu4xqVUcBUQTMHdrpQhgD6K8U=;
        b=ZDbjLP/8vDtdQIS6xcpjN4kpd5yRdqQBm0Vv5jKK4yMwggHtYk0rS4l+Lv2oOdTHMG
         tNdOQ+Q8agSiZAx4me0NxQzXYhd5HV55kU/JJBYeXSuNbi4q5/9AL9kaXKXD2vMWUrDH
         H0vl9sD+yT7NY7ld8Pu2nqeIRRle8rYlv1noJgwhSwhvDElAJFTMLqYIsc1JI7b7Al+0
         2OAfxQTHtO5lbl5Tr0n4dz5q+NSvkRuhCzVvRfJ/kYaC4OCSuHRCuJvkpDl0SGtl6rgb
         HEczBmIvZFHec0Bl2M+YC91MMEixR22pMdiIOLC7bk1e8DADJ8BDCwJQqgr4vS9IZ7wt
         dU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWESI3xysoDxFFfASWt19FkmIsydjtbqanBJb5OZGM90ufC7ZesYO3UokJZ+w+ODwRXeGfRdxJUmVK6UXOC9QXc+rWaUZt2LD7UsyJRsjrN
X-Gm-Message-State: AOJu0YwOWJT6vcplhygmQXEcMAiYfDXIDdBWSrEu8YXRTlyblBJ7QUXy
	I4z+5X1Fk9/KHXWZGmH6nL61bWfMFtOQK8389UUAu3NMcNldd+zGuVTP6w9+uf8=
X-Google-Smtp-Source: AGHT+IFi0FEa8NfGQzs14kkWINqPGBb38znYBqxzSWwuAi5yLnixASU3bnMGLJqc7wL01uaa8+idkg==
X-Received: by 2002:a17:902:ed45:b0:1e2:2ac1:aef0 with SMTP id y5-20020a170902ed4500b001e22ac1aef0mr2782540plb.2.1713966277003;
        Wed, 24 Apr 2024 06:44:37 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id kk4-20020a170903070400b001e245d90d6fsm11944854plb.59.2024.04.24.06.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:44:36 -0700 (PDT)
Message-ID: <bb5fd480-bd43-42c9-b326-2ee7addcda33@linuxfoundation.org>
Date: Wed, 24 Apr 2024 07:44:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
To: Nathan Chancellor <nathan@kernel.org>, shuah@kernel.org
Cc: tglx@linutronix.de, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 09:37, Nathan Chancellor wrote:
> Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
> unconditionally call exit() as __noreturn") marked functions that call
> exit() as __noreturn but it did not change the return type of these
> functions from 'void' to 'int' like it should have (since a noreturn
> function by definition cannot return an integer because it does not
> return...) because there are many tests that return the result of the
> ksft_exit function, even though it has never been used due to calling
> exit().
> 
> Prior to adding __noreturn, the compiler would not know that the functions
> that call exit() will not return, so code like
> 
>    void ksft_exit_fail(void)
>    {
>      exit(1);
>    }
> 
>    void ksft_exit_pass(void)
>    {
>      exit(0);
>    }
> 
>    int main(void)
>    {
>      int ret;
> 
>      ret = foo();
>      if (ret)
>        ksft_exit_fail();
>      ksft_exit_pass();
>    }
> 
> would cause the compiler to complain that main() does not return an
> integer, even though when ksft_exit_pass() is called, exit() will cause
> the program to terminate. So ksft_exit_...() returns int to make the
> compiler happy.
> 
>    int ksft_exit_fail(void)
>    {
>      exit(1);
>    }
> 
>    int ksft_exit_pass(void)
>    {
>      exit(0);
>    }
> 
>    int main(void)
>    {
>      int ret;
> 
>      ret = foo();
>      if (ret)
>        return ksft_exit_fail();
>      return ksft_exit_pass();
>    }
> 
> While this results in no warnings, it is weird semantically and it has
> issues as noted in the aforementioned __noreturn change. Now that
> __noreturn has been added to these functions, it is much cleaner to
> change the functions to 'void' and eliminate the return statements, as
> it has been made clear to the compiler that these functions terminate
> the program. Drop the return before all instances of ksft_exit_...() in
> a mechanical way. Only two manually changes were made to transform
> 
>    return !ret ? ksft_exit_pass() : ksft_exit_fail();
> 
> into the more idiomatic
> 
>    if (ret)
>      ksft_exit_fail();
>    ksft_exit_pass();
> 
> as well as a few style clean ups now that the code is shorter.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
>   tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
>   tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
>   tools/testing/selftests/kselftest.h                          | 12 ++++++------
>   .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
>   .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
>   tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
>   tools/testing/selftests/mm/cow.c                             |  2 +-
>   tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
>   tools/testing/selftests/mm/gup_test.c                        |  4 ++--
>   tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
>   tools/testing/selftests/mm/madv_populate.c                   |  2 +-
>   tools/testing/selftests/mm/mkdirty.c                         |  2 +-
>   tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
>   tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
>   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
>   tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
>   tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
>   tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
>   tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
>   tools/testing/selftests/sync/sync_test.c                     |  3 +--
>   tools/testing/selftests/timers/adjtick.c                     |  4 ++--
>   tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
>   tools/testing/selftests/timers/change_skew.c                 |  4 ++--
>   tools/testing/selftests/timers/freq-step.c                   |  4 ++--
>   tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
>   tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
>   tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
>   tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
>   tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
>   tools/testing/selftests/timers/set-2038.c                    |  4 ++--
>   tools/testing/selftests/timers/set-tai.c                     |  4 ++--
>   tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
>   tools/testing/selftests/timers/set-tz.c                      |  4 ++--
>   tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
>   tools/testing/selftests/timers/threadtest.c                  |  2 +-
>   tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
>   tools/testing/selftests/x86/lam.c                            |  2 +-
>   38 files changed, 81 insertions(+), 79 deletions(-)
> 

Please generate separate patches for each test so it is easy to apply
them and also reduce merge conflicts.

You are missing maintainers for clone3, mm, pidfd tests. I can take these
through kselftest tree, but I need the changes split.

thanks,
-- Shuah


