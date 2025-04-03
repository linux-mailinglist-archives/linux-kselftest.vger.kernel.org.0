Return-Path: <linux-kselftest+bounces-30040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B764EA79966
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 02:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508C03B3A25
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1AF9E6;
	Thu,  3 Apr 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUBQ8sUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001574E09;
	Thu,  3 Apr 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639889; cv=none; b=aeGhNEAVFHAvHd/EQjMwzxTd4Kv7hsERu19hA+Nv9d63bcXxTVBPbS8kRGQ8gpE3eY1hrHAIsXZ5biOmYv8qm58z0sqHogHHJxfQVe2WnhujFyILNDex9lJQSemPtgTiy/swu3OHyhLlh7yZV6GFtCUBrlKOZkcbrrRnug8SmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639889; c=relaxed/simple;
	bh=mz5lyvN7h0nt/sY0f+AgxhZJiaKZQnYXi9YxDfQH9QA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE9PEefTXDhCnLMGkZQFnH9uDMzUYGSf50W3HE7xYk/XDFOejhZeDSqNLMFCB7bZENt+KE1KHAeeOa0wqrUh/8l+r0S7eq3ytW00sN1+6gIGkRg3zsGgtF4kQfK7pY7WOy4iAtSrEkjo8Ai+uUme9gtZFRww1OEP4TnzO43KZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUBQ8sUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC06C4CEDD;
	Thu,  3 Apr 2025 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639888;
	bh=mz5lyvN7h0nt/sY0f+AgxhZJiaKZQnYXi9YxDfQH9QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUBQ8sUK083D/NSf6uKRioMj2OOyOuQ71SxeXZrcdfIxsvc6p71V2o0wTm8gQ2RdI
	 SMmbH8KjZdzQQozFuo1hm38a8xHSimfVP8QK2sV1++UaFMXy0r3z9cOpUFe/VF8SQJ
	 /powehxfHXJuXe3Gpiy9ruUljnBpCgOR2TaM488Lxju4COyQqaJlyxNRVh+u1DbiwD
	 hVSeKyjdzkvgIpxuliu5xZZBG6wkss9FVFr4Jj9jzIijDka2/lYM2gjuvP8U0e2bE0
	 K/8gffs8AkSrPn06h2S34OLtyMjCrlzmhgbpvO7ku+YVjjQfWOVuiCMaXHzWhNev9I
	 7xTAlnUnqqVtw==
Date: Wed, 2 Apr 2025 17:24:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Anton Protopopov <aspsk@isovalent.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>, Jordan Rome
 <linux@jordanrome.com>, Martin Kelly <martin.kelly@crowdstrike.com>, David
 Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add perf test for
 adjust_{head,meta}
Message-ID: <20250402172447.75ed447f@kernel.org>
In-Reply-To: <20250331032354.75808-3-jiayuan.chen@linux.dev>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
	<20250331032354.75808-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:23:45 +0800 Jiayuan Chen wrote:
> which is negligible for the net stack.
> 
> Before memset
> ./test_progs -a xdp_adjust_head_perf -v
> run adjust head with size 6 cost 56 ns
> run adjust head with size 20 cost 56 ns
> run adjust head with size 40 cost 56 ns
> run adjust head with size 200 cost 56 ns
> 
> After memset
> ./test_progs -a xdp_adjust_head_perf -v
> run adjust head with size 6 cost 58 ns
> run adjust head with size 20 cost 58 ns
> run adjust head with size 40 cost 58 ns
> run adjust head with size 200 cost 66 ns

FWIW I'm not sure if this is "negligible" for XDP like you say,
but I defer to Jesper :)

