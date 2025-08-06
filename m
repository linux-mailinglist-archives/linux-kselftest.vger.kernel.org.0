Return-Path: <linux-kselftest+bounces-38417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96186B1CC56
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC39556182C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397E2BCF41;
	Wed,  6 Aug 2025 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJObUTcV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE13C01;
	Wed,  6 Aug 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507568; cv=none; b=kZBxGPj3TCGXw4mCHd2DYWU1oSXSYyGIBmHHrYBuvcjgdXQ2a6Jxjxu1wxGWh7tmKSYe8QL33mM/LjgfX1hpKn5y9B6RoL4AU7W5oQvm4H/tmK2rHNOmV1O2AnUZF5PoswbhyZqN7d4IvMAia3xvk3gAMrjNrsFUF5lnsoyLk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507568; c=relaxed/simple;
	bh=63oiH47TpNrKg8vSfBfA+XroUg56FkruM6tDGJa3KA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLeiyRdACzJQVEAwQWLPbDaNJ8g2ZJ29FYdiYZ3+Vqle9Yg9DIWUKijo/mCEhjNIMrm1RYHDj3DFAInyxErmf0Mk2IKfWgAZ/n/r1u++mvLwA+Z6eApgTE+9L9kewli93C6G2HX0kowCdZDyuFXS6k6vkuSeW76ZHzTRnsoU5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJObUTcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5A1C4CEE7;
	Wed,  6 Aug 2025 19:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754507567;
	bh=63oiH47TpNrKg8vSfBfA+XroUg56FkruM6tDGJa3KA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJObUTcVdLBwCfMCLh2osZjFACQQgVCUtz8cfWIdVaclvA1ChLJlI9I8vLt7nk+92
	 +WnsMFK5jMNiaUR8sOLGK2iCANup7cRV2gNXt1l9xCJK6Z4eBGmLzgViZG+kKpo9DE
	 +qtgcGKOs2+HY+OFmuRdJlhFLw3bFAwnKQJDpFREvCy3afbps3P758/e2njEwy9T+t
	 aIWldOBR/yr52doaCpEpmrBI73snnic5aE/MjnhDCoRZsUL7BMw0Vqn20e/ogLmWIt
	 E6PDxPBGCqt665IGD99LE5MhtXkuLMk5dMA4Ohxcv8ArnvMTs3uY9+gJgnrq6Fveny
	 bD9Gv+dSD6h/g==
Date: Wed, 6 Aug 2025 20:12:39 +0100
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 09/12] vsock/loopback: add netns support
Message-ID: <20250806191239.GF61519@horms.kernel.org>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>

On Tue, Aug 05, 2025 at 02:49:17PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add NS support to vsock loopback. Sockets in a global mode netns
> communicate with each other, regardless of namespace. Sockets in a local
> mode netns may only communicate with other sockets within the same
> namespace.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...

> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c

...

> @@ -46,7 +57,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
>  	return 0;
>  }
>  
> -static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
> +static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);

This change needs to be squashed into
PATCH 3/12 vsock: add netns to af_vsock core

To avoid build breakage.

Likewise with the other change to vsock_loopback_seqpacket_allow below.
And I think also for a number of other changes made by PATCH 3/12.

Please make sure that patches don't introduce transient build failures.
It breaks bisection.


On the topic of vsock_loopback_seqpacket_allow, also:

* Please line wrap this so that the code is 80 columns wide or less,
  as is still preferred for Networking code.

  Flagged by checkpatch.pl --max-line-length=80

* Can we move the definition of vsock_loopback_seqpacket_allow() here?
  The function itself is is trivial. And doing so would avoid a forward
  declaration.

>  static bool vsock_loopback_msgzerocopy_allow(void)
>  {
>  	return true;

...

> +int vsock_loopback_init_net(struct net *net)
> +{
> +	net->vsock.loopback = kmalloc(GFP_KERNEL, sizeof(struct vsock_loopback));
> +	if (!net->vsock.loopback)
> +		return -ENOMEM;
> +
> +	return vsock_loopback_init_vsock(net->vsock.loopback);
> +}
> +
> +void vsock_loopback_exit_net(struct net *net)
> +{
> +	vsock_loopback_deinit_vsock(net->vsock.loopback);
> +	kfree(net->vsock.loopback);
> +}

I think EXPORT_SYMBOL_GPL is needed for both vsock_loopback_exit_net and
vsock_loopback_init_net for the case where CONFIG_VSOCKETS=m

Also, in Kconfig VSOCKETS_LOOPBACK depends on VSOCKETS. But this code adds
a reverse dependency. As it stands it's possible to configure VSOCKETS
without VSOCKETS_LOOPBACK, which will not compile.

Perhaps stub implementations of vsock_loopback_init_net and
vsock_loopback_exit_net should be implemented in af_vsock.h if
VSOCKETS_LOOPBACK is not enabled?

...

-- 
pw-bot: changes-requested

