Return-Path: <linux-kselftest+bounces-41739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC5B80F3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6341C241C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6034BA48;
	Wed, 17 Sep 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWb2Nks2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258B34BA34;
	Wed, 17 Sep 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125976; cv=none; b=q6pKgZBz68605YXVQDVFRzOtS55izyh+MIHfEd2Hxb92GVWD6QLy2Zm8/ymFPqAjQE9b73LYYglMnBtdCxTV9r60IdGb2faDTEdsB+q99B7CvpjQLnpB/0+JZMqo68VVT7Sv2n19FCg34SlY96vHAh4FQi4iaegcdXmsb6ktdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125976; c=relaxed/simple;
	bh=KfbeK80H5Y9LffAIOXluY2vfgoEGJRjwY72RgtAxAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqtd0DEEblA3uJZdnBynI0BbWsHjJM3m1DvxM0QcrvXBV1t1+QXG/841LqhQUCfbn5WFC8jNeATenFzwoFztvymhSQsUoqpoasJUDxAagel1nAZRsq+rH38zgW1xWg5A8cdrPttt1zKRjrA/h4qMpUkUI4w821vAKyCyHj32KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWb2Nks2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F40C4CEE7;
	Wed, 17 Sep 2025 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125975;
	bh=KfbeK80H5Y9LffAIOXluY2vfgoEGJRjwY72RgtAxAT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWb2Nks2coYtIafEU2uyaJpd1scrX/JVLeYBEygX6FHTySf5AH9stfpZ00LqGyCgi
	 KmcoccWAGSZj7Kkan+ohlqjUFYSv5fI78MujSSd/JuIYas8CudQoj6gtYLa9CsGvTr
	 JFhKZAwSeqd1Wh79kHmyB2JplqxOc//XBRfxnFBQi/6zCrRhDvyJ8h9jCcehHl+dLR
	 XYupBBeeozaq/t+yGj6i0nowDraIL4DQjPnhPK9hCPHB2gJlmRgl8gjFBWRkEnNbiH
	 EnRSGQKOTIXePC9+rS1O0uW2jVBKmcRAFuuFT+RVBUYoQ/g67/o5kPwsoGOGYERtjR
	 JJ81Kw81nCVVQ==
Date: Wed, 17 Sep 2025 17:19:28 +0100
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
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to
 vhost-vsock
Message-ID: <20250917161928.GR394836@horms.kernel.org>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:

...

> base-commit: 949ddfb774fe527cebfa3f769804344940f7ed2e

Hi Bobby,

This series does not seem to compile when applied to the commit above.
Likewise when applied to current net-next (which is now slightly newer).

hyperv_transport.c: In function ‘hvs_open_connection’:
hyperv_transport.c:316:14: error: too few arguments to function ‘vsock_find_bound_socket’
  316 |         sk = vsock_find_bound_socket(&addr, vsock_global_dummy_net());
      |              ^~~~~~~~~~~~~~~~~~~~~~~
In file included from hyperv_transport.c:15:
/home/horms/projects/linux/linux/include/net/af_vsock.h:218:14: note: declared here
  218 | struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net,
      |              ^~~~~~~~~~~~~~~~~~~~~~~

-- 
pw-bot: changes-requested

