Return-Path: <linux-kselftest+bounces-30734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668FA888F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1694C3AA32C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A027F724;
	Mon, 14 Apr 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB1pSCdC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4113D531;
	Mon, 14 Apr 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649509; cv=none; b=WTE/Pi/qm9p2dWNC5PYHItDVz5e4FEPPUCWyEKmqGLCDaR6+qVvO/YCWaG4h5fYEVxtBdKaUxstKCWobcjGt7pM0socchRBDqlChY5wVN9lgQJRhBfM7B8js6qMSF/HvjO1QLqvoMTeST6YaItzScBsx5N08RFhWwU2ZIXQRtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649509; c=relaxed/simple;
	bh=t5VNNbpw8fzc7S87KDIOS3ZQiAD+gZo1uhWUUtvPEMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Znk51v9iXbvnetX4AmjSiklPVyh2Df83EboQLDzvd7sTvRTmhgOrFPfnB+PoChRRbwFG2swVPpt04ZEEug+MkOgfaZOFSmn5mQXBbWQbFyVZySTUTLQaBngGybpzyejBOMHxl3KpJuy5nc5n1FPVNqlVhfUn+K4q+7Ps3Di6t8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB1pSCdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1B2C4CEE2;
	Mon, 14 Apr 2025 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744649509;
	bh=t5VNNbpw8fzc7S87KDIOS3ZQiAD+gZo1uhWUUtvPEMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rB1pSCdCDjREXqLhK/slGMaGCmaGWt13IdoDBCKco31S5B3oIe9jicWQeySFH7otz
	 kI+T8T+0mYrXHyOVwHeJBxSBbihVCzJn65CUdZjuCiaaet2sX+tvZv1kN5bNy8+5Ks
	 na1LeLVrzm2uBQSkHZzIe8BxsuE4i2CiPigTOrZpE549UEKF5/pbDOEhl14jcCyolU
	 bHDa3Vgqor8KfZBqVyuavuT+yCfl20wF217MIJJGqJccDrbQ1E/AOOytUvM8+Z6csw
	 aPJac/GEYOkAuY10iSt9rvm7TKTUIbfseXa+sUaz9Yro3C983oaQo2dd8LyQEg4Ic9
	 5BYoe4JqaipVQ==
Date: Mon, 14 Apr 2025 09:51:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, <netdev@vger.kernel.org>, Hangbin Liu
 <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/6] xfrm & bonding: Correct use of
 xso.real_dev
Message-ID: <20250414095147.02800774@kernel.org>
In-Reply-To: <Z/zfWKfhR0GcuCki@gauss3.secunet.de>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
	<Z/zfWKfhR0GcuCki@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 12:11:36 +0200 Steffen Klassert wrote:
> I'm still a bit skeptical about the bonding offloads itself as
> mentioned here:
> 
> https://lore.kernel.org/all/ZsbkdzvjVf3GiYHa@gauss3.secunet.de/

So am I, FWIW.

> but I'm OK with this particular pachset.
> 
> How should we merge this patchset? It touches several subsystems,
> including xfrm. I'm fine merging it through the ipsec-next tree,
> but would be also ok if it goes though the net-next tree if
> that's easier.

No strong preference, but I think xfrm tree makes most sense.
It touches a few other directories but all code here is xfrm
related.
-- 
pw-bot: au

