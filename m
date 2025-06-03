Return-Path: <linux-kselftest+bounces-34243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0DACCE2C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B895E3A420F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDB221D92;
	Tue,  3 Jun 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzIr5FP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0D221703
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982440; cv=none; b=h2wsOKM+E3R3Fd4h7FhZSGlTSNHp5himulIAUBcdXf8uW5gQoIA4/34R+ai3Xj+XPB66j+Q20cmAJ3UTKtBDFutrPIYPlnvh3mTlm87uTGddb1PqOM78KdL7qAtrcQ+AD/foHpjo43SvHCITK6Feu3lQnNPbocO1z51foalssHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982440; c=relaxed/simple;
	bh=FkyXOZFJS2JTs2yvyJibGlBLckskxePeubP27I+ZqKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWvGYd5Qs1tZa5SMueOEYn9okfjJ+CGWWTJPrnzaJqYwfE+3+mlKCuh4VyecOKlRIEo0skTbXek3lwyeLcC0WVQReoYm2GVd93NLhGqdbazVDX6YUJI+jU3lANhSHl7zgnXjSq0/OTKn1yWeVoFvOOTrRZO98T3UlrtGWy1gQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzIr5FP0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5534edc6493so2934293e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748982437; x=1749587237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+IyIfkIPOra+AocHu+9QAm2JwpYmUQiCUktZpdyAo0=;
        b=pzIr5FP0y+LAGAeiFLCW2qeJIr36wbZfSA+M411vWFufTscHXuDgoaNpVoMPmEf98g
         42yY5DDZQh4zPFZ/MP5pVfmb/WSlO4l4QAB1kYKBIBbUrtgsm5q/I0WsmspFiadKscxH
         C0uL6lVYzlUClOBrnuSvARjGSLRVzPUBp+3Dp09XvAtrN/j8+zE5tqGNbvx6pa96g0z/
         YcALG7xmN+ClYNaokmehDCce2qEfD1FsjzBpFlWNmaSp1BFeCuZat1t16idz3NVNVZS5
         /mJZpvlyh1UYWWn/AWpZ0HHlCLo9Y+QFJlSLfHvnFHgUVBH16wSMBxhYxruL2nmDORGK
         oR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982437; x=1749587237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+IyIfkIPOra+AocHu+9QAm2JwpYmUQiCUktZpdyAo0=;
        b=ftbS/qV45NbuLh1NIDHVm3kbMdSRlSlKkvMizPqxzLyYnM5wEyn+FU99fTZOybK3ki
         +0sX8B530+uPQ+Lctcxoa/PRDC2PIqqhJKjBpq/kS2Mf3U1UMabpmqEJ3ujuhASg7cnV
         ac9tzLf9hK6Y1EyXWP/FgW+pPiYaEkgyRt6RO5leG81K9j0eHhWPVuqH1d+aF3YKQRzS
         /xJgtXfRgIAi56iGg9DKBCSe8K4DMfx3Aql3Lgy+mPaCsvwfiNRyp4/j8/Du5ygysBzl
         i4ZwiYSZGJMX2sBvobuSp6E9wyBLi8H65Roig6dx89QyoQ8xXFT0/rHD8UicDGDMl9kn
         E0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUAAEvl3Y604Ox4ikf+e4kQdgyRoz8Td+9ZCbiix28b/vzdL1U0Sp+MAMDKglpXbLrCjdme4JljR+ppho1V1JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PajgL/uzkEKiGbcYc/NKO+Zxi3gk+aXlaImWpGx6capYutCy
	kRB7P5DgNB3R4M0t1O4rHDYF4SvLzzTZE04iUrtKWwcW1Q+m/dY8oJJDqgLDqyGK1hr6tvXDOt9
	4Db5LUkhOf0quCkdyU9qSxE/X/gv2xSXH0Q7Geho=
X-Gm-Gg: ASbGncuE2A5+qQt/IiUMRoRpD/u/mlejO4mFPG+Y+lsQ2RaI35CCBWl1zNqGr4KyXHV
	oSEQJcx/6tFXBG7bG0C5Jq3sEjCppNCKsZoXcaMfI8Reg23viKr0rVGdMEDwhscax4lAhuTKhi9
	VlFEkzTgCh8LS1V+LAKRl2QQcmVtPWPNO0vtr7HFtHGriTFRJJDY0AK2tyJkihA/oUZw0gqnFb
X-Google-Smtp-Source: AGHT+IFh1B+A+fdjQ0CvAxPbjMYP1A9rdTXQW/HM/GhCzzE5FNCpc4tMd+qHVqr75+gws1rXT4Ypm9ihHODwnJj5SLo=
X-Received: by 2002:a05:6512:124b:b0:553:399d:58e6 with SMTP id
 2adb3069b0e04-55356df9977mr125129e87.31.1748982436553; Tue, 03 Jun 2025
 13:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603201036.44504-1-terry.tritton@linaro.org>
In-Reply-To: <20250603201036.44504-1-terry.tritton@linaro.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 3 Jun 2025 13:27:04 -0700
X-Gm-Features: AX0GCFuuX4lVBQbzNpicNH90nbJZyqUiFq9bOfP2TAZziYhan0ThpfFSgl5qplE
Message-ID: <CANDhNCoiKjPOyGwiu5Apg2y4LduPTRQvEjG7snmbzrenZojAKg@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Fix integer overlow errors on 32 bit systems
To: Terry Tritton <terry.tritton@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	ttritton@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 1:10=E2=80=AFPM Terry Tritton <terry.tritton@linaro.=
org> wrote:
>
> The use of NSEC_PER_SEC (1000000000L) as defined in include/vdso/time64.h
> causes several integer overflow warnings and test errors on 32 bit
> architectures.
>
> Use a long long instead of long to prevent integer overflow when
> converting seconds to nanoseconds.
>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>

Needs a Fixes: tag?

> ---
>  tools/testing/selftests/timers/adjtick.c             | 5 ++++-
>  tools/testing/selftests/timers/alarmtimer-suspend.c  | 4 +++-
>  tools/testing/selftests/timers/inconsistency-check.c | 4 +++-
>  tools/testing/selftests/timers/leap-a-day.c          | 4 +++-
>  tools/testing/selftests/timers/mqueue-lat.c          | 3 ++-
>  tools/testing/selftests/timers/nanosleep.c           | 4 +++-
>  tools/testing/selftests/timers/nsleep-lat.c          | 4 +++-
>  tools/testing/selftests/timers/posix_timers.c        | 5 ++++-
>  tools/testing/selftests/timers/raw_skew.c            | 4 +++-
>  tools/testing/selftests/timers/set-2038.c            | 4 +++-
>  tools/testing/selftests/timers/set-timer-lat.c       | 4 +++-
>  tools/testing/selftests/timers/valid-adjtimex.c      | 5 ++++-
>  12 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/sel=
ftests/timers/adjtick.c
> index 777d9494b683..b5929c33b632 100644
> --- a/tools/testing/selftests/timers/adjtick.c
> +++ b/tools/testing/selftests/timers/adjtick.c
> @@ -22,10 +22,13 @@
>  #include <sys/time.h>
>  #include <sys/timex.h>
>  #include <time.h>
> -#include <include/vdso/time64.h>
>
>  #include "../kselftest.h"
>
> +/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architec=
tures*/
> +#define NSEC_PER_SEC   1000000000LL
> +#define USEC_PER_SEC   1000000LL
> +
>  #define MILLION                        1000000
>
>  long systick;
> diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/=
testing/selftests/timers/alarmtimer-suspend.c
> index a9ef76ea6051..b5799df271ae 100644
> --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> @@ -28,10 +28,12 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <pthread.h>
> -#include <include/vdso/time64.h>
>  #include <errno.h>
>  #include "../kselftest.h"
>
> +/* define NSEC_PER_SEC as long long to avoid overflow on 32 bit architec=
tures*/
> +#define NSEC_PER_SEC   1000000000LL
> +
>  #define UNREASONABLE_LAT (NSEC_PER_SEC * 5) /* hopefully we resume in 5 =
secs */

So this seems to be undoing commit 80fa614e2fbc ("selftests: timers:
Remove local NSEC_PER_SEC and USEC_PER_SEC defines")

Would it make more sense to fix the NSEC_PER_SEC definition in time64.h to =
a LL?

thanks
-john

