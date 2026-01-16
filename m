Return-Path: <linux-kselftest+bounces-49083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D669AD2A562
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 03:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47D5301A72B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F227B4F5;
	Fri, 16 Jan 2026 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlIn1LKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D32EB10;
	Fri, 16 Jan 2026 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531764; cv=none; b=Y5xU1Bn5D/ikEqmSa9QgA9zJev0WQ8Pgt00u27iFqYvrL5m/BXbiC3tpTqmZqTHjdFrzT3xn7dYGqS5u9WQjKLOQ5scO0QWRWKhPHvWcNzYNixrTpOc6bi8r4RutAo7p120ERNCjWjEIjpMr9tIQpzczruYPgzzEhknDm+bWbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531764; c=relaxed/simple;
	bh=naNXNmtw5GvOQ0Wi06agiNYq5/AY9obtlTtzMBUwwuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsKGEXg8AWDuDaqt+zpDqspLHcmgFd5042v7qaRMdy2oclo/e89RjtufND73I7F0ucwWjKrm4v3xtREAZMlU4VuyB37OE0nTJHPgm59KRY+zISc/fVfzge5TOoY4lJf3aRhtQ3FE6m/VjDgoYhSEAM0CXru7nUmL3C5zDUOp24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlIn1LKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B74C116D0;
	Fri, 16 Jan 2026 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531763;
	bh=naNXNmtw5GvOQ0Wi06agiNYq5/AY9obtlTtzMBUwwuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlIn1LKvDxsHVkJLmzgFnLPLIL8vLFPv0QnTyKPLisMrQErAmGu3IsvxDt4wsWcmG
	 kPlFzIwOj2pp8/RKJk9S6koFc9k17LsWdNPd5sCle1YrnIU7px0enjogYEfGkCBBVN
	 9iUbaUBRvJTdDaN/I48cq+ZsjB9MVdzJA9Y+bAHKxUXPYWsidgg8uuNMEACIqH5vdi
	 gZ+LFcxCLW7pxXmJwofh+K47sEHFEhg/6ypJ74Q0NCueB69xL4KmyUt+agpaVW/ZDe
	 Wp+56u3pk2rS80aLyzVSe4NthAbVTQtNdWsuX/oAecY1+JpL8/UdWFQKLw1h2M91Wj
	 KVr69vwHupRSg==
Date: Thu, 15 Jan 2026 18:49:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Gang Yan
 <yangang@kylinos.cn>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2] selftests: tls: use mkstemp instead of
 open(O_TMPFILE)
Message-ID: <20260115184922.7e346931@kernel.org>
In-Reply-To: <2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
References: <2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 17:02:40 +0800 Geliang Tang wrote:
> This is because the /tmp directory uses the virtiofs filesystem, which does
> not support the O_TMPFILE feature.

I don't think selftests are expected to support setups where /tmp 
isn't tmp. Please fix your setup instead (or explain why it's very
crucial that you don't). The upstream CI runs all the selftests in
VMs and they are working just fine.
-- 
pw-bot: reject

