Return-Path: <linux-kselftest+bounces-7984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288968A5459
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E81C2208C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF10219EA;
	Mon, 15 Apr 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxN8UDoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1938DFB;
	Mon, 15 Apr 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191604; cv=none; b=mcY7km2p3sNYgP0Nt/aWFlgRSbHlD3d494Xw9vrJ7wQvre5itHzGe37WARM0jc1qC91xvF2sMQ28/RM3tZS6q9bUM4sEKnab5DIrutsHW2IkI3Uf6GPBQeT+BxNSL9T6KtQH4cEmoJJE7cAY0eExjWglqZyqai5e2mz0UaEZvUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191604; c=relaxed/simple;
	bh=bLWH1Ef4kYzeWAf/m3vrZaUDTCdIFw73/tOxogcATRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZbqIWmxyM4H5NOGVwSExjVxxMVZXLOP0+ZvftwkCzMy4XYlCwE1k2CQZs2uHgwSHSdcHfU8KvXK3mo/7FcPTBjTAXyiCLm3XbDdMlMVJxqk8Pa0U12/J4vjlHbBVnS4N8DX+HUzn3YQyILo7YjfXXwPSRtxMqM4SrDY8UIgdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxN8UDoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2718CC2BD10;
	Mon, 15 Apr 2024 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191604;
	bh=bLWH1Ef4kYzeWAf/m3vrZaUDTCdIFw73/tOxogcATRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxN8UDoiUisW6p8hHsy9b/csjGv2yGzRvG9KjGiuBwsrrPzMuFrnv7Bb2YCH+4Z93
	 EPKBYmJcFcSbOHFz0CJlRb6/AvnebPRDR0VvAexrbseoUZL9bGuwFAR+CY+yBepQJr
	 dqbmr1hVwbfpT3X0vG0jvTwtNxETF3f+IqiXcmxn/fFD0Nlk58kWtyEa2+FL/Ghj5M
	 0eHV+E/IAZkJKwVYSSxWLLcz54Q+KAJwcw34izT7jf19/jxO2Bj/p9yw+UUN7xTXgT
	 xQ3boCdDHpyVJ5ZuNLcyG8ocBSjwntM/J+WhivV0gfk7ZjrydRViDFlNbllkNOgzoA
	 IN9IdVOxCtxlg==
Date: Mon, 15 Apr 2024 07:33:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, petrm@nvidia.com, linux-kselftest@vger.kernel.org,
 willemb@google.com
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: add a trivial ping
 test
Message-ID: <20240415073323.351c888b@kernel.org>
In-Reply-To: <49deeded3764fd43b9af23f2f6e1b8f4ab599910.camel@redhat.com>
References: <20240412233705.1066444-1-kuba@kernel.org>
	<20240412233705.1066444-6-kuba@kernel.org>
	<49deeded3764fd43b9af23f2f6e1b8f4ab599910.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 11:31:05 +0200 Paolo Abeni wrote:
> On Fri, 2024-04-12 at 16:37 -0700, Jakub Kicinski wrote:
> > +def ping_v4(cfg) -> None:
> > +    if not cfg.v4:
> > +        raise KsftXfailEx()
> > +
> > +    cmd(f"ping -c 1 -W0.5 {cfg.ep_v4}")
> > +    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=3Dcfg.endpoint) =20
>=20
> Very minor nit, I personally find a bit more readable:
>=20
> 	cfg.endpoint.cmd()
>=20
> Which is already supported by the current infra, right?
>=20
> With both endpoint possibly remote could be:
>=20
> 	cfg.ep1.cmd()
> 	cfg.ep2.cmd()

As I said in the cover letter, I don't want to push us too much towards
classes. The argument format make local and local+remote tests look more
similar.

I could be wrong =F0=9F=A4=B7=EF=B8=8F

