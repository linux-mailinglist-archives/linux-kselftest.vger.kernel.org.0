Return-Path: <linux-kselftest+bounces-39230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11994B2AD6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24F12000CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D733470A;
	Mon, 18 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBNwBUjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51F31A07D;
	Mon, 18 Aug 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532368; cv=none; b=UfaNYcsKF0rtRAQBYHzJ2RDO+p85RZ/xSQkuZjTXzamNvMCyqUf0Lf2aLQL1YZWofM5sQPJ9xCBkD9IRj/FrxdzIL83rQJQ0sYYbrNT/ejzLjeoM4rd/GLbN15ZR4mRJZxaKOM7Hva5ZD7eAyNJ7gTLGC4NNr/RKYh0WvItfiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532368; c=relaxed/simple;
	bh=yUcp7MuE26AP2yLN9EYUbOMT0/y5R9FVEb20sqDOX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAMvbRclsvVkOwCRj2IpOZU9WU5Gb03zhecMk9gk4p0qAes2iYRbr55k5MFWM6LsQNPGy8SIdUGqjHtjZ1dnFWKSsA8isP9pJ+LlTVp7NtypG4xIuyeYIaANzTzDJcIlVs+GTW0++VO8eKdskH7FpouAkaswCxLc5RChE4T0ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBNwBUjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54105C4CEF1;
	Mon, 18 Aug 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532367;
	bh=yUcp7MuE26AP2yLN9EYUbOMT0/y5R9FVEb20sqDOX9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nBNwBUjA7JK+ZE1BqIxYRO6X4pGPags49vJrWyQO7Uf1DMn6mujoTzFLcJ5P67qNF
	 WniLaEKD0/Y8kCm7mmeX+hgTv2RA6KJM5gXOLdZ9zU4xyptHs9psCRhAVYogFt/M3l
	 ETf3vTLbM9hFIlrZk314r8Azue1aGasQ4jru1ZRx2O56G8uwlonx9H641Xd4Mpn3SF
	 XglcoUTHBQDDd+syX6W/FBRvdtlxKxEC5nLQNr2t4p/AA0G0a5PVocHJg9Y3aZ7jR9
	 jmgQb/9H/aKCHeKwwtweXUUoHGDCAP7FRB36/i/Peu/LIF/nYZ6xoMUNDt/mA1UsO4
	 NEye0NtyKFaqQ==
Date: Mon, 18 Aug 2025 08:52:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: tso: increase the
 retransmit threshold
Message-ID: <20250818085246.754ea32d@kernel.org>
In-Reply-To: <f30a1b37-fa50-4b23-a9d1-841b91bf9806@gmail.com>
References: <20250815224100.363438-1-kuba@kernel.org>
	<f30a1b37-fa50-4b23-a9d1-841b91bf9806@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 21:41:37 -0400 Daniel Zahka wrote:
> On 8/15/25 6:41 PM, Jakub Kicinski wrote:
> > We see quite a few flakes during the TSO test against virtualized
> > devices in NIPA. There's often 10-30 retransmissions during the
> > test. Sometimes as many as 100. Set the retransmission threshold
> > at 1/4th of the wire frame target.  
> 
> Did this issue preexist these commits:
> b25b44cd178c ("selftests: drv-net: tso: fix non-tunneled tso6 test case 
> name")
> 2cfbcc5d8af9 ("selftests: drv-net: tso: fix vxlan tunnel flags to get 
> correct gso_type")
> 266b835e5e84 ("selftests: drv-net: tso: enable test cases based on 
> hw_features")
> 
> or is this a possible regression?

I think it existed before, but it was much harder to spot flakes prior
to those fixes because the whole test was failing. Here's an example of
110 retransmits 3 weeks before those fixes:
https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu/results/192642/4-tso-py/stdout

