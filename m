Return-Path: <linux-kselftest+bounces-3871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF95844724
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71681F25C88
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521E131E5A;
	Wed, 31 Jan 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgD6dl2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0B12FF7C;
	Wed, 31 Jan 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725777; cv=none; b=IzYczyU6vwIlT6pJqO5mR3FaOIF8FW3tG7dS0wwclSc4LsCt9ifvXyXvXFu3dEzvRGp1Iih0xuOcRaAFoSIaawU8AgWiHqsiGsg00q/Hs1AEuu8JVKnhkHnX0Rmcj2VobIays+gvm23G4IHfUga8D8O89DHeOxuddepwenmqhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725777; c=relaxed/simple;
	bh=jqQX/UgTogu7KiUnstYHSz/k8BttGHPXLVteXEvXCpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yi1kzJtEGBt4icj4BbuoKgPgcrMW0dVxVDZrt/vMXDlchhWs8UjokDvUNUShoHXROFLzo/KN9O3b362QGz2yiTnjoNvaFvT2FC0KGIZyPuL3MCEYPRQzbMkk1ZiqfcIbmFY+pbVTQV2f+2UIah1mi5A7ghdnm7HVtsiaNP7PiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgD6dl2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855A6C433F1;
	Wed, 31 Jan 2024 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706725777;
	bh=jqQX/UgTogu7KiUnstYHSz/k8BttGHPXLVteXEvXCpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MgD6dl2uqGq65BlRgZgFSuqpk2JkztKm0mJM4rglpfZ7MOhqVd+XOsfv0E9nPoncE
	 CtsKKCDZxRBF/4LPRq/my45yLNbKjN3zr9g+INaDpxI8zJJsLL53e+F8KTlbobjqPz
	 hvHrJOh91Osb28tsJzBvybul30x9iA8voCA46FmTZD21vTYE7y0tJ8ATsEy1Nj89gf
	 Fw+pSHdruNOF5Rf8M/Mqd4FhcTmkzDOGDhgM13LH/ZsPVHOP3tH+L1IFB4GpogXFSC
	 x9PvUljeKi3nc+K9s6VWK33PAEup6EwOwyzaofQAbunkKaRgyjRppWKNEQkjxApGP+
	 Nxy3Jn08VJ6vA==
Date: Wed, 31 Jan 2024 10:29:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, pabeni@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests/net: calibrate txtimestamp
Message-ID: <20240131102932.6caac1e2@kernel.org>
In-Reply-To: <65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
References: <20240127023212.3746239-1-willemdebruijn.kernel@gmail.com>
	<20240130174736.03c79071@kernel.org>
	<65ba61ea978b4_1699fd294eb@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:06:18 -0500 Willem de Bruijn wrote:
> > Willem, do you still want us to apply this as is or should we do 
> > the 10x only if [ x$KSFT_MACHINE_SLOW != x ] ?  
> 
> If the test passes on all platforms with this change, I think that's
> still preferable.
> 
> The only downside is that it will take 10x runtime. But that will
> continue on debug and virtualized builds anyway.
> 
> On the upside, the awesome dash does indicate that it passes as is on
> non-debug metal instances:
> 
> https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh
> 
> Let me know if you want me to use this as a testcase for
> $KSFT_MACHINE_SLOW.

Ah, all good, I thought your increasing the acceptance criteria.

> Otherwise I'll start with the gro and so-txtime tests. They may not
> be so easily calibrated. As we cannot control the gro timeout, nor
> the FQ max horizon.

Paolo also mentioned working on GRO, maybe we need a spreadsheet
for people to "reserve" broken tests to avoid duplicating work? :S

> In such cases we can use the environment variable to either skip the
> test entirely or --my preference-- run it to get code coverage, but
> suppress a failure if due to timing (only). Sounds good?

+1 I also think we should run and ignore failure. I was wondering if we
can swap FAIL for XFAIL in those cases:

tools/testing/selftests/kselftest.h
#define KSFT_XFAIL 2

Documentation/dev-tools/ktap.rst
- "XFAIL", which indicates that a test is expected to fail. This
  is similar to "TODO", above, and is used by some kselftest tests.

IDK if that's a stretch or not. Or we can just return PASS with 
a comment?

