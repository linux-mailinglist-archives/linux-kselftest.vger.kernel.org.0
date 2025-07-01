Return-Path: <linux-kselftest+bounces-36132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7EAEEB38
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 02:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04921BC2568
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0572631;
	Tue,  1 Jul 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z91pH2ZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5C29D0D;
	Tue,  1 Jul 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751329358; cv=none; b=kCqmbgyvGOJ78JT7pS7kH7Lyp9H31i5gyTUnsUE53tFdpzSpWof8oJ/MvL02UZQjW+RlOyIu4GzxxvrDrAE27UjPNyp1JRWqXu2RQeXO0EyQ4pkVAYV2ATi8F33X5VsKmgfhPwESMPzQLdPDsqyDatC/AmICz3Yy72QxHYS4SLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751329358; c=relaxed/simple;
	bh=8m39wZcOsO0ySRI9wOw11ftkOtNE4FokYmfqBde44oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKwQcyNTKP2QPElwvfQQtiWmft+ke4L9ekDP9Ff8TLnZuqLOQCT4ag08nkC9fewYzhdlmdKS8v9wibymwHNO+srDYpsl83oxY4xl/xiMcfYYGD01ZHjQsy5Fbmaj9mLDXmNE9EzPSNuks3GSdU+nrZ8d3JfLKZgwG8W8aBFcjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z91pH2ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D27C4CEE3;
	Tue,  1 Jul 2025 00:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751329358;
	bh=8m39wZcOsO0ySRI9wOw11ftkOtNE4FokYmfqBde44oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z91pH2ZAVjnL0223gf6z3qik26gBpWlFk6GVRnOXXvxnd4Y9yeERF+vQ7vaLod3ez
	 h/IAdb1RxChW11Z0gg7M21RzvJ5MKwKJzNidiWafH/PihjwTFN6atumDTyZR851hUg
	 fUyyab03Yx309lKfXcGemphtd99G+UG6L+XcUB2KHse+qGaif2q6zR+Bs646VrQSDm
	 CyUDp4+dsoLdfKCYSsFfJB9PN6HFM+z8XNMxFGHou8hFB9Zzp2Vcb+18v9UGJcjXH/
	 qIpafuL2yKcdm8e5tm7tMRtDe7qHelZ4egua5vSSkVhYSqciADV6xWyxPaSNTRnipK
	 GGSoPEap+9u/g==
Date: Mon, 30 Jun 2025 17:22:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net-next] selftests/tc-testing: Enable CONFIG_IP_SET
Message-ID: <20250630172237.03d08cfc@kernel.org>
In-Reply-To: <aGMGoICSLZerw5CM@pop-os.localdomain>
References: <20250630153341.Wgh3SzGi@linutronix.de>
	<aGMGoICSLZerw5CM@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 14:50:24 -0700 Cong Wang wrote:
> On Mon, Jun 30, 2025 at 05:33:41PM +0200, Sebastian Andrzej Siewior wrote:
> > The config snippet specifies CONFIG_NET_EMATCH_IPSET. This option
> > depends on CONFIG_IP_SET.  
> 
> So it should be set automatically when running `make` ? IOW, why do we
> have to set it explicitly?

EMATCH_IPSET `depend`s on IP_SET not `select`s ...
I think the patch makes sense. Or do you see another symbol which
should get us IP_SET in the resulting config?

