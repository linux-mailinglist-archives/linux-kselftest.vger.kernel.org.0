Return-Path: <linux-kselftest+bounces-21202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F09B79AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6F285A11
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17E19AD78;
	Thu, 31 Oct 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="heIam3FV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsrpDDDF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F219AD48;
	Thu, 31 Oct 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374150; cv=none; b=gG7opQXsck0NgKyqdovkXc3EEQ/NOgzkwnuqDs4skU8RLSMxwKX0yj4MQZk9epQJtaL9vIvyltIAPBsH42ktim2B5d/siTixf0K97NUuUqlWqzyR1bE1qdw41NeI9ce9sFSbu5thN35I4yfyXfikFXsXZSlPbbmwSwrdOQrr31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374150; c=relaxed/simple;
	bh=UnZX91+/sQM8sS5+OTRnIXvFmFdxwbZ9VqP4wheZNog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkfgRMYQw7hxVHVdd8oW+fUhjo56TfEUfAnpzUrgVhgzGVJ7+E/5jKFWeplNJ64U/E+w8kQB1l04sp7A/dNon5r2P84CxuVkkyzCXxq2zqMiKFjm2sIbttt9ESHNjVUKbsxSq07uSA//O1ePOnVCM+U0sw32L3/7KSJILN/+Ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=heIam3FV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsrpDDDF; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id B66991D400F4;
	Thu, 31 Oct 2024 07:29:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 31 Oct 2024 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730374144; x=
	1730377744; bh=gbk2Ss8q1PE7LytElzmZKH60/pFHvmJOtscWfzfiW6U=; b=h
	eIam3FVft+wIAMxEiwUBm+yrngKlgGBEInd8P5WHuG0MYrW+pPB9uzWwVhdBbfs5
	vJz122evkXigKGnAwXe00jYLl4+qjm0EFt0dqw8DYJyVa9DFKCfY+7zbbLP9m4BG
	iTxyCphnQRaS8ixqda3rJ8aN5NH6KScYjHM7F++jg5EN7C7Mb9bqI8Wv1lrwuSRD
	oh6e8kTRFkJloMHhV0IC8xqAsXMNCH/kTa/Q6OUEqPeMurvzyS2XdHK5Q8oQm2p8
	usZAiuPt48ViD+WScwPI8odwqji/TquyijHko8ggztDlCSDM1H5fnqq9EYREgWJw
	YUUR7yXKL0IZ8Q2BKlKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730374144; x=1730377744; bh=gbk2Ss8q1PE7LytElzmZKH60/pFHvmJOtsc
	WfzfiW6U=; b=NsrpDDDFPsEJNUXtvq+hUUyQ+PuaGh6wSy1QIoe6wJvXv+3mABA
	X4FpfSbR21ekiJMpQHDwlEwGyhq9A7pnkx/rNxQpF27nCJqi7KeLYZgoS7iytD71
	49ntniFH2r36WTPQTCgizMy8xzexy6zN8ehTS3dWwNNDGtaeiOM2lXiCKRDM60yT
	ZHc0w1EX+nyruuEkSXgLx24nTgu6mzLbQ54a03iXsBkXLCtMcp3EKXem0NS5Ut/v
	sSvpxPTI4adA+qEXrkxWFD1hDkwqjcdLTkAqrMGJZCju33gAdpmbBc1iGHWc3kEN
	lPbWRtjjkPKJzkPkymkl9T032wuylshviZg==
X-ME-Sender: <xms:_2kjZ_NS2J05sVtpUpcKyfuqs9E8qHPfAQSs7VxtyTRMYjD8dlAdjw>
    <xme:_2kjZ5-_mwlaT120Gl5A_Kf-9gacRVazrCvxKHijxgSgRBBFPuXf_LftCjfSka0Re
    L0dVEwAdDvS2K03ofs>
X-ME-Received: <xmr:_2kjZ-TIbYXNPHM3lDKmaa28Fn-hHkfMtnERXNKgq1vcHGjOmGUtEOv-t8nz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhh
    uhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_2kjZzvNTqEm_lrGfkTOl6rLKFksu2FEleiizyZz2E9NYWkK301s3g>
    <xmx:_2kjZ3comBMwBJoTsvSs3XqkCb0uNSKf7AMZJweICidGhZ65VaddJg>
    <xmx:_2kjZ_3AvgyXaJtvWv6u0cWtQNLsFhKOR1AKFVXBzSsjP3WNO4-wAA>
    <xmx:_2kjZz8LdZCfj1cZgX7pHp1ulmTxPaUn_I5W9nM013C_A05_qHflRg>
    <xmx:AGojZ2yycHuetLEWJErbEG3p792N2DgvxpliJKTDAmdmRB14p8cucSXJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 07:29:03 -0400 (EDT)
Date: Thu, 31 Oct 2024 12:29:01 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
Message-ID: <ZyNp_WSG6ClueLe_@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>

2024-10-29, 11:47:22 +0100, Antonio Quartulli wrote:
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
[...]
> +	opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
> +	if (unlikely(opcode != OVPN_DATA_V2)) {
> +		/* DATA_V1 is not supported */
> +		if (opcode == OVPN_DATA_V1)

The TCP encap code passes everything that's not V2 to userspace. Why
not do that with UDP as well?

> +			goto drop;
> +
> +		/* unknown or control packet: let it bubble up to userspace */
> +		return 1;
> +	}
> +
> +	peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
> +	/* some OpenVPN server implementations send data packets with the
> +	 * peer-id set to undef. In this case we skip the peer lookup by peer-id
> +	 * and we try with the transport address
> +	 */
> +	if (peer_id != OVPN_PEER_ID_UNDEF) {
> +		peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +		if (!peer) {
> +			net_err_ratelimited("%s: received data from unknown peer (id: %d)\n",
> +					    __func__, peer_id);
> +			goto drop;
> +		}
> +	}
> +
> +	if (!peer) {

nit: that could be an "else" combined with the previous case?

> +		/* data packet with undef peer-id */
> +		peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
> +		if (unlikely(!peer)) {
> +			net_dbg_ratelimited("%s: received data with undef peer-id from unknown source\n",
> +					    __func__);
> +			goto drop;
> +		}
> +	}

-- 
Sabrina

