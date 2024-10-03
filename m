Return-Path: <linux-kselftest+bounces-18955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BCD98E9E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573181C21E14
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5981AB6;
	Thu,  3 Oct 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiNOX+Kd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2F80027
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938468; cv=none; b=I1V4KqA20r0qL6qWmW9jJ7wNsmVSYfvHR6G8qBwgYtRXMjNNbYy/NxzXN6Srk2I8vTj7Vr8RBgqpNyRT13y+djb7xgTNj5C1qZIEIAMNgjy/z24PgkCLOIiGz4v4QY/nvLRdiK1ssyjeRqGmPXG/DgyTiqPDMWAB9vVOGfmOgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938468; c=relaxed/simple;
	bh=3vB34HIu2qEBdg2AwhJ8Jzm4AV8fAtkZTWTDexEw+xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjPptUoMdkmhdzGMkv9kFXv2B1QG/wKsW1mnB2xSlr+cyMsy5FcQVD4F3mgFZ5aXibyVSOtZg0mgbk1HaYZabvVK2m9ixwhxKR1UAxqU0gUIhXeqZUz6uYqKASkRkLvuA9Q7jJ1lANQryGkPQ8qvXr0gL5k5kvby98jRj98d758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiNOX+Kd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4583209a17dso5393431cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938466; x=1728543266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge4dpVL76Zh+7rjxbRWs/IjfXPZtOX6i1AIvG9oxRhg=;
        b=DiNOX+KdIXA1y8d+X+12Y5ouH4cJMsapqUomilMH8//bMjYwhFX0GGGQYJ/6Qkg+9N
         hq57rrPobVAJeBWCeVCgQIHjBln+uIyxAQQ6qb65Qfwx96biAxsCQxrSs44D84FWCB+V
         dj/EAq8H/EGIwnjRcHjudXm8muIRlKy0ceZndnrak/cjO9c243k4bz6SeIfiH0M6ZwCc
         4Xn0X7/TkhQBpKPi8FRZaXn6EbzzA+I7qakoI+oCV8rprZJavr0GnvPq2VT/4zhQgGlC
         jBNFGLEgKl/8+7z2CSZ0Nlpyg3OIZLEUDLiJ3XadkhbK5OAgsQgsdkG84zVrhx252bwy
         RdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938466; x=1728543266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge4dpVL76Zh+7rjxbRWs/IjfXPZtOX6i1AIvG9oxRhg=;
        b=LF5W1ANhDURAQTBBFokeCiVI/HoE59Z/AtNM84i6Y5pQwHDHw661hk7qkQXtTKwDuu
         pAqLngAlkQ+NhPACA829Ju+H0mNT0SSMt8bOmBynn8pWeEYXQWk1jDh5+d0P7OnOyGuE
         Oc0yhOVuyS7t5uoBdClNtZ3E+L3YnBOKJk50wVtUMKrlic/yrV9+a9EpYVWbr/nf6vMS
         9Y/9pXsQsfWpXjiCQC0C91eOro3uUjiEoRoLFgchti38kuBEDidLRY2KeZ0l7GRxWAeu
         4LdNox68Jac7zJfcv7YHpAhUzkJtZXs9NYkrakk1Lv3DkkkvJ6e4O02OHM+9SvQsPttf
         JETQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBvvteikuMGZ4LcSO68zKKB20u/5syU3m2Ng/vMBFnnWOOnfmnUnF/dLyhwk+pdUz1HUirdLF9KSpHoXhxfMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcFFTbRP2v8d2Xajf5auskI3FOvqmzPe8vEvanXfYbJdRvDeP
	dQjXstqmNmCwCW7R2MK6yT8MBmTcYE7LAR2D8KpqZzimDqKyNUBmH5m3rpg+FbsJbEdnOSNCjJU
	Nb9+Pf6w/H22LEGDJwhPAaCJWSENAFMyJOZdy
X-Google-Smtp-Source: AGHT+IEXQZdXgoooD1JSj8Wurktpq6GWBKTTeDL8JlTr1GcUqf/gGnqwOpsESQLJXOrw7nBmIdP/vBbYpb8CpWGc2Lo=
X-Received: by 2002:a05:6214:3211:b0:6cb:9200:944d with SMTP id
 6a1803df08f44-6cb920095dfmr21385426d6.7.1727938465735; Wed, 02 Oct 2024
 23:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928235825.96961-1-porlando@lkcamp.dev> <20240928235825.96961-3-porlando@lkcamp.dev>
In-Reply-To: <20240928235825.96961-3-porlando@lkcamp.dev>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:54:14 +0800
Message-ID: <CABVgOSk3BDO90wzG2192kagKEH5c4+hGqZPK7izfVsL+U08JmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, Danilo Pereira <dpereira@lkcamp.dev>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 08:00, Pedro Orlando <porlando@lkcamp.dev> wrote:
>
> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
>
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---

This looks good to me. The only thing I'm not 100% sure about is
whether or not we want to move the .kunitconfig file into the tests/
directory. I'm leaning towards "yes", but we may want to update
kunit.py at some point to support automatically adding tests/ to the
search path for a .kunitconfig if this becomes a common enough
pattern.

Regardless, let's take this as-is.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  fs/unicode/Makefile                                | 2 +-
>  fs/unicode/{ => tests}/.kunitconfig                | 0
>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 37bbcbc628a1..d95be7fb9f6b 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>  obj-y                  += unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)  += utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
>
>  unicode-y := utf8-norm.o utf8-core.o
>
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
> similarity index 100%
> rename from fs/unicode/.kunitconfig
> rename to fs/unicode/tests/.kunitconfig
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
> similarity index 100%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/tests/utf8_kunit.c
> --
> 2.34.1
>

