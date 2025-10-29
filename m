Return-Path: <linux-kselftest+bounces-44337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7BC1C71E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D534D4E507A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D323350299;
	Wed, 29 Oct 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lemcj1Br"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91B34F48F;
	Wed, 29 Oct 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758832; cv=none; b=W8DRsdrkPQKt8OrzHpO1g420hCRO2qO6Enkg4DnS13pb3TqH81WtDw9OPE9Jf+yh/RJF8v9IMG1ggl7Rdjb374Dgds/Uoh32x3Xn4DYDSpDjY8qBEg+R+BjujuKncdSqT+a13PqpgTTD4HT4DPb/0tPTbMip8oMLZ/cafQDHbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758832; c=relaxed/simple;
	bh=eHGVqeD/Hl7HpK6Gajhgzz+D2etZFFgNEitAsUqlFlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBUZp+n0/+RTGh+2GmF3EWyP0KDaG0a8Lz/yNr7meCu9zEZzH0ba5C54wuMKUsgkX0468nTBNMtPGHjQyFvZxW5FTorPvcuXVMAiZor5uXy2vW0HUccO77HR8gmCbVqT2JxPZVH3MKtdWQ2aSMH5oWijhznwvP9K5R/p7h3hosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lemcj1Br; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cy/khj4zwyCRJiYJwVraJA4aIUcQ5FbuJQtmBgcw5j4=; b=lemcj1BrOyRLyj39YpysL2iTCS
	jCFBSGfKRcOBK11hxoEN09aGxq4gGjA3xHkneqvMFuith+egrxft5vcdz2dQBw3c6z7NWQzh0Sbxn
	Gozt6cxV8jZwCDY7qUO0KtIwZ2lh4m4pY3Yh0ugZVp5UCa6AlqJXYeJaxcx49hsGiw5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE9wq-00CQmO-CV; Wed, 29 Oct 2025 18:27:00 +0100
Date: Wed, 29 Oct 2025 18:27:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: drv-net: replace the nsim ring
 test with a drv-net one
Message-ID: <e1f6841e-80fa-4288-9163-d196892432fe@lunn.ch>
References: <20251029164930.2923448-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029164930.2923448-1-kuba@kernel.org>

On Wed, Oct 29, 2025 at 09:49:30AM -0700, Jakub Kicinski wrote:
> We are trying to move away from netdevsim-only tests and towards
> tests which can be run both against netdevsim and real drivers.
> 
> Replace the simple bash script we have for checking ethtool -g/-G
> on netdevsim with a Python test tweaking those params as well
> as channel count.
> 
> The new test is not exactly equivalent to the netdevsim one,
> but real drivers don't often support random ring sizes,
> let alone modifying max values via debugfs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

