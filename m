Return-Path: <linux-kselftest+bounces-20248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85619A6185
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AFA1F23CB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D71E47A5;
	Mon, 21 Oct 2024 10:06:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3441E0DD6
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505195; cv=none; b=Dp1Yos2qemTiG1pcVw1kVQzVZkxiZcfoEQOXDYRvgdyMSMRozR0H0rHMdA2Udfr+S3h/0Z5lyGp/QBEf9jdp2zyEXjFdOujaIaC0jYeq24yXFvFM88YuYbaIZyMHtk5vaBfNa7z3IYQRL2jiVHrsXNByOR3J3PHMhDCyH4TQBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505195; c=relaxed/simple;
	bh=5yxIvM/q7hEra3NiLu1dppB10SS3WKaWw2cNVD3BDUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY0eJn8Jjh0fFkwu0SdXclJ+TcWw8rGx6hPgQbxLraaXQdgV43rcda07ZtvOEg7d6zaWy/Hliq3RjDbzeh7seg0JhL3qG25X+5hr4K6SWB0WYA5B7ohQcqDWZxVDq59VUs2lfw4XvloIV0ccOkCzufODM5J8HNfQgutMnTOBgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72015DA7;
	Mon, 21 Oct 2024 03:07:02 -0700 (PDT)
Received: from [10.57.65.82] (unknown [10.57.65.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E003F73B;
	Mon, 21 Oct 2024 03:06:28 -0700 (PDT)
Message-ID: <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
Date: Mon, 21 Oct 2024 12:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, jeffxu@chromium.org,
 joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, pierre.langlois@arm.com
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxEx5aXPX2mHngoB@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 17:48, Dave Martin wrote:
> On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
>> This series is a follow-up to Joey's Permission Overlay Extension (POE)
>> series [1] that recently landed on mainline. The goal is to improve the
>> way we handle the register that governs which pkeys/POIndex are
>> accessible (POR_EL0) during signal delivery. As things stand, we may
>> unexpectedly fail to write the signal frame on the stack because POR_EL0
>> is not reset before the uaccess operations. See patch 3 for more details
>> and the main changes this series brings.
>>
>> A similar series landed recently for x86/MPK [2]; the present series
>> aims at aligning arm64 with x86. Worth noting: once the signal frame is
>> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
>> only. This means that a program that sets up an alternate signal stack
>> with a non-zero pkey will need some assembly trampoline to set POR_EL0
>> before invoking the real signal handler, as discussed here [3].
> This feels a bit bogus (though it's anyway orthogonal to this series).

I'm not very fond of this either. However I believe this is the correct
first step: bring arm64 in line with x86. Removing all restrictions
before uaccess and then setting POR_EL0 to POR_EL0_INIT enables
userspace to use any pkey for the alternate signal stack without an ABI
change, albeit not in a very comfortable way (if the pkey is not 0).

> Really, we want some way for userspace to tell the kernel what
> permissions to use for the alternate signal stack and signal handlers
> using it, and then honour that request consistently (just as we try to
> do for the main stack today).
>
> ss_flags is mostly unused... I wonder whether we could add something in
> there?  Or add a sigaltstack2()?

Yes, this would be sensible as a second step (backwards-compatible
extension). Exactly how that API would look like is not trivial though:
is the pkey implicitly derived from the pointer provided to
sigaltstack()? Is there a need to specify another pkey for code, or do
we just assume that the signal handler is only using code with pkey 0?
(Not a concern on x86 as MPK doesn't restrict execution.) Would be very
interested to hear opinions on this.

Kevin

