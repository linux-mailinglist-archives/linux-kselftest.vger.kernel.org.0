Return-Path: <linux-kselftest+bounces-42483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A59BA403E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DDD7BCB4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8419D8A8;
	Fri, 26 Sep 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMQoFAOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D62EB86C;
	Fri, 26 Sep 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895006; cv=none; b=igpHE/9/80lVKktXEJXpA0XXxHjX/6IeH81TRClTPidkqLLd3ckzDepboYKDKhtlFZSCLUw28Qs5pLltg+ndTAOliQSD+VLN0y63L5rGCsCWPwHgCJWzSednKXyD9GOR3plHTQYjzcoTDha32CB1O5hPkZCbfRtf9FImrC6eLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895006; c=relaxed/simple;
	bh=Fm72mJmXUjZofvn+dMegaxkGi813i5IKadoFxl3ITZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/+0WzSKai9lrQwbalFgcJ/I8tiirLgH8ck4w+s5E/nEP5rPKGM7SyDkHLWoGltGcaRKOElGwaLGKefFMQRx2+x+QQ6i4mhHHDDzr3Pr1+bMIRYF9ci2JGCZ/XUI5YfND0xOtOffYFpxuJVjFSulk1AIxDJb7q529ae60qb9FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMQoFAOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA45C4CEF4;
	Fri, 26 Sep 2025 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758895005;
	bh=Fm72mJmXUjZofvn+dMegaxkGi813i5IKadoFxl3ITZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMQoFAOzoT0H0xT0J2/dom6AK5m8gQHJ9xNt8xL0kkqM0pAslR9TErGqlfXGrDaiC
	 ONB/VAEd97mhWuHIC8xn1wh34q4U9JkWAgKFsTLInnwqHvKDTmflIdlfoR5X1A0KpL
	 eRa2zNS8bmV2mXDzLELXnWPL4u1Un2Mpb3dmOAqsSwn51AMi/ebIbOK9ptXm85Xk30
	 Bya85J74a0tK1j0LdYrm47wPDECvdi53IdsKi0ul/1Tdo2RMDSqv98+Fj156/EnA4w
	 RdaNfCX+t99ixhJYiLICyCy+NibDG66oMP5+ReOuzcToIlIIQ08IEYtrNRcGA1+Cg3
	 3Vtzhfd7XK5/w==
Date: Fri, 26 Sep 2025 14:56:41 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Kuniyuki Iwashima <kuniyu@google.com>,
	KuniyNicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH net-next 13/13] selftests: forwarding: README: Mention
 defer, adf_
Message-ID: <aNabmYz3gUVz-3nZ@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <0764bdb9266cd516da23ddeec110e01118cf981e.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0764bdb9266cd516da23ddeec110e01118cf981e.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:56PM +0200, Petr Machata wrote:
> Mention how it would be nice if new code used defer. Also if it does that
> in dirtying helpers, how it would be nice if these were named adf_*.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


