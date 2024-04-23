Return-Path: <linux-kselftest+bounces-8733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2F8AF8F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749A1B2770C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D1143882;
	Tue, 23 Apr 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUw4umd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EB26288
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908118; cv=none; b=J8qbCdzJZuapizlS6PYF6bIgZTSY2lXpx/unpE1EP4c5mdyvBg5lXg1f5cDNY+J0Dd1L9OSklo+9tAYTWgykgiJLLYhAwgwcvQw7e/grOP9eetPt9BRvOW9mcnc8nAjzQ6RsTPvNaP3l49RoNiPig1HfZCvnNtXoF/rwE65FDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908118; c=relaxed/simple;
	bh=5d6+zFSYJmyy3AfzAE2VOGKQ9Gjz+CHRK8T81rYhQAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwqv235HhI/2RLJuBcW4tpv4D7S6Ub8rWzy9k2FVqYnYYPNZYfcTFw0QA/P7+m/3LoIJROmLblAbUR53BDNrEkJG3xTCvNOtrB/8t9e6vAgcEuIkKK5WpNJ4mYWDFBGt+rS0yyGM/k+btp2CEvc1tIszzmKGwMdWGnaAJtfcB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUw4umd8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-436ed871225so40851cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713908115; x=1714512915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKGAmiBY8brLZk2gwaInIBRHzAk4kWqV70ABWJedJWY=;
        b=JUw4umd811VO1l7lKdoP63oKnCwdguD0X98vc+ecL+s0x8JGX9dwXpwu2FoauPmAiA
         gUMpWM0HcPlt3lDocAR9LjPF21nYZSb/K1BY2xoLTuL9HHXwqdBh/G+73J1g10MC14wD
         HmIpkN40Zdb6k209OZZ1yrRWJm46Z6SLZUr1WgwUSYY4TkSM8w2oaEzYEZ/jWSsE2ne2
         sJ0p2NFSklRQS1QxA2aF3ycF1sVjGyHrVYLF6Pa0oF08z+Fb5rKVdDMRaYnQK1yrhk0b
         XhnHvNZJu5+qV2N8DCoCPgM0UPOtPrfQ2+t1VFMMBaCIB63xU+Pf7s17WGjfvXmXRFLl
         4lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713908115; x=1714512915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKGAmiBY8brLZk2gwaInIBRHzAk4kWqV70ABWJedJWY=;
        b=uG0q05Sl2zgL3d0gzqc/pgdGeiKr5PYXJA7PYeBPMIqa/kQGvqym/t6bxN/iNIazsq
         vgp+/Pq/9HXRHtJ8askisF4g0tp9U86fyWEGCQCX4tE1EefljNrKUvPppkAZwNznnQl3
         eJdTsfV9O08P9AK1KN9Vg1fVqaemwFL9AplxSibfpSu2shApxxa+7gXxlY1RPbsVPxJB
         LlUUCuhAFMYRvz15HIB5wFnHC751Eac1q8W9W9anobeOW3yI1HdzY98IqPUDc3QDQxeu
         DCFm9h2gSvwwPXH+STBtfThU3Xzt+jNGaUkbWftY//Sf4SG/h5DHjvi7u+lxBA2iMp4x
         pmdw==
X-Forwarded-Encrypted: i=1; AJvYcCVGyEjnmrJ4OkwObzMKp8EvVqK0KDf96+uYpSkHfmxJRPfWkFEEVlAYc7dt15seuS2tSiPyNL/6pO2DUl5Yk0UFV9Wcqz9jUD1NzW/iWvHU
X-Gm-Message-State: AOJu0YzpY3jVhUcxIo3w4CA+oj+rloPL7zQFVYr+JLcV0QA08+jo5JYJ
	3qm0h3ap/5oVzMa+IpAw1P1XY0PsgGNZuEo9VreOP/Ii1UjIn1nSRju9grBYa36Oaw2tOFVFV5q
	WW5CeOH5GomEjh8gIARPAaJ3041F30XFR2X3ImCeJH4m6CEzrIw==
X-Google-Smtp-Source: AGHT+IEN/0C2sAZReHz8xqnlV3IYP+2lc0ishc8pG0y2szANbMQrigdNg6/nr4ZMmbBb2XxBZCYmy1wafPF+jzDsEe8=
X-Received: by 2002:ac8:45c8:0:b0:439:8cec:2f74 with SMTP id
 e8-20020ac845c8000000b004398cec2f74mr23573qto.9.1713908115562; Tue, 23 Apr
 2024 14:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182701.38359-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240423182701.38359-1-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 23 Apr 2024 17:35:02 -0400
Message-ID: <CA+GJov7BUm4BnWh9m6+hCQRBQ2OW=UwoB9z3dMcFWKRqz44O=g@mail.gmail.com>
Subject: Re: [PATCH] kunit: string-stream-test: use KUNIT_DEFINE_ACTION_WRAPPER
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:27=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Use KUNIT_DEFINE_ACTION_WRAPPER macro to define the 'kfree' and
> 'string_stream_destroy' wrappers for kunit_add_action.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This looks like a good use of the macro. Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream-test.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 03fb511826f7..7511442ea98f 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -22,18 +22,10 @@ struct string_stream_test_priv {
>  };
>
>  /* Avoids a cast warning if kfree() is passed direct to kunit_add_action=
(). */
> -static void kfree_wrapper(void *p)
> -{
> -       kfree(p);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>
>  /* Avoids a cast warning if string_stream_destroy() is passed direct to =
kunit_add_action(). */
> -static void cleanup_raw_stream(void *p)
> -{
> -       struct string_stream *stream =3D p;
> -
> -       string_stream_destroy(stream);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(cleanup_raw_stream, string_stream_destroy, s=
truct string_stream *);
>
>  static char *get_concatenated_string(struct kunit *test, struct string_s=
tream *stream)
>  {
> --
> 2.34.1
>

