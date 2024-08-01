Return-Path: <linux-kselftest+bounces-14667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59594511F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1904B1C245C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156081B3F25;
	Thu,  1 Aug 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHmueRdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19131B374E;
	Thu,  1 Aug 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531204; cv=none; b=LkwutekOLcQpX/pgydly9Y2alYvw7iRb0rZ6j87yVDs+JNGwwFkkS3sdUsQ/I5QqqpfkCNjT613UPOgv/8dM2deHMhYNvHkdqF9SF+fed+cb8EDSqad83Mz4chNAARI2oLdbNxKU/kWHEZvCCB+8yChnMk4qzieRwTvoSFYC+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531204; c=relaxed/simple;
	bh=1ss2wVjTFPPXETnvk+EhTKM7LAhw3I+hKkedtEmd0nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mruOdpesX3sbVP4Qs3LKJQRLj2ZuqUxXbCYGqSmkprYUu2y6NLAQjKkKm/A0rX/stCwYtf17hYkvhBcn5fJSotU+xP+lXIMJArE3W1bjUXFfxbqaTxg+e1NOwqFdo8wL1C5yuF2jHN0Qa7Pt8x5MVEbM/OvgoTnJEiMXYBUmZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHmueRdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28692C32786;
	Thu,  1 Aug 2024 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722531203;
	bh=1ss2wVjTFPPXETnvk+EhTKM7LAhw3I+hKkedtEmd0nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHmueRdv6Dj6D6c5n+5OxpgIs2mQjqFDXIUaKANRQ2XSP5GePJVutgQDBuS19C90y
	 1DZcIB5RHOTR6p7ZpOMUMc6H6UuBul2G0uxV6fYhwwD5NhA45vWCAk/cXSvX/+b45X
	 STOAcdYkCqdRfOjP4wsKHiaGH83MM+s/8qv8z6V2yMISWbDfDtyHb9MsO2bF7KHKHr
	 wGqQdrVUvn2Tfvi/Nv760KQkpebwvXOe2NR2lzbDRgvvaSPVZCRJmmLF/UJO51vnb2
	 rY1rTGX0tQ8wbkCdeC0uc/jkoNzNOOA5EfqFWqlsrkfHos7hDOl9Luo82QZvDlxG66
	 njNBOUII+/L+Q==
Date: Thu, 1 Aug 2024 09:53:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Shuah Khan
 <shuah@kernel.org>, thevlad@fb.com, thepacketgeek@gmail.com,
 riel@surriel.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, davej@codemonkey.org.uk,
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: Re: [PATCH net-next 1/6] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <20240801095322.6d9dec9c@kernel.org>
In-Reply-To: <20240801161213.2707132-2-leitao@debian.org>
References: <20240801161213.2707132-1-leitao@debian.org>
	<20240801161213.2707132-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 09:11:58 -0700 Breno Leitao wrote:
>  .../net/netconsole/basic_integration_test.sh  | 153 ++++++++++++++++++

It needs to be included in a Makefile
If we only have one script I'd put it directly in .../net/, 
or drivers/netdevsim/? each target should technically have
a Kconfig, Makefile, settings, no point for a single script.

