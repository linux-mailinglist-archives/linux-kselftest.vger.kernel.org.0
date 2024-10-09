Return-Path: <linux-kselftest+bounces-19390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6397E99723B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5DEB23109
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D91991B6;
	Wed,  9 Oct 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF5Mti5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102414D71E;
	Wed,  9 Oct 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492414; cv=none; b=RtsepeimK9M7bJjVXgAKLREdGT3/goJq2SGAwwuLOdb9JxOPmRWhbIsyscKzkSAGZfnikTOwAbWECTOPpmbjZ+9z4ul3H/MBUDVx4zmTge3MNS5nI3WtsjO1oIq7EBCJHGPCEZqfgocQqzLacbcT9pjXelGoC3hzUTqTkZA0drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492414; c=relaxed/simple;
	bh=OmUs304wMc8OK5lHEiBWvh96Qrjet1ngSTlBlstJqAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8TCsl4Cu0eCaLEDG6NMo2fNHoee8lnVr4udx/VXMpyJUL+P8oSqTcl7XL9QisOvZhjXUUGEs3IxECZdptlcDcUzncoWLCCTmGIU3RZtUgeoKFoRaX1e/b10S6E5buCRD2M7JtU8wExmw5cOTtHIeFCq3+PvafUIQe4LXZbGnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF5Mti5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568BAC4CECF;
	Wed,  9 Oct 2024 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728492414;
	bh=OmUs304wMc8OK5lHEiBWvh96Qrjet1ngSTlBlstJqAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF5Mti5m4olXLIOVYHM8rSy1xq5UqaFJPLryvEwEvnBQouEZRNjhtRp5b3D1mV+hD
	 EmRdFaGTXK09hR3XM1UeEPopJlTvjvOiX3Ffg9hzg/TZFwUy1Vd0s1YNgkjqc7yRt2
	 xnHtgSgFHKp3LmRMQ2xaZdzNZGgfnjfD96055vhPBT4IM+9cQu+ERhGNO0UBhcVx8F
	 ye0Q+1txEcNEOhA7KR5FOKonT9gE8DmTJjnnfWzqbQ5RRBy8vuuDzO1tFSthAV90ud
	 PAbn8/ERxvU49bKoXta+9B9x+tRI3k8xkjnzD/r/IMBF787TKZ6Xc5abuBRxhBFLgi
	 i1kiey/20DKMA==
Date: Wed, 9 Oct 2024 06:46:53 -1000
From: Tejun Heo <tj@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: David Vernet <void@manifault.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <ZwazfdmNiPmCnWUK@slm.duckdns.org>
References: <20241008153519.1270862-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008153519.1270862-1-bjorn@kernel.org>

On Tue, Oct 08, 2024 at 05:35:18PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
> 
> When building the kselftest suite, e.g.:
> 
>   make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-  \
>     TARGETS=sched_ext SKIP_TARGETS="" O=/output/foo \
>     -C tools/testing/selftests install
> 
> or:
> 
>   make ARCH=arm64 LLVM=1 TARGETS=sched_ext SKIP_TARGETS="" \
>     O=/output/foo -C tools/testing/selftests install
> 
> The expectation is that the sched_ext is included, cross-built, the
> correct toolchain is picked up, and placed into /output/foo.
> 
> In contrast to the BPF selftests, the sched_ext suite does not use
> bpftool at test run-time, so it is sufficient to build bpftool for the
> build host only.
> 
> Add ARCH, CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest. Also, remove some variables that were unused by the
> Makefile.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

