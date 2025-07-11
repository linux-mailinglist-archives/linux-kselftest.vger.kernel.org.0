Return-Path: <linux-kselftest+bounces-37172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC90B02720
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B67D56872F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56338221F10;
	Fri, 11 Jul 2025 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s45j/NP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E221B9F0;
	Fri, 11 Jul 2025 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273704; cv=none; b=W+6qI6SHpUAvXFjoB1iXP/nANeYXx5pnlo1CgdIo417cUPyyzIIleHEmtajRzVSuEX+mmD4i8PNaSN6FQGJdlOLkUYG6iYEgBmHsrGgCl5a9CzR+0uo6SLjbYwA4OIkLWB4TbUj811JU7RR3Ucvvwl17itlsBqX0LTfs+1/KgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273704; c=relaxed/simple;
	bh=Ry9YoQUwtvmVPYEVrTNJ4go4dFDZm/1iipmepvGODnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmijjk6tLFUQGOl3G2X0MycQxlKoI6CVghYevO9yUQmahhJK80RWny77/LpIMMdYhfikF5RCz6ehuAQRspxuBwTFbHDIp4UHNPwxaM7Q5O/O/L8Tbhv4Vy8Etgj24owrr3eT8ylilpZwwjHLmgzV5UiJGMa7xuHfmTRJPR3MDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s45j/NP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA77C4CEED;
	Fri, 11 Jul 2025 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752273703;
	bh=Ry9YoQUwtvmVPYEVrTNJ4go4dFDZm/1iipmepvGODnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s45j/NP/GP1dVQx6pd8KivqCSt8sUBVZkt97NM8h51AXzvv2SoT/KL3leO39HHKdC
	 SgaUV+m8Yu+BcOehO8fDmUqzdEisu3vscF88nhw1Lf0gUoy8d/jfvB1x8ApbpF0sbM
	 Yx3BXb9Q2aBord9Ffb5qpjcXquL3FrPIqt+2KJXJ11+CbgqpCGK0N27bXSytDyODaa
	 Jj/idbOlymdVHwOQpdEXzi307oozaS18pV51uFxR0/h87Xee3xkRKKe2Kzkwv0L7DU
	 IEr66ABuix3cntDF3xR2B0ainjr2yMVab9npohhOXekP5rZ+4R27SH7vJN7RzD/9tL
	 efwWk6qiauf+A==
Date: Fri, 11 Jul 2025 15:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v5 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250711154142.369aaae1@kernel.org>
In-Reply-To: <k45gwtae6yx3cjy5kprctlnw4wox5fnfd5yjlczgpyu2cw5bsj@dol2der4ykat>
References: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
	<20250709-netpoll_test-v5-3-b3737895affe@debian.org>
	<20250710184535.374a0643@kernel.org>
	<k45gwtae6yx3cjy5kprctlnw4wox5fnfd5yjlczgpyu2cw5bsj@dol2der4ykat>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 08:51:19 -0700 Breno Leitao wrote:
> > json=True please and you'll get a dict, on CLI you can try:
> > 
> > ethtool --json -g eth0  
> 
> Sure. I was parsing manually because some options do not have --json
> format. 
> 
> 	ethtool --json -l eth0
> 	ethtool: bad command line argument(s)
> 
> I haven't checked upstream, but, if this feature is upstream, is it worth
> implementing it?

I added it relatively recently. Looks like it's already here 
on my Fedora laptop, but not in the CI system! Let me update
it there, and you can assume --json -l to work in the test..

