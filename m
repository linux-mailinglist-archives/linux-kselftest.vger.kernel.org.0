Return-Path: <linux-kselftest+bounces-36535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A91AF8EFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9923F7B7FB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FE2EA17F;
	Fri,  4 Jul 2025 09:41:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18902DAFA8;
	Fri,  4 Jul 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622082; cv=none; b=h/CQXorHW4c6hVG5KwTLIQ9ZVihAUyosBDA0SagG6sD221QnUvXffJuMwLSTf+iSNrkBPER+fJ09rBHOFRgDVyg9V8z50OEmiykzae1ZExMQ672xmFVomEUWXk9WRPdcoBF9kN2Ybg67NSKSWYxgIsGt4G9ds9u+QMz1k32scUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622082; c=relaxed/simple;
	bh=5kfD3eLWhydpapTP/xx9CKZcEgNscuE+DHWcliVdzt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbhNuFFdQuXEnQ4qV1svW8E0cHOTAZWiIe+4aY6zB5DJ8vSbaMqeS3Ks4KXN3KUPRUpoymAp5nBhP3DgAhhEOE/RK4Gj3DGDPDkcXJUqsms+Np+wtLhh0VjXk3dyysUahKhQiOn2cDXhEam+fi2/4n+KaGqmTEnTl7pzKR3EFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CE1D546D0D;
	Fri,  4 Jul 2025 11:41:17 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:41:16 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4] ipv6: add `force_forwarding` sysctl to
 enable per-interface forwarding
Message-ID: <pwrkjcem57hgbg7ptfbqofr42kqgfyac5eprptn2uw3e5tdfge@4rip2rl2my6b>
Mail-Followup-To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
References: <20250703160154.560239-1-g.goller@proxmox.com>
 <d90c29af-d614-43ea-8bcd-f2c8ced779df@6wind.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d90c29af-d614-43ea-8bcd-f2c8ced779df@6wind.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 04.07.2025 10:07, Nicolas Dichtel wrote:
>Le 03/07/2025 à 18:01, Gabriel Goller a écrit :
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
>> ---
>>
>
>[snip]
>
>> @@ -6747,6 +6759,78 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>>  	return ret;
>>  }
>>
>> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
>> +{
>> +	ASSERT_RTNL();
>> +	struct net_device *dev;
>> +	struct inet6_dev *idev;
>> +
>
>ASSERT_RTNL() is always put after variables declaration.

I removed ASSERT_RTNL completely, this is already checked by __in6_dev_get_rtnl_net.

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
>> +		}
>> +	}
>> +}
>> +
>> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
>> +					    void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	struct inet6_dev *idev = ctl->extra1;
>> +	struct net *net = ctl->extra2;
>> +	int *valp = ctl->data;
>> +	loff_t pos = *ppos;
>> +	int new_val = *valp;
>> +	int old_val = *valp;
>> +	int ret;
>> +
>> +	struct ctl_table tmp_ctl = *ctl;
>This declaration should be put with other declarations.

Agree.

>> +
>> +	tmp_ctl.extra1 = SYSCTL_ZERO;
>> +	tmp_ctl.extra2 = SYSCTL_ONE;
>> +	tmp_ctl.data = &new_val;
>> +
>> +	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
>> +
>> +	if (write && old_val != new_val) {
>> +		if (!rtnl_net_trylock(net))
>> +			return restart_syscall();
>> +
>> +		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     NETCONFA_IFINDEX_DEFAULT,
>> +						     net->ipv6.devconf_dflt);
>> +		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     NETCONFA_IFINDEX_ALL,
>> +						     net->ipv6.devconf_all);
>> +
>> +			addrconf_force_forward_change(net, new_val);
>> +		} else {
>> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>> +						     NETCONFA_FORCE_FORWARDING,
>> +						     idev->dev->ifindex,
>> +						     &idev->cnf);
>> +		}
>> +		rtnl_net_unlock(net);
>> +	}
>> +
>> +	if (write)
>> +		WRITE_ONCE(*valp, new_val);
>Why not putting this in the above block?
>And maybe under the rtnl_lock to avoid race if two users change the value at the
>same time.

Yep, you're right.

>Nicolas

Thanks for the review!


