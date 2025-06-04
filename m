Return-Path: <linux-kselftest+bounces-34290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC002ACD9E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5443F3A34D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0F26A0F4;
	Wed,  4 Jun 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVf6GGRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF62BAF4;
	Wed,  4 Jun 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025926; cv=none; b=lSkgL7er1+bw3/A/34KIREUNsArzgzbIs17TqF4ak/WUBfeWN2TElxN6egptGrD3LHbH34GckZ2u0x7bE8F08Oq0vjb5biDPi+7Icipp+GcCiL3smVI10yKVS3CkAaRyGr4YSl7U8qvK3WdaXXp8wyXLYhKpP4ZzSZ1RdgosX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025926; c=relaxed/simple;
	bh=BSx98tcYXh4Dp7af67RtWcjpl6vupoDFZiuJ+gf+CPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIEQ+UjfpHgvCTmAjgha8BibcMZLvj0IcGqgp30cgDj/4ng43aSxabYmBHqf8DKM50+fL/4Vrgz+rdbBqE1yTJ5zgNix5nsusyQpVKcOraHQL0ahE/w8npirVDTx/hX3okRCOjxMvvUWvu5dkxlGZC/MmEBMKGFnXdlV1m89HMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVf6GGRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA83BC4CEE7;
	Wed,  4 Jun 2025 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749025924;
	bh=BSx98tcYXh4Dp7af67RtWcjpl6vupoDFZiuJ+gf+CPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVf6GGRtM0QycYNqSZIb9RUFd4fMRMZ41qmvUkgiORrjqRsPXOJSSXtMfaWsEIzF6
	 zuUQkXKdfW967KwV0tCEdOaR5C4TqFLzU8e+pBHqscy/2AXcZa8GmPX7iFwiFYOK49
	 a1VBKImGbsiD3zAqr5hE7zqRs2TGJB2LQ13kmdabHqUQLIinS2FPWLlMwq+g7LCCez
	 /z2IADX+poTj5zDKvEc9+vtXO26PEKzGyz0soDvZ8mDOrXf2uDO9Vgz1XjuHirybG1
	 BZXAypL4KLFFiE+uFoI2i4pf/hxpG2Dh6PC6W2kk+5/YIckWOYRpms6cPATP+N2njz
	 k7GtTMz+gFKdw==
Date: Wed, 4 Jun 2025 09:32:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: drv-net: tso: fix the GRE device name
Message-ID: <20250604083200.GC1675772@horms.kernel.org>
References: <20250604012031.891242-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604012031.891242-1-kuba@kernel.org>

On Tue, Jun 03, 2025 at 06:20:31PM -0700, Jakub Kicinski wrote:
> The device type for IPv4 GRE is "gre" not "ipgre",
> unlike for IPv6 which uses "ip6gre".
> 
> Not sure how I missed this when writing the test, perhaps
> because all HW I have access to is on an IPv6-only network.
> 
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


