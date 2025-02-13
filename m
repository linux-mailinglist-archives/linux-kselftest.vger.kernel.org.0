Return-Path: <linux-kselftest+bounces-26494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD029A333F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 01:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AED167A41
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D251179BD;
	Thu, 13 Feb 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA5Outsz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75533F6;
	Thu, 13 Feb 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406310; cv=none; b=rcjc5oWTEzeasDLI5Cya5k5iAPzbPv8jzdsyiF83gY62kDvpzRceYqS+cF/5c2MNkYYX8T3goCvfOlDwoD+Iy7p5KhMx3fEjWslOYOIanxTGEQ72ozQkSemfXp0+eu3t89clgUjR09m4O+al6Bo6AqnPrrq7gn5E0Okq7QwKOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406310; c=relaxed/simple;
	bh=fzyna7PLtoUbYbs8+fX5Za4SKqKoUCKcoou8JqjRvYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+nAl/qBIWK1tUaZqZK5fQDe9UEBMLRm7lCyohOwr1jKkaZ7Gc8RkuLerdPgHjtPdlmkomc7ARU671Cvfmj7WGYwbHgs9kjpXiELyK+UZvcesqqufk1fJjGXE1gubsNwUbO2CdsUVQxXnkrODaKe+TiAcyFi9wLg/FtZndlhljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA5Outsz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso2946503a12.0;
        Wed, 12 Feb 2025 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739406307; x=1740011107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8dBeeEoSDm4SD/YCzWVE+gxCVxcw7YRX7A4c8VioMo=;
        b=kA5OutszU8dgyo/YxArxToAJa4O1j/qmGf8sX5yViyzzSWo0PH3/eTguC3hoLs/zgA
         Q9XBH3m7Lk7fQSKyppe2lHIKnuaBuzr6BA8Si13QvxZ/2h20dh5PAqBnuYbhkNnaw1FK
         W81DGJrYp4UafRjgeuIksUPLXfdBbDDt7uvUdlQKKFIp/hK9AOWzz7wvc8XZG6yLEIUl
         iie63YD0Y5A9dVdyvX2sumgsOvZ48Abn//T55/IlyDJEHiBnNHzMRKWAoR8djTttSu60
         RV61YwLS9HFTE+mkHX4INgI/F4k7Nsh832xjw/bW3IlToFnKqB4SdIwalDLm7qmTAHQ2
         +nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406307; x=1740011107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8dBeeEoSDm4SD/YCzWVE+gxCVxcw7YRX7A4c8VioMo=;
        b=sCJ2jRUHjgdEkS37IBPRfMDjJTh0bW4Ws5QmiWaxn0jcgTGyWA7EOH6EM9DQKk3FOx
         7VTywNzxgU3zTI0TAHMegn3/mxgPkyxn/i6ziohEaItrJeDe9zRjPmO6aR0DbnM1a6iP
         8KIYt8oBYE8eEglGyDgHr1JLcIq998IPGzX+BuEll8pSMqB9dpC0LAhe9Ul92VNa3eU3
         2oSZdzl3F5dvoKFJ3QWukP1+srkfxH9l0xLWn6M0063e3/1fu0UNa8qQtjIdved7+uDh
         VMbiwFrUOgPjYUsgFY3DHVmGaUC+UaQD1sN1e+CkIZeTlkfwAgjpDH9uuJhDaKGV+ubV
         pJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFWBE+GQ8Cybehp43clBKYP6y4N31LFSpI1ia9MTaoRQEn6rEZLH1pGhPA1WMji4isqsc00QKeIxfLpzU/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92guc59yA7ixOSHiCquArI1KmJGKwDHn+cMln7MZQqLE+NLPg
	ETTfppNkXdx/vp6CgDeJx768jRvNwVwDID3Fy6NI8/P5Nbo65hm9vjxKTBSywAWxt9Qc7n1e3cT
	x8QpFuN6yejIb609PwZZLQ1tTbT/ffih+ywk=
X-Gm-Gg: ASbGnctbs41isiEyTBR8hTEFhWBf12zjSg4aQo/IyFkLSS2oXaUYgtkxyNJaI16L6LG
	uRa3sVfjFDyBBbfXVtAZyvZ1SAW5cAM/YpEE8poZbL45GRpHYzoeAbQZm4YJWkeAmqPVq
X-Google-Smtp-Source: AGHT+IFBywya4EAS7dAbROUy9T3txlKiirfcuRq/lCa9/agwJBGHdQZO3s7MfYbRi2pIqybSTqIUYoXFU4GzJwdxoXY=
X-Received: by 2002:a05:6402:1d50:b0:5db:68bd:ab78 with SMTP id
 4fb4d7f45d1cf-5decba815dcmr736936a12.10.1739406306489; Wed, 12 Feb 2025
 16:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128170447.12918-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20250128170447.12918-1-alessandro.zanni87@gmail.com>
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
Date: Thu, 13 Feb 2025 01:24:30 +0100
X-Gm-Features: AWEUYZk-ObCPdB1sCqh0rfANabmxISt7chbnNtEsESdDCHQ8OJSszw4wtsrkSNM
Message-ID: <CABq9Dx53aaX1t2Jidi_zDtR6VDB4UvWo1LkO5GYhCnwfs3ycsQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: pid_namespace and pidfd missing include
To: brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Running "make kselftest" results in several errors like these:
>
> pidfd_fdinfo_test.c:231:36: error: =E2=80=98MS_REC=E2=80=99 undeclared (f=
irst use in
> this function)
>   231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>
> pidfd_fdinfo_test.c:231:45: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclare=
d (first use
> in this function); did you mean =E2=80=98MAP_PRIVATE=E2=80=99?
>   231 |         r =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
>
> pid_max.c:48:9: warning: implicit declaration of function =E2=80=98umount=
2=E2=80=99;
> did you mean =E2=80=98SYS_umount2=E2=80=99? [-Wimplicit-function-declarat=
ion]
>    48 |         umount2("/proc", MNT_DETACH);
>
> This patch adds the <sys/mount.h> include in pidfd_fdinfo_test.c and
> pid_max.c files to find the variables MS_REC, MS_PRIVATE, MNT_DETACH.
>
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/test=
ing/selftests/pid_namespace/pid_max.c
> index 51c414faabb0..972bedc475f1 100644
> --- a/tools/testing/selftests/pid_namespace/pid_max.c
> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> @@ -11,6 +11,7 @@
>  #include <string.h>
>  #include <syscall.h>
>  #include <sys/wait.h>
> +#include <sys/mount.h>
>
>  #include "../kselftest_harness.h"
>  #include "../pidfd/pidfd.h"
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/te=
sting/selftests/pidfd/pidfd_fdinfo_test.c
> index f062a986e382..f718aac75068 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -13,6 +13,7 @@
>  #include <syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/mount.h>
>
>  #include "pidfd.h"
>  #include "../kselftest.h"
> --
> 2.43.0

Hello,

I'm reaching out to know if you have any comments or
feedbacks about this patch.

Thanks,
Alessandro

