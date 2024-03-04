Return-Path: <linux-kselftest+bounces-5852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD3870AAA
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9981F2325E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839A79943;
	Mon,  4 Mar 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KkCD7tgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C946216C
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580493; cv=none; b=Aw59EOgUhvx4XXZ3rUEPtEF/k/Bsh3UKLVN3LnCwcvRXHAzjqy9Ad4omBwY9uKdT2kFifvsN7zzZTBPkHr6c7PVvXlbpeoo1QnlbPAizWKtaNuElmvR/KYoVewt5Ec9zxuxgtrh/Q/9gPrXjHMwoiKa/3Dkvba3saPiEdoUPp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580493; c=relaxed/simple;
	bh=vccNteWZN8tzKrezbLNFg7i1Zez+MHEl2AkooCa/4k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tszOa/h7yK3boD7nyG8j1VqK/kREx8x6dE1XVUdxyipGkBsEvCF7gqcnYXyvLBA+JpAFG78DB59yOaYaz/IyRtILzjMT87u2H/4Pw0rGUqoei5EriGo1AuvSdAwzBE5BgUqi08n2bsbEzIkZ9jFxtxnEh6Fzrq/nnqWA9xye1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KkCD7tgF; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpTHh0nN7zMysHl;
	Mon,  4 Mar 2024 20:28:00 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TpTHg0gS3zb2j;
	Mon,  4 Mar 2024 20:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709580480;
	bh=vccNteWZN8tzKrezbLNFg7i1Zez+MHEl2AkooCa/4k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkCD7tgFNxUA3IFBIhedZOHdArtcSmOKaOTxpUn4FuBn+dNJX81hqroINKaTebfsJ
	 Chs/nU4dB/LrWL9athFmwfk/7g4MUzJjl00V9QvqtnND4FgWqYrtjbXStHzvpmgPi0
	 MAEV2O74g1vmmGhp09sUUH5qSkl/fpXuAmm/Ne9g=
Date: Mon, 4 Mar 2024 20:27:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, jakub@cloudflare.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 02/12] selftests/harness: Merge TEST_F_FORK() into
 TEST_F()
Message-ID: <20240301.Miem9Kei4eev@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229005920.2407409-3-kuba@kernel.org>
X-Infomaniak-Routing: alpha

Testing the whole series, I found that some Landlock tests are flaky
starting with this patch.  I tried to not use the longjmp in the
grandchild but it didn't change.  I suspect missing volatiles but I
didn't find the faulty one(s) yet. :/
I'll continue investigating tomorrow but help would be much appreciated!


On Wed, Feb 28, 2024 at 04:59:09PM -0800, Jakub Kicinski wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> Replace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> brings four related changes:
> 
> Run TEST_F()'s tests in a grandchild process to make it possible to
> drop privileges and delegate teardown to the parent.
> 
> Compared to TEST_F_FORK(), simplify handling of the test grandchild
> process thanks to vfork(2), and makes it generic (e.g. no explicit
> conversion between exit code and _metadata).
> 
> Compared to TEST_F_FORK(), run teardown even when tests failed with an
> assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> for ASSERT failures").
> 
> Simplify the test harness code by removing the no_print and step fields
> which are not used.  I added this feature just after I made
> kselftest_harness.h more broadly available but this step counter
> remained even though it wasn't needed after all. See commit 369130b63178
> ("selftests: Enhance kselftest_harness.h to print which assert failed").
> 
> Replace spaces with tabs in one line of __TEST_F_IMPL().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> v4:
>  - GAND -> GRAND
>  - init child to 1, otherwise assert in setup triggers a longjmp
>    which in turn reads child without it ever getting initialized
>    (or being 0, i.e. we mistakenly assume we're in the grandchild)

Good catch!

