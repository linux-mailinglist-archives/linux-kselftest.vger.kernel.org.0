Return-Path: <linux-kselftest+bounces-445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCA7F4580
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 13:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE2DB20E63
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818A4BABA;
	Wed, 22 Nov 2023 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajMv/8of"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBF1842;
	Wed, 22 Nov 2023 12:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBABC433C8;
	Wed, 22 Nov 2023 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700655131;
	bh=iVQBzIzK7TxLOKrWn5+Ou4i1FBXcoHbbx+acnHa4QNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajMv/8ofmRSNKM3bJTd+9bbZVEKj5K1JrkX7IBsJnOH9FvaqEjUh4H5jdmUkA976w
	 IglRHzV7Q11jclgCgxfmR501hGWeBtvOvsJ6nD/6DhRi/4ir7geffe5JS26eO2+Tp6
	 S3frVpBKDPY3mQI+63bIKpHhN65P1V3TkUlqESaN+lL4PYGI8N27wadtowubOjUzgj
	 sfvcTTiwrrHju8OWPl5vd0OJbj0WMzxzjwjKiwYAkgcdBG2fuLAt8R6DEWgbMLsSHX
	 wkt73ozbCoBb5s17S+VqnD+980NRJKqfwDI/oWeVwgsarItcLrBWFZ85STaLLZoXgP
	 wyC22X70w872A==
Date: Wed, 22 Nov 2023 12:12:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
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
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 5/5] kselftest/clone3: Test shadow stack support
Message-ID: <ZV3wF7s5FcCFo6Y4@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-5-a7b8ed3e2acc@kernel.org>
 <20231122111949.GB364395@mutt>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H2AvtRsbqhN82Vd4"
Content-Disposition: inline
In-Reply-To: <20231122111949.GB364395@mutt>
X-Cookie: Slow day.  Practice crawling.


--H2AvtRsbqhN82Vd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 12:19:49PM +0100, Anders Roxell wrote:
> On 2023-11-20 23:54, Mark Brown wrote:

> > +#ifndef ENABLE_SHADOW_STACK

> Should this be ENABLED_SHADOW_STACK ?

Yes, I already fixed this locally.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--H2AvtRsbqhN82Vd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd8BYACgkQJNaLcl1U
h9Dbqgf/YMu7VRrKiQN4c6ZBSkSJoP0xBkEU3lInWd4tAPb/uece83Xl/sSygUST
M3YDuFCOaStd9HQz+wrbJESATOEJBcLDzJzInhiLDF/EIUDKpFQZO1rzgcbfok4U
+/hvGXUMbnnK5rtgRBBYFayvAHye1MmV9wjUWpvKC/TvsUsttvIEwWd01nqHR1ix
jPS395n0ONlc6+ZWJFNxwhfvo3osJ1w8yYVCrUtGrcs0/Dk0u/B1pxtjOSPM7ydG
aGuBLcECXKhVzsC6fpLr3i9TMI7wbK9G1ANwwQUKAKMOAnSAM/QrvcRA720xVfOl
dJ8S8nZYrlUUE9SAk7wtssITkz6dTA==
=ydHQ
-----END PGP SIGNATURE-----

--H2AvtRsbqhN82Vd4--

