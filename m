Return-Path: <linux-kselftest+bounces-16754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968269655D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C862A1C22922
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 03:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E4136E3F;
	Fri, 30 Aug 2024 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlzbporL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD701C6A3;
	Fri, 30 Aug 2024 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989523; cv=none; b=D5gxKxq/iUEAIRbG3wG584u3d3alE2AP5red2bRJJXObnlHcfQ3ZrWexKNEYjE9IBoeAS9M3cqiyCFe9NLLpI4dh9Nrl4PixqAYvLHZng6RZ/cSQl1hUcSJ7ckgy/qSG3RewPs8Te/GiNKsSJ+46voKSLVlgfjRcAFjiR8X4Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989523; c=relaxed/simple;
	bh=J0xcFtuFPZUXJynAtbT08s4tUtEpPVtHxpNGZt3XgDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxFmYlol1Eg0IYu5HJaCHPZbBfbhRhZIxksR/+LvOH5v+5jzmrx44mU2Xcsvf+DP/adlhnQuu43PNTgYj+tsCiP60aQPTQIbGtqXe5URfVdhiypflZEX1VWe4c/d3pHe9+JplgdRQ1ZsIqvVOKkyvtbkoTL7hDv7r1ae22Sl+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlzbporL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604AC4CEC5;
	Fri, 30 Aug 2024 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724989522;
	bh=J0xcFtuFPZUXJynAtbT08s4tUtEpPVtHxpNGZt3XgDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlzbporLxIvpzCHNOAv7c2P+SbtwYFAtpjBmdhyOeyTVSpNybfjoQJNHppWqtJAuN
	 UIzu7390vLuntmQMw/+spSFSQJXsBIxPEJscmveAfmhCJqlGqB3bQnmylAOaT4pB8F
	 kJ75NYgv8nVHKKk3WFgWj7ZViSjASx7Ngf0aZMpeypaVV0kjNBpGXX/0dSJ+pW3Mh1
	 Loxb3PI0fqb7/D3S3dXv1hiOqgFLr7S0gsQQbV3cbiLFYDPxxEQl1GUBVVrdxj7ZMt
	 0HwtcB9nd3IxrxuN37d5TYM0zCWsevKhcOn/H6GfcR/gXhwHke55yRAmzhhpatY2od
	 AA8nB/HX3ILFA==
Date: Thu, 29 Aug 2024 20:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com,
 edumazet@google.com
Subject: Re: [net-next, v3 0/2] Adding SO_PEEK_OFF for TCPv6
Message-ID: <20240829204520.3d118950@kernel.org>
In-Reply-To: <20240828183752.660267-1-jmaloy@redhat.com>
References: <20240828183752.660267-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 14:37:50 -0400 jmaloy@redhat.com wrote:
> Adding SO_PEEK_OFF for TCPv6 and selftest for both TCPv4 and TCPv6

Applied, thanks.

