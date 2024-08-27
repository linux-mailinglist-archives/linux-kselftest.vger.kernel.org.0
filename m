Return-Path: <linux-kselftest+bounces-16364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71295FFD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C4B1F2345B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6041B59A;
	Tue, 27 Aug 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVIjOuxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078CA171AF;
	Tue, 27 Aug 2024 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729590; cv=none; b=KL9r+e3S+xRSk4XYGm2RxzzolZtRLSymsUYAIIvAQFTv4ipLbIDZWXH6/slBA8IuqEsDXoUOfCFuTnnQZ8Oq5fBVnTbX8NBc3gN0VArcJaRDRDce1qlHQN6IejNJMyyS5lDDI84Bmable45VmHO206Orz1CPadl/g2sjvkJ8MB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729590; c=relaxed/simple;
	bh=6PzS5Tdk8YQgNBjy4ccnPSGnXknsU27HU1R/5Y8rlWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbI4NlCpaaMlQq8bS3THhfHi9+IWDI3kTs9vmssivL0ejD4c9E/vFeRvClJ2sgXQZJ5dbLvb2wFbSE3VXihD4ShJINuWGdIFNWJOePFjpQPF2Sz/KuAYHyqIKU2sswXMIatOeJqWqAcaEiIy7LJ1AGaHBb7uJ6SofxhMVlGfvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVIjOuxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA0DC8B7A3;
	Tue, 27 Aug 2024 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724729589;
	bh=6PzS5Tdk8YQgNBjy4ccnPSGnXknsU27HU1R/5Y8rlWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mVIjOuxVw9qlfJ0a3XOELpEd9UlRzEf6/MNAG1ZLtdNBIjWNxKWPeIolha/JFJeIR
	 TWrJjZ8/upkMPbudUDOwUR1Vx7AR9QdUo9x0vwyGd9YxKhMn/aZn4v99c6rkTe21T0
	 xxldGRDpf0G64BvhxWoSzBFXEdOumFsypgmOUJnk82kOhE2HK7vNkWI7vfnZ5+MEdV
	 pey62m470J8A2naSktnQFiN5iIJ+TT7eFyx6WpQf6Xn/nDjclCxTpVSL1uzsOpW9zX
	 B7Yla7DPiFT9pGSF+ARUNhmtX9Cu8jqfb/rY4qt2CgPyfi+bSoVtGTKYWUhC3L3cqO
	 hcxlwV5KSyzeg==
Date: Mon, 26 Aug 2024 20:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian
 Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 0/4] mptcp: close subflow when receiving TCP+FIN and
 misc.
Message-ID: <20240826203308.7cc1bd5c@kernel.org>
In-Reply-To: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
References: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 19:11:17 +0200 Matthieu Baerts (NGI0) wrote:
> Matthieu Baerts (NGI0) (4):
>       mptcp: close subflow when receiving TCP+FIN
>       selftests: mptcp: join: cannot rm sf if closed
>       mptcp: sched: check both backup in retrans
>       mptcp: pr_debug: add missing \n at the end

Why are you submitting two series to the same tree at once?
The limit of 15 patches applies, no matter how you post.

