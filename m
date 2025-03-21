Return-Path: <linux-kselftest+bounces-29563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B0A6BD68
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 15:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00333B32A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9E21C9F0;
	Fri, 21 Mar 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="j53Ogs/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DB1D514B;
	Fri, 21 Mar 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568032; cv=none; b=MheTAQocF/zCgmGWIBsLWePFq8JdfeaoXJv7wi4Ht337lnG6+TbBVLYatwPwPokvU4Rne4Pe+2QLFPpR1YeeYzZR3YZxn2eWTSHFL1cSGVELSuW7hqu+TKn+v8WijAShtcGBzTC9dQfeIPa/o7ZQwVp1zy+tf7IARF0TB3Ts8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568032; c=relaxed/simple;
	bh=E2+FqgznUEnyWr4r8jGmtnjZVC3ujDGJrrzUcsUPLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdUCq0xBAn1JXam7xjkUm9ckWypN27/sO+QTAkzelvxn1neVBMKvwF85u5+l2m7cHAlgkcWNk6sboJA8KQd4/UrFmHoVYwvaoEARRWe/oCZoGdXhXQ8QQI1BCxR0qFfQuDJaN3Yaw7wh9vbNtC+E2AnZ8uQuPtDFnY/O0tEMrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=j53Ogs/H; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=273ZrHicthe524y60l8YzXOeWySzybOyGBG8piPpQfM=; b=j53Ogs/HYM8gv6m80/LKlzzCWv
	MiPX9TVIujy06m/jUc4kRBI7ZCTIUceHk9yMjF3Hp+no9GfrpbnFo0CEq2KEsqZNdFXSn5y+JFIvq
	/I/+Gx5cwLKNuryJ22XFwuTmOF+SuHJdvtgA3m9AmakvAxjlP3DC0/J5k0OMHEzJqQkkzAHWSIoU9
	1HUGg0gcgoQqWfz2L3zF5JMyb/iPV/o+4jLaGqr4j01cvf4GG0aoWIbRnwkkeW+VJVxMGM2R7a64N
	POFqrbfsNw5DZ0H38sqRzPt6AIFm3/+h1Xm8BB9yKOZIVJZe+56Ka9z3fud+2Kj2zXXS9cjfrMozZ
	kyd+MZZQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tvdXo-000000003pz-1Qsu;
	Fri, 21 Mar 2025 15:40:20 +0100
Date: Fri, 21 Mar 2025 15:40:20 +0100
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
Message-ID: <Z916VMSCEtinZl54@orbyte.nwl.cc>
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
 <Z91QshzKRlmPdpv7@orbyte.nwl.cc>
 <Z91fXURX3BQFDaq9@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z91fXURX3BQFDaq9@fedora>

On Fri, Mar 21, 2025 at 12:45:17PM +0000, Hangbin Liu wrote:
> On Fri, Mar 21, 2025 at 12:42:42PM +0100, Phil Sutter wrote:
> > Hi Hangbin,
> > 
> > On Fri, Mar 21, 2025 at 10:40:25AM +0000, Hangbin Liu wrote:
> > > Hi Jason, Phil,
> > > On Wed, Mar 19, 2025 at 05:15:41PM +0100, Jason A. Donenfeld wrote:
> > > > On Mon, Jan 06, 2025 at 08:10:43AM +0000, Hangbin Liu wrote:
> > > > > +	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
> > > > > +	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
> > > > > +	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
> > > > 
> > > > Can't these be statically linked into the nft binary?
> > > 
> > > If I omit these, I will got error like
> > > 
> > > mnl_attr_put: symbol not found
> > > 
> > > Even though I set `--enable-static` in nft build.
> > > 
> > > Do you know what's the reason?
> > 
> > I was able to have nft linked statically against built libmnl and
> > libnftnl by passing '--disable-shared --enable-static' to configure
> > calls of all three build systems. With --enable-shared in library
> > configure calls, nftables build preferred to link against the DSOs and I
> > did not find a way to change this.
> 
> The patch is using
> "./configure --prefix=/ $(CROSS_COMPILE_FLAG) --enable-static \
> --disable-shared --disable-debug --disable-man-doc --with-mini-gmp --without-cli"
> to build nft.

Do you pass that to the configure calls for libnftnl and libmnl, too? I
didn't find a way to force static linking in nftables build system, so I
disabled building of shared libmnl/libnftnl libraries.

Cheers, Phil

