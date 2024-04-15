Return-Path: <linux-kselftest+bounces-7965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282468A52DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D891C282D12
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8638674C0C;
	Mon, 15 Apr 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daujlsoC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87274BE8;
	Mon, 15 Apr 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190601; cv=none; b=EzLSZgnGh6V08hGpiu91izNMQ90bdKfC56iB/AvnFwIyU1+teErbYOJ8zumtg5uiolsiuLciFvhKAN8ipbRqnsXXbyW7bZM0yZ6PTgLJWuEZhPTwJHvvifO0Cy+wDLjAYQtyytZDW5L+OStd9+52jurYK6UJ/BLpLgRdz2qNrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190601; c=relaxed/simple;
	bh=AeJ3m6898L+idijR3UYOQMzSFryOOqfCPjG6iiSxUAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvkLiBWPHDpWdApTx1MfHqSQ30UXTCvU9Z5tfkUn2fdf+LyPUDiUJeefYRMTm5AoO0w/p70aY1cgjgOWm4XdtTJtVZspPZseNLGrw1egc2DfrzdS5+izJUnC5k8S3WEa9cQtjBWYTN2dvkYQOvDPO6tEGo0dAu+6o701JGz0dsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daujlsoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B30AC113CC;
	Mon, 15 Apr 2024 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713190600;
	bh=AeJ3m6898L+idijR3UYOQMzSFryOOqfCPjG6iiSxUAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=daujlsoCN1J4h3/++vaT3923KATwGcRXjzVlQ0MovGpLv4pIbbEwafFgtJCkqf/Kh
	 wpmo1HeuRf8QvK1kNRMoTAmtASAjW0t3cdqGTDKv2d8Qu2L5LVwsHNL0tciKlfa8q7
	 3Etf7OBBD6PQrWW6NFZCdoym0zHjxAmdIKyA1DB0bdPewoEbZ7MuHBoboDuSJ+JI1E
	 LGH/OJ4sRArdg0bnQuLN8SkAIQ6LhbGDD3KCyLC3FFHFvH1FWbWb1/m51DcFdbsiFn
	 ixCEqoaa/9p8p1ul632t3kMCO08UM8+6VpKJgOlb9ZZznEdXnNBAEaMhMl0CAAUzEg
	 LSQa05vAXmQ8g==
Date: Mon, 15 Apr 2024 07:16:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
Message-ID: <20240415071639.03c9cfd6@kernel.org>
In-Reply-To: <661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
References: <20240412233705.1066444-1-kuba@kernel.org>
	<20240412233705.1066444-2-kuba@kernel.org>
	<661c0cae8110a_3e773229418@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 13:04:46 -0400 Willem de Bruijn wrote:
> 1. Cleaning up remote state in all conditions, including timeout/kill.
> 
>    Some tests require a setup phase before the test, and a matching
>    cleanup phase. If any of the configured state is variable (even
>    just a randomized filepath) this needs to be communicated to the
>    cleanup phase. The remote filepath is handled well here. But if
>    a test needs per-test setup? Say, change MTU or an Ethtool feature.
>    Multiple related tests may want to share a setup/cleanup.
> 
>    Related: some tests may need benefit from a lightweight stateless
>    check phase to detect preconditions before committing to any setup.
>    Again, say an Ethtool feature like rx-gro-hw, or AF_XDP metadata rx.

I think this falls into the "frameworking debate" we were having with
Petr. The consensus seems to be to keep things as simple as possible.
If we see that tests are poorly written and would benefit from extra
structure we should try impose some, but every local custom is
something people will have to learn.

timeout/kill is provided to us already by the kselftest harness.

> 2. Synchronizing peers. Often both peers need to be started at the
>    same time, but then the client may need to wait until the server
>    is listening. Paolo added a nice local script to detect a listening
>    socket with sockstat. Less of a problem with TCP tests than UDP or
>    raw packet tests.

Yes, definitely. We should probably add that with the first test that
needs it.

