Return-Path: <linux-kselftest+bounces-25480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1929A23A97
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 09:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF037A3EB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2E156F4A;
	Fri, 31 Jan 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE+y/FN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F42563;
	Fri, 31 Jan 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312236; cv=none; b=Jtzgiy+s4X/I1g5T3+1oEpnYeD+DXpKQUfGGeK7/f7smrBCNeIRAnt0SY3ZJgcBgGrpX8dnSP3qyKs+SWobfq+QmgbFOYFwKCi/08pZj6/YMVmxsAEvRI56JN/RqnJI5Jzk7Z8VgvFTgQKsJOycMxwGsjWTPupAhiMBEn21UVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312236; c=relaxed/simple;
	bh=AtfBBDRe/v3005YeMC67dhp3He0uuAnKjvaGt1r4Do4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIRAOb/5/jJuzcQMVym0kSE6lN7LPnaOWvpHUCrJQ5gFkiHjPQNm6YQIb4fsCSC6ls3wxZE+z965qlxWrOy0mZZHYFXvXCx4XeEOcPFxjphUFZiaEs2i4lHt9qjsrNDrg9FT3aSyXzu0JLxPsFitbHbj5qunq1v2ZJbtuG3LTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE+y/FN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6AFC4CED1;
	Fri, 31 Jan 2025 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738312235;
	bh=AtfBBDRe/v3005YeMC67dhp3He0uuAnKjvaGt1r4Do4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PE+y/FN4y0l9nZnq29GNlQLNlbXrGpThMRU6p3o2rAMkkdn34doJYFABmB3N/nn2W
	 IR8lItojDilpRouSjXW12hPTTaaHWdSVbR/mfXPSHQQW7C26ef/N3aoZInp1io6t12
	 NHgDMFmsioWh2b4iCaKlIt7LVs4rqCauAhvxjl+uFqk1rQ4rBleyOwNVDDtdCrjHoG
	 fquxgc2mcDnpsIOHma2QRoTszKRscKnU7XRSOfUxJvFCy3kfhv4rLSIqqPZ8gMsxkI
	 nwO7m70Z6AmMNTnLfdXbrUF3LQBVjiZBiq5v/e89Wa6LXItv+xeMBnwjpX8JbKCJtn
	 t4V9N6XJAXzjg==
Date: Fri, 31 Jan 2025 08:29:28 +0000
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 4/6] net: devmem: TCP tx netlink api
Message-ID: <20250131082928.GA24105@kernel.org>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-5-almasrymina@google.com>

On Thu, Jan 30, 2025 at 09:15:37PM +0000, Mina Almasry wrote:
> From: Stanislav Fomichev <sdf@fomichev.me>
> 
> Add bind-tx netlink call to attach dmabuf for TX; queue is not
> required, only ifindex and dmabuf fd for attachment.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Hi Mina,

I noticed minor issue relating to generated code.

...

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index cbb544bd6c84..93f4333e7bc6 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml

The lines preceding the hunk below are:

      name: napi-set
      doc: Set configurable NAPI instance settings.
      attribute-set: napi
      flags: [ admin-perm ]
      do:
        request:
          attributes:
            - id

> @@ -711,6 +711,18 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +    -
> +      name: bind-tx
> +      doc: Bind dmabuf to netdev for TX
> +      attribute-set: dmabuf

Unlike the entry for napi-set there is no "flags: [ admin-perm ]" fpr
bind-tx...

> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - fd
> +        reply:
> +          attributes:
> +            - id
>  
>  kernel-family:
>    headers: [ "linux/list.h"]

...

> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c

...

> @@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {

The lines preceding this hunk are:

	{
		.cmd		= NETDEV_CMD_NAPI_SET,
		.doit		= netdev_nl_napi_set_doit,
		.policy		= netdev_napi_set_nl_policy,

>  		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= NETDEV_CMD_BIND_TX,
> +		.doit		= netdev_nl_bind_tx_doit,
> +		.policy		= netdev_bind_tx_nl_policy,
> +		.maxattr	= NETDEV_A_DMABUF_FD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,

... so I don't think GENL_ADMIN_PERM should be here.

Flagged by running tools/net/ynl/ynl-regen.sh -f && git diff

> +	},
>  };
>  
>  static const struct genl_multicast_group netdev_nl_mcgrps[] = {

...

