Return-Path: <linux-kselftest+bounces-2582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AFE821F96
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058C31C22562
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DA14010;
	Tue,  2 Jan 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPkXFcxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C414F81;
	Tue,  2 Jan 2024 16:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5069BC433C8;
	Tue,  2 Jan 2024 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704213234;
	bh=ccMdA92CK8ykTFXqfbZF1lWT1GVhqrcdf167LJsJX48=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gPkXFcxLcRwxTJGg18yG5kwUTtPCMbXlR9nIfxl0xRdpeieROGL6kWnkjGrFBT3Lc
	 /3WpFNfOGHZEC6N1zgxKUpAqo2EcU+Axo832hhhOq/XlIKDYj0VJ6OSWIR8pSp3o/v
	 40LQ9WVcVYzOdeZbhNZcGjNzZzi8yqI9f5O+Hx6TLx4tXOuUkDGIJqrg8FNaCiC1kw
	 Ww8I1HU6BBA8gIvGY7RixIKOZ6ecb+5cFrpX6IA8wZfFhzS1zbKPQ4/DhA3ErO0Kbm
	 uDAoYdB20MooeFGawRTP5gtwOKqHZFKAZoBC0S+7SZXpHrTIfJJTXpAMv4xTzostkE
	 imWacBLWbaQoQ==
Message-ID: <09a33544-c9b5-49a4-9276-727e2eb8e521@kernel.org>
Date: Tue, 2 Jan 2024 09:33:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
Content-Language: en-US
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/24 6:24 AM, Richard Gobert wrote:
> The existing code always pulls the IPv6 header and sets the transport
> offset initially. Then optionally again pulls any extension headers in
> ipv6_gso_pull_exthdrs and sets the transport offset again on return from
> that call. skb->data is set at the start of the first extension header
> before calling ipv6_gso_pull_exthdrs, and must disable the frag0
> optimization because that function uses pskb_may_pull/pskb_pull instead of
> skb_gro_ helpers. It sets the GRO offset to the TCP header with
> skb_gro_pull and sets the transport header. Then returns skb->data to its
> position before this block.
> 
> This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
> which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
> ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, all
> operations use skb_gro_* helpers, and the frag0 fast path can be taken for
> IPv6 packets with ext headers.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/net/ipv6.h     |  1 +
>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



