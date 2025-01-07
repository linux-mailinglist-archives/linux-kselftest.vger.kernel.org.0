Return-Path: <linux-kselftest+bounces-24031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5DA04B16
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3303A4C7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052731F669F;
	Tue,  7 Jan 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IincHyk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70F1F63E7;
	Tue,  7 Jan 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282288; cv=none; b=VAFZVz54otiSFrvgspvOsHRhhdSKY6YGtyZEz+ilrB7VAhWOqQveKL9u6DCR1DM5OhXNDxxexIj1JIYjEWELOGnVISnUqDHvyieOccG2KfQI7jLz/sOna87UprnzMxvxwMO4DhsWUksL+fJFY7WYfyf6s7mclZ+Wm9/hbzDxVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282288; c=relaxed/simple;
	bh=xVENo9muNO/TQ5xVqUKOs/5Q4+G96PW1sKSnQr73q9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U14vuusbfwKnu2pH69MbVBc1eKEdkMX/chwVTNtajetkhO6xwi7m74cLY/k8ac5c+MX0RrI206b704qlUqOaXdM+aV6iQbzq5lSl28FpER3LUPzbZkMsV6KrnqF5mB4CstaLafwPTymWoZzNYnWuqkUx3PnksWlv/MrGPfzQJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IincHyk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D5C4CED6;
	Tue,  7 Jan 2025 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736282287;
	bh=xVENo9muNO/TQ5xVqUKOs/5Q4+G96PW1sKSnQr73q9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IincHyk5dnHSj14WBxB3nZ8H+ad7Wv7JCDFqB3ioz1CyxVIL28f/wayA5OfnPboFy
	 w4bYeV8oyIpNsDF2th/1YTvksDeeiWBKLOGweUN5unnHCsYuY6UO9/ov33L1S7sVm+
	 1K3BnLtTw6iZPtOBVnjoMMzolL2SbZULRRKu+YNbYACOMPPIofT1Am+zEPd/PAx/vs
	 ld0p/Rkjj2unh6Png65S7WHaBoyC3nNe0ZjG8UBnxGV+bt8cBPNwF55J92ceGMmf0M
	 9p3XnJzVS37fvnQRlLFc7Do5qJjEPxgQYy5375IiG9MyjZthi5D9QPQCuQtvR2QVYT
	 LbPjcwrrJqcnA==
Date: Tue, 7 Jan 2025 12:38:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/11] rtnetlink: Pack newlink() params into
 struct
Message-ID: <20250107123805.748080ab@kernel.org>
In-Reply-To: <20250104125732.17335-3-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
	<20250104125732.17335-3-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jan 2025 20:57:23 +0800 Xiao Liang wrote:
> -static int amt_newlink(struct net *net, struct net_device *dev,
> -		       struct nlattr *tb[], struct nlattr *data[],
> -		       struct netlink_ext_ack *extack)
> +static int amt_newlink(struct rtnl_newlink_params *params)
>  {
> -	struct amt_dev *amt = netdev_priv(dev);
> +	struct netlink_ext_ack *extack = params->extack;
> +	struct net_device *dev = params->dev;
> +	struct nlattr **data = params->data;
> +	struct nlattr **tb = params->tb;
> +	struct net *net = params->net;
> +	struct amt_dev *amt;

IMHO you packed a little too much into the struct.
Could you take the dev and the extack back out?

