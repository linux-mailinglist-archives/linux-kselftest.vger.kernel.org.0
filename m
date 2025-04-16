Return-Path: <linux-kselftest+bounces-30937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74380A8B4B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF1017E8B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E2B233145;
	Wed, 16 Apr 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ROrmdjIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77321348;
	Wed, 16 Apr 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794332; cv=none; b=bvLuSJMdWnlKAwkuPQ7szFsSmTuQN6PGa9NagkPi+0yyVugOZtJ3jmauIyrVY7E7+D6Sx0XEMcssFNdhjTs0Yddgv4FbimKLy4bBmKsOr6TSuqhCzwK134gN4zLAi8hz7RlZhqj6H10C5MrOBlMVpboijc/q/+nOnI614dcsKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794332; c=relaxed/simple;
	bh=uMEWrCr78cmv0MuAdTeAQGXVKQxOSKaTL/7Tz6bCxOs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeK/tTRcRrGG3oJW9CmE2Thhku/QdL9C+A3GT9PThTPoY8pDnpxNi1LiCTWGJKbHWQXZfenwPSgpFEqclPBDdF48h7ohQHLZT1oEuAdeItRtfI5PV/aucaOL0DbTZKDXQD2ihcUARmQqyhft631rcSIMN3uMYOU/bLjPLKJE3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ROrmdjIb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D4C0120606;
	Wed, 16 Apr 2025 11:05:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQcQYRyHQdEo; Wed, 16 Apr 2025 11:05:25 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8DEE720842;
	Wed, 16 Apr 2025 11:05:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8DEE720842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1744794325;
	bh=MJrDaKdfNbtRshuh/vBRKkh3LN3w8BO8t5Sxeu32lbw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ROrmdjIboXoD+2c+PXqeh8M1HiYoAfuSINfR02ioI2pn4hncqT2jZPNMyzXUSmM2z
	 75pDC9mXUKgp/5+hKu0Gctd3F3e9wjgJrEzLkCVwR2L5zcoasPE0ImVhXlCzu/knVs
	 7bgGTTu80W4A6JT/tZ2z7l8theayBIU8aWDfhwzqlmqhhU0SXERfhHrk8uH1mwOi/l
	 VZmXtJrR2FOalQ66/ZnPCLMgQVBPEy/O3LabnPgOrixX8WEkgD8CvcktMvPxvPAFUu
	 lrLutAHupZlIYWF7ve66xrjRNZdHQLOeDtbehrAblvHTP42buJ84VTG3kLYyW/vu7I
	 X7bSWeBfAn9Fg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Apr 2025 11:05:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 11:05:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C07713182D28; Wed, 16 Apr 2025 11:05:24 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:05:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Cosmin Ratiu <cratiu@nvidia.com>, <netdev@vger.kernel.org>, Hangbin Liu
	<liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat
 Bhushan <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/6] xfrm & bonding: Correct use of
 xso.real_dev
Message-ID: <Z/9y1GR5RGxp+UZ1@gauss3.secunet.de>
References: <20250411074958.2858496-1-cratiu@nvidia.com>
 <Z/zfWKfhR0GcuCki@gauss3.secunet.de>
 <20250414095147.02800774@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414095147.02800774@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Apr 14, 2025 at 09:51:47AM -0700, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 12:11:36 +0200 Steffen Klassert wrote:
> > I'm still a bit skeptical about the bonding offloads itself as
> > mentioned here:
> > 
> > https://lore.kernel.org/all/ZsbkdzvjVf3GiYHa@gauss3.secunet.de/
> 
> So am I, FWIW.
> 
> > but I'm OK with this particular pachset.
> > 
> > How should we merge this patchset? It touches several subsystems,
> > including xfrm. I'm fine merging it through the ipsec-next tree,
> > but would be also ok if it goes though the net-next tree if
> > that's easier.
> 
> No strong preference, but I think xfrm tree makes most sense.
> It touches a few other directories but all code here is xfrm
> related.

Ok, I'll take them into ipsec-next.

