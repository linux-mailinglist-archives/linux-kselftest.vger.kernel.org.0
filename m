Return-Path: <linux-kselftest+bounces-38822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF4B2411A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3361D1BC1B20
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 06:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04242C08B3;
	Wed, 13 Aug 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmze2xMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC32BF3C5
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065090; cv=none; b=LEhaFR62u+ngrrJlzOrrVAf6RYVRAc+R5k4Lp4cQOzp1W/OJZJ8uCMr3mRWtg1CBWJ8/DkeMN91GM9AO1LIlcTu50g95sMKmoM9ATZYlcPWp4wVg9tMy8eg12COiEVvGOSzhVSUHqgYn/fCadybv86KQXtYShu4LOjwvsGcL+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065090; c=relaxed/simple;
	bh=eWN7xkKE85MjEYpik+sqsDeU5XU7hK6BAbaVJA3oXTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scnqgiUUtXfupkfCCK+BHAGe3k+kh397u8VFMFuBVdmvkGQmBpV1nMofBm8k6/RyvE53famiP1Xffuzha0ijpWgsDsF4/pj5FCMcfdYbaSr05IvcWSnIr95rfxE1eXcMCoPrQu9dYi8Fx2/iK279ZUI9+RUVuEb9AbXuF6NwfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmze2xMH; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-433f63d7803so1967411b6e.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 23:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755065087; x=1755669887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg/bc4sWjNWuYSBH1zlBDEVWlQ/EAcr6a2lOtEkF72I=;
        b=nmze2xMHMdbNCU6rm5LUomeAUjUbnSJ08I49CuL+xFLiWrgOcVAgtXXp1TLdaogr0G
         t3TY20p4UW7WiIAm9pxPYYCbEuiKuln2fx/w92RIqrH5zi9RiUDrg8AbpJWMl1LRG1uR
         HK3TGOcICo6FFNn0w573z24Ju/E7HlwHHxvsj4PDlY6tXw58cEwLK9QuoIMlVQFGck24
         nE5zF7vddTTZkwgSKZrKwjJfePXoB+hcp/MRVHuV0pcJ5wPBTsWX2hSdHm9bT1anq6b3
         M2fonN2xy1K/4icp0KyWZDV2e37wNBcxVfI2B+Pki0wlQUuO4dvjsPQnAqWgdomWjHkE
         Morw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065087; x=1755669887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg/bc4sWjNWuYSBH1zlBDEVWlQ/EAcr6a2lOtEkF72I=;
        b=cMiUXDslr73pqeC35G4Tno74GL3pAE5QFd1RR9KEcqtwPEyx3WS4FFfMswW/DVZ0JV
         7SzrwBt6WS2akU24cO8cAWpClqJIkvJn6maGK+1RCztpFsl4Ab6WpdNHRs1HcDLvVDP/
         Rl5hDvPTZaXUVpCtxbTl0aWY4sfEdnF/qzFjCn8aBdP8JtGSR37upvVeAISL9Yl1s//A
         eIZT4SJAAZf5G1KwNw2JGOGxBhXd9pskdKN3gCeqoV8fmSIn7zKkFovry6IWRb0WfMIz
         Tf/KDtRO5JiFzGToruJsdZlEIIBxqMEfCaVSzkeT4W9QYAXm9Ie2yZZ8yULQmkvtd1Bh
         8Xbw==
X-Gm-Message-State: AOJu0Yz0CwQB4cD6F2/C1dCzd59dd6Bd5oFwoSBHcmx2RSrNg5aqlUb8
	/b/Gd9BnTtIwfbT32FsA2wvUKdUh+LMGiSr8mxaJdznUpmOEYu5xe2kw9Ch5hj8+Yw/wV0PokSr
	SMDaAR84fBTwPxU0Hc5XX9KsVySb5/O/F0ehLN66GEpyu
X-Gm-Gg: ASbGncu7ClwpHs4f6fuAALxNXq9wTE7FfgNnP/PvjfRsOasuwa6TxnabUEyrd+/1jP+
	QXqoOUsPyLhjmWdI9SZOUVsuVjxWUrAApUfoUREQX9y3e8TJaAS4BXLg0vNjbt67YHCp/R2CaWR
	XYkXJQfRZzqYuo1uXzxQa5j+fiLczwJtoeJGnPT7UwwO0f2Xstai40yYd0H6KsfHGvjFjn91vpH
	PXtYvU=
X-Google-Smtp-Source: AGHT+IGR0nc23LHeCGsfu1WFnoXlbRrrWqjqefY/C5pjkEx4oNgJ6MnUSrRKzlzxeP80b8rVxlMW5Mjgc3TfqpIL21I=
X-Received: by 2002:a05:6808:30a3:b0:434:aadd:72a3 with SMTP id
 5614622812f47-435d416566amr1148862b6e.8.1755065087583; Tue, 12 Aug 2025
 23:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813031647.96411-1-higuoxing@gmail.com>
In-Reply-To: <20250813031647.96411-1-higuoxing@gmail.com>
From: Xing Guo <higuoxing@gmail.com>
Date: Wed, 13 Aug 2025 14:04:35 +0800
X-Gm-Features: Ac12FXyNppAtrtp5bs4--ABVF4wp3DMySzfPrO38WCtCo-9kZTVEGkzkVPb9spI
Message-ID: <CACpMh+DhNLu1H2obFDZmqPT2_oWn4=FvpqZ5L5afhG97BfmFqg@mail.gmail.com>
Subject: Re: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, jhubbard@nvidia.com, amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I forget to attach the error message in my previous email.

CC       mount-notify_test_ns
mount-notify_test_ns.c:23:3: error: conflicting types for
=E2=80=98__kernel_fsid_t=E2=80=99; have =E2=80=98struct <anonymous>=E2=80=
=99
   23 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~
In file included from /tmp/kselftest/usr/include/asm/posix_types_64.h:18,
                 from /tmp/kselftest/usr/include/asm/posix_types.h:7,
                 from /tmp/kselftest/usr/include/linux/posix_types.h:36,
                 from /tmp/kselftest/usr/include/linux/types.h:9,
                 from /tmp/kselftest/usr/include/linux/sched/types.h:5,
                 from /usr/include/bits/sched.h:63,
                 from /usr/include/sched.h:43,
                 from mount-notify_test_ns.c:6:
/tmp/kselftest/usr/include/asm-generic/posix_types.h:81:3: note:
previous declaration of =E2=80=98__kernel_fsid_t=E2=80=99 with type =E2=80=
=98__kernel_fsid_t=E2=80=99
   81 | } __kernel_fsid_t;
      |   ^~~~~~~~~~~~~~~
make[1]: *** [../../lib.mk:222:
/tmp/kselftest/kselftest/filesystems/mount-notify/mount-notify_test_ns]
Error 1
make[1]: Nothing to be done for 'all'.

Best Regards,
Xing






On Wed, Aug 13, 2025 at 11:17=E2=80=AFAM Xing Guo <higuoxing@gmail.com> wro=
te:
>
> Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
> dir") introduces the struct __kernel_fsid_t to decouple dependency with
> headers_install.  The commit forgets to define a macro for __kernel_fsid_=
t
> and it will cause type re-definition issue.
>
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> ---
>  .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
>  .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_te=
st.c
> index 63ce708d93ed..e4b7c2b457ee 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.=
c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.=
c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +       int     val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,20 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>
>  #include "../../kselftest_harness.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -       int     val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_root=
.XXXXXX";
>
>  static const int mark_cmds[] =3D {
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notif=
y_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify=
_test_ns.c
> index 090a5ca65004..9f57ca46e3af 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_=
ns.c
> @@ -2,6 +2,13 @@
>  // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
>
>  #define _GNU_SOURCE
> +
> +// Needed for linux/fanotify.h
> +typedef struct {
> +       int     val[2];
> +} __kernel_fsid_t;
> +#define __kernel_fsid_t __kernel_fsid_t
> +
>  #include <fcntl.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -10,21 +17,12 @@
>  #include <sys/mount.h>
>  #include <unistd.h>
>  #include <sys/syscall.h>
> +#include <sys/fanotify.h>
>
>  #include "../../kselftest_harness.h"
> -#include "../../pidfd/pidfd.h"
>  #include "../statmount/statmount.h"
>  #include "../utils.h"
>
> -// Needed for linux/fanotify.h
> -#ifndef __kernel_fsid_t
> -typedef struct {
> -       int     val[2];
> -} __kernel_fsid_t;
> -#endif
> -
> -#include <sys/fanotify.h>
> -
>  static const char root_mntpoint_templ[] =3D "/tmp/mount-notify_test_root=
.XXXXXX";
>
>  static const int mark_types[] =3D {
> --
> 2.50.1
>

