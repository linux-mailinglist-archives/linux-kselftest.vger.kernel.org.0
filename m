Return-Path: <linux-kselftest+bounces-28450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FEA55D5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DD7A3315
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC91624E9;
	Fri,  7 Mar 2025 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pla5hmcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F953155C82;
	Fri,  7 Mar 2025 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312552; cv=none; b=GUZZ5IkOKXASat4CifV/KbWMuVBKMJJD+9YrJ5C8D+3uAIfOrlTQ8J2nVP94EHqXhl4+iTrTau0lpsDSlr2TSTsfV0H0HwnmBVROMdg08VM57xSQHS3G4SvLIJ9+XJEYxACc5tbfeEnqTjZBQIc1Jk/XwlK4vovI/bxtRzyk1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312552; c=relaxed/simple;
	bh=jzCmZGAmwpg8bHyOWaxlRBOX2RWJnHDIlNa1nRCaMD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQ+qIw0HdGBe1BOcgtOQ8x11k2ry+5SEc9KcixNLyqIT5u++xRwxGQk+T4XU72qlMBe5OAvkcNZm9pEeSHTJrEYyabpiDlErNJr3fsALbXA7J922KIXOXiM0m/8uBNteW36GFpavu1PmpCsXMHhB2TRcbH4FsngtOubXk5JfCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pla5hmcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD84C4CEE0;
	Fri,  7 Mar 2025 01:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741312552;
	bh=jzCmZGAmwpg8bHyOWaxlRBOX2RWJnHDIlNa1nRCaMD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pla5hmcmfU6ZtpRhWTOzsslFVyiBa054pxuL5go/J3ZWEvP7lqtehS1RtojkvKTB8
	 WPOltc4Y12RSTAuftoMZGlfZRHKl6WbkyNuSJecUj/escsX1elPw5iZOw3vyloWA4z
	 j0gUGcwCsNgc0bXt571JJAJbMKPhJ7oV90et1yPZe4kNU7QPKQIsBY674NZraSoxSJ
	 OHgF4c4abqScmwgPIZC+8tm78Z6cAD4LSoyFopu7rWVCRi3qBJXTOq2CPdDfOMQ2dX
	 CxKS2ox3S14Fsb4Q5USTLGXN5dpzW6ex9cXPWVB0KykY93hF1BrQ4weU68SPcHJmvO
	 HLiinPIsaUNYA==
Date: Thu, 6 Mar 2025 17:55:50 -0800
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
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v8 3/6] tun: Introduce virtio-net hash feature
Message-ID: <20250306175550.03c90e21@kernel.org>
In-Reply-To: <20250306-rss-v8-3-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
	<20250306-rss-v8-3-7ab4f56ff423@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Mar 2025 18:56:33 +0900 Akihiko Odaki wrote:
> Hash reporting
> ==============
> 
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> RSS
> ===
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

drivers/net/tap.c:1056:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
 1056 |         case SIOCGIFHWADDR:
      |         ^
drivers/net/tap.c:1056:2: note: insert '__attribute__((fallthrough));' to silence this warning
 1056 |         case SIOCGIFHWADDR:
      |         ^
      |         __attribute__((fallthrough)); 
drivers/net/tap.c:1056:2: note: insert 'break;' to avoid fall-through
 1056 |         case SIOCGIFHWADDR:
      |         ^
      |         break; 
-- 
pw-bot: cr

