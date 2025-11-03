Return-Path: <linux-kselftest+bounces-44648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD9C2C34B
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F055B4F8D54
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C732FF66A;
	Mon,  3 Nov 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H3R8xKzP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F126C3BE;
	Mon,  3 Nov 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176972; cv=none; b=tkv51i8ulP1tG5suBwHZ5kQhCN7tasqBDafolNmpIiD+ZFo6luNSJkLFJYaIsS3q24cuhK2PEoDr1SZRO1pRM6sxljj0pABbHSJy/Cg7C8XXm2qn+yT2IiaO4AiEoP20L/qAD1Dmy9X5BP9+3MleB7rIWj/TViv5saJOUwVBlvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176972; c=relaxed/simple;
	bh=hh4fQWQud1e+BB+JyZ3vB+KHwKuyZC0k6VLYceJN+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/yj7j4+75NdEBoubTH8EefFqfDTlSbd96i62H3ToYaa5MQ/VLN229ln2wr5R9yjt9c5/1SOAEChqblFR24gbn3oikGJBHr6nykxeOUlRvI1XV6P7nIMIbdV9nu158A6eWoubNMveOlQarJA9tw3b4DwmumoHFm90BmQhNJrnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H3R8xKzP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zh9B4vB/7KSaXnJ8zZXyTQPM87A3PE1sYsd73K993Ks=; b=H3R8xKzPPH2KeZx3glli8KbhWw
	Heg3m3N4/sh1hsd1oLCxREijpiXDcQ/Ljbk2XeUpI8QyYpOXQCy/skmsqxExZMLopP9CFbB+zmPol
	Cxls+aFokjr0r5mH3DgLqzEaGuKnT0PbFIZAAPD6g2yPhYU1wJLpm86nYCDbXoeQADM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFuj2-00Cmdm-Gw; Mon, 03 Nov 2025 14:36:00 +0100
Date: Mon, 3 Nov 2025 14:36:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Wang Liang <wangliang74@huawei.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <e014c4c5-105a-43cb-9411-ec139af2b2a1@lunn.ch>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <20251030170217.43e544ad@kernel.org>
 <aQiANPQU9ZEa0zCo@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiANPQU9ZEa0zCo@krikkit>

On Mon, Nov 03, 2025 at 11:13:08AM +0100, Sabrina Dubroca wrote:
> 2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> > On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:
> > > >  set -o pipefail
> > > >  
> > > > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then  
> > > 
> > > I guess it's improving the situation, but I've got a system with an
> > > ethtool that accepts the --json argument, but silently ignores it for
> > >  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > > output), which will still cause the test to fail later.
> > 
> > And --json was added to -k in Jan 2022, that's pretty long ago.
> > I'm not sure we need this aspect of the patch at all..
> 
> Ok.  Then maybe a silly idea: for the tests that currently have some
> form of "$TOOL is too old" check, do we want to remove those after a
> while? If so, how long after the feature was introduced in $TOOL?

Another option is to turn them into a hard fail, after X years. My
guess is, tests which get skipped because the test tools are too old
frequently get ignored. Tests which fail are more likely to be looked
at, and the tools updated.

Another idea is have a dedicated test which simply tests the versions
of all the tools. And it should only pass if the installed tools are
sufficiently new that all test can pass. If you have tools which are
in the grey zone between too old to cause skips, but not old enough to
cause fails, you then just have one failing test you need to turn a
blind eye to.

	Andrew

