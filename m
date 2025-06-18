Return-Path: <linux-kselftest+bounces-35267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E81ADE918
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E534818995F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0903287503;
	Wed, 18 Jun 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouSDihnf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB8284687;
	Wed, 18 Jun 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242842; cv=none; b=GFcuvCyk1IAFUUvsrmKS1VPZ+7UBg8AJHbtK2kD5K5BELU+HwdLEKy+QQXzZHQReBmsd86TDQvme19SA1OX1ES8J/JC83LWrAFR7vsJgISlExjNwraTTpMGygD8AS2RRjlShuxqRbjbtecT0pIv0qqFiQY73WbVlw8JsJ2lk+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242842; c=relaxed/simple;
	bh=9f+ncWU/Z9cZ5BuK9I51GBaZ/Ti54fUCxV8DLs5s288=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCB/ocgEP9Ti1xy+4/RLKidZj8wsScKLhBCl/9wET+ryzzZ0bJREP5RE87V50chaCAiF2PIAUAGyY67lFqNXjePErYHh6uLJg6acuakTZOMfT0H9MzRMRDlAYPOi6eqxr5uNfzRWfClzUqWqz9YqAkwzRRsl4wpvY7icbOq9muE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouSDihnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F32EC4CEE7;
	Wed, 18 Jun 2025 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242842;
	bh=9f+ncWU/Z9cZ5BuK9I51GBaZ/Ti54fUCxV8DLs5s288=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouSDihnfm6VK+p96sz+Ep1KNgPVNzEPSyW6fdagJdLl3jt6D53u2DFWp6X5DdGn4G
	 cCi5mre0VS19KLHnX0vS/gAcO0pFheo388ldPBJiXX5Qdm0FwC821F8wqilNK/P+Wt
	 L1o4IKKmdkeexEfogdz8Qy+Z/2GIY1cqCgJPLs166r2euO/cQfWD0PkPT2wnP2Msz8
	 bqjKt2zNCbgipaV3uBkCaAymj9DzCA9LK/MMhpAYeW3tBX+bOb6fAZ2rWnKBot5gh1
	 VSnlOBPmkC5h8Y5qE3waSP4bZofdcbKT+iQmmAkkGN6B+6W8J5847jG22qGS5RwtzN
	 byNW8IwCG4mkA==
Date: Wed, 18 Jun 2025 11:33:58 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: net: use slowwait to stabilize
 vrf_route_leaking test
Message-ID: <20250618103358.GB1699@horms.kernel.org>
References: <20250617105101.433718-1-liuhangbin@gmail.com>
 <20250617105101.433718-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617105101.433718-2-liuhangbin@gmail.com>

On Tue, Jun 17, 2025 at 10:50:59AM +0000, Hangbin Liu wrote:
> The vrf_route_leaking test occasionally fails due to connectivity issues
> in our testing environment. A sample failure message shows that the ping
> check fails intermittently
> 
>   PING 2001:db8:16:2::2 (2001:db8:16:2::2) 56 data bytes
> 
>   --- 2001:db8:16:2::2 ping statistics ---
>   1 packets transmitted, 0 received, 100% packet loss, time 0ms
> 
>   TEST: Basic IPv6 connectivity                                       [FAIL]
> 
> This is likely due to insufficient wait time on slower machines. To address
> this, switch to using slowwait, which provides a longer and more reliable
> wait for setup completion.
> 
> Before this change, the test failed 3 out of 10 times. After applying this
> fix, the test was run 30 times without any failure.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


