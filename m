Return-Path: <linux-kselftest+bounces-21863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD289C5916
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666F01F21BE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17FD17CA1F;
	Tue, 12 Nov 2024 13:27:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E615444E;
	Tue, 12 Nov 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418020; cv=none; b=uAIS7fmH7bGQIKqrWG6xWPz6WmiNvYlRaItShwUMeJOPjR99pX6CouDSBqmikiXnxkh+MN2tXquUiEitG61kcjXhjKlxmWN6yFainjQyf3EJ+QHGfUFTmhknINorn+2WQP79EcLgjasz536+7QyWR9AVkMK+qSgtpRDDsGQVy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418020; c=relaxed/simple;
	bh=KxBO7TK2j7CBcq2xRoLJlH6ltVnB5weCo12QHsW60WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4rJmpAIWcuqqadCTvJe6R1rRMqHZBapxGnLMldAOC6ZQkf1UW1Mn56OsY+s5fonto9Xm+OdhcgzqhGTrAy/CTE5ezHgbvlvpGuYUNi6cSkYkQYy6Q2413uIfNTasYnaUBCzK/QgRdsJwCkPEVf0YD44u4fqOf5XXYe434hv4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADA9625E3;
	Tue, 12 Nov 2024 05:27:26 -0800 (PST)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.30.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F62A3F66E;
	Tue, 12 Nov 2024 05:26:55 -0800 (PST)
Date: Tue, 12 Nov 2024 13:26:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kselftest/arm64: Add FPMR coverage to fp-ptrace
Message-ID: <ZzNXnJ3Jc45CctCs@arm.com>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
 <20241112-arm64-fp-ptrace-fpmr-v2-3-250b57c61254@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-arm64-fp-ptrace-fpmr-v2-3-250b57c61254@kernel.org>

On Tue, Nov 12, 2024 at 01:08:16PM +0000, Mark Brown wrote:
> +	// This has to come after we set PSTATE.SM
> +check_fpmr_in:
> +	tbz	x0, #HAVE_FPMR_SHIFT, wait_for_writes
> +	adrp	x7, fpmr_in
> +	ldr	x7, [x7, :lo12:fpmr_in]
> +	msr	FPMR, x7

Did this build for you? I may not have a new enough assembler.

fp-ptrace-asm.S:149:6: error: expected writable system register or pstate
 msr FPMR, x7

I changed it to REG_FPMR locally.

-- 
Catalin

