Return-Path: <linux-kselftest+bounces-40358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2488B3CA47
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4A5E07A9
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB6277CB3;
	Sat, 30 Aug 2025 10:39:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D0207A0B;
	Sat, 30 Aug 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550372; cv=none; b=jTgdEd0O1LakRThUZR+fRDk3FRaTBWlHjGOR/X9aj4jIIMvDBg80vnPuVHob1cBQrzEjlMnRnwjpcAPp49e985YtQ9eq5roEYEqmLI8pP8Ic7VSIqxRFHD9QGSB+T14aFinBsixsVE0py4c5ZMKxQ4X2vDuZNGOQECKEJ6Exhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550372; c=relaxed/simple;
	bh=G+WYl5zEZwCixATCLRwwqYylkCcLG2iKRsfwbDufMys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTwKpAAbZobf2HcSqKHv733bAYdjlmwuBCO9l82liU84oBf8+U+bBpHtcLNEs1FA3xcyviEpjXVm9vzXrioJtgJXOP2Fk7WRl5X42e1Nh54B4JKz+fbzYXyV6oGH1rT57W3UEGirWDd5VxCLhEm9QPJJZPA1ld7vewItWzSJE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61259C4CEEB;
	Sat, 30 Aug 2025 10:39:30 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace
Date: Sat, 30 Aug 2025 11:39:19 +0100
Message-ID: <175655035973.1114907.5360306706910307227.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812-arm64-fp-trace-macro-v1-1-317cfff986a5@kernel.org>
References: <20250812-arm64-fp-trace-macro-v1-1-317cfff986a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 15:49:27 +0100, Mark Brown wrote:
> In fp-trace when allocating a buffer to write SVE register data we open
> code the addition of the header size to the VL depeendent register data
> size, which lead to an underallocation bug when we cut'n'pasted the code
> for FPSIMD format writes. Use the SVE_PT_SIZE() macro that the kernel
> UAPI provides for this.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] kselftest/arm64: Don't open code SVE_PT_SIZE() in fp-ptrace
      https://git.kernel.org/arm64/c/d82aa5d3501b

-- 
Catalin


