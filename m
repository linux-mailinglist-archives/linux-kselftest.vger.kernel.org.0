Return-Path: <linux-kselftest+bounces-44202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89EC162A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875633A69E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F734F46C;
	Tue, 28 Oct 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEZPV+QX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8734D4ED;
	Tue, 28 Oct 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672606; cv=none; b=W72gTCuAflE0AqCPFIDNBvSx5y2UByVwPdLU03uxthcSbUiFhr8z1bkEgSJLlbI+aPgcAtfclUeB9y7L+Q1uGyvD2+p7YkpoT07ZvF2xzf6Utc395V8lGUyknHfBB0F3XZIt4tBlezY5ng1ZKuSTYAEu/9o9X8YlVi72QRFz1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672606; c=relaxed/simple;
	bh=MyipjujNs1EeYdDhDdXYXgWCyMVvZAP8Yv0PCmnJf2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asPiYIq4E59h1HccxoojaiP7cjm8Pl8TbfBXK+NY+eQh4xVqbRcS41glk0G5JD15a3z/SpD8YCUq7xnFObfg1ALZYYB/cSLjdkC+Xv+I35dYPgVbPKahmFR8EezuIyf8YjITnzUyW29eXe0S6RBE4dEFPNvd6Z0U9FZcGDraCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEZPV+QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40665C4CEE7;
	Tue, 28 Oct 2025 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672604;
	bh=MyipjujNs1EeYdDhDdXYXgWCyMVvZAP8Yv0PCmnJf2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEZPV+QXYcBvYdpymZErgqWe9wLkt0QaMns3WrHVFPTO8TQzk53x1hMuuT2PCdlXg
	 xCh00MvKTDvxYFMiWAJ7urINcumdLpA6ji78nDOsa/AYNBpsMQItfwSpTnT10uD58D
	 AGK/DJaMNR1zEF7iG0uv41mx/m74m7LYtUewm5rm6Kg5ksfBJnPPm7cXExNi7IzI4U
	 c6CECLmNDqhtzxppeDPaztgNtXBVpTT6AavCfazQTd1ube8XIuMoyGIqqUD6dlvvTm
	 aEdSKDQTOf9pPq1cimG9TD3wdUeuOZhaRvxhMDgM71Z/sIUMYtdJTRvT2u6SDRRg8q
	 P0m4WSlOG4FDQ==
Date: Tue, 28 Oct 2025 10:30:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] psp: add stats from psp spec to driver
 facing api
Message-ID: <20251028103001.7cafeb03@kernel.org>
In-Reply-To: <d4c31a2f-590a-4b83-b6b3-25f33a51193a@redhat.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
	<20251028000018.3869664-4-daniel.zahka@gmail.com>
	<d4c31a2f-590a-4b83-b6b3-25f33a51193a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 10:02:16 +0100 Paolo Abeni wrote:
> This makes static checker unhappy:
> 
> /home/cocci/testing/include/net/psp/types.h:167:6-18: WARNING use
> flexible-array member instead
> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> I think/guess the warning could be avoided using something alike the
> following (completely untested!!!):

It's not a VLA, it's an end marker for calculating offsets.
The patch is fine, we should have added in the commit msg that the
false positive from cocci is expected.

