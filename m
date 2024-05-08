Return-Path: <linux-kselftest+bounces-9668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCE8BF3BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 02:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A73B21E8D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C521A2C1B;
	Wed,  8 May 2024 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZxfO6uu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53C7490;
	Wed,  8 May 2024 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128488; cv=none; b=JuBDqhimWQdQlESGnPs46GJs/23TLfcuTveess0+l8rQGgwe6oGaa26srL/7sMKla4e3gGucXoYzqTsSUsHWKOwF4hGVm2naBGdCzYs7rxuPEv0CsBMiUh3N/sDABmXf2w2u+eIYMiDuCpkJ46eTKwfkxUSEVQ01tMlR4xTlpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128488; c=relaxed/simple;
	bh=KMjZdINE6p4LPP83BwN/kf1WG3JBITPmf6n2KYAIkwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBmIMB8/cOimdoWa4trE5r79vPnDrxV65p2wgcC2ABPlbCGoP/nG121OW2LgC18IoGXRWcMjC/UcwqMw/JdgJdFmmpbMLsNXWw79XTXoXZCVbgu5zCc0OMPU2lg+jes04coP/Sb16l/fYK4pdWTvYMI5aB78B21jZ5LRbLdd8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZxfO6uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5563C4AF63;
	Wed,  8 May 2024 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128488;
	bh=KMjZdINE6p4LPP83BwN/kf1WG3JBITPmf6n2KYAIkwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZxfO6uuR0sJsZ4maM3E83w8LHyCysvPwHU9Kwn/G06Zbv4L2e/hFTq9GUS5Ai1SV
	 dS2srV0P/M8Wy15kUE5x+9yxIpbJJF9kzZBsOxYvlNG+SPDOb5Te1nRAP26K19I+z1
	 Egars8UnKppMv4utEWCCS29OKItnDCev17XefLnfZorFryFeFWCrUNtdVCrTR/1OT0
	 oVq7c/WDtgjsh5sNvDOq/ZIKGWHLgyysT64CGBp1cgL9Ij5Y1z05BX2QU17eSJ3XlA
	 TweCwTcn3bxY24+CITarXvlNVsUhsNTPQo/nnVFfhXRmOB6I8jJVH4L/31eSJGwo8Q
	 AwqETHFwAltDQ==
Date: Tue, 7 May 2024 17:34:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 alexander.duyck@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/3] net: gro: remove network_header use,
 move p->{flush/flush_id} calculations to L4
Message-ID: <20240507173447.015a03a5@kernel.org>
In-Reply-To: <20240507162349.130277-1-richardbgobert@gmail.com>
References: <20240507162349.130277-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 18:23:45 +0200 Richard Gobert wrote:
> The cb fields network_offset and inner_network_offset are used instead of
> skb->network_header throughout GRO.
> 
> These fields are then leveraged in the next commit to remove flush_id state
> from napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
> unnecessarily complicated due to encapsulation support in GRO. These fields
> are checked in L4 instead.
> 
> 3rd patch adds tests for different flush_id flows in GRO.

Doesn't apply to either tree, please rebase.
-- 
pw-bot: cr

