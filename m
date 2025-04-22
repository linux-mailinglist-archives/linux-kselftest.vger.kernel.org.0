Return-Path: <linux-kselftest+bounces-31304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF6A96FED
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13D216A0DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81A28FFE8;
	Tue, 22 Apr 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/RgXd7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69928FFD8;
	Tue, 22 Apr 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334194; cv=none; b=a++bjG9R7TzErI3mHQ12JF3r9dVwl15mUG1Nf/BffbJgYLhLbl4hJ72zUgcLjexydaSbRMu4SHwzD3Z0TMgNWrDt4bGV8p+i+C5LLuZ+IqDV98yj0m0VStosCg6oNA/XsI4fcJS8IHUqsuMwVGiMKdu/nBY5StTAhVHI0wevBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334194; c=relaxed/simple;
	bh=SoyW7IHkfSefq7gBamKtXaT1/v+FeX2nJ+P8eHsySoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5H4xh1N04TKxCz3EL8GNEkgUC6StMGfv9gtq3EIv1qB3Uc3GC7T2dnsLN+aS0n6cKykU/LZntZLv/TpSiojucJZww6bCA9OnpBl9lloxxdepefsNtruWkSuejdfzzkR5/mxCEGn74P3ik8IDJQH7afgGnx3NjTPcb7CCX24ZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/RgXd7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6111C4CEE9;
	Tue, 22 Apr 2025 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745334193;
	bh=SoyW7IHkfSefq7gBamKtXaT1/v+FeX2nJ+P8eHsySoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/RgXd7QE4ZnfQuSwKgSYsFKvLchPs1sn5dKAanflsRJTH45wA76CuzSozzv6bFMT
	 CYcONY1S5vmSZnw4uqqopOas6AuRiJDrnxUF+hgjpO8rypTG5diJY1VKsxD3rwxCht
	 RQtMM428vjUoIZIq8HXL8X4P3HLZanAY/9B12qH/qong8wow71/Cgm4msmssuRUnXm
	 C2lMFtS4qLqWT9Eakp50ooAGXx6k745C1xWVvRzDIoNw4R6DQAQNspgL4PqMAFKTWO
	 Ojr1ehhk72+u/bTpNANNLVIsLGGYov+HbI1LOiLp4ssbIP7NnPW04gMPweVR18JCxg
	 Yu6SVENDn1AVQ==
Date: Tue, 22 Apr 2025 08:03:09 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: PRIME_NUMBERS_KUNIT_TEST should not select
 PRIME_NUMBERS
Message-ID: <202504220759.67C0120FF@keescook>
References: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
 <f2a55a3f-6c56-43fa-bfda-25cc11fe5212@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a55a3f-6c56-43fa-bfda-25cc11fe5212@sirena.org.uk>

On Tue, Apr 22, 2025 at 01:10:47PM +0100, Mark Brown wrote:
> On Mon, Apr 14, 2025 at 04:35:00PM +0200, Geert Uytterhoeven wrote:
> > Enabling a (modular) test should not silently enable additional kernel
> > functionality, as that may increase the attack vector of a product.
> > 
> > Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
> > instead of selecting it.
> > 
> > After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
> > modules for all appropriate tests for ones system, without pulling in
> > extra unwanted functionality, while still allowing a tester to manually
> > enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBERS
> > is not enabled by default.  Resurrect CONFIG_PRIME_NUMBERS=m in
> > tools/testing/selftests/lib/config for the latter use case.
> 
> This commit, which is now in mainline, causes the prime numbers test to
> vanish from my CI which is a regression - the selftests config fragment
> is obviously not picked up by the kunit runner when it builds the
> kernel.  You should add any KUnit tests to one of the configs in
> tools/testing/kunit/configs/ - generally all_tests.config.

Ah! Thanks -- I forgot about these (apparently my memory horizon is at
most 2 years, considering commit 4d9060981f88 ("kunit: tool: Enable
CONFIG_FORTIFY_SOURCE under UML").

Does this look like you're expecting?

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index cdd9782f9646..554da9df02f2 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -51,3 +51,5 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_TOPOLOGY_BUILD=y
+
+CONFIG_PRIME_NUMBERS=y


-- 
Kees Cook

