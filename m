Return-Path: <linux-kselftest+bounces-23604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B299F7E9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B36516802E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3FD227B82;
	Thu, 19 Dec 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFt1Ko4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CB13A41F;
	Thu, 19 Dec 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623754; cv=none; b=p2+Y9w6I+dh9PfereyiyYlPchZJREwPxTC5EtNME9HFbIRkA5+GYHsujR4ys4C/e0HOFO9oUAC6wxUkFCZVPtSnC6ldlwhwPSLeRn5B1uNSqelfYnqFNCVd4o7RICwkzZ5MkJqb6Y5FGUViMWPQUKp4jdxOTBMQeKnto1nKSnDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623754; c=relaxed/simple;
	bh=ZA3e8tpjMwQOZm128w5m1JOe7wbojppzP4cVWCciqpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNKDWi7qZh9tod/sCGcpwuCRiIsSRRi5KV3nE4htawu8IO9plvv5/HsRrSYUIiIZoMUEJrV5DhxPRUVELihWAQDIGeg/sa4Xx9K4HhNe9XPcIsN6yI3pMKAvhH9pkgJ9FporR8fE53GqtYH3KhxwiFEPEwpXp31kVxWzACalFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFt1Ko4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE05AC4CECE;
	Thu, 19 Dec 2024 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623754;
	bh=ZA3e8tpjMwQOZm128w5m1JOe7wbojppzP4cVWCciqpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFt1Ko4YSU9cU1rH2ogwSoR4bY8c2iHySJQGkHTYQAosWxgiBkosnPKX40IeNXGaB
	 3g9AreisVGT8bqdVM7Z+/tYD5rbyta86EKvBuMqYOvIizMenjvgFfzCkYiX8wto4Qn
	 Zkc3V6MFc2pEgwInun1X6Wz8fJPJOOH8CVazME9CYno/ZmiYc0v4TRVk09zlpiZ3P5
	 bY0YLTEuezQ5x+nGDBBygLzT+xNSCifTl+Nsy4utQ7EpikUjpx3cYaAu2EZzYhC9iy
	 Lux4KzWjFtXrBp1ArHWTEn9c6T1S/kiZkZDwxhMzO5Cg9BxpuvN1BWkuASj4P+Xg9a
	 ICuWsfsKQnXMw==
Date: Thu, 19 Dec 2024 15:55:48 +0000
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
Message-ID: <20241219155547.GC24724@willie-the-truck>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
 <20241210170953.GB16075@willie-the-truck>
 <b859bdcd-7343-4d53-9f3a-f374deca725a@sirena.org.uk>
 <20241211224015.GB17836@willie-the-truck>
 <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248dea18-bfad-4ec9-9a7d-5c87c7f48c84@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 12, 2024 at 11:33:05AM +0000, Mark Brown wrote:
> On Wed, Dec 11, 2024 at 10:40:15PM +0000, Will Deacon wrote:
> > On Tue, Dec 10, 2024 at 06:43:05PM +0000, Mark Brown wrote:
> 
> > > Yes, the issues here are not technical ones.  Though there are some
> > > complications -  eg, IIRC the XML doesn't encode the signedness of
> > > fields like we do and there's areas where we've deliberately diverged.
> > > Given the amount of review I end up having to do of sysreg changes your
> > > reasoning is especially apparent to me.  I've passed this feedback on
> > > (again).
> 
> > One thing we _could_ do is have a tool (in-tree) that takes two copies
> > of the sysreg file (i.e. before and after applying a diff) along with a
> > copy of the XML and, for the the new fields being added, shows how the
> > XML represents those compared to the diff. It should then be relatively
> > straightforward to flag the use of an unallocated encoding (like we had
> > here) and also things like assigning a field name to a RES0 region.
> 
> > So this wouldn't be generating the patches from the XML, but more like
> > using the XML as an oracle in a linter.
> 
> That'd be useful, yes - unfortunately I think that's still something I
> can't work on myself at the moment for the above mentioned non-technical
> reasons.

Is anybody able to work on it? Without insight into the "non-technical
reasons", I don't know what I'm supposed to do other than write the tool
myself (which means finding some spare cycles...) or refusing to take
wholesale sysreg definitions until it's been ironed out :/

Will

