Return-Path: <linux-kselftest+bounces-21207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E79B7A5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59171F24158
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C519C560;
	Thu, 31 Oct 2024 12:16:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DBF197A98;
	Thu, 31 Oct 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376983; cv=none; b=PzGWXV/beEuOTSy1Ln3G8q7CXwpaMac45MHV3jxlKZ15VyxyOI90Ij5SHhBMBa5m1pGCrL8Qw1JFEVzH2qj5kWROqnx0eiTWoI4+gEQSS2A9t4da4MBqXX/JsTRgcqQI9QLPQyDJFA68lHTEmtsW0c36HGYz6jer/TW3wmqBDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376983; c=relaxed/simple;
	bh=iQGVGvRF/LkxBjhmqD2B6338yEqS/Vx5HBYv3jadCfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUMFBUEgOHoffpMxfkjSsLdZFw9CTwQSwCUHw5RdxOmzBquMo3boyMBC92G4a51u4nMBtUx+vE6KW2SoV9MzvBAch7J/WnqNte07mMnQK9+1cFKHYZ21b7qFFysNM1vQOCp+3F4KRYZw1bBan8So58YBvn42qXAEoz7eQDPJjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A1C4CEF5;
	Thu, 31 Oct 2024 12:16:18 +0000 (UTC)
Date: Thu, 31 Oct 2024 12:16:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Message-ID: <ZyN1EMPCjdX7zZSB@arm.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019172459.2241939-7-dwmw2@infradead.org>

On Sat, Oct 19, 2024 at 06:15:47PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The PSCI v1.3 specification adds support for a SYSTEM_OFF2 function
> which is analogous to ACPI S4 state. This will allow hosting
> environments to determine that a guest is hibernated rather than just
> powered off, and handle that state appropriately on subsequent launches.
> 
> Since commit 60c0d45a7f7a ("efi/arm64: use UEFI for system reset and
> poweroff") the EFI shutdown method is deliberately preferred over PSCI
> or other methods. So register a SYS_OFF_MODE_POWER_OFF handler which
> *only* handles the hibernation, leaving the original PSCI SYSTEM_OFF as
> a last resort via the legacy pm_power_off function pointer.
> 
> The hibernation code already exports a system_entering_hibernation()
> function which is be used by the higher-priority handler to check for
> hibernation. That existing function just returns the value of a static
> boolean variable from hibernate.c, which was previously only set in the
> hibernation_platform_enter() code path. Set the same flag in the simpler
> code path around the call to kernel_power_off() too.
> 
> An alternative way to hook SYSTEM_OFF2 into the hibernation code would
> be to register a platform_hibernation_ops structure with an ->enter()
> method which makes the new SYSTEM_OFF2 call. But that would have the
> unwanted side-effect of making hibernation take a completely different
> code path in hibernation_platform_enter(), invoking a lot of special dpm
> callbacks.
> 
> Another option might be to add a new SYS_OFF_MODE_HIBERNATE mode, with
> fallback to SYS_OFF_MODE_POWER_OFF. Or to use the sys_off_data to
> indicate whether the power off is for hibernation.
> 
> But this version works and is relatively simple.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

