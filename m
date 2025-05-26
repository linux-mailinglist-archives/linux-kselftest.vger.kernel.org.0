Return-Path: <linux-kselftest+bounces-33775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B4FAC3DC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE54C1745E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DB1F4E4F;
	Mon, 26 May 2025 10:23:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23861F463B;
	Mon, 26 May 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255015; cv=none; b=bRa1AQa6nhLDMuL10e26HA3xv+S9O2ZF4ryqgaV/WgXTN0Cno9m2xPkZ6LVy2I2m8nCnJJNv0Zgp1nQed5ur76BMOfp297xtZlpxleNM3W03EaCKt2zPIUydrKIHsZTKv+lkzVlbYehlPsbLyaU1/2U+vqnk5u62taZVePRXcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255015; c=relaxed/simple;
	bh=Cg3w/aTss7Xq9PEh9oXqGyGb9ze/I/m78kwhXSI3dxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4q6dieYcTb1HzFlcDlgV5WJgsdYMJxClkK7RSRwsili3pj3cYrTgqeTQa4tsCJLEBGOvZZyqL6SzmmkNBjfGxfQZcgzITQ/RS+4ZpZX63dwMjIuTw0kV5DRRwoFhnrnaxeInchj1kxL8pKxjnHjaZYLJ5SljfyT2GyxLfuYShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32BE72F;
	Mon, 26 May 2025 03:23:16 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378BE3F5A1;
	Mon, 26 May 2025 03:23:30 -0700 (PDT)
Date: Mon, 26 May 2025 11:23:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] kselftest/arm64: Update sve-ptrace for ABI changes
Message-ID: <aDRBHDJZyXnic6i7@J2N7QTR9R3>
References: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-kselftest-arm64-ssve-fixups-v1-0-65069a263b21@kernel.org>

On Fri, May 23, 2025 at 04:27:11PM +0100, Mark Brown wrote:
> Mark Rutland's recent SME fixes updated the SME ABI to reject any
> attempt to write FPSIMD register data via the streaming mode SVE
> register set but did not update the sve-ptrace test to take account of
> this, resulting in spurious failures.  Update the test for this, and
> also fix another preexisting issue I noticed while looking at this.

For the sake of the mail archive, that series of fixes was:

  https://lore.kernel.org/linux-arm-kernel/20250508132644.1395904-1-mark.rutland@arm.com/

Evidently I only fixed up the fpsimd-ptrace tests, and missed the
sve-ptrace tests. My bad; sorry about that.

Mark.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (3):
>       kselftest/arm64: Fix check for setting new VLs in sve-ptrace
>       kselftest/arm64: Fix test for streaming FPSIMD write in sve-ptrace
>       kselftest/arm64: Specify SVE data when testing VL set in sve-ptrace
> 
>  tools/testing/selftests/arm64/fp/sve-ptrace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> ---
> base-commit: 1c1abfd151c824698830ee900cc8d9f62e9a5fbb
> change-id: 20250523-kselftest-arm64-ssve-fixups-b68ae61c1ebf
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

