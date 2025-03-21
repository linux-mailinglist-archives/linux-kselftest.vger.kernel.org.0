Return-Path: <linux-kselftest+bounces-29553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F771A6BA19
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FEA160CEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23BC224B0B;
	Fri, 21 Mar 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Fp6eyCEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE2D2253EA;
	Fri, 21 Mar 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557370; cv=none; b=CGTx4HbevyH55y0QdxRQ6Saxq5mwGW7vM/9OnnCdXhZnov4pJrYFy4F+HMO3sZxak75uRY6uTsp7/xeeh8OH+wIUovSyX2ICdra/Zr0kKt/WbZvAVgoWUx8NWOPkxBbpb5GQ27hOvfwCxLx1t/21MWg5dKRN1m90Wr8st+UY73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557370; c=relaxed/simple;
	bh=FL7z4Ub9L6PGWrEEBQ4gbd4eCJTb6x5v6pCL30EeyoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiULCpHWdY0iY6GRcXy5+a5aphAqpcpLVjjUGqXtyaGptT2Dsiy84ylYQeRupdigvFZD8Z4auIHpL4DQh2UGgWfIJn9OzMDFtsdx/e+3ieV5geoa5ZCI3BHcTBHT3n1FND0RlxFPYh4TVKg0zVDPSRHow1N8sDVI5r35EUkfHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Fp6eyCEn; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SUatzUQOETLhyGOv5BeLJaiThxY9I/fVLvbux0oPWl4=; b=Fp6eyCEn+kDEMEmPcxnB+sYMTk
	GvmbJdhOOPpfrsHFIDcPJcNOwBj04mwOH13z2F7r06DT+NYoDV+e+2024/qY9cX/XkQzj/oXit1NU
	8B9LMAd67NghAhQ8AwWojqsRKNXJQLiBE2lJ7lI4oreusm0e+akEp7fh7A6agov+192p051BMckMg
	kGsnJf5YE8W1Sk2VSs8QmInKyKKXtUcEWZ35CpfswcHdfB4PlbzMoq6IuH/gfZHB5Hg8Jizr1Cli/
	6m2gY2UEOjjwUWbAo8aIXSrg05K+PgIDspLu8mHU3eks1XvDjk+joBTMzWOO01KF3s0dmRi6E7YAs
	DafGgLdQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tvalu-000000001kr-4BEA;
	Fri, 21 Mar 2025 12:42:43 +0100
Date: Fri, 21 Mar 2025 12:42:42 +0100
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z91QshzKRlmPdpv7@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <20250106081043.2073169-3-liuhangbin@gmail.com>
 <Z9rtrVk-15Ts_BNp@zx2c4.com>
 <Z91CGRP9QLdZONiZ@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z91CGRP9QLdZONiZ@fedora>

Hi Hangbin,

On Fri, Mar 21, 2025 at 10:40:25AM +0000, Hangbin Liu wrote:
> Hi Jason, Phil,
> On Wed, Mar 19, 2025 at 05:15:41PM +0100, Jason A. Donenfeld wrote:
> > On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> > > +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> > > +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> > > +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
> > 
> > Can't these be statically linked into the nft binary?
> 
> If I omit these, I will got error like
> 
> mnl_attr_put: symbol not found
> 
> Even though I set `--enable-static` in nft build.
> 
> Do you know what's the reason?

I was able to have nft linked statically against built libmnl and
libnftnl by passing '--disable-shared --enable-static' to configure
calls of all three build systems. With --enable-shared in library
configure calls, nftables build preferred to link against the DSOs and I
did not find a way to change this.

Cheers, Phil

