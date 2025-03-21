Return-Path: <linux-kselftest+bounces-29560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08761A6BB23
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E364E3AFE72
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3649229B28;
	Fri, 21 Mar 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SfQ4S5k0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325A226D04;
	Fri, 21 Mar 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561469; cv=none; b=crmXpWI7DbFkIMK5iGUAisds312iYRi5VElz9/fQvVnvhtM+yQ4QwInSPaNxVqMJBbhCxGCa5ip6ygzECAnLLeCFnDC7Z8/CY+Ivs+RaGBAY0uNU4nr/QHhXP883dZr0oPD49LLgtDuFvb5Qu4qmAB8RSPloksV+nFhy9XrrhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561469; c=relaxed/simple;
	bh=frb61xLTauRJ1oYAsBn7KGB1v01AGxe7+8/rQqlvlJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkS+0dxAv9bggULVrH/I+VvxYHauZFYwA2WXfbHpcOwAC0/TD1cJ99n0d8gyjEBxOtT/lQ5n6Xor3Dh9Dk1CkLgqmmokAjXDFAekQ+Kty04fJp3yk/mFsZRMGCBRdEFXCbY/ArxK9dUg9NK7HxnsMCAIskk7a2WFz3qApr0to1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=SfQ4S5k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DDAC4CEE3;
	Fri, 21 Mar 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SfQ4S5k0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742561466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dUf+NuD25WdVcY/g4ihIatL9n9p+d1MPap8zY1l6+Y=;
	b=SfQ4S5k0pTvKrxFXVspBerla/SbUp0Opfi1U//bwYh9m4JHnvyn19VfONZNdUhstjg+pCk
	zg1c+e0ozExXfzaWwUGKFmjtnLhvIiLoFhAPuffwWmgYwiRkQbcVkRsehvpqwa9xn16W7I
	ZSnCZbZpUksmk6EnYC1HPvZ+Gfcqo5Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f1bf067 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Mar 2025 12:51:05 +0000 (UTC)
Date: Fri, 21 Mar 2025 13:51:02 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 2/2] selftests: wireguard: update to
 using nft for qemu test
Message-ID: <Z91gtk_5nA76iYGw@zx2c4.com>
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
Content-Type: text/plain; charset=utf-8
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
> 
> I don't know why it's not linked static.

All three DSOs...

