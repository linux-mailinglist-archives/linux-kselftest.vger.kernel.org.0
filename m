Return-Path: <linux-kselftest+bounces-35145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36946ADBB9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F7D1892A7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52177215073;
	Mon, 16 Jun 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFXP+f0n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2D1E32C6;
	Mon, 16 Jun 2025 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107311; cv=none; b=VvCrGz5evyR6lMa/KWmgkRRDcqhys+ugFDMgRDOqYByl7jKSiNDUTE54iOR3P1JzTj9wirhNCW7fO8IAWcdykRQW9KTgw5Mzs00O+ovmPOlltSxj8XRBAV89aafd/37+0bfjpvynNACgT7qVzD2LWunlqZkMsVeffCmmLvMU9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107311; c=relaxed/simple;
	bh=lPc2k06NOBYmbSOgcB2zAhNJtDMn5gzlWWidkWJg2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cItj9t6biVapAFUozerYitRcapaITjWzzWtHdYZFPeeoOaJuu29Q6k1LcGjlfqGigd12z8oI3uQYvm81zZNiRMXLd0D+qzeIcYFlOAf640lugXTuuVm2zDvHBsd7Nc/qrZ4TTg1qx58vZ43bs5YKxeyd22IXZrF4UF98vYA2vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFXP+f0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4510FC4CEEA;
	Mon, 16 Jun 2025 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750107310;
	bh=lPc2k06NOBYmbSOgcB2zAhNJtDMn5gzlWWidkWJg2IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VFXP+f0nRIqS8iGZpoctvW73WpW3ntUVatBS9JZOn7J80UYQiVTFFnU8l1H08O5tg
	 MWCGpCwAf9iOTnftK4TkmQrT69R/PkpPEfBGNZi5jIJDr5aSvGgxioZc/UF6QhfWU+
	 KOBm5rvK3ciD2tfsW6XnR+vm1h0fAlJzC45+Q/05ojgmtBUIap8mBin+CwTi4d95k9
	 3EKSoKwcNhGwBnfKi12cVc4okSzhCMXyfbKHu7LbE/Jv6WMYHsDPoNxYXFlS/619dF
	 v9kqKYLK27K4pbQFJH2BDu3vsZlBTg4SaAO/1mTE+i10je2X3gNVFIu3aYEzyXEOCO
	 VkAYA/MShlSdQ==
Date: Mon, 16 Jun 2025 13:55:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Message-ID: <20250616135509.255a1871@kernel.org>
In-Reply-To: <be7149b5-0286-4b39-b6ce-809618354b13@kernel.org>
References: <cover.1749757582.git.petrm@nvidia.com>
	<78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
	<20250613095755.54381628@kernel.org>
	<ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
	<87wm9bu13q.fsf@nvidia.com>
	<426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org>
	<87sejztpvj.fsf@nvidia.com>
	<be7149b5-0286-4b39-b6ce-809618354b13@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 22:40:49 +0200 Matthieu Baerts wrote:
> > Good point. The question then is whether to put it to forwarding/ or
> > directly net/, which is has seen more use of lib.sh and therefore the
> > same sort of coding style. I'll experiment with it and should be able to
> > send it later in the week. I don't want to add it to the MC patchset.  
> 
> Since Jakub disabled SC2317 in NIPA [1], then I guess we can put this
> .shellcheckrc file in net/, no?

And drivers/net while at it, if you don't mind.

