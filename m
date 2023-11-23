Return-Path: <linux-kselftest+bounces-486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426117F658A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CCDB20FF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36828405E8;
	Thu, 23 Nov 2023 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY1lQexw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692D405E5;
	Thu, 23 Nov 2023 17:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27BCC433CC;
	Thu, 23 Nov 2023 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700760942;
	bh=/73LHzEUuMC+UbtJ5BdZY8QbIJypb3dNXKHEGBhyUfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY1lQexwEHntktudEDLo2U/ya2/15YkepNxQSkua05q8GbSv6SrrINT35F3cF/9SN
	 nVVuTeTKuFby1C2Q2H9+GAtGpc3HmEwhDoSMRjdrnDZ7qd8YIV7PXYL7d3b0tOSPW0
	 y7mw/lZsUVYDLUtrAv1a3ClM+o5NKYp0Gprp7NcVJrSepRcjEsTppbDPIu4rYAqPhq
	 CPn+qYP6jrRFi7gx+yV6h+UfDlNYqR+RSiEZM4yd6J+0quh157aUnC+PPHDcVK7GKV
	 v6z9a7G+dQuNhkhiiJDlH3d4BufRFhu6hioME38hjy6Ql6uspZzj41LliW1R+CMLeN
	 S/BNLPWNqi4TQ==
Date: Thu, 23 Nov 2023 17:35:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZV+NamY31GyANEe/@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
 <20231123-derivate-freikarte-6de8984caf85@brauner>
 <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
 <20231123-ausziehen-harpune-d020d47f964c@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CndIlGpPnv8RlVC+"
Content-Disposition: inline
In-Reply-To: <20231123-ausziehen-harpune-d020d47f964c@brauner>
X-Cookie: Slow day.  Practice crawling.


--CndIlGpPnv8RlVC+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 05:33:05PM +0100, Christian Brauner wrote:
> On Thu, Nov 23, 2023 at 12:17:19PM +0000, Mark Brown wrote:

> > > > +		if (clone_flags & CLONE_VFORK) {
> > > > +			shstk->base = 0;
> > > > +			shstk->size = 0;
> > > > +			return 0;
> > > > +		}

> > > Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
> > > unset? In general, a comment or explanation on the interaction between
> > > CLONE_VFORK and shadow_stack_size would be helpful.

> > This is the existing implicit behaviour that clone() has, it's current
> > ABI for x86.  The intent is that if the user has explicitly configured a
> > shadow stack then we just do whatever they asked us to do, if they

> So what I'm asking is: if the calling process is suspended until the
> child exits or exec's does it make sense for the child to even get a
> shadow stack? I don't know the answer which is why I'm asking.

We were initially doing some suppression of stack creation based on the
flags but based on prior discussion we decided it wasn't worth it.
There was some question about corner cases (IIRC the main one was
posix_spawn()), but generally the thinking here was that since userspace
explicitly asked for the shadow stack in the worst case it'll just be
inefficient and userspace can fix things by just not doing that.  If we
just create the shadow stack whenever it's requested then it makes the
kernel side handling really simple to implement/verify and we don't have
to worry about having missed any use cases with combinations of flags
that we've not anticipated.

--CndIlGpPnv8RlVC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfjWoACgkQJNaLcl1U
h9AaCAf9ESVElI0jUJmzKPT+rOMQcmn2utfrXnIajA0L2w8qephayJtaRS/cumi6
x79EY3sWCc3/7DU8ZokCs+1hlLe2YXBcHChU9mPSM5r910muGEmRFmDNYvXT0MDx
zTAxwD1JezQm/xx+eao6qAXcndvSWtQ07KRkY+7kGh48MaBu6ea7ZHGLX36KLU3D
FGZ4pwQjZAEZniikVAMKqkMiZgPWLaklyuu86hpWa1m5m9t6j3O97Zc7zsT9EhvO
+L9dshnSTGK00sGneVJrznPPUm6w+9xYsAO8YNFfVMDSEeezBH3nKHxDGaGONOyP
jacIFPP64N2TZMtsNbsQpUCrFXE4DQ==
=+O4D
-----END PGP SIGNATURE-----

--CndIlGpPnv8RlVC+--

