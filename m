Return-Path: <linux-kselftest+bounces-20661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614399B00D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259A1280ECA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF51D363D;
	Fri, 25 Oct 2024 11:04:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0661C1E8834
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854260; cv=none; b=Iev6/aDkKs5m8NIRhY5Nx7PaKrTevAm9FKklfnEqJiNMu/GSmAL/rXejeIqGYaBlm5zQd0bjLopzK0i0yKKhb2+u24lAYJ21S5FpNwchYHWVrrJBElbZe1j7bGjsQtfOoHQzlRyGouSpLkvqoHa9oMIlcLdkDoa1dC5ObR/ouDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854260; c=relaxed/simple;
	bh=Rz1HjbMXSgBYDny7GTFsW97TcQvrfC7O4g14R4ekU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmhilm2rQOo8mW23AMmw+Ugb20h1/hVGeiFRJsoYeNNw+1lc8DuhFDcSpmRxDQddjKDmUsH/BJU1nhgeBvubzcDPVAeu4EI7NQapBzPiLr6rWI30OKDtiovZeBi6DtIz74E/p4+ki2F8iLA2PpviYWHEECL8v4Teki43CUPTHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0115E339;
	Fri, 25 Oct 2024 04:04:47 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066903F73B;
	Fri, 25 Oct 2024 04:04:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:04:09 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	jeffxu@chromium.org, joey.gouly@arm.com, pierre.langlois@arm.com,
	shuah@kernel.org, sroettger@google.com, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <Zxt7KQ2b0oyMp1zR@e133380.arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com>
 <ZxoooqtuqTK5CAMR@arm.com>
 <80688edf-83dd-43c6-a1a8-b69acd30f5c3@arm.com>
 <Zxpq0k3b9q8nWrYa@arm.com>
 <ZxpzexqNIfys3MnJ@e133380.arm.com>
 <d7d00ffc-2e92-46cb-95c2-c877723bcb5d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d00ffc-2e92-46cb-95c2-c877723bcb5d@arm.com>

On Fri, Oct 25, 2024 at 10:24:41AM +0200, Kevin Brodsky wrote:
> On 24/10/2024 18:19, Dave Martin wrote:
> > On Thu, Oct 24, 2024 at 04:42:10PM +0100, Catalin Marinas wrote:
> >> On Thu, Oct 24, 2024 at 04:55:48PM +0200, Kevin Brodsky wrote:
> >>> On 24/10/2024 12:59, Catalin Marinas wrote:
> >>>> On Wed, Oct 23, 2024 at 04:05:09PM +0100, Kevin Brodsky wrote:
> >>>>> +/*
> >>>>> + * Save the unpriv access state into ua_state and reset it to disable any
> >>>>> + * restrictions.
> >>>>> + */
> >>>>> +static void save_reset_user_access_state(struct user_access_state *ua_state)
> >>>>> +{
> >>>>> +	if (system_supports_poe()) {
> >>>>> +		/*
> >>>>> +		 * Enable all permissions in all 8 keys
> >>>>> +		 * (inspired by REPEAT_BYTE())
> >>>>> +		 */
> >>>>> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
> >>>> I think this should be ~0ul.
> >>> It is ~0u on purpose, because unlike in REPEAT_BYTE(), I only wanted the
> >>> lower 32 bits to be filled with POE_RXW (we only have 8 keys, the top 32
> >>> bits are RES0). That said, given that D128 has 4-bit pkeys, we could
> >>> anticipate and fill the top 32 bits too (should make no difference on D64).
> >> I guess we could leave it as 32-bit for now and remember to update it
> >> when we enable more keys with D128. Setting the top RES0 bits doesn't
> >> hurt either since they are already documented in the Arm ARM. Up to you,
> >> it's fine like above as well.
> > Can we maybe just have a brute-force loop that constructs the value
> > using the appropriate #define macros?
> >
> > The compiler will const-fold it; I'd be prepared to bet that the
> > generated code would be identical...
> 
> Fine by me, I suppose I was too eager to use the one-liner I had found
> :) Building that value based on arch_max_pkey() is probably a better
> idea in the long run. (And indeed the codegen is the same, it boils down
> to a mov w0, #0x77777777 in both case.)

The one-line was a neat trick (after the brief WTF moment) :)

I guess my uneasiness comes from baking the number of pkeys in via the
type of 0u and an implicit relationship that this happens to have with
the number bits per pkey in the POR.

[...]

Cheers
---Dave

