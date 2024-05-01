Return-Path: <linux-kselftest+bounces-9176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF78B841F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 04:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12196B21B26
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369D846F;
	Wed,  1 May 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSM5jhhD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113B522A;
	Wed,  1 May 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528798; cv=none; b=PsTygwCUPNkuZUsXTt6hl80ClWKe3G+xq9sJxrda0Vpqoi6xG8KvWV4OC8tVblbRKHRDuB8GbgOULY5olkMwLrThfmLGtg10RXqR1OGh9gwu7BNL1BteXzbC4VmYuUgcAR8Uoy4IxFVzAf32I8XA+aR0gSKG4phukQp1uaSS1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528798; c=relaxed/simple;
	bh=o0JLE4w7Txl02smd17IqwLJ/xQdd2b9AlvJ/m9S7MxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1dir4Axffx4QiCRR85CBlxv04UYRwDKTSupu1rObf0V+kTig4vQXxxtS/ZQCcI2wT9xXeR5qLbhHqZuaiUMHbuXXB/ppxGKn5/SsoMZUvlLRJEdChkHsfKcGkQJZKKQFAAYWRHzdvZEd/UmkYdH3b2Wowft5i3+HJysYk4tRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSM5jhhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D3C2BBFC;
	Wed,  1 May 2024 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528797;
	bh=o0JLE4w7Txl02smd17IqwLJ/xQdd2b9AlvJ/m9S7MxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSM5jhhDyVrsK4rI+tirVbxUm2SGjSCdGiW5yFeyy87vScGUmRYq8PoxARTsWGi75
	 ZN1EWeOQh2/eZFMmiGFHj+woNykMssK7js3ZiiSdJhlK8P+CPJQeD7PHLwKfChDKys
	 Vn6WznDzNt57OAzPcOny8cUE3vc+MoS9R/LGRw0r+eCYBudJMkIWBgooqLvpmCn1I5
	 Dzttpfjh1y7CeXOQvVbhFTH3YMCL8d6ZCnhcpiYB+v31+ar86AKn1pAfB4zKu6l/8b
	 JEmpQTGj5IdNtO+TWT7WkjmqVga3a1ZRHG7SWmeQ1BAc91x3VUyNPErEMaEHGoYkJm
	 tJZXubj0xGIxA==
Date: Wed, 1 May 2024 10:59:54 +0900
From: Mark Brown <broonie@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Define _GNU_SOURCE for sources using
Message-ID: <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
References: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u+4ZZ4jbS0aM3c2U"
Content-Disposition: inline
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
X-Cookie: lisp, v.:


--u+4ZZ4jbS0aM3c2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 11:50:09PM +0000, Edward Liaw wrote:
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.

This seems like something that should be handled centrally rather than
having to go round and audit the users every time some update is made.

--u+4ZZ4jbS0aM3c2U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxohoACgkQJNaLcl1U
h9Dv4wf+Oy51jhJTtX+KR/9MxUx3xHW+ifosvcxRaNBSM47ULNjdnTpPKnkuarpt
mWWj3hbt5RKWrCwD4BXewKlkUTeOwip+tNfAif1eE1keTt7royrAsdrRNbQnej4Q
fZD3C9esrkUiJUPsBHZw74ycUnXOvo+2znUMLfLGh9cMI8AahfyBz7vNeXQanaSJ
1SxF/MZUXwhZ0wmeUHmqIMtppKUiqWzLBTdkhRwVRGaGhzSNWD3qeHMNYmRLN++g
35CtZCDC98DyWxcybLkR/DFkf/9yiC0leVqktKDouqBUiVMZxSicfl9kL8bfgmq8
dSdfvdLQR1VKa6bPvR3uEa4WSOIlVA==
=krSA
-----END PGP SIGNATURE-----

--u+4ZZ4jbS0aM3c2U--

