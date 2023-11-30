Return-Path: <linux-kselftest+bounces-912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165797FFD2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AEB1C20D1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139C853E00;
	Thu, 30 Nov 2023 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIuBcQmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC081708
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:57:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b422a274dso8355e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 12:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701377877; x=1701982677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/l1oyYMER9bdmRSJxabnKYiLsJ8DbCjdBG67yg2+OI=;
        b=KIuBcQmpMAwF6/NlKMg5+8untx+4dxgBlGbP8Swo4mvsBiq7u/UBr11UwtBjWnOSUN
         RtaG6xG08+50lgGTP9E66UWywRqVgsyWLruDCD/lr85WcX7rDWBNaIO7ytRKk4x9AFB1
         HB4+GG3Fp8ZI5ZFgL0SbzscrF1245E5VNtb61ZWd5sDsBZNDx/1tMGK+2oiFwxrJFEvG
         Vni+n8uBxsO/XSovpEj5H9NCfFRrrDe07nTIUh0T99wvFExEo0jj5fp+fSekscbedVbM
         X88u4nCpkNUUPDlVJpFJPJu6CYngZJ6lHQTHnpmWmMdiEafGHyosKa4btQrRGP5zxOj2
         Hwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377877; x=1701982677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/l1oyYMER9bdmRSJxabnKYiLsJ8DbCjdBG67yg2+OI=;
        b=kkrNq/F03Te54i0sOeVnqwu+ng5fmeMFrche4DIesZ4FN1vdjrRUHmDHM4p2ztypTR
         GhkI757cohtd/3tb0byMap8anzJrjula5hpsHBs9cc0MYWQIcDoQUueFvyzvnVd6cwzg
         6QETGS1+xG7Ka/SY5rywVekM66S3o55jaCZgSmqohJqSIwqnf/RFHXsBpceTi7nL+uR3
         Xc2RMSkF30K77kjw2t+TZ4Fdh3Cdtz+ATQK1B1yOT0LJrjWtVju7sKecAprpZXLJIx3m
         uj2eh4iNTvtwtENKP3qIj6iOt7KXdiaDKXKjk9Ab3AJLcV5cAEnruE1bD+OfDuenbnM0
         i52Q==
X-Gm-Message-State: AOJu0YxI/tB8rBRKZQzLrzDqHm0ysWZQhf3nyODZ4X506XAEs3GWXPRj
	i7cIchIXpTEh+/ZclxHw4LpBxvbLKBfd+SM2wnT8sg==
X-Google-Smtp-Source: AGHT+IEFkzzG69JgX8+EtDgoeVk1m/IAKAaqysFjAuWz3CoPTFFan6cx+EoVlMfrFDIG2IOXd2z4OM+JIXhlwEapMlQ=
X-Received: by 2002:a05:600c:4507:b0:40a:483f:f828 with SMTP id
 t7-20020a05600c450700b0040a483ff828mr22184wmo.4.1701377877459; Thu, 30 Nov
 2023 12:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030104758.241472-1-rf@opensource.cirrus.com>
In-Reply-To: <20231030104758.241472-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 30 Nov 2023 15:57:45 -0500
Message-ID: <CA+GJov73iw=Z=KibZ6QtAHRZQ4aaoodx=dan1gBSYnsP2vf9Hw@mail.gmail.com>
Subject: Re: [PATCH RESEND] kunit: debugfs: Fix unchecked dereference in debugfs_print_results()
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 6:48=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Move the call to kunit_suite_has_succeeded() after the check that
> the kunit_suite pointer is valid.
>
> This was found by smatch:
>
>  lib/kunit/debugfs.c:66 debugfs_print_results() warn: variable
>  dereferenced before check 'suite' (see line 63)
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 38289a26e1b8 ("kunit: fix debugfs code to use enum kunit_status, n=
ot bool")

Hello!

This patch looks good to me! Thanks for fixing this!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 9d167adfa746..382706dfb47d 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -60,12 +60,14 @@ static void debugfs_print_result(struct seq_file *seq=
, struct string_stream *log
>  static int debugfs_print_results(struct seq_file *seq, void *v)
>  {
>         struct kunit_suite *suite =3D (struct kunit_suite *)seq->private;
> -       enum kunit_status success =3D kunit_suite_has_succeeded(suite);
> +       enum kunit_status success;
>         struct kunit_case *test_case;
>
>         if (!suite)
>                 return 0;
>
> +       success =3D kunit_suite_has_succeeded(suite);
> +
>         /* Print KTAP header so the debugfs log can be parsed as valid KT=
AP. */
>         seq_puts(seq, "KTAP version 1\n");
>         seq_puts(seq, "1..1\n");
> --
> 2.30.2
>

