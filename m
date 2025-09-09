Return-Path: <linux-kselftest+bounces-41065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219FB507A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2517431D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5D242D6B;
	Tue,  9 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3ZgBZUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0680B;
	Tue,  9 Sep 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451891; cv=none; b=STK51++Of6bmvIZfa1Ooa8Mh07BhOVhjVYcBuN01zz1v8P6LyOGt1MKx3A5EJn90+ltqFm3nJC/k6e+2oY8KFT530e14xHs0MxMEzqZs3YM0MgaENUoj3CIpR/nN6W60vrcIwExDNPAivXlb6+8e0s2IoQVXLrwLRerDOEkO6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451891; c=relaxed/simple;
	bh=XjQd3lT1oVCye2ipgt96pYVcrsuv6+2ThoOFuWBMXiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHEuMzwLaKupv3D6DSgRH0xmjhm9JGG3LDOUJEKFXXQepss4f48TTAioSMeZOA/Fd6ckEJwmdzXtDI1b1Pcofw8hv7gj6GGZdf31JMz9d9AEN3zRwQr4uN6tcu2tKTmeR6ndpsEYHD/r59m5CVHcRF+W4q60qqEt9/AQyylx4e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3ZgBZUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A98EC4CEF4;
	Tue,  9 Sep 2025 21:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451891;
	bh=XjQd3lT1oVCye2ipgt96pYVcrsuv6+2ThoOFuWBMXiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K3ZgBZUmL8KMbprUbmB8zTrsjOJGchPxEOGe9vs+LZLJGfRaJvAypOvsy68k1FIA8
	 UtE2dSrP7ce3lgq8EmqxJ1unrl2lSJuMLVlm3K/O++CzrQwc+VfKmHr1U5KyI75ueb
	 ePe/cQl88Thdg3FxH+ol9L5krOULRisJ870MRACle81zDwVJ5jU6dWPziKN81wIzZQ
	 iYOOAKaLnJMS1vPdQHXqYntg8/K1VpjJh3TwUqwSL0jpjh8gknadS5qVhUnmigHo1J
	 ucG3oPfq9gjnm48wfuKEHNP55VuLuRQesS4nc7O1BdJiGsimAE5BzsoGxjYCTFs7zG
	 sK/2D5XmLTfxA==
Date: Tue, 9 Sep 2025 14:04:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: drv-net: Relax total BW check in
 devlink_rate_tc_bw.py
Message-ID: <20250909140449.4bf015ba@kernel.org>
In-Reply-To: <2cdd9fa9-9fba-4880-aa92-c73033c668f9@nvidia.com>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
	<20250831080641.1828455-4-cjubran@nvidia.com>
	<20250902162101.5c78cc88@kernel.org>
	<20250905153243.6c03e257@kernel.org>
	<0cd98e25-b387-452b-b1a6-414ab20a4cf3@nvidia.com>
	<20250908131917.10785ce0@kernel.org>
	<2cdd9fa9-9fba-4880-aa92-c73033c668f9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 13:06:22 +0300 Carolina Jubran wrote:
> > Sounds too complicated, this is just a stability improvement for a test
> > which works on single device, and is not exercised / reported upstream.
> > Let's jump straight to step 2. =20
>=20
> Ack, I=E2=80=99ll drop this patch from the series and handle the migratio=
n to
> load.py and reliability improvements in a follow-up.

I think you misunderstood me, let's redo the whole series against
net-next. No need for Fixes tags.

