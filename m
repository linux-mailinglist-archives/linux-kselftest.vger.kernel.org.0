Return-Path: <linux-kselftest+bounces-37136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CFB02266
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F35A4BCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969F2F0050;
	Fri, 11 Jul 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUPxNd0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4A1DDA1E;
	Fri, 11 Jul 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254057; cv=none; b=EUuSs/7+45LruA8tqDOM8d318CHmwPD+/rxLJaOrVDIPVY50GKmd4DOJQ5W2tAZZoshDWhACtVxJqtGGp31Ty19+nMOTAKfjP09XNFvuOFvF6wh5T7PrCs+wGdkVd5jU6xiO37gtYOV6FvVzWg5cXsCSc+GJHf9LKv5wyy4NtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254057; c=relaxed/simple;
	bh=Z8t4v9GE3HmVQ5IrHhzssCSA8tAjT2bLy2KFBbGN2aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeZ8MyVVZu/k48W8POP6QmxaSH4GVP19SBYrLayE8PxwHEWA5mCNFy4R6DPNQ/Q+GSSxaSdVhyX1+9QpQdXEPCx8fD9eeBjMalSAaxbIuiJJqOyLMLbxo98I1ZSkN7gtHRfBInx33ew0M7EFANPCQE/Pjzh1tFyXOpXuhu0mkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUPxNd0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7364AC4CEED;
	Fri, 11 Jul 2025 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752254057;
	bh=Z8t4v9GE3HmVQ5IrHhzssCSA8tAjT2bLy2KFBbGN2aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUPxNd0uDD6sEJHPCqCIjAjD6BxgmI1NR/JRGeJ3elXWo/TaNS3BfX1HQzLDo1gUy
	 G6JADPJ9ZgI7weP8hqK8vB8ciA2Bb+nnlQSADuqS2oObezgopBLVJjT/SdGrYGulr2
	 m670SUlWOloJwny43iY/So9IxJnXDkvC7ephxT/aFZ0sySV8tzjIQxpG/+7iYTlJNb
	 PMdtDljWgWv8N9hR+XVyVyFCIzyKHa1pyc+UwEpM1Kx0CpeI9beakEDow8wMddUDjQ
	 RYGwkCM46aAQmKVL4g4n57tkLH55nRlR4jAl4svvRcAVNRgBAO8n1suITkknkEnRue
	 vExZS2UCzQNmg==
Date: Fri, 11 Jul 2025 10:14:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v6 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250711101415.6ae42daf@kernel.org>
In-Reply-To: <20250711-netpoll_test-v6-3-130465f286a8@debian.org>
References: <20250711-netpoll_test-v6-0-130465f286a8@debian.org>
	<20250711-netpoll_test-v6-3-130465f286a8@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 09:05:11 -0700 Breno Leitao wrote:
> +        rxq = ethtool_result["rx"]
> +        txq = ethtool_result["tx"]

Most HW NICs will actually use the "combined" channels (which have both
rx and tx ring on one NAPI).

> +    logging.debug("calling: ethtool %s", cmdline)

ksft_pr() ? 
We had a plan to add a verbose() helper which would still be
TAP-compatible, but never finished the patches.


Either way, would you mind respinning the series (without the 24h wait)?
It conflicts with another series which adds a bpftool() helper.
I applied that patch so you should see a trivial conflict when rebasing.

