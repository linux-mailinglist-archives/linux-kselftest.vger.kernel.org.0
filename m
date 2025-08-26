Return-Path: <linux-kselftest+bounces-39990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A0EB37161
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C97367AC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BD28D8D1;
	Tue, 26 Aug 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcB1gbYT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9031A569;
	Tue, 26 Aug 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229660; cv=none; b=NpO8pAXsYORstNAyMLYv+FTJYRLrkEr6SMuakV6R7omNrROpmlrjEAZcRSAhn7e0Ecbj91263iYdPLTAyTJkvEQ2tDkP98gl4wRLscWeRL9G6lwd5glcTUczP9MCB9m+XNST0868NEklZ84WWXequDU/uD47PAd6W7hz3Ftzryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229660; c=relaxed/simple;
	bh=BF5va3bL9H0RXQ72gqDVVjz3oJB72gPJ9Rwn68FQIjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojMp47S6ZHKF4uZdWgVntjod04rEOh6pdtbdjH5biKRxXQSTRwcPCgi32ZeRjMLrexytbcvGtA3hL9Wp6Vm4+ILIG5AbExugFPZJyBAsLGwc0C+GycS59NNiI1tZ/BgbtXlm18dCifmuZVCtNOuaJ4H7bP3MvjVmSeAYACeprH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcB1gbYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CD0C4CEF1;
	Tue, 26 Aug 2025 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756229659;
	bh=BF5va3bL9H0RXQ72gqDVVjz3oJB72gPJ9Rwn68FQIjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcB1gbYTXHVKXXad5J58MPjClFNprzobx84QVmyRgOQWxq2IsFrVJhXX+uFQvzf0f
	 vOPcdah708uJmRFASp/hr51jdua3hqIA8oXViZj66RLFCTxGy1pypYvxAxA8pxASbQ
	 zM9lFS0OY/bqh7vi9HBf5r0DrVVLzz9JWu2D5xclKbt9/TDfdLaZoZCMvlp8FsML7U
	 SLMMEVQ2J200bFwpT8S4Wd6HPEod3ENYMw/UX/pmsKsE9C5PzFFaSD2oMNyRsoNpJi
	 wABl06QOkDS82SXiAPWNUQ/lDWL8etHn7riVvdWrnLdsqsBKuikcdIYowIyPHxk1c2
	 jcbeX0ZtoBgAQ==
Date: Tue, 26 Aug 2025 18:34:15 +0100
From: Simon Horman <horms@kernel.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: openvswitch: Fix spelling error in print
 message
Message-ID: <20250826173415.GM5892@horms.kernel.org>
References: <20250814180007.406941-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814180007.406941-1-madhurkumar004@gmail.com>

On Thu, Aug 14, 2025 at 11:30:01PM +0530, Madhur Kumar wrote:
> Fix a typo in a print statement in ovs-dpctl.py:
> "Unkonwn" → "Unknown".

Hi Madhur,

You need to include a Signed-off-by line here.

Please see [1] and [2].

[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
[2] https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

