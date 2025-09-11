Return-Path: <linux-kselftest+bounces-41256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D977B53999
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 18:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9DFAA1579
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB6A31329F;
	Thu, 11 Sep 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7tuczm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0721DD525;
	Thu, 11 Sep 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609347; cv=none; b=IQ+E4V94CuvRVAZVR3uBxUt8iKJLMd+dUY8EDEixxR86cDLLRK+11PxDI4SF169w1wdwuYFRLdcmpscqKpUlJ0iRjO+xQ6UmMitd/0WRFEpdlAAzAJlJNIS7ZZZy9JUC9DO8nFGc+gv8B+H2U2tEdN4+Yk2AW3PdpFCLMlGNjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609347; c=relaxed/simple;
	bh=Q1uHQmxAk66/ZAaxdRDpPqN1BaLmGqSSyv09DI0J98k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQezWoZwrfFV/iSeNtKy+p6cFom9FxOHgqXgWVznzaK1eLlA61sylY/GUhV80j9Yzx5dH+7V+ulVsNgSPPxSN/a+xiQ+nyICdteLGHn+unmuy067c6g/3l15i06VPd2VwMQ0TS4s0ap1wLPAZi4vAygns4UQ1/VFUE+2sD87vvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7tuczm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19233C4CEF9;
	Thu, 11 Sep 2025 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757609346;
	bh=Q1uHQmxAk66/ZAaxdRDpPqN1BaLmGqSSyv09DI0J98k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7tuczm8V70F2KH/6PZihaaSlG3roAjrclY6+Y6cBgt437WUozeQQB0H2/5GrEKGI
	 MkbwH9Z8esQrC1NEA5jJZQJu9KXuQa7+IEZcbrK1AmKqMhH6XnC8KZaPdTvkFS23n+
	 VAFvzPSwdPC5xnxV6wj6Oc9rbr3NTLDxrznK+8v/93FblGPmdEHp1T4KUdIlsGw9GT
	 ao6C35dS7ugdCEN5AOB4Q4SAF4ESQ0PhQIE2bz9oK6WHZF0Y5rsKww5cGHR5enMtpG
	 F2ICoR1JVEUyf9ou/8wNOEqMQspWNoys8WI57S2+ao5aNOeKvb6fyia5m8qu7v3KOG
	 SCMzCayegJD7Q==
Date: Thu, 11 Sep 2025 17:49:03 +0100
From: Simon Horman <horms@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: Disable dad for ipv6 in
 fcnal-test.sh
Message-ID: <20250911164903.GM30363@horms.kernel.org>
References: <20250910025828.38900-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910025828.38900-1-dsahern@kernel.org>

On Tue, Sep 09, 2025 at 08:58:27PM -0600, David Ahern wrote:
> Constrained test environment; duplicate address detection is not needed
> and causes races so disable it.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


