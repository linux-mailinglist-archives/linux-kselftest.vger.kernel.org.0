Return-Path: <linux-kselftest+bounces-15852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766F959C43
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7445B263B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF64188CA4;
	Wed, 21 Aug 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8MLptxK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A87155307;
	Wed, 21 Aug 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244357; cv=none; b=SGkXojFTug5fEDffq/7T3cGBhP6uGsQzH8ctMt2wrQCIp3YYpXPtxIAJFQGjQ+dCsAzuonfA6f2WhKGiy0mjh3JnOQ5ybS8FgIh4En2hrEeDjn//AFj0mG9whRH/eVt3G8ek6GlCgoxyxNbyUKQxXBPb2BrG8zevHZUxP1trwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244357; c=relaxed/simple;
	bh=r9eOQk8Wrbg0igQUr38Qd//QX7nCzOe2ZVOo1vsBV9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLhr8pAq6RHpheTsijafuFBQE4lO/vl53PTWmUr45qfhd+KgMrXPYFVOZLzSzkE7wyLqP84vcF8svnPFR5XGntO8Bj/xP9VAJK1ySF280mEnzQDlJ38D0FikFoeeVJdKScDhiqRSc9sgdUo4vyt43WhqnZBVtwnthBJE3TQXD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8MLptxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4989C32782;
	Wed, 21 Aug 2024 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724244356;
	bh=r9eOQk8Wrbg0igQUr38Qd//QX7nCzOe2ZVOo1vsBV9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8MLptxKacB0FKbin56oUdvqI3hOJi4p3+otTum5BMIEzOcvcMIP1GpW63IL7YWKG
	 pvBVwnbcRCACjd0VG0oDWvD6/M8lbRgOO07AaKXQt4u4z7E4oAR5qfEHM+GIHXpGTM
	 nOIsq/tIRyXY7cYZe7nTVGfm26y88ufCp/WPUoPynnIeE01s9nxmLHPBeP4HdkAKql
	 saAil7czdzmlf00CuDcN/FqYuV/nk8MNKoxp0dG5yWQA/ZGlJ8XTkoriC6IqYipzoK
	 SWOzXMdjcJrnfC2CjzGbLbd3HPzzKfvsQwblDu+nOt9G2MGLVddjvQhRd4oWvnMf1M
	 +RRKk72P28p5g==
Date: Wed, 21 Aug 2024 13:45:47 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R2s/DrK5IP5IlpI8"
Content-Disposition: inline
In-Reply-To: <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
X-Cookie: You are false data.


--R2s/DrK5IP5IlpI8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 01:45:16AM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-08-21 at 01:19 +0100, Mark Brown wrote:

> > I think it's going to be strange one way or another, either you specify
> > a size that we don't currently really use or you have two things both
> > called stacks which are described differently.

> I would guess users of raw clone3 calls would be able to handle that kind=
 of
> variation.

Oh, I'm sure people could cope either way - it's more a question of
clarity and not causing people go do needless investigations to try to
figure out what's going on than anything else.

> I was just trying to figure out why there is both the pointer and size for
> normal stacks. It seems that one usage is that you don't have to worry ab=
out
> whether your arch's stack grows up or down. But otherwise, the previous c=
lone's
> didn't need the size. Before clone3 the stack size users seem to be kernel
> threads, so when they unified the infrastructure behind kernel_clone_args,
> stack_size was needed for the struct. Could it be that it just leaked to
> userspace for that reason? I don't know, but I would think a tweak to suc=
h a
> fundamental syscall should have some purposeful design behind it.

It's entirely possible it just leaked.  My own attempts to dig through
the archives haven't turned up anything on the subjecti either, it seems
to have been there from the get go and just gone in without comment.
Equally it could just be that people felt that this was a more tasteful
way of specifying stacks, or that some future use was envisioned.

> > =A0 I suppose we could call
> > a single parameter shadow_stack_pointer?=A0 Though I do note that as you
> > indicated we've been going for some time and this is the first time it
> > came up...

> Sorry for that. I looked through all the old threads expecting to find
> discussion, but couldn't find an answer. Is clone3 support a dependency f=
or arm
> shadow stacks?

Catalin didn't want to merge the arm64 support without clone3(), and
there's code dependencies as a result.  I could unpick it and reverse
the ordering so long as the arm64 maintainers are OK with that since the
overlap is in the implementation of copy_thread() and some of the
dependency patches.

--R2s/DrK5IP5IlpI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbF4XoACgkQJNaLcl1U
h9CDOAf8DpqQjrzuJ6yjpr8Urc8gQ8toLYGxub4euGdhl+eUhDDCPz3r+n1gEZkg
OnsX7WQsgWAevH8wmcKRcskvfGU1m1r8bysHt0X5ggg45OYzjBOeX5I0LaBljOdv
cv1H2HJsCvhsGe3pTMeidAFze47dya1C4DRR/RSuN+roGIgO3eF90HzQw7BT797H
QqJmYmjBt/uHKWvaTDs46C/dJ+8bfki/QP3AWwGId0rrn+OKG/n3Ee2D77PU8ghm
PFdR1maHwA53iOd9XZ1DEhkFDSk0qB6DnM27AMpeKTEE6jFRoJPEwIumCUQNoGZZ
MTrIO1FQZZubZ1a74yIZ0keI9a1aZg==
=Tde6
-----END PGP SIGNATURE-----

--R2s/DrK5IP5IlpI8--

