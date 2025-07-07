Return-Path: <linux-kselftest+bounces-36710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F111DAFB859
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712F918840A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF2225A35;
	Mon,  7 Jul 2025 16:08:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77313215062;
	Mon,  7 Jul 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904482; cv=none; b=Ygs7vThZ3vFKP4F7VLv6uRknjD8YlcShQpOWkNlQFWirM7w2I5IvyXmdVu9jSUmhJTYjo7e9XWy5C0uZR40ejf1I7a6xYUqvGiOqTVw2NGdd/rFJo4EBgWccFBJPIVNhmnYSWnj8fTBnL7aOJcewa/4f/FJhQq4Og4EfrzL1FLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904482; c=relaxed/simple;
	bh=2ygqV8EB6mY5V3xqX1r9SYbhNO7fGfzN/oIydN4m5Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKRTwTEax3amSKG7aa5MVUmXLEXXbIs39BsX779dyALgmgp7YuQ+Ko3mOzsUy2FgW+EM6pKDFgQw1XggyGfNr+F5D8ydf5zZ7xZaq/jA6B4+X8V5CmKQf0346RMqfWlVAObHUnH41RY89ccrKeEY+pw8JUwMTZXGzIoC/U+QK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78937168F;
	Mon,  7 Jul 2025 09:07:47 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ADCC3F694;
	Mon,  7 Jul 2025 09:07:56 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:07:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
Message-ID: <aGvw2YojY0vVX_QT@J2N7QTR9R3>
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-3-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200459.1153955-3-coltonlewis@google.com>

On Thu, Jun 26, 2025 at 08:04:38PM +0000, Colton Lewis wrote:
> There's no reason Enums shouldn't be equivalent to UnsignedEnums and
> explicitly specify they are unsigned. This will avoid the annoyance I
> had with HPMN0.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

I realise you've already agreed to drop this, so the below is mostly for
the sake of the archive.

We deliberately kept Enum separate from SignedEnum and UnsignedEnum as
there are enumerated ID fields which have no ordering, and are neither
signed nor unsigned (e.g. CTR_EL0.L1Ip).

That was discussed previously at:

  https://lore.kernel.org/all/Y5MrVC3d8MPhvshE@FVFF77S0Q05N/

We could consider adding a comment to that effect in gen-sysreg.awk, but
that needn't be part of this series.

Mark.

> ---
>  arch/arm64/tools/gen-sysreg.awk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
> index f2a1732cb1f6..fa21a632d9b7 100755
> --- a/arch/arm64/tools/gen-sysreg.awk
> +++ b/arch/arm64/tools/gen-sysreg.awk
> @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields
>  	parse_bitdef(reg, field, $2)
>  
>  	define_field(reg, field, msb, lsb)
> +	define_field_sign(reg, field, "false")
>  
>  	next
>  }
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

