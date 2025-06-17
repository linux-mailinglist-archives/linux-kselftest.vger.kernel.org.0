Return-Path: <linux-kselftest+bounces-35223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA3ADDB2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E116B04E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F402EBB89;
	Tue, 17 Jun 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A69jbRYl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2172EBB85;
	Tue, 17 Jun 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184032; cv=none; b=M9Zp2/M00sWKsTPhkjekE/j7yWjgyMwkuB0b065FuHMz13QqXIkVD0zZ+5lsKB2rGm3n6IMY64Mgp2k0E9a5FaRDRQh66HwFxZXj1Q88q9A0XltbWjzq9tcilgmvc4p3VmLHSSE/4jvrmZqV95UWAq7smHQjtGhX1kHocd6f73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184032; c=relaxed/simple;
	bh=VmZXPBLMF0zie706MFAs++AVMntXL2DLlnrW9DgPw08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMaKF2jW+RWt4kK/B/rl9CGXWYhn1DFNreohXo7SjOX3rzt9OrSDmk9oRytqvlCKqFQuNizRFgD3hnvzUw+tVtRKPtKXyIl5btSrt9uqQ+6BEy9TuNLaxbv3iAFaCMl8A3vOtsSp908dRcb/0GEASJFrV98S4QcJ+kSSNmaTVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A69jbRYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784ADC4CEE3;
	Tue, 17 Jun 2025 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750184031;
	bh=VmZXPBLMF0zie706MFAs++AVMntXL2DLlnrW9DgPw08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A69jbRYle9MKG8B9In09AHJ8TPl5CPbzIXYmdER4lY3zsldkTgA5F6sNoqyJZP7X2
	 kOyQfc20kzUzLqsctU1EB8FsIiM7Bdxq8WF3ZJELTH3loVys/XDJ5RJ13V7VvT00QJ
	 B0oLzxbJnQUxzsHChmMeFFTxF7gDq+QHABNu+F/NLNOGlJOR0IfMyKtvPLEcNGrP41
	 nwy4M6urJt5z5uMtgM8QFkFORBEmmseK0lqQB9JgKi9nzvHwV3arSwV6Vzh4ujWktx
	 0a9z7KY3JJ0zNjV5Bkj4g4r6mwotkIIRgTvniWXHjlQt1Ul4rH2eB1t10YyPHE2XaQ
	 QrSviCLTZ2vVg==
Date: Tue, 17 Jun 2025 08:13:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/4] selftests: cgroup: Add support for named v1
 hierarchies in test_core
Message-ID: <aFGwXkU2RjQHsvaL@slm.duckdns.org>
References: <20250617133701.400095-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617133701.400095-1-mkoutny@suse.com>

On Tue, Jun 17, 2025 at 03:36:52PM +0200, Michal Koutný wrote:
> Michal Koutný (4):
>   selftests: cgroup_util: Add helpers for testing named v1 hierarchies
>   selftests: cgroup: Add support for named v1 hierarchies in test_core
>   selftests: cgroup: Optionally set up v1 environment
>   selftests: cgroup: Fix compilation on pre-cgroupns kernels

Applied to cgroup/for-6.17.

Thanks.

-- 
tejun

