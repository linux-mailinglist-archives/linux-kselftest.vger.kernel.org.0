Return-Path: <linux-kselftest+bounces-26720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B5A37049
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F109E7A3095
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC61EDA3F;
	Sat, 15 Feb 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhHbjle+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94F1DF98C;
	Sat, 15 Feb 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646123; cv=none; b=gEuzjzJle9Vsy/1y1Pg+IMjAU2eBCoJnt7ci+1cIKgT/lCTcuq5JUAgeXW/4ZCFgkXigI/mYBwgCN7jc5NyfpxdHmOGn6GyBX7H8voR0OYVoE4UhKZj8Aa///cIxPqD7uSSGFje/tPTXmm36Z/uWr00dtgTkiTFkt54Uo3aPTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646123; c=relaxed/simple;
	bh=HudMfY49mSqAmZgoZf2dNEnXXORoyrdxby3o1hdTgAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8QF/IlyJUrwpS310JI6CBoHTwvL5cChIFzvf1CPnPgTge7cgY+u2xUIl5PXhHeSAVkIYxNpAEiB2ughrIZwk30wn01HDs6avyT/FCvU0rG/MZ+r17FuUBUY3eiy9OQXZDIlmXq5EgqyD0bm0ZvfXf7vn5mQ0ttnERFZZyoLl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhHbjle+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D0BC4CEDF;
	Sat, 15 Feb 2025 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739646122;
	bh=HudMfY49mSqAmZgoZf2dNEnXXORoyrdxby3o1hdTgAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dhHbjle+yGglktEW8k7sNojmTldB4vX4N3Z0d65mfgb3kNBfztQtB2ihersP3kWQ+
	 Kk2mNdH9UeVAkubXqkexsfz7Wnrc/zOLsJASmtFLlTV5tW4ropul2XVQLV9Yhf+5td
	 3uUaW14oEhvOWOJxbjRpgTMBoyh8jn2Yt/fhpoQoiF80vBk4k1YiaTfAQmntQrXSCJ
	 jQmVne+gM1bZ0OEemKcArDYoPcbiU6iP52UDfirZH955ffStsNghUdmWNzyecpCR/w
	 YxuaZmNxQSjg60JVHX/zShnBQEuc16jrPdoMByZZRYzL4dx71LLA7F3Tt92GS/58zT
	 Cp8DMnbuH0G7Q==
Date: Sat, 15 Feb 2025 11:01:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Florian Bezdeka
 <florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Joe Damato
 <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Bouska Zdenek
 <zdenek.bouska@siemens.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v10 1/5] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Message-ID: <20250215110159.0c1888ae@kernel.org>
In-Reply-To: <20250207021943.814768-2-yoong.siang.song@intel.com>
References: <20250207021943.814768-1-yoong.siang.song@intel.com>
	<20250207021943.814768-2-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 10:19:39 +0800 Song Yoong Siang wrote:
> Extend the XDP Tx metadata framework so that user can requests launch time
> hardware offload, where the Ethernet device will schedule the packet for
> transmission at a pre-determined time called launch time. The value of
> launch time is communicated from user space to Ethernet driver via
> launch_time field of struct xsk_tx_metadata.

Acked-by: Jakub Kicinski <kuba@kernel.org>

