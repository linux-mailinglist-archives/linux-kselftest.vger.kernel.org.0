Return-Path: <linux-kselftest+bounces-37098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E0B01C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765873BADD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32F296178;
	Fri, 11 Jul 2025 12:29:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803167464;
	Fri, 11 Jul 2025 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236970; cv=none; b=u893Xzlt8SaXZRUo1lErhssURXtRX8ce/wfx1d6s4MCeIDtalh3eZ3PLLEH6RnJkKCbPRTI24UAFgFDdcTQlV7w/wY4m8zO9XlzGCKxKenNkdr5Vh3VNlK1ZVIwlTv2CKZ30OmYr6hJLFtEBlyU5Aqy47W4k047gV/lsHEnAHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236970; c=relaxed/simple;
	bh=fIitV8uS/kxmTYFxFGDGgZ/5RFXqlgUXQMoiW7LTyAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T249YAtxky5i8M8yt9bJLYuTGfuJBv6T3BO4RCCELLBjHbcL3IlKglFApPvhBE3e7xhEUnOM/D4+OvXxawfrSF/s3nReE9qX3mGSV5t6OCEvjdSeyJxR3jl1adD+3Q9J6RoTxCMzXT4uvExsODQGTEdMU4EfugIUAzD3vuGthwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 910D2472EB;
	Fri, 11 Jul 2025 14:29:17 +0200 (CEST)
Date: Fri, 11 Jul 2025 14:29:16 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5] ipv6: add `force_forwarding` sysctl to
 enable per-interface forwarding
Message-ID: <mo6dtede26twve7umo6tu6q3tajxetc2nxgy3et5mhdoxfuwxe@br4vg5h73k5k>
Mail-Followup-To: Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250707094307.223975-1-g.goller@proxmox.com>
 <858eb643-bf0a-480e-b7f7-103b7bd94707@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <858eb643-bf0a-480e-b7f7-103b7bd94707@redhat.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 10.07.2025 15:26, Paolo Abeni wrote:
>On 7/7/25 11:43 AM, Gabriel Goller wrote:
>> It is currently impossible to enable ipv6 forwarding on a per-interface
>> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
>> enable it on all interfaces and disable it on the other interfaces using
>> a netfilter rule. This is especially cumbersome if you have lots of
>> interface and only want to enable forwarding on a few. According to the
>> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
>> for all interfaces, while the interface-specific
>> `net.ipv6.conf.<interface>.forwarding` configures the interface
>> Host/Router configuration.
>>
>> Introduce a new sysctl flag `force_forwarding`, which can be set on every
>> interface. The ip6_forwarding function will then check if the global
>> forwarding flag OR the force_forwarding flag is active and forward the
>> packet.
>>
>> To preserver backwards-compatibility reset the flag (on all interfaces)
>> to 0 if the net.ipv6.conf.all.forwarding flag is set to 0.
>>
>> Add a short selftest that checks if a packet gets forwarded with and
>> without `force_forwarding`.
>>
>> [0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>>
>> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
>
>Does not apply cleanly anymore, please rebase and repost.
>
>Also a few nits below...

Will do.

>> @@ -857,6 +859,9 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
>>  		idev = __in6_dev_get_rtnl_net(dev);
>>  		if (idev) {
>>  			int changed = (!idev->cnf.forwarding) ^ (!newf);
>> +			/* Disabling all.forwarding sets 0 to force_forwarding for all interfaces */
>> +			if (newf == 0)
>> +				WRITE_ONCE(idev->cnf.force_forwarding, newf);
>
>You could use:
>
>			WRITE_ONCE(idev->cnf.force_forwarding, 0);
>				

Agree, thanks!

>>
>>  			WRITE_ONCE(idev->cnf.forwarding, newf);
>>  			if (changed)
>> @@ -5719,6 +5724,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
>>  	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
>>  		READ_ONCE(cnf->accept_untracked_na);
>>  	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
>> +	array[DEVCONF_FORCE_FORWARDING] = READ_ONCE(cnf->force_forwarding);
>>  }
>>
>>  static inline size_t inet6_ifla6_size(void)
>> @@ -6747,6 +6753,76 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>>  	return ret;
>>  }
>>
>> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
>> +{
>> +	struct net_device *dev;
>> +	struct inet6_dev *idev;
>> +
>> +	for_each_netdev(net, dev) {
>> +		idev = __in6_dev_get_rtnl_net(dev);
>> +		if (idev) {
>> +			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
>> +
>> +			WRITE_ONCE(idev->cnf.force_forwarding, newf);
>> +			if (changed) {
>> +				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
>> +							     NETCONFA_FORCE_FORWARDING,
>> +							     dev->ifindex, &idev->cnf);
>> +			}
>
>Brakets not needed for the above statement. Either drop them or move the
>WRITE_ONCE() inside the if ()

Agree, thanks!

>> diff --git a/tools/testing/selftests/net/ipv6_force_forwarding.sh b/tools/testing/selftests/net/ipv6_force_forwarding.sh
>> new file mode 100644
>> index 000000000000..62adc9d4afc9
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/ipv6_force_forwarding.sh
>> @@ -0,0 +1,105 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Test IPv6 force_forwarding interface property
>> +#
>> +# This test verifies that the force_forwarding property works correctly:
>> +# - When global forwarding is disabled, packets are not forwarded normally
>> +# - When force_forwarding is enabled on an interface, packets are forwarded
>> +#   regardless of the global forwarding setting
>> +
>> +source lib.sh
>> +
>> +cleanup() {
>> +    cleanup_ns $ns1 $ns2 $ns3
>> +}
>> +
>> +trap cleanup EXIT
>> +
>> +setup_test() {
>> +    # Create three namespaces: sender, router, receiver
>> +    setup_ns ns1 ns2 ns3
>> +
>> +    # Create veth pairs: ns1 <-> ns2 <-> ns3
>> +    ip link add name veth12 type veth peer name veth21
>> +    ip link add name veth23 type veth peer name veth32
>> +
>> +    # Move interfaces to namespaces
>> +    ip link set veth12 netns $ns1
>> +    ip link set veth21 netns $ns2
>> +    ip link set veth23 netns $ns2
>> +    ip link set veth32 netns $ns3
>> +
>> +    # Configure interfaces
>> +    ip -n $ns1 addr add 2001:db8:1::1/64 dev veth12
>> +    ip -n $ns2 addr add 2001:db8:1::2/64 dev veth21
>> +    ip -n $ns2 addr add 2001:db8:2::1/64 dev veth23
>> +    ip -n $ns3 addr add 2001:db8:2::2/64 dev veth32
>
>The above will trigger DaD...
>
>> +
>> [snip[
>> +    # Test 2: With force_forwarding enabled, ping should succeed
>> +    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth21.force_forwarding=1
>> +    ip netns exec $ns2 sysctl -qw net.ipv6.conf.veth23.force_forwarding=1
>> +
>> +    if ip netns exec $ns1 ping -6 -c 1 -W 2 2001:db8:2::2 &>/dev/null; then
>> +        echo "PASS: force_forwarding enabled forwarding"
>
>... I'm wondering if it could sometimes race with the ping and cause
>sporadic failures? Possible using 'nodad' option for address creation
>could help.

Good catch!
I'll add `nodad` to the addresses.

>/P

Thanks for the review!

I'll send a v6 soon!


