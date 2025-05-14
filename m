Return-Path: <linux-kselftest+bounces-32961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED6AB74B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438568C3B96
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B267289839;
	Wed, 14 May 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GStGUKmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2D28981D
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248517; cv=none; b=BK9JiUORl79PNRWx8jJwqm/12oJACXBfQa5LGdN/JErj6/F5mAuuFObEJlrcRkQFPkSQ2ZEZrO6ZgI1TufpAMCdeC079egYhwpyLnvO/gmFDtp3TqNIGNIjvCpY3YRnktTB1o1rpQe0DcL7LadEM/47XJz2LQD+dsdJ2cXrTaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248517; c=relaxed/simple;
	bh=1dL3jkRxFC0P91egx6YqWf3eBdBVV0GfaxQZDGn2glA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPinDklVP/0r8QHa3+E//SI0ohdAHMRQP7VKsu53baAhIei+0hVwTXkB3CDp14GBbqlZh9S2yKoqlxA2qeqjogO9agff5Kf1Hzr8lHZcjnxQWkf0zUknHdhaOHV1SZQOUiFC/CGJhpQ4Lo22kE8vCgIdVcPQMUNMLXYpQXWHzIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GStGUKmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E01C4CEF6
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747248517;
	bh=1dL3jkRxFC0P91egx6YqWf3eBdBVV0GfaxQZDGn2glA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GStGUKmjR+wAEwFb7qQoXWXDn5oorfkJXJjv5IGvbgDKZVxT/xxALUEcqh6R2uqM8
	 /3FzdzDdGGZGmHaLC46ao8CwkwU/BQThUbo4xXeYc6JEa+hqLvFLh/mNuVSUrvSxnU
	 H+S53I6QMpLeYY02s0O9gJCHo5l5oi/z9uhRo+dg98/s+CPBZjgGjKb9bRuzN9M9iD
	 SgTFDS8bipCpPeU3vB/j1ZSUDjgm2yCewWOQhQJZkQ/bTBipXfmgbg29p0cqho9qUH
	 S96yR26jnoxhyyGfgLQlTIDAmfChYoSYUFMfNB09zdK4JonKv25g1U/M0MXEK04+oI
	 HTCXC+/KcjEdA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso299916a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 11:48:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsopoyuPwMZq0JY1z3Zqf8ODajaJzItEJJbaoRBoBAJ5/xr1Uj33xnWtt0IrYe/I+OPaQEZ2kl6/tNeIWrlpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdgxatPpBUatuBufQtZaV+4c6GGR7wSjHEIlTUQiHAqTJoR0p
	U4AlDQlTi7yx3utTKaBxbspjne6/uiw5+40Nv5CRX40mpdcz1Fn6nsJtLgZ5ogwmwQ6rFeLqITQ
	0RiDncfMGIGR15qAHdzIbIq++StUci69kkGDA
X-Google-Smtp-Source: AGHT+IEwYBrqLp5B8yM7DCtv9E2xaKltpmN2IE70cuY0GgkncCn02p6VNhOoZ0q8F3xgtHCoLYzieRnXkf+m1JsA3pw=
X-Received: by 2002:a05:6402:2709:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5ff989141c5mr3783098a12.22.1747248514758; Wed, 14 May 2025
 11:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com> <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
In-Reply-To: <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 14 May 2025 20:48:23 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
X-Gm-Features: AX0GCFuIZdNpfAM0OCZ1PfMQ_hYGIe9IvTF-jFPpzRbhWO4tNX6gFXEj5lMCve4
Message-ID: <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:06=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sat, May 10, 2025 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >
>
> ...
>
> > The signature check in the verifier (during BPF_PROG_LOAD):
> >
> >     verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
> > sig_from_bpf_attr, =E2=80=A6);
>
> I think we still need to clarify the authorization aspect of your
> proposed design.
>
> Working under the assumption that the core BPF kernel code doesn't
> want to enforce any restrictions, or at least as few as possible, I'm

The assumption is not true, I should have clarified it in the original
design. With the UAPI / bpf_attr the bpf syscall is simply denied if
the signature does not verify, so we don't need any LSM logic for
this. There is really no point in continuing as signature verification
is a part of the API contract when the user passes the sig, keyring in
the bpf syscall.

Also, since we have a solid grasp on the design and its implementation
being contained, it will be much simpler for us to actually implement
the patches. We will keep you posted.

- KP

> expecting that the BPF kernel code would want to adopt an "allow all"
> policy when it comes to authorizing signed and unsigned BPF programs,
> delegating any additional restrictions to the LSM.  With that in mind
> I think we need to agree on a way for the BPF verifier to indicate
> that it has verified the signature is correct to the LSM, and we need
> a new LSM hook which runs *after* the verifier so that it can inspect
> the results of the signature verification.  While it might be tempting
> to relocate the existing security_bpf_prog_load() hook, I believe it
> makes sense to leave that hook before the verifier for those LSMs that
> wish control access prior to the verifier's inspection using criteria
> other than signatures.
>
> With respect to the LSM hook, since it appears that the signature is
> going to be included in the bpf_attr struct, and I'm *guessing* the
> best way for the verifier to indicate the result of the signature
> verification is via a field inside bpf_prog_aux, this means the hook
> could look something like this:
>
>   int security_bpf_prog_verified(bpf_prog, bpf_attr);
>
> ... and be called immediately after bpf_check() in bpf_prog_load().
> As far as the new field in bpf_prog_aux is concerned, I think we can
> probably start off with a simple bool to indicate whether a signature
> was verified or not, with an understanding that we can move to a
> richer construct in the future if we find it necessary.  Neither of
> these are directly visible to userspace so we have the ability to
> start simple and modify as needed.
>
> Does this sound reasonable to everyone?  Does anyone have any other
> thoughts on the authorization aspect of BPF signature verification?
>
> --
> paul-moore.com

