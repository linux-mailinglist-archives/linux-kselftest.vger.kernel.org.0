Return-Path: <linux-kselftest+bounces-9100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE48B6723
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DF6B215C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391C205E21;
	Tue, 30 Apr 2024 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIGb2SwZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154E1870
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439144; cv=none; b=tYkus2Gr38mXAZi9ABgm8ZoJAHUfez1YnZ7zyn40ILM8Nhtk6xvRuwKMIS/RxpdwvfqX3EGdrtX9enk7dEQUwiGEdgxlV0uQUTS5TocrFnccR85hdt+lutFL3ZtNAaGlzpFJ/T8tFdj0tHIKrWqwRMo3qK4kPdLb/1mUKTCm7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439144; c=relaxed/simple;
	bh=TK5MtPXbmMywsCNK4eaJvcbQwX7I5488OjtThsv2tq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIFqRDtIhAsuGgTNcygRkmcmUTImLitVg1E71lO/+lnw4L2AidydsFCtiWNys4tvpBoRqCrBvnmM92YWnDHGuZ8SH96enI/VWvj5O3DL+9awxwq/3au2I5UrqoIWDoOSf1ldDaaNJNHBGpTz7RGbbACF1gFl/Ato3vaZHNjaOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIGb2SwZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so5354a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439141; x=1715043941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaputj2Z1W/10vL4BFBUxMxYDeoWPqOOi+AGsgxCP8A=;
        b=rIGb2SwZdN7Z6v8EfXQefKicqrqWr0TUXLHLLSTZpEhWV9O6YvdhwTzB+o5ckJGxG2
         ZGcFMJPQSrf5FtzNqpYvehIwI0R/qMWXBhDmy3ZDGA+m4DKZZfv5mA2WvxZPLGhJCMmI
         kOdJ3mcDr+pcdZoHMuui6Wb8wyBR34L7KhoGUh6NugWgBvyWtV+k6fugQQmsd+cg5Aaa
         VxTnBL6EJAUaxOdnCfYmXREGg5Nk3NaQyHdMOiz3EROLmtFUyghCCpQGphY3YZNbohEo
         095ofikSZLAk2lniyAPdEBl20ExNLq4izGuqMWFuiJWmndnHfPG5W9K4tdvwU+pVE17E
         WawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439141; x=1715043941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaputj2Z1W/10vL4BFBUxMxYDeoWPqOOi+AGsgxCP8A=;
        b=qqOVqKru0kJLYNXLWsTr9KJQdD+kkuR3jKcfRIa4aoGz1+9zYER3liCEeaQ0KUf5k6
         mYhUMztggZFfF0vcfOKiuQVDT0xLIZUcockQ+U8RzQ/M4smJ5Nmsk39GuJTLleFbrmZU
         UONn8cBUkl/+V6cH0t/2E4+UOzO2aJFwSNie+UWSHCGWMnPbtDUeoyfzxvFY/Iq+q0eQ
         fZKUcf6fE8l1oXvD5CFku+0mlOZcsCEWf493Yg95L+G+8Z+aJubuuVqilui3DMTUc9WH
         ARjXDfmWI0TPuAMlxCYxW75lmOf07lHXpx8SPllPwiRtnR1+CH5r8JBJxUjGzaUx1/tH
         tqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiSbD53xhmmuX+4NebPSQ9eTtEog38D2M7MQtaMfAW9/1fkTZ/57QCRwuhK1uBIuaRNdSt9/db4dfP5YKyL25KEjGZgt7oCrntNF0x5GGd
X-Gm-Message-State: AOJu0Ywiup8twYFaScE0mOq3LaNBeWgYjjyVnd6dbmuMikbFEIA/fhS7
	ViQmafWUngzyI+qPOjkKmDLnZMVRsVMaXLD2Hek/BmFVzEkr5OktNRuPH8upwqywsS9o8WeGFwb
	1E5bg+wUSKyJqG7D5XhflFwcUBiTlxJT6H/C9
X-Google-Smtp-Source: AGHT+IG7LNX5veX8mreZLpnWG+Z3Cfj8RR3WtQABkQDJ65b4W0+sr62DOWgadzsbFuhb69tkll6WhyZyUSWm9YxG7Ew=
X-Received: by 2002:a05:6402:70b:b0:572:4e7c:90d9 with SMTP id
 w11-20020a056402070b00b005724e7c90d9mr44036edx.5.1714439140728; Mon, 29 Apr
 2024 18:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430004909.425336-1-edliaw@google.com>
In-Reply-To: <20240430004909.425336-1-edliaw@google.com>
From: Edward Liaw <edliaw@google.com>
Date: Mon, 29 Apr 2024 18:05:14 -0700
Message-ID: <CAG4es9VDsiWdhAHuBkS-+GkQeW+m5DeJC0mdDLEmOh1PDfQBdw@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Add a ksft_perror() helper
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, will resend this; I forgot to prefix that it was intended for
the 6.6.y branch.

On Mon, Apr 29, 2024 at 5:49=E2=80=AFPM Edward Liaw <edliaw@google.com> wro=
te:
>
> From: Mark Brown <broonie@kernel.org>
>
> [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
>
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KT=
AP
> compatible format.
>
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're usi=
ng
> that only print the errno.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers tes=
t to generate KTAP output")
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index e8eecbc83a60..ad7b97e16f37 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -48,6 +48,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <string.h>
>  #include <stdio.h>
>  #include <sys/utsname.h>
>  #endif
> @@ -156,6 +157,19 @@ static inline void ksft_print_msg(const char *msg, .=
..)
>         va_end(args);
>  }
>
> +static inline void ksft_perror(const char *msg)
> +{
> +#ifndef NOLIBC
> +       ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> +#else
> +       /*
> +        * nolibc doesn't provide strerror() and it seems
> +        * inappropriate to add one, just print the errno.
> +        */
> +       ksft_print_msg("%s: %d)\n", msg, errno);
> +#endif
> +}
> +
>  static inline void ksft_test_result_pass(const char *msg, ...)
>  {
>         int saved_errno =3D errno;
> --
> 2.44.0.769.g3c40516874-goog
>

