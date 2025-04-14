Return-Path: <linux-kselftest+bounces-30663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB9A87D25
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC347A9B45
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FA265CBC;
	Mon, 14 Apr 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="huxKY3SZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5D190679;
	Mon, 14 Apr 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625504; cv=none; b=thX+egDmLZajktKczdM6Dr3Kr8hBlxxiZswpi3mkoLX+46cyQabdLhQdXtuR0HoiSq2FIp3rS97m6mRxdZMAsDiZ83Fi5EevBjGxGknBDI9kjCwEvHklOKDd881XGfTUDxSY6AiB/63LlNwOzbgN6puvCrz2lGJ412pWW0Ha0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625504; c=relaxed/simple;
	bh=A5JrYJudGl3DhGQV8xarh0BdKwPSWfzjJojbct/oWAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdCl8TFNiItyuPPfJzuiTCtfDhMKITYRZNbMzvy+hLePIV6H6cg/18qRmR4DieemPNPIEwaoCzwL8jqt+6Fy6ZS0Hg7YY8bELwR7Xb70LHGtvOWhc/VtE7OfG1yR8lGbP9dK04JTvT17ejk8eVYF9YbvqdI76pM3dGdzcFGVkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=huxKY3SZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1514620523;
	Mon, 14 Apr 2025 12:11:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qlytawnqRQOS; Mon, 14 Apr 2025 12:11:37 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3534E20189;
	Mon, 14 Apr 2025 12:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3534E20189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1744625497;
	bh=Weyznl+15m4X8CsfGwNOCXhpIw7Y6wOODlPtRSZ+HV4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=huxKY3SZmtyVuMCV846LSXff4w1KwmquZdZPvh27Hxmg4fAcZq/66nLyqU/7cTy1h
	 m9f1ANEJ1iFM9x+WD1xODHbrGdAdvzNNZc+ycTSjw1LKni79fK8JE5ZvhPzEbE9QjY
	 Wgy8/2+E9OYz1RcCHcRRuIYTrfzXt15P4WerwPc18TRjw0irlRYdPFbh6QDKXdgRcl
	 m3IljHCyd+zC6qChKqm7qh5ODGEhCqk1nEm6XgU8Peh0TBGCH1g/kU06tNRYmwKY/T
	 UCohCR9MS6GUWuCzuHdnDZzCG6dh5yqDXTPleRn4mDLs3a5aqDvfiH0gfcpyJy2GFb
	 8BFynpTVih7Xw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Apr 2025 12:11:36 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:11:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2284A3182D8A; Mon, 14 Apr 2025 12:11:36 +0200 (CEST)
Date: Mon, 14 Apr 2025 12:11:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
CC: <netdev@vger.kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh
	<jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Simon Horman <horms@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/6] xfrm & bonding: Correct use of
 xso.real_dev
Message-ID: <Z/zfWKfhR0GcuCki@gauss3.secunet.de>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250411074958.2858496-1-cratiu@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Apr 11, 2025 at 10:49:52AM +0300, Cosmin Ratiu wrote:
> This patch series was motivated by fixing a few bugs in the bonding
> driver related to xfrm state migration on device failover.
> 
> struct xfrm_dev_offload has two net_device pointers: dev and real_dev.
> The first one is the device the xfrm_state is offloaded on and the
> second one is used by the bonding driver to manage the underlying device
> xfrm_states are actually offloaded on. When bonding isn't used, the two
> pointers are the same.
> 
> This causes confusion in drivers: Which device pointer should they use?
> If they want to support bonding, they need to only use real_dev and
> never look at dev.
> 
> Furthermore, real_dev is used without proper locking from multiple code
> paths and changing it is dangerous. See commit [1] for example.
> 
> This patch series clears things out by removing all uses of real_dev
> from outside the bonding driver.
> Then, the bonding driver is refactored to fix a couple of long standing
> races and the original bug which motivated this patch series.

I'm still a bit skeptical about the bonding offloads itself as
mentioned here:

https://lore.kernel.org/all/ZsbkdzvjVf3GiYHa@gauss3.secunet.de/

but I'm OK with this particular pachset.

How should we merge this patchset? It touches several subsystems,
including xfrm. I'm fine merging it through the ipsec-next tree,
but would be also ok if it goes though the net-next tree if
that's easier.

