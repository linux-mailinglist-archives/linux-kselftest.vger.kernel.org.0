Return-Path: <linux-kselftest+bounces-25774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BDA28196
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C281885885
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4E212D65;
	Wed,  5 Feb 2025 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZjlLBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307620DD45;
	Wed,  5 Feb 2025 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738721317; cv=none; b=qg69FuqXAolG3GQ/W4dZuGAY6ALyi4SsJJl2/G8hbISy3hi0n6rGB8iRbdXPnh21l8VG6dAFCrjOI15AxMbTzGeIb1PabFPAYUKBqPANCzX+ORCg2gEFvTa7d1/ibdsfQjoDgmbE3rabORWHeyfzR1owv7iTkScoKvXKeItrA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738721317; c=relaxed/simple;
	bh=7mGvON76aOVSll1EQ1UpgCRp0itlDsHTpyTyDoSJjsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T17x98PmrQKvCHZMu0b00r6KTI/Fk4eEpKGkQsqqdlBumJFlp8+H9EYKEKiAu+yBZ7MT/WjgCOZv8zznY4LtK7MqEQvBs9MoZqdz27VZc6ikdd8Wv/QvrplnRc1MK0hk66EgHVg4aAvFmDhvn9aqL68nLgHWUzBa4o9M556Duq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZjlLBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F97C4CEDF;
	Wed,  5 Feb 2025 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738721316;
	bh=7mGvON76aOVSll1EQ1UpgCRp0itlDsHTpyTyDoSJjsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ivZjlLBTdS2rCYB5+K9xcl83RZhD5DhJ3yYaCpho/7AXEsYqjjESebQLp5CXMvh9D
	 YwRTXfL+NkYxLtZd17ZCbOv8CMAsTbklFxdxpeoOvOb++Eutws+ab9YNxEnwVw61gC
	 CU+z8mSlId0tOZGhko0DPEwst1is2qmaUuD6LBPBjYV9QKT1Kv6TnM2VmGH8vFqF9Y
	 2uo0t/m/Ct9TnnXstE2zlfqfunwFWSRAu27GlU4ts6pTXj6Fd/Y/GDdRSoZLPBxRaG
	 cFpsLkqv91AlEMzI1Co6ZSV4lw5s3DgNsrV8ZEUUEuO3JK1nZYIykd7N6/lv7Zp3Li
	 +EeIFBzwmqG1A==
Date: Tue, 4 Feb 2025 18:08:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Eugenio
 =?UTF-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan
 <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com,
 dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Samiullah
 Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <20250204180833.48cb40cb@kernel.org>
In-Reply-To: <20250203223916.1064540-1-almasrymina@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 22:39:10 +0000 Mina Almasry wrote:
> v3: https://patchwork.kernel.org/project/netdevbpf/list/?series=929401&state=*
> ===
> 
> RFC v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=920056&state=*

nit: lore links are better

please stick to RFC until a driver implementation is ready and
included

