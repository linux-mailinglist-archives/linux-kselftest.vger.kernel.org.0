Return-Path: <linux-kselftest+bounces-22274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3DF9D285E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178CAB2B4D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E01CCEFC;
	Tue, 19 Nov 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="ea30Z+f/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AAE57D;
	Tue, 19 Nov 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027051; cv=none; b=APrUCw4EHSzk4/kmt84HN89uFew9hYNUvwzUptTitE3kjrRG58PM5YYdWYPwsVpqqO3DszWFIj9+YZzo0hvvdcn91ym/mHS+fQyHTYE5VlSkYlEhIJvBxu3RoluY/3xfyBkwHrRE8Q/EzkhkTk68GaYCbtnYQ3BAcBPGtQIUW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027051; c=relaxed/simple;
	bh=eFlAIRQOqdtMQ86+sZD38hKpZm2bIwb7xLJUaTtTn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAUbqmZ3isnkpgvLC6TxlwG19janbkfwjbYYroygG0YNQbGpWO4ma/1zWkHYdLFtNQq6JjpiJixApGxdmxzLB3nt2Tio7ITHj6O3x8tbWi89Z6NjUegT4lTfwj4pUrnxCaZ2Y7JjYk9AGLw8emP+nI54o2QHNTzZJTAJvp9V2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=ea30Z+f/; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D9+QT/PGS7TNywt2V5GvWPp0z/RDdp7emmM5ESDUzdg=; b=ea30Z+f/yyDdDbUYNySDZ+u9gt
	DhDZP1ZwNTOKp91YVMeM06M7lliHi/hSiMDLj7Qykf7LjXucE+eNwapyPxHDsuHeQq+FIxX1ieh2S
	oynuuq7thdxh9lFkFu4d2vtwoA4oFahrr2I6cAnXDAXjPcVdCF8RkU2bUREDWqInwtx7wqAQv17kh
	EiPO5N+YwVK4Caso1gJKQ27e1OZWw9Q0HBQ6H888jT8ZLV5FbuPFq+8ZpKfMVX9Uw9e7E+OmbMciF
	NeQPyGzAjj0Hbi4V82PH4nNUqQyrGRNI5BuC9jd2XpD0TQj31dUril7ZmGu8e0ThNX4r46IHeL7lk
	JBHC8CYw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tDPM3-000000002ZO-15PU;
	Tue, 19 Nov 2024 15:37:23 +0100
Date: Tue, 19 Nov 2024 15:37:23 +0100
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] selftests: wireguards: use nft by default
Message-ID: <Zzyio98xh1GN08wN@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111041902.25814-1-liuhangbin@gmail.com>
 <ZzpNXM17NX3nVzMl@zx2c4.com>
 <Zzw8rb202R6FWVHs@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzw8rb202R6FWVHs@fedora>

Hangbin,

On Tue, Nov 19, 2024 at 07:22:21AM +0000, Hangbin Liu wrote:
> On Sun, Nov 17, 2024 at 09:09:00PM +0100, Jason A. Donenfeld wrote:
> > On Mon, Nov 11, 2024 at 04:19:02AM +0000, Hangbin Liu wrote:
> > > Use nft by default if it's supported, as nft is the replacement for iptables,
> > > which is used by default in some releases. Additionally, iptables is dropped
> > > in some releases.
> >  
> > Rather than having this optionality, I'd rather just do everything in
> > one way or the other. So if you're adamant that we need to use nft, just
> > convert the whole thing. And then subsequently, make sure that the qemu
> > test harness supports it. That should probably be a series.
> 
> Hmm, try build nft but got error
> 
> # make -C tools/testing/selftests/wireguard/qemu/
> make: Entering directory '/home/net/tools/testing/selftests/wireguard/qemu'
> Building for x86_64-linux-musl using x86_64-redhat-linux
> cd /home/net/tools/testing/selftests/wireguard/qemu/build/x86_64/nftables-1.0.9 && ./configure --prefix=/ --build=x86_64-redhat-linux --host=x86_64-linux-musl --enable-static --disable-shared
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> ...
> checking for pkg-config... /usr/bin/pkg-config
> configure: WARNING: using cross tools not prefixed with host triplet
> checking pkg-config is at least version 0.9.0... yes
> checking for libmnl >= 1.0.4... yes
> checking for libnftnl >= 1.2.6... yes
> checking for __gmpz_init in -lgmp... no
> configure: error: No suitable version of libgmp found

You may find proper details about the failure in config.log. My guess is
the cross build prevents host libraries from being used. (No idea why
your manual call works, though.)

> But I can config it manually like: ./configure --prefix=/ --build=x86_64-redhat-linux --host=x86_64-linux-musl --enable-static
> --disable-shared correctly
> 
> Do you have any idea?

You may just pass '--with-mini-gmp' to nftables' configure call to avoid
the external dependency.

Cheers, Phil

