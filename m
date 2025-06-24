Return-Path: <linux-kselftest+bounces-35692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F744AE68D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6921C21B40
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF472D3202;
	Tue, 24 Jun 2025 14:27:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BF291C37;
	Tue, 24 Jun 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775258; cv=none; b=UKLVwmIHBMFXBTCZGpSAXVyBRTvAI5kvra+YWN6bWtjee7/D3vOb1VorcIG7yEM6bkKJgR4c32Q/kr6zN+Kkjp74PXEKmdFKvQ0MubG9yvAjVAqqA+Qb1eA2jlABFeif2nSvIY0CIK4za7YQTmqWaoKdc780LrlainnZ8NRduKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775258; c=relaxed/simple;
	bh=1szUNF6KnsTqMQCfgfpq3RpcrkDvF5/wYVTUYcZrL9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBdCq/PP2FXVa2QM/I241OmWVxVLdGzTnHlxe+h1/mTqIh2lT9tNJrZNvLk9iYex9llmznvyyn+HsuVJTVdqfuoRjFO/ivDO1ddeYxMemekkM+0V0kuBDDEkyy17L8YZEZBQ9p3EinCGjeBdUke4zS2um8pKTDCTGrELdTaALMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0a420431bso212275566b.2;
        Tue, 24 Jun 2025 07:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775253; x=1751380053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLCaCaOTb4cF+Wte6sm9P0O2OKEItr0RiopbN7xQeu0=;
        b=gdCQEaLWtOmN56uvQgODWP0Kcx7lqdrYvP7Ua9vM9FSauHKSejcQIjNxq7y5xMr+dG
         +LviM1N11ESJ30Knt8vNr+7dhR3bGgUNPosd0F0/RTZ7cpI23wBymOXGRUmXumNg1dAg
         CjRWy8+bOuptFZMKvdsh0xrzII7d28EnPfKeezaJqSLD4JLQeNtx2obrBpa5N71TDtq0
         JzEItEQNSHWeRkdFAH5Hxghk+aIPn3qc7SFncVgo4VVoo0ZZnw/An/wEfnp/hjq+rSZm
         2rpnPg5TbbNfbWjJbGgsCfrAWeJw7o9Hz+YZO2mu4R8cjr3NvQQKHUleZSSh5o8mxfpQ
         GUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKK1xfXsjRBXi+Zhk/g/INuNyyMkfkEfARTwq0Da214kfYT3ufdrtxA6asnVoOFaBNwDwwkrjd@vger.kernel.org, AJvYcCWUjelTT2kG4YB/AKqn9GdiSu3qfPgEUtDthSaGLMyrc9lYBvKh8B3SYRX6iG9ilCi/2Dpio2+HarCaigY=@vger.kernel.org, AJvYcCWeocTrfGIwPWA7uloJx5G2+LjDu/4k+8YYiz/Q6G0uDQU0i41UGuQOlIphN5FJDxsOQDb4UXkf6ocBA9nlPUA8@vger.kernel.org
X-Gm-Message-State: AOJu0YyGes26eHmW9C/QvDtGsJlhnHL43yBhDLqWYNazC0ElIqzFTt3V
	GyibmhRiCzEh8WSgK5PM5WohzD4OOv4QOuQKC55XZWRGpPTrxCY+UPpy
X-Gm-Gg: ASbGncuw903eiWcJ7245WJPAgYCragmcu385LkQK29wilcQChc2Jqb4k47GKEt/7dpq
	FMVefQr+mxV2FzR7r371MJl2gMIOZcU85fqZSySEyxwf3g4Qg3obagNP3u3m/9uFv2wCCrR5Ct6
	RcT9VimYNyVVFlGSVWrZ9fUkfObYT168GVffrBKcMaUvSExGDNgxY5hfG1dS9wkccou1yoy+yq2
	nAuy6+ceJgB8iE7QfEJCj30Cs8MltkkRiiFeGO5Mn650drgnoPMBdViqBTdy7PETWBEBUH2/fDP
	jVpVo+QvOWO8aTtFB+KRlE+mw2B6/9a0iGmzr8GuPsLVvG5VkRXoyVqxLVY=
X-Google-Smtp-Source: AGHT+IFILPyMtwDOx7dYBC+cw+ruDb8Y3KGn15RJ43QElepTSN4zsNDHc469pKVmkARFZbwmhHvr+g==
X-Received: by 2002:a17:906:fd83:b0:ade:3b84:8ef6 with SMTP id a640c23a62f3a-ae057abdef2mr1619028966b.23.1750775253066;
        Tue, 24 Jun 2025 07:27:33 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::7:6c51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7f534sm878164866b.9.2025.06.24.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:27:32 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:27:27 +0100
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	gustavold@gmail.com
Subject: Re: [PATCH net-next] selftests: net: add netpoll basic functionality
 test
Message-ID: <aFq1z0BS6RCUCNwa@gmail.com>
References: <20250620-netpoll_test-v1-1-5068832f72fc@debian.org>
 <20250623183006.7c1c0cfc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623183006.7c1c0cfc@kernel.org>

On Mon, Jun 23, 2025 at 06:30:06PM -0700, Jakub Kicinski wrote:
> Could you turn this into a docstring?

<snip>

Sure, I will fix all of them except C0301, which is a error message
string and I prefer not to truncate.

> > +def set_single_rx_tx_queue(interface_name: str) -> None:
> > +    """Set the number of RX and TX queues to 1 using ethtool"""
> > +    try:
> > +        # This don't need to be reverted, since interfaces will be deleted after test
> > +        ethtool(f"-G {interface_name} rx 1 tx 1")
> 
> Would be nice to be able to run this test on real HW too.
> Can you add appropriate defer() calls to undo the configuration changes?

Ack!

> > +    try:
> > +        for key, value in config_data.items():
> > +            if DEBUG:
> > +                ksft_pr(f"Setting {key} to {value}")
> > +            with open(
> > +                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}",
> 
> Could be personal preference but I think that using temp variable to
> store the argument looks better than breaking out the function call
> over 5 lines..

I was not able to get what you mean here, sorry.

We have config_data, which is a dictionary that stores the netconsole
keys (as in configfs) and their value, which will be set in the code below.

What would this temp variable look like, and how it would look like?

> > +def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
> > +    """
> > +    Test netpoll by sending traffic to the interface and then sending
> > +    netconsole messages to trigger a poll
> > +    """
> > +
> > +    target_name = generate_random_netcons_name()
> > +    ifname = cfg.dev["ifname"]
> > +    traffic = None
> > +
> > +    try:
> > +        set_single_rx_tx_queue(ifname)
> > +        traffic = GenerateTraffic(cfg)
> > +        check_traffic_flowing(cfg, netdevnl)
> 
> Any reason to perform this check? GenerateTraffic() already waits for
> traffic to ramp up. Do we need to adjust the logic there, or make some
> methods public?

Not really. I can just remove this code, in fact, given
GenerateTraffic() already waits for the code. Or, I can add under DEBUG.

As we discussed in the RFC thread, I will add support for bpftrace in
the v2.

Thanks for the review,
--breno


