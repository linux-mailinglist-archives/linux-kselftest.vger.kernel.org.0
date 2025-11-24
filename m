Return-Path: <linux-kselftest+bounces-46393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3EC816E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DC33AB372
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88679314A78;
	Mon, 24 Nov 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="may3B/Bb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUUcFB9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1F314B66;
	Mon, 24 Nov 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999489; cv=none; b=twaby9KdKbUhnCxm7rvdIZLcL7I31fSjBIIDKVxbYCjPXkR9dCIvj3GhpbaUgSMv/4dK3juNXvFomE4XFR2z7n3aboh/+LzFdHuM7Jzot56Tcsz8ccNIZvHpeB7/jHZdygZx3F5M7gtQXMeqakQ70RqOSgYQmEuCQ65Ea6iY4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999489; c=relaxed/simple;
	bh=otuPABYn4zLwUeEOIQLHE6rTXs92bXeq1cLf1V9VM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpUcjIVu1BRY0g/f6BI964ALx7rqQxMPuOswSAd1guglmyEG4gpeknof79zC2d33uOOZHG+kGY+H8TZrfVXXxo5tJNc6G/TVTUC+UH2Pt4djxSDEFbyO41nUf2Mot1sBj9dqDC3EMDNxCD15awaL1kGJs1t/j4NikJoNZF+IPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=may3B/Bb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUUcFB9F; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2ADAC7A0056;
	Mon, 24 Nov 2025 10:51:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 10:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763999485; x=
	1764085885; bh=j/N6nmudtOU9Fqi2MivRj53BzTIm/n1CHOnrw2jDlzQ=; b=m
	ay3B/Bb09NprPopA4WkvSgDBpUBUtjZdwsV2RlLREisa7Ki00A8g5+GSZ0fINMo1
	YPlys3kuXxf9OcwtSBBRwMngne7jr7y8iamXNAKGUAnGT3IQmueHNfjoNuA6c1L9
	IA04rM+rupRymcYU7tVDM9g0V3N1adBWuYzRWYljO6OLgjwIxbr1zY6P4Zsr6oD0
	pSSHbaDsx08Z26d2Nnt3AWatcfDWe+e7LAKHhwUi/XwC3SLDtpsxkAioezffKjwi
	REGgc1Y/C0ZCKPQM/cnCfoSe8GDMd1Tp4GOiniCp99Oyf6sj8Mb52bjrhrgwmm8Q
	2cvqLXac8cR99whIvjX6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763999485; x=1764085885; bh=j/N6nmudtOU9Fqi2MivRj53BzTIm/n1CHOn
	rw2jDlzQ=; b=NUUcFB9FNa72k7qub7uOQri2nr2pnZSGezVF1qe/r27Jyic9fdH
	eXAHPtqn13Svmcuq1jIGv8SCablgVFRmxYR0p9v36uFLUix4s3skpCEFVG/n08Ht
	TyAmi7Y++0LrgPP9tzYgzfFiXyl7t5UB0AYCh0hz0xxaOGMejRquL6f2b/Z+UgZO
	n0uDR7JD7dQjlEFqqKhP+R2nlx1T7bKs8sjwtm+1xnq/HqXmVxzSxRE1Q/rZzbDN
	pw9r3cEzWJIFA5t/tsUCbqIlhonxuGns1RCbk+dOp7psfwRDI+PWrMTr1/FvJEHj
	FgtUMPvJ7U4ogvCzN+d+4joAqWlWdEqbGKg==
X-ME-Sender: <xms:_H4kaWtF8tYI_ZMOopKV-XUce7WcElBgRa9S-bOLKsMIi8GZs1W6bQ>
    <xme:_H4kaUwgF9yYJ7IV74JwI4s2q09qDiN2Yc97OyQLAh_tgpzyDgLBwtbFf8UTGqHpu
    CZMiqYRwK8eL_DH77QZ2__ALTZtkIDl5hPlFGSyhmn1ajlIf-dBvkc>
X-ME-Received: <xmr:_H4kaZDXYpGTigOk6Ybaen7f9h5XQBz7AdQv6g9rkGyEL2IqUMqRRvGnMZz6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:_H4kaSdHsdxbhkTEOK-ajvV5yN7k62VA7w6h6vjNzazhR2yysDAPCA>
    <xmx:_H4kaTnMZLXF_eXOKZd4VoOQv2n9-RK0fR0O22ELDx9vw7UdsdlYgQ>
    <xmx:_H4kaZEuwHxybmBy6xYhy1S8CHqlaBi_pLo3UF3-qDSa3pQ8s3v_6A>
    <xmx:_H4kab71mV55cRROKXiHhmbfN0PqMxGnK9OXI1gW66gn1YwO5WSTXw>
    <xmx:_X4kadn2wXu96XSj7j_RUNJv2fj9TTSFYV2sSz2RFKo4GTSZHBMWwE2k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 10:51:24 -0500 (EST)
Date: Mon, 24 Nov 2025 16:51:22 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC net-next 02/13] selftests: ovpn: add notification parsing
 and matching
Message-ID: <aSR--l90hvP6Fkld@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121002044.16071-3-antonio@openvpn.net>

2025-11-21, 01:20:33 +0100, Antonio Quartulli wrote:
> diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
> index 88869c675d03..b91cf17ab01f 100644
> --- a/tools/testing/selftests/net/ovpn/common.sh
> +++ b/tools/testing/selftests/net/ovpn/common.sh
[...]
> @@ -82,6 +99,23 @@ add_peer() {
>  	fi
>  }
>  
> +compare_ntfs() {
> +	if [ ${#tmp_jsons[@]} -gt 0 ]; then
> +		[ "$FLOAT" == 1 ] && suffix="-float"
> +		expexted="json/peer${1}${suffix}.json"

nit: expected?

> +		received="${tmp_jsons[$1]}"
> +
> +		kill -TERM ${listener_pids[$1]} || true
> +		wait ${listener_pids[$1]} || true
> +		printf "Checking notifications for peer ${1}... "
> +		diff <(jq -s "${JQ_FILTER}" ${expexted}) \
> +			<(jq -s "${JQ_FILTER}" ${received})
> +		echo "OK"

Should that OK be conditional on what diff returns?

-- 
Sabrina

