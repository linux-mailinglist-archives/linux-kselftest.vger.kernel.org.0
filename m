Return-Path: <linux-kselftest+bounces-21881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A59C5D46
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD89B35137
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9A206944;
	Tue, 12 Nov 2024 16:07:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE3204015;
	Tue, 12 Nov 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427672; cv=none; b=JT01s6nqpUKIaHDJRoIxXiPbPafUFnO7/KSIDIMqxfgKPDPZXciQ3xX8B1rvL/CmkVhz3iyZwAc/iYNAN10mFC37dIYC5T7wkiyZej0fIkuXYxEQxzZjVB13cVvQGbUI45ju8rD1OWjJaSeprlqbOLh1retEt9B5J8SNYKUx4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427672; c=relaxed/simple;
	bh=cGRxX8zCMAKxPCH0dwX3zwPxv0RLZtFSKaeV863QNdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYIJ2CnQTNw7T4ovHlBla6cTM23heTNoj82FXFl9CA/S1B9qucxEITWlzUg56DJ3FU3hzWFC4pQO7i7gu4wwQfT2qSCM9bUc0CdgF+2b2lURTFb6K2GJj+zjOG0HIqgneQxLntr2sE2a0mJqn6SZN1SQ7m6Y5gxR1bVSJrdVbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D419C4CECD;
	Tue, 12 Nov 2024 16:07:50 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix build with stricter assemblers
Date: Tue, 12 Nov 2024 16:07:33 +0000
Message-Id: <173142698241.893467.6217445754530780538.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
References: <20241108-arm64-selftest-asm-error-v1-1-7ce27b42a677@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 15:20:46 +0000, Mark Brown wrote:
> While some assemblers (including the LLVM assembler I mostly use) will
> happily accept SMSTART as an instruction by default others, specifically
> gas, require that any architecture extensions be explicitly enabled.
> The assembler SME test programs use manually encoded helpers for the new
> instructions but no SMSTART helper is defined, only SM and ZA specific
> variants.  Unfortunately the irritators that were just added use plain
> SMSTART so on stricter assemblers these fail to build:
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fix build with stricter assemblers
      https://git.kernel.org/arm64/c/ae465d9ca192

-- 
Catalin


