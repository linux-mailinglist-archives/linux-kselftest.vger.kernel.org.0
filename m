Return-Path: <linux-kselftest+bounces-38418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E04B1CC5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 21:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E617A2A64
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CE2BCF41;
	Wed,  6 Aug 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N397vsFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC423C01;
	Wed,  6 Aug 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507635; cv=none; b=n/KBTDuqHFDrzPgGOwYJy+tYKHEUcJek+dM0DH+JliHRRvWjltVF+5pSpmuPCfUmWpZA/FkVQBS6zdmC+dFnF9FjEuvWKbJ2sQpn6DFmUKqTSboFAtF0Cxqk4KAInj+LUB51gk61V8QYxnuD+xDtwRrx0w/Dn311rksoeKWyWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507635; c=relaxed/simple;
	bh=HbH7Kb6Eo2GSd8U2cOPYi9TcSaL7mbK43Ax3qx78gfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtk5LXlHQ1MicdM6EQSDZr60/7khY9RVBVVP/m8uKOdHqsO/C419ggpxbinCz6xmnSEx3ZFJJZC3QfeLc1rWhHgoFYKODTDgX3uqSqfWymJqcfjb8Igu+WhyBvYRPsGep9XxnoG9qspKPdeMDO/RCA21BdotYkADd0+1kdxdtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N397vsFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAB3C4CEE7;
	Wed,  6 Aug 2025 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754507635;
	bh=HbH7Kb6Eo2GSd8U2cOPYi9TcSaL7mbK43Ax3qx78gfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N397vsFlJ7oRhyCxAfm3gIvq6iu+P6J1jHjeq8sW6sj/rNMLIMp7anYUJER0cNKV5
	 f11NcBca8ViJI1WwkT7Clsu8HIo1uqU7hnDTuKRtegfk0UvA9svyNwjRsgFZUCwam4
	 os+Id/GiY16FD0iOUFDCO8yK0SSoj4P3IgmutJVnCRUzGEsByqCa0qJyTqLXick/TL
	 dle6xunoOyYR76L9Jgju/DkZnkKti+h3My7ECHYV4F3MofpoOddocVgCoJXgxfGs52
	 g3LVBMLcte42ZZqxHAmZriDhSj/CsySEVDqGoL/lzCcz8ozK72CSBAiDQGwuHGzCYO
	 7T+N+XlkcZiYg==
Date: Wed, 6 Aug 2025 20:13:48 +0100
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
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <20250806191348.GG61519@horms.kernel.org>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>

On Tue, Aug 05, 2025 at 03:03:37PM -0700, Bobby Eshleman wrote:
> On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:
> 
> ...
> 
> > 
> > Thanks again for everyone's help and reviews!
> > 
> > 
> > Changes in v4:
> > - removed RFC tag
> 
> My bad, I didn't notice I still had the rfc tag before sending out with
> b4.
> 
> This is ready for review and not really an RFC. All test cases passing,
> etc...

Ack. But net-next is currently closed for the merge-window.

So please don't post non-RFC patches for it until it reopens,
around the 11th August.

