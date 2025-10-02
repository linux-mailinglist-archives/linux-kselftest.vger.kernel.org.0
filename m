Return-Path: <linux-kselftest+bounces-42684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED48BB4FBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 21:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB5B4247B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 19:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EE8283128;
	Thu,  2 Oct 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Zqt9h4U2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F42741BC;
	Thu,  2 Oct 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433053; cv=none; b=AWQd/+3bwH3t2qLflGV06OZsRtDrqr93DjYo4eBKM8ZAX1Cqv35cNQbvy4SSRxs3ZbENZIALruVxy+flezVkmjwskbrzDRChMzhzSPbOOw0eAyr3bxh19IWMvcpoFpJRAcXy99Wbc2NdOfB2XbDpH7oHviyM73gLR5h6E8SIZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433053; c=relaxed/simple;
	bh=qAdp32i582ExBrsWXpfpit6C88dqWGnBtUXQoqBtx2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9H+TPy/Q65SpD1I2bzGI77ULvGRWhhrg1ofN0Ut5/zIcuQAz1Ew66ointd0QkMmwENkHQr4Ol7WUjolBELAKduuTg9sUYLK+2InVokcOoAu0fJRp7eUKVgZG08Kn6Ql5ZqZp1ul7+DOdUMnRN997oHH/2ulfhDTy1TusOXjPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Zqt9h4U2; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dWwMMcLkwkyvrz6dAbQjbLSghWCEq8qJYvwgikKkCVY=; b=Zqt9h4U22O0t8XLEOWioKT2XvF
	Eo1FAd3MgRlVIk6bFn6UYsjPb3RvDGEVL7H8lmCpgCGFYOOVPWLryLlYLB6UEG3xDBg5QYdzlxhLv
	0gDuiXfbCv1LGB6U4dirIhxafXhGFOHYMyVVZOpVR7IWNSZWbfwQ4WP/IxNOyZOpUt4WCRgsliI0q
	Psk2JUBDR0PfH1KVoVnEF11PNjUYQrxob/i6R2kktZRZXHGTrAAroBJUS6/SVLq3ZTc6nwNCfjYOf
	gL/XFcPE4NOdqnSc1ZkOPMYj5VwNoVqfrBZyB7faXq3PIvr4J9KYLQRTOrRevOCwioTTTzwREynEj
	wLCWy5CQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1v4OuD-0000000044w-2tE2;
	Thu, 02 Oct 2025 21:23:57 +0200
Date: Thu, 2 Oct 2025 21:23:57 +0200
From: Phil Sutter <phil@nwl.cc>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, jv@jvosburgh.net, olteanv@gmail.com,
	jiri@resnulli.us, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, kuniyu@google.com,
	matttbe@kernel.org, martineau@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, antonio@openvpn.net,
	allison.henderson@oracle.com, petrm@nvidia.com, razor@blackwall.org,
	idosch@nvidia.com, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net] selftests: net: unify the Makefile formats
Message-ID: <aN7RTSbXDA32J8D2@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	jv@jvosburgh.net, olteanv@gmail.com, jiri@resnulli.us,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, kuniyu@google.com, matttbe@kernel.org,
	martineau@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, antonio@openvpn.net, allison.henderson@oracle.com,
	petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20251002013034.3176961-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002013034.3176961-1-kuba@kernel.org>

Hi Jakub,

On Wed, Oct 01, 2025 at 06:30:33PM -0700, Jakub Kicinski wrote:
> We get a significant number of conflicts between net and net-next
> because of selftests Makefile changes. People tend to append new
> test cases at the end of the Makefile when there's no clear sort
> order. Sort all networking selftests Makefiles, use the following
> format:
> 
>  VAR_NAME := \
> 	 entry1 \
> 	 entry2 \
> 	 entry3 \
>  # end of VAR_NAME

A potential problem with this format is loss of context with long lists.
While I don't think it will cause incorrect conflict resolutions,
appending via '+=' may ease reviews of patches:

VAR_NAME :=
VAR_NAME += entry1
VAR_NAME += entry2
VAR_NAME += entry3

No trailing comment needed this way. Downside is '?=' can't be used.

> Some Makefiles are already pretty close to this.

Which is a point to stick with it.

[...]
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> index 07b7c46d3311..daf51113c827 100644
> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> -TEST_PROGS = devlink.sh \
> +TEST_PROGS := \

Maybe irrelevant, but assignment type changes should be avoided IMO
(there are more cases like this one).

> +	devlink.sh \
>  	devlink_in_netns.sh \
>  	devlink_trap.sh \
>  	ethtool-coalesce.sh \
> @@ -17,5 +18,6 @@ TEST_PROGS = devlink.sh \
>  	psample.sh \
>  	tc-mq-visibility.sh \
>  	udp_tunnel_nic.sh \
> +# end of TEST_PROGS
>  
>  include ../../../lib.mk

[...]
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> index 7ec7cd3ab2cc..868ece3fea1f 100644
> --- a/tools/testing/selftests/drivers/net/virtio_net/Makefile
> +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
> @@ -1,15 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> -TEST_PROGS = basic_features.sh \
> -        #
> +TEST_PROGS = basic_features.sh
> 
> -TEST_FILES = \
> -        virtio_net_common.sh \
> -        #
> +TEST_FILES = virtio_net_common.sh

These seem intentional, so change to the syntax as proposed?

[...]
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index 88c4bc461459..ce795bc0a1af 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -5,12 +5,16 @@ CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
>  # Additional include paths needed by kselftest.h
>  CFLAGS += -I../../
>  
> -TEST_FILES := ../../../../../Documentation/netlink/specs
> -TEST_FILES += ../../../../net/ynl
> +TEST_FILES := \
> +	../../../../net/ynl \
> +	../../../../../Documentation/netlink/specs \
> +# end of TEST_FILES
>  
> -TEST_GEN_FILES += csum
> -TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
> -TEST_GEN_FILES += xdp_helper
> +TEST_GEN_FILES := \
> +	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
> +	csum \
> +	xdp_helper \
> +# end of TEST_GEN_FILES

This one is interesting, the old code appended only, new code might
overwrite existing content.

Cheers, Phil

