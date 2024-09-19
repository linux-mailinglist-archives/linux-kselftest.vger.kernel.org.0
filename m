Return-Path: <linux-kselftest+bounces-18133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66997CA8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4295B23B86
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387A19F408;
	Thu, 19 Sep 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMgjs/+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F919EEC6;
	Thu, 19 Sep 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754162; cv=none; b=rYoxLbFi+LqmIvasHvF+Gre8X0dDtGGdKzgkVl4JyyWSM0kfQgxMLfxpEVISYRn/dyqpHhtJB2wTs9QyAZftuGoEs5pxyg9wVuB19LDXVQk+s5EYC3IgvETos/mHeev0Sfv2g9EIG7eITYmDyOWVro3md/7QqUaj6Sc4D2ww8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754162; c=relaxed/simple;
	bh=FUIoneVuELrqS1CNv63Jdafju3cgq3W0v0AThpJiRqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI/L1qG+mEsR+OHrcxQegjVN76uDGnE87JosjbvrDYEwaAXKgLOtFtDO+G0PIFWyzXYaDhAdStrbgFDrY/skPLlcZGWx0Hb9yRcQQHKTmGoKQq+aUgq432z1xSjPuVS2pFzW1dzsu0c2P0lxGyV5GM6ivPyXJltHi0NXgDhtezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMgjs/+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3432C4CEC4;
	Thu, 19 Sep 2024 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726754161;
	bh=FUIoneVuELrqS1CNv63Jdafju3cgq3W0v0AThpJiRqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMgjs/+uxiqe8HQ/PbmcxxRE00miX9ymA1Xs2crx+F3HcFAKpQe/WxggkN7ZbKT1j
	 U9+9hUpTf4EflnjwiUoKrT2iXr4woDwln8r/BmLZhL2fs9+S7bqbP+Autl9T/DNH25
	 ow/E27sjLuStpq7L5D8rKZB+5k8dWDobaEOPK2+uVnBi/ZvaMqGCOkqnRBD1elPE7O
	 Cn3XmCMxexLgMKeySdgp6Mbcmj1B0HSMZkZzQITGfnu5g8VWlA4pb3MgmJIwZd6CHY
	 7bw+S7hfuj0HQtfq27M0W7pxyBhEBfmKbH00sDh8eGb7AHicmU7/j331N+Rcny1gqn
	 dtp/MoD4fDzxw==
Date: Thu, 19 Sep 2024 14:55:57 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
	matttbe@kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] selftests/net: packetdrill: increase timing
 tolerance in debug mode
Message-ID: <20240919135557.GD1571683@kernel.org>
References: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919124412.3014326-1-willemdebruijn.kernel@gmail.com>

On Thu, Sep 19, 2024 at 08:43:42AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Some packetdrill tests are flaky in debug mode. As discussed, increase
> tolerance.
> 
> We have been doing this for debug builds outside ksft too.
> 
> Previous setting was 10000. A manual 50 runs in virtme-ng showed two
> failures that needed 12000. To be on the safe side, Increase to 14000.
> 
> Link: https://lore.kernel.org/netdev/Zuhhe4-MQHd3EkfN@mini-arch/
> Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
> Reported-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


