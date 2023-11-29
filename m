Return-Path: <linux-kselftest+bounces-840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A927FE1AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 22:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36801C2094C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861726167F;
	Wed, 29 Nov 2023 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skHkOTvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAE10C4
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 13:19:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so2925e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701292741; x=1701897541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rdop8jujlsq38j+c7NGxEa2QjOJzSNmSB+B/S+mFwg=;
        b=skHkOTvv8uUBVxZ3vfl+wDZ3VrCDcJOQy9bhFPNgdsZ/EgGQ5wP+4NnVJpanmWSTQB
         TwwB+FgwTzMyibzNtSvcBDj9v/iAOH2xpTPhDhirFOuLSWybFftpHbR1gcvrd6YjEkd3
         DX3IMgL5Z777bI8YIdoPW7+sD84gJbpLa6KyEh9o5DWgVsUZWPX/NoREZuk7sZSEd0U6
         N7OtRA00qLtkzBpCSylnzgUIDRSxco5Rx+3aogv2xiyYUNkpZUeTh7Qz6jcEzmRhjZgS
         QsiIWuqiZYaAgzuvVJfnC6OI+E+HX+bwUTR35oMF1pomhYQRt2TL8j7vwA9K+dKavWp4
         AEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292741; x=1701897541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rdop8jujlsq38j+c7NGxEa2QjOJzSNmSB+B/S+mFwg=;
        b=Od8cEa/h2bjZ5eVjX/g9Sc3EDs2rmdg6EM+kAX7gkC/oR9MHwfzA7BSAscWNR/5Mm1
         dEMBW0CayfzPESXFPXNTlvOmIn+zqY+fc3SU9fx2F65A5xSLzZQIptZM+6+CybVIrpBe
         xNxilsLi/9SZAZMnNcknER8XmOMb1oL/y9dKf0Dbk0OOt+RNdQbti4zBCHK+sR5iB4g5
         JCjuj+Xcw7EGpTi5bbeP+utBORKluc6tlf801uS2hsDxnoQhJIq+DLOm30euk3pwEIUg
         OFVX9inO62er/PIzcvsPx1P8iRimWpy+hHddlS1HlAJi+EDkQD6/sgvl2WxTEP55jYWB
         PX8g==
X-Gm-Message-State: AOJu0YwcTS6dUxv8GwM2Bzpp4GDeMzEHiqAlTUAgMedfzHJWJ/rsZvS7
	1lmD4oJjx+KGlWRWEz3kxyy0PAKIv6QHoYnq2dMLRQ==
X-Google-Smtp-Source: AGHT+IHyO9c4yie0auocSQkL6hivcgNhN6tW76pQ5z/ufkohVvgVzXQvW4qZ3GnEDZBUV5HP0qJbXbHG2m8gA/7WD+k=
X-Received: by 2002:a05:600c:c07:b0:405:320a:44f9 with SMTP id
 fm7-20020a05600c0c0700b00405320a44f9mr31506wmb.5.1701292740717; Wed, 29 Nov
 2023 13:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121162457.17703-1-rf@opensource.cirrus.com>
In-Reply-To: <20231121162457.17703-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 29 Nov 2023 16:18:48 -0500
Message-ID: <CA+GJov50r+0vPj6gtgXXuaKf8nQqt9CVM8dGUsJcxiFupxo7Sw@mail.gmail.com>
Subject: Re: [PATCH] kunit: string-stream-test: Avoid cast warning when
 testing gfp_t flags
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:25=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Passing a gfp_t to KUNIT_EXPECT_EQ() causes a cast warning:
>
>   lib/kunit/string-stream-test.c:73:9: sparse: sparse: incorrect type in
>   initializer (different base types) expected long long right_value
>   got restricted gfp_t const __right
>
> Avoid this by testing stream->gfp for the expected value and passing the
> boolean result of this comparison to KUNIT_EXPECT_TRUE(), as was already
> done a few lines above in string_stream_managed_init_test().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: d1a0d699bfc0 ("kunit: string-stream: Add tests for freeing resourc=
e-managed string_stream")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311181918.0mpCu2Xh-lkp@i=
ntel.com/

Hello!

This looks good to me. Thanks for fixing this!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/string-stream-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 06822766f29a..03fb511826f7 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -72,7 +72,7 @@ static void string_stream_unmanaged_init_test(struct ku=
nit *test)
>
>         KUNIT_EXPECT_EQ(test, stream->length, 0);
>         KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> -       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_TRUE(test, (stream->gfp =3D=3D GFP_KERNEL));
>         KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> --
> 2.30.2
>

