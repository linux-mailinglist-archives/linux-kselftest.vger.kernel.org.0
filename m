Return-Path: <linux-kselftest+bounces-21882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCC9C5CE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE4283AC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD4204031;
	Tue, 12 Nov 2024 16:07:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B6204030;
	Tue, 12 Nov 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427675; cv=none; b=WwBw0WbJTzcvnyw3/mrCBg5i9bTEjsJgtdeK0OAydUeJ0Q8No01GVnIdQZTrfN4+kj1ImUmT3P+8QdGsRgId0rFsmYUmmaZBj11g0U1Ndh8sgPPmS2UpV+Z+dWktH+Ul5+3qm36gE7fJZdazCrsek4zjf2a8FbW124zmhAsbmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427675; c=relaxed/simple;
	bh=9bbGK2FLOU9er9OD4W23YD+qPgtDYZzQofPwV3cl6sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/8ePtF1LWCYhFoYk2Ql8XaAROeHZyZd0nYNF9wnSjgypsGM37592DDCkz/3eRyD2kG1m3nR2TtE66/WWKqoL0z8BeqyRH/AkPN8ADAQBDj2GQDbx29OwRabxZJrFYBNamIUoF0zaLoJuYBLX7FupEjPRz9iUVvERntIEPFX73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD84C4CECD;
	Tue, 12 Nov 2024 16:07:52 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] kselftest/arm64: fp-ptrace enhancements
Date: Tue, 12 Nov 2024 16:07:34 +0000
Message-Id: <173142698242.893467.659853152392768670.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 13:08:13 +0000, Mark Brown wrote:
> This series contains a bit of a grab bag of improvements to the floating
> point tests, mainly fp-ptrace.  Globally over all the tests we start
> using defines from the generated sysregs (following the example of the
> KVM selftests) for SVCR, stop being quite so wasteful with registers
> when calling into the assembler code then expand the coverage of both ZA
> writes and FPMR (which was not there since fp-ptrace and the 2023 dpISA
> extensions were on the list at the same time).
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/3] kselftets/arm64: Use flag bits for features in fp-ptrace assembler code
      https://git.kernel.org/arm64/c/c0350076c13e
[2/3] kselftest/arm64: Expand the set of ZA writes fp-ptrace does
      https://git.kernel.org/arm64/c/7e9c5b00009a
[3/3] kselftest/arm64: Add FPMR coverage to fp-ptrace
      https://git.kernel.org/arm64/c/7dbd26d0b22d

-- 
Catalin


