Return-Path: <linux-kselftest+bounces-43823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA90BFEC36
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 02:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06453A90BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 00:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299E18A6AD;
	Thu, 23 Oct 2025 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s27osoOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667482899;
	Thu, 23 Oct 2025 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180965; cv=none; b=QXG5/ghDdbAET625c4Bi770Qeat+m2m8eZCzyUYplqqNuSu3QgIbP1uLopAi4jizJuZ7znX/vXp7rSbnEfRI5/XuxUhCJ73ox9eDglsl9T6pV7IqJDFfj4rrLdrTWkTkxtdtPFvcuL1zHfrN/SqbByv8Cd6jQCDgYFfCg5G8pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180965; c=relaxed/simple;
	bh=919OIB7G8MYaz4vd3DIyciwxunOCOVhTx3Xiov1GHts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKHcUqoMBniJlJuP8UWZLDumQfA9quhzYlMp2IqGUM9Yl2mnIv6xvcitcAejr+8qdCFs9hR6YZ3ZtuV+XUq/vjwT/hwGx42a+aMByOhjFQbRnqUaxguecF/YoHCZmtNOxqn4iyQ0SewQT9L9zhkfRb/xuHxvTBeu+7sZi515nO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s27osoOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5B6C4CEE7;
	Thu, 23 Oct 2025 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761180964;
	bh=919OIB7G8MYaz4vd3DIyciwxunOCOVhTx3Xiov1GHts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s27osoOfpL8QKkqw2yh4FK25fkGHdNowAoucEE6RMvLRpdgyizdwi3jdNZYGXMGGC
	 xC+AcBzEoj2FPuAfxjgdaT79d++L76FSNO1MhUYZOOgMlT+E01ToxMoOMl/LdgPZMP
	 BNkTu41LztzUE5jWQj6y/2oPHLDeby50biUQCk8v9GnAQhPa0aZUHBQQrncnEI2C0r
	 fySrcZjqJ7IQAugmtwT3mp4wlvbsu72Jmhl5WSDZJ2q8S0bSHh/O4QZIDztRPbJujq
	 lAR+fgN55rzx1LrIOp+2se1ZdyU/NY0ghSRkpza1DISsl6dEkDgMwFNzDXBbAPxCwc
	 3/pNaQAyTcIUg==
Date: Wed, 22 Oct 2025 17:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny
 <borisp@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Willem de Bruijn <willemb@google.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Raed
 Salem <raeds@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net/mlx5e: Add PSP stats support for Rx/Tx
 flows
Message-ID: <20251022175602.560ad464@kernel.org>
In-Reply-To: <20251022193739.1376320-5-daniel.zahka@gmail.com>
References: <20251022193739.1376320-1-daniel.zahka@gmail.com>
	<20251022193739.1376320-5-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:37:36 -0700 Daniel Zahka wrote:
> 		mlx5_core_warn(mdev,
> +			       "fail to create psp rx flow counter err(%ld)\n",
> +			       PTR_ERR(flow_counter));
> +		err = PTR_ERR(flow_counter);
> +		goto out_err;
> +	}
> +	accel_psp->rx_counter = flow_counter;
> +
> +	flow_counter = mlx5_fc_create(mdev, false);
> +	if (IS_ERR(flow_counter)) {
> +		mlx5_core_warn(mdev,
> +			       "fail to create psp rx auth fail flow counter err(%ld)\n",
> +			       PTR_ERR(flow_counter));
> +		err = PTR_ERR(flow_counter);
> +		goto out_counter_err;
> +	}
> +	accel_psp->rx_auth_fail_counter = flow_counter;
> +
> +	flow_counter = mlx5_fc_create(mdev, false);
> +	if (IS_ERR(flow_counter)) {
> +		mlx5_core_warn(mdev,
> +			       "fail to create psp rx error flow counter err(%ld)\n",
> +			       PTR_ERR(flow_counter));
> +		err = PTR_ERR(flow_counter);
> +		goto out_auth_fail_counter_err;
> +	}
> +	accel_psp->rx_err_counter = flow_counter;
> +
> +	flow_counter = mlx5_fc_create(mdev, false);
> +	if (IS_ERR(flow_counter)) {
> +		mlx5_core_warn(mdev,
> +			       "fail to create psp rx auth fail flow counter err(%ld)\n",
> +			       PTR_ERR(flow_counter));

Coccicheck sayeth (5x):

drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c:
WARNING: Consider using %pe to print PTR_ERR()

That's %pe, flow_counter instead of %d, PTR_ERR(flow_counter)
-- 
pw-bot: cr

