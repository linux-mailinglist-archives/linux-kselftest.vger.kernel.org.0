Return-Path: <linux-kselftest+bounces-42481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA32BA3FFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827F2189FB0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1F2FAC0E;
	Fri, 26 Sep 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Lvj0yT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E96ADD;
	Fri, 26 Sep 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894978; cv=none; b=bDYTA7DkxbCbHhR+evwWaQTtTRdFf208RzBYFZkglL4N4dPvFdI5boVk9HzXF3C80P7oAWqr7+kcIOlQx1jE5yFwWGQb8CdpekordkLIB/WgFMu0Q2RRNNxUhsQck3xlpaR/RWCBotVN8PMP45mIBxHwpkL76OVDn8eXW+2pQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894978; c=relaxed/simple;
	bh=e1CHJ5lT/X3OXUxAXjj4eLPvofausX+z7gYzrWuaU9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCluTPUMLXqbuaRu45o51Qyg3gYIFItQgUz/m5JtzDdCvNJweIKn1HOTzp2SzMUkSzaSaNwfZSsQQDhqx8/amvn/YYBr56PoOdVj9mIZSfuAZkmEkst9O6kmZu9VS0eJhSUhMGLoBz7v27Jk206zCqwKLGM50CJPAtkaWmiQOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Lvj0yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09206C4CEF4;
	Fri, 26 Sep 2025 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894976;
	bh=e1CHJ5lT/X3OXUxAXjj4eLPvofausX+z7gYzrWuaU9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9Lvj0yTLlAbJtzK7KGZFMEXmjzb1P6pXZehlQABL8cUR2muHifwPIYo98Tfy9fYB
	 v9/0sMrUdnGQ9TOPgA8rxKpbCFvmh68fwOWIs2Yzjx+4SX8pgCCQT1qUKg4qjpi552
	 NWmw/EaIG0XoMYpS1uSEXBRh6iOCj0rNHSFwhfuj38/vZma8Jp9YleEH1O0m51S8VH
	 u21bvP1N9RT4a4m1TU0BFcr7euGqwsbcZHVC0NjmDbwvPdYy9LdIJN4sCK44J+LZTd
	 LGupn/iPPmPqngQ8VW3eYlhp6mQjLatpxmJ7P31IX+Ft78W1zok6CDfe8agv7QODyq
	 +tOSexi8JFJJg==
Date: Fri, 26 Sep 2025 14:56:12 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>, David Yang <mmyangfl@gmail.com>,
	Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net-next 11/13] selftests: forwarding: lib: Add an
 autodefer variant of simple_if_init()
Message-ID: <aNabfP7-rLyfgTDn@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <6b9ee1a7946a36fd32a47fdb1aa9325198ffc695.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9ee1a7946a36fd32a47fdb1aa9325198ffc695.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:54PM +0200, Petr Machata wrote:
> Most forwarding tests invoke simple_if_init() to set up a VRF-based "host"
> and simple_if_fini() to tear it down again. Add a helper,
> adf_simple_if_init(), which is like simple_if_fini(), but takes care of
> scheduling the cleanup automatically.
> 
> Convert the tests that currently use defer to schedule the cleanup.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


