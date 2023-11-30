Return-Path: <linux-kselftest+bounces-910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149147FFD1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19051F20F77
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ADB47785;
	Thu, 30 Nov 2023 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSwEsTQn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2401171E
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:51:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso1675e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701377508; x=1701982308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0w0LWsaVhx7toijCRasOWOsbuYywvP2QO/AJh+x5nA=;
        b=bSwEsTQnp+crTLTYct7mku2qJuzj8DUAMNj6KRQfs2JpPRtbh4c1kwhok0CW257zo3
         eL4lIO2XcRVBqZl2eYYbFoKMP8DglA/2FAP/o2pNpUocE8oR9OEz1c8/hrwARmVCqV7T
         H2QEKGd0mOI39A9DtYVAUj1TMY55o+rqyOb7KkIIBhTxYYCGT86AbZ6XEafP4gnrATdK
         Qw2C6glat3peIhbLicbfNvWJzz6d6V3Ztl6RF+ohxSEFeAfeCbaL3z195HJG+EhSHz4N
         XATr59VwSpe/DZTnPDRRSwEdlHakXs42TJK7giDX57erDHdKv6GxgdP7DeYI+Vw2jfCU
         g0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377508; x=1701982308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0w0LWsaVhx7toijCRasOWOsbuYywvP2QO/AJh+x5nA=;
        b=d/RFLLq6Kmar96DJscrR8UwbpWk3DfG0kIOdhpOnr1ZwoHWpeFthBEzsZn67xSpzIh
         MW5+YndIgyWCxGFjhIfVUl9m/mSgtOHgDFJTsJXUFLEnlQQgPOLKs7IDy/ODJyvIMU89
         aOgm8fOKB1roj7wQD66GETzs/QiKqVYGy/tBSYqoo4VHEWO78m+L8PrVIIAq1FkR6XdF
         DAktpfYBhETCx2o82qafFcvhTGsRxC5utJkRU+qW2l51NjkAy/9HS0euo/G/FYNHAS7U
         B+Gn28jxbxLjD11EJ9xXnEouTBnNOfsMq58TmNPb+RcPGRxgkNXgj2SHCvkipqLwKdAF
         xjgQ==
X-Gm-Message-State: AOJu0YzkrLzbYv6gepMT+OcKduGGbxaC7g+h4U5J7bUej5uOLXlT7XqG
	UA/yq5MyJ8QJG+qnEiag37OxXR3PNziXKJVnS+GxLAYT2MvEqU8r3go=
X-Google-Smtp-Source: AGHT+IEWmm4zsK7trudVYwAf/DSQ/1DbDzKa3t2Na71SAO1Fo9gW6aO96foQVVUNCaJicwhtrG1KXyXxqnrGD7i/HQo=
X-Received: by 2002:a05:600c:3089:b0:40b:2979:9cc2 with SMTP id
 g9-20020a05600c308900b0040b29799cc2mr15935wmn.1.1701377508071; Thu, 30 Nov
 2023 12:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030104746.241414-1-rf@opensource.cirrus.com>
In-Reply-To: <20231030104746.241414-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 30 Nov 2023 15:51:36 -0500
Message-ID: <CA+GJov7r9AiQSfFrWZLCL5SDtM2J6RND+zy_ieHGq8H1pJO5Mg@mail.gmail.com>
Subject: Re: [PATCH RESEND] kunit: string-stream: Allow ERR_PTR to be passed
 to string_stream_destroy()
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 6:47=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Check the stream pointer passed to string_stream_destroy() for
> IS_ERR_OR_NULL() instead of only NULL.
>
> Whatever alloc_string_stream() returns should be safe to pass
> to string_stream_destroy(), and that will be an ERR_PTR.
>
> It's obviously good practise and generally helpful to also check
> for NULL pointers so that client cleanup code can call
> string_stream_destroy() unconditionally - which could include
> pointers that have never been set to anything and so are NULL.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

Sorry for the delay in reviewing this patch but this looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index a6f3616c2048..54f4fdcbfac8 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -173,7 +173,7 @@ void string_stream_destroy(struct string_stream *stre=
am)
>  {
>         KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
>
> -       if (!stream)
> +       if (IS_ERR_OR_NULL(stream))
>                 return;
>
>         string_stream_clear(stream);
> --
> 2.30.2
>

