Return-Path: <linux-kselftest+bounces-42456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFECBA340A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DFE388388
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D929E11D;
	Fri, 26 Sep 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cas4uuwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98429BDB9;
	Fri, 26 Sep 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880414; cv=none; b=EdUmem6yRr5OsRgifCCauUICkIysHQLK44WxcrsSpeiy16Q17yTn4+ag3JrW/XLcDFjVGmZC4adaT7OQeMuq6eqg7LJpZCjkwvxWbqJhiV5lyAtCmBCwMbd28eqGDy+DuQURils0ILvzAUhSEFZTlHTn5cBtdRE7KCcFhhk8y4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880414; c=relaxed/simple;
	bh=ABg3JBeJ+y7C2RlZnbDls+ChldG2KSsda0gRwyTvuI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwLjgw5LtCAfrtdEyKbRJGmLWK/nx9qdJrFs2CGS7spPWwyc1rBG6IXWfWaJABTYCWHIaxUYwM3NUFlQLg9o1dFbuFd/A6Ah0532a/CmBuGd6n2zfo9jh06PVB7D02z48gEQ9XsBRMVMmCfVugClnXABhBdmLzMXDPXde5nZu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cas4uuwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7FCC4CEF4;
	Fri, 26 Sep 2025 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758880413;
	bh=ABg3JBeJ+y7C2RlZnbDls+ChldG2KSsda0gRwyTvuI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cas4uuwFB7OKkpV/FnG+acSoxR41ScdeuIv7ja/onD16BlgqutbP/jnASuWyGWEdM
	 8A4uYWl5EAcwpG98C1N4Ag1ZWbEMdhOxY1CwbS9Y093SnHo/Sin1nllvyrnAwoE4wY
	 /ntmer5ATxSnRkDWeyQm9kDH6SgE7j1xrIeQQ5gV6+naE0yRVLQg3yN3zR5TwsOwPL
	 ryAMFZtLb7ksQyThdnNDE0OO4R8B+WSD34eiH244lSeGsUy6BHHQtJY9/5HS8rzLa4
	 CYBCEcCYH2R+CoaLVfxIQlXLRnqv3w1HQ1sfFRZDF2xZqoZrxOEgSX94ofgcD2uSFz
	 e/lJOFgG/SQaA==
Message-ID: <0608935c-1c1c-4374-a058-bc78d114c630@kernel.org>
Date: Fri, 26 Sep 2025 11:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/09/2025 11.30, Lorenzo Bianconi wrote:
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + * ``XDP_CHECKSUM_PARTIAL``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE`` and
> + * ``XDP_CHECKSUM_PARTIAL``.
> + *

It is very important that we explain the meaning of XDP_CHECKSUM_NONE.
As I hinted in other email, this also covers the non-existing FAIL case.

If the hardware detects a wrong or failed checksum, the code still
returns CHECKSUM_NONE. This is where we could consider adding a
CHECKSUM_FAIL return value instead.
The driver will also return CHECKSUM_NONE for the cases where it cannot
parse the packet, and therefor naturally cannot calculate the checksum
(given it doesn't know the protocol).

Thus, for CHECKSUM_NONE we don't know if this is because of bad checksum
or hardware don't know this packet type.  The philosophy is that 
hardware might be wrong and cannot know of newer protocols, so it is 
safer to let software handle recalculation of checksum for all negative 
cases.

Thus, if we want to use this in a (XDP) DDoS filter, then we need to
combine RX-hash info about if hardware saw this as an L4 packet or not
(see XDP_RSS_L4 / enum xdp_rss_hash_type).  If hardware saw this as e.g.
XDP_RSS_L4_TCP (or XDP_RSS_L4_UDP) and rx-csum is CHECKSUM_NONE, then we
know this was a wrong/failed checksum (given this hardware knows howto
csum TCP).

What do people think: Do we leave it as an exercise to the BPF-developer
to deduct hardware detected a wrong/failed checksum, as that is possible
as described above.  Or do we introduce a CHECKSUM_FAILED?

An argument for sticking with CHECKSUM_NONE, is that it will make it
much easier to add driver support, as we don't need to deal with any
logic changes in the existing code.


> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     u8 *ip_summed, u32 *cksum_meta)
> +{
> +	return -EOPNOTSUPP;
> +}
> +


