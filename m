Return-Path: <linux-kselftest+bounces-20716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7199B125F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 00:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7391F21763
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E91D9A46;
	Fri, 25 Oct 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GsqKIeiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD6217F30
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894380; cv=none; b=jedkGx2YiU0AD2j8l460tRTre6O/jvlfhBQXyLIOBBmzjafgONs4a8EKDUTqCV2228Gc7CYgxiDvBYzkMSF261Z0GbaGP7YEyKMWjvzZLm44lnAs+0RzMFkN7xEaegPDHDNX+z/rqY0liR4H4tXSYxa3BOugQMA4PzbPAquHy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894380; c=relaxed/simple;
	bh=wLE7gbHS/zil2nem3fEemkkOYe/GUpOOrZThEvr7q0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm8qh/hTCCXGyBpTL6QdkVuiVHJ6NOmDQiKKNC6AqnlwbEOsUjzanehvs5HIRTZKNIWHy27SOWWbahtHeuOBD3amPnK+Cvg6bq9PUnMWOj/7kEVNdTZRs2JIUzi25aQtUsx9pJ2xETlj6/lOxCcfh6fK7xUULSr/A+9U5vtlQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GsqKIeiV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729894375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zT1JrWE0wCzIdFq3Ykrqf07oSRTFil0hjG6CI7HG/ls=;
	b=GsqKIeiVrOjDeIqr8pui3jQ5t9ZLl0riwXzeEm3iMypLtUcBfhsFMieprt7Jp5OCC0vXYD
	VeR8QxXxWX+5gPplyWcBcmvxVFiiLWnU3/GseaivcagIBJbS3cu7H4+xzUuK/o30WeNPCG
	EK6wMoMIt90L9dhTT5SxTL+0e1zn780=
From: Oliver Upton <oliver.upton@linux.dev>
To: Zenghui Yu <yuzenghui@huawei.com>,
	James Morse <james.morse@arm.com>,
	linux-doc@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Marc Zyngier <maz@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	kvmarm@lists.linux.dev,
	Len Brown <len.brown@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Miguel Luis <miguel.luis@oracle.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: (subset) [PATCH v6 0/6] Add PSCI v1.3 SYSTEM_OFF2 support for hibernation
Date: Fri, 25 Oct 2024 22:12:41 +0000
Message-ID: <172989416837.3684225.4795897590830335669.b4-ty@linux.dev>
In-Reply-To: <20241019172459.2241939-1-dwmw2@infradead.org>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sat, 19 Oct 2024 18:15:41 +0100, David Woodhouse wrote:
> The PSCI v1.3 spec (https://developer.arm.com/documentation/den0022)
> adds support for a SYSTEM_OFF2 function enabling a HIBERNATE_OFF state
> which is analogous to ACPI S4. This will allow hosting environments to
> determine that a guest is hibernated rather than just powered off, and
> ensure that they preserve the virtual environment appropriately to
> allow the guest to resume safely (or bump the hardware_signature in the
> FACS to trigger a clean reboot instead).
> 
> [...]

I grabbed the KVM portions of this series, as they look ready to go. Happy
to take the last one through kvmarm tree w/ acks, and can toss it on top.

Applied to kvmarm/next, thanks!

[1/6] firmware/psci: Add definitions for PSCI v1.3 specification
      https://git.kernel.org/kvmarm/kvmarm/c/2f2d46959808
[2/6] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for hibernation
      https://git.kernel.org/kvmarm/kvmarm/c/97413cea1c48
[3/6] KVM: arm64: Add support for PSCI v1.2 and v1.3
      https://git.kernel.org/kvmarm/kvmarm/c/8be82d536a9f
[4/6] KVM: selftests: Add test for PSCI SYSTEM_OFF2
      https://git.kernel.org/kvmarm/kvmarm/c/72be5aa6be4a
[5/6] KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
      https://git.kernel.org/kvmarm/kvmarm/c/94f985c39a1e

--
Best,
Oliver

