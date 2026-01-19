Return-Path: <linux-kselftest+bounces-49378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5883D3AF28
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 16:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301FF3026AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00F38A9D9;
	Mon, 19 Jan 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnTPBamt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB81A3172;
	Mon, 19 Jan 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836855; cv=none; b=f0qqTFRpZWSiLa7vv8Id3DdetFygQk9i2rPSZj6Y/o4kbVwB0WZwE3w2C4eRXIJnx4t4ZjGrD5FLN6jc0IRUIHd/dj12C/GPo9S6Z0a8IQcB6qcC4BplTd8Wm/DPHG1kS1GT+ixIdqpCkAWhmuCJd9LNm0w5EitUECqYJzLYZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836855; c=relaxed/simple;
	bh=EV9T2myKyHW3Va2uCiNnqCvAhEhltNmAw8tpzkkdAzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0b89vzcTsc0LtnG1/6tXNJKLcbqt3wH2DvX2zHQ67yLTjrzhhB67KohcItqTzdJhsXKQXnRD2pctSIGyANls2drpe/76xnh/6KPFZviSZePZzXMFGJBwPTy7MzwFqqUpgNscTcGTZ31JL/K5fVLp72FCXT4ZEtcqmChFwPfCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnTPBamt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6981CC116C6;
	Mon, 19 Jan 2026 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836854;
	bh=EV9T2myKyHW3Va2uCiNnqCvAhEhltNmAw8tpzkkdAzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnTPBamtcpdz1LcA6KzmSTKkAZ+TFdl7qyRNKWE3Akp48IOYXqvoOqmcFIyjLmtcA
	 j8slHUynBdR7vCN2o5vdKzJJ+AJPt2faLJ7NDN9kmc9vEUgolojkGLCFHaiaM8DGuy
	 ayds765ZMJhLuH/0dSdeAPclWKXpdn/ehgC1SI3hNTv5WrpcA59Shg2UVKLtjNiadm
	 3dnm61SJHT4FfTqP/Z6CuaT9OqoAvL95U62K2ZA0FlZNfEPAR9iEkfm1YIoieddOeO
	 r6fBFs3NruE+FS+bG+MFkqIqDe47vIrXlGpGOlIKd9ZSmW1mpyAJPmYXEWOH+1RsVQ
	 g96pudsYi2RCQ==
Date: Mon, 19 Jan 2026 15:34:07 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, catalin.marinas@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 9/9] arm64: armv8_deprecated: apply FEAT_LSUI
 for swpX emulation.
Message-ID: <aW5O714hfl7DCl04@willie-the-truck>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-10-yeoreum.yun@arm.com>
 <86ms3knl6s.wl-maz@kernel.org>
 <aT/bNLQyKcrAZ6Fb@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT/bNLQyKcrAZ6Fb@e129823.arm.com>

On Mon, Dec 15, 2025 at 09:56:04AM +0000, Yeoreum Yun wrote:
> Hi,
> 
> > On Sun, 14 Dec 2025 11:22:48 +0000,
> > Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > >
> > > Apply the FEAT_LSUI instruction to emulate the deprecated swpX
> > > instruction, so that toggling of the PSTATE.PAN bit can be removed when
> > > LSUI-related instructions are used.
> > >
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> >
> > It really begs the question: what are the odds of ever seeing a CPU
> > that implements both LSUI and AArch32?
> >
> > This seems extremely unlikely to me.
> 
> Well, I'm not sure how many CPU will have
> both ID_AA64PFR0_EL1.EL0 bit as 0b0010 and FEAT_LSUI
> (except FVP currently) -- at least the CPU what I saw,
> most of them set ID_AA64PFR0_EL1.EL0 as 0b0010.

Just to make sure I understand you, you're saying that you have seen
a real CPU that implements both 32-bit EL0 *and* FEAT_LSUI?

> If you this seems useless, I don't have any strong comments
> whether drop patches related to deprecated swp instruction parts
> (patch 8-9 only) or not.
> (But, I hope to pass this decision to maintaining perspective...)

I think it depends on whether or not the hardware exists. Marc thinks
that it's extremely unlikely whereas you appear to have seen some (but
please confirm).

Will

