Return-Path: <linux-kselftest+bounces-21107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A271F9B6551
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F8F1C22D3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89C1F1306;
	Wed, 30 Oct 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa8KLYzM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE71EBFFD;
	Wed, 30 Oct 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297350; cv=none; b=o/OG/h8+YRBt0lYD9Ql9WOn/rQeiVYV6WSft8DMJqs8T9Xi+PWOZEAc8HP4XrDF/CW0wJ/iAN1sgi1XmTwaRgrpYjx8hXdZAcYT3uuOJ21mSTo14mPHrxWENWB4F3o6cobNvbSitNT90fjdvh+hCCxGMxaxljFw7qYFvnp7qMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297350; c=relaxed/simple;
	bh=6urYDJMFL8UfCsl1Fzqxyc1jmEIEOvVoGCYwStPXqkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8LGPS/0OMl4pxiYe8oQZWNGeQZ/ySSt55dLHyhXmIsbca8D4z6afs2FbQ0ozCZZVjzFobrG4dTfOTFEffoHMBVDLoK2gbxaHYR9cH5dmugYaUNXFctIuy/QnmjGZ4z/tQUuTQsTcWPFNB6AiDx/GSaY2WPsdfbNkyBsrzAJMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa8KLYzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59823C4CECE;
	Wed, 30 Oct 2024 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730297349;
	bh=6urYDJMFL8UfCsl1Fzqxyc1jmEIEOvVoGCYwStPXqkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa8KLYzMTD0/Ny2o9kgu9jCNo0P4WE28G+HbAk6eDyVzi4GSmCefpSa3JPr268yZk
	 HYX4AEnJqk28zbnGLpnNhxxu89/RweShj+28BLQ+HxyqYUpxehnQjqS+7QnlmtQhb/
	 USYC/9DDmNp0dYfSy9jvAC7SFLLZ/5eh7lghCYZtQoC+1MIKvLeF2PVPaqsIpN/Z7y
	 n5DOKrdRC+3wWCMc31aGY4+Ab0cV2xTPEri4BHLskNS8Kp9HBK/RAjiwyn65VKbvcX
	 J5UrnKfuKbEfML8hQngajwTHzrggPr97l3u7nCfY/+RfpYpmlp9U0DgPb/zQAXH2ZD
	 ncU21nUuCYiFQ==
Date: Wed, 30 Oct 2024 14:08:59 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
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
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFT v11 0/8] fork: Support shadow stacks in clone3()
Message-ID: <9843cdfb-6cc6-40b1-94b3-768c48351945@sirena.org.uk>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tDhb735K0XmDRkCI"
Content-Disposition: inline
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
X-Cookie: I feel partially hydrogenated!


--tDhb735K0XmDRkCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2024 at 11:31:27AM +0100, Mark Brown wrote:
> The kernel has recently added support for shadow stacks, currently
> x86 only using their CET feature but both arm64 and RISC-V have
> equivalent features (GCS and Zicfiss respectively), I am actively
> working on GCS[1].  With shadow stacks the hardware maintains an
> additional stack containing only the return addresses for branch
> instructions which is not generally writeable by userspace and ensures
> that any returns are to the recorded addresses.  This provides some
> protection against ROP attacks and making it easier to collect call
> stacks.  These shadow stacks are allocated in the address space of the
> userspace process.

Does anyone have any thoughts on this?  I reworked things to specify the
address for the shadow stack pointer rather than the extent of the stack
as Rick and Yuri suggested, otherwise the only change from the prior
version was rebasing onto the arm64 GCS support since that's queued in
-next.  I think the only substantial question is picking the ABI for
specifying the shadow stack.

--tDhb735K0XmDRkCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciPfoACgkQJNaLcl1U
h9ByZAf7BJTj2pxo1IrLT45sZZaPAjyEqSup5XazXYJcfpzSjaAMgXfb3SXzK3xq
VfTCfGto6Vy8BEQcghOJJwkzpxVXWFeT+PkSq7NWRgGh9hfAPvRypyGbp7r7v3HD
c20NAibhagaiMzY/Z4jllV0HRw+0ivw3rfsMYQGau7qN5LEx1HvK+5Nf751WSx6m
MSPw2rFyS/iVExob0A7VeNVChTfB5hQoVswFRvUppz/TabTfoeVflwvLvH74SumH
YJdboeil2TWbeySM2XKqEFNxNaAiyqZG2FQkhab0hTmdNgzmknNwpHz5wIesGFxL
iiLXtEIpvzFmWLY5Kv5hVnt10MW9/A==
=VJVF
-----END PGP SIGNATURE-----

--tDhb735K0XmDRkCI--

