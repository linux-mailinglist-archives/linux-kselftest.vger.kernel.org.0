Return-Path: <linux-kselftest+bounces-36574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF1AF94C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA5B5C0CAC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FA30749E;
	Fri,  4 Jul 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4qnshEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CE1FC3;
	Fri,  4 Jul 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637261; cv=none; b=R3jJkYmbIyFifbw3DsIhCEwvkHop0vGuG3luNqphM4bnS7inp1qBIwYP9AgILeLouQ/jo3mCxLvjPhysa8v1wE9tazYW8Na2yx+cmbZsOEgPbqwTL/CJjUsdvCCnMPX5Vmi4GOmYKfMQqKPvmjIzeU9Q4LSnHpQsfuqAfJ8kVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637261; c=relaxed/simple;
	bh=4ayEkfBXxX5gmDnrqD6eA3letENoiIO0XL+wRQWHehk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJkXJs0eumnjd+Cjvf65TsHuptlz1R1EHG7/wXJj6Gmhq+ZMaG4gU8SKYvIgUP8/G1F9x5TBUWc8EiTlh0UyVv8XR17G/OIuhf7u247husIUPTKMzVyUL7ahXJeUBCX9yY/bBOmhoU1y2+ET48J79ERVsG3/gwD3D+yPvHUvKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4qnshEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70065C4CEE3;
	Fri,  4 Jul 2025 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637261;
	bh=4ayEkfBXxX5gmDnrqD6eA3letENoiIO0XL+wRQWHehk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4qnshEVEkSe4etrajOTWo18roCWfSwx4YvPHZjqNRbm8QhRnwvney6jPwv/nHsca
	 8BM/qoEZprbz5RPjAsJqCdVHP1AQu+2CTUKJHOoL/eT0k8T6B5bQFEVZCFBb4gjOV7
	 RX+IhJ7YvpG0g590+BaU3GRlzh+YdQgzOuNzuZqYsoy8r907rpWkw2zTlIuO1pSXFU
	 CsVA2j7tRNbHzXcaSxexn09L0gBBgY/5a4a4JgTIMtU/AprsllPe728Xpx+xErc+M1
	 MoM1jDFA24SvCKVqVwWdgvNc/kz4E4cIHKYxZE4eBIJ1SQW/fbtly6+TtKBU78LQRf
	 Llilw/z59xyKA==
Date: Fri, 4 Jul 2025 14:54:15 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 5/7] netpoll: factor out UDP header setup
 into push_udp() helper
Message-ID: <20250704135415.GS41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-5-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-5-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:37AM -0700, Breno Leitao wrote:
> Move UDP header construction from netpoll_send_udp() into a new
> static helper function push_udp(). This completes the protocol
> layer refactoring by:
> 
> 1. Creating a dedicated helper for UDP header assembly
> 2. Removing UDP-specific logic from the main send function
> 3. Establishing a consistent pattern with existing IPv4/IPv6 helpers:
>    - push_udp()
>    - push_ipv4()
>    - push_ipv6()
> 
> The change improves code organization and maintains the encapsulation
> pattern established in previous refactorings.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


