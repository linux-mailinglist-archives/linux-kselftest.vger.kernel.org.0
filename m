Return-Path: <linux-kselftest+bounces-46865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19058C9A1EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 06:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4852346456
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C912FCC1B;
	Tue,  2 Dec 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oavEaRQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6252FC875;
	Tue,  2 Dec 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654360; cv=none; b=ugsW9mLYW5IAMqcoWYZhLAE0yBd6CbFZqKR+Y5LdjSZVZVabGqaeFp8DPp1PBhWk1JBjBi03/uFloFPf0rVpYXZPPqH2L7/xKXuQ74+YMT0Tgh5+scVpzUT4Qvzjfq2K9wY8zonoMuL1yeD3GYs+5umrpvrOK0va9xiUobjGvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654360; c=relaxed/simple;
	bh=5AGygSHnHPIFSS6YwKZVtMBnpy0dcQQb7F9JR6SgAkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP9WuVvK18EuoO6za7yId1WhnoerR2j0JrdHWCg7neJeo7i78cFRoBKLOc5vu3DaqLnDcndaqbriolWn2Sz3bRNvUW4nKmERsrrJER0GDjy+Bz9IwTqp4yNX9C3E1X+5B+24QC9cB3rzMhxFF7ajcI/YYFMdsoGQQlmswZWtFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oavEaRQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E2C113D0;
	Tue,  2 Dec 2025 05:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764654360;
	bh=5AGygSHnHPIFSS6YwKZVtMBnpy0dcQQb7F9JR6SgAkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oavEaRQ6m5vpG10o/4HokVtjqL5IIEx93eAQR46W7PNtkXWLFsig92HRBCPvDhvVD
	 zccK2Fx1oD+pwkJEd2XfdvmBe8MN7mAFVHi+FqoSfKynFTsBidf/8k/iAhIhfdQ6w9
	 WvtXsGkU7cjK6n78m2d8Guj1BdXHNFD3M7b9Zl5TU3lG+j1UudrJaYTV08wYJLdqBH
	 P3dZSr00YFkOvD9Xnzoa94GLXqtR0EJQ1z3n4sOcqCRbsZdWI2gMHxtODSoRMeX0ww
	 hA4DID/7P2UriNCFX6ajoOvzRm7L3O+mXGbt6Lmt+Nyo4r4J+QQuENPBaiCcSlWBlp
	 cXmtSs0vqFdcw==
Date: Mon, 1 Dec 2025 19:45:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, mkoutny@suse.com, muchun.song@linux.dev,
	lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] selftests: cgroup: Enhance robustness with
 polling helpers
Message-ID: <aS59Fjm1iL5U3-Fn@slm.duckdns.org>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124123816.486164-1-zhangguopeng@kylinos.cn>

On Mon, Nov 24, 2025 at 08:38:13PM +0800, Guopeng Zhang wrote:
> Hi all,
> 
> This patch series introduces improvements to the cgroup selftests by adding helper functions to better handle 
> asynchronous updates in cgroup statistics. These changes are especially useful for managing cgroup stats like 
> memory.stat and cgroup.stat, which can be affected by delays (e.g., RCPU callbacks and asynchronous rstat flushing).
> 
> v4:
>  - Patch 1/3: Adds the `cg_read_key_long_poll()` helper to poll cgroup keys with retries and configurable intervals.
>  - Patch 2/3: Updates `test_memcg_sock()` to use `cg_read_key_long_poll()` for handling delayed "sock" counter updates in memory.stat.
>  - Patch 3/3: Replaces `sleep` and retry logic in `test_kmem_dead_cgroups()` with `cg_read_key_long_poll()` for waiting on `nr_dying_descendants`.

Michal, if this looks good to you, I'll apply after the merge window.

Thanks.

-- 
tejun

