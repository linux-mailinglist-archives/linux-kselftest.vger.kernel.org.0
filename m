Return-Path: <linux-kselftest+bounces-21786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469869C4248
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20D51F2635C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288913CFBD;
	Mon, 11 Nov 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDsXTkF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D4C66;
	Mon, 11 Nov 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340874; cv=none; b=Jfszqw35I45luomo68vwicNr+Gpr0no32DuWZ54CYM+mARckmegbZPOeydnGNaoxa2F2rjhxMjdJplj69EOGbAoKEZz777j48JcCsi2e6/fNULl2r/k8FTFLfk7/ZTK+zmMiUuyZE0S9V2DhTW8aQm4RDlzcjSaSvwfyZ1HZWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340874; c=relaxed/simple;
	bh=9n0asBWOcoO7lwV+uq9jbYFvYUrxvms5zO7vjFHGzDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLnrOwv3K+L6FTXowxR1lCgzRPE2JIW3EPpfxDHfl3HSaTEtktBWNig/N5nCzQuEdAo/wHIw6sD2ptsTxU8UgZGNc6RUgRGnDNNef0zNHeIPielykhXNYvYkU85yGoexpM+Jr1n8PjFel3XKTIeOzVmEC7H03ryAiAqpUTjSQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDsXTkF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B0C4CECF;
	Mon, 11 Nov 2024 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731340874;
	bh=9n0asBWOcoO7lwV+uq9jbYFvYUrxvms5zO7vjFHGzDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDsXTkF3QudITamYiv4CNN7n2hHZjw1Gl3nuTLTVgliCq4jT6JccW0z0vkrn+AdIC
	 EXxpSmOp+qjhSfX8GzvhG3qoMvhwqiOOttuG684uJP+WtCtLZGb+e4PcH77WYUMAf0
	 CByxT8N3JiUbJYbU0AhjhbTRTWTUaTiLQ4qsqRVIAKTTYSEVkWo9LONQMadgbqHrOK
	 MwYLej9HHWi13mTAA3TDtLgGGqu4DKp9TFiD/4rKoeWFfr4Syrb5eqNF8WCtMVphTe
	 H9gJ/w/ur52JSjJotn0yiiYE142MEZ+JWdsAWYtiWnZxRfzGN4/X1uiVzIZOKNHuJ7
	 ABSOEhvpco5BA==
Date: Mon, 11 Nov 2024 16:01:10 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: netconsole: selftests: Check if netdevsim
 is available
Message-ID: <20241111160110.GE4507@kernel.org>
References: <20241108-netcon_selftest_deps-v1-1-1789cbf3adcd@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-netcon_selftest_deps-v1-1-1789cbf3adcd@debian.org>

On Fri, Nov 08, 2024 at 06:59:25AM -0800, Breno Leitao wrote:
> The netconsole selftest relies on the availability of the netdevsim module.
> To ensure the test can run correctly, we need to check if the netdevsim
> module is either loaded or built-in before proceeding.
> 
> Update the netconsole selftest to check for the existence of
> the /sys/bus/netdevsim/new_device file before running the test. If the
> file is not found, the test is skipped with an explanation that the
> CONFIG_NETDEVSIM kernel config option may not be enabled.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


