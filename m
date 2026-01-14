Return-Path: <linux-kselftest+bounces-48902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE55BD1BF5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 02:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B824D3006E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 01:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25172E8B74;
	Wed, 14 Jan 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiTnhzGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BC2E22BE;
	Wed, 14 Jan 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354799; cv=none; b=ZZG3PCrVJhoD6RR/7hCcKzE/V7xlx35lDMfpIq1dZ4Woe6v4ET0ObXOsAhoAm7QwxGwe75868y2Ur3i7yLhWCydnSsFQOnyao2f1ge7nv6UxAElTqQN9TCV6gAvRlve7/geXPImKS34WhiTibM0DerBSaa8sB0sax1KKnsmEME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354799; c=relaxed/simple;
	bh=S1RdJNbhoYlYqtBNMOHJ+qs3FGmorLaX2U05cKuDIuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pep479kE5I4/hC5HKNXOiT/CdRKpM3YAskRZJ/0TJlsnu1LtQ+Stad/6RAjIDV26j5pydy3BMJLsCL0RY8ojOwaaRmW5IkjdWb1pJq9mYMCP1e7IL2KIIK9d+BTYIoRmNV36IGuXATE/RVvRnVOkVF7CeAmijFJ448VANU1zNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiTnhzGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CCAC116C6;
	Wed, 14 Jan 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768354799;
	bh=S1RdJNbhoYlYqtBNMOHJ+qs3FGmorLaX2U05cKuDIuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZiTnhzGP6dSh7aHApCNAwFgLG+c6aAbNFAZJUrHKMd35/8TKC0ULBNn+EvVeqGBuZ
	 Q/SkYP2N1I3fIbaYrZ4XYhumiSTQIxeTy5RWNpIwX988qlSOZSLHQ1JHJE6UbDIe3Y
	 AXqxM+1OEZv4ZdKT+pyUDDk5w/jsaqvz7Hi09jupsh8DbQjKKNSFZ5YS/Yg1JwTGX4
	 gy6aTAlZ+ds2hMAPxD8TOxo5Bz+AMHje9TURkDGcuFuLxd6w8k3G3vZSKv0e4QMKjI
	 +Net77ecTMdOOwZwQ7xTuUZI8B2ZUQiJcKTqlsNx+HJkVd7HoZORyzzCHAyoJZFNke
	 APFLp5fygAHGA==
Date: Tue, 13 Jan 2026 17:39:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: csum: Fix printk format in
 recv_get_packet_csum_status()
Message-ID: <20260113173957.432bb9c5@kernel.org>
In-Reply-To: <b0e24fd07302aac492d03d0bcd30626a338f976f.1768326133.git.chleroy@kernel.org>
References: <b0e24fd07302aac492d03d0bcd30626a338f976f.1768326133.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 18:44:19 +0100 Christophe Leroy (CS GROUP) wrote:
> csum.c:710:50: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

> Correct format from %lu to %u for both.

I mean.. you're going to make the warning appear on every platform
which has a ulong size_t. I think you're looking for %zu?

> Fixes: 91a7de85600d ("selftests/net: add csum offload test")

No Fixes tags on trivial code cleanups please.

