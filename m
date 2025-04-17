Return-Path: <linux-kselftest+bounces-31073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E5A92310
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48485A568B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81825485C;
	Thu, 17 Apr 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOKQktra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966917A30E;
	Thu, 17 Apr 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908793; cv=none; b=X9nsPTsl4Ct1Sy8H4iwpE3exhxvhpzFNpf8YlIFc+yEj1LT3Rp/Eis1NX/EYS1dzg9Syvk/Li4W7/i3EF912DsO6lYmI91e3SAhcrgYj5OfrbqAzxPLVpPwh5D5LCH23s9ZfPauFTsF+cNX/eBc5249qyAtrNRzhtf6eGYdAvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908793; c=relaxed/simple;
	bh=FnrDTiqP5GOEuFNV3L4kIiqs3E1hpChvor2OYtPnF2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHOCUyGMF1rAePBbrMgUGxbb6mEklUowCohQPPWLNStY1rEm9ojKvBZ+kk4Dxu4Rv/v20OxqZT3+f7IsVmeKwheovHYgnqGbdT6E3hLAAqdheSDSezNwew9sIIsUtRqdj4ipXcIXWjTJXmRjnbc7tXL51qO3OZDlu1viMQ4SAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOKQktra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA960C4CEE4;
	Thu, 17 Apr 2025 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744908792;
	bh=FnrDTiqP5GOEuFNV3L4kIiqs3E1hpChvor2OYtPnF2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOKQktra7AcQm05bcaJQ+N+NmnvZJCk7xy2FNdprIonBstTYNOiMWzqeaeeKA1GM3
	 gX+zwJDw28bVl4wtyv5Sdg82W5oyGBbYOQRuu4mSsv/6Ujbe6adwtgP2nbQTZZyj5b
	 lQtE30S+QofXTBkjKo2r7E5PmCAjEza96PQN42mUTSjpdRikl9L1RLY6wj/xxDYddj
	 CSPKRx7EmY2sEQSrmxFMGbbeTFjv9tZaExPNNggNNqKp4GHJ7zrZWQF8CXZGXuAdC+
	 t6qMzaF2atxCHOjwSs3h5DWDUCnTy23Owxr6EUpkgApBKxcNtdhf9xlYm00scP9Xl1
	 vKpl5j0yg+ZqA==
Date: Thu, 17 Apr 2025 09:53:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open
 list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID
 is non-zero
Message-ID: <20250417095310.1adbcbc8@kernel.org>
In-Reply-To: <aAEvq_oLLzboJeIB@LQ3V64L9R2>
References: <20250417013301.39228-1-jdamato@fastly.com>
	<20250417013301.39228-5-jdamato@fastly.com>
	<20250417064615.10aba96b@kernel.org>
	<aAEvq_oLLzboJeIB@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 09:43:23 -0700 Joe Damato wrote:
> I think the main outstanding thing is Paolo's feedback which maybe
> (?) is due to a Python version difference? If you have any guidance
> on how to proceed on that, I'd appreciate it [1].

yes, it's a Python version, I made the same mistake in the past.
Older Pythons terminate an fstring too early.
Just switch from ' to " inside the fstring, like you would in bash
if you wanted to quote a quote character. The two are functionally
equivalent.

