Return-Path: <linux-kselftest+bounces-27906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFEA49C05
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4632F3AAA3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50B26E62F;
	Fri, 28 Feb 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY5O/cwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BC224CC;
	Fri, 28 Feb 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752989; cv=none; b=AD1vAKwuKQ5dD9Yk76YhhCYBcw7r6L2xd0E0NB8Qpb+OIsKryggwyLP9RrWW2WAFFvwXT1vYWDtAP2eE8m+pOs6Wlq7zZnjkAbOW39b6ZwIGBUwZOS7f5jQ5eBvw2F+/o1u5Z1EaXiXvaAd1XgNgMDx4XmjbH3QpIAWrSniHLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752989; c=relaxed/simple;
	bh=AY6KTggfG+2NZyh4MNhPng9mblge+5h8fWPaN9vRs4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raBUJCK0Fs5oguwjNAmtMr2OilU/4lVJ7YY7eiZUlno0ryqA2VmLgvSmXucvl2Z6YJ+u8UHIQWm9mGPZOm8vJilQlvS9QjMFTgK3RyBfqZsgOMrIcBHwf8yo2zO1/hbiJiLMYOnRu+oeRNbgruXOuSuu/q0enuC37bmnYPx8nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY5O/cwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6891EC4CED6;
	Fri, 28 Feb 2025 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752989;
	bh=AY6KTggfG+2NZyh4MNhPng9mblge+5h8fWPaN9vRs4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PY5O/cwxqxGLSaoACpfVg8SBBsGU7X8sCCbwt2WaNaSJM188KFrQ1NJlA1llaK1h5
	 W8+lMdcP7Ed0rrxJ9K8q68rCEeFhpCBYO+rCwVYvY2pXkef3HQSjICnUnoh0I6VLlp
	 YNERk5kXkPB0RyuYIQedzL61nc49kcQq897Ga/IiFWrWPnwwcZeU45v1m9wFelEktG
	 PCfg1foDNZykiybW+k42CR878DQ85frAgVgDbj41geD2PWGYKSMmbYCLxSxP0L1M3p
	 m07ouhO/PQ/yMy7+FB5N5jlDEoHo8SzaoBh3AV5576HyXpb2G2Ponp5l53ssIqcTXk
	 93Cj4wOH1T+PA==
Date: Fri, 28 Feb 2025 06:29:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>,
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>
Subject: Re: [PATCH net-next v7 5/6] selftest: tun: Add tests for virtio-net
 hashing
Message-ID: <20250228062947.7864a59c@kernel.org>
In-Reply-To: <20250228-rss-v7-5-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
	<20250228-rss-v7-5-844205cbbdd6@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 16:58:51 +0900 Akihiko Odaki wrote:
> The added tests confirm tun can perform RSS and hash reporting, and
> reject invalid configurations for them.

The tests may benefit from using FIXTURE_VARIANT(), up to you.

The IPv4 tests fail reliably on a VM with a debug kernel
(kernel/configs/debug.config included in the config):

# 5.90 [+0.00] ok 14 tun_vnet_hash.unclassified
# 5.90 [+0.00] #  RUN           tun_vnet_hash.ipv4 ...
# 6.18 [+0.28] # tun.c:669:ipv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), 0, VIRTIO_NET_HASH_REPORT_IPv4, 0x6e45d952) (0)
# 15.09 [+8.92] # ipv4: Test failed
# 15.10 [+0.00] #          FAIL  tun_vnet_hash.ipv4
# 15.10 [+0.00] not ok 15 tun_vnet_hash.ipv4
# 15.10 [+0.00] #  RUN           tun_vnet_hash.tcpv4 ...
# 15.36 [+0.26] # tun.c:689:tcpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_TCPv4, 0xfb63539a) (0)
# 24.76 [+9.40] # tcpv4: Test failed
# 24.76 [+0.00] #          FAIL  tun_vnet_hash.tcpv4
# 24.76 [+0.00] not ok 16 tun_vnet_hash.tcpv4
# 24.77 [+0.00] #  RUN           tun_vnet_hash.udpv4 ...
# 25.05 [+0.28] # tun.c:710:udpv4:Expected 0 (0) != tun_vnet_hash_check(self->source_fd, self->dest_fds, &packet, sizeof(packet), VIRTIO_NET_HDR_F_DATA_VALID, VIRTIO_NET_HASH_REPORT_UDPv4, 0xfb63539a) (0)
# 32.11 [+7.06] # udpv4: Test failed
# 32.11 [+0.00] #          FAIL  tun_vnet_hash.udpv4
# 32.11 [+0.00] not ok 17 tun_vnet_hash.udpv4
-- 
pw-bot: cr

