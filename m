Return-Path: <linux-kselftest+bounces-12478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B8912F15
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A82B21381
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA617BB3A;
	Fri, 21 Jun 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGU4GPzD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696B374C3
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003673; cv=none; b=VEvvCIY/3JvFkiaOhBOMLpUq313hwoDYkMsQxx6xrDakHqsQohMuEtVCWcQbLtxXI+4E9o2iyCc7PSowvPIgTR7XWNs3DK0wIv47GIGQLB8HDdfVWcvuKzskDSX2/9Er7RRTz9nzsoqM22PlUtqItF/YhILnaQHUMDiJ3XCnxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003673; c=relaxed/simple;
	bh=3Ic2VcMfH2poMKiLf1iC0g87Ok1vLwZFmpogt9YLytM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl4U9XOjOj7YXDzyFDLmhbjzOoFF4bJ0ZF5SUlfVIBG7Q8DYyRrEjy/uDm61zBELw6IMnvVC+iwSlBPtKnUOQqCWegDZp1HyWD6aSd1KQ14lmG9gJWrlBf3ZYcnrDPzffirSScEZnR6Hy1Wc8jOiYDqwKv0uS7eUefV3SLGdHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGU4GPzD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4405dffca81so294961cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719003671; x=1719608471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyoXzeg22LUPfKFKI52ob9FVeWsXGniC4Ii60C/Ql+A=;
        b=gGU4GPzDzaSmJgfVbIS8Vh1wvtGhON3WrUvekIfy1DkOLWgLuZEh4SYQp0wOOQhAlJ
         JHX+dPGcQFc07Y7kqovINiRpQPm8DmJu1OD8kLh7Q3jQKftHCJMlpZfkCqP8wMhPUGOT
         OuSpWiwDXGgAz6n/pBeZcJjTDvvXWkyIo/4Sq91eWVLTii/bUk+5cN+0rb5H08mKofak
         ldZuFZy3jMhXO5wHCNI82DOYswWIkJ9VbgcGe7DHXvsZJhOiclRF8epN/LqyL+HkzO5N
         PKe7pKXMzl7dPX4s27lyqXngZE6YyoB/XwlXm7emivNohoGNevM/HTiNptNO1WRU0x9o
         ytLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003671; x=1719608471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyoXzeg22LUPfKFKI52ob9FVeWsXGniC4Ii60C/Ql+A=;
        b=L48D1OS6UKw19+/FflSExJ6ZCQ2E1WCQwqYvX6jBi8cGM59rX1oyWkzJr/gWXCRwWm
         +gd6krsfgMoTmA7ctEURUaGUnBJHTY3p4N9XaIrDAftXG0EAj59ToZanQ7MDQeoHrpsQ
         5zFWdrvJfJhGLw8lJhBRQNkLvLAq2WA5pN9wKOFuKBwWBsyDiw1pNpXVwv9eHP10NuGQ
         jrDt9FcVVrYf5CvY1skCoju68sv71/PBGxk1sMqRKj3CoCDZUx2+WM8jpiLvUBrvraV/
         IrGCbAGXUChSjpAWiSqzbO5MmSZBRbW+4Wysw1bFrfeqv2OL7/abU6Vb5mNGDtDmwKtK
         1qiA==
X-Forwarded-Encrypted: i=1; AJvYcCVgwsYfwOulHAWt0a12ozVC4BnMPzFVm9TPzDDbI6sNYCyIQck4N6+69OVUKpxLlCGNnlrNAIASOpDGECzYtgRRLchA+XNyk+fcaay57U84
X-Gm-Message-State: AOJu0Yz28Qj8Ks4PFQGo2dz4npWwx87e/14SBGbcMK8CSyEC7aibAyx/
	PFz4rdlt4FCPhtnbODBekWIk6+JGLMiE4yuZPx0kCF+8q2Xcnc/ht3cnCnn0Ljx1nCBePKFASWD
	xGh+2GRI8GilEli3/wI2tzK7FTQ4/Y2xtHxmi
X-Google-Smtp-Source: AGHT+IG9vCelY04z/7YOAcD+feshnsJlmDSV3XveEGXfR/DAO0cIK5AOqJ2g6nJKbGhcHX/TKE7msH0lgw7s44eOFG4=
X-Received: by 2002:a05:622a:83:b0:441:54bb:50eb with SMTP id
 d75a77b69052e-444ce39fd5dmr363221cf.28.1719003671213; Fri, 21 Jun 2024
 14:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-2-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-2-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:00:59 -0400
Message-ID: <CA+GJov6h2KJ6AWD98xxLK-nrAxgUXOjW2hRk7kSC6aiPfNwW_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] kunit: string-stream: export non-static functions
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Export non-static functions from the string-stream.c file into the KUnit
> namespace in order to be able to access them from the KUnit core tests
> (when they are loaded as modules).
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> V1 -> V2:
> - No changes
>
>  lib/kunit/string-stream.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 54f4fdcbfac8..a5e3339854da 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -10,7 +10,7 @@
>  #include <kunit/test.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> -
> +#include <kunit/visibility.h>
>  #include "string-stream.h"
>
>
> @@ -86,6 +86,7 @@ int string_stream_vadd(struct string_stream *stream,
>
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_vadd);
>
>  int string_stream_add(struct string_stream *stream, const char *fmt, ...=
)
>  {
> @@ -98,6 +99,7 @@ int string_stream_add(struct string_stream *stream, con=
st char *fmt, ...)
>
>         return result;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_add);
>
>  void string_stream_clear(struct string_stream *stream)
>  {
> @@ -113,6 +115,7 @@ void string_stream_clear(struct string_stream *stream=
)
>         stream->length =3D 0;
>         spin_unlock(&stream->lock);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_clear);
>
>  char *string_stream_get_string(struct string_stream *stream)
>  {
> @@ -131,6 +134,7 @@ char *string_stream_get_string(struct string_stream *=
stream)
>
>         return buf;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_get_string);
>
>  int string_stream_append(struct string_stream *stream,
>                          struct string_stream *other)
> @@ -148,11 +152,13 @@ int string_stream_append(struct string_stream *stre=
am,
>
>         return ret;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_append);
>
>  bool string_stream_is_empty(struct string_stream *stream)
>  {
>         return list_empty(&stream->fragments);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_is_empty);
>
>  struct string_stream *alloc_string_stream(gfp_t gfp)
>  {
> @@ -168,6 +174,7 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
>
>         return stream;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(alloc_string_stream);
>
>  void string_stream_destroy(struct string_stream *stream)
>  {
> @@ -179,6 +186,7 @@ void string_stream_destroy(struct string_stream *stre=
am)
>         string_stream_clear(stream);
>         kfree(stream);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(string_stream_destroy);
>
>  static void resource_free_string_stream(void *p)
>  {
> @@ -200,8 +208,10 @@ struct string_stream *kunit_alloc_string_stream(stru=
ct kunit *test, gfp_t gfp)
>
>         return stream;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_alloc_string_stream);
>
>  void kunit_free_string_stream(struct kunit *test, struct string_stream *=
stream)
>  {
>         kunit_release_action(test, resource_free_string_stream, (void *)s=
tream);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(kunit_free_string_stream);
> --
> 2.34.1
>

