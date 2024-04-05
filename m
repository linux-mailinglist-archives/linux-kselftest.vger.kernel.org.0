Return-Path: <linux-kselftest+bounces-7240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC68992F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 03:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750291C21317
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1468C13D;
	Fri,  5 Apr 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqdRmaSX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CF1C02;
	Fri,  5 Apr 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712282326; cv=none; b=gUWI8K2DBbK9dBvAnzSxdnGXGXwqK3GK0gh5S2wI0lxQ8UmsPxKARVg+bFIEiZjRPXkwOc867ejSIDOhVsZH60P+SfvXsYN2cKFAuTAjspp9h4vHXmeksc6KZOOkBvjqM4C4eCWQNotY828tkexff17QmuaJUN5AcjZrKcRkOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712282326; c=relaxed/simple;
	bh=G2BSx76EhmeknzsYLYGm9uUqS2jps2xIR7gwh3ktd9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT5VGZklxHrTWe4ANzXfmp6ohYWN1yisq0DqqzB+/aRT41XmHrM7RZAXjBicvuCRSIK9XNnvbwCc4ybxySRewCSyGsrP8cdiZJzCzfGR4gwwLvB1F9MnYNITl/j4Gwn/fZabApAvIyp20uZHuLKeiDMQb+u0EFXBXycojcPYht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqdRmaSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C825C433F1;
	Fri,  5 Apr 2024 01:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712282326;
	bh=G2BSx76EhmeknzsYLYGm9uUqS2jps2xIR7gwh3ktd9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqdRmaSX4RAXO7BrhELtwCKBBeVqq3zFd6Yj+dDEKSlRNsJwu7/F3K2LswsslKuWM
	 a61kc1Ms3O0wB56WEUD3rGE2nn/OeJ6syCTpwGLY/4T43pbi6N93c8Upkh+BYT/shP
	 UiQLztBECXcvxd1q4o+ArDX+VIx5Odg7oW59EiF9OX7gWKvXNOCOMebkg3bJBQNO9Y
	 kTNG0kfAbbvBS+1djtO1yo/IbBT4Mtc/RhQ1PWZ00ZyCy1J2YqZqoT/yN87yRnAO6h
	 3s0vhxfmeIFAiqSmu1234pX7xS4dS0vKgj7oOlMlxXAeqTbAA8kJEwbULlN1f66ne1
	 BNdMuUNkp7EbQ==
Date: Thu, 4 Apr 2024 18:58:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/7] selftests: drivers: add scaffolding for
 Netlink tests in Python
Message-ID: <20240404185844.0ddb8632@kernel.org>
In-Reply-To: <87zfu9fk2v.fsf@nvidia.com>
References: <20240403023426.1762996-1-kuba@kernel.org>
	<20240403023426.1762996-7-kuba@kernel.org>
	<87zfu9fk2v.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 12:42:24 +0200 Petr Machata wrote:
> > +    def __init__(self, nsimdev, port_index, ifname, ns=None):
> > +        # In case udev renamed the netdev to according to new schema,
> > +        # check if the name matches the port_index.
> > +        nsimnamere = re.compile(r"eni\d+np(\d+)")
> > +        match = nsimnamere.match(ifname)
> > +        if match and int(match.groups()[0]) != port_index + 1:
> > +            raise Exception("netdevice name mismatches the expected one")
> > +
> > +        self.ifname = ifname
> > +        self.nsimdev = nsimdev
> > +        self.port_index = port_index
> > +        self.ns = ns
> > +        self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
> > +        ret = ip("-j link show dev %s" % ifname, ns=ns)
> > +        self.dev = json.loads(ret.stdout)[0]  
> 
> I don't think self.ifname, .ns, .dfs_dir, .dev are actually used outside
> of this function.

Right, one of the "further down the line" tests need these.
I'll remove for now.

> > +    def dfs_write(self, path, val):
> > +        self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
> > +
> > +
> > +class NetdevSimDev:
> > +    """
> > +    Class for netdevsim bus device and its attributes.
> > +    """
> > +    @staticmethod
> > +    def ctrl_write(path, val):
> > +        fullpath = os.path.join("/sys/bus/netdevsim/", path)
> > +        with open(fullpath, "w") as f:
> > +            f.write(val)
> > +
> > +    def dfs_write(self, path, val):
> > +        fullpath = os.path.join(f"/sys/kernel/debug/netdevsim/netdevsim{self.addr}/", path)
> > +        with open(fullpath, "w") as f:
> > +            f.write(val)
> > +
> > +    def __init__(self, port_count=1, ns=None):
> > +        # nsim will spawn in init_net, we'll set to actual ns once we switch it the.sre  
> 
> the.sre?

Ha, must have started typing with focus on the wrong window.
Good it wasn't my password :D

