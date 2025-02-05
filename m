Return-Path: <linux-kselftest+bounces-25773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF786A2818F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C343A1491
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D1212B3F;
	Wed,  5 Feb 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5nDGIfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41818212B1F;
	Wed,  5 Feb 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738721168; cv=none; b=QKV/6k3dAfN5EK79b1vhgXlT8dFy/k+8J5ChdzXxUz/3taMrIuJFI6K5ayklkcTkftX+Zsn73RFhxbwolWpuuHRxjtocILX6iStgPTLDm8pWMscMn1WZ00z9PO9URVsePLptHSplhul8xnejdVW8beq+CS92ti0jPe9Z76WL+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738721168; c=relaxed/simple;
	bh=g/MZNgeG47rEDHzwtuKkaPDvwcYnBFmBeL4Dnw2TTwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgBVsXjZs863dt4TgoSvTUMf49bodNBGM/Gd95Ly6PFTaEXegCAdPz3oqdWtOUjDPjnowwoI2VT/PimSfkSMqYXSSrR7W/u8Uyq0ieW17B7Q0WVMgoN5pNRuCdaJh9D4UKpYuUB+5v/OaSnCnMwJhs+835fw8+zBpC7IapjXDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5nDGIfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6171BC4CEDF;
	Wed,  5 Feb 2025 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738721168;
	bh=g/MZNgeG47rEDHzwtuKkaPDvwcYnBFmBeL4Dnw2TTwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f5nDGIfbkYWYtpJTxIXjgqSOpvUVgjXcNyoLY4kBNZqYhrWBhgHshE0CocdnbP8qW
	 NusCCF/whBR1MMPCuEHEEuMVtmWQaejCi0hILMO8zuh5IEHye3hMMo9JHfpb0Dt2Ob
	 88buMz7DMWFN6fUDEJHB3q0bN5/3UmAOoDfVtZYXoaHPX2iCQtfOmX11KwEO9r590x
	 1Dxl3fwauA5YO4lyGOJ1A6SB84KvqL+KY8hJhuGAG8X7gb0668kzHwJmMxAmQTYMdH
	 owE7Qc+1W+JjXOM0X2yerYHm+Vnlfk/ECWyuraJNBZMIMTPfRRToETAP6Cu0nudK6X
	 pfa2LOjYB+VSw==
Date: Tue, 4 Feb 2025 18:06:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Neal
 Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <20250204180605.268609c9@kernel.org>
In-Reply-To: <Z6JtVUtsZL6cxsTO@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
	<a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
	<CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
	<Z6JXFRUobi-w73D0@mini-arch>
	<60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
	<CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>
	<Z6JtVUtsZL6cxsTO@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 11:41:09 -0800 Stanislav Fomichev wrote:
> > > Don't we need some way for the device to opt-in (or opt-out) and avoid
> > > such issues?
> > >  
> > 
> > Yeah, I think likely the driver needs to declare support (i.e. it's
> > not using dma-mapping API with dma-buf addresses).  
> 
> netif_skb_features/ndo_features_check seems like a good fit?

validate_xmit_skb()

