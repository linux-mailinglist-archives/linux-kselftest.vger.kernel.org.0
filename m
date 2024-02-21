Return-Path: <linux-kselftest+bounces-5234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18085E920
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DC1C20AE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46D3B298;
	Wed, 21 Feb 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOJLHGKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF44A1D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547844; cv=none; b=eaGMYMUPiVECS96OefivzBRCfZA3+6eYuFk5TCUH90IjGrz8gOGV2cxuGKTsaZDP8Y6XFaMHgMU0rpQx/7lXK/tkS25NRt5xIXEK6+n6NL+eoxS32tgf+wudRK+aDMLPzsXkPeZ548c8wr8gmIAYJlTDv+IvWjzYV+GqyrtKoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547844; c=relaxed/simple;
	bh=GFhPlma8ElxwHflsLYpQTVGFiMO4B/Q3z9xrY8lb7y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+yraxUMHfmQTbCDuGzIOCRivWbKuyTY8icZ2QQf6TzZR4G6ZRy+WLRk26KkVoIA7m8q0Ga2EUtU+lxHlbNtFiblSwQHzOx3eNPN94xI886w5a/ggrm5TsFta7BBwAwjksecls/888f+ghZtW1i5gpEx3tWZ9FxuywuaTn+ps+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOJLHGKK; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e2507c6e1so61901cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547842; x=1709152642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=HOJLHGKKrcNVm9zHUUvf7EqnDqKAk5QM+rTcL4NCiVRYjsxUhivIg5hRT/LQTS3z0w
         tN+59qnO5jXS7h3bwo0QLneyaJDPSsQ/R0H1VMsMnsjqzwXqZvhyZarJBIBft1W6CvoH
         B5UzCPI6pE2zPQG3P+0MIJhBBel75TYzMORBwlsYVRVBFEYIERbWD4IPOgazb1cfKa9k
         41VriWt5nFgbMQlIOmUdnmfsiQo+nFmu5r6uKzQMadcTua5363qY17NlspO+cw9q1ylW
         rKPQliip/GGG9rK8WU3FjqvnPJLOyGZ7VgzNb2Fw9+bC6gI4uJTzG5ujcwLOiXUil9JF
         z71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547842; x=1709152642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=ArTVdjTysymF5nMAul+aerrerHR1sFBz4TybJjUGUJ54eoDYDTPpRCp72QwQwIAOef
         4cxuFSxZBM2VQ0PU+pdWsC2zJNpsuSDgatyRObm/DN5wQwpQvGbQFFUEqNKzTRMkFL+b
         uJtfY6mClZffaIp8gF/VGH2/zeoyJrjGH3cmxCfqyXxptMWBRGBujIwFfyihTNZrncsi
         aRV3aAJ3nYe8ID8ahvdBVPmQ4i8CgfjCxk6PxbOt82gK6or2PpxUCKjxJt4d2D3JB/gg
         EBsnOn1/phzShyM/EazkpL53SJtyODMeD4jo1eEJ/PCZiefRKI0HIJnPZvqn9djTjC5Y
         M6+g==
X-Forwarded-Encrypted: i=1; AJvYcCU7BqsldK6RnpSNgIZiW4jwnLgbOtaGkxLUlyLBmALyEOyndeqvelCwRfZybvcUCCzy6TbfjznHQcOTdsrmiG9oppczOcYrwusOI92VcpPo
X-Gm-Message-State: AOJu0YxkFMGXGJyZLRqoIndXd5usUky6CQzYM9innWiYFwSqir2qHLS5
	plcCEI0fhmVJt3jtSREs8eGevhrPDz3csRTgb2pVv9vrjAidhh8bamaWHpL71S8bUoVEUMNQm+1
	Ni5pkfUJc1mUFCAn3zBp7xvBvXSBPdfD5NR6UBA/aWxiGn+m2aw==
X-Google-Smtp-Source: AGHT+IHkUH8682wBjX2MlXCiKDKRKTZ78A7IDkSZwKh62FAeHimOB2zWqCHjoUmuvZXD72aiFX0+O0WGwp10g7NziwQ=
X-Received: by 2002:ac8:4907:0:b0:42e:660:eb8d with SMTP id
 e7-20020ac84907000000b0042e0660eb8dmr285459qtq.5.1708547393077; Wed, 21 Feb
 2024 12:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-2-davidgow@google.com>
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 21 Feb 2024 12:29:38 -0800
Message-ID: <CAGS_qxpyNVqigHB+kS-1xqzR4BAOQXoMSNS+d5khkLYrkpmOgA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in executor_test
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:28=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.

Note: it's worse than that, afaict.

It's printing from a random bit of memory.
I was curious about this, so I found under UML, the string I got was
always "efault)" if I make it fail for j=3D0.

>
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>                         GFP_KERNEL);
>         for (j =3D 0; j < filter_count; j++) {
>                 parsed_filters[j] =3D kunit_next_attr_filter(&filter, &er=
r);
> -               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 '%s'", filters[j]);
> +               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 from '%s'", filters);

note: if there is a v2, it might be nice to include `j` in the message.

