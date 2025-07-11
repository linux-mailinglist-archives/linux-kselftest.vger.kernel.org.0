Return-Path: <linux-kselftest+bounces-37129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6AB020DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326741C252F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0E2ED842;
	Fri, 11 Jul 2025 15:51:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782617A2EB;
	Fri, 11 Jul 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249086; cv=none; b=JHVAIhtKGEqWdYYnyH/iQo9iov59lnX61bSVtMelJ0kozdXMjatLF/gqJOU9GfwlxMU8OoFvdi2cL0Gc1VDK3Wr3vitNWLRlKGaPq8PXnbiiUGYkdUWhaYy/cUWZZ79Fy+BnPJJkzuV3BCSFPV8YwLaKw6eRPZCNPtCuIIGMFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249086; c=relaxed/simple;
	bh=tMvjwrUUx5JzCR1Iuf+ULRuuEz6wXdcmmxLtzBGITY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pneGcFQiJwFk3KZYZlDq6hiicWQqQPrzz7VJfmGZx0ROQlxOYvbowPWYuOeXQ9/6vezC+EYKF1546Tsx1FbMxJ9pOIIYJanqG8xbiRgXQvIxYaPU4FLyS50RxOqx4yVV8CUH1GYHU3LjwPfxwz2v8EHHr0N0aIoVD7InoX4Li7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso403714266b.0;
        Fri, 11 Jul 2025 08:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249083; x=1752853883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EemhuuktFGN6h6gJqo1Xlj4CNK5k2utZwixQsaHrULo=;
        b=rerlI0ugJ8fDXN1qsLjDKERH8aAaqm49m4dATqkCDYq0VdbXi3U/I4VFKrMDvVJ6un
         mR2hDB+wqqMc/XaFRyBARBW5iZeMu15q0pczcD5eNnZHp5nsIl9DDIUITP8XvIxulDDa
         VUm0lXMIHSUSZuSa63F3aQzbATsB0shrnmPMi1P2bClNny2lWx6U9tXC4kmf6ud/Vij2
         rimQb6HPxdFmREKhpK3Yv2G9gxSj7l/5WuN+dugbxOFgMKIZmZRV6LrDkAwXbq6xz8Xo
         YGusPg5OKoagshFS7qdLo3hwDc2XNyKtKG8b7iwSiDgP8x58Soj7YZHnrbrkM3/HC7S2
         +cGA==
X-Forwarded-Encrypted: i=1; AJvYcCVxRmfFBdycptvtCgJ5aLGJmMUAye6DT3OVwDvJwzxdJKhCRwG4Em4sxL6A0frGROYnXFzv1/CI/vWY1Pgl@vger.kernel.org, AJvYcCWdHoLCcUolE9uzgE/S2KEEllnUHAFXg5DaZBlODPVDrgvzBwgnWjRyNRayj+BL/4XRkKOG8gc+@vger.kernel.org, AJvYcCXBiVR273NbGGjsvLo40VujFwxigPrNfr5kmnqxYcR0AkeJUujM7LCLFRWgao1xtZOtVG/9RhPj3cpRsVHI0Czd@vger.kernel.org, AJvYcCXZjtadbqs8bDQNcrkGcoquTrpu+wwG49i4p8kceBgEiy/iWZD07Dxr+Sa5Z5eJJ4DydMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1G25sSJcMVFYYxtGne7s6wHZjCdqYCNtiJGLSh3Sl6vzSyaR
	hG/b9Qqi7tJu3ISFnb42bahrVTpL42bNJJuRzIxyJaN9TRafDtkfovEs
X-Gm-Gg: ASbGnctEqe0kGWYaqG4GGvG16vqzxydu1UPWCwx8PcCkIPFpsqGmcxF8/wkR+2KIMzB
	rrPeRwCbRT5R2HYO7LZMhI7AXMvfkPUElMswrhlAN3C4m+xzOyZQS0R47lX4h8DxawoB6NoKq2a
	ZkAFRg/tzv6Hn5vYZgjGQ2wTr8sgUhmpIxU9LOpsNPi+pJtoC9+6Rek/yEciSvim94gDXCCUoiP
	03fELidsFJfV1XdBqBMci+56WnY32CRkhBDxTfSeHOmRQAgD7fX3PnrihY4esxkd98mnhxe50v5
	miVfzuUcChWOifH4Jxy6i6MWE4Z3Lzr2bG+idtxKOMBX/xm+Kz8hFfmyPFc4ocCfVcpcLvTKogi
	KIZ4M0uPUXg==
X-Google-Smtp-Source: AGHT+IGI00rWAIpdapWnzS7FmLmfeGVsnS2ofhLVeIpT53X8jpK9GRpsZjnZVCzgQWyXqOPVcNx2SQ==
X-Received: by 2002:a17:906:7952:b0:ad2:e08:e9e2 with SMTP id a640c23a62f3a-ae6fb90ca97mr410209066b.27.1752249082134;
        Fri, 11 Jul 2025 08:51:22 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294042sm313717766b.119.2025.07.11.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:51:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:51:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com, 
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v5 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <k45gwtae6yx3cjy5kprctlnw4wox5fnfd5yjlczgpyu2cw5bsj@dol2der4ykat>
References: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
 <20250709-netpoll_test-v5-3-b3737895affe@debian.org>
 <20250710184535.374a0643@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710184535.374a0643@kernel.org>

Hello Jakub,

On Thu, Jul 10, 2025 at 06:45:35PM -0700, Jakub Kicinski wrote:
> > +MAX_WRITES: int = 40
> 
> FWIW the test takes 25sec on our debug-heavy VMs right now.
> I think we can crank the writes quite a bit.. ?

Sure. I will increase it to 40. On my VMs I get more than 30 hits every
single time:

	2025-07-11 08:30:08,904 - DEBUG - BPFtrace output: {'hits': 30}
	2025-07-11 08:30:08,904 - DEBUG - MAPS coming from bpftrace = {'hits': 30}

> > +def ethtool_read_rx_tx_queue(interface_name: str) -> tuple[int, int]:
> > +    """
> > +    Read the number of RX and TX queues using ethtool. This will be used
> > +    to restore it after the test
> > +    """
> > +    rx_queue = 0
> > +    tx_queue = 0
> > +
> > +    try:
> > +        ethtool_result = ethtool(f"-g {interface_name}").stdout
> 
> json=True please and you'll get a dict, on CLI you can try:
> 
> ethtool --json -g eth0

Sure. I was parsing manually because some options do not have --json
format. 

	ethtool --json -l eth0
	ethtool: bad command line argument(s)

I haven't checked upstream, but, if this feature is upstream, is it worth
implementing it?

> > +        ethtool(f"-G {interface_name} rx {rx_val} tx {tx_val}")
> 
> This is setting _ring size_ not queue count.
> I suppose we want both, this and queue count to 1 (with ethtool -l / -L)
> The ring size of 1 is unlikely to work on real devices.
> I'd try setting it to 128 and 256 and if neither sticks just carry on
> with whatever was there.

Thanks. I creating a function to do it. Something as:

	def configure_network(ifname: str) -> None:
	"""Configure ring size and queue numbers"""

	# Set defined queues to 1 to force congestion
	prev_queues = ethtool_get_queues_cnt(ifname)
	logging.debug("RX/TX/combined queues: %s", prev_queues)
	# Only set the queues to 1 if they exists in the device. I.e, they are > 0
	ethtool_set_queues_cnt(ifname, tuple(1 if x > 0 else x for x in prev_queues))
	defer(ethtool_set_queues_cnt, ifname, prev_queues)

	# Try to set the ring size to some low value.
	# Do not fail if the hardware do not accepted desired values
	prev_ring_size = ethtool_get_ringsize(ifname)
	for size in [(1, 1), (128, 128), (256, 256)]:
		if ethtool_set_ringsize(ifname, size):
		# hardware accepted the desired ringsize
		logging.debug("Set RX/TX ringsize to: %s from %s", size, prev_ring_size)
		break
	defer(ethtool_set_ringsize, ifname, prev_ring_size)

> > +        "remote_ip": (
> > +            cfg.remote_addr_v["4"] if cfg.addr_ipver == "4" else cfg.remote_addr_v["6"]
> > +        ),
> 
> this is already done for you
> cfg.addr is either v4 or v6 depending on what was provided in the env

Ack!

> > +# toggle the interface up and down, to cause some congestion
> 
> Let's not do this, you're missing disruptive annotation and for many
> drivers NAPI is stopped before queues
> https://github.com/linux-netdev/nipa/wiki/Guidance-for-test-authors#ksft_disruptive

Sure. This is not needed to reproduce the issue.
I just put it in there in order to create more entropy. Anyway, removing
it.

> > +def main() -> None:
> > +    """Main function to run the test"""
> > +    netcons_load_module()
> > +    test_check_dependencies()
> > +    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:
> 
> I think nsim_test=True will make the test run _only_ on netdevsim.
> But there's nothing netdevsim specific here right?
> You can remove the argument and let's have this run against real
> drivers, too?

Sure. that is our goal, by the end of the day. Being able to run it on
real hardware.


Thanks of the review. I will send an updated version soon, and we can
continue the discusion over there.
--breno

