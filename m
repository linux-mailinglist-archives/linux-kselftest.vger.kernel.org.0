Return-Path: <linux-kselftest+bounces-23230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E219EDA44
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8649E284288
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1201F2C5A;
	Wed, 11 Dec 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Leq5SNJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE41F0E4A;
	Wed, 11 Dec 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956821; cv=none; b=n/Cy/uYj3J08aiZbSUkx7xekZcC2UqxQPqhV6ljTT/UbSlXFVTfwePsyGNms+nVd/v7uG2GTuOkY5X4rZLT3dl8KVGSiWESyDkglAdh7hvvgT12PuTqY884HqGj+J75i4ryU56U/HHScyumOqspgZ3prs/mE1MqvFRzvIZThx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956821; c=relaxed/simple;
	bh=hD8/P8msz1Ork95b5s3aX3duWl/S0eBHHPkq0olmuXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOeZCfjp0FEvH/cyhM8/Si9iXRwSCF77+hQDtEF9DKI+cLLNmmh2BgZqMV792YcidYB9HhCOKcKYLBGvcS5rKXp8dsgCCyEjiuGMiIO3EPAjEZSO0/kMTR7d7osDob5XuHl0uDO5ulDo6T2NmFnZzM745fkhwCJBp7NDqiJtnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Leq5SNJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC7C4CEDD;
	Wed, 11 Dec 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956821;
	bh=hD8/P8msz1Ork95b5s3aX3duWl/S0eBHHPkq0olmuXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Leq5SNJmh6z5QJtQMQJACDt4lasqGOaOAngRVE/wMFXEMuvlApieRAfGYeEFX5tO8
	 VfHDAn0SvseO7e2tofEC7y9LdInHBx3a8tqkg8rNdP2ITGLM3up/IODHssACnpduCw
	 jOOZ7cxJ/gdeOc95Tvs6I3FdIviZ8j+MIXIEMnR9vWY1KDwdn+l61JI1Pg0lucDqcl
	 WFPZn/cFhqetVURxnNv5m3tCf1k/WG/6JOaU9CSA9NZnuzpDjMy2qm1Okr82ArcRKd
	 ODhqdafz6ncwa62FO6sN1Y8fSqrYW7eTe0ETHyx6wlklenvH9UKWPs3Ic+PzxhDLdV
	 mu4oOmWLtF9ww==
Date: Wed, 11 Dec 2024 22:40:15 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <20241211224015.GB17836@willie-the-truck>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 10, 2024 at 06:43:05PM +0000, Mark Brown wrote:
> On Tue, Dec 10, 2024 at 05:09:55PM +0000, Will Deacon wrote:
> 
> > Can we _please_ just generate this stuff. It feels like we've been
> > making silly typos over and over again with the current approach so
> > either it's hard or we're not very good at it. Either way, it should be
> > automated.
> 
> > Others have managed it [1], so it's clearly do-able.
> 
> Yes, the issues here are not technical ones.  Though there are some
> complications -  eg, IIRC the XML doesn't encode the signedness of
> fields like we do and there's areas where we've deliberately diverged.
> Given the amount of review I end up having to do of sysreg changes your
> reasoning is especially apparent to me.  I've passed this feedback on
> (again).

One thing we _could_ do is have a tool (in-tree) that takes two copies
of the sysreg file (i.e. before and after applying a diff) along with a
copy of the XML and, for the the new fields being added, shows how the
XML represents those compared to the diff. It should then be relatively
straightforward to flag the use of an unallocated encoding (like we had
here) and also things like assigning a field name to a RES0 region.

So this wouldn't be generating the patches from the XML, but more like
using the XML as an oracle in a linter.

Will

