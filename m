Return-Path: <linux-kselftest+bounces-22869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE89E59E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A97D188791F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFD21D592;
	Thu,  5 Dec 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYYHT+uH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE0218E99
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412918; cv=none; b=KDQ+Ek4KyGxHNzXSsCR8R/nzMi46jqeSy/a0Z3/kjNukb0c2gvl3Zo4puinTpTEv/zZ4bN9C9NluzVPxQ48k+3IrvgUpYCicNSGaNk2G2bj/4iCoPIRNcM9LLiXLC/ZPzWWZ5bThnNyxJS1tkHH4jzZvsY0MLMghnlhtseJZ8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412918; c=relaxed/simple;
	bh=QAn9V2yuHxWuZKu/2W05MmXDqxTNJ3evsGgiq4zaEjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd1TnYD6+6VlL4oUz9w0D6qUs4k4aIY9+B4uoRRfws8FWdmeojAm/JngOQg8EihDopHBPW3eqz3Y8H2Ax9d1CLzFhrxIgdy0oB7wAgb2e0fHF/4iKptqn9rz4IFrOj1AzTnrF6cTMYKOM3C+lcZ052+nGe8omnbaYbbLsSSukV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYYHT+uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3282C4CEDC;
	Thu,  5 Dec 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733412918;
	bh=QAn9V2yuHxWuZKu/2W05MmXDqxTNJ3evsGgiq4zaEjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYYHT+uHfWLWVdmGgHQUQkaO2doOyhEX/aZRREhpRE8xfBJXPw/FoUtKW/AXQO11K
	 HBuASn+Ab8OKesIiu4BpIrKcg6NxsEWLqYWMfZXapLBuU8nbVd8qnT05xJuHDVzzg4
	 pXp3uhM9EYnM9sXM9AnCYMbET9E2TCclaQ/WvIX32HHwZ8WpgZNS998mYmVCPXgJxC
	 Ltz9KhuvzE9Ogo5yeaEA6HotE2jkbyldlpSxzCVO52hkR85ZeXs3HDHH5rWOded2cm
	 PRxqT6dp55hxKKZcrbaST6UDDb7QVmfpffrKEezHjicgW3mWdmOLna4v/rq6FAG/Yp
	 a6u0YPHDDDkDQ==
Date: Thu, 5 Dec 2024 15:35:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, mbenes@suse.cz, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/lib.mk: Introduce check to validate
 required configs
Message-ID: <6564cc2e-745d-49df-900d-263177c1ea19@sirena.org.uk>
References: <20241205114757.5916-1-simeddon@gmail.com>
 <20241205114757.5916-3-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aCw7c7lh6ArWI5u6"
Content-Disposition: inline
In-Reply-To: <20241205114757.5916-3-simeddon@gmail.com>
X-Cookie: Many a family tree needs trimming.


--aCw7c7lh6ArWI5u6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2024 at 05:17:56PM +0530, Siddharth Menon wrote:

> Currently, kselftests does not have a generalised mechanism to skip compilation
> and run tests when required kernel configuration flags are missing.

Should this be a build dependency or only a runtime dependency, or
should these be separate options for cases where the selftest builds a
module?  If people are building the selftests once and then using them
with a bunch of kernel builds it might be surprising if some of the
binaries vanish.

> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
> +KDIR ?= /lib/modules/$(shell uname -r)/build
> +

Shouldn't we try the current kernel tree, and for runtime checks
/proc/config.gz would be good to check when it's enabled?

> +define CHECK_CONFIG_DEPS
> +    $(if $(wildcard $(KDIR)/scripts/config),
> +        $(eval MISSING_FLAGS := $(filter-out 1,$(foreach cfg,$(TEST_CONFIG_DEPS),\
> +            $(shell cd $(KDIR) && scripts/config --state $(cfg) | grep -q '^\(y\|m\)$$' && echo 1 || echo $(cfg))))),
> +        $(info Skipping CHECK_GEN_REQ: $(KDIR)/scripts/config not found)
> +    )
> +    $(if $(MISSING_FLAGS),$(error Missing required config flags: $(MISSING_FLAGS)))
> +endef

This is going to use a separate set of config options to those listed in
the config file in the selftest directory which is perhaps a bit
surprising.  OTOH we do have a lot of the selftests directories where
not every test needs all the options so that's probably a good choice
unless we make things finer grained which might be more trouble than
it's worth.

--aCw7c7lh6ArWI5u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdRyDEACgkQJNaLcl1U
h9AUeQf8Cve9zVidBux1yRhPZn8yxHs/WQzckHgyFDEk6qu8SNPp/iP27hsuwUi6
WIsX8Igg4vcjxWfuRzFh0fV+te/MCrMErc0UaIP4chdmoAFVY8h4l6piBtrI6rRO
gYxtbhGu12s/yPFS8qOZV5kQ5/TJ1EOuby2LXQe57nKrB/r5x5mT9E2rlcyFhXa1
816pgaDcfzZm9Rj33jg/PefRMUEvnsTFzuq3yADkwJjQC8l72wf9mTlwYcEpK+U8
Eqm19kG23ydAWT2MKCbMs9kgcrV3H7HO4Hy5RKgIJ9ldW9W3pvgapLV65r5J8Qoh
Ao77eRELV52/UaIG4RJlkj16UP3ejQ==
=F49b
-----END PGP SIGNATURE-----

--aCw7c7lh6ArWI5u6--

