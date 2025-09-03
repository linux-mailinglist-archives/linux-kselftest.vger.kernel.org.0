Return-Path: <linux-kselftest+bounces-40682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5AB41AEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128361637EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826427146D;
	Wed,  3 Sep 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLOjMkmo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB691217F2E;
	Wed,  3 Sep 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893675; cv=none; b=Vt3ITliL45kxyxbpltW6KxVrQcnSCu3Ebu0/ItWKdJ45zvPqthSUJw6fKahnmq1UaXgdEZfLEjgrFxqgxzDH+NKi5ALhez9I77LjTvFG4jXQqZrojQS9JehNVRQ1h61Iu8mu3biNCNLv2vHNjYtxzaapvAthudJ/+vbV79jk/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893675; c=relaxed/simple;
	bh=B2Q577TjWIcrbRtvx74l8SXwGWVA4w1sbot6JtJZjS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIafrF+4nL3sd44KNkTx0H525p0amga3cYzx4ZfiHxOo1DbB22wmtKco9AZWW1SdpbyFmBq+mlY84j8LIt5QWUVe/9ImIZnhK5VZrBJdRy6ixKIrp4IrsInEDE1svgWa78jj9yg1Ve6KCLJz0IlOXqboa5rGEgBiJCRTFTFddOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLOjMkmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4474C4CEF0;
	Wed,  3 Sep 2025 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756893674;
	bh=B2Q577TjWIcrbRtvx74l8SXwGWVA4w1sbot6JtJZjS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLOjMkmo/owD/Budlyh5wYJThLnMn6Oc+mNBx/6h+lMaxJAhXK2YtKvZ/Qx9xVVvt
	 iT94G7hLxfaZPGa1ROxPEc0G7Jo5NG3P7olkLPb1aBKXr9XC6cBBl2UQw5xT2OKo4f
	 uNwC4RQwJz+ibnbIbs6cqzyowpYopCL5Tg4Dk7aWZjtXFw4E8hmG1kFQnzkFq8hrpg
	 mzfsNRX8GE4EN+ue4nnPV6rVwXbKmlHlTBv/nZqXFEdTGieij3Z+Kqw/mCXjujf4fC
	 cekee4TG2gdT2sjdWRJSvyqehMrQ1sjrNlGIiPAHIPDOHCdj+zqfYV6LXUoYFSCEMD
	 qbZ2bd3kNWKLQ==
Date: Wed, 3 Sep 2025 11:01:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
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
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <734e4c2c-a478-4019-86f7-4965c2b042e1@sirena.org.uk>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <aLdbT67auUpaOj2T@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vEWHDJml80AW6hw"
Content-Disposition: inline
In-Reply-To: <aLdbT67auUpaOj2T@arm.com>
X-Cookie: You were s'posed to laugh!


--9vEWHDJml80AW6hw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 10:02:07PM +0100, Catalin Marinas wrote:
> On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:

> > +	mm = get_task_mm(p);
> > +	if (!mm)
> > +		return -EFAULT;

> In theory, I don't think we need the get_task_mm() -> mmget() since
> copy_mm() early on already did this and the task can't disappear from
> underneath while we are creating it.

mmget() will only have been done in the CLONE_VM case, if we're in the
!CLONE_VM case we do a dup_mm() but that also returns with a reference.
I didn't know if people would be happier with the reference clearly
taken by the code using things or not, the general pattern is that
whenever we're doing anything with remote VMs we take a reference.

> > +	mmap_read_lock(mm);
> > +
> > +	addr = untagged_addr_remote(mm, args->shadow_stack_token);
> > +	page = get_user_page_vma_remote(mm, addr, FOLL_FORCE | FOLL_WRITE,
> > +					&vma);

> However, I wonder whether it makes sense to use the remote mm access
> here at all. Does this code ever run without CLONE_VM? If not, this is
> all done within the current mm context.

Yes, userspace can select if it wants CLONE_VM or not so we should
handle that case.  We discussed this on prior versions and we felt that
while we couldn't immediately see the use case for !CLONE_VM there
wasn't a good reason to restrict the creativity of userspace developers,
and given that you can specify the regular stack in these cases it seems
logical that you'd also be able to specify the shadow stack.

> I can see the x86 shstk_alloc_thread_stack() returns early if !CLONE_VM.
> Similarly on arm64. I think the behaviour is preserved with this series
> but I'm not entirely sure from the contextual diff (I need to apply the
> patches locally).

That is all for the case where the kernel allocates and manages the
shadow stack, it's the behaviour that this series allows userspace to
override.

--9vEWHDJml80AW6hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4EeAACgkQJNaLcl1U
h9C9iAf8CfCzzwiQJ36masHVjY8H/SDctzkmeaMnXiIjH732CjftOeKNoRPZ34ol
CKFnvEZkggURFZsZuKo9c3hQMhp+u+OO+5oomf9iAW2Pa8ApmUryW3Nfqy+nUqHe
H10R6RH4qUvxmVNKVZ5zJEQzqNMuotibH4JgXj37AUswWB1Rc7Q0g4RIcYs/yAUp
1/lM83ad8OzpakfhhTqipogrUWchOLxnFvDoWomOAmwlg5pvQTAmfAiX2QZNThj/
bBCrHAftwe9Gy7RdYwINEgcLEFmip48YDuhEoBAk5yO+HQtJ0oEnKAZoggEUKM4L
I1UziLq0GrtZG9TfyvDE4OlF5Yq2jQ==
=p7O0
-----END PGP SIGNATURE-----

--9vEWHDJml80AW6hw--

