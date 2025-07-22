Return-Path: <linux-kselftest+bounces-37829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA5B0D701
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E057B59AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA87C2DFA28;
	Tue, 22 Jul 2025 10:10:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A22DCF4F;
	Tue, 22 Jul 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179053; cv=none; b=rpUBeVBgQazzvkQDg3vnzIRuCp/93UgIXuCYaSqicFwCjpSItHWtN9VTqPzBdlj13LbvQd51UYhoGNyBYBfyv0OHMPxRxrtIn3evIfa6gGtdKsUU40oIrEhKRWTrpS4IH0aDpI8iCWGBAqIyta2ohZmkmUyhWVISjGJLjEXwADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179053; c=relaxed/simple;
	bh=3R56aaB/igaMtG/d7evdGFPNKvBcCTq12+3Hpgp6/m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUOqbBbgeo9KBpN632I1O1DMy/ZwuN6wnW39CIpcqvngdkrtfUxcNnfZ5TFefM9Xz7VAf/9J0zg86/jKucoorIqBYJ9k2eXge97eGZjHhHBrvH4YGQHXRbrcfSdHrjYJdcy2jf+wLuxscWxO+BzobEKZYlsGUZpq1Bi/MHa7Pmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B2C4CEEB;
	Tue, 22 Jul 2025 10:10:51 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] kselftest/arm64: Fixes for fp-ptrace on SME only systems
Date: Tue, 22 Jul 2025 11:10:49 +0100
Message-Id: <175317903265.3058188.4852096181091664179.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
References: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Jul 2025 23:14:49 +0100, Mark Brown wrote:
> When testing SME only systems I noticed that fp-ptrace does not cope at
> all well with them, this series fixes the major issues so that the test
> program completes successfully.  The reason I was looking at this is
> that following the recent round of fixes to ptrace we do not currently
> offer any mechanism for disabling streaming mode via ptrace, this series
> brings the program to a point where it tests the currently implemented
> ABI.  A further series allowing the disabling of streaming mode via
> ptrace will follow.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/3] kselftest/arm64: Test SME on SME only systems in fp-ptrace
      https://git.kernel.org/arm64/c/b021f45d39f3
[2/3] kselftest/arm64: Fix SVE write data generation for SME only systems
      https://git.kernel.org/arm64/c/aa7d3c8bc27d
[3/3] kselftest/arm64: Handle attempts to disable SM on SME only systems
      https://git.kernel.org/arm64/c/4752dcc156f2

-- 
Catalin


