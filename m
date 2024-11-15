Return-Path: <linux-kselftest+bounces-22102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16319CE2E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A504B1F21C7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AB1D3194;
	Fri, 15 Nov 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG+7viDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48D1CDA2D;
	Fri, 15 Nov 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682337; cv=none; b=JMCqP5Jo8ujY6azWGktW8VXUSSbDCwzBjJe1EN0UDX07i/XAQNwFSZ5A15qznHUc/GkzXYftHJM+KRRzdqdWm5Pgv44HNGITiNPT/Bor7sUNXQcYPkhbfmiEHDIacYO/Q+dNrhc8zjJUVZdpUckSIybgCGLV1CYivb/+ZRgmyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682337; c=relaxed/simple;
	bh=Maia2BdeXxH63cl9QjSddCcMACjiF2xzxEJIXupzsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+YwwfPYA+NfbCmcyP3MsVqqZIF/psZnTIt8fSJueEPpgM9gfCebiHgHphtpdqD67COTjsOIbVdzllApjmlezBZXY7eW31nSAnbsyashtTR9h77lsL6aZyH2ObF7kI1WbwIZ4wAVbmtqLVQwyrcsjoy3DRzo1f+gUdRE46Z4D60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG+7viDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF6C4CECF;
	Fri, 15 Nov 2024 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682336;
	bh=Maia2BdeXxH63cl9QjSddCcMACjiF2xzxEJIXupzsLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kG+7viDWNa5z0nmB5vj1Ru76dk3TQyRaK+63XBqVtku2JNhSRo1gQbYFDkYkBgL2m
	 xD7MKcipAEx/2BKWuTxfEK9bW75KjPJou0XvAdyewX5aRVnqyqDYd/FpU4iXKv2KvG
	 bz4p9il+3RcRTJHdAe/IjNSuuo5POd8RiS0vKKlQwIX5/jDhwCp9EeOgnozVgQCDWZ
	 r1Awgtu//2dphLqhz/cFxi3iRWi7ICknq87DCRs85axCQSsg2DDkGJmJGZRUcrsZvf
	 N/+YK8c0Hr8sT08nOdLme9sdG8mzNSurTroTzH66aHW3tYi2XJSC0wa4l7jhZxQTmV
	 c/zzX0OgV5aCg==
Date: Fri, 15 Nov 2024 14:52:12 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: netlink-dumps: validation checks
Message-ID: <20241115145212.GT1062410@kernel.org>
References: <20241115003248.733862-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115003248.733862-1-kuba@kernel.org>

On Thu, Nov 14, 2024 at 04:32:48PM -0800, Jakub Kicinski wrote:
> The sanity checks are going to get silently cast to unsigned
> and always pass. Cast the sizeof to signed size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Ouch. I checked and I couldn't see any other instances of this problem
under tools/testing/selftests/net/

Reviewed-by: Simon Horman <horms@kernel.org>

