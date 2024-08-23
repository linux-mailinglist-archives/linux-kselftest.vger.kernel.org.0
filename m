Return-Path: <linux-kselftest+bounces-16170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD695D497
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9617C1F2450C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31C190064;
	Fri, 23 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/6S7+ws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6308A188A1E;
	Fri, 23 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434962; cv=none; b=Ic0xHgCt2LXealK4blHfXXcG8FGQ+93Pd3uoQuRk/Sgtxz2Mn6ZmKxxb3GO0gt1gyQ8LURZjrl3XeWfAtRvl9G+Q3bTnmlXe9FOJFxXCokBppj88HRtXqQKfuZb85vFHeBx2KonpfY+2egSbTfaL+tjFSQYO0e+F/y89fARNy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434962; c=relaxed/simple;
	bh=UVIRHLZjkY7DgcbSsxoWvwGvV2JG2+bFLhV/5mAwIjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZScuayWQYBMPkey2grBzI92a5kA3dlwcG/Ben5RtwGtKZKT6F90Brj78mYg41i2AW1OxFzGlTKBPlbUe2c8vxU4G7yZuSfGvdLFB0BA8G0M3ZfJvkNSyJ0ErJ2+Pj48SZG2vPNBR0QL/ypxDH1c5efC2L1w51IObicH7q6moNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/6S7+ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8CC32786;
	Fri, 23 Aug 2024 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724434961;
	bh=UVIRHLZjkY7DgcbSsxoWvwGvV2JG2+bFLhV/5mAwIjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/6S7+wsL62t/xkuRBeOJJ+UPyIz7IGzGvUxdBS0vnmwvsK44fN5L4o89QPtstFIO
	 QdXYxHCQZv0HXVjylHONFcl/VYBwlzz9d8cSkVhqhVA4+kMOwEIrGmK6avGL4p9Dcm
	 xM/9btzp3QC/qRFTwPlCj6XiOUQIo11NeZX3EmXWfcETpYGOGVvGmRIPSxxtUjoQbF
	 +TIDKyYM5BTfeEAYFR0RkkSe/K9PsKApsD4BVNaCR2k+WWtSNY5A5fo5qnZiUraFZj
	 adXSiXpz9NfKRI/4eLmutxNKd//Q6A69wdnUPusly4qFR6wmTB+TTXUQGZEJdc05mZ
	 F6+nHUtF911hA==
Date: Fri, 23 Aug 2024 18:42:37 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftests: forwarding: no_forwarding: Down
 ports on cleanup
Message-ID: <20240823174237.GC2164@kernel.org>
References: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com>

On Fri, Aug 23, 2024 at 06:25:37PM +0200, Petr Machata wrote:
> This test neglects to put ports down on cleanup. Fix it.
> 
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

