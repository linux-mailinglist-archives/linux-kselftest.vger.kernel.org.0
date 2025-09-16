Return-Path: <linux-kselftest+bounces-41557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8118B58B55
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915871699E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBB220F29;
	Tue, 16 Sep 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baZQh+Zg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CD2135AD;
	Tue, 16 Sep 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986884; cv=none; b=L7GvDIYb6e+vIPnxjA9+39QRCLjAsm56UsxwN60yNPSkC8jaN7k05KvGH1yqqOqUF2HOVLPt0wmMlHw7f+5j3/qk0/0Yll6eBPhq35uEEeMSW5nO7Ifc18uMBcgt0svwVCulhdbCdSez84EM+JgqDvATscfRKQH0Uh0a0r4JbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986884; c=relaxed/simple;
	bh=8hwQcwBHz2zuy1ceLhAuHCSU5WJ152SvEZ/BnmXPAnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5DyJXadQ4oDYxTd8036Y8FRmsAJvwVntWW0XsC1yUryRd4T5IuzxUOGdJma69r81mVvr2s9rMqjWqVxibagICTkJ8Fe2YakuCImvo7nvmTiKiIUfUnGXzWDCQcWW8d0Y7hOSmZ20Suyg1S3TIrGjoM8ITlF0yx3AM7FeoUrWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baZQh+Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B67C4CEF1;
	Tue, 16 Sep 2025 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986884;
	bh=8hwQcwBHz2zuy1ceLhAuHCSU5WJ152SvEZ/BnmXPAnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=baZQh+Zg8nNrO1680vkA2olUSKrxkFZBUqJQI63+xryyLibk78TRlw0NSuyMb6EEO
	 oA5mj4aVqpPc8oQ7Hs3h+efA+4ZoIiTfRawD2FoL89AcECgPCdCzAKf6BiGWVrw7BA
	 ju+Qnm3xWBh62qdNtCxo7YHHWJaLxME2n9UpFj1uPDpufxfGSLiEtZ243FzqyydMei
	 gvY/VJhEkFET8Uz3NtW2a9FDH5oFKMj2xZ+H9WOc6J4Gu+/DbzH2uci5wDsWS85VDi
	 JGLEHqr6rgiUkC+iX2Ki4YFdXYfG6texEFGGHhdezhYfhTtGj1xuXI99uLT2uZkc7Y
	 ajvfKqmfW5TOw==
Date: Mon, 15 Sep 2025 18:41:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
Message-ID: <20250915184123.505d2bb8@kernel.org>
In-Reply-To: <20250915083742.423741-1-liuhangbin@gmail.com>
References: <20250915083742.423741-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 08:37:41 +0000 Hangbin Liu wrote:
> The active-backup bonding mode supports XFRM ESP offload. However, when
> a bond is added using command like `ip link add bond0 type bond mode 1
> miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
> disabled. This occurs because, in bond_newlink(), we change bond link
> first and register bond device later. So the XFRM feature update in
> bond_option_mode_set() is not called as the bond device is not yet
> registered, leading to the offload feature not being set successfully.
> 
> To resolve this issue, we can modify the code order in bond_newlink() to
> ensure that the bond device is registered first before changing the bond
> link parameters. This change will allow the XFRM ESP offload feature to be
> correctly enabled.

This reportedly doesn't apply.. I suppose we want it to go via net?
-- 
pw-bot: cr

