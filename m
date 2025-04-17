Return-Path: <linux-kselftest+bounces-31039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49EBA91718
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A97419E16FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA022618F;
	Thu, 17 Apr 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="f4eQv6T0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1D1E32C6;
	Thu, 17 Apr 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880270; cv=none; b=bUe/eUoEFcWSKeDWf5Qff2eGJWZR4sUombWcJyxnI4wlL7ejRiC+JFfdmYC/IB9phg/yYsPc/LVEAwnZ3Dm7EdiNE9aA1EOpnxeNDcKYqXqrFc/kwntQ1Ym1PveEeJX5zggoxP+2VqVrJcwNPAlkDnrsp6xi7vdRGxz9tiVB1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880270; c=relaxed/simple;
	bh=qX+JlIkLdfJZ/KFFhs5U6Cj7JkhKVwtaJ1urSBZeLXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIhijr5PsfpQkaj21jNVsc6BiKB7ZxVyu3KvrOpFs3O0pITRAXWm7wKGg/uY/Si4Bk72gj51nBgaHCShE5NNNL5gH6MKs7rIt5HGLdOZ53bTIHbvPWcPUQ80S4HmSnvKNqInDaxIctzTjmzc7Rb7TxMz5LmlNh1njsGGrRZVOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=f4eQv6T0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9AA6720841;
	Thu, 17 Apr 2025 10:57:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbwm9sTdFU-d; Thu, 17 Apr 2025 10:57:39 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EF51B20743;
	Thu, 17 Apr 2025 10:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EF51B20743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1744880259;
	bh=XiQY5xoIJ7MHDNZ9xnfAyLt0o10fuJcMwDgChIE6mGA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=f4eQv6T09dF5OqVbxdt22fnZYMvcq4BvCTT6V/uFzh9uTGxqXCytxF3IDKjXjBmG9
	 0htOOcyutUwWzy96Px42WOtx09dEBXNtXJn6AL5+XqBa5Ucj0uYyIKGsYN3ZdDIk62
	 BC6xCcgI/suZfKbeuj0xnx7Zksh8b06MMOCmk6Kv05Ba0RjWj+JHz2KBtegbACE9Vu
	 avmq6+cIrdfLrUmKLqUZDWt4dAFnfkL5u+8Mayx+iHC+JlOLNjKKoe9ZWGI6lVuvOj
	 2rJrPkLft0HA0AWX/a+HAQ1rHSiQ4avAy6MaqKMg4sUAmhhibjUW+QdW0COK07o6fx
	 Gp9/0nAAyHyAg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Apr 2025 10:57:38 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 10:57:38 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2ECB63182C91; Thu, 17 Apr 2025 10:57:38 +0200 (CEST)
Date: Thu, 17 Apr 2025 10:57:38 +0200
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
Message-ID: <aADCgoEKT+I/TPo4@gauss3.secunet.de>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
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
> 
> [1] commit f8cde9805981 ("bonding: fix xfrm real_dev null pointer
> dereference")
> 
> v2 -> v3:
> Added a comment with locking expectations for real_dev.
> Removed unnecessary bond variable from bond_ipsec_del_sa().
> v1 -> v2:
> Added missing kdoc for various functions.
> Made bond_ipsec_del_sa() use xso.real_dev instead of curr_active_slave.
> 
> Cosmin Ratiu (6):
> Cleaning up unnecessary uses of xso.real_dev:
>   net/mlx5: Avoid using xso.real_dev unnecessarily
>   xfrm: Use xdo.dev instead of xdo.real_dev
>   xfrm: Remove unneeded device check from validate_xmit_xfrm
> Refactoring device operations to get an explicit device pointer:
>   xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
> Fixing a bonding xfrm state migration bug:
>   bonding: Mark active offloaded xfrm_states
> Fixing long standing races in bonding:
>   bonding: Fix multiple long standing offload races
> 
>  Documentation/networking/xfrm_device.rst      |  10 +-
>  drivers/net/bonding/bond_main.c               | 119 +++++++++---------
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 +--
>  .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 +++---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
>  .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
>  .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
>  drivers/net/netdevsim/ipsec.c                 |  15 ++-
>  include/linux/netdevice.h                     |  10 +-
>  include/net/xfrm.h                            |  11 ++
>  net/xfrm/xfrm_device.c                        |  13 +-
>  net/xfrm/xfrm_state.c                         |  16 +--
>  15 files changed, 185 insertions(+), 167 deletions(-)

Series applied to ipsec-next, thanks a lot Cosmin!

