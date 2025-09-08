Return-Path: <linux-kselftest+bounces-40958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF000B49477
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFABD1BC1175
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A53101D2;
	Mon,  8 Sep 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS8VLBBR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D330FF39;
	Mon,  8 Sep 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346952; cv=none; b=C9LCow0n3Th+RXQV6GgWxCTOkHoHp6BsUbdDCRCP5dalp70P8rtT8Y88nmoRXFqz83/DWsLXnWNpxWU8z8R8/jb1+Fq7aB/VLW6wi32dwDIdhvjtTe4MEVIs3xF8PMGQ1a8fkM5lF4+HwmTzNqGKs+1BANL4u5KyN6E+pAiqwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346952; c=relaxed/simple;
	bh=MIQXdTqzCuyImVdiOhE8rNTbwPNyhkIPQlXgimdMFS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2OgFWnk3bURRJn180YfWPmNkyIGPMJ75mM8WEpW5dhQajNEl6d+tFzTzUXFzYvvCgt/AWJq4V6hPV8M8jFdc2ujq5lab3K/hjIhayfgl+fo33yACgU7IXCSmcjy2ZY00DC42Z+H2o2FCnNR25ysLM12WpkxCdQ5W2EjWBkC3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS8VLBBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB94C4CEF1;
	Mon,  8 Sep 2025 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346950;
	bh=MIQXdTqzCuyImVdiOhE8rNTbwPNyhkIPQlXgimdMFS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eS8VLBBREUZo0Z+fEkRclXc/Ugf9tnzjnb2Mkkf9ZH7jb8pD/bE2s98uC9ORSn4ny
	 eJZ9C4bOHme7m0M7Mv/BMq9ShLGnf7mVmOBlb0Q9FAtwa9qAIjgXlcoim7zO83OTxH
	 Rsqyffu0poYiAYBWvZC2gkP4W/ef/qgGHCIe6Q67gPcWgbHuyoMPwao9RO/apcnasm
	 bxQzlT0wBKTasoOvFqexeJrmdx4WjaBD+shC1OY8nwXs77VvFbpq2P7r8uMmLPFTcM
	 Rr8DWhQU7nkNQ854Ci0VY0vziXP3u7NsgDVXfq3erdZjH4fflhl1LRAxLi67QsYvPB
	 gOocdgx62KnXQ==
From: Will Deacon <will@kernel.org>
To: anshuman.khandual@arm.com,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	broonie@kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [PATCH v2] selftests: arm64: Fix -Waddress warning in tpidr2 test
Date: Mon,  8 Sep 2025 16:55:31 +0100
Message-Id: <175734146103.139506.13467439064813237125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
References: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com> <20250807114247.5915-1-reddybalavignesh9979@gmail.com> <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 17:12:29 +0530, Bala-Vignesh-Reddy wrote:
> Resolve compiler warning about always true condition in ksft_test_result
> in tpidr2, passing actual function.
> 
> This silences -Waddress warning while maintaining test functionality.
> 
> Fixes compiler warning (similar for other functions):
> warning: the address of 'write_read' will always evaluate as
> 'true' [-Waddress]
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] selftests: arm64: Fix -Waddress warning in tpidr2 test
      https://git.kernel.org/arm64/c/50af02425afc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

