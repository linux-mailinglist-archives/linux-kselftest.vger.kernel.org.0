Return-Path: <linux-kselftest+bounces-39268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F8B2B5FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738A15E19C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5251CEAD6;
	Tue, 19 Aug 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDAuBa+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24E487BE;
	Tue, 19 Aug 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567014; cv=none; b=KW73s4UMXIIwTkxEJFnBCil4KWhpAENQcCTcusRSIXS7NLENpspA75k44RXfRxCZkCXC4+s15HCshRfneL74OiJL388Cih9e7w3TC3kDsgprseuuN0whFV+6exB0C1siRCHeMtB3gUnOoZfPq2UNU86aq7uaOC9lkrBadh8apxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567014; c=relaxed/simple;
	bh=HjSo4sMUl2Ldpf1msP/byAnFpczRUW9sFjAhNUFqEsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiYlZ3BOpJ3NQcASjBBsYXPzBd86rXk3pBzT6kk1x4/UNkuDbAaklGaJC1IH1LQ2UTs4DeYC5NElFQsUPxHpGM+tlxnIAG1T1PiuVBOJY8WXJkMvTQPbMHFikGBLEOgqGFvTOUB5b1JHDtto3evzY8dR6KI2zCAzXq114EybxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDAuBa+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22353C113D0;
	Tue, 19 Aug 2025 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755567013;
	bh=HjSo4sMUl2Ldpf1msP/byAnFpczRUW9sFjAhNUFqEsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDAuBa+IUsn5iUwada6rb+7o/czEjANoO2s/prcqXiSwdAFrTFCc2AHH4I/h29rcE
	 tIXIcoNfOdIpy/fXOaDiCuNfhIVW6klmsnXs+UwRd2IEqJhKoD08pGiQ6vVKs/4Ln0
	 ryXSA5pAUGspsMp3ty+Y73aWFjGGLkhSY/+ZFDDpbeqUbFJ5cQQtvCbERU95Ro+K0e
	 J0paZl3HZB2eh+D/F4akbXHskNEuLe8BBOEsjrwLT35xlyXO4C62hM1Wg6NICgqCVV
	 3lTRlRu7UXXtMkZe0D+/tweuckCSlCIgITLR5r7to0n40aediBAN/8sxn92AGdpsTp
	 55f9r0u3Cq+pg==
Date: Mon, 18 Aug 2025 18:30:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: fix addrlft test flakiness on
 power-saving systems
Message-ID: <20250818183012.35f47956@kernel.org>
In-Reply-To: <20250715043459.110523-1-liuhangbin@gmail.com>
References: <20250715043459.110523-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 04:34:59 +0000 Hangbin Liu wrote:
> Jakub reported that the rtnetlink test for the preferred lifetime of an
> address has become quite flaky. The issue started appearing around the 6.16
> merge window in May, and the test fails with:
> 
>     FAIL: preferred_lft addresses remaining
> 
> The flakiness might be related to power-saving behavior, as address
> expiration is handled by a "power-efficient" workqueue.
> 
> To address this, use slowwait to check more frequently whether the address
> still exists. This reduces the likelihood of the system entering a low-power
> state during the test, improving reliability.

It flaked again, after long time of being fine..

https://netdev-3.bots.linux.dev/vmksft-net/results/259361/15-rtnetlink-sh/stdout

