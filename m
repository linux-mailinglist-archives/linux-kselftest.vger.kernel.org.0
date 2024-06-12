Return-Path: <linux-kselftest+bounces-11807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BEC905F50
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB031C215BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C012CDA8;
	Wed, 12 Jun 2024 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcMHyvhs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F85464A;
	Wed, 12 Jun 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235602; cv=none; b=Ke303/o6ChI34hxP1DODs8GYNfiK98OB6DhpLJIw/QJdjCIuZPdNDBL3XclSS0HA1RzZhj6DkbKESmUZbTXE2Rqn0d92EXKgWyTrEY8lyg+dDXt26RWfEzG7tK46dNLQ2yfD1ULRduj9aqyfsDZGER/Z1Q+VJT/6vHdP8sYyRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235602; c=relaxed/simple;
	bh=WsC6Et8Vg0fdhouW8l29uZmhPYQgqgGPx/4xK87/2q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+rjxJZ296QJRdHeHIRQJpmc4fGSfJdsPFl2Gs4X32ea1QJk7Fqi8BsrJPGjKgvJK2yWDikGeg9Ob407sDRA3ajfHlOeNJbIWG5K2i40oub7bMAG12mW2i3obkQ8eppB0FaQ2Pgbi2qBYZgNSVtmloLvwbnjiB2+zuH+2KZOsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcMHyvhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBF0C116B1;
	Wed, 12 Jun 2024 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718235601;
	bh=WsC6Et8Vg0fdhouW8l29uZmhPYQgqgGPx/4xK87/2q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bcMHyvhsZWckX1t23uyuJfAapzldxq0qcVF+Tc3de5mVjAGw3H70ui4ctMAtkinq1
	 f0WVyi/HdApvGK+LLEGguhdFRGRWxU0tApPNZ5GtXxoPTIdP97dSSu1mhnunoqB/fl
	 jnRvQJcAEKTtE5YvvLZAWDMI8Tjjd2q+o2DJqKP5FUgj/X9J82OkFw3IPgN/C4lC87
	 F6HicCcW0DE0idIQ9ivjjj05Jx90BqN+ejGTlgYQSGoTEWgt6SupFfJ2zwc1cr4Siz
	 iWW3oyhextYOekncX0NsnBSe8K7fBU+/ZhpuXxfEzaBnpNxcJZ7aY/+wA6taXmoC/P
	 fXT1dBd1moRyA==
Date: Wed, 12 Jun 2024 16:40:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Boris Pismenny <borisp@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] tls: receive msg again for sk_redirect
Message-ID: <20240612164000.29c0f1a1@kernel.org>
In-Reply-To: <ce31a803e39c856f27f16f9ec03376ef7fc4da81.1718182183.git.tanggeliang@kylinos.cn>
References: <cover.1718182183.git.tanggeliang@kylinos.cn>
	<ce31a803e39c856f27f16f9ec03376ef7fc4da81.1718182183.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 17:19:03 +0800 Geliang Tang wrote:
> tls_sw doesn't work for sk_redirect in nonblock mode, sk_msg_recvmsg()
> returns 0 in that case in tls_sw_recvmsg(). This patch fixes this by using
> "continue" to receive msg again instead of ending it if strp isn't ready
> and rx_list is empty.

Can you explain what user-visible behavior problem you're trying to fix?
sk_msg_recvmsg() returns 0, but tls_sw_recvmsg() will return -EAGAIN as 
a whole, so everything seems in order.

