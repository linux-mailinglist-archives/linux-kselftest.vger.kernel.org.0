Return-Path: <linux-kselftest+bounces-2201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269E81862D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EB42863EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541014F9E;
	Tue, 19 Dec 2023 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn2HuqBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876751862F;
	Tue, 19 Dec 2023 11:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E458C433C8;
	Tue, 19 Dec 2023 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984719;
	bh=+h2tsZ61JLjqWX+H/YMTKyIMI8Rjw4JpeoKyhXu+/aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hn2HuqBfnQwxEwIHwxcPOUV24w+a46J1ULqWG0mrO7kR7uildDg2EsZ3X7dMhR4ZQ
	 dV9nYKGtoOT6JcjkOKnblkeDULY0UrmnN8LCUbiTO0lB+POHJTRgzo9jSrsJZQ3Q4D
	 0TzAPEAI78s+WVtaXxjhQoqHmgDOEEzhq9IET6k4VLA1++7aoPylMFd8whlwKD8JSt
	 /sJ0l6LDYDNAXX5NWDlTm3A9D/rsUIHNioLBUIal1fbOrwiNEtNac/ouJ5EU7y6/O3
	 6cHEq9Go5KQ4kd+Usn4HE+q9Mun0HA/KxLiqZzgo8Fh6bOdD5NmnPqoq4X2/+RjCMQ
	 M2udhaDQ6ansA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Don't probe the current VL for unsupported vector types
Date: Tue, 19 Dec 2023 11:18:30 +0000
Message-Id: <170298019769.1509727.6589504598690487361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231218-kselftest-arm64-vec-syscfg-rdvl-v1-1-0ac22d47e81f@kernel.org>
References: <20231218-kselftest-arm64-vec-syscfg-rdvl-v1-1-0ac22d47e81f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 23:39:32 +0000, Mark Brown wrote:
> The vec-syscfg selftest verifies that setting the VL of the currently
> tested vector type does not disrupt the VL of the other vector type. To do
> this it records the current vector length for each type but neglects to
> guard this with a check for that vector type actually being supported. Add
> one, using a helper function which we also update all the other instances
> of this pattern.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Don't probe the current VL for unsupported vector types
      https://git.kernel.org/arm64/c/9a802ddb2123

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

