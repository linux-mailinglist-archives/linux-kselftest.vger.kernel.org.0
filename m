Return-Path: <linux-kselftest+bounces-21206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567999B7A55
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AD71F243CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902119C55C;
	Thu, 31 Oct 2024 12:15:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F71BD9E4;
	Thu, 31 Oct 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376955; cv=none; b=hi0ESdtRp91uMxGMsoAxzMDgooCkASXTB9MjAjYU0k9Ct5PK4ZLvcGvqJtYYbPNGTAh9BTp3lXuq0GiB8IelzgWb+DDAbx41CnUuVRzUUm297+Zk0L6xjsuertgSvFiDH95qutA111XJFHEIk0lIVBNL2cFiVevDEt/rzbyYMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376955; c=relaxed/simple;
	bh=H22SOh/aeE4gJPKnEO/MD9tJP/zNEdQ8sKtea3+LhuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzcOTYqFtKa3VLj0Tgm4NnIfkEMfgu9FD6pZTtt130CMjqtrmWC86RyUco5FB1nqydEhm7w659j0fJnTZ4dyHKjlJQxsNCO0D1cZODcoJbB5T7/SHoIsYcFxsvBdHSR1YFeykKD5pKJdGTTA90S79zgXbrnlsb8v5ZFd2o2dF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468AC4CEDC;
	Thu, 31 Oct 2024 12:15:50 +0000 (UTC)
Date: Thu, 31 Oct 2024 12:15:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Zenghui Yu <yuzenghui@huawei.com>, James Morse <james.morse@arm.com>,
	linux-doc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	kvmarm@lists.linux.dev, Len Brown <len.brown@intel.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Miguel Luis <miguel.luis@oracle.com>, Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v6 0/6] Add PSCI v1.3 SYSTEM_OFF2 support for
 hibernation
Message-ID: <ZyN09BSZqKLXLi6_@arm.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <172989416837.3684225.4795897590830335669.b4-ty@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172989416837.3684225.4795897590830335669.b4-ty@linux.dev>

On Fri, Oct 25, 2024 at 10:12:41PM +0000, Oliver Upton wrote:
> On Sat, 19 Oct 2024 18:15:41 +0100, David Woodhouse wrote:
> > The PSCI v1.3 spec (https://developer.arm.com/documentation/den0022)
> > adds support for a SYSTEM_OFF2 function enabling a HIBERNATE_OFF state
> > which is analogous to ACPI S4. This will allow hosting environments to
> > determine that a guest is hibernated rather than just powered off, and
> > ensure that they preserve the virtual environment appropriately to
> > allow the guest to resume safely (or bump the hardware_signature in the
> > FACS to trigger a clean reboot instead).
> > 
> > [...]
> 
> I grabbed the KVM portions of this series, as they look ready to go. Happy
> to take the last one through kvmarm tree w/ acks, and can toss it on top.

Happy for you to take the last patch as well through the KVM tree. Feel
free to adjust the code comment as you see fit.

-- 
Catalin

