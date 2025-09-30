Return-Path: <linux-kselftest+bounces-42609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD0BAAE18
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AC5189CE28
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8B1DE3B5;
	Tue, 30 Sep 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1NxS9N1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C10785;
	Tue, 30 Sep 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195627; cv=none; b=R8pjtRDQHqcLWHIf78BhoKpKijmIeFuLd4HtCUbSi7YqKDE2dGTPwVYgKFsIdNCQDW2TRfaK/fmk4QvUBEmysIsT6v+vecvazchKPaBix6WLHTPMkYJy+wKIWjXQ7rywavftfPBSVQdD998sXmfWs/9fs6zL2fvNraPD4njnhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195627; c=relaxed/simple;
	bh=Mvs1TVjMABo2r4RhATfzwiftFD6X2sa6qX9zEuFViic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAbye7QfofjDUNnGjV90uj/Oy1w0l5rJGvVPGAaeXmgN1jIapdhvAhrKfz75wxTaFi5vHfO1JZskzCSmRBu6CDtEvWLoQWogR8i7VwYsRFqiFAIamBuipQwz27jIqRvcXxxuU6mOxM9lkqsdTHtIS1DaLKkn9bG0wHM5T2uVHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1NxS9N1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AF6C4CEF4;
	Tue, 30 Sep 2025 01:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195627;
	bh=Mvs1TVjMABo2r4RhATfzwiftFD6X2sa6qX9zEuFViic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N1NxS9N113Mh+6DVlwM2aSjlu9XRdS2eFJvot/SAODRnqPyhbGXnBp6rkRt7zhF1Q
	 pndzQVqv1z0dwJzVkV+IUZLNNwAiY/VE2ijaLbzQVELao5ElJ2fNbi1JDduFn55ceM
	 r2JT9IufcOrZHGr7+6ieZrga57dvqpf4UybD+a8cW9AOGm8fGoA7aS4MhLmNa1HinA
	 C7vYHJTCOMNOvGijXvMp/l+kFE0FdGpz3iskyyHrtx5GPVdIjvJngKBQNLBu0G9fK6
	 VgVhSLJhis+2+OuyXhVxXzK2Vbk97CAeRbHGZjuc5lXEGylJTdSRyhzjlJbQQQIUKX
	 nv+TXZa8+O+yw==
Date: Mon, 29 Sep 2025 18:27:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] mptcp: receive path improvement
Message-ID: <20250929182705.1583702f@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Sep 2025 11:40:36 +0200 Matthieu Baerts (NGI0) wrote:
> This series includes several changes to the MPTCP RX path. The main
> goals are improving the RX performances, and increase the long term
> maintainability.
> 
> Some changes reflects recent(ish) improvements introduced in the TCP
> stack: patch 1, 2 and 3 are the MPTCP counter part of SKB deferral free
> and auto-tuning improvements. Note that patch 3 could possibly fix
> additional issues, and overall such patch should protect from similar
> issues to arise in the future.
> 
> Patches 4-7 are aimed at introducing the socket backlog usage which will
> be done in a later series to process the packets received by the
> different subflows while the msk socket is owned.
> 
> Patch 8 is not related to the RX path, but it contains additional tests
> for new features recently introduced in net-next.

Could be a coincidence but we got 3 simult_flows.sh flakes since this
was posted. Previous one was 20+ days ago:
https://netdev.bots.linux.dev/contest.html?ld_cnt=250&pw-pass=n&pass=0&test=simult-flows-sh

