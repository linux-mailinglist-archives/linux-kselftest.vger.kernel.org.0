Return-Path: <linux-kselftest+bounces-36570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7CAF9497
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636555C00A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152F2D77E8;
	Fri,  4 Jul 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVdvHYBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3A309DB6;
	Fri,  4 Jul 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637018; cv=none; b=Qb/8I8l9YabOcr/ZD6PjKl8gp1gSgqVIBj0XNfm7ZRe7vTiVjaVmXYwKu8dAk0btJYaRq9ZPhgcu17u2svjz/4/xySLkp1Om1BiMaAxuxxSXaXb/IjQhT8YClEKVidfSFgMmYphnPLSPrwWFlLXRz7wq5uyQ6wlUAVsChlHoHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637018; c=relaxed/simple;
	bh=NRGF9dvXVWicxmaYbtbL5eWUwxyig9E5LYcW4lpk1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzhgy+gXAbdIH4KklncpXoEp1F3/QIHqcaSQFW8wGup4zUvO0y/GHXp+HES1zHGuBDSpcMNgGGIowQIFOLR3k8om6N9nvsPO0m0VNxnb4PtfbU9AWuthq88kF1rK5JaP40bySVGs357aYx/r7aVTV+S6GQeFfqUq5EI/w+5mZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVdvHYBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D93C4CEEB;
	Fri,  4 Jul 2025 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637018;
	bh=NRGF9dvXVWicxmaYbtbL5eWUwxyig9E5LYcW4lpk1mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVdvHYBeHbAVvQiZKZgl1NoUs+TYUY5sMGy91Yn/H75PWCbb2QFzdUoDihfCF5D3j
	 NTPuqOa6OXIa9EdQPr2HuWondjFaZV63T0qSLD1A4a9KgfwqzvJEKMbe+hXaIRAj+J
	 nrWfCQ86EkeYnSc7+w/dZoS8tVyWl8cNP9uWHBF/dPCPZoeHoLolKVZq/iBfsTgKYr
	 Z2vHf+t/gBP7Ml3CIGHI2x8bZfP6F3C0CTtSnUW3/ki9nFlHp1j8YYdwQj1znGh5oA
	 LdwfrSZFtTmp+4pnOnwnsHg5ukqbi7lYnFdvjSwqtvlnxoqYycsenEEgptPdE6L6T5
	 43naKZN9PkUKQ==
Date: Fri, 4 Jul 2025 14:50:13 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/7] netpoll: Improve code clarity with
 explicit struct size calculations
Message-ID: <20250704135013.GO41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-1-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-1-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:33AM -0700, Breno Leitao wrote:
> Replace pointer-dereference sizeof() operations with explicit struct names
> for improved readability and maintainability. This change:
> 
> 1. Replaces `sizeof(*udph)` with `sizeof(struct udphdr)`
> 2. Replaces `sizeof(*ip6h)` with `sizeof(struct ipv6hdr)`
> 3. Replaces `sizeof(*iph)` with `sizeof(struct iphdr)`
> 
> This will make it easy to move code in the upcoming patches.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


