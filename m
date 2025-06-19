Return-Path: <linux-kselftest+bounces-35378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D7AE0B92
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBFC7A2107
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2428C2D8;
	Thu, 19 Jun 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY7vGU5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC15213259;
	Thu, 19 Jun 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352317; cv=none; b=Hk8e1GJPLR1nhYKYmKvxm1xIN1GJ2cugyVTB1mdwvyNfNk1Ax/k4ivneK1esNhOMOgMP9IU6xq8iArA7QFvjm77Mvukr7houDR0Y6qs/2nF3L/xlee4ujdML0NTifV2CtlJf+o5y/m6rXVu+xbrAEcPrgdRvNbb1sO9969Ps27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352317; c=relaxed/simple;
	bh=+wGRBZ7uDacbFQxuF7M0n8RCOgpm3hYTgu9cP9lJjPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsX/tNpw38Q8EJ4noJ9ONeRMLm4C9MTNX1hkgeD8AAx5/CwOEa+U+TgL0Lbl9jEfwjM0cNHePyW5PrFyVN4GEDPdx02e9Gdpl7pNIL6LZuuzX/LOyjBUanAo/UQ72vvg8AW7RrON0HlC/lhiM71BNkcf5z49P1GqYOHhU7iZPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY7vGU5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D7C4CEEA;
	Thu, 19 Jun 2025 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750352316;
	bh=+wGRBZ7uDacbFQxuF7M0n8RCOgpm3hYTgu9cP9lJjPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nY7vGU5twz6IL7HgE+qhjiimHSWzpKYIerpgyZDdiN8ch5REWxdTqPfCOIuqmAeWB
	 MBuKbgCEsD6O//s5SMeYK/wQoze8vcZmya3dhzpIvb6uKW5hSXgZ+u5IZmzCsm/dvv
	 mF5gqTQjpT73wxMXHNVcY42fo5lMojZwVxj4G8coyhlYRvc3G9rPama9vhRvHPxALW
	 dAk9QPpdgv0ONeusWMMeJQGm9cYuYg2DKNdwaaxN+78TMlH0U2xEJU97/RMGEbpP1j
	 qwejRaGe25pVHDuvdpoAxzVm514sNofEIcsSYiaZjWarCjB7xlKt8wFK2htpC4YWp7
	 oWOhuFlVgyrCA==
Date: Thu, 19 Jun 2025 09:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Ignat Korchagin
 <ignat@cloudflare.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250619095835.6ef52aee@kernel.org>
In-Reply-To: <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
References: <20250615205914.835368-1-almasrymina@google.com>
	<c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org>
	<CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
	<f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org>
	<CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
	<a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org>
	<CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 08:37:05 -0700 Mina Almasry wrote:
> Jakub, this patch was marked 'changes requested' for good reason, but
> after investigation we found the patch itself is good and the issues
> were elsewhere. What do I do here? A resend of v4? Or does this un
> 'changes requested' as-is?

Do you want to update the numbers in the commit msg?

