Return-Path: <linux-kselftest+bounces-37831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C7B0D703
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904E97B5DA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDECC2E03FC;
	Tue, 22 Jul 2025 10:11:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203D2D660B;
	Tue, 22 Jul 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179073; cv=none; b=UXjiHSuhRCgZ7ZYVNW8/dNFN9uYCaZP8QlZFypDzyPL+mBNeX9XWSUytvRytLlG4qnbwiyFp/D1TvUk6zQnFw9S8D/uF+OH7u0N0uGi9DP33rUccje5QAxqKANXXrUOoHrjTllYFYbGTz9g0MU29srUGRw58q4Ef52luvv79LBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179073; c=relaxed/simple;
	bh=Dc5VZDhDGrX8bBd7ybK8/r/QekbQcXsSGZqyf4YZ46E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsKWBf63zznYo+sVhn8rpQeiUCPsxz+xhFviRwaDqJH3JzuUN+awVid5S36mosDrABaNKGnyUBcPipJrAwu6/Mn+62Uq+pcAMg0+iRUugnrl/7wCZJkiGU5E7AHbpGrsxeB7OZ/3wIUD14WE9LmNIluS3T4HalNQAEmJqzYEc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3AC4CEEB;
	Tue, 22 Jul 2025 10:11:11 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Test FPSIMD format data writes via NT_ARM_SVE in fp-ptrace
Date: Tue, 22 Jul 2025 11:11:09 +0100
Message-Id: <175317903265.3058188.1426905529254051034.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718-arm64-fp-ptrace-sve-fpsimd-v1-1-7ecda32aa297@kernel.org>
References: <20250718-arm64-fp-ptrace-sve-fpsimd-v1-1-7ecda32aa297@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 23:03:26 +0100, Mark Brown wrote:
> The NT_ARM_SVE register set supports two data formats, the native SVE one
> and an alternative format where we embed a copy of user_fpsimd_data as used
> for NT_PRFPREG in the SVE register set. The register data is set as for a
> write to NT_PRFPREG and changes in vector length and streaming mode are
> handled as for any NT_ARM_SVE write. This has not previously been tested by
> fp-ptrace, add coverage of it.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Test FPSIMD format data writes via NT_ARM_SVE in fp-ptrace
      https://git.kernel.org/arm64/c/b84d2b27954f

-- 
Catalin


