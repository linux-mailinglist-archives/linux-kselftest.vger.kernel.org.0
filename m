Return-Path: <linux-kselftest+bounces-12253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267590F365
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08201F250DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40935158853;
	Wed, 19 Jun 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Deuzf+T7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917B158206
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812160; cv=none; b=gqfwfta2u12uTVMfgodPsD5UBlDtjS5JTZH4Snc31u2s5Hfuu6KYz3/XWTYOmE4VvfSnkeobbaYLxrLfbwbLnC+Ypjgx7Yj9IE9nSwNJZaM7dnbK8f2w3VBt2G7uvLW6X1Gtri6jZ8sCvoWNGeO8/GHS3X00yXPQhadhc0wMS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812160; c=relaxed/simple;
	bh=cSH93zHXkK5myzncS0R9U3Eonp7whM/bFDFKKdLoqKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b259tJLhzN3VbbMzrffVAvtylkd7VyQhP08dVRDV35ExKQJWDMQGMbgnyvrCLRz1UTI10frhfNuKj42X7cwNEW0kwS42BJSdtU1vFQfpVbsGqGZfzewdwsTm/Kz3Ll2auVnVhI+At+1Oe7KVhXlb9mSpb3tMGO65MT+MfxSmaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Deuzf+T7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6312f1f83d9so51284697b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718812157; x=1719416957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A3V41ThbwHIAGZpAhL1w9y7K8p24jvNIlupY7BQNOY=;
        b=Deuzf+T7eIoBmSjD0usGJ8i1x1VH9BioooixvPYb5R5hoaZaXI0MekCU7r/i0D31Sa
         ZjAc8jE/T4Em5onVaGSWln4Ds5DiMatRYi7HpFN+oFqyDgbaISxht2YO8VtPfr85MeEB
         oTs8ew+/Sf5VZsFdGKZe8GLudEPvrxrOFEUG3IuaRK/zFpiMhoF44PMocckPFcbB/rBL
         t7dFYaoLU3Gt29BgTW0SLHOzBPgp1ga7J3wzPZiOO9KqhSRgpwvwD63KQ8k+L09P9UOY
         4bNKDTs0r2yZgP4g3XnOae5yXnHYjfMKGDpMpqUn8rooCPqPM1p2O31BENaO19Q8RNKt
         m4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812157; x=1719416957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A3V41ThbwHIAGZpAhL1w9y7K8p24jvNIlupY7BQNOY=;
        b=FGOk5Zdg4XAoYQcvqP7es+5fYnYyvqRVohe3y3kcEltuPBO4zsAc7XReE4K+dWdzM2
         DuhjtlBn90ekp61qQe5KY/XEpTs0tZjyKMAWcy2bW9PvOFjD5G1lZxK5bnfHI1TqfMrB
         8zPj4jElqoK06kDBz8D/+294GmaZ8kt+NYV6y6HYWbHtP2DCYpXGUj9mpefvaxGiBlpY
         /VMEpEOIWd6ogndlb/rCB1iKAGuR0EY+65ZY8QDOxobYwNaMILnaEA2Ly5jt+8x13TRg
         K8/z2MUbAO7gXBcxloDinojXCfszDXZH731/0k2kszU1hg1MmLnkJQUZ8ZF+RyBCPxs3
         xzqw==
X-Forwarded-Encrypted: i=1; AJvYcCXXOs/zEiWNyiE6HypyzaZcKUY9OgB6t30gX++kntC4sy3BOhZCv/LpDjFhiYrYx404+qDSx4xpqFWg+BM/D4HeI5ercqlgZM4qXF9QVtKx
X-Gm-Message-State: AOJu0YzTUPZZ+A9eEjxPisX4oSH2p72lFjwgOHya7Q1rV5sKrrs7k7ky
	+IOQ3JZ24ihtp1T/cJCWAmGKuZaJO8O3mMuvBClVvRjfaW1g/iG6p98c5ZVhN9bdQ/cC3X6QcSX
	gOKXRNvL2qTY2VX+3COJMbVdoRoHIsM4CegVH
X-Google-Smtp-Source: AGHT+IEkDQP5qZ6Yrjj3uYAUPWx122jAV/ve6smoTK2csXSUiZ3XrnUftHl2q2TGjzjXyIgjKZD8k1vF8LzOBOY22t0=
X-Received: by 2002:a81:84c5:0:b0:62c:e6c0:e887 with SMTP id
 00721157ae682-63a8d72f60bmr34069987b3.9.1718812157336; Wed, 19 Jun 2024
 08:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com> <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
In-Reply-To: <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jun 2024 11:49:06 -0400
Message-ID: <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Integrity detection and protection has long been a desirable feature,=
 to
> > > reach a large user base and mitigate the risk of flaws in the softwar=
e
> > > and attacks.
> > >
> > > However, while solutions exist, they struggle to reach the large user
> > > base, due to requiring higher than desired constraints on performance=
,
> > > flexibility and configurability, that only security conscious people =
are
> > > willing to accept.
> > >
> > > This is where the new digest_cache LSM comes into play, it offers
> > > additional support for new and existing integrity solutions, to make
> > > them faster and easier to deploy.
> > >
> > > The full documentation with the motivation and the solution details c=
an be
> > > found in patch 14.
> > >
> > > The IMA integration patch set will be introduced separately. Also a P=
oC
> > > based on the current version of IPE can be provided.
> >
> > I'm not sure we want to implement a cache as a LSM.  I'm sure it would
> > work, but historically LSMs have provided some form of access control,
> > measurement, or other traditional security service.  A digest cache,
> > while potentially useful for a variety of security related
> > applications, is not a security service by itself, it is simply a file
> > digest storage mechanism.
>
> Uhm, currently the digest_cache LSM is heavily based on the LSM
> infrastructure:

I understand that, but as I said previously, I don't believe that we
want to support a LSM which exists solely to provide a file digest
cache.  LSMs should be based around the idea of some type of access
control, security monitoring, etc.

Including a file digest cache in IMA, or implementing it as a
standalone piece of kernel functionality, are still options.  If you
want to pursue this, I would suggest that including the digest cache
as part of IMA would be the easier of the two options; if it proves to
be generally useful outside of IMA, it can always be abstracted out to
a general kernel module/subsystem.

--=20
paul-moore.com

