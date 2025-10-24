Return-Path: <linux-kselftest+bounces-44028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4CC08562
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89694E943C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76330E825;
	Fri, 24 Oct 2025 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le42WXym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDE2FE05B;
	Fri, 24 Oct 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349329; cv=none; b=XkQZx1ahNQ2mlWhJdtIYu38NfTJ12PPokXhPoGZ1IHwQhY7IK3/KB3ffIEKH9OXMMHy2PtlH83FnwNGSLGOVVCiEK2q7FI3hpFw/wU2U8VIb5ZD/dNxBX4pe3QZryo2vh+tlIIXeOuuQZPJl4sjeaQm1usokLZmSZscimo7cja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349329; c=relaxed/simple;
	bh=XWNdrRqN93VIvDQl6H8LxcywyJlO3tWIkLxQLeKXNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+IL8tiGiAjqnZ5rC7EpKGjbAkLq+rXAtyMTxd6FbdxFs1gJ/6Doj6rYeM6coVIUhOwfDUjs+FOzPmYxllg2wqEg86oQ3JFW8aM2TBkC+So+gKMavdXA56gy/Wy5QqgA6QYoCGDSicNGEEM6Eyae79IMwdyzAUha2Zxvj7CStG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le42WXym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E02C4CEF1;
	Fri, 24 Oct 2025 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761349328;
	bh=XWNdrRqN93VIvDQl6H8LxcywyJlO3tWIkLxQLeKXNpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=le42WXymzdHA6j7KcAW7kOp0kYQ2ff7rYI1VYGB3qIxxhqkJLOTOtX859GeHJ/oTm
	 E1LRpVsKQEZL9PvqBNjadLzF2SoR8R5h669JnhZfGLtpV4CB59YXJX1axjSIW5H4AB
	 b4SaW/uElIjnMiocFoCTiWUUYkKyA5QudXUG8qH5kWMYe/ER3CCkQalwERT1/3wyDc
	 krc5f9avTdEMdj4JgRqfZXijIwfBGd24uXgofpQc4cgOlA8QKlKqBqL1gMueXXfWL3
	 /j1OgZErwKEJWE8RZ/LM1sL8ErGFYsk6dQkZTedUWIsEwznB7ZLVt58/HJ6sh/z180
	 oKWouFuzaSa+A==
Date: Fri, 24 Oct 2025 16:42:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthew Wood
 <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] netconsole: Fix userdata race condition
Message-ID: <20251024164207.3062ea9e@kernel.org>
In-Reply-To: <CAGSyskWm=jDOSPAh3LWEQQzjAxvc-Od7DkQyP7W9EynoMdDnMg@mail.gmail.com>
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
	<20251022180107.3a7d1198@kernel.org>
	<CAGSyskWm=jDOSPAh3LWEQQzjAxvc-Od7DkQyP7W9EynoMdDnMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 18:10:06 -0300 Gustavo Luiz Duarte wrote:
> There are two reasons for hitting this skip.
> 1. The hardcoded 2s timeout in listen_port_and_save_to() expired
> 2. socat died or failed to start for mysterious reasons
> 
> #1 should probably be a success (we ran the test for this long and no
> corruption found), and for #2 we can try to return whatever exit code
> socat give us.
> Retrieving socat return code is a bit tricky because we are running it
> in a subshell, but we can save it in a temp file.
> 
> I can also send a follow up patch to use a longer timeout in
> listen_port_and_save_to() if KSFT_MACHINE_SLOW

Frankly I'm not sure this test is worth the compute cycles it will burn.
It's a direct repro for a very specific problem. The changes it will
occur again for the same field a pretty low. Maybe just repost patch 1?

