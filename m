Return-Path: <linux-kselftest+bounces-25113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3AA1B971
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1F01639B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66A156F3B;
	Fri, 24 Jan 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWrEmPeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525312FB1B;
	Fri, 24 Jan 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733115; cv=none; b=FWoiJUm874TYlnGCqnk5tTQRGFF3Czvm4PX31Ufjgxt+8P13UD/97sABqfverW0burzCbXgfL//ehYliJKSSeUIGabOcqPptGCAdhKLX+h6cqa3rcKY5mMUzYJlrPL3G1M+NxxYK5m2uoY8DRxtVKFs1LCqbcnaPQdjavC5kN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733115; c=relaxed/simple;
	bh=lUeg54KtkUlFW8c4xzi16OHpEuOGUNANkqmCKd5o0ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dv5QjbYmIqbT4LBc+piBq6mtrEVbSqLsFYSR5VOCpJtKyUh6EQM2YqTTI1mbjTDxa0q3mjV/DJZJ7/AVUWDFPKTg0lY0HEFIfLbBnqLgWREJsAcluqNUx1tjPaaz84Pd1tpvyT0Jm/4WYYTf0DVUHcGkHGdhRM+hGqlENaCJOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWrEmPeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27210C4CED2;
	Fri, 24 Jan 2025 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733114;
	bh=lUeg54KtkUlFW8c4xzi16OHpEuOGUNANkqmCKd5o0ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWrEmPeYabaDcHjNI7Je5uWRpAT50LrEhQs+6MvDnOHJ/mOYpq56H6HgZ4utZNdo0
	 R34yj/NJFSI9Wfbe9+TU8ofDE7poYICM+hxBKOr+JmFWijbtl2MATJMxMRLt521sUe
	 S4UNrL/REhZ1Aa6cmC8/GmIiuALJG/+d9VqR8O7qa9VFb7P0xMviNZzhlhUKVPGYnc
	 +siNoJKTQ1+4/5xzfq0aHl2tVPXnU45hRSkobBm1GkfTrgjRirvTybLCGVKv9zYREU
	 U3+Ztm7oBReNUtdxVaBsYihIDMCuEGELQgk0Oxs8tF/VgCnX00vOGXWLRicv9O3hzX
	 xdGYTtmJZSsvQ==
Date: Fri, 24 Jan 2025 07:38:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "razor@blackwall.org" <razor@blackwall.org>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "liali@redhat.com" <liali@redhat.com>,
 "jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, Boris Pismenny
 <borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Message-ID: <20250124073833.2b2e2f4c@kernel.org>
In-Reply-To: <fc63c005a8f2fd6a34a055c1ac484bc36869f8a8.camel@nvidia.com>
References: <20250122135218.183578-1-liuhangbin@gmail.com>
	<40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
	<fc63c005a8f2fd6a34a055c1ac484bc36869f8a8.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 15:24:37 +0000 Cosmin Ratiu wrote:
> I've sent another patch to suggest these changes.

FTR this is not the normal way to proceed in code review,
please try to share your feedback rather than taking over
the submission (unless the original author explicitly asks
you to).

