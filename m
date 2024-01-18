Return-Path: <linux-kselftest+bounces-3213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BC831E37
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C61C22B98
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DA2C6BB;
	Thu, 18 Jan 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpJ1rKat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25B2C6AA;
	Thu, 18 Jan 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598009; cv=none; b=GoMyrZN01LDsSnF8+iNv91sNzNsecm8kKeec+UH3jMx3Q8CE3PkcyFHdhMnbdaEdbtOWDwJhyJyVXgvGiQcxrxxU8elRzaSc7tIe5ewQeLgA1Q2TVUjw/6HVDh8MzbYkObPLghrlDoHxd6d95MU0oiC8lEQcrHhe+z19cNQNqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598009; c=relaxed/simple;
	bh=9o2lBDYb6ONkZXbvFSTfGbBBwuoSI9hZAcZPwVUMhj8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=AkfwyZJBv++k4SdoEReaE9BSNZBHLEy87L6gi8mmaAvRCgoIzKJiMy6gpJQcktFqozgMCFMqrDRrKCU8UwF5pU6tU2VBh/LkxBEHRK1ojSz11iPg5W9XUMFkrb/d5UKDuydJQKpcTVu1+om43wQ67gdpjfKF3oCO3PN+1B3+Bhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpJ1rKat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12C4C433C7;
	Thu, 18 Jan 2024 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598009;
	bh=9o2lBDYb6ONkZXbvFSTfGbBBwuoSI9hZAcZPwVUMhj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpJ1rKat2pQCVwGvZ/btu/r8GZ0oaiCCoUGQFc+7uD9oWlqNj0OMpHuBLkZsthefT
	 uwAe7UjQKBcLP7T1amEiQOtOdSQCcR+0pxc/OnE/PBGgnFmzi85rcFC/dnxEZwGkrn
	 B3irrORZ+7yhoye7DAkaBEGHMMGqXjQi2XlWhPDSUw8drcHNRlhtBHe9SdH07hwApP
	 W6uHEAEV5bvPsbwefMSgzsLjrwtWcHokvyxxisz9HwOOGugbV4DvCboutAniNKYNXr
	 QX5dncX8aOcwa7YhyLon+WGK64SIhvS9fgSxc5EHtfqiyJBhh6mEqC0rSuImqXNxk+
	 VHH7SLk8X9OxA==
Date: Thu, 18 Jan 2024 09:13:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Mohammad Nassiri
 <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Message-ID: <20240118091327.173f3cb0@kernel.org>
In-Reply-To: <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
	<20240118085129.6313054b@kernel.org>
	<358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 17:04:25 +0000 Dmitry Safonov wrote:
> > Somewhat unrelated to these fixes but related to the tcp_ao selftests
> > in general - could you please also add a config file so that it's
> > easy to build a minimal kernel for running the tests?
> > 
> > Something like:
> > 
> >   make defconfig
> >   make kvm_guest.config
> >   make tools/testing/selftests/net/tcp_ao/config  
> 
> Yep, sounds good to me.
> I'll take as a base tools/testing/selftests/net/config and add any
> needed config options on the top.

You probably want something smaller to be honest.
tools/testing/selftests/net/config has a lot of stuff in it 
and it's actually missing a lot more. I'm working thru adding
the missing options to tools/testing/selftests/net/config 
right now so far I got:

# tun / tap
+CONFIG_TUN=y
+CONFIG_MACVLAN=y
+CONFIG_MACVTAP=y
+CONFIG_NET_SCH_FQ_CODEL=m
+# l2tp
+CONFIG_L2TP=m
+CONFIG_L2TP_V3=y
+CONFIG_L2TP_IP=m
+CONFIG_L2TP_ETH=m
+# sctp-vrf (need SCTP_DIAG to appear)
+CONFIG_INET_DIAG=y
+# txtimestamp
+CONFIG_NET_CLS_U32=m
+# test-vxlan-mdb-sh etc.
+CONFIG_BRIDGE_VLAN_FILTERING=y
+# gre_gso.sh etc.
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_IP_GRE=m
+CONFIG_IPV6_GRE=m
+# ./srv6_end_dt*_l3vpn_test.sh
+CONFIG_IPV6_SEG6_LWTUNNEL=y
+# local port something..
+CONFIG_MPTCP=y
+# fib_test.sh
+CONFIG_NET_CLS_BASIC=m

