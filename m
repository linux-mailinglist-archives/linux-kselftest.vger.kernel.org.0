Return-Path: <linux-kselftest+bounces-6050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7C875035
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D961F21D8C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2412D1F7;
	Thu,  7 Mar 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9H8kAPv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5o+fsxtp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43912C801;
	Thu,  7 Mar 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818717; cv=none; b=tLyhsHtY3GwxI9icn6bzBL64dUFLf7+azPkkeltZtqCOqDjpBUEZmPn6RFj3Oy4Rs+nnTXeSyISvV5N+Y0gboFvhULKHr3/HAQrKPYHnuZs0aSyhPNSFA6tIrhk2ghNgfrAWv0HDYEJZrQMT+RJ5sIvCir+X95Z4z/zEonxDiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818717; c=relaxed/simple;
	bh=pIgMBBvdlFq4jsZGTTvCeN0WxNn+N/qtdB4CfQxf4sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRPpcAUzNjMgtP/Oj3ubwbZo+CP9Qx3J8d8XX12szQ4yMRlKhqGiu+/EsLHcub6cw9qPGHvPdTVO3/qWNBMiSrFEZKkoqotuI6aNjO9vEake5nHLdlrsof3/wu07NjPEcYZvglktTQ7F70WmxB4QbhwKm0QOqdbtY1zM7uN25AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9H8kAPv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5o+fsxtp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709818714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SB4kuCbnB1I2QFSjwFkPG9Zmio3lay0lzfUcc31gg7Q=;
	b=u9H8kAPvhSJvJGtXtKSYHK4bcix7rnKNSjfap1gntl+bLs40s5fFCi6l4pmv5C4bQJXO83
	TjSwSWlmO7kJ8xenqcUBW72vGyjmDzliF3kyWmtTWlac2mgILjH/1QcN4QOeMJTgnTu/tp
	pNQPI2W1jXfPRS6WODxh8LcUw3N+0vl93CWfnJHNmK0s+bmPRfDRmogYXYDL29/d/NNxLc
	dwFCOOll1/37QUIc9+IEAMCVQEnPPiEBUiTrRoI+YegqKoYrJKnWshzkRYZ6PofQ73VoyT
	VoQwfEJE5fBn7ABUlNvih+ye2H/P6KweH8zmftvgStzsucgHeOsM5GZbpn6UKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709818714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SB4kuCbnB1I2QFSjwFkPG9Zmio3lay0lzfUcc31gg7Q=;
	b=5o+fsxtpkLCbJ0Ppn+2MGX95fwrdlBx5VYy77iOoFE5udU4LXZmCdpcc70zBfbDyEAyuP9
	rhnGCkZZMP/lQ+Cg==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@google.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 xdp-hints@xdp-project.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [xdp-hints] Re: [Intel-wired-lan] [PATCH iwl-next, v3 2/2] igc:
 Add Tx hardware timestamp request for AF_XDP zero-copy packet
In-Reply-To: <Zein8XvWkqj8VrHs@boxer>
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
 <20240303083225.1184165-3-yoong.siang.song@intel.com>
 <Zein8XvWkqj8VrHs@boxer>
Date: Thu, 07 Mar 2024 14:38:32 +0100
Message-ID: <87a5nago13.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Maciej,

On Wed Mar 06 2024, Maciej Fijalkowski wrote:
> On Sun, Mar 03, 2024 at 04:32:25PM +0800, Song Yoong Siang wrote:
>> -	tstamp->skb = NULL;
>> +	/* Copy the tx hardware timestamp into xdp metadata or skb */
>> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK)
>
> I believe this should also be protected with xp_tx_metadata_enabled()
> check. We recently had following bugfix, PTAL:
>
> https://lore.kernel.org/bpf/20240222-stmmac_xdp-v2-1-4beee3a037e4@linutronix.de/
>
> I'll take a deeper look at patch tomorrow, might be the case that you've
> addressed that or you were aware of this issue but anyways wanted to bring
> it up. Just check that you don't break standard XDP/AF_XDP traffic :)

This one doesn't crash standard AF_XDP traffic. Don't know why, but it
seems to work.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXpw1gTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgl4bD/9QHm43zCKRDfGU+Xr7XPWXNlbFxEIr
2rXt5ujhN1t6VfmaiOY3QyCuU7C+9lI/LR8J8IIzSw3quIIALtrgzjukPYgw8ICh
JoS0P18HMJbpIAWKCLOTZ5jry4Vhg7nB1ONwWCyZeJnxcUdmKgXhc7hyEBDcr7Is
VMqjvME3qsOb1WgoYVxUZO1/jjGQURn98O5nee29HuXzMSnUWB0l0OkldTgT7gt5
jT7yAyh66lei+9D+n6kEs23R2Gx6BmKw6SXLqj7Iq3t6Fe5B836Yc2oiustThPJ4
Mannvof2SnRdzsGEouBwumk95f24ssI3JXc8zKXAaGo+h9NdgJKtc+muz5ctgnLz
Z8mEAJHmaGcFi9XBC2LZsmNozox9rZMR/KRO6xTtZv+sKodNecZoYfriF0pZ+bu0
ky36jP84qoO58SBWtrBkSJYpPtmRZ78gR6Chn6idT9BxO/RcCNSxntGaS7xDwlb9
5DvxYJ5Saq4EEZFYl+YTDxwqohSwBFDjYhcw2qhWxMY85H8H9xjgVp//bxCSVexh
kPt9RBERHc5GGMBc3h9l2iodmfaEPJdKJ03gqOwoRYd1by7RtO6WcSDUpxhSIthq
Wi5XZqKBB+IoM0N8zTZD/B1veZH/FWco6rEqhVr1DPfMsgP7l/8zbabERu28L3VP
V0gtgB9MKcXqGw==
=5vqC
-----END PGP SIGNATURE-----
--=-=-=--

