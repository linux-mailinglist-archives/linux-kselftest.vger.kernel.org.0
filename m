Return-Path: <linux-kselftest+bounces-16168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72795D3ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F04B25447
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619918CC15;
	Fri, 23 Aug 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD5ix2mU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138718CC0A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432545; cv=none; b=bNhnp5Gt07jkiIxV1IkzADsNYGGb2ltglIByLe/WG7drn/Xw4Jc9aDZoAkq+YhyrJ9n8ZgDfWaIWzJVephS9fQPkNSlqTOpp4MqPYwIcYByXvruU045YFHAt8PdG+4Kf9Lx4aEJdkZOtquUjTHNZV8QuJMSwNGkph5TnTP8ICVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432545; c=relaxed/simple;
	bh=a+HtMAKp0iTr49LzE5/i5jCxtdA5B+nSCv6r+KCZscY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQMlYnv35KKxZDuRbZbgrulFt0MwxmyocWDyScy2jmIqfF1U7AgZZNsNl4a7FIgZELXVdevSKJK+009ulufg6kHg6RST9ci3J1j5OVvSnh8vpfCTk1rtsGCeBwJEB05MrVFdPFjHPZaPgyVd/NsEl7haobBoo34yXq/pmNf+NH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD5ix2mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D593EC32786;
	Fri, 23 Aug 2024 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432544;
	bh=a+HtMAKp0iTr49LzE5/i5jCxtdA5B+nSCv6r+KCZscY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TD5ix2mUTq3N0SQCinWedWh2XRL1C/DOaxEkhD+3dJ6yQD1Vn53ZMxJrHSCt0sLfn
	 j1NY3LHaeaeTjQujEC68ZbIq9QWOa1RxYv/oWWeUH37fZr1zQy5pCUq95s1OUVtxDx
	 Ivgp7XNb/gQ6VEQbzPa1rCmuJCGg964cJyF2XfjoLKJAHk8Iyi/VR0jrgjVgMyq8BF
	 pWf77BlUwbKk9cSkaUxME6w+DoneHpA55y9jRwGaYs+zdJTLmvTYukdi8m3RNhjw6l
	 hqoSppGVjgNKucj4kR5OsATq6EzmSC18ZLjm83tYmqTrAgo3w0dq6VklgliIe5AKZc
	 L3YitWQIzQhIw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3] kselftest/arm64: signal: fix/refactor SVE vector length enumeration
Date: Fri, 23 Aug 2024 18:02:08 +0100
Message-Id: <172440929617.1920961.4281973626925639937.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240821164401.3598545-1-andre.przywara@arm.com>
References: <20240821164401.3598545-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Aug 2024 17:44:01 +0100, Andre Przywara wrote:
> Currently a number of SVE/SME related tests have almost identical
> functions to enumerate all supported vector lengths. However over time
> the copy&pasted code has diverged, allowing some bugs to creep in:
> - fake_sigreturn_sme_change_vl reports a failure, not a SKIP if only
>   one vector length is supported (but the SVE version is fine)
> - fake_sigreturn_sme_change_vl tries to set the SVE vector length, not
>   the SME one (but the other SME tests are fine)
> - za_no_regs keeps iterating forever if only one vector length is
>   supported (but za_regs is correct)
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: signal: fix/refactor SVE vector length enumeration
      https://git.kernel.org/arm64/c/5225b6562b9a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

