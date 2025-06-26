Return-Path: <linux-kselftest+bounces-35870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7EEAEA38B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215771C460A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12D211A05;
	Thu, 26 Jun 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVFEVI3B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194420FABC
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955447; cv=none; b=hWkpR8QzDoxT5/6LqVsSwLXulB7+SJjmTEPlsegWU7ry0cFJMVO0JtsNE09pkUgrlBpOCZhQU4XnOVONiJg/vEti5zyLec7WREyZ9uzIUUuD5aqxNJnQme5LX2WHWJsuT0hwdfweDJC5okD8nWViPSkBQm6aImsMlCKAtF5wgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955447; c=relaxed/simple;
	bh=VxniKKxdj8VO60D+f8aO8Zk5R4w5C4igetSRbzU2mqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpQEsqxBcs17XpDcYoj4cdcsAEFZY+SeEzLLBDMLshGa7JC2HM7oTrZM7rZOAzjXECeZE4jSMN3B6g9VgHtSomd76MjSl7yPykAdNliETkPzDy9vAYfhQTUkJYEW+ZYLrjQoIkEDY5tbiOPied7BoMYl1DknNiYU/Z9bPUDEea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVFEVI3B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237f270513bso179775ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750955445; x=1751560245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxniKKxdj8VO60D+f8aO8Zk5R4w5C4igetSRbzU2mqw=;
        b=qVFEVI3BnK/A8w48E+me7Yu/T4PEBwoQV8siY2cs2fdMtMl/1UGcWjZogr52vUUf2w
         SrmmY+sxVCS66PFYNxgie6YlTIgbQlE+zDkmbgbxIJ1gkTg+/7pV/imtZqaVP4QHMmPi
         5llOuln+TKIcY6g3m6eOC7IHEWYBcnSnOR+BxgJYM2z6DMXoSdq87FOcnm1X3SXNqqqs
         z//VwFTAnrwEvPDull3wnQdo2VTlUYcQY4wHOnKP84G/Rl35+tuw1fvmLFLZJv8U2cRz
         E4lQZXc6OVVzfmxiiIvlfAkmQzcXH3DaDAqxyyMLb4xorfS968EyJUMceaCFfJnRPKg0
         yJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750955445; x=1751560245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxniKKxdj8VO60D+f8aO8Zk5R4w5C4igetSRbzU2mqw=;
        b=DBUr+icLgNs87LyZyiBuA6/Cqtz92zbBlIkAJXtma9oyRbPQxGjv9AOp1fQ7q6GCM+
         9MqyNQBT3yRH/sseJwaRdBPyK++lp/CMgLoBFJep/HOhRWDSgUSCSFrN2MHpCjzAZihH
         i65Z3KKZSgMPR4KltrJ1nvFR4Aq6UPRt9ffm14/aCucxXUfIyLmFgCGIym5PYTSz0lOc
         DY0R3Yd5y10ZPO/UvwwhHTa7787xj12dwsI+WQdAUN9nejwqDtHtokcpJ0G4ju4FgzVt
         JdW5UFYW6V5udOy0+/mRGARR7plegbBL+E2WS2vqUU4XWATIHFqiAq9F+pDb6Jj+LNSm
         p9ag==
X-Forwarded-Encrypted: i=1; AJvYcCU1sqin53AeIp0C3BQSkVpxBjYuQkxaiQr2pUJF9lH03vBdU271YIFAG9HzUB7+rm4Dr+WnkYzmbAgoC9UfajQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3dVHlBd2Z+WxnjwTQW1O7rmS2a/SZoDKsU1h6g+CHQ6Q0YHc
	bL1/kzA1bBA2yRTJB5GtR3xcMGS3qt4TkL6ff0mxERByygCwi49361wPklZ38/BgQdCnpjZOI03
	4RhqRmCye1rzhVnn4ogERuUYgNBHS+djtgU13lPw5
X-Gm-Gg: ASbGnctHxSpJ5J4Xm4gMW5rnTnF7sY+bkJR9G/9x+Cgex6gEw7Em1CY3gxfhDgpO0eA
	V8PsaOzwTjzLwcUum49BKIZUtpmDLkvZpHxb9+BJ4AiQTYZpSHbEzjd02Ob+IbAimlh+ztVdr/B
	usFGHe8vn6LiSqJp/XwwNHbAHppzjoxcjQf21SFgRXemXdL5XN10U3hAMIePXew6I2WN3mjbokX
	w==
X-Google-Smtp-Source: AGHT+IHnkI1JTKMufhBHrZlGk3kcyVjXOAIfbl75+k0vyNtVnCOnm8BKwUiXRKwCOmCAmjKm1fvC9OsZdFGZsBrVeGo=
X-Received: by 2002:a17:902:f64a:b0:236:9402:a610 with SMTP id
 d9443c01a7336-23ac169a103mr188905ad.22.1750955444986; Thu, 26 Jun 2025
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619181519.3102426-1-almasrymina@google.com>
 <175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
 <CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com>
 <20250625170305.40d8c27a@kernel.org> <CAHS8izO9=Q3W9zvq4Qtoi_NGTo6QShV7=rGOjxz3HiAB+6rZyw@mail.gmail.com>
 <20250626082327.59888c1f@kernel.org>
In-Reply-To: <20250626082327.59888c1f@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 26 Jun 2025 09:30:32 -0700
X-Gm-Features: Ac12FXyeQlG6eMLJvH4wzEsZH3DMG00Fymfw_gdDT1maO_1-nKM7RvUbzGWO3f0
Message-ID: <CAHS8izPCjjfgfUWVuANcCLs6DLCefAyQL4OKT9g0YQTt2jraKA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	hawk@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 25 Jun 2025 17:22:56 -0700 Mina Almasry wrote:
> > What I'm hoping to do is:
> >
> > 1. Have nipa run the benchmark always (or at least on patches that
> > touch pp code, if that's possible), and always succeed.
> > 2. The pp reviewers can always check the contest results to manually
> > see if there is a regression. That's still great because it saves us
> > the time of cherry-pick series and running the tests ourselves (or
> > asking submitters to do that).
> > 3. If we notice that the results between runs are stable, then we can
> > change the test to actually fail/warn if it detects a regression (if
> > fast path is > # of instructions, fail).
>
> That's fine. I don't think putting the data on a graphs would be much
> work, and clicking old results out of old runs will be a PITA. Just a
> little parsing in the runner to propagate it into JSON. And a fairly
> trivial bit of charts.js to fetch the runs and render UI.
>
> > 4. If we notice that the results have too much noise, then we can
> > improve the now merged benchmark to somehow make it more consistent.
> >
> > FWIW, when I run the benchmark, I get very repeatable results across
> > runs, especially when measuring the fast path, but nipa's mileage may
> > vary.
>
> 100% on board. But someone with Meta credentials needs to add a runner
> and babysit it, I have enough CI wrangling as is.
>

Of course! If someone with the credentials volunteers that would be
great, if not, no big deal really. We can always get the runs manually
in the meantime. The volume of pp patches isn't that much anyway.

> Or we wait a couple of months until we migrate to a more public setup.

Yes, I'll take a look when/if that happens (I'll watch out for an announcem=
ent).

Thanks!

--=20
Thanks,
Mina

