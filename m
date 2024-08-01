Return-Path: <linux-kselftest+bounces-14657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F1944DAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D73EB2363F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656C1A4896;
	Thu,  1 Aug 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkIeY0Ge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E61A488A;
	Thu,  1 Aug 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521262; cv=none; b=aPpVIrSakQgfBWB5Rz0zXkJRuOjy3Mnhf7sChb5HpJA9m2ptR9/Hm5Xw/JsWsyqqLKNNYUrr4VneOd0E136nzVn3qu8F4ayU1R7P6eSEy2KKg9DmEOETmKB+r+mVftWkIKH/W463LpP/7nGfK17H8XPzolb87NHiyZz4faPPD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521262; c=relaxed/simple;
	bh=YX0KgtYQVa5YzigsQeAAQyteVvcaWRSiNqCBfz5+BPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQvrd0RWhtGJEO4r6+u/w4jUkB+R56byEf6NbHFPXvgj6xtICeijDI6FkwyybrcffcVhF88P/emAceSddQ0UNGejqHqwZuB+TlDw4k1d7Vf3D7JaP5GwgfzioBF8qLuTFsc/UGH7Zt0Gj+kbiVyormhlUq7nOIMS58AtYI2sL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkIeY0Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE5C32786;
	Thu,  1 Aug 2024 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722521261;
	bh=YX0KgtYQVa5YzigsQeAAQyteVvcaWRSiNqCBfz5+BPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkIeY0Ge6mBJtUYLXFLSGLvbad8OPzCfNFb+WTpe26AIxANxKgcC468Dli1myUbxq
	 rkac/cGcdFGrvOs+Bzaf6HK/jbRaHtNXyZysRmWo6DxbXaI1QAYbv89Wdf5KdJ414o
	 KSMjLpFPiQxGzXV4zfL3HgCRGliPaxK1caI0/iGPb3QHim5iLgsHyzCOo+iN9FePSh
	 VXLZByBgET9fld/mboN8MhMrBaLPeLzVrNZqFThaWLWKrkVUfS45mzmtp08uVgr+32
	 cEmRSK917S5uniuytQDn/4wvUHLiG6Ji3pXLX1EM+RBxDS8xTUrB31WUxR0leHXLLc
	 eD37J2yHo1+DQ==
Date: Thu, 1 Aug 2024 07:07:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: ksft: support marking
 tests as disruptive
Message-ID: <20240801070740.4ae582df@kernel.org>
In-Reply-To: <87zfpw62hi.fsf@nvidia.com>
References: <20240730223932.3432862-1-sdf@fomichev.me>
	<20240730223932.3432862-2-sdf@fomichev.me>
	<878qxh7mf4.fsf@nvidia.com>
	<Zqqi8LhvSn1MXu9B@mini-arch>
	<87zfpw62hi.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 10:36:18 +0200 Petr Machata wrote:
> You seem to be right about the exit code. This was discussed some time
> ago, that SKIP is considered a sort of a failure. As the person running
> the test you would want to go in and fix whatever configuration issue is
> preventing the test from running. I'm not sure how it works in practice,
> whether people look for skips in the test log explicitly or rely on exit
> codes.
> 
> Maybe Jakub can chime in, since he's the one that cajoled me into
> handling this whole SKIP / XFAIL business properly in bash selftests.

For HW testing there is a lot more variables than just "is there some
tool missing in the VM image". Not sure how well we can do in detecting
HW capabilities and XFAILing without making the tests super long.
And this case itself is not very clear cut. On one hand, you expect 
the test not to run if it's disruptive and executor can't deal with
disruptive - IOW it's an eXpected FAIL. But it is an executor
limitation, the device/driver could have been tested if it wasn't
for the executor, so not entirely dissimilar to a tool missing.

Either way - no strong opinion as of yet, we need someone to actually
continuously run these to get experience :(

