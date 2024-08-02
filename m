Return-Path: <linux-kselftest+bounces-14712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC399946033
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5581E1F2166B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15948175D5C;
	Fri,  2 Aug 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+8p7NH2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB2175D53;
	Fri,  2 Aug 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611905; cv=none; b=s+lsGizMXbC0QzkbUc6deK2PUp7QSMTp1ZkP4ubDXzkRlaBwvwwx/YFJgNF0DyNhVdfCtaovylORGGusVhpnNhEguNwREQ9g3LhqijzRY9BqAXVmW2cY7uqD18iFgzapvUV6LNwmHy5xhuRGMVYNL8XT9rXmM6bDjDZnvuRJZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611905; c=relaxed/simple;
	bh=4jwxw8pHXDdyTWLCG3vVw4j2DotA46a1uGLkptcyRVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz8/2XckkYtfWxz7/ot6qTgnVt8055a4yqBzTu7w58hiE+pP3WjP9fxAwK5VcXZ4WQznXkFy3n+uJibu+rycaXZt5ulwaFLBy2Ow/R9xnVF053QuMFaLgDYRA3drt2STW9lPJg4xm/8wiuAGaViG8X/gP8Y7OW2VzCKN0b2WlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+8p7NH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D9AC32782;
	Fri,  2 Aug 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722611904;
	bh=4jwxw8pHXDdyTWLCG3vVw4j2DotA46a1uGLkptcyRVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+8p7NH2fVcCv4WUHm5Zkz2uiYHWn28gdCEoPF8kxwBCqU2W9SLrDh/SgT4yY8ky5
	 g29svdyuLT3aLLQaPIJ62q+dgztcov9XLRr5HgpvtHL2PP95cF56JnjbW/T5S2aX6j
	 F3XWNOA/pjtug444vEa/LLTd3EGX9vcgVk3Cxy1Ygtczw08XtaFzy2jyOA39eYD5rg
	 Vlek/ocf4OLXd2W5JimSuPyflTkH10fS1/pTt9nCz3GI+vfKQbpFh4uQvgWXAHdwMe
	 d4RffFyWtmfqM8R9X28Pqx2ifQccgdjEMRFMFPoGtGAteG/LCcDs7YHdALzMMmMLHx
	 njzjTbo5g6IGA==
Date: Fri, 2 Aug 2024 08:18:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Mohammad Nassiri <mnassiri@ciena.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/7] net/selftests: TCP-AO selftests updates
Message-ID: <20240802081823.67a27db3@kernel.org>
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Aug 2024 10:23:24 +0100 Dmitry Safonov via B4 Relay wrote:
> First 4 patches are more-or-less cleanups/preparations.
>=20
> Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
>=20
> Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> the issue, but I hope it will fix netdev flakes for connect-deny-*
> tests.

Hm, could be a coincidence but we did hit:

# not ok 55 # error 381[unsigned-md5.c:24] Failed to add a VRF: -17
# not ok 56 # error 383[unsigned-md5.c:33] Failed to add a route to VRF: -2=
2: Key was rejected by service

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsigned=
-md5-ipv6/stdout

in the first run after this got queued. But the retry worked:

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsigned=
-md5-ipv6-retry/stdout

=F0=9F=A4=B7=EF=B8=8F

