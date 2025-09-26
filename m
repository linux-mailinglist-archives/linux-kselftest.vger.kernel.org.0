Return-Path: <linux-kselftest+bounces-42467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E3BA3BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508291C00D02
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0672F530E;
	Fri, 26 Sep 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFdCPuMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043B2D5925;
	Fri, 26 Sep 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891661; cv=none; b=E11DOb+reB1FXdjwjCdj2QB0m6lh99UY3jO4QbOuFILCNiv+RtD0dfHJla/lsiksU/KujqYNfVSGxQq+SLzVj3y4SWehTaXfklrAJGxXwR0vlTao58cxRwPV/hqcz5oQb4dMXoKsoQzAjvEC8wHNMXwy1/54dSRVeI50M70YbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891661; c=relaxed/simple;
	bh=+/IFKmeBdwRONbJJfYmPNUH5WvHF1WaOkyKhjGbOrtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8qCgWIS4hGT7T/0sQZnHHiI5eKglSKJEDfpv9iSYSxglVMDTj32PZxrio6Lo0DN3Ucnjh+3RhlM5yYVqhQqvko4hbmeEAuG/sCzavRYFJsUzenxsAmGC44/IyeW/0uvlsRzsnw+7VPj88fjU2S7scIHPiT0ceplNzh4+Q45NRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFdCPuMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DEAC4CEF4;
	Fri, 26 Sep 2025 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891658;
	bh=+/IFKmeBdwRONbJJfYmPNUH5WvHF1WaOkyKhjGbOrtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFdCPuMIaiBnW3NYG1npjJxbwGdthJkty2fQHyHeE9w6LhaJzcmBzobKXh1eFec5D
	 TR91zLlb3CYxpAK/V3CdGWFo3RztVThaGy4rEDyBvLQ+KyBXKo9yLWNWfLYSZOF3Ze
	 4Ln21sNVDImYJaR2IwCHw13dIoioTPSetFp/t/3kRnpt9mXFqj55QoDmj5/A9/VHl0
	 lM5y+BesSukkYbJorOFz3dwrdrGRsB8J318XmhSJbpNBG4LSZBLE6ywPEjWn8tneS2
	 daqeNtBaqBZxTS7QEbpLdBpAPjh+svi1TurInRqZ7xDPoontZYKUfKVwNILGxOgreq
	 MbL3OTqb2CBNQ==
Date: Fri, 26 Sep 2025 14:00:54 +0100
From: Simon Horman <horms@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftest: net: Fix error message if empty variable
Message-ID: <aNaOhkKMbZ0Rytex@horms.kernel.org>
References: <20250925132832.9828-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925132832.9828-1-alessandro.zanni87@gmail.com>

On Thu, Sep 25, 2025 at 03:28:23PM +0200, Alessandro Zanni wrote:
> Fix to avoid cases where the `res` shell variable is
> empty in script comparisons.
> The comparison has been modified into string comparison to
> handle other possible values the variable could assume.
> 
> The issue can be reproduced with the command:
> make kselftest TARGETS=net
> 
> It solves the error:
> ./tfo_passive.sh: line 98: [: -eq: unary operator expected
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
> 
> Notes:
>     v2: edit condition to handle strings

Thanks. This seems more robust to me.

Reviewed-by: Simon Horman <horms@kernel.org>

