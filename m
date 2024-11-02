Return-Path: <linux-kselftest+bounces-21334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6A9B9C55
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 03:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59A32825C3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B484D3E;
	Sat,  2 Nov 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP9R9KUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E417C77;
	Sat,  2 Nov 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730514461; cv=none; b=KhZooyW9uWKnMsA1kEQCe2QweztfA23CiT6XqIbVoY2CklUbEIRwSRlOvx9xx5ROcXvbVQYePaQDQzH3Q9yI0I2+4xPLMyz33OB6nEJgMXURbQsstlLu2X/aFRipHPqhmYanaP5zDtYjQCdYDHOGyRoxnE+4LXyBqh75BzyRql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730514461; c=relaxed/simple;
	bh=sPYoohuUKK83shWXXrl9HVtz7juTaHQnwiFqwA86XqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb+JtbW+1/UpP68qJavMGbvKYH7u6eCEWJb995NWKmQXCVWYeD4obo1eT1UJEq3ljEKpo4MVIqo9ShrUtGq4GLGjSHOR5JfhX/Vqa2+kuBIXM/UPhVastQuZXa1R7AtBungeJeU1TPKaRCPKvZWM6YhXHe8yEM+zohTURLKCCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP9R9KUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411BC4CECD;
	Sat,  2 Nov 2024 02:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730514461;
	bh=sPYoohuUKK83shWXXrl9HVtz7juTaHQnwiFqwA86XqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WP9R9KUiUY+3RLIYe9ojB138Hh4EkYCV4mjCOYFMtfhjUuCu2jHHKOviFqF9bXAs/
	 3vCO5O1d7IbfNgNYhbqZHNZ/xMGuEr96ShGiungiX9whZRgJhVsxnHfXi58mVVY9M3
	 0u2qFnflI5O3HQMXu8C5TAA1sneuo+/9xjo3FAbEoIvvIlhPP6nKnJ/CewpKtFjz9s
	 htPBiOp2okdIR7KOZrViiKubr/uLwG2DtDdm1UIdDLmozcyBx9IlUHv24o0bghv499
	 cMkTMStSW0usiejmnIiPWyCWRBbmaprkwmRX1a7REXONLkym8zjQLxKBIbo8Em1rW7
	 aLVa/fcep/+Aw==
Date: Fri, 1 Nov 2024 19:27:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 0/7] devmem TCP fixes
Message-ID: <20241101192739.6caece56@kernel.org>
In-Reply-To: <CAHS8izO-UhDfctAsjpdipRV=WyCvUAu9VnAes0mBe2wSvV3_9g@mail.gmail.com>
References: <20241029205524.1306364-1-almasrymina@google.com>
	<20241031194101.301f1f72@kernel.org>
	<CAHS8izO-UhDfctAsjpdipRV=WyCvUAu9VnAes0mBe2wSvV3_9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 06:14:14 -0700 Mina Almasry wrote:
> But what is the 'missing input validation'? Do you mean the input
> validation for the SO_DEVMEM_DONTNEED API? That should be handled in
> the patch  "net: fix SO_DEVMEM_DONTNEED looping too long" in this
> series, unless I missed something.

I guess it's borderline but to me it feels like net material.
It changes the user visible behavior. Someone can write their
code to free 2k tokens on 6.12 and it will break on 6.13.
I don't feel strongly but the way the series ended up getting
split I figured maybe it was also your intuition. If you do
follow the net path -- please move the refactor out to the net-next
series.

