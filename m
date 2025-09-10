Return-Path: <linux-kselftest+bounces-41157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A10B51B19
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917A3B62579
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919A32C33B;
	Wed, 10 Sep 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sETkKnpY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWpMje03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8532A80C;
	Wed, 10 Sep 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516280; cv=none; b=m6ecqS4YhJMboQ7W6Ne7nvCtKjHoieNP+Z/ZwcspE8Ndj0zNqSmNH7QkfwOEObIa2SJP6+9240k1B4IgAGk53ZRCEbo8s0scfUnq8akUjYBDHp4uZxxFGZb+LVQOvGRYLcZYUJ+w26yK3tBL9tfdVSBvStMcBvt4YzbQblmiPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516280; c=relaxed/simple;
	bh=Vln8dfg2bHZWodEg9nnmVYDAn8PzYG29tHd56gGL644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxf3FUIIrdx+ozgzw3m7Am9zq0cSh5L0ou+/pgf62jPsFs0aqEHEHK7B97RAO+ptcdgrnMa+P1ohBAPdXLtQzUWZdrtI9CC9/a+MMKarBz4L6jrjIwjRsmCtRG2B+QM+/Otuc9oNmuby9dB3A7613KTjGlakPk6xvrCJ+HoLlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sETkKnpY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWpMje03; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B9101D0010A;
	Wed, 10 Sep 2025 10:57:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 10:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757516277; x=
	1757602677; bh=fj2WWlUvdozMy73vBjpbx8CvlLfiX/DewG58TQUw/5s=; b=s
	ETkKnpYjusLWEXoNeNa85hC3l2VxvioJqMnlZncO4mSdlN+Wy+p5+Ptj8gHUegFo
	raapCNQ5PC/o3QDw348mEcBfPaEUZIHjrKTxqiDThr7tfBM2WjTaR8auX+H6xmH1
	zXg1NNnFxlACbJyvM3Bmaz8uS2YluiGNZbMpIzc5E/E6Q3vEyYd8R/IuDnslBdiS
	/bvuf7U/GrH8k7jBRCBQMyAQ99JW62xuO35nn0CIfqRJZWzBB+aIvUCnOiYouY1c
	UwE2+xwwuxIFjZPCokJV7OQmM7KEqILW5xNLFUAhaBioHaDttHVqqyRkavgsvTIr
	+LAfQNeoo5W8NYP1v/pIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757516277; x=1757602677; bh=fj2WWlUvdozMy73vBjpbx8CvlLfiX/DewG5
	8TQUw/5s=; b=CWpMje03a6T5qWXd3hlOihHGuBovJsdC4Z3ADrG0anuP9M30tRM
	tqeWFgB/uXvh8hKOJapCnYNRjoSwoT3tEMKzoQv2j4/a5Ep8ycH1v0wcA5y9XRx5
	C4027bqatCeUBIfcr1sYOtet7BOXcvQv9yewwWzxNv3H0smxF9wX7BnprXsRPm+G
	+n8QcAAc+8L4IWy6pyfcQ32TF6nyeNs+19FE05rOlzOQxiZsgYQD5HGGOFZIbaA8
	bW13kS87FXfPPl+/1poalwZf15cqqAubeKtIy/9RZ+MQPp4SwiP94I2C6AotF0fa
	RxHmk+IjCviUseEiQvNp+tEdC/cavdK5p5g==
X-ME-Sender: <xms:9JHBaMxhqglCpDKMVYP8e8AhT9hCYm_vW9XWMjbgsCN2Wz9n18_pcw>
    <xme:9JHBaKieOE50pJ2hiii6EAkcuh9CHvCAeGYJSp2ktPM9DK7d235rXYehEMZNhT27B
    Yh_hh3K35xKQbu1l2I>
X-ME-Received: <xmr:9JHBaDwZr7ytM6UEkSAQt1WJ24fkjKSPcjoKYdvN3ltBLlUgHOG-L9ggqsGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvhesjhhvohhssghurhhghhdrnhgvthdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruh
    hs
X-ME-Proxy: <xmx:9JHBaAzGKD3_Ef-FY6jEcp89YnqsHMzNpevTwGyu24f0392oizoNIQ>
    <xmx:9JHBaFqydQnaNerRnnGOrEi4Q1oRjKuwVSiK_6NossEV5H9pkzW4lQ>
    <xmx:9JHBaLmLCNjLRGSjwcxl0AHP5Xow0j7Bya4JRF-UbdSvOGOtlQ14_w>
    <xmx:9JHBaGxqrul5Bo1bF8BBa6uuzM9PAbLLgh3uulAbuWL1tpNmxLWm-A>
    <xmx:9ZHBaHgWVcH9x5WKs83y1vh8qbqkI61H32j3qTvimxa4qUaBk44kN_kZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 10:57:55 -0400 (EDT)
Date: Wed, 10 Sep 2025 16:57:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMGR8vP9X0FOxJpY@krikkit>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909081853.398190-6-liuhangbin@gmail.com>

2025-09-09, 08:18:52 +0000, Hangbin Liu wrote:
> +__check_offload()
> +{
> +	local dev=$1
> +	local opt=$2
> +	local expect=$3
> +
> +	ip netns exec "$ns" ethtool --json -k "$dev" | \
> +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null

Sorry Hangbin, I should have noticed this when we discussed the IPsec
test, since the problem is similar for the other features set in
netdev_compute_features_from_lowers:

`ethtool -k` does not test the dev->*_features (mpls, vlan, etc) set
in the new common function, it only checks dev->features and
dev->hw_features. So this will not test the new function.

-- 
Sabrina

