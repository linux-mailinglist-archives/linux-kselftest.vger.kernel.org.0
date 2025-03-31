Return-Path: <linux-kselftest+bounces-29967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA19A7715D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 01:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3CF3A7EF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 23:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5B215779;
	Mon, 31 Mar 2025 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrKthTcD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113619E96D;
	Mon, 31 Mar 2025 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463738; cv=none; b=QK+swDb+1YXfkSeXemAMAOm3fvajSsewWCjqjxvbeXuKENIWexmgZ7y/5Y38VKU3oxNgPvnnr73EsM08yT1AM3W6gpJ7SgkYA+mi2j2HDpC0Zdw+oaF9xXD9qvKwK+ljpP47gWrFo9mSh/4DI0KhWVGbxhGcGEs/iqAV44mY1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463738; c=relaxed/simple;
	bh=Bbaj4Lji//+qrYiN5JSR/ULnSVr2NQQMV1fGOrqgM3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYtlJyDXqcxBr8Co2KA5Hy7L5JYOO0mRufK21MHcpSC+m0ogs2JD/jWwgKIiRZWqpP7pGPMKPxprDVafRtyOLdV8kMIa97O8oIRVuqeKC+729SnAwx2WLD4oyqZpDDobftBnsNTZYHK3x/RTLwKqFCLvDJrI7EZmUsvQMBFsxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrKthTcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24656C4CEE3;
	Mon, 31 Mar 2025 23:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743463738;
	bh=Bbaj4Lji//+qrYiN5JSR/ULnSVr2NQQMV1fGOrqgM3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrKthTcDD1cdvokSj8sWPBBVHp9JnZC3h5ffuEP+2hO2pm1tKE/I9tLMq23bWftK1
	 yj7caeUflItqK592Qm1XEN+o83Cju84wP6BedyVhJjJhKsda3BI9xotvmynCtdP9FL
	 JBXI//QE9T3/jM85keeznJ7nPZk9ynLRbs3p+xkzEcONLpqWYiZ44Mo+2vTKegPG+d
	 7XJQ6fskpKt736gJxXOIf1N9iAy/dc1ZOlfdmQrrTfxgb2GNCpvu1XYsPr0QsGj1Dx
	 Fz5JAq7iMCi81uoNtXfpf9ECDPme1+9DUI2vCI/RNNvLgOJG5iydfYcpNmmC4KRr85
	 O4062BK1iVrXg==
Date: Mon, 31 Mar 2025 13:28:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/10] selftest/cgroup: Add a remote partition transition
 test to test_cpuset_prs.sh
Message-ID: <Z-slObRzEv-VFuGb@slm.duckdns.org>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-11-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-11-longman@redhat.com>

On Sun, Mar 30, 2025 at 05:52:48PM -0400, Waiman Long wrote:
> The current cgroup directory layout for running the partition state
> transition tests is mainly suitable for testing local partitions as
> well as with a mix of local and remote partitions. It is not that
> suitable for doing extensive remote partition and nested remote/local
> partition testing.
> 
> Add a new set of remote partition tests REMOTE_TEST_MATRIX with another
> cgroup directory structure more tailored for remote partition testing
> to provide better code coverage.
> 
> Also add a few new test cases as well as adjusting existig ones for
> the original TEST_MATRIX.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied 2-10 to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

