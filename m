Return-Path: <linux-kselftest+bounces-3327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC4836C50
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7431A1C26AD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5F60260;
	Mon, 22 Jan 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBcIivUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C3482F4;
	Mon, 22 Jan 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938047; cv=none; b=aff84I0hHNV7lJFYOnpBGXFivy+nd4CG/XzWZoYVA2uONyBG18qGOd7hF2Q3jmH7gDmp5JuMxqjudD63ddExAFMTi1bF/K3q2WLA+W12yHeJ0N+jdu4Kjo/WErcdZaY13NINdurLb7l/Fsxycbb0vpJQQVtUDYAOuCCU2cBaXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938047; c=relaxed/simple;
	bh=Llm/bGfvWQJffn+yLnx+hItsLkbnebNnRSSuJm4Okcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlNLLtrWKCfrouOG6hgkr7j79Mdx7XsWg3HZPDkDsfzdJiTENwl12Qfi9rHk/zdCOa4MH6iXg4579Ignom308goOl+n4y06WESnDXPUx4v5f47eDmdGvUaGd8hj+RXE0/e+1wAtmzbA44dnToBvaqyv/Aik+e7jdAWdmoal+cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBcIivUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D5C433F1;
	Mon, 22 Jan 2024 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705938045;
	bh=Llm/bGfvWQJffn+yLnx+hItsLkbnebNnRSSuJm4Okcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBcIivUwryCQqSYxtZlJ8Oe2XaMcPw4Dx/pkOKR2BY7QuNUR8r1ujbcqep1cqsz3S
	 yzUNej2CKbZo4BSc4IufGYJC1SYfkyKwmOkLangoQBjH/7jfqezvjPQAbW7fdtctYB
	 Dp9xIXCF8DMXTNcD9o0qwmykFOnZj7NTMomaYt5HFeTdmzrGnEbsFoFDb0XQpYKo7o
	 BOgxsiHQ8zsEFWvYEGSMMxI2wAe0BM2VDr4caw4W+ea5Si6FSnRwRhmXRe30UCMBcN
	 lU7Zo8lSiuNFmFb6QSESrmzDsK9eIblcXm8CvRDXN+0gYiOuPhSlzp8/s8u365L0h1
	 fZNb51RXbr55g==
Date: Mon, 22 Jan 2024 09:40:43 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] kselftest: dt: Stop relying on dirname to improve
 performance
Message-ID: <20240122154043.GC601827-robh@kernel.org>
References: <20240122-dt-kselftest-dirname-perf-fix-v2-1-f1630532fd38@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-dt-kselftest-dirname-perf-fix-v2-1-f1630532fd38@collabora.com>

On Mon, Jan 22, 2024 at 11:29:18AM -0300, Nícolas F. R. A. Prado wrote:
> When walking directory trees, instead of looking for specific files and
> running dirname to get the parent folder, traverse all folders and
> ignore the ones not containing the desired files. This avoids the need
> to call dirname inside the loop, which drastically decreases run time:
> Running locally on a mt8192-asurada-spherion, which reports 160 test
> cases, has gone from 5.5s to 2.9s, while running remotely with an
> nfsroot has gone from 13.5s to 5.5s.
> 
> This change has a side-effect, which is that the root DT node now
> also shows in the output, even though it isn't expected to bind to a
> driver. However there shouldn't be a matching driver for the board
> compatible, so the end result will be just an extra skipped test:
> 
> ok 1 / # SKIP
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk
> Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Tweaked commit message
> - Added trailer tags
> - Rebased on 6.8-rc1
> ---
>  tools/testing/selftests/dt/test_unprobed_devices.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

Rob

