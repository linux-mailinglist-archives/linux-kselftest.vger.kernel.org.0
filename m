Return-Path: <linux-kselftest+bounces-15489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63439546F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 12:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F41D28346A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2556198A32;
	Fri, 16 Aug 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJEYDkMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1C198A08;
	Fri, 16 Aug 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805525; cv=none; b=GluNMFwO4aCa3kdX3LxLdb3YtxhNy3T9ckMCAzuwjs3irGy1P/EWVWH/JFQiZCn5kY6Z/DpClECiSCyRjhYTizgz6wKbUt5tdTpruem41IBHk76UxoUjh4S3Ja2rGoiKxTJ2n6KSGWe3UH2/s9QI5oVtGTHtm24eTlZkLsECp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805525; c=relaxed/simple;
	bh=sfpft34+Q7KpSTmp1/eLWQvAOdHVfxQX2RrOjfaV45k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZUr0BxxLG5uDHW4bw8c0vdduprW/H4YkSEkKtvurdhwNb3SjIvS+Mnhx7dpPHOxN9aKbRVdjUHZ/XfGv1YLbk4bABAfa+qd+T/e4O3QcDj6hWfClNYsw5iRMUN1x+DCu27q9i9RqhKCxAlrmpv/2NHb6608tE4zx06HAG9OwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJEYDkMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F32C32782;
	Fri, 16 Aug 2024 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805525;
	bh=sfpft34+Q7KpSTmp1/eLWQvAOdHVfxQX2RrOjfaV45k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJEYDkMn6TmebfPerm4lk8VIradWKYkDFTfBkB3nBlBrG0s2NxeCKW4Uru7OP+lJO
	 S60xtYkMNFVa4RAHS5ex196JjVqVtVU+YGpNBO0aWkd7QEKEJLcUsVHQovN2hQcj5S
	 Qy2pAnjUl59oh9a47he0OEsvr6RHugCPTd4YgYYNKsiQgk5frJsVgayxKexR2wQUEZ
	 1S5NFaHNXMEBtgun4D8CFftUN3DxO+OO/gMiBQ+Hl/dmX3XmJUP073d6AMMFSDAoLP
	 3tti3ZDhfgMpleaEHZSOJl58kral88OJV9PfsSJba4DWgEaO/7gHe/tTvWjDaD1B7h
	 1s68AyoGy6djQ==
Date: Fri, 16 Aug 2024 11:51:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <c644d64b-f7d0-47de-b5ba-ae2ac1b46e1b@sirena.org.uk>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i+AGODBgwk+YiNog"
Content-Disposition: inline
In-Reply-To: <Zr8RfoHZYRWem1K9@arm.com>
X-Cookie: A Smith & Wesson beats four aces.


--i+AGODBgwk+YiNog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 09:44:46AM +0100, Catalin Marinas wrote:

> We could, in theory, consume this token in the parent before the child
> mm is created. The downside is that if a parent forks multiple
> processes using the same shadow stack, it will have to set the token
> each time. I'd be fine with this, that's really only for the mostly
> theoretical case where one doesn't use CLONE_VM and still want a
> separate stack and shadow stack.

I originally implemented things that way but people did complain about
the !CLONE_VM case, which does TBH seem reasonable.  Note that the
parent won't as standard be able to set the token again - since the
shadow stack is not writable to userspace by default it'd instead need
to allocate a whole new shadow stack for each child.

I change back to parsing the token in the parent but I don't want to end
up in a cycle of bouncing between the two implementations depending on
who's reviewed the most recent version.

--i+AGODBgwk+YiNog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/L0wACgkQJNaLcl1U
h9BKkQf/Tb1CjJ0TFb/grSaBzz9tUOVm5wq48R7CEnmXCbox1sbTUCqom9wLNkPk
04SjExLevPi/NB9b2P70iBfZzfEiqmrbZEUZZHb7PSLK5xF1QJ6gDlx2wmjXMQP+
C275u0W6zVCNLpnxBYAxNKWWq+X0eIoch+hzpEk3yHzjUQEFqYjkAJsLhS/qU5dZ
vRF1DDm1mcxTdV5m4gkMkOgkSDw97s330FFYhL8iSzP05/oQGp5NGX2S9IwJz6OK
01FwbU/7olCBDK/ZbvUil6Gv42+Z14WLQUTPyEk9a2xzhaJkDjIMo1NFfqIxhbZ0
hVUF+d4yVftBABef8rjNaQpAClsqiw==
=JqPA
-----END PGP SIGNATURE-----

--i+AGODBgwk+YiNog--

