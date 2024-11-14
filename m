Return-Path: <linux-kselftest+bounces-22031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49269C8DA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7960D285BE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D6127E18;
	Thu, 14 Nov 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtTJBBuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D22C859;
	Thu, 14 Nov 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597222; cv=none; b=YiQMput3EGd9F84IFvLshm7HFdqsBrFRn/wRsUu7ToBSGiDjLEGyjGcmiDSECWC+gKcDvwEzQnuPOiT8obOXkAzNnCppeVcpDHATJ+lZCJL68FpaLtu6yaaGYrbayVeLuXGkqdqSZSfLxM2hk5RPTkFgxQXKsYqAo0jARMIkync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597222; c=relaxed/simple;
	bh=aq7ZMKtF9p4l87Fei6eyuzzavvkC5xav+Z8nvF4e5Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZPZzjQaMFeRJy6NB6NHzFfx2MDyMI4T+w0NOFyg6GQGSq9ZS8pU5TUA6RX3po0jpkoLs7RI1u6iF51tj2VQq2Ia3avawERlMAYYQ976ZwrmH+L0qeGhL1JiTOalXdsiUQ0/MaiOl1rlwNn4djjSInG7kws/FfsXgHaiB3yP4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtTJBBuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE85C4CECD;
	Thu, 14 Nov 2024 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731597221;
	bh=aq7ZMKtF9p4l87Fei6eyuzzavvkC5xav+Z8nvF4e5Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtTJBBuUnMy09nCLrhSXD52HWurv/zcPe4lfVUIsDPeRG/wk7Jt2ep6e0t0+HfmtB
	 6auC5HZkXrFZBiS+pannNb1g21kRZBrHHY6ryKMsWwjHMzkxzZFIfo1+Eo+7uCEhh+
	 EwhCXR6redtLvByRC7y5j2hi0sMDxyBfbr4ff1WuCljuofZXTfGBbztYp9/oxMG4c0
	 w7KHXw3H7bUsbouYLUmp+OvRNr0yB+AO3up9MEwk1WH1B6/bjIQhnHODfh8PgpplF7
	 qy9OYz+tItaVTFA5TcviGBHe1IIAJpaRJ9b2f2PwO4hsgzvz46h4vhPkXrQm/uwxr8
	 sUH5DnBOlkcCA==
Date: Thu, 14 Nov 2024 07:13:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Sam Edwards <cfsworks@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <20241114071340.2b4929a4@kernel.org>
In-Reply-To: <ZzWyk9QHb9qseMYO@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
	<20241113125152.752778-3-liuhangbin@gmail.com>
	<20241113115612.1717575a@kernel.org>
	<ZzVZoe_N4_h4qWVP@fedora>
	<20241113184312.7a33a83d@kernel.org>
	<ZzWyk9QHb9qseMYO@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 08:19:31 +0000 Hangbin Liu wrote:
> > > Is this tested with patched kernel or unpatched kernel. On my local side I got
> > > 
> > > # ./rtnetlink.sh -t kci_test_mngtmpaddr
> > > PASS: mngtmpaddr add/remove correctly  
> > 
> > I believe you that you run the test before sending.
> > But if it doesn't pass in CI we can't merge this.
> > Just a shot in the dark but does it also pass without the -t ?  
> 
> Yes.
> # ./rtnetlink.sh
> PASS: policy routing
> ...
> PASS: enslave interface in a bond
> PASS: mngtmpaddr add/remove correctly
> 
> I will modify the test with Sam's suggestions and see if it could pass.

The other option is that some other test doesn't clean up after itself,
since we reuse VMs. We have a script in NIPA to map things:
contest/cithreadmap

Looks like we run rtnetlink.sh after pmtu.sh, I wonder if pmtu.sh is to
blame:

Thread3-VM0
	 4-pmtu-sh/
	 5-rtnetlink-sh/
	....


