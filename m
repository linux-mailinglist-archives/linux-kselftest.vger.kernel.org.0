Return-Path: <linux-kselftest+bounces-41505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74569B57F3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29011885D37
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956AF32F77B;
	Mon, 15 Sep 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnc69pfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C52EF665;
	Mon, 15 Sep 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947096; cv=none; b=cLvCIapnwbFq0XRuUAEHY2cDaJJ1eNMmMKVKk6+1nTBXmU/wRO3OqRsV4IqhR5fmU1SRbvGJ9rVkAV258vkbROUC/XyP3Y0u2LwML5lzcP6WGuw6XOKuO+vbvtyr5sa74mKPDnaEts+UZSg6Ms0vLKzc7AE0l2VI9jEE2SsouFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947096; c=relaxed/simple;
	bh=pIPqBrpi6MCVwMxuEkfeQmtM9LqFS/6HjfKsrZh1VkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPnNqzbt9SkaaOEFeWexNow6Bll48uRsDsddyaTJu1CUu5LzuvauvHHHKpPL397CQV+CHHl+mvvFTyDGLhW11nX8j+zTFuNFsDAZviHpzUfGFJxK2Biht98yRE8e2b/Ot/bU6DxcXBUyLXopF8js+GwpudAlTmXz2YLNINKu0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnc69pfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C67CC4CEF7;
	Mon, 15 Sep 2025 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947095;
	bh=pIPqBrpi6MCVwMxuEkfeQmtM9LqFS/6HjfKsrZh1VkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnc69pfOTZdWuY3E8AkUd8Lzpp7Qdqfo4oKdfCEU0xZy7mV4RJhGWjH0NskW5XOy1
	 J8wxprg+R6tn42L/tvS/avghdo9AyXCAVI9L/8RiVzSU1Nb2iWA1hSs/KGpE34W7ZI
	 fuPvMbV/VgWBBpDu7URG1ofAt7Zz5aBzdr/vfjnD2FqcC9a9JL77EWPrdu9Ul469m5
	 Dq/Ud7A08QfpZYvBkqbAQZBvkQ/BTQjI13zm18f/eRp5hxZ8ZzioSjU31gv1daOHW3
	 qOo2zdaSE2Qyvf0kNJE8bKlTeGstwYZ5I/LvoYF4p1xkanognWWDQnHgKn0VYAbRSp
	 Jo7PLqkXloFrg==
Date: Mon, 15 Sep 2025 15:38:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
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
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <be4e8f7e-fcc8-4e71-a594-7c3c30e645a5@sirena.org.uk>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <20250905-nutria-befund-2f3e92003734@brauner>
 <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
 <202509050900.8A01B1E6@keescook>
 <8caf310a-7179-4d4f-be73-2e25496a915f@sirena.org.uk>
 <20250915-aneignen-notdienst-c901d4b6df24@brauner>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A7e0Nx686JhSOAAC"
Content-Disposition: inline
In-Reply-To: <20250915-aneignen-notdienst-c901d4b6df24@brauner>
X-Cookie: Use a pun, go to jail.


--A7e0Nx686JhSOAAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2025 at 04:29:41PM +0200, Christian Brauner wrote:
> On Fri, Sep 05, 2025 at 05:02:33PM +0100, Mark Brown wrote:
> > On Fri, Sep 05, 2025 at 09:00:51AM -0700, Kees Cook wrote:

> > > Bike shed: shstk_token?

> > That also works and is fine by me, probably better than my idea.

> Can you do a quick resend based on kernel-6.18.clone3?
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=kernel-6.18.clone3

No problem, should be something later today.

--A7e0Nx686JhSOAAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjIJM8ACgkQJNaLcl1U
h9BTUwf6Ai07eNxxiditEa0W7VqcpeltEDfn/D2mJxi8LCDtJm2AtLIKi9eFbpg+
ZNiDYgPG0rTFtGS0S8o1m0ljoMnBLd5DlPrgMfNSFWu4oxU9sDuxa3bg+0MbnK5M
OCc2PjWBDZROanoP40ErDVZp1T/Sk1sXBUuBYbUK7AuURFx3BGlokH9eEbgCm7qH
5v4+t/7I7jf2Sy+3M1B/u6dx4meJV7Bs9aFJ4L/ZHl+KCYe19GMVLTzZ1EDvEqcS
QF4Wlr8vG9ELcpe0gAoguDQfACwz7JKgI9PNaTiELG6EeBi79w0tzTZxlG7FwVUd
4ny0uuqZmfbrJQs+aRLu4x0C/Fva/A==
=quae
-----END PGP SIGNATURE-----

--A7e0Nx686JhSOAAC--

