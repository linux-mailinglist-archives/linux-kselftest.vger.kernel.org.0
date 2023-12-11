Return-Path: <linux-kselftest+bounces-1616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818D780DB95
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7372819FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807653E1B;
	Mon, 11 Dec 2023 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jToo/cEQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0D53E13
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 20:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5172C433C8;
	Mon, 11 Dec 2023 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702326465;
	bh=+f+K1J2zjMnV4XxDy3cuCWY6rDx5LO4Cp2MLoIwdP08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jToo/cEQ3vlKq7uXuK6pQ0GhiYMB+ee4x2MXGN1GDctBWWy9YToDQi9E/NJqpDNn5
	 PeO30kk9waFSFEfgmxpTMjF1HztAPVRYsYfEXZb7tnwSCrWuXxPsQekKAJ4EB6Q3ah
	 qfGSeDXlNd/plAfuamlpsjPZwetCcjXv/tZ6QcGfVEaUqRkizOxAM2i8OOvw6igspA
	 xCBSbfxxea++rr2rzEaIhq6UXKQNn6jEkI8NB2lyc8+QVaH08KGPY0Hjvl5HFYf8+6
	 sFUNqH9Ap3B7J5zMnnXu+EYsLYchLw/XKmuKfnSECYoSTVC4YmWmP/mpyRukVxo8q1
	 UFNC3jjQSiwfw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Improve output for skipped TPIDR2 ABI test
Date: Mon, 11 Dec 2023 20:27:29 +0000
Message-Id: <170229604354.42938.7367909798766410585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124-kselftest-arm64-tpidr2-skip-v1-1-e05d0ccef101@kernel.org>
References: <20231124-kselftest-arm64-tpidr2-skip-v1-1-e05d0ccef101@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 24 Nov 2023 15:22:21 +0000, Mark Brown wrote:
> When TPIDR2 is not supported the tpidr2 ABI test prints the same message
> for each skipped test:
> 
>   ok 1 skipped, TPIDR2 not supported
> 
> which isn't ideal for test automation software since it tracks kselftest
> results based on the string used to describe the test. This is also not
> standard KTAP output, the expected format is:
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Improve output for skipped TPIDR2 ABI test
      https://git.kernel.org/arm64/c/33c1a7785a41

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

