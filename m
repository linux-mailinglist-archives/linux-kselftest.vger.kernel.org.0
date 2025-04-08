Return-Path: <linux-kselftest+bounces-30388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCFA8193E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B54F1BA28FD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADACB255E2F;
	Tue,  8 Apr 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax8+5rrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE123FC4B;
	Tue,  8 Apr 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154460; cv=none; b=bVWR7NUDDkDas0QLPIFO2u4k8WfaEYCjnzRDc+tp/zu2aQ+l0xp2XPvh5Fi1QsDA/S74RKpdOmgiyIElr0rCwnGuhs+L5eFfvbu1rBdkLx1uKJLAd+ySU6Sh+9y76v6uCJmXBJytvrfmHB7wezEc7VsGtvg+Lq5GaVZcOF4Qzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154460; c=relaxed/simple;
	bh=vWGLK4hJ97VHXRESfYlQmWSZONEI9Yy7VflJj/ld8go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDs/Kg6KLggCo2w2x4cQBusqQePfxY/c1MnuLNLlBm1BoZn9/Xw6Y7bMUrBvlZePwCrrA46WRKamWboSs35jqDYVTi5FQ2z3B/mYEIHaRPzy4KwEVmWMtwuzVKvLVvNbqEr0qSQdXeuIPZd/o9Xm7dSx0BdAhaeCGHirDV45bDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax8+5rrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7E1C4CEE5;
	Tue,  8 Apr 2025 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154460;
	bh=vWGLK4hJ97VHXRESfYlQmWSZONEI9Yy7VflJj/ld8go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ax8+5rrIuTA3+fEgyYs8DnFMpJrqLoJBjDLz+FlGqCTw4lV6sCTPQ30B5pSEaDqnn
	 vYgscZOvgv2UHmLiB1NIhktAsVOBJl08iwwXiwVx2nTKYsmdcAbuUMYcsQeK5WQSAz
	 +B7Lb5NzciL7izP57sYzwbZA6mjDVc4jEZaVa7sjjhxvi1YzMp/F+QmN87wne2+Al1
	 OrF2S7RI0r6XtDcfTkopRBQG3J/9Z8kG9m9rUaQ23pv0bSspFDdoWX2TVmfVbXNi44
	 WAZF4sr8DCz80/pwEuTSC9PwrBtPlef1Gfx5GtCrxrxM1qr5UrYKypRpIPRNDCzNxr
	 /QuiJHgtjb2ag==
Date: Tue, 8 Apr 2025 16:20:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Louis Peens <louis.peens@corigine.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] xfrm: Add explicit dev to
 .xdo_dev_state_{add,delete,free}
Message-ID: <20250408162058.36a44055@kernel.org>
In-Reply-To: <20250407133542.2668491-5-cratiu@nvidia.com>
References: <20250407133542.2668491-1-cratiu@nvidia.com>
	<20250407133542.2668491-5-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 16:35:40 +0300 Cosmin Ratiu wrote:
> @@ -424,10 +424,10 @@ static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec *ipsec,
>   * This copies the protocol keys and salt to our own data tables.  The
>   * 82599 family only supports the one algorithm.
>   **/
> -static int ixgbe_ipsec_parse_proto_keys(struct xfrm_state *xs,
> +static int ixgbe_ipsec_parse_proto_keys(struct net_device *dev,
> +					struct xfrm_state *xs,
>  					u32 *mykey, u32 *mysalt)

nit: you missed a few kdoc changes in this patch
-- 
pw-bot: cr

