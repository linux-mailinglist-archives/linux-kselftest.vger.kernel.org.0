Return-Path: <linux-kselftest+bounces-42600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C39FBAA673
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 21:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE538177F9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E5122FDFF;
	Mon, 29 Sep 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8All/fI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADACDF6C;
	Mon, 29 Sep 2025 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172679; cv=none; b=ZNES3lIPtpIoEJPtPsV+6N5dkUpGErhrigdIAw6T4OSOlNrZaBpy4aCZcSRcg+nmGLF9TTwc0o+Q2sGFju7KFDkxCWk3v/j2PE9O9A1iO+MmyiywNQF1O6EmyASdAFKZkYL+94gvk1kUVFdGBTTsGifVSCUMXITPfB85U1xy6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172679; c=relaxed/simple;
	bh=qCJ8wA/pIJzOSjjkfs6DawqqEI09XjRR6If8AcAlD24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUeaBKemmxkZqTsS8/Rq1/G9zrAxyqceQKMeAIAmqvdmBFWxVNGY+1O/kmRgu+UmpuAZq+21D7rpe0C278cgLjmo2trfxW6KUnbn1QXPdqJc4LW+eQDBzhpaa8w6DyeeFKa4Lyh9A5yCP4z2dPxmkI0vtbEfFpjFgx1F2uoLKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8All/fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4F0C4CEF4;
	Mon, 29 Sep 2025 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172678;
	bh=qCJ8wA/pIJzOSjjkfs6DawqqEI09XjRR6If8AcAlD24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8All/fIbvEBkdZPCmgSJsO0qHTseRmw0DxaQBimtqXlHvcI9lTj2dJac996592c3
	 aZWZPA4IzHQtoHMgsQz+z109oVufT1h/IBygXUxjslerQZOpvVM/3p4H3cfhFyO3kW
	 R64s7tvxJrA0Y+5kVquyE3FNsEETrLwc49htU2fzWy9pTulT+Yu34Mz7hs0+wgU2kD
	 XcjnNZgbH3cl7HMtSKFCJRO4ZsUdbCROwaIze8qUvTK8WnWzZvaFaFcZcRUbH7VOje
	 Z6HtMItHUZhpvdKwkEx77mgwbJmeMkJ1CQ3uZSs6xqD39790zCBvazhKmIC2f7kVV0
	 erBlF93FLOUPg==
Date: Mon, 29 Sep 2025 12:04:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, willemb@google.com, shuah@kernel.org,
 daniel.zahka@gmail.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/8] psp: add a kselftest suite and
 netdevsim implementation
Message-ID: <20250929120437.3eb28d75@kernel.org>
In-Reply-To: <willemdebruijn.kernel.2e2661b9a8ae9@gmail.com>
References: <20250927225420.1443468-1-kuba@kernel.org>
	<willemdebruijn.kernel.2e2661b9a8ae9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 12:00:15 -0400 Willem de Bruijn wrote:
> I'll leave a few minor comments inline, but nothing that really needs
> a respin and/or cannot be a minor fixup later.

I'd obviously prefer to have the tests merged in the same release 
as the code. And there's no time to respin since net-next closed. 
I'll defer to Paolo's impartial judgment :)

