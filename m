Return-Path: <linux-kselftest+bounces-18920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8360F98E288
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D781C20D82
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD41216A14;
	Wed,  2 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC+49rEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81A8F5B;
	Wed,  2 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893856; cv=none; b=bMNTflubLHpBB1kLbFoppADqYOqPex9nFMbsikKyQqszDYu9UN/Kj+aMy9djYO6+2gnQMwDAv13MNLyoU5qL6cx2mbNuzzT72MiwODuhO4Z311CX9bx+Zlk4PggpzRqBe8qpMEJioxoiYzPMmnMPQ1St/0AoGN3nTlcJ+5WmAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893856; c=relaxed/simple;
	bh=gyjFz5oiZLGM+U6TNALGw9KPxxaB4f7AlGkLsH1SlYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdDHsJgZPgzM+vNMkB4tYQo4XIlpUHOUiH4ekHngddsWDhXiAmk+jhd4Am93r2fl76CxcUH2NPbKJGh9yo6FVuURqe68rfIHotPv9AtKRwASOgpUNwYo250R6BwoxbquJtCx2+TmOgdPuq4kEtXhbPEfGeIlvF5hrEDj/0A4U1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC+49rEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44109C4CEC2;
	Wed,  2 Oct 2024 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727893856;
	bh=gyjFz5oiZLGM+U6TNALGw9KPxxaB4f7AlGkLsH1SlYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oC+49rEygowTcrfNmuXH7iDngPXahBTbTyIFFVP8UPjwtWgItjc2As6uMiel8wpe2
	 31Fih6y7wtMQIAGhXWCZLbmcMqHIYuqG6huDs/S6PjF0m3poC2tx7zrp7M8lKjYMa5
	 yqCVnaAWroVR7I3s6JZM9sWSv7Uj9uZ3YQ04tFXlF8ceyVpTJB32ABIiq3j1uNJQ29
	 GUvkpTbSx+9LFiYM5jgv55CxbYvXALLm8EOPCHKWRtpKy++vNv7HDhmUUu+mWE3Sg8
	 +auX+Bb49jZeWhR67u/IquWFI/GZsk3uwXhD8cjAsbPo9quLvINcgC2BrbXeyAXvXz
	 Mss8W7eCkCnTg==
Date: Wed, 2 Oct 2024 11:30:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, David Ahern
 <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Jesper Dangaard Brouer
 <brouer@redhat.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] bpf: devmap: provide rxq after redirect
Message-ID: <20241002113054.50970a27@kernel.org>
In-Reply-To: <20240911-devel-koalo-fix-ingress-ifindex-v4-1-5c643ae10258@linutronix.de>
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
	<20240911-devel-koalo-fix-ingress-ifindex-v4-1-5c643ae10258@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 10:41:18 +0200 Florian Kauer wrote:
> rxq contains a pointer to the device from where
> the redirect happened. Currently, the BPF program
> that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
> does not have it set.

Acked-by: Jakub Kicinski <kuba@kernel.org>

