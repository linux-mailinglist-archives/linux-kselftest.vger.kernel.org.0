Return-Path: <linux-kselftest+bounces-28326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A89A50704
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EA43A7A5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E5252905;
	Wed,  5 Mar 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLjGYBKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E2250C1D;
	Wed,  5 Mar 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197131; cv=none; b=NpCjVVyeUYnUDYkmERiSlUXfb+liuwQ6KG667tWMNWAkqF+FNgMEmNazKNfXoq7G27ZZ1UuEQDXGKE5z+5T4OD+SI8gFo/bsf8Qy77z6DLnSq8bM5zOAwN26EdMPhGT1sjPsrq4Vg0ADKBeApRWRw5lOiKcz6aAKY0jpQHJCOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197131; c=relaxed/simple;
	bh=+fO6QHFZK3v34T0UbQQG+Rs4wUa/4vaaUqJFHDD+cJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM1XHSDxgcH+fmdWiSp7gbMvWK2e5lnyDfD4DEuOwC83YBroPveYDiBFQ8Pb+JnjKzDzpZCx4l+A0EQzFBFYAvsF6AD1NhsRX6L/f8Zqz9dLwV9/kbUCrbpbG+Mv1ZmwRRwlAXP5pHOB3RQqaz3Rlo8chqck2fa49zD2PRgHPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLjGYBKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60757C4CEEA;
	Wed,  5 Mar 2025 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741197130;
	bh=+fO6QHFZK3v34T0UbQQG+Rs4wUa/4vaaUqJFHDD+cJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLjGYBKb2Crad0G/NITWxBaBxqZgqDl+WHtPV/INm9ZGzYEuYRxMovqxsAw8g9F7n
	 6GKC/zA3gIBNEe3IQbEIX2voyimvey/XiDv9YyHcfniDhPi/FtDpb3ckaaSo42teoO
	 gYN6zX8dZV+z9eCW50WR45oIzlMXO5CT+FQBwNCYKERCp694nN62/2glkpvvAMxuaj
	 RGGx3yukJw17Ry7zuiXdoE721k8i4Uc812+jnw16YiKYjQ6U1haNvUewQLZMYfHrBd
	 MCWnPFT80c+anlS38oocNHqYco2JryFGb/mlHMl+dQktVXF12U7BUndPiZiRE20Eii
	 HUn/+p3uqdIEw==
Date: Wed, 5 Mar 2025 17:52:04 +0000
From: Simon Horman <horms@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v7 3/6] tun: Introduce virtio-net hash feature
Message-ID: <20250305175204.GP3666230@kernel.org>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
 <20250228-rss-v7-3-844205cbbdd6@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-rss-v7-3-844205cbbdd6@daynix.com>

On Fri, Feb 28, 2025 at 04:58:49PM +0900, Akihiko Odaki wrote:
> Hash reporting
> --------------
> 
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> RSS
> ---

Odaki-san,

Please reformat the patch description to avoid including "^---$".
Git will truncate the commit message at that point,
excluding the text below and your Signed-off-by line.

> 
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
> 
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

This one is ok, as the commit message should end here.

>  Documentation/networking/tuntap.rst |   7 ++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tap.c                   |  62 ++++++++++++-
>  drivers/net/tun.c                   |  89 ++++++++++++++----
>  drivers/net/tun_vnet.h              | 180 +++++++++++++++++++++++++++++++++---
>  include/linux/if_tap.h              |   2 +
>  include/linux/skbuff.h              |   3 +
>  include/uapi/linux/if_tun.h         |  75 +++++++++++++++
>  net/core/skbuff.c                   |   4 +
>  9 files changed, 390 insertions(+), 33 deletions(-)

...

