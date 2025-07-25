Return-Path: <linux-kselftest+bounces-37965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9540B115D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 03:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BF8169469
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9D1DE2B5;
	Fri, 25 Jul 2025 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij5daOub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C443ABC;
	Fri, 25 Jul 2025 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406669; cv=none; b=idX0+hwR+691JPOe+JBrwIeIQjjEO9lYetNQQoYK0F1lhmby4D7CHyMVuR7UaC9Mn9lSLgrjqlMTR1TRS2koIEuBsw70Jc/RLFUXlNj7HjREnRSTokFlRg1PgSkPBPWI3k29jAGSdQ2UQJS8MIzXJY7oCSuBWAzcUZwGHLL3Qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406669; c=relaxed/simple;
	bh=T8LNO5AvnTSpaz3oGEJtdNfb4yIxbJpcEuBH2EQ7wjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd9mfBBL00eAgQv+ct+727cqvRXbBgNY8J4CbHG3K8JGYHtE+yCcv4QvJZWnrJd7rYDR/sAXGqAvhApRLDaSnogaY7w90d1cDLNl9mgaPpcFXNsCDRaykYogaA3rSuxs9BLsqXCQPC3YP0GHZbK1fwosCHYciPJLxqhz6EuuOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij5daOub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CBC4CEED;
	Fri, 25 Jul 2025 01:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753406669;
	bh=T8LNO5AvnTSpaz3oGEJtdNfb4yIxbJpcEuBH2EQ7wjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ij5daOubh+CB/TjrNPq/7PRGY4Nl8LWtEbyQ3Z1yzNT2AtCSdsEt3MzVPDGPCXt9J
	 OdU0rJygETVxmtyHGLzsJzDsDesUsJT9Kc0fB72JCwmw0W6iqDb6xL+kf2Z2KxmX1P
	 IFti47mr/7w37CXb241VnmyM0d3ngSSyNbKzr2/hLgDXxaDFesa0SopeDvteCWjIfE
	 fuIth4ECFuCUcmL7Hzz4ncCt9xxzEA10EUC59mR+y4VCwaBIeCEQFTKLfVbOn0xcwW
	 O3SoQy1CTrF8KFIuEhUvPpidqA6Oxf/hjH8v9uHN02/bQzYpP/2WwoKHMW8or+ttaP
	 oH53OsVUL9xVA==
Date: Thu, 24 Jul 2025 18:24:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Message-ID: <20250724182427.5ece92e8@kernel.org>
In-Reply-To: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:35:06 -0700 Breno Leitao wrote:
> Extend the `check_for_dependencies()` function in `lib_netcons.sh` to check
> whether IPv6 is enabled by verifying the existence of
> `/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconsole
> tests. If the file does not exist, the script will skip the test with an
> appropriate message suggesting to verify if `CONFIG_IPV6` is enabled.
> 
> This prevents the test to misbehave if IPv6 is not configured.

IDK. I think this is related to some of the recent patches?
The context would be helpful in the commit message.
Otherwise, as networking people, I think we are obligated 
to respond with hostility to "IPv6 may not be enabled"..
-- 
pw-bot: cr

