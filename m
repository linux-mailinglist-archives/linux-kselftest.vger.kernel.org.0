Return-Path: <linux-kselftest+bounces-26448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3EA31C27
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 03:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438C07A3DDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF361D435F;
	Wed, 12 Feb 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5AD6OPj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91211CAA87;
	Wed, 12 Feb 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327828; cv=none; b=Ydo7eAPCs9lWTmxhpdfRddmIwa/KjGlwWyLS2WCuFYY7jOrSqyCHgeDzmNY4TRwha+S8EbcLXhQO3zZ1tbWsYJHDGVbePUGc0dZTB/QxPeh4vpTXzmMF+aZDVlxC558SjtrSj2yASr5YMDVhDOySZjrEPMtqrPWhtW/U8nonX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327828; c=relaxed/simple;
	bh=YaAR5QiuZynmHcyvLV6BKRsvj5JY5bABea9gGeDWeFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUafXH21OI30uj1QEBDbimBSznFPeQQ8v1jha3kt9gVi6IveY0T5uToABJcQtkq0G5oFIjRevVZ3sSgBD/EiFIx53DKLoxVF7brCu6z+EvSdGuojNNdD+fpySQrXaF8nzv2YF/VqfmLH4NIEVievp1Vs1L+YdEt+j+xWWKNmmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5AD6OPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6255DC4CEDD;
	Wed, 12 Feb 2025 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327828;
	bh=YaAR5QiuZynmHcyvLV6BKRsvj5JY5bABea9gGeDWeFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5AD6OPj27Wkl3Luv+2FQWbuMklKx+34Rn1CtdQ7zsG0l3BSPFpgbnfhOv049+xE3
	 9IGOPTvYzEW72lzsJFiv4Mkj9ZD4yK2lEADua433cG9lJtFl1MStAzbNaqvdOzvz1U
	 BQWV5tkZeD3kF8BKP1x2l9IjHq0hj4w7zSJWn8hpzebjQdp52kcVYL9Lu6VhhkvRjk
	 juBJIrur3mliULP8YoLOx6fB5NDfc6+BmRUTR9DTHudrkd/6whs+4GtlZRVagu0Tpz
	 n1r/gk1+3jHIg9XDqmtU97wUfq86b0Wm4nyj2scSKQCaiLO463n+M27lcwDEk6W0mN
	 FfonvHT/opiAA==
Date: Tue, 11 Feb 2025 18:37:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, horms@kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open
 list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 3/3] selftests: drv-net: Test queue xsk
 attribute
Message-ID: <20250211183706.5b53ee5e@kernel.org>
In-Reply-To: <Z6vY_LXp3LTp7qWV@mini-arch>
References: <20250210193903.16235-1-jdamato@fastly.com>
	<20250210193903.16235-4-jdamato@fastly.com>
	<13afab27-2066-4912-b8f6-15ee4846e802@redhat.com>
	<Z6uM1IDP9JgvGvev@LQ3V64L9R2>
	<Z6urp3d41nvBoSbG@LQ3V64L9R2>
	<Z6usZlrFJShn67su@mini-arch>
	<Z6vRD0agypHWDGkG@LQ3V64L9R2>
	<Z6vY_LXp3LTp7qWV@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 15:10:52 -0800 Stanislav Fomichev wrote:
> > I can't comment on NIPA because I have no idea how it works. Maybe
> > there is a kernel with some options enabled and other kernels with
> > various options disabled?  
> 
> Sorry, should've been more clear. My suggestion is to add 
> CONFIG_XDP_SOCKETS to tools/testing/selftests/drivers/net/config
> to make your new testcase run in a proper environment with XSKs enabled.

+1 this we need for sure

> > I wonder if that's a separate issue though?
> >
> > In other words: maybe writing the test as I've mentioned above so it
> > works regardless of whether CONFIG_XDP_SOCKETS is set or not is a
> > good idea just on its own?
> > 
> > I'm just not sure if there's some other pattern I should be
> > following other than what I proposed above. I'm hesitant to re-spin
> > until I get feedback on the proposed approach.  
> 
> I'd keep your test as is (fail hard if XSK is not there), but 
> let's see if Paolo/Jakub have any other suggestions.

No strong preference. Stan is right that validating the environment 
is definitely a non-goal for the upstream tests. But if you already
added and tested the checks Joe you can keep them, up to you.

