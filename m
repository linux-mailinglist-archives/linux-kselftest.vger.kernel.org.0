Return-Path: <linux-kselftest+bounces-27469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4333BA44428
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E593A61BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB9267721;
	Tue, 25 Feb 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7B6Eubm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937A21ABA8;
	Tue, 25 Feb 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496675; cv=none; b=NgTIsOZ+5Qy9IijW831feW+5jmAK3wtl1Ri24FP1ofMgnR+SV8/lEqFHLLPO3Wa6TcgHnXZ/+7VX4qhkj5dgVzwQWG11SVkPpSDCAr5ujlSfmkJn+TA2cBF1rX54xaVRie0N8AMevA6uqXWBmT2gSAk3r6s3r5NYTnMrAOJLWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496675; c=relaxed/simple;
	bh=EJ3krwHNLtRc7GLB+HTKJlFuR9pfh4MhEWqR13XCfx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxYXmKtoIhNvaRLhIVJi6BWoHg0OFs1zMfG3rPaQkn0xm9WaPO+5CBW11WBAp/gJSRrpsX93MzfXT9D3VCtibyRLOqjLhq5i2mLX/6n284DuYZ9IVJnwoxUCZPzpWK+zFGMKe4LvbgUvkV1zf5MN4Uy/xs3ASB6ziCWbCb2Gv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7B6Eubm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6295BC4CEDD;
	Tue, 25 Feb 2025 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496673;
	bh=EJ3krwHNLtRc7GLB+HTKJlFuR9pfh4MhEWqR13XCfx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7B6EubmMG1vIqCyCLCmHxG9YZJ5wvt4tiggK9mMffgCfAvMzv7B/iJLpdLp7CCe/
	 wJOrsZekMxNlw+lec+/Jx4Ivm+W8LZoI45O93zUzem0Z7i5ZLFTP2FQGl09+FCmtGk
	 hkaf9FvXn8VX3cy2NSwZouNDTGv/TcQawJQoPZspOcwRL2S3ziCT95Pnw/ckv3pnPi
	 cxgq0xIQ9YHMLYN6xRpR5+X9Fg6AW6rbJLNNfz6/BQriQrbbzAFJuoV9fkk3+ocUHa
	 IZhW6/7uAKSet6En7FbjF7CwpE3P25K+33T/uSNKCUdFhzX53h/TiNavIpbPxfnr3J
	 cDC22dHIjf85w==
Date: Tue, 25 Feb 2025 15:17:49 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v6 8/8] selftest: net: add proc_net_pktgen
Message-ID: <20250225151749.GD1615191@kernel.org>
References: <20250221215246.383373-1-ps.report@gmx.net>
 <20250221215246.383373-9-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221215246.383373-9-ps.report@gmx.net>

On Fri, Feb 21, 2025 at 10:52:46PM +0100, Peter Seiderer wrote:
> Add some test for /proc/net/pktgen/... interface.
> 
> - enable 'CONFIG_NET_PKTGEN=m' in tools/testing/selftests/net/config
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


