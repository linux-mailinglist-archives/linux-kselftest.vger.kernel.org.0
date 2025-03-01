Return-Path: <linux-kselftest+bounces-27950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AFA4A72C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 01:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80145189CD7A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71727179BC;
	Sat,  1 Mar 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqwYnfQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564B442C;
	Sat,  1 Mar 2025 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789784; cv=none; b=Tsp1kpGED9CwUv4ktAw+3USbmZnA5C5/2evpY8hOAGdS3WAgfzFDlR7+SDv5W1s0cPcbP0ixaqmyXmQ1OZNq46L4KHF9NoEq7EA/j3efNGPp88AgZBRYWxQmNYk+7KyhL1IET73zEfjiBJeSsTXMwWTHlnoHCgQfuk4ILJc5rUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789784; c=relaxed/simple;
	bh=ea5nB3P0PJidb6Y9nt5u1AfiiG2H38AOo9WolZSdhKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTpL9ik0Ve/3RvLc9VGH+skmuDTaIeDMH6kyQ5lRM9yv/2ZtvM0uvF95z7cCF3zjrv0obk8IteP3vN5F2bzOOnEVgS7oXwoIITuGKSv0KFiGLoAwyG1ZFjt7vQYVjDOl4trJRIQXnNPzkn0NLMOKKluZf/qtUjZ1/B/SgJia2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqwYnfQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7277FC4CED6;
	Sat,  1 Mar 2025 00:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740789783;
	bh=ea5nB3P0PJidb6Y9nt5u1AfiiG2H38AOo9WolZSdhKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qqwYnfQYrlR1UpE8jgFQrfswPrd8Pu4rD5K17AXsR2Uxuv9cIki/GMieTKEhQWql1
	 mumC5yO6c4Tx5JD/DtCgkBlaFLgVDkMdT2As2T71+mdqI1KAARm0smjT9Zrs+CWp/U
	 B/WeWVvPuxnDKqLWhCkg0Gr2vR0t6YQw2sdF3OzkrMLhXPw3pU6Prqryse4avpW+5H
	 iSMt0GZOPuEtACd51EBhAGMV1vKBUD1hFqrdZWfuVxTH2PTXVWhHJ5QZBfuvyLWRVw
	 04jZdaEGkrWM5XKQYzJNo6qbd+xH7uPC3x5dQRRj+6WaQb5i0SVV0GzdkxwHoiVQ83
	 JKSyI+RjW3gkA==
Date: Fri, 28 Feb 2025 16:43:01 -0800
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
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem
 TX
Message-ID: <20250228164301.07af6753@kernel.org>
In-Reply-To: <20250227041209.2031104-8-almasrymina@google.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-8-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote:
> +	if (!skb_frags_readable(skb) && !dev->netmem_tx)

How do you know it's for _this_ device tho?
The driver doesn't seem to check the DMA mapping belongs to it either.

Remind me, how do we prevent the unreadable skbs from getting into the
Tx path today? 

