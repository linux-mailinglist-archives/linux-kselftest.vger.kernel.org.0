Return-Path: <linux-kselftest+bounces-36575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B4AF94C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2457E1C880DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB33074BA;
	Fri,  4 Jul 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlyAVyGC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019D2F85DF;
	Fri,  4 Jul 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637296; cv=none; b=HFJPcFORAwmMEKGO4PaCGIz12qq2ftnw+EeJz5guDqp8hJO27VWXzVN3lBn8YUXezTnVUuJB55icpKlZNCLK8aChSkuWkA2/28K/KocZEDpH8scc4x3r14S4/MA/F54Jd+7Da9LjXHc3A0Ev2pYGzga6C2Tw6ftovvRUVpylh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637296; c=relaxed/simple;
	bh=zu97t0DDSsQDJ7BSyHTomzu7j+Hzgvv9X4zrkYV1CrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imZ/iDWxF5tfNCAqHxkN/GLAGyOBJScnoeswBpoh58XBZoDHaSG5N1UQVCIpbXrWlm+FGXlkxXTTHv3/v3/K+UZjKi6v039U1x3CkBtwd1/3TtxYzNaJPaIhX31yXGlx0tfl4I9xlEDw/13pxi9uqDG/3VdRsOONkufOfZydrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlyAVyGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F58AC4CEE3;
	Fri,  4 Jul 2025 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637295;
	bh=zu97t0DDSsQDJ7BSyHTomzu7j+Hzgvv9X4zrkYV1CrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlyAVyGCJKcrsgqyGz1oIrs6IqNHL80nbB7G9IX2C/SuBEepDtb86DbewCIlBPk1P
	 o7YMGpkRIfcGOxY/Zl53CYxXkbBbBZ8ga385uyeALZ3Qb9aBxztMnt544I9GwtPYsE
	 KNs6DdWWlW7hr3fLDhb4avmfy8Gk3MbcefUmNI+RUfq4BuFDwHXM4TCfOucvxXtIPD
	 H9y5h4mR/zFCUr5bUqeyot+hpLcUSG6OJplfC/tPsCWDF4taJrvqWJoocQtJm1t1zX
	 LQTp8vRMAPmZcTel1j/cXcwYyLt+f8dUCrad5V2K7gM+9wbpIyg+Drs57ObOx15DE9
	 zXe7usUscOBSA==
Date: Fri, 4 Jul 2025 14:54:50 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 6/7] netpoll: move Ethernet setup to
 push_eth() helper
Message-ID: <20250704135450.GT41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-6-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-6-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:38AM -0700, Breno Leitao wrote:
> Refactor Ethernet header population into dedicated function, completing
> the layered abstraction with:
> 
> - push_eth() for link layer
> - push_udp() for transport
> - push_ipv4()/push_ipv6() for network
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

I note that Jakub's review of v1 has been addressed here.

Reviewed-by: Simon Horman <horms@kernel.org>

