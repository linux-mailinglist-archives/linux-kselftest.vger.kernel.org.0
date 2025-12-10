Return-Path: <linux-kselftest+bounces-47364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A419CB28BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA793150C46
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF283148B2;
	Wed, 10 Dec 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtoeuoXZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD8313E08;
	Wed, 10 Dec 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358603; cv=none; b=vBmOT+EPbtlkJPOpwx8r/mwNxjCkLl3RFJ124A6+P8tk5ADyjo91xr+6f3ovagz9VhEkwHjiDXZsLYb6a94GVx+JxhIEyLKJ/OPXWrWXmnhWRNzujLQA1MnBLB24DgcxanQm4f+Cp53v6veZay+z0Y6oXqkjeaoV6jP4qA31Y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358603; c=relaxed/simple;
	bh=lb9v2yO+QpPHd9d5IjHK3ZkYycOZlqYQjQAzI9fpUTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeL0jx7fE7sNgmvME1AA7BXgqgVy4BYKDjrBEabCa7/3lOUi7tn/wuB3XVBEGMwSyFwRa1bEVdpfj6E/l2SHqeHjctj3Xt3/etfu8dvgyBKTFBnt0S7TFSpnsXVYlGeD/OlarNxjw/LkZvTI0diCw1AgFCpT+VKOQEEsg3U9fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtoeuoXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E72EC113D0;
	Wed, 10 Dec 2025 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358603;
	bh=lb9v2yO+QpPHd9d5IjHK3ZkYycOZlqYQjQAzI9fpUTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtoeuoXZ3BBBN+6IH51frJRoPdFIpIXS//VcCjs61R+csZgofTNEEFHV/ScO8wPc/
	 gEz9T8m4k8pr0iZi7LmcRmOR2Y8eFuvsmN7LiNXgJsntkBJzC3kRZRUarhUpM/zKZ/
	 EPTIjqBJ+XbCUip+X2KpYp7Ji53u5w6VgPW/z02zZBQ2p++ljq7/wyleCAiSnvag0c
	 BG5qXXS5Or5OanmDCtswkUdxFiqfdV1u6OxP+KXJ2XzhJJuQmRWyq/NZl2T1uXm4sE
	 06Oak4W/H0ifyN/LPlwfdlL+uuQaKmMM6oCVULEJdwzGvQ3om25ABE64DnoWDl7GzL
	 AGQ/AxJJWPOYw==
Date: Wed, 10 Dec 2025 09:23:18 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: tls: fix warning of uninitialized
 variable
Message-ID: <aTk8Bj9WLtjyBdV2@horms.kernel.org>
References: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
 <aTQE9WDQxBA3g6Gr@horms.kernel.org>
 <20251210180640.62fc3145@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210180640.62fc3145@kernel.org>

On Wed, Dec 10, 2025 at 06:06:40PM +0900, Jakub Kicinski wrote:
> On Sat, 6 Dec 2025 10:27:01 +0000 Simon Horman wrote:
> > Thanks for the update. Overall this seems good to me, however,
> > net-next is currently closed.
> 
> FWIW after Simon made this comment more fixes for various ksft warnings
> got posted, I think we should apply them now and to be consistent I'll
> also take this one.

Understood. I'm always a little unsure where selftest changes should best land.

In any case, feel free to add my tag as this does look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


