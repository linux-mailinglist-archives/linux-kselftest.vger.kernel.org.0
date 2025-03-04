Return-Path: <linux-kselftest+bounces-28200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097CA4DD31
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DCF7A5303
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F75200132;
	Tue,  4 Mar 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGxJYrI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33464201016
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089419; cv=none; b=Z+qOAWwmnVoOrWc88xpXaVt/B9euXwOLVe5iZnqimgo7L3j8PsS2TEVFG/3hT3mKWskDJxUWuwfwjIxyrK/KwTPPeCjBlK9N04/Y9sNgNNqIy+czTAiwPZrCCkKK1MtUOcqEs2KecE3LMuB1+x6Bvfe5CWDc46RV2y9VdIZEXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089419; c=relaxed/simple;
	bh=7CV/tglOXpwtd+ACTlnlPRuyKcTdqYGbOWgaAct7b60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qn8K72zrsG2YQfxCnrYD7SU3Q96fFpnDVFv7oFp9k13XX+HMb60mCt8Dv5/IQBk/PJmCvpQ17RlKoupUSQc8nrCCqFGz5P2k/rs8+yr3cPxRMulRtbx2qlLz+TSItWVYEZtgK4pxwu6CvQPdBZE5KS76UV+ESuUBHLZYUhV5/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGxJYrI2; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso5736812e0c.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 03:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741089417; x=1741694217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1niHqFMSHq72s1r9U6R1sN/sD6PMQLCGG4Ay/Tpacaw=;
        b=iGxJYrI2zZ6cKETexOvcGt7aWTdfcvwIKcjUllUJVTNl1276qCRo2jmhGV7pBBo6VY
         7xz8lDx01pPdRTEbbmziPE+ZrfFpumoi1LWx54ZF3uB+lmoK5XzdF07MATA+Bs+yIeW4
         Yfci6o1TnA6vYoULl4ef2XGbeQCjaCKyxf7MB50g17zJEt/sYi51YWAPXQeWC7jeO41E
         fKKawTHUS9B5fXF/GL9UGZGIPT/qP3RgBc2RDtPdG4E+7Xs7srvm8SrIYq4AtmrH5ZAs
         GDBvyZ0C7nw52RDLAiSqrKrPAVw9AKi+vzl/QMES5fF5fE19gGeJ0l+CXHahm1Wl5feH
         dG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089417; x=1741694217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1niHqFMSHq72s1r9U6R1sN/sD6PMQLCGG4Ay/Tpacaw=;
        b=UgIuQWP8I7vstxhm8Bf8PooWb3+Jjix0Ybx30We/KBmXTBb/pP+bpHSC9v1QwgraMx
         moRnnbO/ibIp6Sa4w+TXsHJ/qQ0qUo/DHMop+026eh8eQpMofr9evD3Ym7y3k4dy2ZGK
         TFdBBhr1uQDwYvCFmhhdbzLAYRjJpzar0Z3fcOI6Fygrj3gCMDwC9uKs13DcgrJzZa5k
         uhvndpL57gLCbhBz6RroO/BmuebQgsg5XmWkvCNgd6ipRf+o+NyLPwMeRMvDVz7V677g
         5Zq6WPZUrVdpNNPi7tZo2k93bLwESYXV/j9o3Ik2S+qlg8hHXZpKsNnFBDNA6S8TMo0Z
         Vq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWCGhwF+TQN4bjZ7U6+nS0gCwylJKPIZOb1jUgvZ9/1/bzqoCVcJf+uYuRTI+Li2BauAamFLvoWcLB09Ptjd8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sMgWBb7ICyVcj9h2Z+83xAS+DF8ZDYVW7hPHsj5O0LAOVqNF
	vRlMj26gslD4aQclVPTzEQkd65DTtPZ+IuuOcClaAvedcacL1oTOdxSvpskKKa9v/aW/JLMJVLl
	0AUltuZfCeMENMPOSn0iTyl+p+FRAysq/5aI2yQ==
X-Gm-Gg: ASbGnctFeNjCSpm9Rb21XsLYHlVcUZUEEmHPif29ZAVv+/Spr5BJ143npRx94Xxfv4V
	0Xr4JIE4QwCGbBr3s5iTHT8ApqrHtnC/cuEHReDYvTD6T61RK0BPKlGre/k/8OqQl156sWekLzU
	Vk4Y+2F0o16GE8DoLRT6H50miCyoXoq/LDUKmqIxWHlSXPvm39D/G9yw6wLEM=
X-Google-Smtp-Source: AGHT+IEBpk86hUVQz5hrr3Y4izjaPl+V8gq8s8kHDbuezRtsg/3SFAe7YGJ7EmCDFYA+0y/Wv0n2i9DoVAZcUR3J4gk=
X-Received: by 2002:a05:6102:330c:b0:4bb:e36f:6a35 with SMTP id
 ada2fe7eead31-4c044961241mr9235577137.14.1741089416962; Tue, 04 Mar 2025
 03:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 4 Mar 2025 17:26:45 +0530
X-Gm-Features: AQ5f1JqTpjO7WcSglV7CxNDa8lwt4A83sT-2JklUF1keCdefKeaIxJcBGckLea8
Message-ID: <CA+G9fYsrfM62=kr=q1nu_Nx9-sTHQw-6A-3OWkiqgs4JiKzvgA@mail.gmail.com>
Subject: =?UTF-8?Q?selftests=3A_cgroup=3A_Failures_=E2=80=93_Timeouts_=26_OOM_Issue?=
	=?UTF-8?Q?s_Analysis?=
To: Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As part of LKFT=E2=80=99s re-validation of known issues, we have observed t=
hat
the selftests: cgroup suite is consistently failing across almost all
LKFT-supported devices due to:
 - Test timeouts (45 seconds limit reached)
 - OOM-killer invocation

## Key Questions for Discussion:
 - Would it be beneficial to increase the test timeout to ~180 seconds
   to allow sufficient execution time?
 - Should we enhance logging to explicitly print failure reasons when a
   test fails?
 - Are there any missing dependencies that could be causing these failures?
     Note: The required selftests/cgroup/config options were included in
     LKFT's build and test plans.

## Devices Affected:
The following DUTs consistently experience these failures:
  -  dragonboard-410c (arm64)
  -  dragonboard-845c (arm64)
  -  e850-96 (arm64)
  -  juno-r2 (arm64)
  -  qemu-arm64 (arm64)
  -  qemu-armv7
  -  qemu-x86_64
  -  rk3399-rock-pi-4b (arm64)
  -  x15 (arm)
  -  x86_64

Regression Analysis:
 - New regression? No (these failures have been observed for months/years).
 - Reproducibility? Yes, the failures occur consistently.
 - Test suite affected? selftests: cgroup (timeouts and OOM-related failure=
s).

Test regression: selftests cgroup fails timeout and oom-killer
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log:
# selftests: cgroup: test_cpu
# ok 1 test_cpucg_subtree_control
# ok 2 test_cpucg_stats
# ok 3 test_cpucg_nice
# not ok 4 test_cpucg_weight_overprovisioned
# ok 5 test_cpucg_weight_underprovisioned
# ok 6 test_cpucg_nested_weight_overprovisioned
# ok 7 test_cpucg_nested_weight_underprovisioned
#
not ok 2 selftests: cgroup: test_cpu # TIMEOUT 45 seconds

<trim>
# selftests: cgroup: test_freezer
# ok 1 test_cgfreezer_simple
# ok 2 test_cgfreezer_tree
# ok 3 test_cgfreezer_forkbomb
# ok 4 test_cgfreezer_mkdir
# ok 5 test_cgfreezer_rmdir
# ok 6 test_cgfreezer_migrate
# Cgroup /sys/fs/cgroup/cg_test_ptrace isn't frozen
# not ok 7 test_cgfreezer_ptrace
# ok 8 test_cgfreezer_stopped
# ok 9 test_cgfreezer_ptraced
# ok 10 test_cgfreezer_vfork
not ok 4 selftests: cgroup: test_freezer # exit=3D1
<trim>

selftests: cgroup: test_kmem
#
not ok 7 selftests: cgroup: test_kmem # TIMEOUT 45 seconds

<trim>

# selftests: cgroup: test_memcontrol
# ok 1 test_memcg_subtree_control
# not ok 2 test_memcg_current_peak
# not ok 3 test_memcg_min
# not ok 4 test_memcg_low
# not ok 5 test_memcg_high
# ok 6 test_memcg_high_sync
[  270.699078] test_memcontrol invoked oom-killer:
gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0, oom_score_adj=3D0
[  270.699921] CPU: 1 UID: 0 PID: 946 Comm: test_memcontrol Not
tainted 6.14.0-rc5-next-20250303 #1
[  270.699930] Hardware name: Radxa ROCK Pi 4B (DT)

<trim>
[ 270.729527] Memory cgroup out of memory: Killed process 946
(test_memcontrol) total-vm:104840kB, anon-rss:30596kB,
file-rss:1056kB, shmem-rss:0kB, UID:0 pgtables:104kB oom_score_adj:0
# not ok 7 test_memcg_max
# not ok 8 test_memcg_reclaim
<trim>
not ok 8 selftests: cgroup: test_memcontrol # exit=3D1

## Source
* Kernel version: 6.14.0-rc5-next-20250303
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
* Git sha: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
* Git describe: 6.14.0-rc5-next-20250303
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250303/

## Test data
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next=
-20250303/testrun/27482450/suite/kselftest-cgroup/test/cgroup_test_memcontr=
ol/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250303/te=
strun/27482450/suite/kselftest-cgroup/test/cgroup_test_memcontrol/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250303/te=
strun/27482450/suite/kselftest-cgroup/test/cgroup_test_memcontrol/
* Test logs rock pi:
https://lkft.validation.linaro.org/scheduler/job/8148789#L1774
* Test logs x86:  https://lkft.validation.linaro.org/scheduler/job/8148731#=
L1948

--
Linaro LKFT
https://lkft.linaro.org

