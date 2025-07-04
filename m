Return-Path: <linux-kselftest+bounces-36510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF7AF8B18
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3771CA495E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D91328006;
	Fri,  4 Jul 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3dV36Wk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF474327FFF
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616065; cv=none; b=PPyoGczXjeaTDuARv+0XrqJe3IDRk9jB4Ogx2EGG9+K2gA1qad6veSc9GJH4Q4g1oW7cHDc3ndOIrMzZLCdHv8hLjV+03+aSduy5Kd3NMzf2bGx0Q7F5e0YAA5uHAMm8juomHMchvUbRDq4y1v/5rAtuFZ10HJCKg5XzhUcE17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616065; c=relaxed/simple;
	bh=MavaVcHmHUBcxDXmoAet1o0TO4NeLL674Tn4+KgFr+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVAN37PhKsij7hiTmJKywaHKCYcckGLtDswD4R19hF5ANYWqyzj31xzUqbwc3+P043A4UvXZZfGMJjHuuleqVz8wW74R88mzErwcnZJSFQgq2CqxUGZoQYRLhtlJArSzSGHWuXZJik6f1OM6oBfjH51ilG8niweHdwfuY4yibVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3dV36Wk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso1662543a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751616063; x=1752220863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=871LHtfICsP4HWPXTfpyFCO/uBx5NLX+MNBP0IGi11Y=;
        b=h3dV36WkhJfg7IVGJ5cfIPLI+/dPu6GI998mcsmiWCv6YfuAraP5F3otm1dyYoFYST
         S4+eQOc5as/fzHVL4FoXp95BBu/8nTeEeo2xQwuXJa57PippiJxpKeYfp9kx3x205lto
         FmsmrQpip2vrUAe6sbcK3s6yJU4r9W1947KKaHKavt2TiBIQwh1W6g67SBR9NEsA/brM
         42Gp/p8UhpVQX2dEO7bL9ubp5nCrgnZ7jZ0wIReztGeTEuH+XL63NK4Wg1gEAC0BaDBi
         sNdmp5GH3OoERCDHx/f4DQvox29fdQ9xTNtcoxveymbo3pUVPrgFvFwspa4r2ub8QkVg
         2x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616063; x=1752220863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=871LHtfICsP4HWPXTfpyFCO/uBx5NLX+MNBP0IGi11Y=;
        b=Iw77BQAoJvhPXq0D/rdOOtv0KZKXZq/CpjWfqkYqZVoNnwCY9VRbo+1R1f8R3r/p6b
         vIwXIzsgTNZ3K2q0yhUH3ZGfKmPy9E0lYttYI9hQlLk4D8oZ8Y/ql64Nr9rIrtEW3BKf
         P0av3p9L+E4c9c610By/SGKJAZUKhxmApe6ErlHf+I0BCzs+2cHDdZJ686DpNR0C0B5v
         ZCHG2urrm+gkJg6OPZ2R+BAi4OySxflDhijmaCygbiGcDM52ibxg6rOz9hcVaNXIBY0o
         DWRpBGQUhPSWxXs8RiyuW1giG+rHDbofHnboM/G6LZQ2rlbrkNUpKjxrZ19DEu4wNP/f
         cqSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNVq44JMA9lAoSQatrTCFjnAdTFDgFe860ORLj5K+S4VVqgJOXkwzjuRd6fzH9w4AciJOkLdFUp4tz/E/J6/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNtVwCOs4beweWxFOqDckHLNgaQJnu498JBTEtNaSLm+cDaL0
	wY0XXj9MIwhcOawN5jzKJJUUd1EuPOykwDjBq7D+Jd/wWnOhqwHwBsZbpkfG58WJfTwCy3/tjYi
	i24UEJw==
X-Google-Smtp-Source: AGHT+IGhHuyYYc0DPphHjWVDjLD2G9Tn2pqlyBgLZRGhRjNxi9Z5rH9gHqa6RoAdRw1mJnzsBrDScqF3UVg=
X-Received: from pjqq14.prod.google.com ([2002:a17:90b:584e:b0:311:ea2a:3919])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e44:b0:314:2cd2:595d
 with SMTP id 98e67ed59e1d1-31aab856b9bmr3131512a91.8.1751616063071; Fri, 04
 Jul 2025 01:01:03 -0700 (PDT)
Date: Fri,  4 Jul 2025 08:00:02 +0000
In-Reply-To: <20250703160154.560239-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703160154.560239-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704080101.1659504-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v4] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
From: Kuniyuki Iwashima <kuniyu@google.com>
To: g.goller@proxmox.com
Cc: corbet@lwn.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	nicolas.dichtel@6wind.com, pabeni@redhat.com, shuah@kernel.org, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Gabriel Goller <g.goller@proxmox.com>
Date: Thu,  3 Jul 2025 18:01:53 +0200
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 0f1251cce314..ec7fa1e890f1 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2292,6 +2292,11 @@ conf/all/forwarding - BOOLEAN
>  proxy_ndp - BOOLEAN
>  	Do proxy ndp.
>  
> +force_forwarding - BOOLEAN
> +	Enable forwarding on this interface only -- regardless of the setting on
> +	``conf/all/forwarding``. When setting ``conf.all.forwarding`` to 0,
> +	the ``force_forwarding`` flag will be reset on all interfaces.

Please update conf/all/forwarding too as it will be stale after
this patch.


> +
>  fwmark_reflect - BOOLEAN
>  	Controls the fwmark of kernel-generated IPv6 reply packets that are not
>  	associated with a socket for example, TCP RSTs or ICMPv6 echo replies).
> diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
> index 5aeeed22f35b..5380107e466c 100644
> --- a/include/linux/ipv6.h
> +++ b/include/linux/ipv6.h
> @@ -19,6 +19,7 @@ struct ipv6_devconf {
>  	__s32		forwarding;
>  	__s32		disable_policy;
>  	__s32		proxy_ndp;
> +	__s32		force_forwarding;

nit: place force_forwarding just after forwarding.


>  	__cacheline_group_end(ipv6_devconf_read_txrx);
>  
>  	__s32		accept_ra;
> @@ -857,6 +859,15 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
>  		idev = __in6_dev_get_rtnl_net(dev);
>  		if (idev) {
>  			int changed = (!idev->cnf.forwarding) ^ (!newf);
> +			/*
> +			 * With the introduction of force_forwarding, we need to be backwards
> +			 * compatible, so that means we need to set the force_forwarding flag

Strictly backward compatibility is not related I think because
the per iface conf is disabled by default, and this is a new
behaviour.  Maybe simply say

/* Disabling all.forwarding sets 0 to force_forwarding for all interfaces */

> +			 * on every interface to 0 if net.ipv6.conf.all.forwarding is set to 0.
> +			 * This allows the global forwarding flag to disable forwarding for
> +			 * all interfaces.
> +			 */
> +			if (newf == 0)
> +				WRITE_ONCE(idev->cnf.force_forwarding, newf);
>  
>  			WRITE_ONCE(idev->cnf.forwarding, newf);
>  			if (changed)
> @@ -5719,6 +5730,7 @@ static void ipv6_store_devconf(const struct ipv6_devconf *cnf,
>  	array[DEVCONF_ACCEPT_UNTRACKED_NA] =
>  		READ_ONCE(cnf->accept_untracked_na);
>  	array[DEVCONF_ACCEPT_RA_MIN_LFT] = READ_ONCE(cnf->accept_ra_min_lft);
> +	array[DEVCONF_FORCE_FORWARDING] = READ_ONCE(cnf->force_forwarding);
>  }
>  
[...]
>  static inline size_t inet6_ifla6_size(void)
> @@ -6747,6 +6759,78 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
>  	return ret;
>  }
>  
> +static void addrconf_force_forward_change(struct net *net, __s32 newf)
> +{
> +	ASSERT_RTNL();

__in6_dev_get_rtnl_net() has the same check so this is not needed.


> +	struct net_device *dev;
> +	struct inet6_dev *idev;
> +
> +	for_each_netdev(net, dev) {
> +		idev = __in6_dev_get_rtnl_net(dev);
> +		if (idev) {
> +			int changed = (!idev->cnf.force_forwarding) ^ (!newf);
> +
> +			WRITE_ONCE(idev->cnf.force_forwarding, newf);
> +			if (changed) {
> +				inet6_netconf_notify_devconf(dev_net(dev), RTM_NEWNETCONF,
> +							     NETCONFA_FORCE_FORWARDING,
> +							     dev->ifindex, &idev->cnf);
> +			}
> +		}
> +	}
> +}
> +
> +static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
> +					    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct inet6_dev *idev = ctl->extra1;
> +	struct net *net = ctl->extra2;
> +	int *valp = ctl->data;
> +	loff_t pos = *ppos;

nit: Please keep the reverse xmas tree order.
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

> +	int new_val = *valp;
> +	int old_val = *valp;
> +	int ret;
> +
> +	struct ctl_table tmp_ctl = *ctl;

same here.

> +
> +	tmp_ctl.extra1 = SYSCTL_ZERO;
> +	tmp_ctl.extra2 = SYSCTL_ONE;

As you are copying *ctl, please specify this in addrconf_sysctl[].


> +	tmp_ctl.data = &new_val;
> +
> +	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
> +
> +	if (write && old_val != new_val) {
> +		if (!rtnl_net_trylock(net))
> +			return restart_syscall();
> +
> +		if (valp == &net->ipv6.devconf_dflt->force_forwarding) {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_DEFAULT,
> +						     net->ipv6.devconf_dflt);
> +		} else if (valp == &net->ipv6.devconf_all->force_forwarding) {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_ALL,
> +						     net->ipv6.devconf_all);
> +
> +			addrconf_force_forward_change(net, new_val);
> +		} else {
> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     idev->dev->ifindex,
> +						     &idev->cnf);
> +		}
> +		rtnl_net_unlock(net);
> +	}
> +
> +	if (write)
> +		WRITE_ONCE(*valp, new_val);
> +	if (ret)
> +		*ppos = pos;
> +	return ret;
> +}
> +
>  static int minus_one = -1;
>  static const int two_five_five = 255;
>  static u32 ioam6_if_id_max = U16_MAX;
> @@ -7217,6 +7301,13 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> +	{
> +		.procname	= "force_forwarding",
> +		.data		= &ipv6_devconf.force_forwarding,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= addrconf_sysctl_force_forwarding,

Here for extra{1,2}.


> +	},
>  };
>  
>  static int __addrconf_sysctl_register(struct net *net, char *dev_name,
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 7bd29a9ff0db..440b9efced72 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -509,7 +509,8 @@ int ip6_forward(struct sk_buff *skb)
>  	u32 mtu;
>  
>  	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
> -	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
> +	if (idev && !READ_ONCE(idev->cnf.force_forwarding) &&
> +	    !READ_ONCE(net->ipv6.devconf_all->forwarding))

Now this ignores devconf_all when !idev whose dev was not
found or has not had a valid mtu.

if (!READ_ONCE(net->ipv6.devconf_all->forwarding) &&
    (!idev || !READ_ONCE(idev->cnf.force_forwarding)))

