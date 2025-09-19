Return-Path: <linux-kselftest+bounces-41980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A2B8AF2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCA51C87CFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618B25CC64;
	Fri, 19 Sep 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1aIsfRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869AD247295;
	Fri, 19 Sep 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307108; cv=none; b=K0a86+yWwbqI0G4wzLgLgb4wZcBVZEVwTe9xBVVLnBJPbuuoE9pMQt3Iiuyi3ZAykech5Pe0RummaUubSPWfP3d3+K9SimfLgMKj/q6Ld0qAck7UBUqh5YIydqc+Qbh8F7j+ilhquMXuEUg1hy4WaByw0yh8cks58Vk6XwN2xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307108; c=relaxed/simple;
	bh=EeZzWFrfZxrU8fh2GXxBtvaOZgVq6ueEnBhBSJauFWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz1yvi1c5flFE7+GpIMdyNTyO3Qi+az8MKToN7UBUh73ufya3y3s1eJelM2yWNU6LxPj+KYT0NgIdPrCn7VpPCmGS9lw3m7HCBQjoArHIjtRMsd8vodX8h+p9RGAXb9AY318fZTar9eUH2v3B1GUTYfqJDuIZn6Ij25uVSiHLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1aIsfRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50919C4CEF0;
	Fri, 19 Sep 2025 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307108;
	bh=EeZzWFrfZxrU8fh2GXxBtvaOZgVq6ueEnBhBSJauFWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1aIsfRYpwgGG1ulRgCexm9tZ8cz18SxSmW+AJ/e1l9FzTrztVNzTIa5Y4SAAxR0W
	 oipQkNRT+vAf9yvlaQ6ds6/i9hJOH70tMF9tvymO1jje7ABHNywjN41zug7yYaEY2+
	 wgN+TEhvZpe6htN23Fb+fdqpftk20KG985QTMQeZp+fYbMcm8BQn+JuLwUnfDTT7aP
	 Ok01ljK2KHuj+tPXU7VVbRZ38bjhTepyoU1NlNyUfC5/4KMNXoyCzXmOzUlvtYcp/a
	 sNHOglQ0n1CFJrEUf+lUxTwmRovEDIaSwrk7JuQFw5+0OzLM9TurShOAINtombvFWy
	 DYgp0Wy26aCsQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/2] arm64: Support FEAT_LSFE (Large System Float Extension)
Date: Fri, 19 Sep 2025 19:38:17 +0100
Message-Id: <175828261879.3019927.22813258731218689.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
References: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 20:42:05 +0100, Mark Brown wrote:
> FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
> memory operations with floating point values.  We have no immediate use
> for it in kernel, provide a hwcap so userspace can discover it and allow
> the ID register field to be exposed to KVM guests.
> 
> 

Applied selftest update to arm64 (for-next/selftests), thanks!

[2/2] kselftest/arm64: Add lsfe to the hwcaps test
      https://git.kernel.org/arm64/c/777fb19ed8d6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

