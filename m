Return-Path: <linux-kselftest+bounces-19973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F849A2769
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A84B25609
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED81DE8AF;
	Thu, 17 Oct 2024 15:49:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBB1DED58
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180148; cv=none; b=F0oa2msine4e9IgWIftHw4gKQOS3AJLX7Cjcb9N+i3PGY1TIgbml/eQtMiRU63I6oD6LoUp0pTNrzKfuTLi8dLDFKfjEHdVZsva9jytdy2NRjYtdcEk95zbx9xPNFX10bFkOgDJDR48nAozk788eDsFllAU4961OBMWkkD1qe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180148; c=relaxed/simple;
	bh=lRoPxdpLTdoZAQhI1EVk/2fFRzP5ZhdbQUz6wZMgT5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkC9VV8UovJj54qJhzJRWQ3Njgt7y5xy4OJLyMfHzSrgjyIkzaBtsLwRGBOjE6XpvNIL151nok+af8lzQymb7rNQddD/yXh3Ft73lgUisHXzpzuanyBUOtPa3Cra7IqgRJn3EKBEwEpycnL2Oy2kW/lH/C3KoHhDgoBXCTKFaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4998DFEC;
	Thu, 17 Oct 2024 08:49:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F94F3F528;
	Thu, 17 Oct 2024 08:49:04 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:48:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Message-ID: <ZxEx5aXPX2mHngoB@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-1-kevin.brodsky@arm.com>

On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> series [1] that recently landed on mainline. The goal is to improve the
> way we handle the register that governs which pkeys/POIndex are
> accessible (POR_EL0) during signal delivery. As things stand, we may
> unexpectedly fail to write the signal frame on the stack because POR_EL0
> is not reset before the uaccess operations. See patch 3 for more details
> and the main changes this series brings.
> 
> A similar series landed recently for x86/MPK [2]; the present series
> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> only. This means that a program that sets up an alternate signal stack
> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> before invoking the real signal handler, as discussed here [3].

This feels a bit bogus (though it's anyway orthogonal to this series).

Really, we want some way for userspace to tell the kernel what
permissions to use for the alternate signal stack and signal handlers
using it, and then honour that request consistently (just as we try to
do for the main stack today).

ss_flags is mostly unused... I wonder whether we could add something in
there?  Or add a sigaltstack2()?

[...]

Cheers
---Dave

