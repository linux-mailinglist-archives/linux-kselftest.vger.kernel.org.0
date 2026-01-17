Return-Path: <linux-kselftest+bounces-49240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49CD39007
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A1EA30161C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91D286419;
	Sat, 17 Jan 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekUoehTX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417D238D52;
	Sat, 17 Jan 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768670549; cv=none; b=ncl4+Qx7o5bT0qYX94+eiUbmInb6sxvbazdmPbXVRjpEPI/LBez5B9wOaPM12nA0BZn/Azq/aljgvRSfwdFN+5I2pwb7FI3C1n1tvsncOI9YdSKf/0iGqvooKoFJe+wQXKRBJyQV8xJUUozIYtzNhiDlb3sVNYf2DEVW+IJzRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768670549; c=relaxed/simple;
	bh=9ZeRVW8KCB8TM7Iuo/p0JiFXSnPhVwkmX25hYakKBYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRJyd7v9Bh8Rc4lPP11gBO0+3euENTwxcD0ISX8wU4+engoeqULbSLFF2MTIVWkCpel7QFg5GLG8hCWT+fUYhPNkwqgrbx5Dk4PRVW2gaX5djbPJWVani1J1YsX/H0+65HFeyU1N0Bb7PhVm7IhEYtPlTiLv8duwq4ZBmuNkRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekUoehTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2CCC4CEF7;
	Sat, 17 Jan 2026 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768670548;
	bh=9ZeRVW8KCB8TM7Iuo/p0JiFXSnPhVwkmX25hYakKBYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekUoehTXqlaObA+qq5388GDt9GyOU0+SXm9/bVK9lHUUBpDr1sYpmBEohXclMyfxl
	 Hz0F7+8lRi0O+DixktJcKgSe3yd4e7NvCwig0/t8F9tjg6AcUm38LhGcncTl21uwda
	 07mL5yYjMwkd62Re4TGJlkxXu0NiRMGVCCcAHgy+HSMK7ADzumkxQGSHVtX7uVfR7u
	 xvyutFHH49k8c2wGjg1OFS+N3WLgDc5OA/o5QzEhsff9d2YpIdteKruaALPuz7/IZt
	 LcBMTXOknH0jFu8GRzxvnKPvor/fxoYhMsVsqX7VSc9r9s2J0Og6ZlcyAHTWxXIGFf
	 cKYGyVqKxK6VA==
Date: Sat, 17 Jan 2026 09:22:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <20260117092227.741cba3b@kernel.org>
In-Reply-To: <aWqkhT_-4UoNHX6F@archlinux>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
	<20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
	<20260112061642.7092437c@kernel.org>
	<aWqkhT_-4UoNHX6F@archlinux>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 21:01:22 +0000 Andre Carvalho wrote:
> On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> > On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:  
> > > Introduce a new netconsole selftest to validate that netconsole is able
> > > to resume a deactivated target when the low level interface comes back.
> > > 
> > > The test setups the network using netdevsim, creates a netconsole target
> > > and then remove/add netdevsim in order to bring the same interfaces
> > > back. Afterwards, the test validates that the target works as expected.
> > > 
> > > Targets are created via cmdline parameters to the module to ensure that
> > > we are able to resume targets that were bound by mac and interface name.  
> > 
> > The new test seems to be failing in netdev CI:
> > 
> > TAP version 13
> > 1..1
> > # timeout set to 180
> > # selftests: drivers/net: netcons_resume.sh
> > # Running with bind mode: ifname
> > not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> > -- 
> > pw-bot: cr  
> 
> I've finally been able to reproduce this locally. The issue is caused by the
> fact that the test currently expects that mac addresses for netdevsim devices are
> deterministic. This is the case on my setup as systemd enforces it (MACAddressPolicy=persistent).

Argh, systemd strikes again :(

> I was able to disable this behaviour by setting up /etc/systemd/network/50-netdevsim.link, with:
> 
> [Match]
> Driver=netdevsim
> 
> [Link]
> MACAddressPolicy=none
> 
> I'm assuming this is also the behaviour on CI hosts. 

Yes, systemd changing the MAC address is racy - it does it too slowly
and some tests start doing their thing, then systemd comes in and flips
the address. So indeed:

# cat /etc/systemd/network/99-default.link
[Match]
OriginalName=*

[Link]
NamePolicy=keep kernel database onboard slot path
AlternativeNamesPolicy=database onboard slot path mac
MACAddressPolicy=none

> I have started working on a fix
> for this test and will submit v11 once that is ready. The approach I'm taking is saving and
> restoring the mac addresses once I reload netdevsim module. Example code below (needs more testing):
> 
> function deactivate() {
> 	# Start by storing mac addresses so we can be restored in reactivate
> 	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
> 		cat /sys/class/net/"$DSTIF"/address)
> 	SAVED_SRCMAC=$(mac_get "${SRCIF}")
> 	# Remove low level module
> 	rmmod netdevsim
> }
> 
> function reactivate() {
> 	# Add back low level module
> 	modprobe netdevsim
> 	# Recreate namespace and two interfaces
> 	set_network
> 	# Restore MACs
> 	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
> 		address "${SAVED_DSTMAC}"
> 	if [ "${BINDMODE}" == "mac" ]; then
> 		ip link set dev "${SRCIF}" down
> 		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
> 		# Rename device in order to trigger target resume, as initial
> 		# when device was recreated it didnt have correct mac address.
> 		ip link set dev "${SRCIF}" name "${TARGET}"
> 	fi
> }
> 
> The main annoyance is that to test resuming when a device was bound by mac I actually need
> to change the name of the device after restoring the mac address (since when the device 
> is registered after deactivation the mac won't match).

Workaround sounds reasonable, FWIW.

