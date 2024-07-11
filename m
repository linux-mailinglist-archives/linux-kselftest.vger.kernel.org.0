Return-Path: <linux-kselftest+bounces-13582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A692E80B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F32DB213AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CC15B11D;
	Thu, 11 Jul 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDvJB6KZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E21459E3;
	Thu, 11 Jul 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699997; cv=none; b=X6t4as6bB9I2NNS401Vn06XTupjH7fjhVKrXMgvviCDlBRi7nDYoeuWi65jEx0DQ5rjXC+8/sKg/YRymbmtOHBlaGbbmb/6Nk6BKzOG17qecqKvjSPfI9DZRHx8FsqL5Q9ZZY00npWYUOblW+gOdm+3oQ7JIBKmlz2lum7l5xMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699997; c=relaxed/simple;
	bh=h9HbpYW8qryT7BVOo7V0FvjYk9cqlw8vFypo+q2ixFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq4m2KKpYGCC3eVfPHPPqKrPbKVz3xSy6y3Gx9wPom5ZbziWseIYywd/8xariJq2r/HZPm7d7CUViTXyXT+UZUXHRLIdubHNCqCcT9wbQuRTQIMr0tmFccQMNzDiUNlOmSIVyMOKsZ3n9RhGdbkqCZGuY2e94rPYkCDq4JFLbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDvJB6KZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B638C32786;
	Thu, 11 Jul 2024 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720699996;
	bh=h9HbpYW8qryT7BVOo7V0FvjYk9cqlw8vFypo+q2ixFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dDvJB6KZUrbPurGK328ixhl1sjK/jbuqdv2pWZgCOgHmnAr78DdwYBEHN1rao0XD4
	 WmluE2sRqke5v9b7IFZIfGi4HJhWkSUG0rrNLueX0jqEhBfsMg0SfxbjKwOCLeASGs
	 v95j4kSsFMY+5unc8Q++EnsMnEI4uHfmiWgW0h8E4auPxNk0E187F//fd976YH590Z
	 cDd2pDDUKct1JnpZ3OZw8wQ7mvsCvw4/3XXQl5XkamtAXouolEo1cAySVGFD0kNLJk
	 phuh0mW3IIKaugWGh3N1xFP9n4RdCWfkeH5z3+7ib1eRqSipLqbaPP0n9Qaq/aBnue
	 hSOyTNrifP5Sg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c665d8345dso39962eaf.2;
        Thu, 11 Jul 2024 05:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjYNdpcmCjeZGneQXCLg7eILalKMYQrgqfGMbkXxEpAZQLrfuM6zntpnIu2ohdOspNHQKvbYy0agT/aiO/fAnVbJbMWxHcxyde7radTfmraGVmOE7AHpte0EWm2+08EYfwzx4GBvDgX1VaG1JUuckI97DV8ESRZ91VjsHDuVGyaeRB5AVYS2g=
X-Gm-Message-State: AOJu0YwAYkE3WRQv/joGFxYLZzIE7d2bFSIKUBLqtM/+EfD9uFS/OMFl
	nef8zAKxm98y3naGR+u759PwIlXSgnNnX4vejz1S8RjVh13vh0Q8rLKUe+n0dahkCvcFASdej+I
	6MT3mlTczQhQjVcsE2S9izrBrtIo=
X-Google-Smtp-Source: AGHT+IE72WBMUyKXLLTs7CdwO/6Lus4fMsnzY7te1QDY+vOJ6Yh/DN5wi5n24FdfZ2wpHX2W3vtiewlcaI+C4Mub3ss=
X-Received: by 2002:a05:6820:3d8:b0:5c7:b126:10c0 with SMTP id
 006d021491bc7-5cac9071001mr2181068eaf.1.1720699995945; Thu, 11 Jul 2024
 05:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711121033.3569948-1-shreeya.patel@collabora.com>
In-Reply-To: <20240711121033.3569948-1-shreeya.patel@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Jul 2024 14:13:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gYj5MfwVZihiJEFUWohRmKjudOEExpYgew0Fg4Cu+whA@mail.gmail.com>
Message-ID: <CAJZ5v0gYj5MfwVZihiJEFUWohRmKjudOEExpYgew0Fg4Cu+whA@mail.gmail.com>
Subject: Re: [PATCH] kselftest: cpufreq: Add RTC wakeup alarm
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, shuah@kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:10=E2=80=AFPM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> Add RTC wakeup alarm for devices to resume after specific time interval.
> This improvement in the test will help in enabling this test
> in the CI systems and will eliminate the need of manual intervention
> for resuming back the devices after suspend/hibernation.

Why don't you use rtcwake for this?

> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh | 24 ++++++++++++++++++++++
>  tools/testing/selftests/cpufreq/main.sh    | 13 +++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/s=
elftests/cpufreq/cpufreq.sh
> index a8b1dbc0a3a5..a0f5b944a8fe 100755
> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> @@ -231,6 +231,30 @@ do_suspend()
>
>                 for i in `seq 1 $2`; do
>                         printf "Starting $1\n"
> +
> +                       if [ "$3" =3D "rtc" ]; then
> +                               now=3D$(date +%s)
> +                               wakeup_time=3D$((now + 15)) # Wake up aft=
er 15 seconds
> +
> +                               echo $wakeup_time > /sys/class/rtc/rtc0/w=
akealarm
> +
> +                               if [ $? -ne 0 ]; then
> +                                       printf "Failed to set RTC wake al=
arm\n"
> +                                       return 1
> +                               fi
> +
> +                               # Enable the RTC as a wakeup source
> +                               echo enabled > /sys/class/rtc/rtc0/device=
/power/wakeup
> +
> +                               if [ $? -ne 0 ]; then
> +                                       printf "Failed to set RTC wake al=
arm\n"
> +                                       return 1
> +                               fi
> +
> +                               # Reset the wakeup alarm
> +                               echo 0 > /sys/class/rtc/rtc0/wakealarm
> +                       fi
> +
>                         echo $filename > $SYSFS/power/state
>                         printf "Came out of $1\n"
>
> diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/self=
tests/cpufreq/main.sh
> index a0eb84cf7167..f12ff7416e41 100755
> --- a/tools/testing/selftests/cpufreq/main.sh
> +++ b/tools/testing/selftests/cpufreq/main.sh
> @@ -24,6 +24,8 @@ helpme()
>         [-t <basic: Basic cpufreq testing
>              suspend: suspend/resume,
>              hibernate: hibernate/resume,
> +            suspend_rtc: suspend/resume back using the RTC wakeup alarm,
> +            hibernate_rtc: hibernate/resume back using the RTC wakeup al=
arm,
>              modtest: test driver or governor modules. Only to be used wi=
th -d or -g options,
>              sptest1: Simple governor switch to produce lockdep.
>              sptest2: Concurrent governor switch to produce lockdep.
> @@ -76,7 +78,8 @@ parse_arguments()
>                                 helpme
>                                 ;;
>
> -                       t) # --func_type (Function to perform: basic, sus=
pend, hibernate, modtest, sptest1/2/3/4 (default: basic))
> +                       t) # --func_type (Function to perform: basic, sus=
pend, hibernate,
> +                          # suspend_rtc, hibernate_rtc, modtest, sptest1=
/2/3/4 (default: basic))
>                                 FUNC=3D$OPTARG
>                                 ;;
>
> @@ -121,6 +124,14 @@ do_test()
>                 do_suspend "hibernate" 1
>                 ;;
>
> +               "suspend_rtc")
> +                do_suspend "suspend" 1 rtc
> +                ;;
> +
> +                "hibernate_rtc")
> +                do_suspend "hibernate" 1 rtc
> +                ;;
> +
>                 "modtest")
>                 # Do we have modules in place?
>                 if [ -z $DRIVER_MOD ] && [ -z $GOVERNOR_MOD ]; then
> --
> 2.39.2
>
>

