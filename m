Return-Path: <linux-kselftest+bounces-42229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E406B9B1F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B9F4E2EE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B959315D4E;
	Wed, 24 Sep 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QczILfrf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bdq+eCwb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8722068B;
	Wed, 24 Sep 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736265; cv=none; b=Eh8p9hdxctzKGnD7xst7FGvi82FFFUpxfELw12k52Myho1PwgOf2QRAB908c+xLdZnLmiKw1FU6+Ae0jPqlPSaTvqIm79kFcdZGD3DEcBGCzJtSkpJhFb8tRx0SCLDqv/df0eopEMWxMDBwJjbX+A3grl/2SXAdjNvH8XOJpjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736265; c=relaxed/simple;
	bh=rtsBUMiaIy6TYtCPgN29kdioK8qxXz4HS+p0U7bKED8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWwctPpr5tUEXg8HBeOLDED5++iAAbeoW3c9of74I79qfEGjDLvfjNIfgesLW6Mc4kjryTN1G66OkXRClc/FPAA/tYQjJfFBg7Do1ZhYiM8lY2ormAmhdJV1/ByNkKgSuIRb85C93Epzza0BT/rqYrij24G5GLonRvh30NO9fAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QczILfrf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bdq+eCwb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ACEB2EC011B;
	Wed, 24 Sep 2025 13:50:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 13:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758736259; x=
	1758822659; bh=PiczgBaiQtiGl2TfSKm/7nhe5+iR70Rhzl3gA9tA4t8=; b=Q
	czILfrfaCryzpAn7FTDCOkU4mXFif1KGRsJFf+nqhKkK2wyjlVimQekZthRw/X0c
	1cgpuwrJGpZYabC4RRifk3SAkpomHJ7psEOt5E3CRREQBnDGFQD8630/RhgCHWnf
	49HWZfgInWzF39gcMimN5iMrj7qHm+4l9XWBB+CWhpLbKuHezAVMHkE53eFhweCg
	Xdk7TyMqSCBqNciFL6sdW+VoDtrXie/AE+OK/qWuKZ3wmnI2qbqniwqewACVq/kd
	oJ3SI0We2uDwr5x8ufolHL2NKSrhxzsj8K9+obCdrnbX96Wpi+oSkTG4rP13ECM2
	7NaG73PZgg7H0LnmOxyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758736259; x=1758822659; bh=PiczgBaiQtiGl2TfSKm/7nhe5+iR70Rhzl3
	gA9tA4t8=; b=Bdq+eCwbxtxzRNOsR8717EgGC5QolF7SafR6Wo0TrBqyBvg9hS3
	Rb1daOyUTYG0M1p0hevo7DXVqNKMyWSb0+HLHWHzUAjoE/9YG3479mQuet1S/kBf
	e0jLVQorcI0YhADKZLt5DN7mAXCYdK7MJayZcYN1ZvYg0bKEe3q6f4gvba5Zepa/
	oYajmRToWgT1H2MWdKTg3ikXS1wI9IMrNRPua8b4rcbHKcvPHLu7JUe6ETBtgoUx
	J5zv2AvzNCu95C6Op0mJkdLAB/QfzJctUrTS06toDXT6X2uurWjWSWbxfAfsEaSI
	NWa+6zs59LceIYGNZ4+Qaiqh0LVX9O54pjQ==
X-ME-Sender: <xms:gy_UaORv2Dmfrkm6tT1VOuUYQo_AIqpUZ1_DV65rQt6wrDyVmMR0Ug>
    <xme:gy_UaAL8vjSu9UE3DI2KoCD42JGXQ3H_Xi2hO5Vlxxv1YKM5fWtIvSud5nSv_qqOD
    uxR6yM7EFzAQymvX7BGO5BmIKowKcEiljYix5oTxar68wJDrMXkhc0>
X-ME-Received: <xmr:gy_UaASqTlwzJSltULq9NEnyq7F2ljIXeejhvzcdAfrOu_GRF1nt8oXB9VR2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifihhlfhhrvggurdhophgvnhhsohhurhgtvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgr
    thdrtghomh
X-ME-Proxy: <xmx:gy_UaIIQI7XWNZ459IUHenWHcPHY-1v6-bG-p13xn73_B9DvTLC4bg>
    <xmx:gy_UaD9zYUFp84SD5QahjPOYQvCHKcxMFjlhARyRuX5sCKOw9qZhKA>
    <xmx:gy_UaPLPg18Q85Q3RIlk2lBsgQujyFxFv-dFJUvvCGCxZfaL1xeTmg>
    <xmx:gy_UaCH7NTsy7RvWNVxA4BCzhEoZbAMr5rOVA7oP4feE5luMjAim_g>
    <xmx:gy_UaFJ1flSdn3jq17m_cxUMK9qM0eOzppBQZJYAfsTaH9KdgdyhIB1b>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 13:50:58 -0400 (EDT)
Date: Wed, 24 Sep 2025 19:50:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	john.fastabend@gmail.com, shuah@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Message-ID: <aNQvgD7AvFe7-sAv@krikkit>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923053207.113938-1-wilfred.opensource@gmail.com>

2025-09-23, 15:32:06 +1000, Wilfred Mallawa wrote:
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index a3ccb3135e51..09883d9c6c96 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -544,6 +544,31 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
>  	return 0;
>  }
>  
> +static int do_tls_getsockopt_tx_record_size(struct sock *sk, char __user *optval,
> +					    int __user *optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	int len;
> +	/* TLS 1.3: Record length contains ContentType */
> +	u16 record_size_limit = ctx->prot_info.version == TLS_1_3_VERSION ?
> +				ctx->tx_record_size_limit + 1 :
> +				ctx->tx_record_size_limit;

nit: reverse xmas tree


[...]
> +static int do_tls_setsockopt_tx_record_size(struct sock *sk, sockptr_t optval,
> +					    unsigned int optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
> +	u16 value;
> +
> +	if (sw_ctx->open_rec)
> +		return -EBUSY;
> +
> +	if (sockptr_is_null(optval) || optlen != sizeof(value))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> +		return -EFAULT;
> +
> +	if (value < TLS_MIN_RECORD_SIZE_LIM)
> +		return -EINVAL;
> +
> +	if (ctx->prot_info.version == TLS_1_2_VERSION &&
> +	    value > TLS_MAX_PAYLOAD_SIZE)
> +		return -EINVAL;
> +
> +	if (ctx->prot_info.version == TLS_1_3_VERSION &&
> +	    value - 1 > TLS_MAX_PAYLOAD_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * For TLS 1.3: 'value' includes one byte for the appended ContentType.
> +	 * Adjust the kernel's internal plaintext limit accordingly.
> +	 */
> +	ctx->tx_record_size_limit = ctx->prot_info.version == TLS_1_3_VERSION ?
> +				    value - 1 : value;
> +
> +	return 0;
> +}
> +
>  static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  			     unsigned int optlen)
>  {
> @@ -833,6 +898,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>  	case TLS_RX_EXPECT_NO_PAD:
>  		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
>  		break;
> +	case TLS_TX_RECORD_SIZE_LIM:
> +		rc = do_tls_setsockopt_tx_record_size(sk, optval, optlen);

I think we want to lock the socket here, to avoid any concurrent send()?
Especially now with the ->open_rec check.


> @@ -1111,6 +1180,11 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
>  			goto nla_failure;
>  	}
>  
> +	err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
> +			  ctx->tx_record_size_limit);

I'm not sure here: if we do the +1 adjustment we'd be consistent with
the value reported by getsockopt, but OTOH users may get confused
about seeing a value larger than TLS_MAX_PAYLOAD_SIZE.

-- 
Sabrina

