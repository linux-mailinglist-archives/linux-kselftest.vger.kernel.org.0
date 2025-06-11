Return-Path: <linux-kselftest+bounces-34669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DABAD50B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD41189406D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2525F980;
	Wed, 11 Jun 2025 09:59:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C6239E72;
	Wed, 11 Jun 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635954; cv=none; b=PUa7ksOjmI9Hl6Ot77E+zLwzsfl8aydDihahUAkyilLT436Fml4gS8WbTmCFUFHDi9/ZxlYYu2+/Kq8FM6K44udr2Ld+8KdhIfofz8Zd7xv192ALjXAyGs4v/rsbDYFAYnQOvZ2k8vAXpJ9+utGmcOhGlMwSnL0GUy9uyuzsh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635954; c=relaxed/simple;
	bh=HwXs6qp3W7EZHA1+yzvKN6nMOhRAgv4bEYIrYnnhwjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/sXy8AsghOHelsubfvbgYGNIYYzqjcZerTFFGhhYHmFQhbx9S6OY2BJDzoYciZGYeqwIi/k7Nwqk33lMQBImJqTatD9R9kkCyY85JmLZe6/UxoLxj9AhmPPBmuWZ7Dm9y8CAEQcIWaD1+NvZ4BM6q42GH4N2ixR1TQl/dI3bl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2651596;
	Wed, 11 Jun 2025 02:58:52 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999603F673;
	Wed, 11 Jun 2025 02:59:09 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:59:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V3 2/2] KVM: selftests: Change MDSCR_EL1 register holding
 variables as uint64_t
Message-ID: <aElTaqOqzAi17H2b@J2N7QTR9R3>
References: <20250610053128.4118784-1-anshuman.khandual@arm.com>
 <20250610053128.4118784-3-anshuman.khandual@arm.com>
 <864iwnedjk.wl-maz@kernel.org>
 <9b378582-44eb-4fbb-a03a-40eb317daebd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b378582-44eb-4fbb-a03a-40eb317daebd@arm.com>

On Wed, Jun 11, 2025 at 09:15:10AM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/06/25 10:31 PM, Marc Zyngier wrote:
> > On Tue, 10 Jun 2025 06:31:28 +0100,
> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >>
> >> Change MDSCR_EL1 register holding local variables as uint64_t that reflects
> >> its true register width as well.
> >>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Oliver Upton <oliver.upton@linux.dev>
> >> Cc: Joey Gouly <joey.gouly@arm.com>
> >> Cc: kvm@vger.kernel.org
> >> Cc: kvmarm@lists.linux.dev
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-kselftest@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  tools/testing/selftests/kvm/arm64/debug-exceptions.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/kvm/arm64/debug-exceptions.c b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
> >> index c7fb55c9135b..e34963956fbc 100644
> >> --- a/tools/testing/selftests/kvm/arm64/debug-exceptions.c
> >> +++ b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
> >> @@ -140,7 +140,7 @@ static void enable_os_lock(void)
> >>  
> >>  static void enable_monitor_debug_exceptions(void)
> >>  {
> >> -	uint32_t mdscr;
> >> +	uint64_t mdscr;
> >>  
> >>  	asm volatile("msr daifclr, #8");
> >>  
> >> @@ -223,7 +223,7 @@ void install_hw_bp_ctx(uint8_t addr_bp, uint8_t ctx_bp, uint64_t addr,
> >>  
> >>  static void install_ss(void)
> >>  {
> >> -	uint32_t mdscr;
> >> +	uint64_t mdscr;
> >>  
> >>  	asm volatile("msr daifclr, #8");
> >>  
> > 
> > Why change this in the place that matters *the least*?
> > 
> > arch/arm64/kernel/debug-monitors.c is full of 32bit manipulation of
> > this register, and that's only one example of it. So if you are going
> > to change this, please do it fully, not as a random change in a random
> > file.
> 
> The first patch in this series changes mdscr system register to 64 bit
> in the mentioned file (i.e arch/arm64/kernel/debug-monitors.c). 

You did not Cc Marc on oatch 1 or the cover letter. KVM folk are only
Cc'd on patch 2.

Marc, for context the series is:

  https://lore.kernel.org/linux-arm-kernel/20250610053128.4118784-1-anshuman.khandual@arm.com/

... and I've asked Anshuman to better describe the rationale.

Mark.

