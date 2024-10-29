Return-Path: <linux-kselftest+bounces-20992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2379B51C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668C61C22CAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB201113;
	Tue, 29 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmsV13xl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA4201103
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226518; cv=none; b=UCI1KgSRakSrVXXyhATQafsEscaZY2u9PIROq7T3Sp64fq+PbPKjSTmdSwocWgR5LYRQfUvoNqmh+VSputBm/s27dHC6SBJfiAveq5IaOBPY9u9WgP3dCuBMe3E11RZZBgbmU4X9WmSkKt5/4730BAn7HtbZzfYsi3EGgQyjTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226518; c=relaxed/simple;
	bh=P8mXAsE98FFqUUr7ZIAanxyWudqifHBH+Nea4jlQZe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlTGL4Un7lUzYAa2EiQ2lfdnOEGwOjYbXux/rG8sunal1l83zXhuWNYIuqOcIvf7qy4mgsNujfqzK8m0qV5EHwCovxa4SJEcy3Z8cituLzDfJjoGBzRKDuqt48FQ23YU45cwekMMHOCLrSD8W++Yc1SqYh6PU9sCagSxQ96tR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmsV13xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BBCC4CEE7;
	Tue, 29 Oct 2024 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226518;
	bh=P8mXAsE98FFqUUr7ZIAanxyWudqifHBH+Nea4jlQZe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmsV13xlt+y2FkFVVf2UqvyxqT884Bhj+2WWe/tPzJcQKa23S3w+HvNsa3ujLCR1w
	 e9rXa9pPRdj4mYfH90d+pj3Ew4FJocO2QJbjfVHuLFzwlQDSUMyZ01i6uWJStJwzIV
	 fapeWM5LfkOWBgqgefb05gCpo4hLhPB02/hbQkDeZBt8nIz87YskL5WGxqd4pHP70k
	 zQMA0RY+p7lEKFu69mAzISJxd9UVCyRrpusK6ULHmpDfbLl/ETrzDpgVaO4Vmy8wMP
	 ZVHyB9cla/0yeu/poun3HQq9p8PrlSMClTUe0MEgICLMt4wQkFsFE7lC6cnZYp27O4
	 q28XmsC2Zo0+Q==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	Dave.Martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	tglx@linutronix.de,
	yury.khrustalev@arm.com,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 0/5] Improve arm64 pkeys handling in signal delivery
Date: Tue, 29 Oct 2024 18:28:30 +0000
Message-Id: <173022469291.1156360.488688243050095907.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241029144539.111155-1-kevin.brodsky@arm.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 14:45:34 +0000, Kevin Brodsky wrote:
> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> series [1] that recently landed on mainline. The goal is to improve the
> way we handle the register that governs which pkeys/POIndex are
> accessible (POR_EL0) during signal delivery. As things stand, we may
> unexpectedly fail to write the signal frame on the stack because POR_EL0
> is not reset before the uaccess operations. See patch 1 for more details
> and the main changes this series brings.
> 
> [...]

Applied first patch to arm64 (for-next/fixes), thanks!

[1/5] arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
      https://git.kernel.org/arm64/c/2e8a1acea859

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

