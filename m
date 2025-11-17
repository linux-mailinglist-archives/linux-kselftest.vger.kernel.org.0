Return-Path: <linux-kselftest+bounces-45794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DDC66304
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6E25D29685
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948CA34405C;
	Mon, 17 Nov 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcyvUuOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913F3370F0;
	Mon, 17 Nov 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413349; cv=none; b=pGhonb/rqZQFZ6XotaUWjIhL8+wBr+eUmc410jp1kjSSE9eVnghjUZHu8zY3GC3cJ35M6bhz9FO+fRJrHhutm1t4NXD/IShpLjyQH7hW26Itihp1oKUORzQdIozxNwC6Vsc55r9gtd4TnZhPg3OIIPsk+QOPhL3qS7KxxD2tgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413349; c=relaxed/simple;
	bh=bE0iENGKX931P1EKdTaVZ4dDp+hh3qF3ZbwQ/1IU8a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSeHwn9VCzhks+U7pInk0jnseiDj2jZ219WP85ZX18FQrVrFqSFxxjfJo9ULmPqvyoLatgHnWxDy3i7uAHfj1djBsijqYxfqkjKZzyvOJ8gNXFF8DIZaOIKbWcUOwZYCRymNKufCZylZGKfiDBAFREVdF+Nms8VvshGDGFhBOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcyvUuOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F2DC116B1;
	Mon, 17 Nov 2025 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413348;
	bh=bE0iENGKX931P1EKdTaVZ4dDp+hh3qF3ZbwQ/1IU8a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcyvUuOPrdgEKf+IiV3Mi2NKan7arkgRprfH91oavZjFzs0eoDWaaZz79bMU+Fmge
	 /AV0gI4kU8w85+0kRmMIEO3oioTpSlLpCnIWv7Vy93oifWgB0HWCFo9j9jNL6oNKg6
	 E8AfflGx+KvsYNur2oB7lDY1aJTMon55P/UQZbTpqhI7NcSspyICzblzBnjCzBcedx
	 9dMk0U/X+Bb/3X48uLP1Rs95dHVt1LSAocSBqocq89Sc/5bbQ79zwhMST+1P2a/LD0
	 WYQHHGKdxVfXtdqXq5SaAUv618wWJnlHJ7WWyU74Yy7dejZ8L/tYbqf9z/tSMGqYM6
	 bGQJgHvy0l/RA==
From: Catalin Marinas <cmarinas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Luis Machado <luis.machado.foss@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64/sme: Support disabling streaming mode via ptrace on SME only systems
Date: Mon, 17 Nov 2025 21:00:59 +0000
Message-ID: <176341325906.789443.15370787298292895484.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Wed, 15 Oct 2025 18:56:35 +0100, Mark Brown wrote:
> Currently it is not possible to disable streaming mode via ptrace on SME
> only systems, the interface for doing this is to write via NT_ARM_SVE but
> such writes will be rejected on a system without SVE support. Enable this
> functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
> via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
> writes currently error since we require that a vector length is specified
> which should minimise the risk that existing software is relying on current
> behaviour.
> 
> [...]

I don't think we'll get gdb feedback soon. Thanks David for the LLDB
ack.

Applied to arm64 (for-next/sme-ptrace-disable), thanks!

[1/3] arm64/sme: Support disabling streaming mode via ptrace on SME only systems
      https://git.kernel.org/arm64/c/472800cd5e38
[2/3] kselftst/arm64: Test NT_ARM_SVE FPSIMD format writes on non-SVE systems
      https://git.kernel.org/arm64/c/eb9df6d69a96
[3/3] kselftest/arm64: Cover disabling streaming mode without SVE in fp-ptrace
      https://git.kernel.org/arm64/c/a0245b42f881

-- 
Catalin


