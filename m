Return-Path: <linux-kselftest+bounces-27949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AAFA4A71B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 01:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CB916FA55
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07A179A7;
	Sat,  1 Mar 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx7qpfWJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCCD2FB;
	Sat,  1 Mar 2025 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789529; cv=none; b=doLtjz8NVtsgkoguyLciOBruQK3/eXtI3UldYkY5DJ84EsGXBO8N2DHSwJVzv5abET92FAkH8rA8pL/xBmf1Y7kw84d1OmmyP/IYpwNoP6N7tE5gDOcK8/PlyVQFaClj64F2FAiQguZLHOHF9rNcDxErLy84r1R1X+0KhCn7jjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789529; c=relaxed/simple;
	bh=cmEKSxw5aeNZwvCuEFEfP9uDWkInDxdoU9TEsCWxJek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ri7aOQHrgn8GVdxwYLMnV4OThbeJg66LU9p+emlQnEaZ65cfcUMQ3AmGOEurhXvDrZAIBJB6nY/yEMuScD/jBzL0SxkZ9AGfc4XSfTcG/hLY9u6WAE7EWUCna9xQJ/dOSMnxGhTtpHpqjFrebpY4bukZJYMNiW0YT3oVcxFFiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx7qpfWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C15C4CED6;
	Sat,  1 Mar 2025 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740789528;
	bh=cmEKSxw5aeNZwvCuEFEfP9uDWkInDxdoU9TEsCWxJek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wx7qpfWJvYWHknPi9Aun0tomKq5sp4voC+U+ORaApPCm2IgZqdxBBIEcpWCLtDRdW
	 6EiOpd+nJhMAImD6p2Rc85gRB6+X5OOVMzfQdmDpubtWCqfwtvaP98gLUr4mrbJQdv
	 /XFDpoPC9RdKXd0mrMfIQQs3M56mG0T0nNWzakp7NXoDnEWl4EHeNdIq8ly/P7Et9m
	 q+5pxa36GxuvLqbyyJEexBfEp2MUEixM2uohZA8HHAxo9LsddhVHpC/7zzNOykHDam
	 4dq9f5Yr0rZgv/rIJyvhqoeOiQAH5ZrbrmGfplYxFGj2jShF7JTSqIUIWT+Vsp52gV
	 Vm9YCNerdDN9A==
Date: Fri, 28 Feb 2025 16:38:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "Eugenio =?UTF-8?B?UMOpcmV6?="
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Message-ID: <20250228163846.0a59fb40@kernel.org>
In-Reply-To: <20250227041209.2031104-2-almasrymina@google.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 04:12:02 +0000 Mina Almasry wrote:
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -	get_page(skb_frag_page(frag));
> +	get_netmem(skb_frag_netmem(frag));
>  }

Silently handling types of memory the caller may not be expecting
always worries me. Why do we need this? 

In general, I'm surprised by the lack of bug reports for devmem.
Can you think of any way we could expose this more to syzbot?
First thing that comes to mind is a simple hack in netdevsim,
to make it insert a netmem handle (allocated locally, not a real
memory provider), every N packets (controllable via debugfs).
Would that work?

