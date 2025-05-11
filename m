Return-Path: <linux-kselftest+bounces-32823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0ADAB25CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 02:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FFA17FE57
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 May 2025 00:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CBF9E6;
	Sun, 11 May 2025 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YBKcljK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3E9444
	for <linux-kselftest@vger.kernel.org>; Sun, 11 May 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746923760; cv=none; b=MTO3mKUTNCbn5QRPBV2E6i9RZOHUwsxoYu4KUI+L6RLfO2eyb/7UUbtpD1zBnJvOzCT+URF8p/z0ELH+hVSX6vsTCI6bCUdh9HTHv2L8MKIK8s4Uo14ZmJ01ww9Tm5RBS2mgcTqsuMhFmlDJMrjVhT8se2sp1l/XsvbYYIKUVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746923760; c=relaxed/simple;
	bh=r03nLJvgUgmrXUBp6pwwH1baawwiopAwlukRYtT8E8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZXRdtnxkpWpLOpLJcwRUsXLJbi+Zi+XSHVs9aaHYuWJMwj9+WegvEzOiVhdjsaAsOn6DtOs4/ECYnco+9VVP71/D+oPLUjRjaunjz2HU9+Hk1WTOq1+OALKNv6BeEWK/uKt5qlnLlc2HGjZtmbiLOMeLVTElAwQ5tR5hTCxAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YBKcljK1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7423ee0e42dso383309b3a.2
        for <linux-kselftest@vger.kernel.org>; Sat, 10 May 2025 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746923758; x=1747528558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtRaVsiUBI+SZ9IP8U8WDTO4rTZdygKMrFtkoyTuE/s=;
        b=YBKcljK1hLQ/txMdxQ1bK1cdOGHYDVulrCIfYr6zlA6qpQcrIlDwsulYknuGx7HFl2
         UuV5kF2t7r0BEerB+2rwnefXHqPkA3F7WgBlxBHLnq6wSQxgm/Dwg1BdNyT4rTSehxyS
         JQeruB4lNcl6A+tr9j5SA+n5t1wB7vEeZT+y0I0TMHACuOubs61o5yPSincVRFORTyIp
         yTaHyaB1w5FesWJVlcoPGFH7e1GhqLZPFJnG6rP7uuecSBp7com0PP+Y40d1c+bp4IXc
         9OtM9Xn9POU2FM+Z2uw0R062OZawBGEfDETnYlkvZYwwgSI4vBgcksn3D17NPBV52/fg
         s3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746923758; x=1747528558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtRaVsiUBI+SZ9IP8U8WDTO4rTZdygKMrFtkoyTuE/s=;
        b=U4JHOK3lCwbyhFWinOHSV5n9wca3RbT/Tc8OJXioCDUT921P/0ymjqjb4kX8ZlrsnK
         cTTX35FNMmyZjKGWwBJd8PTkvc6DYg/na+x/6wK1uCNksGWpMFd9B9HCBL0Fu8Asmi22
         U2qVHGLQZKrjTWrz+w06ygka8uPA6l30gxe3Isc22P6v4TsdMYyCuRNZAP6lgfZ/bY5w
         AlQ/0Okna8O+VnjySGTgvt2/rd8ckg4qc6DhWL7bIj1Xcrw0EGsnYs4wyeo8G057s8PE
         cRaGWtf/6BRi1HMVYjC54QiReHgIVDnZmqKijQE+Hgvm83V0TqQAYGDtB2/ntaL5J0kW
         Cxgw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tmNzw1sh+uDxELfM1Y82uqi+8dfJRffjZJu1oqg1cysRuj0IZaPU0aMYTuj8SwPUP689C93LQgf+Sok+uvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPvp3tgGuasqKhk/KhcpWhjGlvRlMfObPcfzHdq7JYMkvAJuu
	TeEQqVp+nwBDEq3uSqwFxY+eteUF0RkbjvpHKaJLmSt8JN07Z/z8A8pV3yUTSNb47vrLEcSQVY8
	Oo0/cR5Ez3o3jdrmmzelnXVpqIIczLw3s+ozWJg==
X-Gm-Gg: ASbGncsqiFQiB1MZbQ3EE2sAe4E3CiZ9IR4YHbpGQIl2VvTNrxW72j0vOeBPwIq+PJ8
	i8qFI9Ohu47pSr6xqtejfenkFReDGHSFlZpNOItT5nZBHE7g37EacMlGK5O3iPHt+KdVSFbeqis
	HD+ofBlZ8pQ6VPvp9AOk09q0u9MLfQS6s=
X-Google-Smtp-Source: AGHT+IEQchr0wi7aB6E+8gcZ5oqBZRv0bHhEJAH4Nl3ce9Fg2GOxYYgtWBIB9g4f0p6+kGvZGmGTGjU/TmWpKmQUugs=
X-Received: by 2002:a17:902:ced0:b0:224:216e:38bd with SMTP id
 d9443c01a7336-22fc8b3b40fmr53521885ad.5.1746923757953; Sat, 10 May 2025
 17:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com> <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 10 May 2025 17:35:46 -0700
X-Gm-Features: AX0GCFvq5YiYiXLcLb8hsdNH-xK5jnR1e6XUTmKox4Zk6Icabgf3xuys_D3kZR8
Message-ID: <CADUfDZrhsQfx6nyCZQq=8HDZLysa48uBWuENY6oKnFuayt-wCw@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] sbitmap: fix off-by-one when wrapping hint
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:49=E2=80=AFPM Uday Shankar <ushankar@purestorage.c=
om> wrote:
>
> In update_alloc_hint_after_get, we wrap the new hint back to 0 one bit
> too early. This breaks round robin tag allocation (BLK_MQ_F_TAG_RR) -
> some tags get skipped, so we don't get round robin tags even in the
> simple case of single-threaded load on a single hctx. Fix the off-by-one
> in the wrapping condition so that round robin tag allocation works
> properly.
>
> The same pattern occurs in __sbitmap_get_word, so fix it there too.

Should this have a Fixes tag? Looks like the off-by-one wrapping has
existed since 4bb659b15699 ("blk-mq: implement new and more efficient
tagging scheme"), but it's only a correctness issue with round-robin
tag allocation, which was added in 24391c0dc57c ("blk-mq: add tag
allocation policy").

I don't have much background on blk-mq's round-robin tag allocation, but FW=
IW,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  lib/sbitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c03dc6600bbe53f130404b765ac5a..aa1cec78b9649f1f3e8ef2d61=
7dd7ee724391a8c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -51,7 +51,7 @@ static inline void update_alloc_hint_after_get(struct s=
bitmap *sb,
>         } else if (nr =3D=3D hint || unlikely(sb->round_robin)) {
>                 /* Only update the hint if we used it. */
>                 hint =3D nr + 1;
> -               if (hint >=3D depth - 1)
> +               if (hint >=3D depth)
>                         hint =3D 0;
>                 this_cpu_write(*sb->alloc_hint, hint);
>         }
> @@ -182,7 +182,7 @@ static int __sbitmap_get_word(unsigned long *word, un=
signed long depth,
>                         break;
>
>                 hint =3D nr + 1;
> -               if (hint >=3D depth - 1)
> +               if (hint >=3D depth)
>                         hint =3D 0;
>         }
>
>
> --
> 2.34.1
>

