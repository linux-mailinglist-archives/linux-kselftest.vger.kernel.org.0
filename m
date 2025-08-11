Return-Path: <linux-kselftest+bounces-38686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F32B21226
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D22C1882A34
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36742522B5;
	Mon, 11 Aug 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDi+FP9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533B1494C3;
	Mon, 11 Aug 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930009; cv=none; b=ofrpNjVegsXxXzAUCq8BhJe+BGlqf6wCA8GQhO3bcV4GEFL7aLeX7O5XYu9heVj+tBJXAv8eyi7ZJ4evaqw98+B0G9CjabGyGoPLoLExZgaX2b1+oOsZWz6lM9YRYpXlDSrIS4aTxKtZdYsN5mfeH9rDhTdqS80fEeare3vTFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930009; c=relaxed/simple;
	bh=DWcUTl2SHn7hqoaVo7YianA9NpidcOYnkPILUtfu+ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3leEhEoVESsqGfozVlYznm9IpveItxLQyp+3aBGP/eCBJCQcQI7yGWDrW1XEnsIXbnJjRUVtzPm6zr2PTZnjGh68+qFPQ6XMq8+DWFL5+hOd1kJ0eRbbLZlgfnJTjWBZEQb76zVgr55zZjmJZAb5/knq38KpssSbHXYvz8PKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDi+FP9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337CC4CEED;
	Mon, 11 Aug 2025 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930009;
	bh=DWcUTl2SHn7hqoaVo7YianA9NpidcOYnkPILUtfu+ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDi+FP9fymM59E16Gk9pyLCUSHAzgYoWpj2Ku32MvF/2uINGQ4jeXGTfBcQtU5bpn
	 lWSS6jO3B9+K9YyPT9OuiJPE1tBgZJz9kHme8+8/Igps0bW0JROgoAoE/tfpfTGTUs
	 04DlxUoLDx5eJqV8zSqsqWyywL9qSJ3j3QJMcEMooWOIfcBGsjYwGw/DxZTkZrlDvW
	 odjbdWCMqVDZ2taL1Gow6Jf+Wv7AAx379bRC+q/qA7erFAxFXWjIFewd+TL9O7mMzK
	 k48GViiV59N3gHlE2bfW1gwLasCooZI7USvS2QiK9EY+a88T561B7N74mK+QVGhZpU
	 AUrbsc7j5SeHg==
Date: Mon, 11 Aug 2025 09:33:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Wilder <wilder@us.ibm.com>
Subject: Re: [PATCH net] bonding: don't set oif to bond dev when getting NS
 target destination
Message-ID: <20250811093328.70343754@kernel.org>
In-Reply-To: <783435.1754922439@famine>
References: <20250811140358.2024-1-liuhangbin@gmail.com>
	<783435.1754922439@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 07:27:19 -0700 Jay Vosburgh wrote:
> 	Generically, I'm wondering if test updates should be separate
> patches from the functional changes as a general policy.

Yes, not sure if we made it a hard requirement, but I think it's our
preference. It is the reason why we don't require cover letters for
submissions with 2 patches.

Hangbin, please update config for bonding tests, looks like vlans 
are not enabled there today.
-- 
pw-bot: cr

