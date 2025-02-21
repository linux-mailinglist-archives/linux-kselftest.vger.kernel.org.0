Return-Path: <linux-kselftest+bounces-27244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C071A403B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E002E3BA0C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663B254AE8;
	Fri, 21 Feb 2025 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM/ZfJRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791220AF8E;
	Fri, 21 Feb 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181674; cv=none; b=L6RVtffEbeBy4sOI8DYVq/j4eDlIulX9+i5RoXWdDsNZXfrIDRAwnwzhzSEjH1rO6QMARcF5NZUdwV7UMPJH3HxTDHfxPc3kpfnRoBnVeJJxwl9N5kJWspDiIiq3Iu3NMw0aULHcF1eFEqXxuqQWH0jYDGreR9twn/WVk5/Wt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181674; c=relaxed/simple;
	bh=YpqZyI6XQkE+I/cz0HVGo821pG3xUv+i2G8tH9sw4Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUMzq3OCOo3uSMiOn2/HZRqHWoOU8FUHE+iHE0nXy3/pNG5H9hF+ZgsaRcjmnmTAufq6JvmUhRXlMnEhEHEUY8SJAab14l2FmY2yhq9p1GtwG1sowqb7JIG2tS73tB6Ef3M7cRhLGIJCGHuxJDYNLZqrF7yJ39tmHv2Zzwl+9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM/ZfJRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A7C4CED6;
	Fri, 21 Feb 2025 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181673;
	bh=YpqZyI6XQkE+I/cz0HVGo821pG3xUv+i2G8tH9sw4Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KM/ZfJRW4Ao62YReF/CByxvaytS6eCg7A62ykfem1F7ZlcxARc/ttMS+Eo7QSiRoC
	 L/Yjcd2caMn4ObZZCnCGyEuo9xgC6WZot/rpFAy5wigXVK3ut+VHILxglTeHRYA9kk
	 k60pF94LnYZ/h3hrEAauaHfon//iQu4AioNB3aq2W2kbk7oEuocz2/ygkH/nvqljBK
	 2J+2++rVJPifxTn81/PKTdrWtLY/Om1L+itbDoBh6z+E8Cwe1RdbvdUeamo4+pUpWj
	 /c4yBKxGb0jQHXag71qQxP+sWONgV0p8K4pbQVmHScKyB2/E2s11Z7gaJWVk4E/s5B
	 mJf6Xz30VzUiw==
Date: Fri, 21 Feb 2025 15:47:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Kuniyuki
 Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/13] net: Improve netns handling in
 rtnetlink
Message-ID: <20250221154751.54318ae5@kernel.org>
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:50:26 +0800 Xiao Liang wrote:
> Patch 01 avoids link name conflict in different netns.
> 
> To achieve 2), there're mainly 3 steps:
> 
>  - Patch 02 packs newlink() parameters into a struct, including
>    the original "src_net" along with more netns context. No semantic
>    changes are introduced.
>  - Patch 03 ~ 09 converts device drivers to use the explicit netns
>    extracted from params.
>  - Patch 10 ~ 11 removes the old netns parameter, and converts
>    rtnetlink to create device in target netns directly.
> 
> Patch 12 ~ 13 adds some tests for link name and link netns.

Nice work, thank you!

