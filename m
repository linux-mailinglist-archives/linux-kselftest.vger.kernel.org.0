Return-Path: <linux-kselftest+bounces-34578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC5AD3897
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190DB1E05CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399C28D8EE;
	Tue, 10 Jun 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzuqle3K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48222D4D1;
	Tue, 10 Jun 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560581; cv=none; b=SDtkKF/mmcX8/n6DSntTT8gf/2Ka1j5IOk+NvcNAieiXKyUeBxaeL3hYcflt8pZH9oTUXs8URKRdeq1gNoH1sK/T9He1s4DiYNPGYpUQQcmuLTjP8x3ClgOLmD2P2eL8PoHo2joR8XfVeTG4gHX2XGe3srB0xm/6+pcPcYPcN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560581; c=relaxed/simple;
	bh=JpBzempB8amvFKFVlCUmuYC1NIzkDNtNbps8F+olw3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tG2rX7nmf+lih9XOJuwnEKtzKBC7DUNVVIjjNS7Ka+FnOrGClqwkRvBeRnG2r2xZpVdsoFX02WXSG5uYMltTItAXYHhKduXLRSk0RMCzi0ySPefdyKVS0vkQQcwH2cALyCy1kGKTMFN4xlQ0NbrKSwIT6XGKsBRHrp/Rjz2Cqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzuqle3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA92C4CEED;
	Tue, 10 Jun 2025 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749560581;
	bh=JpBzempB8amvFKFVlCUmuYC1NIzkDNtNbps8F+olw3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzuqle3K2Zgo2WzvyOt++C0dkbUQSgoq5QZS3Q1s0Kr66eVNZZJXhTvu8UsH2Nl3J
	 xFcBdLX8Fm8d3Jf8blc4xt5bK2DCrWsCoAB8+q9HzfJlGaGOX4MH8p9B6F2x53JOsn
	 BPIZFqSBbAtZrQZdm0W9EchUoH+WKGFORACdY69cb+ywntEJI3mu87EKHlm+A6mNra
	 XZ96Ggxqs7X/YcnPrmwFaLs0r10C6ktdUx+VRHGtNU3v2VNqa/VFygT6J1l8XEBH39
	 7ukw0QoA6lGkWOUX6wE5fb1QbrModr83OELHqBxud5j7gZCZ9/QUD2JdGDw6e4Ag4k
	 J+GKfuLai7Cbg==
Date: Tue, 10 Jun 2025 06:02:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Message-ID: <20250610060259.00a17ce8@kernel.org>
In-Reply-To: <d47a5edc84638eb27e2f57655a619b06051fa7ae.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
	<d47a5edc84638eb27e2f57655a619b06051fa7ae.1749499963.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 22:50:30 +0200 Petr Machata wrote:
> Add tests for MC-routing underlay VXLAN traffic.

nit: we started using shellcheck, may be worth addressing the
warning-level complaints?

