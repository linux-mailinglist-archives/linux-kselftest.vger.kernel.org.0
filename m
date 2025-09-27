Return-Path: <linux-kselftest+bounces-42514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4133DBA56CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 02:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CF33B032C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 00:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D91D435F;
	Sat, 27 Sep 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2AiDi3P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF854282E1;
	Sat, 27 Sep 2025 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758933342; cv=none; b=YCKDKjeF72pZ5XFQJVhSLZP4aGaf2NhV+qLyMgPzq2qIhR3Pe66E86UvXvSunw4r90Azc99jcdGxDAGWe6RyNTuEovwJiklu2czTjmslfbwYr55h9g9Bzx/NXIJqA3CZ0fWkU4X29UJCcIPduepJA8H0B7dh01Oti9zQenZNlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758933342; c=relaxed/simple;
	bh=6LZQOG26MoTzz2WiVd7VfoJ2nPId6GoJXe3Q2HKktN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pccx/P6vRjfEsYtc2YcBUe3XMT8wsI4bPbFvEJcuBQQIbWOShHw+mqxlKaImAg5r8jkZyl7B5wDyUSuQmWjnRm64emC4iQksG2pgsLLcFHod6RgcKCXmqdlA6mf5Xlboe62IeRUW870S8Ai588yTZGWPBsL309/TasnxcwBni1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2AiDi3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512A2C4CEF4;
	Sat, 27 Sep 2025 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758933341;
	bh=6LZQOG26MoTzz2WiVd7VfoJ2nPId6GoJXe3Q2HKktN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2AiDi3PUCkALX6/ryb+c/2gTaAulq08805GgjYhgjLQWuQ+HZuvS5hV3bXoze4qa
	 KeHqxqXMToSklYCbuntu1G89K5uD0aF8uX3CLl08p5oIdTKwlh7TTL0YlR5mBJ5Tq8
	 AjG0OkjH3t/8TmQs06naA4DMQ4vggNelv1NdAox+4zEyzMtvfMbfG7+2ROqa3LLS+S
	 2YmDqubGDpnUwmIyGJ51Vd5kkZnJT42Bk/Q7jSTgGP1MlcLssfFMtd4cB5McpWCLBF
	 M1Gavgvd78hMrmrjB8JNTeeJwFlFPPTE5rurZA/M54dU0HLr8gEBvb3baC5WVCoMF3
	 P89DHt3ATZwxg==
Date: Fri, 26 Sep 2025 17:35:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <20250926173539.17403e94@kernel.org>
In-Reply-To: <0608935c-1c1c-4374-a058-bc78d114c630@kernel.org>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
	<0608935c-1c1c-4374-a058-bc78d114c630@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 11:53:25 +0200 Jesper Dangaard Brouer wrote:
> > + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> > + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> > + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE`` and
> > + * ``XDP_CHECKSUM_PARTIAL``.
> > + *  
> 
> It is very important that we explain the meaning of XDP_CHECKSUM_NONE.
> As I hinted in other email, this also covers the non-existing FAIL case.

Good idea, perhaps we should add this to the big comment about
checksums in skbuff.h and point to that? Avoid the duplication?

