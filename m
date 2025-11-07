Return-Path: <linux-kselftest+bounces-45147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F4C41A2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84103ADBBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50495289374;
	Fri,  7 Nov 2025 20:52:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6B18C2C
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548764; cv=none; b=EqJ2YbsPSNpGZcdzPTuWXWc9jT9b3NCC4VCFn8iVZnCo5RUq9wjbTP7Egwi3pXW7C679PpBx92dgHX9Lc6Zdh6fjyicDeNtS4Q0M3GekzdmgS4VNqnvOupxtrEuQl3PlqhBOc+LpyDDHddGAeASpsiAp3y1XPtrWez64uTv5LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548764; c=relaxed/simple;
	bh=cqkWh1KpbO4RFrhZOu4niA4cxRbOBqY8Cf8COhhOMtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpRxXIj0ks6LdMwCMHrM6oUK7f2W5B3X7s5nxPp5HYsG8IU0Vmdh2oeGNQ1Mw/vhJ72TRuXRtVHay8Oj211yxhccDtqsuchYAdQTlcRSIbgceIMtHq98wB0S8CPZc6yKdWG8ga4GbYUZwUsY0CoQWIzvnXE7rXyPmlNQgdu4gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EC8C4CEF5;
	Fri,  7 Nov 2025 20:52:42 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>,
	broonie@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] kselftest/arm64: Align zt-test register dumps
Date: Fri,  7 Nov 2025 20:52:34 +0000
Message-ID: <176254875462.3846404.5369912226955297969.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103160417.1023545-1-mark.rutland@arm.com>
References: <20251103160417.1023545-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Nov 2025 16:04:17 +0000, Mark Rutland wrote:
> The zt-test output is awkward to read, as the 'Expected' value isn't
> dumped on its own line and isn't aligned with the 'Got' value beneath.
> For example:
> 
>   Mismatch: PID=5281, iteration=3270249   Expected [00a1146901a1146902a1146903a1146904a1146905a1146906a1146907a1146908a1146909a114690aa114690ba114690ca114690da114690ea114690fa11469]
>           Got      [00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000]
>           SVCR: 2
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Align zt-test register dumps
      https://git.kernel.org/arm64/c/a7717cad615f

-- 
Catalin


