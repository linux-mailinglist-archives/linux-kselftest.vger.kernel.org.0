Return-Path: <linux-kselftest+bounces-42004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B13B8CF0F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAEA3AAEF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E531355F;
	Sat, 20 Sep 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xtn78Rp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00B3126C3
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394746; cv=none; b=N4sL+D2aQAeGK/ivjJT0MwPJqUGHRwycTaJdZfOE0hkno7NiAI1jXj1+/MwgDqTCXxkAcjDHVGgw+Mw8B7I571QlW2Yd81AMLDgfoy+SxNvwwFrVmNvcOJ0DackcOIaxHalANgag1Bfc8cBPtPQA/bFpvvcNSVtZBffWx3Wol48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394746; c=relaxed/simple;
	bh=kJKPqb5ITXNFMsS2LLt9HdEV0P6O3eXRMkxx5fWkKdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slMs5gnrpnh9cDAY/8ROeYGfKDMD1aLfDHt9nw7j+ddLiSnamYJJy9CG00r+NZXWDEYvWt3Hw5CbZvmbbUbTFoWBpTKhK8j17g55eOywWo2nVQRPRDqj0+2sdwHEArY8Racg4IB5Jy0lUpiZV7xcYuOnhpNvF4KgsbCOnC0GuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xtn78Rp8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-328ec26a106so490130fac.2
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758394743; x=1758999543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=Xtn78Rp8rq+zMthPi/pRMYb1l3VTbMBqsUE5uGLQEbrRP2WzhIKDfRnvL9VwMrMfOM
         V7XTAMG3xBD21ymwobDlDV0j60OKgyxZ5dVo+aVXuFa2BsJpTdEo8VX8r9UI5+KJ3OYQ
         5NXjietMB7GpEaVwpvAFTPfVh6Z3gC+v/HioE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394743; x=1758999543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=radOkJqM0bkGKj6vDcO5q64kiVrLiYHUKu13zl5H5ZjtnzVONL2tTfHF817brJpIIh
         vjx2Wic7eMh8JcC+L1s5opGG+pbN3UZ8AHgliKld3/mgb3xjIepTIMp4bKw0JRuv4h4q
         hfqvrihd46UF57OwD7kvX0vlsl/cSdI2N+mNQNRywSnXlhoGnrzbYVWbLpy8yLEQTwzC
         sjkSvscjFjJvxcA3COJrSry56G1MsbwBelnEfdSJCH0dCgAkbtwYqIebwWXzjnOJSMj1
         F1kmwSGWCdBSqPKppbhuOLiDlEHvk22wrwGJKUbb320z2rXHpumNFJ8EP+Y7NtPemRok
         es8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwaH0xLywj5heAZ5fv9pwhC+FAfcbQtNLIH7nZ65nMy//8t6h1KCejM3mQ9L9mNhHQuP9yEZb7/81ShxCoX40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX74nwiQOlTCzIvodCXbQ+/X7nNZfv2n8psdHHYNr2fj3VG51
	U05zVAaxufPqoSvxdS410BtSwAJx6c/FnqO6kbs+lPW/7oliWaq/apQReTXEqx5R5EBRC39CMq2
	vG8sWniWphU18ACoQGj7o9z1Ml7/ldlCKGQvi6hx3
X-Gm-Gg: ASbGncthT13mgb83v/JQwxan5e7HGSEmmoW0MEQ4QBA20btn9rDN8ES0Wtt2NhcoNkD
	cvyBBFH+DT3iYDGYm43fWxVZXGA8Y2undERP5W+jHHFYF+Z3XJYdJqEokp58uedEDYFoPajjtkp
	nkTQQrabFLguAZhPh3bbCMZsbmirSmJqvLPxFov6yd5tVpcroXtTPDaxCBQ5/SrPkB9jE7C7i8L
	6l+hYoaE2dk54eXtOlC/R+G7zqByy1Em/Ef1B3S
X-Google-Smtp-Source: AGHT+IEbtUOHoGxmH8+U+ohTvlhZagORiUWDUjw1ZNRWRQtq3uyJEEBBW+146XDI0TEaj7CC0DarjKctgvx9c6CKZAI=
X-Received: by 2002:a05:6808:4f6c:b0:437:b03d:9028 with SMTP id
 5614622812f47-43d6c2d5ea0mr1674830b6e.8.1758394743248; Sat, 20 Sep 2025
 11:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
 <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com> <87o6r5ac2z.fsf@gmail.com>
In-Reply-To: <87o6r5ac2z.fsf@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Sep 2025 11:58:51 -0700
X-Gm-Features: AS18NWAgq3wn2Sk2LOUvEfd7d6hzlOiiolow2BKEmFkCuGifdHV5pRX8Z7-PEW0
Message-ID: <CABi2SkUj2WoNpm6repAr0rkmQgFAmfRTYD0k=KcPUXjOd3tvhw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Xu <jeffxu@google.com>, skhan@linuxfoundation.org, 
	keescook@chromium.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Fan Wu <wufan@kernel.org>, 
	Kees Cook <kees@kernel.org>, "tweek@google.com" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhinav

Thanks for reaching out, it is great that you are interested in
Landlock and IPE use cases for executable memfd.

Adding  the latest discussion/status  that I'm aware of, related to
memfd, for reference

- Thi=C3=A9baud Weksteen (In CC)  has patch [1] for a new selinux policy
for memfd_create in [1]
- Micka=C3=ABl Sala=C3=BCn and I  discussed the security hook to block exec=
uting
memfd [2].
- Your recent patch in Landlock [3]

[1] https://lore.kernel.org/all/20250918020434.1612137-1-tweek@google.com/
[2] https://lore.kernel.org/all/20240719.sah7oeY9pha4@digikod.net/
[3] https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gmail=
.com/

Thanks
-Jeff



-Jeff

On Fri, Sep 19, 2025 at 11:10=E2=80=AFPM Abhinav Saxena <xandfury@gmail.com=
> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
> >> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote=
:
> >> > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> >> > >
> >> > > From: Jeff Xu <jeffxu@google.com>
> >> > >
> >> > > The new security_memfd_create allows lsm to check flags of
> >> > > memfd_create.
> >> > >
> >> > > The security by default system (such as chromeos) can use this
> >> > > to implement system wide lsm to allow only non-executable memfd
> >> > > being created.
> >> > >
> >> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> >> > > Reported-by: kernel test robot <lkp@intel.com>
> >> > > =E2=80=94
> >> > >  include/linux/lsm_hook_defs.h | 1 +
> >> > >  include/linux/lsm_hooks.h     | 4 ++++
> >> > >  include/linux/security.h      | 6 ++++++
> >> > >  mm/memfd.c                    | 5 +++++
> >> > >  security/security.c           | 5 +++++
> >> > >  5 files changed, 21 insertions(+)
> >> >
> >> > We typically require at least one in-tree LSM implementation to
> >> > accompany a new LSM hook.  Beyond simply providing proof that the ho=
ok
> >> > has value, it helps provide a functional example both for reviewers =
as
> >> > well as future LSM implementations.  Also, while the BPF LSM is
> >> > definitely =E2=80=9Cin-tree=E2=80=9D, its nature is such that the ac=
tual
> >> > implementation lives out-of-tree; something like SELinux, AppArmor,
> >> > Smack, etc. are much more desirable from an in-tree example
> >> > perspective.
> >>
> >> Thanks for the comments.
> >> Would that be OK if I add a new LSM in the kernel  to block executable
> >> memfd creation ?
> >
> > If you would be proposing the LSM only to meet the requirement of
> > providing an in-tree LSM example, no that would definitely *not* be
> > okay.
> >
> > Proposing a new LSM involves documenting a meaningful security model,
> > implementing it, developing tests, going through a (likely multi-step)
> > review process, and finally accepting the long term maintenance
> > responsibilities of this new LSM.  If you are proposing a new LSM
> > because you feel the current LSMs do not provide a security model
> > which meets your needs, then yes, proposing a new LSM might be a good
> > idea.  However, if you are proposing a new LSM because you don=E2=80=99=
t want
> > to learn how to add a new hook to an existing LSM, then I suspect you
> > are misguided/misinformed with the amount of work involved in
> > submitting a new LSM.
> >
> >> Alternatively,  it might be possible to add this into SELinux or
> >> landlock, it will be a larger change.
> >
> > It will be a much smaller change than submitting a new LSM, and it
> > would have infinitely more value to the community than a throw-away
> > LSM where the only use-case is getting your code merged upstream.
>
> Hi Paul/everyone!
>
> I am not sure what is the latest here. But it seems both landlock[1] and
> IPE[2] have a use case for memfd_create(2) LSM hook.
>
> I would be happy to work on the use case for such a hook for landlock.
>
> CC=E2=80=99ing maintainers for both LSMs.
>
> -Abhinav
>
> [1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@=
gmail.com/>
> [2] - <https://lore.kernel.org/linux-security-module/20250129203932.22165=
-1-wufan@kernel.org/>

