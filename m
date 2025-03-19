Return-Path: <linux-kselftest+bounces-29439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC01A69402
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811971B64E17
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74A1D5AB9;
	Wed, 19 Mar 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzti4y4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEE1A315A;
	Wed, 19 Mar 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398913; cv=none; b=CR1SwMbzE2oP8v5Wsp1K+Rl8csJkt8IbpyQZO+Og/1Cd8OtSu2rwSNQo7sVfCFXu/9er4LoTPFK9lpqSo8RevtuCjSEwJDz0EKdz8BDpzKPRxciPXDhVA4e8CUsKDEekdQgJuXO/gQuv09xSWG0GBV1yC9T0wC3ifJ/AJFfRE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398913; c=relaxed/simple;
	bh=VYoJuUZomvYANAsVY1qRtnH9bbb0K6385lkRihk4jk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+dqzfzVu8ZdFFGVjhOucUMJvF1FFhm8xmD2KrQa5yrlGYevc/rJOL63ciGA2cnV+PnRh6NhwRaqpg4jXnlH+FIsTRSxedFruPkJpuUA38hUi0xCurf513S4PRy/bbPbSJhRMpzUhbHK5a/DvpMq/SokZ6SPvs9YhYFRqmXObrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzti4y4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF5C4CEE4;
	Wed, 19 Mar 2025 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398913;
	bh=VYoJuUZomvYANAsVY1qRtnH9bbb0K6385lkRihk4jk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzti4y4+JEASnZ5yOYB0W9+BbZd/FpF7bRHjPYbWazRkFwjsqIbt6ewS/xutiO16A
	 y6ftl9+QwF83xXKqh43VndZCK2OFtEuIPPhnCax73mqd1wjgKaVG4x7b1pua7jxUxA
	 Ri3vPxlcUPn1EEn/FygUhlwV9z+yuiWQYEzojGXzTA4XrSTZfMYNYgVeScN7DVwqPG
	 F4NX7s8ULXE0bFrOmXbjjrW1yXTz2zTZ3Jfhh9Yduhab4ZWy8LHRjyjOS3xxar4/kp
	 prDNLhve0S2ckVSk3ClhVC2hpGC4d6KKdJH7UNzTIzYUFPsjNerin17EebE90xBE+W
	 hxmS2AGZ+yzdA==
Date: Wed, 19 Mar 2025 15:41:45 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next 5/6] selftests: netconsole: Add tests for
 'release' feature in sysdata
Message-ID: <20250319154145.GJ768132@kernel.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
 <20250314-netcons_release-v1-5-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-netcons_release-v1-5-07979c4b86af@debian.org>

On Fri, Mar 14, 2025 at 10:58:49AM -0700, Breno Leitao wrote:
> Expands the self-tests to include the 'release' feature in
> sysdata.
> 
> Verifies that enabling the 'release' feature appends the
> correct data and ensures that disabling it functions as expected.
> 
> When enabled, the message should have an item similar to in the
> userdata: `release=$(uname -r)`
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


