Return-Path: <linux-kselftest+bounces-32420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B0AA9B08
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569113BCA29
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97826C397;
	Mon,  5 May 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPsEPFoK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56991AC458;
	Mon,  5 May 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467397; cv=none; b=lY97zm9tVHg3BAFnjZRnS96BOUGdeHAOfId7xpV0yJm/YNLQTFKxC6A38B01hCyu+v251hPErUkBfwVnOtDMLTVlx9wGKT4papTck3PpaTrupYrB9NHDJCE1AY4H649mGzOLnlGOtcZstgns17U98JLOBetaM6p5hRYHeCIW2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467397; c=relaxed/simple;
	bh=lOM+r5Fd7U8DMPrMDi7F8rh56yRIFYhbuW/hBKdRzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI6NDPIsMSQ8MfqFvHbVpwR2O9ECNpdnNlMCuuOB0UIoivORB6vPvCpjnDYXDxOyErUqZjOsEeuopXd7FGyINVkH3pdpSmwMP97Q5Lwdsp1UXNSuR+eKJqWId/CoakoYIpNNFq30qOi7zVXKj6e2W6WpFuNBzvkf7Uxk+G8ZPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPsEPFoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4119C4CEE4;
	Mon,  5 May 2025 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467397;
	bh=lOM+r5Fd7U8DMPrMDi7F8rh56yRIFYhbuW/hBKdRzb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SPsEPFoKmH8WklyOPDe8dI6m2scCNswA9vT79jzrGA3fYrCz9q2ty+RVbkrhNzyT8
	 gTR1GliY2HwFimWP2XFqbmQ0l7Ov0Ke7XxpsQVm67eGiPYZf4wk89MH+T+rKFRC0Xj
	 LFNvljq8/ZAJuzVckaWY+PZZ9+5j5cXZy49vPEWiC6TYMLdu8yvp9gZPop+0Q2OyXl
	 LyIH4h3e+ngpdAF1X3+FpFXV1lSyk/GgHmXT6HT83GzNWmH3um/PrJkmjlWqtxJd3d
	 xDapbCz5wa8TADbF+RFmTOx7ZtgjL7IVjk0PmG3QLC9buoatI4oFV/r6vWJhYCwlBb
	 wLo1zeykI49Bg==
Date: Mon, 5 May 2025 10:49:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/3] selftests: drv: net: add version indicator
Message-ID: <20250505104954.39cc63e1@kernel.org>
In-Reply-To: <a8c17a58-67fe-4cba-ad4a-a1822554c459@davidwei.uk>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
	<20250503013518.1722913-4-mohsin.bashr@gmail.com>
	<a8c17a58-67fe-4cba-ad4a-a1822554c459@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 22:02:43 -0700 David Wei wrote:
> > -def test_default(cfg, netnl) -> None:
> > +def test_default_v4(cfg, netnl) -> None:
> > +    cfg.require_ipver("4")  
> 
> With this patch, is the previous patch and this hunk still needed? I
> think you can drop patch 2/3 or both.

The previous patch makes the more "meaty" tests run when either ipver 
is available. But we still want an indication if both versions are
supported by env but reporting *a* skip. Historically this is what
the ping test was for, TBH, pretty much a sanity check for the env.
But it ended up accumulating random XDP test cases :( 
Perhaps something to address in net-next..

