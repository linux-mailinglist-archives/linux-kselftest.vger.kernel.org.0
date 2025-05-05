Return-Path: <linux-kselftest+bounces-32416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B6AA9AF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75301A809FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328F26C397;
	Mon,  5 May 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9MZMqi4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF225D8FB;
	Mon,  5 May 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467075; cv=none; b=pAPDs72jQX3N+3gt0XPMvGOSm+z8PG6UqXO80xeuFpyk+Fm61R+2QhADs5NnMMa1ZBEacuxmPmtAJ5UT40j4VyjLyLLICq2+m2ps4lbO0/s26Dm7pobzqiBUZYNTiwv/PcGf1izwh9pqaLpngWHV6dY7AdUU4AveTcdeJYyLJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467075; c=relaxed/simple;
	bh=uQtdKOv8+nklDkXLNTL9GcP88vqK29pPRV8J/XiFxhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL2pCvTJd8qt2OGOhfs9RjJY1O509HYfbWl4eeEX40OHnXmvSvkAcL5/UDo5qVuvElfn61ZlOfayVjXIf8CEIYoU5ADsxqh3vgiKrulXRP4gx2/zAiyeu9vOUA/PO9qX/BjbLOh13/MSs0C2ciwqBlj1nWuAGo+bAWm/daxkibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9MZMqi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EEEC4CEE4;
	Mon,  5 May 2025 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467075;
	bh=uQtdKOv8+nklDkXLNTL9GcP88vqK29pPRV8J/XiFxhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9MZMqi4Mj/wTOK7/vTn9XJFeq64v474403hadA5n4yh0tniENbLFrOnsYK/hSCjR
	 DGEtjWFV2D3Vri7Y8MuEkFD9ctXSzdMR3NN0ggvMmb5oy2+EFQtVZ/IWZsHdfI6yuT
	 X5VujU39m2Pr5S9p81r+qi+TMle3CxHi4C7yyddjMKFLNQSAFvZyVuXOl8QRnrNPch
	 B8tE3NEF5j2HmCzcWwynPrZwuSrSOv7JpUyIv/vinZk3zPFsvfXRtZQopTFhLKL4CQ
	 SORBk1FubGOVjl9Waxb4uD99cu9xwrCMemVuQImSMVoT07EUmZVByRqBXK1dR7iV3c
	 jh4jXhgoRrUnQ==
Date: Mon, 5 May 2025 10:44:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] selftests: drv: net: fix test failure on ipv6
 sys
Message-ID: <20250505104433.0eb6173a@kernel.org>
In-Reply-To: <9f944c15-5f61-403f-95cd-540fa9c0b783@davidwei.uk>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
	<20250503013518.1722913-2-mohsin.bashr@gmail.com>
	<9f944c15-5f61-403f-95cd-540fa9c0b783@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 21:49:46 -0700 David Wei wrote:
> Unrelated to this patch, but there is an ip() helper already. Can it be
> used instead of cmd() with shell=True?

The wrappers are mostly useful for JSON, parsing the JSON output
is a few lines. For running a simple command we don't have strong
guidance.

