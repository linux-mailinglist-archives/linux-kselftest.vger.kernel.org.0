Return-Path: <linux-kselftest+bounces-2813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DCB82A319
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 22:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140D1C264A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2C4F5EF;
	Wed, 10 Jan 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRDNLOzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3134F5E9
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so1335e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704921007; x=1705525807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dBlfe0ai2/9qnOVJT7Cr9v3swK0leKtoIMht6HfIU8=;
        b=rRDNLOzIiXSOzioXfKQkfA5eOus1qZsfOzk1snEsyTecSdZXKLKrs8N7OWu+agHFUW
         F/VZ0HVe6SpI31YoKeZwjvy24qCcznW5REcWmhH+1LbPwWzwsoyrQUM1NT5JWhkt0SEh
         qOU9jRd/nIfYeKYuex3CB0S0u1Kbba6Ei7Q4LeKNYMD8I34CRUk5p+jdA1ROB7JQ3ojz
         4gMNmmEtuGk9X7oC4m3tEnKxK7b6B5u4spsz2UWTpye/BK0wng69jHCS/RJR2YGRZf6F
         /ctBK0Qrv5m3LJeJbHB7ZIutMbGePeb41dRAeaO9fvJIxnDJw63SHHCRtKtIRPYRO5Ip
         smQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704921007; x=1705525807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dBlfe0ai2/9qnOVJT7Cr9v3swK0leKtoIMht6HfIU8=;
        b=vpYXQ+R2Ppopwz+HMskTX8Sd5s8wRd/f4b4zqf5WUrLk+1ICmV14Dc/Y8n3wjOmv0z
         SHEn49Ihg3/wQmKb4Bl3XjH1igf4ZIcAW+BhKT9v1MCYo9/dVO+lXmPzA1lHF4kTd3PX
         FCdN07xatQlzgmDsSr5HLCbT0qyFf2JtaRVeXRqhXxnKSluzT15IWdVG2VATUddbqrTV
         04lP0neJsGLXFTftibxnpdX9wFrNswMAxIUhIYcbewEQWUPavngI1CsKJPm6Km29VBzC
         6WqTZ0qaGz/B+AF64CVvr7OK8/Bv1OJ+1BpMsJrWjcv1Pe4BGGrTpGeuwkYWK6tEPz8Z
         5z1w==
X-Gm-Message-State: AOJu0YwVNHOrHQp5ODdchYi0eQwxIUY9j3OkB28dqjsBQtL2P5E0yv9D
	So0nLSpXva7XWJE1IxkIB+49apiZC/QnMjNJEPLhJr8UIm+20cF/XVFtH9oB0lqW2KD0g3nyo4S
	lkVCgfxa09UZT26Mj1rN7snoH3ukOqnQsVGNF
X-Google-Smtp-Source: AGHT+IHsAggDnwF7TsHK2T7smnyeA48DXI2a46o7MmsiupRvXAiMBgCqaHhlnBsI7Z9bP9EmbmAIt/9dbXM0bef0tPs=
X-Received: by 2002:a05:600c:3b09:b0:40e:490c:48a9 with SMTP id
 m9-20020a05600c3b0900b0040e490c48a9mr7775wms.3.1704921006606; Wed, 10 Jan
 2024 13:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd938a86-38d9-4d62-abd0-1df80395fbbd@moroto.mountain>
In-Reply-To: <dd938a86-38d9-4d62-abd0-1df80395fbbd@moroto.mountain>
From: Rae Moar <rmoar@google.com>
Date: Wed, 10 Jan 2024 16:09:55 -0500
Message-ID: <CA+GJov7P_ypZ58TrWoMSSQyt6fdoGyYTqbfEuU7v_ZHFSOczKA@mail.gmail.com>
Subject: Re: [PATCH] kunit: device: Fix a NULL vs IS_ERR() check in init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "davidgow@google.com" <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:55=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The root_device_register() function does not return NULL, it returns
> error pointers.  Fix the check to match.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

This change looks good to me! We could check for IS_ERR_OR_NULL
instead but this change is more correct and is also how others check
root_device_register().

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
Rae


> ---
>  lib/kunit/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index f5371287b375..074c6dd2e36a 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -45,8 +45,8 @@ int kunit_bus_init(void)
>         int error;
>
>         kunit_bus_device =3D root_device_register("kunit");
> -       if (!kunit_bus_device)
> -               return -ENOMEM;
> +       if (IS_ERR(kunit_bus_device))
> +               return PTR_ERR(kunit_bus_device);
>
>         error =3D bus_register(&kunit_bus_type);
>         if (error)
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/dd938a86-38d9-4d62-abd0-1df80395fbbd%40moroto.mountain.

