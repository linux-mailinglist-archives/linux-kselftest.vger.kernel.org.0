Return-Path: <linux-kselftest+bounces-32303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D87AA89FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 01:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C6A17308A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A8246797;
	Sun,  4 May 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqp7GXVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899A19539F
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746401155; cv=none; b=B9h06JKH+zg0bfD7Ctzf4SPmlmxq0mKs2x6LAVT7DSiQ48kG65Xbr01kT53MTxyw9+BmZ467xb83ktM+E/rK1OFSkBetb1gABvt+Nd9U7yWaoq0DJojdfczpO5eJH+tvupV38a30jclo4PaJExpZc6qNVMHEWW/wLNECIhD9IVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746401155; c=relaxed/simple;
	bh=YQlrNPWfAd0hPo2CWDN8tgD2UZHZogK0tWHcMMD3DmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMwMBWyhZQ5s5aNt39RFSmqikVEZINdRFEiecSY3RwhhqwAJXpH9ysTkRwbiYHq35a0PpYp0ikCrD6IGHbdNKuxi6NtjyBXbQwnQgWV5fx3WZUnk4iJOmGXVTVuU3RbNto5Oe+4RMzfYVjZgglNTvfdU12uDFfqFb2YN37nEbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqp7GXVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C051C4CEF9
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746401155;
	bh=YQlrNPWfAd0hPo2CWDN8tgD2UZHZogK0tWHcMMD3DmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iqp7GXVBeNYGYMVRk3GxDOEV1we/bQgWzUR7RZud2nNel2AgjcJnJCeWwsCWpAUrp
	 cYc1IBvCXBQHWX7HubULJNSCBCPYT68r/pJytUI010hEISCZ83BOsZEi0iKxWvRWPy
	 08lwQV2iBCiYHEQ6DOL/uc45kSTzJRZsbqvSYzTzj8luoGF+uw2HA2hg3dekUUEuwm
	 Q6k6CwkTXtPg3LcTJnqAwsyiC3c9gOYM1mloK6HY3PK/a40bw0tkDT0J9HfrzKUBvU
	 GbYcxcR+qdasKC2159pZ49bMVpXkoR+Figrfn1Q0dThXdPeMN9iW8vZx9xqw/pVbXQ
	 ogWYH+by0hC4g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so5904729a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 16:25:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXjWu+EtWiR0VQ3/SOnKHIzo0Y2xL85XKMqFnfBqFEyyPM7rjWE+0YBQquJ35e4+bcLZklIGnJ2SiEbTP7s34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuDdQp0Pqr2puSNbSydrOvKWqxRjeODbopefiYOhuBwdPSzW4
	BoVnfLva1Eq0otuKct86fGzL9cxUcwexAVcQZWRfIh0dPA7CBcmUfugFnou2JDr/oFh+zrXVTgC
	m+OEEgsGx64lj69NZdj+j7H7fuGDSCu3VBrF/
X-Google-Smtp-Source: AGHT+IFeHttEHnt6JGNYvUj0b4tgsDNrFFzyPvM3lBConO1ypZC65jr1D+YbzAXa36rr90WmrBbCyVZSkuAz1r58mbk=
X-Received: by 2002:a05:6402:2312:b0:5fb:18f7:459b with SMTP id
 4fb4d7f45d1cf-5fb18f7473emr1026068a12.4.1746401153666; Sun, 04 May 2025
 16:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 5 May 2025 01:25:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
X-Gm-Features: ATxdqUF-4LjdLg3QP9aQurW4StUtszW6zEg3L7LcP4VsuTxu8r7YCkYGmWYmIdo
Message-ID: <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
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
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 7:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, May 2, 2025 at 5:00=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > > This patch series introduces the Hornet LSM. The goal of Hornet is to=
 provide
> > > a signature verification mechanism for eBPF programs.
> > >
> >
> > [...]
> >
> > >
> > > References: [1]
> > > https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov=
@gmail.com/
> > > [2]
> > > https://lore.kernel.org/bpf/CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=
=3DcBzdEYbv_kg@mail.gmail.com/
> > >
> > > Change list: - v2 -> v3 - Remove any and all usage of proprietary bpf=
 APIs
> >
> > BPF APIs are not proprietary, but you cannot implement BPF program sign=
ing
> > for BPF users without aligning with the BPF maintainers and the communi=
ty.
> > Signed programs are a UAPI and a key part of how developers experience =
BPF
> > and this is not how we would like signing to be experienced by BPF user=
s.
> >
> > Some more feedback (which should be pretty obvious) but explicitly:
> >
> > * Hacks like if (current->pid =3D=3D 1) return 0; also break your threa=
t model
> >   about root being untrusted.
>
> Speaking with Blaise off-list when that change was discussed, I
> believe the intent behind that Kconfig option was simply for
> development/transition purposes, and not for any long term usage.  My
> understanding is that this is why it was a separate build time
> configuration and not something that could be toggled at runtime, e.g.
> sysctl or similar.
>
> > * You also did not take the feedback into account:
> >
> >    new =3D map->ops->map_lookup_elem(map, &key);
> >
> >   This is not okay without having the BPF maintainers aligned, the same=
 way as

[...]

>
> From what I've seen in Blaise's efforts to implement BPF signature
> validation in the upstream kernel he has been working in good faith
> and has been trying to work with the greater BPF community at each
> step along the way.  He attempted to learn from previously rejected
> attempts with his first patchset, however, that too was rejected, but
> with feedback on how he might proceed.  Blaise took that feedback and
> implemented Hornet, traveling to LSFMMBPF to present his idea to the
> BPF community, as well as the usual mailing list postings.  When there
> was feedback that certain APIs would not be permitted, despite being
> EXPORT_SYMBOL'd, Blaise made some adjustments and came back to the
> lists with an updated version.  You are obviously free to object to
> portions of Hornet, but I don't believe you can claim Blaise isn't
> trying to work with the BPF community on this effort.

Calling map->ops->map_lookup_elem wax objected to by Alexei.
This feedback was not incorporated.

>
> > So for this approach, it's a:
> >
> > Nacked-by: KP Singh <kpsingh@kernel.org>
>
> Noted.
>
> > Now if you really care about the use-case and want to work with the mai=
ntainers
> > and implement signing for the community, here's how we think it should =
be done:
> >
> > * The core signing logic and the tooling stays in BPF, something that t=
he users
> >   are already using. No new tooling.
>
> I think we need a more detailed explanation of this approach on-list.
> There has been a lot of vague guidance on BPF signature validation
> from the BPF community which I believe has partly led us into the
> situation we are in now.  If you are going to require yet another
> approach, I think we all need to see a few paragraphs on-list
> outlining the basic design.

Definitely, happy to share design / code.



- KP

>
> > * The policy decision on the effect of signing can be built into variou=
s
> >   existing LSMs. I don't think we need a new LSM for it.
> > * A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/bp=
f.h in
> >   the BPF_PROG_LOAD command:
> >
> > __aligned_u64 signature;
> > __u32 signature_size;
>
> --
> paul-moore.com

