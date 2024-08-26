Return-Path: <linux-kselftest+bounces-16339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9E95FBDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 23:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1739A2829C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864919B3C7;
	Mon, 26 Aug 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzLzlyqm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4919ADA2;
	Mon, 26 Aug 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708424; cv=none; b=oG2YVPNkalw5WoU9YyTkc0vbpQBGdscmbwhUXikukzN/tQsCGf7rFOpWbKsN5bUgkVqEYC/1/6knj6ELv4EkCsWzAM5PX1p0bgQr9tG3q6sPjsKxJpzXHu90PFaFNGXREaVwAorbh5w1eXAhM1N9+NANuawXTdHDxcLYE98tkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708424; c=relaxed/simple;
	bh=yKbfpeVIrH22+VzEAgcjh8eEG0gIjmSrqdaFBjSFwf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orsc0rNDPWRTZY6yOkzzrxL0Ve63vfVs1TUa0oTERWscIsqaex7ypuLKtXlAkK1dnxvG1qoAA1iEe4WsSJv1D5YJTsGeuZNQDwzcK1/TxSmgCjfHIMUcdDAFayXxFM9v0eyE6DrBissir3VpN7laYoi3I1ZigqtDtA5mOGkhxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzLzlyqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1EAC8B7B7;
	Mon, 26 Aug 2024 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708424;
	bh=yKbfpeVIrH22+VzEAgcjh8eEG0gIjmSrqdaFBjSFwf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzLzlyqm+jDjrvh7Lc/YnI+YnJW+2bR9Yr2pn46o8qzbQuM8bGMZ08HFijLFUMGzx
	 8S/YL02KkLFgUN9jvSpM53NuscHG5c0Hc98A9aiLWi4Wcw+KOHQdA2pNWLJMzsMd6K
	 ZiuMdnUDphH9kGsVG1hzCfjdoyObbE58UWpxo7KYto1fWIJaFLBNzb0ekZoR1gEieb
	 zr1RwiuTexXkrnD2aWgaHFUl2UgQ/GRR3PDQNSSnH4wM8X1P8yALZ+XHKc4QVtCz3j
	 YWxPGs+0n3zAz8JK3Te2XYr1NhSfrxrnCrLyp75chp0xlYLDSYik7Mpj1lSxsJ370O
	 BFiDZ8KRX7YYg==
Date: Mon, 26 Aug 2024 14:40:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
Subject: Re: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell
 script
Message-ID: <20240826144022.72a80d8c@kernel.org>
In-Reply-To: <20240824143837.228874-1-david.hunter.linux@gmail.com>
References: <20240823190828.214443-1-david.hunter.linux@gmail.com>
	<20240824143837.228874-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 10:38:37 -0400 David Hunter wrote:
> Subject: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell script

no need to capitalize Selftests

> Turn on the execution bit for the shell script file. The test is skipped
> when downloaded from the linux_mainline source files.

Change makes sense but I don't understand the commit message.
What is linux_mainline and how does one download from it?
I see an Arch package with similar name is that what you mean?

BTW ignore the pw-bot it gets confused by mode changes
-- 
pw-bot: cr

