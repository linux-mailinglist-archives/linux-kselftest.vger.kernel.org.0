Return-Path: <linux-kselftest+bounces-47857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB881CD696C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A20C301B7CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A932D0F5;
	Mon, 22 Dec 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fAOhR5jH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5722F6191
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766417851; cv=none; b=Xa29gW3+HBt4rzOw9a4J1DJkLouHubnzJhupnJRNlDPSk3FpRnMPlv59UBOhP72MR0d2pkR5TWSOTNGGFN3Y5badIXR3gDfcGV3r01r1e97NGxVDoOJY5fZrCeEJqMxRnrp29YO05+VmIYwzab9RjXdaVNDMRKOgYiWS1MwiRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766417851; c=relaxed/simple;
	bh=RcUzhWg/Um7DuspxpIDIAp0IJtjt6YbaI9Q9VwJGvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRFUI+r6nLYTzonm7bhsmnTM/dM1IJApFxQL6QCS7qGMykJsJCwugfIffSqnfSEQBfPeN7IspV+ejWPVyB5GmIT3BqK8oPjLu2oPoKy1dLpYCv4qAwFtjoAlZguAIAv6eVlyRF5YWNyeegajr1v0O2rHvI1l/0OLo36SBuvM/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fAOhR5jH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a07fb1527cso9688275ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766417849; x=1767022649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT3Diy9pIeV/PN2q7dXNIN/gteU85UXLAruGSjxuY7k=;
        b=fAOhR5jHEOjYoEhcIrvhhf6mnJZp7JZACt0C1LbMwjLiP0zQ1HCWtgsZYwP8JudWQO
         xEoFM0tAG/1r0GUWLXVkI/eEAVTCTFXr6eUXBHMXdo9wGQ0OA4Di2/j9G3eIy1nq4GJa
         NXnjy3vBzL6vBCkxuJqcpsOg7BRo3OGr0kNAdekyZhAMqsRaEFwurxlGWAWXSWpuUp1r
         M0+rvA+taHJm/nzNgbr+NHdj0KkmaTDFK+wwnT6/vkeRlfpDBZQTDaQMnaRyShMLr8sc
         er3h1BQPMNzKr/W6q5cdXZTETElIXHO1FFFAo442KVCIT0Vfapmsqeuhq4pwQDFs/hjh
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766417849; x=1767022649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT3Diy9pIeV/PN2q7dXNIN/gteU85UXLAruGSjxuY7k=;
        b=MHUN49XMqBvK1m/AlYCnAJOriMG5mRJ/bUPz40TkFgDdABy0x53Rk+JAnsRQbhDsvf
         mJq9x9uYgjEdsEIM6+gnUbLVciMSnRNxECEFHc9regm7N0TjW0SsGT3ErpQOeUcpogP0
         Sj8ki9LGobQwANQGsGMHTcJR4NN/XJQy5N2v9ef2dLl1m5ifAZM+5mwMJkgcQfWoVWSd
         d0cL4G/uNlSqITDmwGOQnJeVYneMjA0yuPXMGTNUis5is2kL/tR3KyotmIQaO08I8YIf
         j+hPoW6XR1oQh6+Q+McnnPVEvUX5IE28TUPT8so2nqgjRbM6YjCs8sB7f+/Dn6AiCDBh
         7rvg==
X-Forwarded-Encrypted: i=1; AJvYcCWw4G/Y3zg/jclsc5daMIVXwlWFjiULB4ZhxExOU+j5XapDQm4TSyShRQY+b22q6Eqw9rjXc4/ubeoHAlgzcvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6X+3TiEJZS8nd8XxXMxShFx0HYdE7bN5FsTTUB8GsYwR5z87
	HV5ZCo7hzuzE+cC8iH9Hou17W208oZthzgty+cNqgWfebhSvTk6AllY9XrjfefafR55RT91UuRu
	rQ35yNzfRj1U97pJ/V7lYlcg5f2f7NMp9Eja+ghcqEw==
X-Gm-Gg: AY/fxX6sMMkq8kIpth+KwlANXJ7wbaowuKCdQEEHMhWrcAitfdJdKRWz8v9UgTQDIN8
	unfIaMpr6E8TJgttfoD+qR0/TqBhSmI/uth0B6RO0cLAVyPVQwHi6219y+ZSFAcu61WryD27RG7
	ZvJipOAJVO/j9JFcN5swroZyveEt3QlCcpgz6N6VljBkZypyqaf/T9ayG4x7TNV4JGB/A2Krq4F
	vcpBWCeIrzgvh0+QuciHoLaB61P5OZ7O/5Bs7HDBs/qWIHs8JPv+t96OmE1jO48kPf27iA=
X-Google-Smtp-Source: AGHT+IG48uyE1b0nQuixVJe4XhHbbPE00lDgvxvW34A3y719k7ccU/Y7YctxFgCLxQBrdafH3y5D7Zxd3tmvFXs4w2o=
X-Received: by 2002:a05:7022:6199:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-121721ad61fmr7865966c88.1.1766417848941; Mon, 22 Dec 2025
 07:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-9-csander@purestorage.com> <aUlbPcjuk_XlE_zq@fedora>
In-Reply-To: <aUlbPcjuk_XlE_zq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 10:37:17 -0500
X-Gm-Features: AQt7F2oQd6LyEEMBKp5IZ-BamQwRQ8iC19BlCQuds5IXxVlYv-HC1nOaOAZV2eo
Message-ID: <CADUfDZpW-8e+tkPJZX29w9Rs1vWc5T3t7qZQXWpyygKh42WKbA@mail.gmail.com>
Subject: Re: [PATCH 08/20] ublk: add ublk_copy_user_bvec() helper
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Dec 16, 2025 at 10:34:42PM -0700, Caleb Sander Mateos wrote:
> > Factor a helper function ublk_copy_user_bvec() out of
> > ublk_copy_user_pages(). It will be used for copying integrity data too.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
> >  1 file changed, 30 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index d3652ceba96d..0499add560b5 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -987,10 +987,39 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > +static bool ublk_copy_user_bvec(struct bio_vec bv, unsigned *offset,
>
> bv could be better to define as `const struct bio_vec *` for avoiding cop=
y,
> otherwise this patch looks fine.

I was thinking it probably didn't matter much as the compiler was
likely to inline the function call. But sure, I can pass it by
pointer.

Thanks,
Caleb

