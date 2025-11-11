Return-Path: <linux-kselftest+bounces-45332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69BC4EE99
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 289D834AD5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF4C3659E9;
	Tue, 11 Nov 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USivKnOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902981D86FF;
	Tue, 11 Nov 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876953; cv=none; b=mmZsUAowpX6mH/sX0jRN1e5jiLu3OyUOIuTveHM8gpbl1Q28hz+90KrrE1Aw06OqPqxL7pnzlKi6a0qLiN1qAyM3SHzNh9veB2ISe/9IDh5b0CpmOfuzWt1nA5MPZLT1H/0BO17ptgkfH3hkZ8jdr60GCDHf1pVSndoV5i9lZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876953; c=relaxed/simple;
	bh=oeHpY/ZFSAk4R5LQf2bBTq5IFewl+GasH3sF4MmA5sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSrOpAIgWOLvb4KdIx6StvgOBsB12bozsA5VSqsJH0x/nt5wejGOIKujPjpcdf/bV8Yo7Lr05N8Bt+OotH3eFlIfUDls904GA9HPEaKIKxaYUQYmxLf8Ql1cQeM88g63BffR5DHiheJaoQRk8Vtx8/SckfSctr/GIVePoaKMwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USivKnOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949AEC16AAE;
	Tue, 11 Nov 2025 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762876953;
	bh=oeHpY/ZFSAk4R5LQf2bBTq5IFewl+GasH3sF4MmA5sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USivKnOvm9QAcxm0fMqkTcFjh4REGWsF6/i5zmjQWDCeLLnQ/sM1ztOQx/ygGhIWv
	 QMnYYenhDtRFCYHtpA11hA+t+sIMXC5iGTNsTgQ70hs5nZ15Z0BA14j9Q7uY2dhCNC
	 a412cncJJbgnSjT5tzuz1+O5Bdy1VgKTRRuusPPn37rOFMIZaIaRvhjan+ClYhdgP7
	 RmJX5jvq6OnYIiI+uhLxsL/OH2pnn3LCil2nu/D0DJ2CEJ90sL8xFLN6TiHSF9ZHmA
	 Qp4xSCK9yI0LCc21CAVaTRth5LfIgh0uIkGjGbjR4i8EFQIeE7KbztN1Y0azwM5MTQ
	 6W1em3oxXJ8OA==
Date: Tue, 11 Nov 2025 08:02:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/6] netconsole: support automatic target
 recovery
Message-ID: <20251111080231.3a9ffe79@kernel.org>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Nov 2025 11:05:50 +0000 Andre Carvalho wrote:
> This patchset introduces target resume capability to netconsole allowing
> it to recover targets when underlying low-level interface comes back
> online.

Hi! FWIW this is not getting applied to our testing branch.
I suppose it's because of Breno's fixes in net/main.
net will be merged into net-next on Thursday afternoon.
Until then please switch to posting as RFC.
Once merge happens you'll need to rebase and post as PATCH.

