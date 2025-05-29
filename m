Return-Path: <linux-kselftest+bounces-33989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1F8AC7BCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97951C02504
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194B229B1A;
	Thu, 29 May 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGo3F2//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F61F37C5;
	Thu, 29 May 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514746; cv=none; b=X7h7K/UEVMmFzHU8YBK1PIC2xS4+WPnDMNRd5G+ZNz+UjZhOz+IFdQJ1yOYOo1kijg3QQ756+UdgcFhGWqFx0ZldRSuyPjmy+JHtAlceUnYCJna7Wc1SxVe+jSTtfYSyZoHy9yBWsSsxyN1EO7aNuKcDQaks2y6Kg/CYY8usw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514746; c=relaxed/simple;
	bh=vtBZStphILsRCkam3PyG1d8YPdnxbQSuFdSE330h3mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aePNXZOEkHDEyVGJYzSFyotCAPeSUXK+4HEmxEWJHol79q7vhLQWeoBSQsnhTpE1c8WCsFrfOwdcZ6B0j3ot+F0O8siHQC3CaNvZfPGIzl64y3HkoCGIcLpITuuxOcGT4olAT6R7r90z91/R6WkEvMn1JsJLVkbXZZixb00cd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGo3F2//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314F0C4CEE7;
	Thu, 29 May 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514746;
	bh=vtBZStphILsRCkam3PyG1d8YPdnxbQSuFdSE330h3mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGo3F2//RqiQhuur2YO5zpxJkKevrEGql+vzPuBhiqHoWngmKAmatFvI59Vphym3q
	 2ucHoaQrw9zhr+KA8ZRa2pU9VCyCQueL6ASeZj/gyJb96+bVzNfHBBwLaSczw4p7A4
	 iDG9FH0Bp31/hzjHGAwMHeKj0dpEz8RyLBvuEF0IuG4FIdceIWeUzpBWe7ooSMoSkv
	 EPOn6VRofe8t2XTNe04mrVnnUV687G6FtJmgrYuEERB0xNtC8Wee6jJ/fCbTHHp5UM
	 TZrVKHLhFDOTl8KgtAmviRo8rsNXYt+ZDH4EmKHs8kQGsX8X/4tD/ZL59HR6Lf4U6P
	 hcOCsxNbw2/JA==
Date: Thu, 29 May 2025 11:32:21 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Philip Li <philip.li@intel.com>, oliver.sang@intel.com,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: build net/lib dependency in all
 target
Message-ID: <20250529103221.GN1484967@horms.kernel.org>
References: <20250529070536.84491-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529070536.84491-1-minhquangbui99@gmail.com>

On Thu, May 29, 2025 at 02:05:36PM +0700, Bui Quang Minh wrote:
> Currently, we only build net/lib dependency in install target. This
> commit moves that to all target so that net/lib is included in in-tree
> build and run_tests.

Hi,

The above describes what is being done.
I think it would be good to also describe why.

> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

...

