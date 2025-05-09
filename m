Return-Path: <linux-kselftest+bounces-32696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B0AB077D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77394E3E8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB58632C;
	Fri,  9 May 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEsa+DP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD983A14;
	Fri,  9 May 2025 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754658; cv=none; b=Dqg7/OOcx+m4no8/DWiqL7bmRvwRdQlAB73yQKHPeB0+YM1pwntIF78fVVnG18rxdj1u1zRgOreoZSpEvzZ+geQ0T5dtr6l50xm6Z1O1zG4auH4Dk1TOiRv1jc/19yeopQ95wv1tGqmhexyUkVxuxeCBe3N0J2eX2l/j8I0Ujyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754658; c=relaxed/simple;
	bh=lSb4NxMm3Poop2YhDM3uMtoi0BHm4ORlg33b1z92nDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMTkynOFL1Q3NDV5FHjP/rUB2FdtXkd/ZjPy60xhcpnAqShRvDQbOkhUel6irFMxmGlrvOQ4mYb6Qn6Zw+RyEWle50Jj7YlkJqNzLpMA30S29g5n9GbLuEyrpOTHIuNiy7RUiL4/hgomuFveIbx9DK5pEF/SOfqAsRhtjoOmTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEsa+DP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2842BC4CEE7;
	Fri,  9 May 2025 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746754657;
	bh=lSb4NxMm3Poop2YhDM3uMtoi0BHm4ORlg33b1z92nDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEsa+DP5kOsuz059NZovul//GMwO5mpaElk8vKVmaLq2AUlASNdItKqVoFDVnRR0D
	 4T0ApRX/MZVbGWyRNyi7o38nSdf86JXYLRwzyBDsV7qgd1D4FdWELfoiERzSNx7Ur2
	 HfZwcXY+gydYl4CxjXfoRXa9CAUI5qT5QSfmhP49Z0i6X/xemRgf/+xvtAn6Wn7+mM
	 TbrO+hVHvScXnOxJb9dUM2Dmg93azSfyXQgkrYvi51rFxEIGYw6WMKPZ21r+vu4EHS
	 ukDhcWEKtcCO43EOhxr7+YASv7fsG8VF5hcNRAEbTqg+AQwF1hmEjQO+LDQmIAUVoU
	 UCFb+HCWH2V5g==
Date: Thu, 8 May 2025 18:37:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping
 test restores checksum offload
Message-ID: <20250508183736.74707daf@kernel.org>
In-Reply-To: <e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
References: <20250508214005.1518013-1-kuba@kernel.org>
	<e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 14:59:12 -0700 David Wei wrote:
> > +def _schedule_checksum_reset(cfg, netnl) -> None:
> > +    features = ethtool(f"-k {cfg.ifname}", json=True)
> > +    setting = ""
> > +    for side in ["tx", "rx"]:
> > +        f = features[0][side + "-checksumming"]
> > +        if not f["fixed"]:  
> 
> I checked and found that "fixed" is a ternary:
> 
>          "rx-checksumming": {
>              "active": true,
>              "fixed": false,
>              "requested": true
>          },
>          "tx-checksumming": {
>              "active": true,
>              "fixed": null,
>              "requested": null
>          },
> 
> Python loads this JSON as False and None types respectively, and `not
> f["fixed"]` is true for both False and None. Maybe this doesn't matter
> but flagging it.

I think so, yes.

> > +            setting += " " + side
> > +            setting += " " + ("on" if f["requested"] or f["active"] else "off")
> > +    defer(ethtool, f" -K {cfg.ifname} " + setting)  
> 
> This does rx/tx-gro too even if not explicitly requested. I assume that
> is okay?

You mean because those are automatically updated when we change
checksumming? If so then yes.

