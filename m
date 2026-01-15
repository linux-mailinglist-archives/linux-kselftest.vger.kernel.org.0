Return-Path: <linux-kselftest+bounces-49032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B85D24A6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 14:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406F130317B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA57239E18C;
	Thu, 15 Jan 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMG03Zuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A339C65F;
	Thu, 15 Jan 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482181; cv=none; b=PUFRgYz/D5HKNFQKH2398T748RV5FI4MOl6OuAq/QE5hUP28YEU8zift+KtYx9FHT/HY36h2B7CG+XnRrod1LEFi+DD1TdEbTHgoMroFLnlSCisSfnzZy2tArR7OmO1fIf+bFTy0FYXpK3Qxp8e9D5UiBw3TRYOLYRqvZ2lznAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482181; c=relaxed/simple;
	bh=1gDjKnngSQPKg3Vknl3yXRygZb7k/1wDPmUo8MM+pc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld8rsnbvEEq+AoZ8iBn7nm7NWDy8YtHJNHHBTqMF835k3J3JMqIGavKTBxpo1hbVH4iyIY3QESrTtIER5Oo6FP4mZuDJXC9gk7GyA+9hqFmZd3l4kIP2bizLpUvw5TOdUFwDPf+4h32EeEk1bQc5dYKhm9Vp1vj/ksnOtLDfk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMG03Zuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63564C116D0;
	Thu, 15 Jan 2026 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768482181;
	bh=1gDjKnngSQPKg3Vknl3yXRygZb7k/1wDPmUo8MM+pc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMG03Zuo6Csrn6WHfCHjDfqu1QbA8uAASYMKnXqefFqhoOux1p1rY/Bwqbw/hy4De
	 bFSSVdOGRrHgXAccrBwi+7qgrFZK3oqciJJa4Uj9MUJXFp4w+glQNmNY2dQ8RgkuhR
	 W9XKUFkXsbs7TrN6K7Qd5J7y7xu5ls6lKJhot/zqZZfA9ce+XmsUHF+MEx9fPq/7PJ
	 Qz+ztj4Z/wba1kgw/z69ZjK534VDYhrcs3m/ZYfZGq5RGFynVoMIWZdrAK1ceHmXSG
	 1/PTmhGrATF9c7+kHeA+pEWO5a7+fGhRjvvWo1OfFy1C8slWsPpCOMGyLqxZ3VwTXr
	 2/NGACdF6j6CA==
Date: Thu, 15 Jan 2026 13:02:54 +0000
From: Will Deacon <will@kernel.org>
To: Oliver Upton <oupton@kernel.org>
Cc: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
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
Message-ID: <aWjlfl85vSd6sMwT@willie-the-truck>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <aTiqK7gKKKzGGwgW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTiqK7gKKKzGGwgW@kernel.org>

On Tue, Dec 09, 2025 at 03:00:59PM -0800, Oliver Upton wrote:
> On Tue, Dec 09, 2025 at 08:50:57PM +0000, Colton Lewis wrote:
> > This series creates a new PMU scheme on ARM, a partitioned PMU that
> > allows reserving a subset of counters for more direct guest access,
> > significantly reducing overhead. More details, including performance
> > benchmarks, can be read in the v1 cover letter linked below.
> > 
> > An overview of what this series accomplishes was presented at KVM
> > Forum 2025. Slides [1] and video [2] are linked below.
> > 
> > The long duration between v4 and v5 is due to time spent on this
> > project being monopolized preparing this feature for internal
> > production. As a result, there are too many improvements to fully list
> > here, but I will cover the notable ones.
> 
> Thanks for reposting. I think there's still quite a bit of ground to
> cover on the KVM side of this, but I would definitely appreciate it if
> someone with more context on the perf side of things could chime in.
> 
> Will, IIRC you had some thoughts around counter allocation, right?

Right, I was hoping that the host counter reservation could be more
dynamic than a cmdline option. Perf already has support for pinning
events to a CPU, so the concept of some counters being unavailable
shouldn't be too much for the driver to handle. You might just need to
create some fake pinned events so that perf code understands what is
happening.

Will

