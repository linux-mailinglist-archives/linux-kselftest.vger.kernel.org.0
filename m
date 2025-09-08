Return-Path: <linux-kselftest+bounces-40960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1129B49480
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7639167EC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2358B3112D0;
	Mon,  8 Sep 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP65rJin"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2F30F92E;
	Mon,  8 Sep 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346960; cv=none; b=TcRZ4e8kc/x+7egJuJSPI1poA4R5n/d/J533Xi4egGEmQvFTJCJQgaU+FqcciMPWkar+VM/fe5bYxObcB2NsjPusIncPf1BDvsxVuiRhEafIzfy/TtuuV7jVr1rvIKuECAULhNRLmrlP7earciumz7s0BB7VMYdT0q4C8r82Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346960; c=relaxed/simple;
	bh=3QPTwbhduu2dP8D2E7G/tU0gXRTNUJdIG510wmSZlbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W76HKWiThXoV8Qw7aE7uVMMTGrg5o3/UL09jrkyPd5f3xFyKR+CjOYdG1PLUHVCutj9E5fhVAAdhaD+i4PD2FQjFjzKqRe2i5CMj4LKNczgT7ozB75kq24+3/3arazfrbgIaHhX1ASzRhto+tNM96rdqkF1BdRl+CliGXCYKFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP65rJin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC5EC4CEF1;
	Mon,  8 Sep 2025 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346959;
	bh=3QPTwbhduu2dP8D2E7G/tU0gXRTNUJdIG510wmSZlbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UP65rJin/AZ9cx5t+pjQ3qg22tsP5dc4u8R4ai2bBDukl9PkdnM/oZFBtptd0sZSn
	 EySGVZ2WgWPkq4KLVHcw9JXAZ6lXyNWZYt/yooBIyTQChW6lDaS6CjRNyklPS+coqJ
	 VMCsG+Bd/6wPWl4eNHWJhgneqc+gNkbOCwikVB0QChmaUN1QNRp9NkybRtYSxvUgGY
	 81DmdrbB4t0qpG7ZtIKeGq02PTMxIHJVCRJJwHAipeQ0LW4XtK3r5TcDwX5LDkLPsJ
	 +YbKvjYWUmXDjii8rBV6i55sf3XsUFplKmnx0ovwlPXba+VL5Wt9/2/6oyriaP1SJT
	 kC37Z5fFpoGeA==
From: Will Deacon <will@kernel.org>
To: bagasdotme@gmail.com,
	Markus.Elfring@web.de,
	broonie@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	shuah@kernel.org,
	mark.rutland@arm.com,
	ebiggers@google.com,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	thiago.bauermann@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] selftests/arm64: Fix grammatical error in string literals
Date: Mon,  8 Sep 2025 16:55:34 +0100
Message-Id: <175734463405.156831.1715928321630007279.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826214913.866695-1-zlatistiv@gmail.com>
References: <20250826214913.866695-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 00:49:13 +0300, Nikola Z. Ivanov wrote:
> Fix grammatical error in <past tense verb> + <infinitive>
> construct related to memory allocation checks.
> In essence change "Failed to allocated" to "Failed to allocate".
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] selftests/arm64: Fix grammatical error in string literals
      https://git.kernel.org/arm64/c/14a41628c470

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

