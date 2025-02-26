Return-Path: <linux-kselftest+bounces-27619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D7A46467
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027EC3A2285
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED3223329;
	Wed, 26 Feb 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA/IzGhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD522157A;
	Wed, 26 Feb 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583206; cv=none; b=EHWuSS4qhj8yCEsyM/VZqWPcUk+bIaLzx6aS0rcJ32TSeTafPMQPcLqZoDjL6OFILQRRVHI2PkG6YbOhjG61kVElu8ZG5SRgKWHZz1jOBr7V7Q84N2HyqLAJiGvjDabn4tn6lH91nLJFupfhcEpEBmHFSlQeHzHU+4wM2mYWk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583206; c=relaxed/simple;
	bh=CedHuBhU4dG6Z7WShc/tqSWOqWeKxnRhgco2OyGymr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncKUQgbLwvikFZ6iMxsoY2gBcJpFMFAKVFtv4hd3NPYnW1NIC5Q8zrNq/LHrqQUCYSfIuYDlgAVUYm4J5mPP0zo5LCukZ2va+z/VCVT+FUfOUQpYKXQ4zDhPuoRq/PL0i3QniF1qMROnv8kjiITXDRoRbgg9D0aCvrhRM1Zw8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA/IzGhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C24C4CED6;
	Wed, 26 Feb 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740583205;
	bh=CedHuBhU4dG6Z7WShc/tqSWOqWeKxnRhgco2OyGymr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cA/IzGhK17WDeCv7tdCcRLQFW79uNqyYRIehaLJxTU4mER7nWMrg4J52hwOOnMQ7d
	 y3P12OCaCxGYIQb8FkolzbFh4np2zmANfHmuYVD8n9A6GZYfQPMAAFx/P+tEQGAM3C
	 IuCDJ7zoNuFyIW+4PA1wYOGL8XJTrjM6gZBxLo84GZITi2kGvaBJtPzG+fc9F8S+xq
	 dBea/g/ocDDgqiNjFUIufWXAudP9K2REo3ChgTgOObN8WyyTIUx6SBVD4SBybPEFGx
	 IUCOt/DGYagls2AKjM94UQeWZ3BnXGKpxr+ymX3tB8rg4p5ra5Mh30oUTEOx56hwcL
	 eFgj3XkX9PPdA==
Message-ID: <b4029bcd-3d47-4f24-956e-04033853c667@kernel.org>
Date: Wed, 26 Feb 2025 08:20:02 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com>
 <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
 <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com>
 <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
 <CAHS8izMc0NCMPvCGg-uAOeWaf+K-_EfHnK7+4i205dPUy9JBFA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izMc0NCMPvCGg-uAOeWaf+K-_EfHnK7+4i205dPUy9JBFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 11:54 AM, Mina Almasry wrote:
> 
> Will do, although I think maybe I'll add that comment above the
> refcount_t definition in net_devmem_dmabuf_binding, if that's OK with
> you. That was meant to explain how the refcounting on the binding
> works.
> 

That is fine, I just think the lifecycle of the dmabuf and what the
unbinding is really doing should be clearly documented to avoid surprises.

> Maybe worthy of note, this is not that new, in fact something similar
> is happening in the RX path. In the RX path each skb waiting in the
> receive queue to be recvmsg()'d will hold a reference on the
> underlying page_pool, which in-turn holds a reference on the
> underlying dmabuf. It's just that a similar thing is happening in the
> TX path.
> 


