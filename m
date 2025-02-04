Return-Path: <linux-kselftest+bounces-25736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD747A27B66
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8864C7A1DA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074E204C21;
	Tue,  4 Feb 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH5Vvc9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B841204698;
	Tue,  4 Feb 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697863; cv=none; b=oha0PD5GbLx0L3Ds8JydVkt+iQ+Pwj2g1cDTJxSTIGvnij2nudk/Ecz7Cg4Zlp7uCNZQ16qQioTvYQAUpRS2tF9BzDNvsDdDnw5OmvdEGkQrBu0UBDj+JEIcZI5xifZAnQ4SFZ7XWYMm5kccXV21yYEyMHfXmW/rljopBXwd/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697863; c=relaxed/simple;
	bh=Q5isih/PoGJ89XqytLFfg5xu0bQkElehQU8kEbn15Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jegEGInbTd9itUVxVaTzHaibgKKb43t8aRSPiO+HnRtsTj3AqbZvdUooVvjAYMaCraJB+yCmLD//DjKES28b5APBg0n4K97Y8DkjSC38MmhozaWZGsSTJB549GTdGsnk4wQQZvvWJc3jBNyH7PcN843wmjKXiqKEkLzSoZuBfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH5Vvc9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6FFC4CEDF;
	Tue,  4 Feb 2025 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697863;
	bh=Q5isih/PoGJ89XqytLFfg5xu0bQkElehQU8kEbn15Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH5Vvc9+otR3UgsI/FLkLghmw0y9r7NvPfWJalHdf2kZvSWT8b0oOf7vqzjbhj3Sk
	 shjFWG9bTlyFluU42X6t/qaZHJ9VcjFiSfRhbHIb37k4MPm/rSiRkrIEQGkgwkd+rE
	 KbdQOLDbrAkR1oecKKexj406sz91CfKpc+TQeH6Ex+s/rUxzY4BhZhUy+DDqsct+mR
	 j3HODnhvOv2+5047CGXLlJuTBkkE6GRdxJLXoV9LzoX79eDkaRZCxg+i4iPdjYq/q0
	 MT0uHWdrO/7FH4iMkmg34HpBDUmQZKvMgU9FEHyKbMDqAps+A4VnxL52/vIRvPE30j
	 RJLqeO5fJIZrA==
Date: Tue, 4 Feb 2025 09:37:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	skhan@linuxfoundation.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/cgroup: use bash in test_cpuset_v1_hp.sh
Message-ID: <Z6JshqGfyv94KVsg@slm.duckdns.org>
References: <20250204192956.50589-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204192956.50589-1-bharadwaj.raju777@gmail.com>

On Wed, Feb 05, 2025 at 12:59:53AM +0530, Bharadwaj Raju wrote:
> The script uses non-POSIX features like `[[` for conditionals and hence
> does not work when run with a POSIX /bin/sh.
> 
> Change the shebang to /bin/bash instead, like the other tests in cgroup.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

Applied to cgroup/for-6.14-fixes.

Thanks.

-- 
tejun

