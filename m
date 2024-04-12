Return-Path: <linux-kselftest+bounces-7815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22F8A333D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A60B24A60
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBC143899;
	Fri, 12 Apr 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwH7YFM3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59C149DFC
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938122; cv=none; b=B8XkdEo98SvXCHEWWYkk6qTGBE22DIoT/gLoLzkKLeI5oWFyq3Pv1/MCaZc80LlPWujS3/bjYFCiDXMyMDrV8ghCcmSH0Cu9+x/i4Izai1nOAFDoNrSx8x7u8YRoDHFYebaHlrK4ZsSdBkgHKe3ct/NINf6O8UQqzmQ8iMwMI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938122; c=relaxed/simple;
	bh=aZ/P73mUhmx64gcqfpqiqbfDua3KGlA/ZWvGXvrP2Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqhfieFyFuGYFYdmriKTzDif14Ul5HC/f+SZg8V1rSNr01uVk1ls2t4pMMeurozroZ6ayhb4CNFpEaWbc36KSH+osuWNhvU2CC17csX5sLUF3oGjD1jf4bElVuI5fJgqog/QvGSpDsuvFNrzr3M7U0lEasiC7dgxf17CmZrQ88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwH7YFM3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41641a889ccso77545e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712938119; x=1713542919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNYirPwNVr+GTWxU7VfrVwFiMeqJyrofCKy1YE+ANNY=;
        b=BwH7YFM3WdEzqcdTswddgNrUGa/I8LkJkS669RkIesDmZZvf9TuFAjHVBzwLOJnRp6
         WfviyB+zdIHcntr3bk33JWtCAOBtwo0q7pLmd6dIbHJjgbKv7Aj82DQxHW6xT0kn8wKh
         9wJTnClSS8Fu4AEcQ9abwanWeWouHlW/pCYpkmq5z5KJ5Qw5Bjc3rFFNJYwP0NRwdSSF
         rIPKrrqrpzcrWW/0lLIAZExUYGc0ekZwh0dXK1+LJfsT+SK4lICUimIWecQmlWBYlaCj
         WNLebngb/k/+WlefH+5appyX0GwK2afZzN8Pbt3zHCZsu2mo3jHfyp0B01IutsPRo10r
         kHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938119; x=1713542919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNYirPwNVr+GTWxU7VfrVwFiMeqJyrofCKy1YE+ANNY=;
        b=hJTxsU2SNmupKduBtUwzSFXZVPe1u3XzzQaE0LqDdn7beaLADg/BKpwpmiZS0ekuUv
         bI0XxmCEb1xzDuz995HNuHLl/G2Fss39Mgz0Qamh436Pa5kY3KJIGWhZg0pIQj1C+P1E
         ml/F5zzcsl2FUWfIC4MdVJ7Kg2ANB12B5J+Xf3+dKJrVXzvkK0oIfJ3chM9tqBQZuFeI
         8fpXnIDOB/8T89jIs9mkDfLeMXN5SlfQSDahOGRFRumnxbkiIMTBp8eubLifJGz0m962
         RT8/xNK7ShbrEzSigUPddaKTcYSOC33dDX2K8QTJ5RI2f/cu3iaSicOulw3y1Rz/nuLv
         6AzA==
X-Forwarded-Encrypted: i=1; AJvYcCWlCkDpJ3lxZ3aAPeJYbiHHJrZn9bSWJGS+y/nDq8AvcSf4MdSKhCj78+yN2VgaeDKCknnGDN3JRdRinUoam2W/ceqnHCcHghrs0wIG/pu4
X-Gm-Message-State: AOJu0YxesXKwHeibNevCa45cbbvjX3s2sP3FeukK1iie7uAljVNoM2QM
	YBT8J4Ceo8X7GiaEbUvWZrlHNgsJGUQEGivzc0IV5zpru0nCrBHbbzmIMz7Bp7yDkKWCkl/SZCp
	WeDa7yTidAHVyDFFXytE8fmU6SSkw3eqvBPI=
X-Google-Smtp-Source: AGHT+IFVDRZZizAvAAJdzt4RivJzgfJ0OODeVjij/yWDYakPFhhDIwnAAwlI5ZQ7ZkMZMDlD2eoOIKw5yvDXbHLUd5c=
X-Received: by 2002:a05:600c:19c9:b0:416:3014:63f8 with SMTP id
 u9-20020a05600c19c900b00416301463f8mr222985wmq.0.1712938118606; Fri, 12 Apr
 2024 09:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
In-Reply-To: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Fri, 12 Apr 2024 09:08:20 -0700
Message-ID: <CAGG=3QUNPGtQ7OqzEtNW9BQET+a+1WW=h++CqRTHRY=YLrOAcw@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Mark functions that unconditionally call
 exit() as __noreturn
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@linutronix.de, shuah@kernel.org, oleg@redhat.com, 
	anna-maria@linutronix.de, frederic@kernel.org, ndesaulniers@google.com, 
	justinstitt@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:45=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
> check_timer_distribution()"), clang warns:
>
>   tools/testing/selftests/timers/../kselftest.h:398:6: warning: variable =
'major' is used uninitialized whenever '||' condition is true [-Wsometimes-=
uninitialized]
>     398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &maj=
or, &minor) !=3D 2)
>         |             ^~~~~~~~~~~~
>   tools/testing/selftests/timers/../kselftest.h:401:9: note: uninitialize=
d use occurs here
>     401 |         return major > min_major || (major =3D=3D min_major && =
minor >=3D min_minor);
>         |                ^~~~~
>   tools/testing/selftests/timers/../kselftest.h:398:6: note: remove the '=
||' if its condition is always false
>     398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &maj=
or, &minor) !=3D 2)
>         |             ^~~~~~~~~~~~~~~
>   tools/testing/selftests/timers/../kselftest.h:395:20: note: initialize =
the variable 'major' to silence this warning
>     395 |         unsigned int major, minor;
>         |                           ^
>         |                            =3D 0
>
> This is a false positive because if uname() fails, ksft_exit_fail_msg()
> will be called, which unconditionally calls exit(), a noreturn function.
> However, clang does not know that ksft_exit_fail_msg() will call exit()
> at the point in the pipeline that the warning is emitted because
> inlining has not occurred, so it assumes control flow will resume
> normally after ksft_exit_fail_msg() is called.
>
> Make it clear to clang that all of the functions that call exit()
> unconditionally in kselftest.h are noreturn transitively by marking them
> explicitly with '__attribute__((__noreturn__))', which clears up the
> warning above and any future warnings that may appear for the same
> reason.
>
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_ti=
mer_distribution()")
> Reported-by: John Stultz <jstultz@google.com>
> Closes: https://lore.kernel.org/all/20240410232637.4135564-2-jstultz@goog=
le.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I have based this change on timers/urgent, as the commit that introduces
> this particular warning is there and it is marked for stable, even
> though this appears to be a generic kselftest issue. I think it makes
> the most sense for this change to go via timers/urgent with Shuah's ack.
> While __noreturn with a return type other than 'void' does not make much
> sense semantically, there are many places that these functions are used
> as the return value for other functions such as main(), so I did not
> change the return type of these functions from 'int' to 'void' to
> minimize the necessary changes for a backport (it is an existing issue
> anyways).
>
> I see there is another instance of this problem that will need to be
> addressed in -next, introduced by commit f07041728422 ("selftests: add
> ksft_exit_fail_perror()").
> ---
>  tools/testing/selftests/kselftest.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index 973b18e156b2..0591974b57e0 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -80,6 +80,9 @@
>  #define KSFT_XPASS 3
>  #define KSFT_SKIP  4
>
> +#ifndef __noreturn
> +#define __noreturn       __attribute__((__noreturn__))
> +#endif
>  #define __printf(a, b)   __attribute__((format(printf, a, b)))
>
>  /* counters */
> @@ -300,13 +303,13 @@ void ksft_test_result_code(int exit_code, const cha=
r *test_name,
>         va_end(args);
>  }
>
> -static inline int ksft_exit_pass(void)
> +static inline __noreturn int ksft_exit_pass(void)

Orthogonal to this fix, but why does a "no return" function have a
non-void return type?

>  {
>         ksft_print_cnts();
>         exit(KSFT_PASS);
>  }
>
> -static inline int ksft_exit_fail(void)
> +static inline __noreturn int ksft_exit_fail(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_FAIL);
> @@ -333,7 +336,7 @@ static inline int ksft_exit_fail(void)
>                   ksft_cnt.ksft_xfail + \
>                   ksft_cnt.ksft_xskip)
>
> -static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...=
)
> +static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const cha=
r *msg, ...)
>  {
>         int saved_errno =3D errno;
>         va_list args;
> @@ -348,19 +351,19 @@ static inline __printf(1, 2) int ksft_exit_fail_msg=
(const char *msg, ...)
>         exit(KSFT_FAIL);
>  }
>
> -static inline int ksft_exit_xfail(void)
> +static inline __noreturn int ksft_exit_xfail(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_XFAIL);
>  }
>
> -static inline int ksft_exit_xpass(void)
> +static inline __noreturn int ksft_exit_xpass(void)
>  {
>         ksft_print_cnts();
>         exit(KSFT_XPASS);
>  }
>
> -static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
> +static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *m=
sg, ...)
>  {
>         int saved_errno =3D errno;
>         va_list args;
>
> ---
> base-commit: 076361362122a6d8a4c45f172ced5576b2d4a50d
> change-id: 20240411-mark-kselftest-exit-funcs-noreturn-17d8ff729a7a
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
>

