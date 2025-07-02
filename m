Return-Path: <linux-kselftest+bounces-36230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA5AF0744
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887444A880A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE4C13D;
	Wed,  2 Jul 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKxTe2fV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537468F5A;
	Wed,  2 Jul 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415834; cv=none; b=Zjvqwtvw7h/0X4Thh9fIkLFq3nlWv24nsA0X92NZqqVf7vxgAKN0Et/O9Tn6JQn+jXsLgRK029nIQmV69DPpSCDvrGMQi1/k3TzApcg4sB54zqKmbejX5U6QWASqtOefaCrc7SGORtkioe/YTN/Q/1zNFC3ZzUkH1zktg2Vduxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415834; c=relaxed/simple;
	bh=yvX7x3EJvRcGIvHF2lTm5r0SKmIF/1zQI08kg/i9BEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8F1IlgHbKIi6L3L1xjmQQZoKDQ4dYURoQn2ADLtb2Zcv4dovr0SgBlJMlMmL+CasR7duWPez+PD+n1jqq4j9IN4YxSA7Le+yjqfTsIg7Qyy8LGnfWr5aMWBS/MkoJUAJLZB2GSakKgVHkcU51NUZvZfu+qjbRuMGIJiG7aV8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKxTe2fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3074C4CEEB;
	Wed,  2 Jul 2025 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415834;
	bh=yvX7x3EJvRcGIvHF2lTm5r0SKmIF/1zQI08kg/i9BEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKxTe2fVWTN2DPnJasnSLLbfq5ZbBCXh3/wCel95rTMT45UBw7AVLFdA8Uy5kvYjd
	 GREKE4zPFnRUquCpUPOYoCc54161ly7nF/GPgpbnb27/vtNWB9lP1LsZ4YD+FCViAy
	 jjOfpyxA0WypFEBMYPBtpE6q4NBgGRuFOKPAENvmpC+d9JhJj379SoClLR6dVNupSX
	 hv72nz6lC15wN6F5qXIJ/2vPYejjCrha6/Jt0XBe45gg4s66AcO0p8MzNZOV7A8YBE
	 tkQQYrRcr+Sy7Vq0gym45bKZnqDd6lUcuqLODnau23vOhbXn4xcgelYdCDD1X0TZpa
	 DxoP6kdGr6XJQ==
Date: Tue, 1 Jul 2025 17:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: Re: [PATCH net] selftests: drv-net: rss_ctx: Add short delay
 between per-context traffic checks
Message-ID: <20250701172352.5dd42418@kernel.org>
In-Reply-To: <20250629111812.644282-1-noren@nvidia.com>
References: <20250629111812.644282-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 14:18:12 +0300 Nimrod Oren wrote:
> A few packets may still be sent and received during the termination of
> the iperf processes. These late packets cause failures when they arrive
> on queues expected to be empty.
> 
> Add a one second delay between repeated _send_traffic_check() calls in
> rss_ctx tests to ensure such packets are processed before the next
> traffic checks are performed.

Sprinklings sleeps should be last resort. Is there a way to wait for
iperf to shut down cleanly, or wait for the socket to be closed fully?
Like wait_port_listen() ?

