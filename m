Return-Path: <linux-kselftest+bounces-9795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CB8C12A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF045B21BB3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2716F85D;
	Thu,  9 May 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z41RnRs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC416F850;
	Thu,  9 May 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271783; cv=none; b=DO2Qn5O+mZxRZib7xAcv8zV8DjQ49mc0n1Y7y/sxcFKxIGyO4pXWlr+mBoC5o24pwytM3SZN2Lqa0eWQjmyQ4QQZDut79JBXiVVejC7WVFE4Y1VcuZv90uI+exjjvy90X+Wg9YACpzE6B4vIl63IlK7ExDKIrFoMGvHY3DduPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271783; c=relaxed/simple;
	bh=M31Bl44kii1K9+Q7ehT90NgML4XAgZre14l+WC7/t40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We3g2pFjmOcHz/lxiUS40ovH8/7aukRCfUZryAtKnfFQM3bMnuNXQkfXlqCEKlzDPD5+NS9tvCUNYOagBzKz7862CK0+mUw5+nD05ITSAgktZAWJsZ0uc1az5Zlz0zbNJtoV8yuvAC9TzlkPzV51+K4NCygL9zK4Nepg9ENlMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z41RnRs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F16EC116B1;
	Thu,  9 May 2024 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271783;
	bh=M31Bl44kii1K9+Q7ehT90NgML4XAgZre14l+WC7/t40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z41RnRs0lBMWqe9TdQPA1oqlCAMAda62dPzkfmWrVloPNWL8ltKVSoA7g92B0ocwA
	 fQPmbhiwF9rUmQB24NciwHboMSs9O2NmDXT6I+8iv3vor2fYxEt72De8M63fuZNvIw
	 d63MgNJtKLMOxu2rDLvYOECAU5gcHLzpUqT3ZWjQ+UsRGgoJcvpzitqsj9q/qF2jHN
	 ++1fOY40spnxqFqm1H9nXBU0zDjAqSuYfR5d9S0LGq4wmJiNt2gVYfI0rep1dHVnyh
	 By0sF/UJbfP1bmW2UzS48xnymeRJp2NSeXVhaiTwwuhNdhTtk4gDS8al/mcEyXYcXv
	 wOl4Yzwt2RLJA==
Date: Thu, 9 May 2024 09:22:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
Message-ID: <20240509092257.2ecb8fd4@kernel.org>
In-Reply-To: <20240508040643.229383-1-ap420073@gmail.com>
References: <20240508040643.229383-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 04:06:43 +0000 Taehee Yoo wrote:
> In the forwarding testcase, it opens a server and a client with the nc.
> The server receives the correct message from NC, it prints OK.
> The server prints FAIL if it receives the wrong message from the client.
> 
> But If the server can't receive any message, it will not close so
> the amt.sh waits forever.
> There are several reasons.
> 1. crash of smcrouted.
> 2. Send a message from the client to the server before the server is up.
> 
> To avoid this problem, the server waits only for 10 seconds.
> The client sends messages for 10 seconds.
> If the server is successfully closed, it kills the client.

Since this didn't fix the problem of smcroute crashing I had to take 
a closer look myself.

I filed https://github.com/troglobit/smcroute/issues/207 for smcroute

And sent:
https://lore.kernel.org/all/20240509161919.3939966-1-kuba@kernel.org/
and
https://lore.kernel.org/all/20240509161952.3940476-1-kuba@kernel.org/

Please don't use netcat in tests in the future. There are two
incompatible implementations which always cause hard to repro
issues.

