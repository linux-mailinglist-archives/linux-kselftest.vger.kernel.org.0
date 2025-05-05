Return-Path: <linux-kselftest+bounces-32441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DFAA9DBF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211A717D82F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983042741A6;
	Mon,  5 May 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WhgsSo9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7812701BA
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479101; cv=none; b=XrrDtONXpf7WmUKY1JnhZyawtPblQR+d0ZrGtamWQILEctBnLq08Lo05lsR2aoTiUYeunvPnhMWTmcSJg5f3HslPhaV7yIz3+uU4F5ZGH+rYiCceqgjeAOC8cMGxYLS/laUwZhTy7T4r6oTisSABLSnHLRMfqYQg4z5H5L3hjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479101; c=relaxed/simple;
	bh=pvJm4iJToWGX01vWFAWNiClNkhuZHWWKlI9oy7VPwrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0E4dXJcGEFeFnM64IqjO5kkRpQ/kSjEU7IIcCrm4mKbcc7d7DJsroJXGqIXjNGl+UgoOuaUO9kFrz7mrq1U6Yu4AG4lJ5FswVOHl4OPGUN4GlZvO7VKoKSPMGwZyrY0nFDaATFRXPZSXdM+wP7n0uaq+OMvwAJFiUoB4wtHBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WhgsSo9J; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7080dd5fe92so41026987b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746479098; x=1747083898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV6Ehr5flIzxPNkBJYbjhBPm/Nie/yPzlaQWxf1OGLY=;
        b=WhgsSo9JWV48EKUKRmgKeuu2vJsYMPLJ1pLf+ibrUGTWn2+WkRrraD+IuzYDCHdsgi
         TTDKbg3e0i/eTbdgI7l2QVK9n+kI6ObrZPtfmtNfL6qlZz7+41N8oEYLIPnbj2iALqTn
         Q/Cbc8qsYJ5YdcG1kADDtxqU59toKqXSim9JJDVAhrJ9jSOKR2EUyWklInE1QZftyxzS
         Xy5L+DZJtUBnNvNxpVf7D0wvIpluIpP8tW0iRyAtZ+KsLBR8uXQ38omd9fXF9QzLJJWM
         Jm0W5mbRYgTmCH2APZteUpOA4pIIyDAfPbaFAL4S+GSuat4CMUTYEnHGbaXEHzMdZXO3
         5wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479098; x=1747083898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV6Ehr5flIzxPNkBJYbjhBPm/Nie/yPzlaQWxf1OGLY=;
        b=mN6kKTpIKmAzmXwntrw0OqIXcoTa4lV113eD+zuQ4l2iM/2oCimwTreUD6dC7Y6pgb
         /XKA+SSmrOrE4dhwSdgh/IRGosBihqa+o1xKY6VrOKDXrPauvCgh2k4/co4PvWCpy5Iy
         ehAIcYFJmTG2GNlcQghLSUC8fGve6EjWNuB+bhDBi+Le2m2h9eSH+p7mErt22Q+g2H/m
         p6YZWhLoBZ4C0++DLMwzp6RK3gNTSlzGTTADSFeVNt+Htwks76dcRXJQW/Dfb0sOUmTo
         YRAHRpIiBzdJm5xnwt6tMhlh5cf9jjoW0ZbUs5nh6Edx3TbZqOCr2t5G/39+XqvcC9rD
         O6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXICn3k8Cw4ujYa5rhkWExeXxnv0xoGwXHqtsIuHClQGJQhTRWSQ08L7a1tWU9xsMVmOCd5iPbprDXu//af1m8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gKpbPAMNFLXQJnhfoaYRIS41mURYMdyvwxqGjsOCMFos0d2H
	1nKf7fM/g1+2k1UT5CgtpDB6C0k431BzLtAQNn4YhGi3Fr5EIeuoQnzQrX66zSa1ME5XKmODcZE
	+DjcXPRlwle08k31niawCO9tkrCGIfxPJx0a/Phclyvu8SlncrQ==
X-Gm-Gg: ASbGnctdR65aYRlcqS3tCU6DqGKne5zloSXZSN3Wk9SaJtRvy/G/+jhov58F/8Z3uOs
	T2wefdjsRuNwEQ5OK9gf5JzEXRyRXx1OZHVpBAUYh/UCUs7BQNngNCYFC5SE/JH7eNQ+06eyuJI
	ZWpsOnSEKPw+AOOosSbrTBvQ==
X-Google-Smtp-Source: AGHT+IFmAkNEdgI8Usf/OOS6czpCIUfjzjMmDrrLFeB8TbVt16spO751vhSxBgmbdO5FhYFLhIwyiyfP8SeItQ5Z+90=
X-Received: by 2002:a05:690c:368b:b0:703:c3ed:1f61 with SMTP id
 00721157ae682-708eaeef043mr127166017b3.20.1746479098491; Mon, 05 May 2025
 14:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com> <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
In-Reply-To: <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 17:04:47 -0400
X-Gm-Features: ATxdqUH7QOdmAmbomuCBMV4FUrVw8a-HbJeWUtKQ1wX8nnex6ppuCCrqNPrIXY8
Message-ID: <CAHC9VhRwpvQQyMmFTeiQaos0+yJDkuCkt03QcYdnsxUvBXAtVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James.Bottomley@hansenpartnership.com, 
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
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:41=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, May 5, 2025 at 7:30=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > KP Singh <kpsingh@kernel.org> writes:
> >
> > [...]
> >
> > > Now if you really care about the use-case and want to work with the m=
aintainers
> > > and implement signing for the community, here's how we think it shoul=
d be done:
> > >
> > > * The core signing logic and the tooling stays in BPF, something that=
 the users
> > >   are already using. No new tooling.
> > > * The policy decision on the effect of signing can be built into vari=
ous
> > >   existing LSMs. I don't think we need a new LSM for it.
> > > * A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/=
bpf.h in
> > >   the BPF_PROG_LOAD command:
> > >
> > > __aligned_u64 signature;
> > > __u32 signature_size;
> >
> > I think having some actual details on the various parties' requirements
> > here would be helpful. KP, I do look forward to seeing your design;
> > however, having code signing proposals where the capabilities are
> > dictated from above and any dissent is dismissed as "you're doing it
> > wrong" isn't going to be helpful to anyone that needs to use this in
> > practice.
>
> Please don't misrepresent the facts ...

KP, I believe the most constructive thing at this point is to share
your design idea with this thread as previously requested so everyone
can review it.  We can continue to argue about how we got to where we
are at if you like, but that isn't likely to help us move towards a
solution.  If you are unable to share your design idea, either in a
couple of paragraphs or in some form of PoC, please let us know.

--=20
paul-moore.com

