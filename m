Return-Path: <linux-kselftest+bounces-21293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73189B9124
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5019CB21E59
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53DE172BD3;
	Fri,  1 Nov 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHQ0KNd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733EC13C;
	Fri,  1 Nov 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730464232; cv=none; b=GtTPeYG1qWyCEBpw8za6cNToI3XrkGbJgm/igw0OzKmMcO/H63t/UQva7pvfGmstAWlSi1OUCLXZ3FroukGczE6sQ99LyUuEmPdhFKcReAV6rs0+DccReN3hEDivEmnnfNPpCkHDvPtdqsZ8pK8oEvuDIcskWjHyZ8DGVN0L8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730464232; c=relaxed/simple;
	bh=7TcBxOnka1nVz+YB3rkflphZbI2fzT7QcPJP71YAV2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km8ONNJrpKmBKdPe7jmuYfV2nnn9NsOOEGRju6aP5Q9EVsExq2MX9jbu2CCsJfxsuhM7m+OW0PVsTg5oFsmdCc8fm6vF13j965xEaTg0lgH5bOl4AvjlKeYbdjosTSyiTtoACxLV+icQUfn/nLh9i0hZC0UY+j81/ZQZWyNcY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHQ0KNd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288AEC4CECD;
	Fri,  1 Nov 2024 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730464232;
	bh=7TcBxOnka1nVz+YB3rkflphZbI2fzT7QcPJP71YAV2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHQ0KNd9iULqrLiO/PvS7RwbhdGoK30GLmYzCTnH200RvPYgDNvEBdQOo75bAkTib
	 r2tAIks3iV2FwflGonEKA0XOzsdLXdtCxu+eRtI63/i9Ro4l8fY1PQ0UgFiaNCuWUN
	 hvSLEMvII8fQBMoO/OGqePdZsTQqfK076wzfhHgehQdJrruutapBhfKPpHKRt/lGa8
	 208Zd67neipOlFi6QBpz3pmufbr7cDmZhmEJwiFibU8dhBSCdQ3E/MbnQttMZE+dVt
	 Ob5CRfxRGuMhj26vqrNY9EUAUZcdfXuxkVGgtzGXQjO5WFHLPdTjeRtXuXHcNZZ+Wr
	 YR5IBlM2C9rnw==
Date: Fri, 1 Nov 2024 12:30:23 +0000
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
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"kees@kernel.org" <kees@kernel.org>
Subject: Re: [PATCH RFT v12 0/8] fork: Support shadow stacks in clone3()
Message-ID: <eca3edc3-1a2d-475c-a866-ea25d6bd9756@sirena.org.uk>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
 <fe6cc8010b2b35aaa2629c4c5e972dc1c90c43c3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WzOkb7e6YaToc7v5"
Content-Disposition: inline
In-Reply-To: <fe6cc8010b2b35aaa2629c4c5e972dc1c90c43c3.camel@intel.com>
X-Cookie: We read to say that we have read.


--WzOkb7e6YaToc7v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2024 at 09:06:09PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-10-31 at 19:25 +0000, Mark Brown wrote:

> > base-commit: d17cd7b7cc92d37ee8b2df8f975fc859a261f4dc

> Where can I find this base commit?

Ah, that's still my branch from when I posted what's now applied in the
arm64 tree, this is the same code:

   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/gcs

Sorry, I didn't rebase after the GCS code landed.  Applied branch here:

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git clone3-shadow-stack

--WzOkb7e6YaToc7v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmckyd4ACgkQJNaLcl1U
h9A/zwf9EQ28AczCH5D/BrYuZ+sphQDinPIhh020kD+hncKxKb5/pHR7YqjDCDow
UiD2dUHuEOH5kbS8eLAYdYA2PdUmBGq3HJv1s96OqN56WrNWWQYeGPnGZjSrfW6T
jlKlDOCm15m67oaRAKOMXaXPxKkFQumKUjk4N5GRorlMnPhUo7RACgyg/xFcKneX
keakD5gzrSCMbabGnmtg5tumG1qOkrwG/nZL1of4f0Q8nHPLFDxfrjMSV8THAlwY
kTZlIm6xV3MCo1ZmCJu8k+tohHH6Yft1eCjCw3Pxz8eiWiiFSlcl1Ie8n7/w3o/H
CDR56lJwb2Lbmrftd8mIz8eVW4btfA==
=SCG2
-----END PGP SIGNATURE-----

--WzOkb7e6YaToc7v5--

