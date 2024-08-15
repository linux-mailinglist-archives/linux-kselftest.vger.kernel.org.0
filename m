Return-Path: <linux-kselftest+bounces-15408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5B95344C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38BDB2920C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4381A08DB;
	Thu, 15 Aug 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaBif9Ud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222519DF92;
	Thu, 15 Aug 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731863; cv=none; b=BBtsrJNGq8On+1yyYEz7fJkyKDXUehC2W1I12Yv4z8zmcC/o0/78V2lh/HRTjgXwhr174UQHjHM+c/XPxKXIe6rNK6YBOPorE5CVK7wRmQZfv5Gu6VDBq0MShwGGJCIWRInHxt+ysP5tEem8mGIbXR4a+vN0pnNnfo2qHAMU1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731863; c=relaxed/simple;
	bh=oWFM9hMu5UM6J5ZKg5Hx8ZMhLMm107p2yHuAWNRa3m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4a2FHG/U0B0AlgzCiqPO9xUE0c2wUbG4qPupkaIJg/bGH3kBXo1vpU9hlqmDQjO7Dn6CWAsZKnc/u53kk8dkmZljE+Pd5EJQd3LqSTzUw0ntyOwMAotIK64OOkoiofIUfAlX83ICgA5DKArfwLm/awyzM2EG2PzzrVaEDLpLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaBif9Ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08637C4AF0A;
	Thu, 15 Aug 2024 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723731862;
	bh=oWFM9hMu5UM6J5ZKg5Hx8ZMhLMm107p2yHuAWNRa3m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaBif9UdXbtREpa11t2MJuTKMDptGTnf5IWTXQcPry88RlerBT0sgLpTwT8zhu3OY
	 oTvhVFrLdDsqhyyB7v46LqXYKEtpbuSa3iE1Og/WdougSOjZUk/fYXwPJGA2To7FqZ
	 sWlzD9DmbQUJJBOY7aqqLk2VyVlVuWDsa2+EOmZIcb4osahXiuPb23Z3pcw1xnktNr
	 30hLn3uHf7lE/8TAWiwGCUL0O5QyRQAib+VGIi5BJ8yuKHaHEStIaGjRJ4/s9sFhln
	 vhS7rfEf8XO7eKZl1nLTV/IEbpvScTLOhtVLEOs5KoMEBT+nEQwstAwS3cOWDyEmve
	 +qED5TyWDjt2Q==
Date: Thu, 15 Aug 2024 15:24:12 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <3e3570b8-f138-4373-94b8-b471419bbf11@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rf75a+d8nN1mvn3I"
Content-Disposition: inline
In-Reply-To: <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
X-Cookie: -- Owen Meredith


--Rf75a+d8nN1mvn3I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:18:23AM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-08-08 at 09:15 +0100, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0ssp =3D args->shadow_stack + args->shadow_stack_s=
ize;
> > +=A0=A0=A0=A0=A0=A0=A0addr =3D ssp - SS_FRAME_SIZE;
> > +=A0=A0=A0=A0=A0=A0=A0expected =3D ssp | BIT(0);

> > +=A0=A0=A0=A0=A0=A0=A0mm =3D get_task_mm(t);
> > +=A0=A0=A0=A0=A0=A0=A0if (!mm)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EFAULT;

> We could check that the VMA is shadow stack here. I'm not sure what could=
 go
> wrong though. If you point it to RW memory it could start the thread with=
 that
> as a shadow stack and just blow up at the first call. It might be nicer t=
o fail
> earlier though.

Sure, I wasn't doing anything since like you say the new thread will
fail anyway but we can do the check.  As you point out below it'll close
down the possibility of writing to memory.

> > +=A0=A0=A0=A0=A0=A0=A0/* This should really be an atomic cmpxchg.=A0 It=
 is not. */
> > +=A0=A0=A0=A0=A0=A0=A0if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 FOLL_FORCE) !=3D sizeof(val))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (val !=3D expected)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;
> > +=A0=A0=A0=A0=A0=A0=A0val =3D 0;

> After a token is consumed normally, it doesn't set it to zero. Instead it=
 sets
> it to a "previous-ssp token". I don't think we actually want to do that h=
ere
> though because it involves the old SSP, which doesn't really apply in thi=
s case.
> I don't see any problem with zero, but was there any special thinking beh=
ind it?

I wasn't aware of the x86 behaviour for pivots here, 0 was just a
default thing to choose for an invalid value.  arm64 will also leave
a value on the outgoing stack as a product of the two step pivots we
have but it's not really something you'd look for.

> > +=A0=A0=A0=A0=A0=A0=A0if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 FOLL_FORCE | FOLL_WRITE) !=3D sizeof(val))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out;

> The GUPs still seem a bit unfortunate for a couple reasons:
>  - We could do a CMPXCHG version and are just not (I see ARM has identica=
l code
> in gcs_consume_token()). It's not the only race like this though FWIW.
>  - I *think* this is the only unprivileged FOLL_FORCE that can write to t=
he
> current process in the kernel. As is, it could be used on normal RO mappi=
ngs, at
> least in a limited way. Maybe another point for the VMA check. We'd want =
to
> check that it is normal shadow stack?
>  - Lingering doubts about the wisdom of doing GUPs during task creation.

> I don't think they are show stoppers, but the VMA check would be nice to =
have in
> the first upstream support.

The check you suggest for shadow stack memory should avoid abuse of the
FOLL_FORCE at least.  It'd be a bit narrow, you'd only be able to
overwrite a value where we managed to read a valid token, but it's
there.

> > +static void shstk_post_fork(struct task_struct *p,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct kernel_clone_args *args)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0if (!IS_ENABLED(CONFIG_ARCH_HAS_USER_SHADOW_STACK=
))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!args->shadow_stack)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (arch_shstk_post_fork(p, args) !=3D 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0force_sig_fault_to_task(S=
IGSEGV, SEGV_CPERR, NULL, p);
> > +}

> Hmm, is this forcing the signal on the new task, which is set up on a user
> provided shadow stack that failed the token check? It would handle the si=
gnal
> with an arbitrary SSP then I think. We should probably fail the clone cal=
l in
> the parent instead, which can be done by doing the work in copy_process()=
=2E Do

One thing I was thinking when writing this was that I wanted to make it
possible to implement the check in the vDSO if there's any architectures
that could do so, avoiding any need to GUP, but I can't see that that's
actually been possible.

> you see a problem with doing it at the end of copy_process()? I don't kno=
w if
> there could be ordering constraints.

I was concerned when I was writing the code about ordring constraints,
but I did revise what the code was doing several times and as I was
saying in reply to Catalin I'm no longer sure those apply.

--Rf75a+d8nN1mvn3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+D4sACgkQJNaLcl1U
h9BTdAf9GZtUARmVLIt9R/bsU7tcZIAMeU6tc+dWKGy+SUT/uCod0ZgF63tGvD6F
6TpHq1piVctZtKejTOEJBeOdgGqlO2D57o+nKyucCfzQGf+GsDO7RfqPmbEtTOUx
i6CuIiF5FLeR8iQA9h6LXqF3k1m4qfupN8Qw8oIjeZh1Y/DVwhLbn0AiPwE2uIIy
bkBbDcTt9ULonqH8VoVE0nR370gqtLyz9wS06HbwOSpLXQRiILFbvw4g2rre5LKu
X/6TVOwCqa0xO8lhUXPkVCVmWrNxHvZAjeuFUS1ZWcOLKcDNr1mVdrPjK9OAckbY
S7l+1L1FnN5QZlndcPRc3YqOeUM5rA==
=FCea
-----END PGP SIGNATURE-----

--Rf75a+d8nN1mvn3I--

