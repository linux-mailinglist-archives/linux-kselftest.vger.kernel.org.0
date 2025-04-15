Return-Path: <linux-kselftest+bounces-30870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD28A89EAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83499168A35
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2F296D20;
	Tue, 15 Apr 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKFQTpTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5928E61D;
	Tue, 15 Apr 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721792; cv=none; b=BY6U4RNVylTBeAIUTKTAXfWdc8naXWEt9UCW00qSWSSNgrqd2zodJHg16geJL8o7uFDkNJzPJAE6odcjifSAEvNBpxVks0ZfRAf7S7A9KsiJ2WeRPwJJgUIu5ESpQ40JPPbgcg3tbDNbOZ5TkMFkG0ySpIqJ1Ps14yemGXehTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721792; c=relaxed/simple;
	bh=JRDcI9XTL6/McMvP9bm95+ugxrRXAWejJmT4xuEZ0Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA0j38sQ/cEmtbRraTAAAQRkYglGb6a+m67lEO5ZwFIResp6jhtcyFze13F6zeAvdXddmhxkb8xfeMBqRxa/LpdXyEQWbn/n6rrBkiPxnOnkTbL/GyYvfh77x9R90WdQEMl2w7s9Dh991ZRO867k68m3zLDqu6r5XxQ84Qj1SKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKFQTpTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC31C4CEDD;
	Tue, 15 Apr 2025 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744721792;
	bh=JRDcI9XTL6/McMvP9bm95+ugxrRXAWejJmT4xuEZ0Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKFQTpTOYJTq9Xbi4PMEhhH6FlQ6iSYPS357S2a4IgeH0WZ7YuCStXAjBWTFacPm6
	 ho1VNMgc66AbfbBZ1J94dSV1qq6F8g6VfWgYUH6GQXOmAjGWnVhywfKh/OceFYCgLb
	 QNlr6a0wrP2H7GFV7pCwuYhxk4WaIV3pj124FI8TpjRqYEYVHHXwIdO7GOlFRGIFEF
	 OfvzQ7nXMRdlMStl7bMzakbBpEm+Ik5NCueeQy+S6cLr2+Xbw9/EWx+uy1qa4C4mO6
	 NXJv0Q9mBg+j6/i7NcsJNsJcbCc0L22yAPufZdkN2ngxHqqZFMkPfzAeKdKBEfeG9E
	 U7GbztbFaaAIw==
Date: Tue, 15 Apr 2025 13:56:24 +0100
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
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH RFT v15 4/8] fork: Add shadow stack support to clone3()
Message-ID: <e0bd1091-0342-447e-a74d-4d2ce01144fa@sirena.org.uk>
References: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
 <20250408-clone3-shadow-stack-v15-4-3fa245c6e3be@kernel.org>
 <b15bf40b530f74d3339a313e7f5f5cb09205d348.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AwGzYJdIo8nWtgmb"
Content-Disposition: inline
In-Reply-To: <b15bf40b530f74d3339a313e7f5f5cb09205d348.camel@intel.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--AwGzYJdIo8nWtgmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2025 at 06:28:14PM +0000, Edgecombe, Rick P wrote:

> First of all, sorry for not contributing on this since v9. I've had an unusual
> enormous project conflict (TDX) combined with my test HW dieing.

No worries, there doesn't seem to have been huge urgency on this one :(

> Both fixed in the diff below, but in debugging the off-by-one errors I've
> realized this implementation wastes a shadow stack frame.

I rolled your diff into the series, thanks.

> Do we want this? On arm there is SHADOW_STACK_SET_MARKER, which leaves a marker
> token. But on clone3 it will also leave behind a zero frame from the CMPXCHGed
> token. So if you use SHADOW_STACK_SET_MARKER you get two marker tokens. And on
> x86 you will get one one for clone3 but not others, until x86 implements
> SHADOW_STACK_SET_MARKER. At which point x86 has to diverge from arm (bad) or
> also have the double marker frame.

> The below fixes the x86 functionally, but what do you think of the wasted frame?
> One fix would be to change shadow_stack_pointer to shadow_stack_token, and then
> have each arch consume it in the normal HW way, leaving the new thread with:

>    SSP = clone_args->shadow_stack_token + 8

I think that's a good point with the extra frame, your suggestion is
sensible.  This didn't translate well when refactoring from specifying
the extent of the shadow stack.

--AwGzYJdIo8nWtgmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf+V3cACgkQJNaLcl1U
h9DNCwf/d/78n/7YKAbpKnphufPOLaov4Aev9sMXOF3KDwmLA+ibe20td6Crz1ew
If3etKclVlGQO0noH/YaRgSDdnddkDQt6RP7F9xEjM2Od2EFPGeSLgiMrLxGJfGz
BGTwb86QvFglWwg2ohgMAQnMlEMCYJdSibhiid54Lj4iNwPrG/yMF7X4aZ4wJhVn
mXn4/I+2Nc+sVI8lIPvUar+sXyYweNWcImeBHHy+KL64g6wUWFh8kP7gap6CHjEI
vPr6UWB3PbD2TGkDzaxjecuLJSDewd78R551z3d60pS+46BEm3+Po28+bgvLrZbx
ClDJ3HX6nnZtNBytKOSpXs5lG/cHJg==
=OXqt
-----END PGP SIGNATURE-----

--AwGzYJdIo8nWtgmb--

