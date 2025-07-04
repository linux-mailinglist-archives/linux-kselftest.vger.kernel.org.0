Return-Path: <linux-kselftest+bounces-36534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C49AF8EE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6187BF9B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24662EA468;
	Fri,  4 Jul 2025 09:37:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354328B419;
	Fri,  4 Jul 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621837; cv=none; b=VZal6XhFtPUg/yz3kS+G1jv/ANIHKvk6XYcQEIaVPbFCb2ETP1olsmeB3RDrVPhw1FShdzEqpCbQw/uzGctlHKhIgfH/01ewTIoX/JQ8xt1VauyfmC2CS2H8jqeywzMC3Mg54Z0sRvJ2TxAqIYyvA/LlEniRT3gqejwzgliDRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621837; c=relaxed/simple;
	bh=GVlXhsXjSY2FBO4LfCYBAGFTR7uHL9ktkhNg0wxfCNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIM4Ri4f9X5l15Y1SK0cyOsJbSM5PtVmZPsAP379fLbGzyznN7OMw2QOOlGLGBq6pzZV4V5fvC0lX2KxLOpYmJMRMbtbcNQ0f1B0e5W1+C4c4dOSrIW9V232Jc5mtlKMmTOLeCkL47fFICVUBb/t4gOTTdhVXq35ju5Ejb2z290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 41EF545343;
	Fri,  4 Jul 2025 11:37:12 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:37:10 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	nicolas.dichtel@6wind.com, pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH net-next v4] ipv6: add `force_forwarding` sysctl to
 enable per-interface forwarding
Message-ID: <4f6ti2orkpa2c5upawpaj63jyhdx3uxeobaxjhd2tjnuzgucqz@odfw5wacuwjt>
Mail-Followup-To: Kuniyuki Iwashima <kuniyu@google.com>, corbet@lwn.net, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, nicolas.dichtel@6wind.com, 
	pabeni@redhat.com, shuah@kernel.org
References: <20250703160154.560239-1-g.goller@proxmox.com>
 <20250704080101.1659504-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20250704080101.1659504-1-kuniyu@google.com>
User-Agent: NeoMutt/20241002-35-39f9a6

On 04.07.2025 08:00, Kuniyuki Iwashima wrote:
>From: Gabriel Goller <g.goller@proxmox.com>
>Date: Thu,  3 Jul 2025 18:01:53 +0200
>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>> index 0f1251cce314..ec7fa1e890f1 100644
>> --- a/Documentation/networking/ip-sysctl.rst
>> +++ b/Documentation/networking/ip-sysctl.rst
>> @@ -2292,6 +2292,11 @@ conf/all/forwarding - BOOLEAN
>>  proxy_ndp - BOOLEAN
>>  	Do proxy ndp.
>>
>> +force_forwarding - BOOLEAN
>> +	Enable forwarding on this interface only -- regardless of the setting on
>> +	``conf/all/forwarding``. When setting ``conf.all.forwarding`` to 0,
>> +	the ``force_forwarding`` flag will be reset on all interfaces.
>
>Please update conf/all/forwarding too as it will be stale after
>this patch.

I'll change the conf/all/forwarding section from:

	IPv4 and IPv6 work differently here; e.g. netfilter must be used
	to control which interfaces may forward packets and which not.

to:

	IPv4 and IPv6 work differently here; the ``force_forwarding`` flag must
	be used to control which interfaces may forward packets.

I hope that's all right.

>> +
>>  fwmark_reflect - BOOLEAN
>>  	Controls the fwmark of kernel-generated IPv6 reply packets that are not
>>  	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
>> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
>> index 5aeeed22f35b..5380107e466c 100644
>> --- a/include/linux/ipv6.h
>> +++ b/include/linux/ipv6.h
>> @@ -19,6 +19,7 @@ struct ipv6_devconf {
>>  	__s32		forwarding;
>>  	__s32		disable_policy;
>>  	__s32		proxy_ndp;
>> +	__s32		force_forwarding;
>
>nit: place force_forwarding just after forwarding.

Agree.

>>  	__cacheline_group_end(ipv6_devconf_read_txrx);
>>
>>  	__s32		accept_ra;
>> @@ -857,6 +859,15 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
>>  		idev = __in6_dev_get_rtnl_net(dev);
>>  		if (idev) {
>>  			int changed = (!idev->cnf.forwarding) ^ (!newf);
>> +			/*
>> +			 * With the introduction of force_forwarding, we need to be backwards
>> +			 * compatible, so that means we need to set the force_forwarding flag
>
>Strictly backward compatibility is not related I think because
>the per iface conf is disabled by default, and this is a new
>behaviour.  Maybe simply say
>
>/* Disabling all.forwarding sets 0 to force_forwarding for all interfaces */

Agree.

>> +			 * on every interface to 0 if net.ipv6.conf.all.forwarding is set to 0.
>> +			 * This allows the global forwarding flag to disable forwarding for
>> +			 * all interfaces.
>> +			 */
>> +			if (newf == 0)
>> +				WRITE_ONCE(idev->cnf.force_forwarding, newf);
>>
>>  			WRITE_ONCE(idev->cnf.forwarding, newf);
>>  			if (changed)
>> @@ -5719,6 +5730,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
>>  	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
>>  		READ_ONCE(cnf->accept_untracked_na);
>>  	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
>> +	array[DEVCONF_FORCE_FORWARDING] = READ_ONCE(cnf->force_forwarding);
>>  }
>>
>[...]
>>  static inline size_t inet6_ifla6_size(void)
>> @@ -6747,6 +6759,78 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>>  	return ret;
>>  }
>>
>> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
>> +{
>> +	ASSERT_RTNL();
>
>__in6_dev_get_rtnl_net() has the same check so this is not needed.

Agree.

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
>
>nit: Please keep the reverse xmas tree order.
>https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>
>> +	int new_val = *valp;
>> +	int old_val = *valp;
>> +	int ret;
>> +
>> +	struct ctl_table tmp_ctl = *ctl;
>
>same here.

Will do; moved this up.

>> +
>> +	tmp_ctl.extra1 = SYSCTL_ZERO;
>> +	tmp_ctl.extra2 = SYSCTL_ONE;
>
>As you are copying *ctl, please specify this in addrconf_sysctl[].

Umm how would I do that? Do you want me to add a comment explaining it?
I need extra1 and extra2 to be the network device so that I can set
NETCONFA_FORCE_FORWARDING but I also want to use proc_douintvec_minmax.

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
>> +	if (ret)
>> +		*ppos = pos;
>> +	return ret;
>> +}
>> +
>>  static int minus_one = -1;
>>  static const int two_five_five = 255;
>>  static u32 ioam6_if_id_max = U16_MAX;
>> @@ -7217,6 +7301,13 @@ static const struct ctl_table addrconf_sysctl[] = {
>>  		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= SYSCTL_TWO,
>>  	},
>> +	{
>> +		.procname	= "force_forwarding",
>> +		.data		= &ipv6_devconf.force_forwarding,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= addrconf_sysctl_force_forwarding,
>
>Here for extra{1,2}.

See above.

>> +	},
>>  };
>>  static int __addrconf_sysctl_register(struct net *net, char *dev_name,
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index 7bd29a9ff0db..440b9efced72 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -509,7 +509,8 @@ int ip6_forward(struct sk_buff *skb)
>>  	u32 mtu;
>>
>>  	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
>> -	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
>> +	if (idev && !READ_ONCE(idev->cnf.force_forwarding) &&
>> +	    !READ_ONCE(net->ipv6.devconf_all->forwarding))
>
>Now this ignores devconf_all when !idev whose dev was not
>found or has not had a valid mtu.
>
>if (!READ_ONCE(net->ipv6.devconf_all->forwarding) &&
>    (!idev || !READ_ONCE(idev->cnf.force_forwarding)))

Oof yeah, you're right this is my mistake. I'll use your solution.

Thanks for the review!


