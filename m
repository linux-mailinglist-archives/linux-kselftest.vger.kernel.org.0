Return-Path: <linux-kselftest+bounces-30476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B5A8417B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE18C20BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F328137A;
	Thu, 10 Apr 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tnOxydS/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205A280CF0
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283457; cv=none; b=ITcIEKKdgb24MH1XbXmkU9WxdKSLa+oTl6oNvkJknWM1GY8GL3CAxtQtHj+oL4/ZrwXPUkhlKWJUD9FMbEJzbw2G5RK2xLjif93qyLBFtfXgsKOU92LjB+sDaZvlfma6KfKpne6mLxhrsyU+1QoQOYLx2ikHu0n+4/Xi7VSROkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283457; c=relaxed/simple;
	bh=+e4uZEgvaKhO0stJYuLSFF3XAGqvC9lTsIv+F4Gta5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPSssqU4rAo6rTyVCqIWSQmy3atOlPWDgfSM6grFfkvTp4CmZ7SCsxTlyGUVH/FxPbEIdE7/SnL/g0HToE5UbIg1HWXvGZz3T9os9Pv7bf8hfF4tKbKK2Cun/MNoD1WhDh9zvyMvu6d6J7gfTwkHhc1rlPyGOSikEqanT19NBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tnOxydS/; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cfe574976so4810105e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744283453; x=1744888253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zXlC9nBwul2N0yZKb287bMYJF4TW86ravWYsYs27Cg=;
        b=tnOxydS/0D/X95SGC4TYOkrnKM/fvQKCoMyZEOOOE7u4vyhmy7v7aN9Yuj/7kQ+PMm
         kch5ZkpoQMrgijIDs8iVD0hqxDscS317dzG3DZHCPOP2so59vGvU13he7w8sOgARcmgZ
         mNaf6RMKHILPf3XQV7QDH897JTDKOFa4h+FEHSIQUZwXNIocRgTwFxPCsMq4E5rZ7Ajy
         93pts8FRUWpF9nIw68z9MTymPp59acYJYzLH/iGKWdRdhz8VZaJELhfbz3GroB88mm0M
         IhBc+u9qMDwLUaFvn1ExdyZ/KDutpDL48DW9JWGEx6sRbJlBApdUPAY32AXOk36LO41O
         Zxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283453; x=1744888253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zXlC9nBwul2N0yZKb287bMYJF4TW86ravWYsYs27Cg=;
        b=UcgAm/u8HI/8Bicjzq7E+aNPYjl74fl+uFlWq9ztXrL7cLA3p4cZPKdFliajMwcTRS
         UeNkwleaFIsTxjSq+O8ZALaMfkIu924w0j24Cz42eZEcw5Ak+0Cvr/e9ZRZyL+J9K0NL
         +kkMzG3sYeyWosPP5GpYFpNs0Pr0ZmQbXdltNJDO/mhzPn/mF6hw2y5+ceSJsRXfSiF3
         5y67VLVLa0Elc0P5qj3gVBZx4TDUUCYv1IoO6rHWQ+z7e6eL5SNlUc2BZN6zoFdbvqpG
         tv+h+ywv1JM5PZV7hPt0vgTd2vl48zWUAXjLK00kfq9GtYhUzbXxTn5WR/JvHYr4MBq4
         DnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWI+1xphBo08Wp/fWemxN+ZfcOOCFWhelyiYGgKhN09GS7iylTBzYd4JKShSTZGATsPhjueH7koFuW6fkl3M+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2F27aIjyAM6oGYfsZnv4xPhEHRPEBnwPAWOSTIIMfqOPSbweH
	t8Y6eRFOkuMFQIgDXuG9U7baOfqM1TD3QlkmGb4Qht3im9q14s1F+OhjNft/NoI=
X-Gm-Gg: ASbGnctrhAwHcElizxOQc02gk45Mp8itlT9+HAn8nUYgsu+FWb5ROJN+e+XojGx3soc
	FvYWeBAXbf+FimLostd3CqjJb8kbJSgwIpXhZbSdfRHEbnX3uZYmwQ3hBW6+e4fq3NtjnCKntYc
	U4Si0q/h7ZXllv4vCYtNqEMrOXEZ0GQNKtSpSq704WN6pmV84ATvOGJAlmq+3DnMOk/qN0V/ruB
	EO7tjKWMWvZMAh2DSZN2QBPPcj1xi3y6r7Q2BqG/g6a9Pb4Qq7UOLm1BcXajYh5HY3tEUW3NNOG
	pmMywbnvJ5JoRd3wxAcoA7wUQXuhqeK7liest5fxVTxS7S1DPmTF3fmskSD76n6A+tO90XoX
X-Google-Smtp-Source: AGHT+IF9Hc7Q24zHl7xPZwtzZ5Sgf/XrRL5TMP+ztmFz2QJ9DEFpqqYglIh+Gx6IPi7LxlVpXe0SHQ==
X-Received: by 2002:a05:600c:4e13:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43f2d7b8862mr31752685e9.10.1744283452746;
        Thu, 10 Apr 2025 04:10:52 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm47242725e9.10.2025.04.10.04.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 04:10:52 -0700 (PDT)
Message-ID: <a7989f85-7699-4b90-9328-9480297a1765@blackwall.org>
Date: Thu, 10 Apr 2025 14:10:49 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/6] xfrm & bonding: Correct use of
 xso.real_dev
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ayush Sawal <ayush.sawal@chelsio.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Louis Peens <louis.peens@corigine.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-kselftest@vger.kernel.org
References: <20250409144133.2833606-1-cratiu@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250409144133.2833606-1-cratiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 17:41, Cosmin Ratiu wrote:
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
>  drivers/net/bonding/bond_main.c               | 113 +++++++++---------
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 ++--
>  .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 ++++---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
>  .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
>  .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
>  drivers/net/netdevsim/ipsec.c                 |  15 ++-
>  include/linux/netdevice.h                     |  10 +-
>  include/net/xfrm.h                            |   8 ++
>  net/xfrm/xfrm_device.c                        |  13 +-
>  net/xfrm/xfrm_state.c                         |  16 +--
>  15 files changed, 182 insertions(+), 161 deletions(-)
> 

Thank you for following up on this. It's definitely not getting cleaner with a bond
ptr in xfrm protected by two locks in different drivers, but it should do AFAICT.
In case there is another version I'd add a big comment of the locking expectations
for real_dev, and maybe in the future it can fully move to the bonding as well.

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
 Nik


