Return-Path: <linux-kselftest+bounces-40061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EBEB3876E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 18:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8523A1B28265
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05B35082F;
	Wed, 27 Aug 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpd2/hr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11A34AAE3;
	Wed, 27 Aug 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310954; cv=none; b=nQ1ZNuBVg0qGWxo176C+1iQaUBKGMyMra4V5R9hjaRjZskPj7zOFVllaEgSFjQ8IH0cDVFAwLO/6oq3R4FWwZ38sRnq3RKuXZ+CMh4Jh9Gl7Gftv3eKoEGdqX60nojv3tRoSla7G9/OQSHDR7WpE++UhMV/S+CyKT46iJe7piyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310954; c=relaxed/simple;
	bh=gedjhTojdtO0Y60ESbJpUNxPxI1ipaR3giWJlyGTs18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sduIW7CV4Ybav3cJfv8KhmBwjJTYOPVrbzrV/F9po0by9KNDpcJQOenbs9MJWyWvsUHPmt5RYQOlv7ClrZmLItSJnwYvTdI2QlgUOmZSHYgDhu8sWURm3YT/Hh1M5mVBXIiw3VA1aRLYXSn4j45eGqkYBLen8EyZ3n67zxic6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpd2/hr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4B0C4CEF0;
	Wed, 27 Aug 2025 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310954;
	bh=gedjhTojdtO0Y60ESbJpUNxPxI1ipaR3giWJlyGTs18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpd2/hr/NuRLMxyGlrswKwdMJMg2QgSf2a5zyxSOD08Vgwx6U1PrFRaR2E7kygq6w
	 I4OmXymHvwPBttuwzCBOHLlbwRRsO2x1ogJqD4roO8ennCR8XNDTJGGx2l8Srf4sOx
	 o6jp3pb/4PDvBAJeDyhrFnNOHDneRo8OFZl0v5nOKV5VkaMrBM6qv3tqGnrAdA9vQf
	 3uu/3/CFPlqTXcVAStdrXwnnWnsNMUhb0d19vCaiMsy0PFkRcE8nO+ThOVnXPvp/MA
	 qFjHG1RWtyqkDPIGqCe6/9ldtJjblxby8LHMOpbg4AwgVfQoKlMAOotuD0lGUnZXo0
	 7TfonItpCEjlg==
Date: Wed, 27 Aug 2025 06:09:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: cgroup: Make test_pids backwards compatible
Message-ID: <aK8tqDoouuFmaYb7@slm.duckdns.org>
References: <20250827155301.174365-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827155301.174365-1-mkoutny@suse.com>

On Wed, Aug 27, 2025 at 05:53:00PM +0200, Michal Koutný wrote:
> The predicates in test expect event counting from 73e75e6fc352b
> ("cgroup/pids: Separate semantics of pids.events related to pids.max")
> and the test would fail on older kernels. We want to have one version of
> tests for all, so detect the feature and skip the test on old kernels.
> (The test could even switch to check v1 semantics based on the flag but
> keep it simple for now.)
> 
> Fixes: 9f34c566027b6 ("selftests: cgroup: Add basic tests for pids controller")
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Tested-by: Sebastian Chlad <sebastian.chlad@suse.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

