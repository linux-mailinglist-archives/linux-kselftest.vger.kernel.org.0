Return-Path: <linux-kselftest+bounces-9984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702A8C1D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 05:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B155B2837F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 03:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DC1494DE;
	Fri, 10 May 2024 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB4I2uNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AC171A7;
	Fri, 10 May 2024 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312850; cv=none; b=WX3izbLXW6sZTQpThqjNz8hGMVeQUZws8AkIeUW3AMehS2N2oLJXR39O0SqTu12FOkfxQAVVoFchehc7ckkjPOSIiJWk4Ob8CdK/OVbRxK+c1ngSM/B4oYJtPUTpsCXHmHgGYCIxCovTAqJ1EEMpgNkvgOCECH5GsZb3yz+sDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312850; c=relaxed/simple;
	bh=2L5moJV7GTghp41BDZNw8hy3pqlre0SnpvrA583Cpns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L32xVO8CJzqWpJ8EVFZxfAvbKX3yf6t0mXYDoxcCqumbmJJgqScFKRFTm7laiBWKtvpeZ0gA90g94bcvYg9NXb0IHm1q5nlm4BxRHOC3IiG2DeeYyTbKnmyL1N75GSYy6lyxxDJBxY3ATTT3W1qeVNKqMFUT6gWKnw4BtmIAQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB4I2uNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D28CC113CC;
	Fri, 10 May 2024 03:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312850;
	bh=2L5moJV7GTghp41BDZNw8hy3pqlre0SnpvrA583Cpns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZB4I2uNz/7WMsvnC4SJepauSbR3r/aBQgWVsrLHpPCbGf5W4S+SIoqCKJGPzXJ8JI
	 E2Q8lCQGVBfk9GNfMyH4qF/bFm69QINR/b8FGuXc5TGGPryr121mAjNsOUB1ga5lcK
	 yqlnnPrDtY6GJxF4WzmD/DOP3emvsVgcvJTHCDI0nhLAOpe3uZn2tMvhxJFZCNdSHL
	 VJNaduQ3XAcWCyVUF9xqFQWXXS0Qhbu4dMUDXqVw6KEOaTJVxQk5GNy6dRws5exKOs
	 rdlEJe9qVcMnltxrGsm6vcpzPudeKJ6pXD7xG3LzYhPsymxr5QZYdEb+ywbblJoKW0
	 trUzcdpsNn4sA==
Date: Thu, 9 May 2024 20:47:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, vladimir.oltean@nxp.com, shuah@kernel.org,
 petrm@nvidia.com, bpoirier@nvidia.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate
 the expected failures
Message-ID: <20240509204728.5326bf6a@kernel.org>
In-Reply-To: <Zj2RbpO6tu7Sq8za@Laptop-X1>
References: <20240509235553.5740-1-kuba@kernel.org>
	<Zj2RbpO6tu7Sq8za@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 11:15:58 +0800 Hangbin Liu wrote:
> I may missed something, I saw there is already a log_test_xfail() in lib.sh
> 
> log_test_skip()
> {
>         RET=$ksft_skip retmsg= log_test "$@"
> }
> 
> log_test_xfail()
> {
>         RET=$ksft_xfail retmsg= log_test "$@"
> }
> 
> log_info()
> {
> ...
> }
> 
> Added by a923af1ceee7 ("selftests: forwarding: Convert log_test() to recognize RET values")

Good catch, sorry. Must have had net checked out when I wrote it :(

