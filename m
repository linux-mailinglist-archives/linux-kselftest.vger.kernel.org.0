Return-Path: <linux-kselftest+bounces-3942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07CB845DB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330FBB31ABF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB221FDB;
	Thu,  1 Feb 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn9ZQX3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566163AF;
	Thu,  1 Feb 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806056; cv=none; b=WRiKx0TvozDDD02mNv2kdDzrEVM25ZHXSdgD7KWiDgLIc/2zBu0ntdp/fkCT+DDweKepiMsXdRVxO01EkkUBaX5mrfhjCgp94QACkBlLS7NxMhlR2kl2vZ2BMfLVlmcpXKkT+/Hrz9tR2wrPt9Fg/4dCb0NRZ0aWD95m93njkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806056; c=relaxed/simple;
	bh=/Cpko5bgqtkY/APFe0XRYiD2zhK2pxQ8UE5K7+s5InY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7gfEv8AZbQ4dqWYrVHt0h/FmWcglvV+0QTziiFQ40MQ31oYG9HBuWNve+y5I8g/p0Wi5Q9j/InJPhBojSpd9+kJBE5MENq/2U3bdaVx7zTZ+Y3QMCp5SrVTNNYLIvAfLOi079PcDv9QqAwNTtQAi4hLMGnlL82Phuaq7hS0PLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn9ZQX3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A16BC433F1;
	Thu,  1 Feb 2024 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706806055;
	bh=/Cpko5bgqtkY/APFe0XRYiD2zhK2pxQ8UE5K7+s5InY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tn9ZQX3Ml+wdbppqkFNiVxhS3dIm/Y9ANv3FnATgHy5Nufkd468WOSF06Tq0WNmXa
	 UljAghw6pGSIOGV343sa6tZ2L6lo8mYuDlOVvd3rmWKQKOm9vhLmF5kMH2x2ASCMrG
	 cnj506kMkSaQCtk8EbHUOxJ1F9/lGyspU+F4E4qWI3J024IsM7CD1P6I6TCzBaK9R1
	 63bOpY1Uw1alPq4TZgB30W1n6tLIWBPmvZgPef8ebZ5nqflPi4BRZCJYzosFmAju74
	 wFHSEu3sCdoBHNqGrLz9TmF7dE7YvqhiAT4bt9lWKVEqT8767wkZXaDh1JLfG2OD0V
	 y3IV+Z9yfIQEw==
Date: Thu, 1 Feb 2024 08:47:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Shannon Nelson <shannon.nelson@amd.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/3] selftests: net: more fixes
Message-ID: <20240201084734.1cec7c63@kernel.org>
In-Reply-To: <cover.1706723341.git.pabeni@redhat.com>
References: <cover.1706723341.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 18:52:26 +0100 Paolo Abeni wrote:
> Another small bunch of fixes, addressing issues outlined by the
> netdev CI.
> 
> Paolo Abeni (3):
>   selftests: net: cut more slack for gro fwd tests.
>   selftests: net: fix setup_ns usage in rtnetlink.sh
>   selftests: net: enable some more knobs

Let me apply the last patch since it's equivalent to what we had
locally in the CI bot for a week. (The rest needs a repost since
they didn't apply at the time of posting.)

