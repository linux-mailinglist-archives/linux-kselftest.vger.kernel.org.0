Return-Path: <linux-kselftest+bounces-11780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62B905829
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28B728248F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED017F36D;
	Wed, 12 Jun 2024 16:08:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957C16EC13;
	Wed, 12 Jun 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208512; cv=none; b=gr+RKnwrlQdFubhj4lSkZCvAqYnPNiZDicVoE6/7PtNhbWY5R+vv5ig89FIlzWHzRSX5zkAAT32ls3iZSxkpuZFqGG4masEhBoVbKHYpnKW3hMSElKUkE8UgeBR/4v3lZFM0r48+ikVdkbxpftozcw8u59jjNjsgL5gYhZLU4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208512; c=relaxed/simple;
	bh=W1z/9u3rEgHbPdyNnjpzPdL3NJwPRc2YbEoijhy0DxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9Q1jCBcSf9soamP67e2iIeA7FPXhAPlOUiyVpPd5bwQWy7cy+Gygnm2TtPwnypGUWvFd5n1ljNHXMjOZI3js2EjGTULH34Xi5NHaFxBniqYK2z9MNhcl7MWDlzCCXefY/gfBOzH+slSUpSCJEm4TC8YCzDpYpbsuKCHaanfMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C44C116B1;
	Wed, 12 Jun 2024 16:08:30 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Johannes Nixdorf <mixi@shadowice.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Include kernel mode NEON in fp-stress
Date: Wed, 12 Jun 2024 17:08:28 +0100
Message-Id: <171820848287.4013585.16773584820853103152.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521-arm64-fp-stress-kernel-v1-1-e38f107baad4@kernel.org>
References: <20240521-arm64-fp-stress-kernel-v1-1-e38f107baad4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 19:18:26 +0100, Mark Brown wrote:
> Currently fp-stress only covers userspace use of floating point, it does
> not cover any kernel mode uses.  Since currently kernel mode floating
> point usage can't be preempted and there are explicit preemption points in
> the existing implementations this isn't so important for fp-stress but
> when we readd preemption it will be good to try to exercise it.
> 
> When the arm64 accelerated crypto operations are implemented we can
> relatively straightforwardly trigger kernel mode floating point usage by
> using the crypto userspace API to hash data, using the splice() support
> in an effort to minimise copying.  We use /proc/crypto to check which
> accelerated implementations are available, picking the first symmetric
> hash we find.  We run the kernel mode test unconditionally, replacing the
> second copy of the FPSIMD testcase for systems with FPSIMD only. If we
> don't think there are any suitable kernel mode implementations we fall back
> to running another copy of fpsimd-stress.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Include kernel mode NEON in fp-stress
      https://git.kernel.org/arm64/c/d5859510d35d

-- 
Catalin


