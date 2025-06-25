Return-Path: <linux-kselftest+bounces-35802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D192AE90C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 00:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017DC3BD8AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0426E6EA;
	Wed, 25 Jun 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2W/sCTA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70744264FBB;
	Wed, 25 Jun 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889231; cv=none; b=boBnxFiGKWSYiop7HXgdF2HYtyYuKIihtVL9iFVNalzHcy7e4o89jTK5j0CjBfYDCMOnsuYKDL89JQNSZyZBFjVfHFzsVdXXwGS1RDdHWETExFpsrP8LrOIxZA2dbHcZO5igwb3jQRrwvvOCis2BnmQgFyxGxgBmcVEHS/NnbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889231; c=relaxed/simple;
	bh=zciBL9py9I7HWDvFL6oGguLJbsAg/8OOWe6uJbB5lG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YALjTdmb5mhu4cno+sH2VwnqEsN+a34TGJBQ1CengbtlkZfwUvHFSSuwRaSHmBRezPmbqWWdw2yZjvNABmoq3FdWZbp4IjgoMEcvEDIabX9jAPfMsQF6bfZtGSeByKo9iQpdNcOiRzGT1/ZuHDAeEMMG8e+covqSnXpBu+rC3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2W/sCTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3448C4CEEA;
	Wed, 25 Jun 2025 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889231;
	bh=zciBL9py9I7HWDvFL6oGguLJbsAg/8OOWe6uJbB5lG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2W/sCTAggXDr7TW3jkDAilgBST9eF7KXeRRGU+tNJ0P6xbWAMdJvxpooc1ieXD/g
	 6ydgk8m529SqGiiHqAGaQvDwax/bOMhnwdrRFf5MCLIjJuKRpwT045Sl0re8otYzUd
	 hJz5KEvcPcSgeAzbrfl9kH5gwJl8vPqjaVZY8cHdYXsMO2/sIp7LP9444W4FrJ61bQ
	 f1lVrAy8iM2gXfBScPnxQ+rOBQQK8axfDYc44Ko25iXt3Sk4L6fD1uqfSOUyYL74XU
	 3cjY05WGXgsy/chln4j9pWrodnIgpfrTrC1RnE5z28cCFe+s7RUTZ5t0ntFuHtpywm
	 ForUB2rpKNGAw==
Date: Wed, 25 Jun 2025 15:07:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 3/4] selftests: drv-net: Strip '@' prefix
 from bpftrace map keys
Message-ID: <20250625150710.4ee0f729@kernel.org>
In-Reply-To: <20250625-netpoll_test-v2-3-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
	<20250625-netpoll_test-v2-3-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 04:39:48 -0700 Breno Leitao wrote:
> The '@' prefix in bpftrace map keys is specific to bpftrace and can be
> safely removed when processing results. This patch modifies the bpftrace
> utility to strip the '@' from map keys before storing them in the result
> dictionary, making the keys more consistent with Python conventions.

Make sense, tho, could you double check or ask Alastair if all outputs
are prefixed with @? Maybe there's some map type or other thingamajig
that doesn't have the prefix? 

