Return-Path: <linux-kselftest+bounces-35019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA1AD9F0F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99E33ADB58
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3B2DCBEA;
	Sat, 14 Jun 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d63Zb6Jd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0F13AA3E;
	Sat, 14 Jun 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749926235; cv=none; b=qS5r5PEgsNig0y1LvM/HegSkix7hLjQ0IZwgnAoFf2VpX/+Lc9hq0StVL5WtCaC3CGCT438t3SS8eQYB1Xi7tO5NEmhiM/neKCpAJImhHuhsRyW72gHWb4S5s0ULmRRSfmLVpu1H/pEvfYN5bJJ3ZMwF8BVE2fJVZZ+cejWxdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749926235; c=relaxed/simple;
	bh=G+P66hoOSUSIwWlKroYcgaEw3Vouu378clFj4f1qjW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZSMoAZ6p5BANlnc6GdOlvrUqP1VllDleyiHwcmqplcFkvTgOBjq47W/Vwy7tr8w1kWOSw0HyqX5CcFs26Uz8URa0nPwxBOj3bq8zABWKRl7XeZBT0F/trA8n4DaykeLEuW27tlS8Lt/koZNcBIu1jXqbvGvH/gt+bAb/JF++JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d63Zb6Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B516AC4CEEB;
	Sat, 14 Jun 2025 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749926235;
	bh=G+P66hoOSUSIwWlKroYcgaEw3Vouu378clFj4f1qjW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d63Zb6JdkP/EPZFsk18bYDpcx3yR7oGSkzJ5wV2n5hr7vBl7bULiQFCojNen4GEqs
	 qtT6/b0xfrqryPNaN+4sJoCsUM479aZrH8glgeeTXasWdYQVszFHIXv8xs+B/ePF31
	 dpy6NFRIxoYLoV/Q/imCrIJv1U7a+HZXN8sVp0vTKjf+t24XrquAcyxF9MzLg9dvjX
	 9JI+FbcTHD8f3hwKD6Ycpq5FsmPVB3pnDBDNewNraPav8/cPZkMs7PoNWTiLxyPmT2
	 LFYNsHWDJ7uzYY+B/kbIZfYlnSYerdQtWY5y8OOj20gRKbPKrobwEEpzmsu1MlDdI4
	 ZxhWdCnfxwXzg==
Date: Sat, 14 Jun 2025 11:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 1/4] net: netmem: fix skb_ensure_writable
 with unreadable skbs
Message-ID: <20250614113713.46b69771@kernel.org>
In-Reply-To: <20250613042804.3259045-1-almasrymina@google.com>
References: <20250613042804.3259045-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 04:28:01 +0000 Mina Almasry wrote:
> skb_ensure_writable actually makes sure that the header of the skb is
> writable, and doesn't touch the payload. It doesn't need an
> skb_frags_readable check.

"doesn't touch the payload" is a bit misleading.
What I'd say instead is that the pskb_may_pull() call about ensures that
write_len is within the head, and will already fail if write_len would
dip into unreadable frags.

> Removing this check restores DSCP functionality with unreadable skbs as
> it's called from dscp_tg.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Either no Fixes tag or send it to net. I think net is fine, this is
clearly incorrect. By definition devmem should not prevent header
modifications, so net?

nit: no empty lines between tags
-- 
pw-bot: cr

