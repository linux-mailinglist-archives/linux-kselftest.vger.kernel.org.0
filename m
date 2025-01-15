Return-Path: <linux-kselftest+bounces-24590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E0A12A47
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC943A58A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD001C4A1C;
	Wed, 15 Jan 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2nwk6R1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7D16DEDF;
	Wed, 15 Jan 2025 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963744; cv=none; b=OcH+iZVyiUHnL0+vBBU8ddgrbevLTA8OL9uLgZNRL/WO0E9K6guV5ABFefoE2O0l+6DkYmkJY3U/dhO5bsu12cQZYLWzGdaDktYCMiiWlSHxKiia5WsYiXVKHyFSWhnSCW+8YGd8xEHIBwLNFT1pfJ2jjEyH1pEY6I9HMhfTrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963744; c=relaxed/simple;
	bh=0w+ArX4GnhxCr5OSQ47y3Vlj9ejytveLGQFBP7Wx1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXV+Ov+IZ5nzQrCNFzmTQwPGyohjZNROTAzXQWu4Lf0K2UwOWFCz+4KtqWvBMPO344otQpo6CtAzQnHePAppsHzz8xleBBuyERRJgz03Xo96Qk0LygYRyt1BcSW7iyWQXa0U0avbWYPTMPSmh1e+TE2fOuqDPmc6LLnGK1ZvjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2nwk6R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9B5C4CED1;
	Wed, 15 Jan 2025 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736963744;
	bh=0w+ArX4GnhxCr5OSQ47y3Vlj9ejytveLGQFBP7Wx1TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2nwk6R1d/klS5LpMkk48y2JBMfAxuooI1n/AGJvkZeG0rAZIxSiDrAiEwkSNDdDg
	 l6N0nDwnPjBjZTKiD8gOOdrhGmF8Yoawz/Z1EZkkrUzsWucjDjq3XCdARuQPQ7U+5q
	 O1oTyIwsqUVhVpQPZuRZ2OTpfkarh1be8h6w50gXvFefmTxZb6lg9055RrVNKgjNzO
	 l1D2Uf8ex7+sgkeLEYeLQwQTYe/ByXnVxTv/8M/vW6n2dB+fWmlejE184In+G5RD7Z
	 BrsP7R9VuOG73y5U/4nlb+ytsp4vSyelmOBjyay3QSdCNB6mTqdC6QB95pRm8x2u6C
	 77CEn3qY5sjBw==
Date: Wed, 15 Jan 2025 09:55:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
Message-ID: <20250115095542.1149548b@kernel.org>
In-Reply-To: <Z4fvl9Rk1tuD7Oq7@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
	<20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>
	<Z4fvl9Rk1tuD7Oq7@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 18:25:43 +0100 Sabrina Dubroca wrote:
> @maintainers could I get another day or two to poke at the new socket
> release mechanism? I haven't had time to look at it in depth yet.

Certainly, thanks for reviewing this code!

