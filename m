Return-Path: <linux-kselftest+bounces-21778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1239C3E42
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B541282C73
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB6C18CC0B;
	Mon, 11 Nov 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXOSXs+b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC514B946;
	Mon, 11 Nov 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327337; cv=none; b=spYXUWavnUoofPZKun5WD9JqkVWFyvZDfkM8+CywyF8IT2aLu8HZprHs3b+yLaqRLjlr0cow/8AcHwEYA9TT8fGa0L+H5EIlyIZi3VrCEECKaChYLDOnW4j382u7Uhrhpm1bJiuZpsjHsIX6bFxkKmy314IWhjEEbAcplm7JLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327337; c=relaxed/simple;
	bh=MqWP9KD8S95In9kdbT+YZQxosASpNaxOgKThXgUXLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsUMvWufjdIoR9NwCjat2Tr8APgv4eIN/c0YI0+92Lf6WzuVldCm6ok72WplOqumRE2+uSM7A9ZPVJEHACj+whg30azurWLxcBQIfbSp52+nq3GG3oaohkJDI7pUC7VzgWrKkYaCR/79s1oc0dZIpKfYPZ85t5MVPKogpG+QA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXOSXs+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152ACC4CECF;
	Mon, 11 Nov 2024 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327336;
	bh=MqWP9KD8S95In9kdbT+YZQxosASpNaxOgKThXgUXLZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXOSXs+bJy2TgxG83s3FDI/LYpOiIw4PJ+r9UbYoo6yhuwDaMEvaPUKLtecYGuP28
	 bRypstqsKZewqSOmqtC1Wn9ds/1IypCnU4DoaKAA6mIrxpmyqKtzxHEdDkTM8Aales
	 /NQBIJ2PPYozMiSHFFV2W/B+4wCScyTHhwAZZ0ppHSKNY8SB373F49wIlYLEa07pLF
	 RakxksDEiRSJQzL66Y3ng6xMU4LhNHVI33fowkV/gnGi0ZGpjbesLFB4OIOHpHrrTM
	 YBi7OePLZMy2GxSyuxyMgPkajwV8vWA01hyMLRQ7ZC6C5LVYhWUbUFhoT+z/3qncdD
	 OHzZIXA8rs8PQ==
Date: Mon, 11 Nov 2024 12:15:32 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] selftests: netdevsim: add a test checking
 ethtool features
Message-ID: <20241111121532.GV4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <fff58fa70f8a300440958b5020f6a4eb2e9dad61.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff58fa70f8a300440958b5020f6a4eb2e9dad61.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:28AM +0100, Sabrina Dubroca wrote:
> Add a test checking that some features are active by default and
> changeable.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


