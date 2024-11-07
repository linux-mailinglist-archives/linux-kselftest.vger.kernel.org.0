Return-Path: <linux-kselftest+bounces-21642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C989C0DF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67222B23103
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1302170D0;
	Thu,  7 Nov 2024 18:40:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E69215034;
	Thu,  7 Nov 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004835; cv=none; b=RGxPUzvRF8ulx+SMzQ/zEVJ4oS/rm+UvjJcxRgsUpVp7EGlfi3xfGgaLKMO3LUvPnXVp+ZcPuh8tYMadzz6TbzyyWU2VNELvtctXRCwDPockx2b9vKSBlV9O38dAKrsCODtyI41oigYYm6zzYTyJeHVeJEcJS8ZdyTkeVSyljiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004835; c=relaxed/simple;
	bh=I0AeZp4d3pDXSkSC8dIrB6JacndUSQXg3Hr+vqnUR5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XY+/CpCHVA9Hd3e8saJLFKHGlSFdFvUZtsRwcE2rqyfUVB3pEsxsIFBK3JYrxp/rZPcTPdvmkRQpS/VoHFCdgVr3YPLM1fKstjnQ1qtwDJgub0lrvB/7MKx+8aGvueRkTYOvTcxGumqeUQI8OvblhXcM6XojaDrjFn2x1E5cZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF2C4CECC;
	Thu,  7 Nov 2024 18:40:33 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/6] kselftest/arm64: Test floating point signal context restore in fp-stress
Date: Thu,  7 Nov 2024 18:40:31 +0000
Message-Id: <173100478595.985049.6746642229117398125.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 01:39:19 +0000, Mark Brown wrote:
> Currently we test signal delivery to the programs run by fp-stress but
> our signal handlers simply count the number of signals seen and don't do
> anything with the floating point state.  The original fpsimd-test and
> sve-test programs had signal handlers called irritators which modify the
> live register state, verifying that we restore the signal context on
> return, but a combination of misleading comments and code resulted in
> them never being used and the equivalent handlers in the other tests
> being stubbed or omitted.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/6] kselftest/arm64: Correct misleading comments on fp-stress irritators
      https://git.kernel.org/arm64/c/94de486e4215
[2/6] kselftest/arm64: Remove unused ADRs from irritator handlers
      https://git.kernel.org/arm64/c/ffca567fef9c
[4/6] kselftest/arm64: Implement irritators for ZA and ZT
      https://git.kernel.org/arm64/c/d65f27d240bb
[5/6] kselftest/arm64: Provide a SIGUSR1 handler in the kernel mode FP stress test
      https://git.kernel.org/arm64/c/7368debf275a
[6/6] kselftest/arm64: Test signal handler state modification in fp-stress
      https://git.kernel.org/arm64/c/ead1c35ce3b3

I did not merge patch 3 in case Mark R has any other comments.

-- 
Catalin


