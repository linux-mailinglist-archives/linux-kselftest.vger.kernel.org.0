Return-Path: <linux-kselftest+bounces-1454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9E80AD1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 20:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635241F20FC7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1FB4CB4E;
	Fri,  8 Dec 2023 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUwEC5xF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7851732
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 11:33:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so8535e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702063983; x=1702668783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra9vJuTInRrpamBBEJ9LmrEW3hYoB09CBBvxN/oJ2+Y=;
        b=SUwEC5xFvyL3QDodvRud/4eaGIAtEMP7zbj7xDJFx/avnxwykn0lyvpUdPFgBNM63Y
         jDRoDYxBqsl4AwlKUu8zweKfSbPCl3+GDwvVPg9zY5aDyOYv5AR928vA1V0jlyNW8yLo
         WPZCGT43X2ltD4XzSZEhNr5SjS6BsyPCjGFgS57TpdJOQaGHTNmxt2wg4wYicvMarsKZ
         YFEZKjBBc1PCP7HcUhbdYwH9JyjbIwRx24sbWEjXoJaNWGoKIFOSJg5wFe9HcKRhp/2f
         VaeQTevTvUG60yOFjqpGyduRLZ3gUKwkyaIEIZlCl7NEX9O1HxY6DXawTZV70i18KGux
         5PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063983; x=1702668783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra9vJuTInRrpamBBEJ9LmrEW3hYoB09CBBvxN/oJ2+Y=;
        b=dwrGPqYoxoQViGny4AJeFYCSOelXYZGyzEReqP9hC9pIjWrMUQJkL6I8QIeyzQzMnw
         7/6bouW3t5qbH5N5Ws30Tr0HEXz1pMopATuN42FYn4e7NtlUgFGMZiAoo5NqLPla4/1h
         f1sYrW+xus7/tDKvaQnZXPyUktDLbOMuhYRJs/iMvh9GI7De0GJcaME9Tbkx3WmFkk48
         SfLf/JEovNforL71HfetI9DOnXSf2BNT35U0cBCiJoBRCBpboaF28+JRSGDq1KpavNqj
         zVtxRNGdhfHh5PUal1AxZKbin077eUb2O/XUIVeI8psRvTvSsyneivI6D40w8glNZivZ
         6cUg==
X-Gm-Message-State: AOJu0YzfI69AkNOYKTauhkIt/Wh6ZDx6acCtgUm/w0mELWruxSgXHT+S
	M03Q8r3FPuyL9RYIHc6K77gPKHuuPJadUEmS2apnjIh6ow9fmxBmcBw=
X-Google-Smtp-Source: AGHT+IGdOUZJcWkF1Q/IPZf5TuqHSwtcgFDnUkDzI2G5sOp+gsWGwRfPac8MwWtVbp+GO5kIg5Uloat2UDw51JfXlxg=
X-Received: by 2002:a05:600c:286:b0:40c:29a1:5547 with SMTP id
 6-20020a05600c028600b0040c29a15547mr86714wmk.7.1702063982671; Fri, 08 Dec
 2023 11:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206082251.586204-1-davidgow@google.com>
In-Reply-To: <20231206082251.586204-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 8 Dec 2023 14:32:49 -0500
Message-ID: <CA+GJov4H8DJgeaxus5BTS=Y0iR9M+BirLVht8fB9jxjWGODrMA@mail.gmail.com>
Subject: Re: [PATCH] kunit: test: Use an action wrapper instead of a cast
To: David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:23=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> We missed one of the casts of kfree() to kunit_action_t in kunit-test,
> which was only enabled when debugfs was in use. This could potentially
> break CFI.
>
> Use the existing wrapper function instead.
>
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. All ready to go.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/kunit-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 3e9c5192d095..ee6927c60979 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -559,7 +559,7 @@ static void kunit_log_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
>
>         full_log =3D string_stream_get_string(test->log);
> -       kunit_add_action(test, (kunit_action_t *)kfree, full_log);
> +       kunit_add_action(test, kfree_wrapper, full_log);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>                                      strstr(full_log, "put this in log.")=
);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

