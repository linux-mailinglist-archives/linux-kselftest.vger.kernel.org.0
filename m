Return-Path: <linux-kselftest+bounces-47348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8419CB1600
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 00:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D43303C807
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC7C2FFFAE;
	Tue,  9 Dec 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Z2s9JW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AC309EFB;
	Tue,  9 Dec 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321262; cv=none; b=SDkssKiPqoHVidRY69G3QI2R/Lgn5rt/zbh2fDHzm4FCTBHnbVgTDfUzpdX4MI+ZuunuHYzCM/ZRa8OdMwRoCdqVpDV0tdQ1eUeMdotrmB6LfM/l5RRZDRtqlK3RHbh46hUlk02G61KwfPr6cQXsQ8WrQN3y4zvLvvvFqk3+9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321262; c=relaxed/simple;
	bh=/ah7Zqz2nEXNAxPK4fIH6Lzc/09WmhDQtHjd6n9mOeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB+PRSXq6143uOWLzdsoL7LgghzoOkAbxWRK7ZhOlkBaMzzzcGG0Z7KwEdQP01fqd5/niFHK5UduPLxnYGPLTcW0SMB+kItbXrNFcp59EnGh3RXFjdJ2uR2gHdM/+4sTWA1GEqA9yg3fRT5LOAzhTUVN0+GNpoigatxceen6K9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Z2s9JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360C2C4CEF5;
	Tue,  9 Dec 2025 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765321261;
	bh=/ah7Zqz2nEXNAxPK4fIH6Lzc/09WmhDQtHjd6n9mOeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1Z2s9JWfojscSVTnJwydD7UV4xdGcvwgbFKC8mdeuCUIQGwCGyf+uTghHKUBkIbu
	 ZPRz8fO0uNalxMF/ozlxNYLd+Apyru/mijc2WT70RTagFeAOyjPcLQAU4zLBxFcMCl
	 PcjmeDS2LWJ2KAibw5ZtxQdXj/FP62jnY69/yJ8KzjFOsqNxk3bj/WbI9aAMzQrnwo
	 p3B3CkuN3cfv46RHfhNytOPrt5Qn9eFQrZr+py3CzHyMWVIX/dQb3/n5njtU3b0Ip0
	 udpcHzXK1FdWrvrirQyGdPNfrzcAy3d5nEfHa6ssb2rKx+7J54erVlG5dJEepmb+EN
	 HPka7oYuHd9og==
Date: Tue, 9 Dec 2025 15:00:59 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 00/24] ARM64 PMU Partitioning
Message-ID: <aTiqK7gKKKzGGwgW@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:50:57PM +0000, Colton Lewis wrote:
> This series creates a new PMU scheme on ARM, a partitioned PMU that
> allows reserving a subset of counters for more direct guest access,
> significantly reducing overhead. More details, including performance
> benchmarks, can be read in the v1 cover letter linked below.
> 
> An overview of what this series accomplishes was presented at KVM
> Forum 2025. Slides [1] and video [2] are linked below.
> 
> The long duration between v4 and v5 is due to time spent on this
> project being monopolized preparing this feature for internal
> production. As a result, there are too many improvements to fully list
> here, but I will cover the notable ones.

Thanks for reposting. I think there's still quite a bit of ground to
cover on the KVM side of this, but I would definitely appreciate it if
someone with more context on the perf side of things could chime in.

Will, IIRC you had some thoughts around counter allocation, right?

Best,
Oliver

