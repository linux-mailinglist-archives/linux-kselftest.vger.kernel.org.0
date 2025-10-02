Return-Path: <linux-kselftest+bounces-42670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54477BB3AFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27959327720
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997E30CB58;
	Thu,  2 Oct 2025 10:47:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE2EAD09;
	Thu,  2 Oct 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402051; cv=none; b=iukIebJ+KVPr5Ic9DAH+lDLq4PP38vulDC9rg09qr7lvqw2X8QDE86OzN+psNXjK1gOuKDSjeFDQ8h2PTC8CT5R9viH4Ed3T28EcjWcljmkoE0q87QT5Mmb8AXKPQ3CdG9qMFLYZxVeUTfBxlVKYB17hIgvZA03qV8hXQh6zj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402051; c=relaxed/simple;
	bh=eTjW1Pp4youXrCDVjpPAS4c9yCGyGiw8pYJl9/VvPzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahogTQNG+1ZD4PzFLTQ0P6gS0VP1j7vk38UzuSiz7gALkwRx9g7LZdSGRi+s3KHBQBc8apHFlGJTJvbSEWodN6NAm0K3P5WaSL9WvosSGSspslFECuUm6KnXTUk6qTvAa5k44RT8GfSVE9mxrj4FqGuHPsPEE48+BXLnp4faZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 19EAF603B8; Thu,  2 Oct 2025 12:47:24 +0200 (CEST)
Date: Thu, 2 Oct 2025 12:47:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jv@jvosburgh.net, shuah@kernel.org, kuniyu@google.com,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc,
	antonio@openvpn.net, sd@queasysnail.net, razor@blackwall.org,
	idosch@nvidia.com, yongwang@nvidia.com, jiri@resnulli.us,
	danishanwar@ti.com, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net] selftests: net: sort configs
Message-ID: <aN5YO4j5Q_9Aigdo@strlen.de>
References: <20251002015245.3209033-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002015245.3209033-1-kuba@kernel.org>

Jakub Kicinski <kuba@kernel.org> wrote:
> Sort config files for networking selftests. This should help us
> avoid merge conflicts between net and net-next. patchwork check
> will be added to prevent new issues.

Makes sense, for netfilter bits:

Acked-by: Florian Westphal <fw@strlen.de>

