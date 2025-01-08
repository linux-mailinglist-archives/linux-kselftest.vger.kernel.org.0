Return-Path: <linux-kselftest+bounces-24063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0CCA05D0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 14:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE23A5362
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73D1FC7C6;
	Wed,  8 Jan 2025 13:41:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F571FC114;
	Wed,  8 Jan 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343668; cv=none; b=Qbe8tQmWfrl47uqqTjhXQY5KMUt6lpdWxHtuyU7HUAJL4XKbj06uJTSKSHjYfLXJIA6xs8D7qleEpLrvaZGS6ryJWij9cawUTs6BA5GIIKRnTR8VmgwUG5uwtZE3dSborq+jzqsQnhtYN9RX5BU/2FCxOgN3bQMNEjGi0nOIdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343668; c=relaxed/simple;
	bh=53OPs+5laER7KgU/z027K5Vs2KkN85+R9eJRu71IJmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNSiWyLBEWzfwspqk9P/F3M1fEgKmZMX/h8jlFLSY3jj1maHUA3zkx+ev28QULudt3cfLa+oXjaiOlJtX9LhZlgGAw+PbbmS+Ajk6zikz6oJz44bRKqxJfENHL7TtSmWUin2y+VIKBonlXLDEKCv4yEgXwtyGkCsa+zeqUSPFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACABC4CEDD;
	Wed,  8 Jan 2025 13:41:04 +0000 (UTC)
Date: Wed, 8 Jan 2025 13:41:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/5] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <Z36Abq8mrhnl3cg2@arm.com>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
 <20250107-arm64-2024-dpisa-v5-1-7578da51fc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-arm64-2024-dpisa-v5-1-7578da51fc3d@kernel.org>

On Tue, Jan 07, 2025 at 10:59:41PM +0000, Mark Brown wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> The hwcaps code that exposes SVE features to userspace only
> considers ID_AA64ZFR0_EL1, while this is only valid when
> ID_AA64PFR0_EL1.SVE advertises that SVE is actually supported.
> 
> The expectations are that when ID_AA64PFR0_EL1.SVE is 0, the
> ID_AA64ZFR0_EL1 register is also 0. So far, so good.
> 
> Things become a bit more interesting if the HW implements SME.
> In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
> features. And these fields overlap with their SVE interpretations.
> But the architecture says that the SME and SVE feature sets must
> match, so we're still hunky-dory.
> 
> This goes wrong if the HW implements SME, but not SVE. In this
> case, we end-up advertising some SVE features to userspace, even
> if the HW has none. That's because we never consider whether SVE
> is actually implemented. Oh well.
> 
> Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> being non-zero. The HWCAPS documentation is amended to reflect the
> actually checks performed by the kernel.
> 
> Fixes: 06a916feca2b ("arm64: Expose SVE2 features for userspace")
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

