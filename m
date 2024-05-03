Return-Path: <linux-kselftest+bounces-9398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11B8BB224
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EB41C21A9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020B158212;
	Fri,  3 May 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr6+aV4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D715359B;
	Fri,  3 May 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759596; cv=none; b=RxUSkquVJoGNmhzrpAAWm31/aissZCJ/VFbe6F7274oD/AzmYz01JOcKGmIuFV6qnsluXB+4wtpSia7mEdmiS0SZF07DAzLHSXowh9fc1N34HY6VMB4kmDHTEA7Wfff+B0NYCQBeKmzyfEz+kmR9XKm4umRGW2VHz6amt1EYols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759596; c=relaxed/simple;
	bh=eZHc3+HDuXQRkSr68soKZWf/U0hOwVb3v5Yz0qKASQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+RiCfShY5f+cfWYdfWDckyfb//e9GSLQAJNxhnOkli/4lNzFStxKrOu6ORmZswE8hL7sTu4UQEIHEl5ddKepM0v0VyLHJqg+H0AkDEM65IzbR5z5WGo+PxX0FeZPV2Z9clxj+D1i5Tqz7dq38BnSYqGofzoMoS1bjhH6C4zCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr6+aV4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A216C116B1;
	Fri,  3 May 2024 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759596;
	bh=eZHc3+HDuXQRkSr68soKZWf/U0hOwVb3v5Yz0qKASQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hr6+aV4S49DHFrNX7b8XaR0ZcqrILVkIeva6hMX92BrKJhaEtfus465cVAmKtH8L0
	 9p+lbt8q60KgnTLIlBO28xLeL7iiHDt7jJJGqxbeydDaIt2ZQbI+QwCppPaA1Kpf/P
	 2VOSRRuztTku7/K0K8PHRnJ8VK8Ugm9+sCV4oK5boXyt64KiYZvj/afQ9Va8V1PWt5
	 PWpr18PSV6tdXlaAaurrnMrF2WrRjCqwCUGJbQZSW6nPxJHR6EkNlw7NXEU+W5oaX+
	 gdE+qQYorwe4s3r9aamQG5HXkdkvD6vF3oraymiSxEOfT75cKS8MXp+KWlOTRQgEh6
	 6JquVKs10WSoA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] mm/damon: misc fixes and improvements
Date: Fri,  3 May 2024 11:06:33 -0700
Message-Id: <20240503180633.72917-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, please add DAMON selftests patchset[1] that I posted yesterday before
this patchset.  Otherwise, patches would get conflicts.

[1] https://lore.kernel.org/20240502172718.74166-1-sj@kernel.org


Thanks,
SJ

On Fri,  3 May 2024 11:03:08 -0700 SeongJae Park <sj@kernel.org> wrote:

> Add miscelleneous and non-urgent fixes and improvements for DAMON code,
> selftests, and documents.
> 
> SeongJae Park (10):
>   mm/damon/core: initialize ->esz_bp from damos_quota_init_priv()
>   selftests/damon/_damon_sysfs: check errors from nr_schemes file reads
>   selftests/damon/_damon_sysfs: find sysfs mount point from /proc/mounts
>   selftests/damon/_damon_sysfs: use 'is' instead of '==' for 'None'
>   selftests/damon: classify tests for functionalities and regressions
>   Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter
>     matching sysfs file
>   Docs/admin-guide/mm/damon/usage: fix wrong schemes effective quota
>     update command
>   Docs/mm/damon/design: use a list for supported filters
>   Docs/mm/damon/maintainer-profile: change the maintainer's timezone
>     from PST to PT
>   Docs/mm/damon/maintainer-profile: allow posting patches based on
>     damon/next tree
> 
>  Documentation/admin-guide/mm/damon/usage.rst  |  6 +-
>  Documentation/mm/damon/design.rst             | 46 +++++----
>  Documentation/mm/damon/maintainer-profile.rst | 13 +--
>  mm/damon/core.c                               |  1 +
>  tools/testing/selftests/damon/Makefile        | 13 ++-
>  tools/testing/selftests/damon/_damon_sysfs.py | 95 +++++++++++--------
>  6 files changed, 100 insertions(+), 74 deletions(-)
> 
> 
> base-commit: fc7314cb6b750187a1366e0bf9da4c3ca8cfd064
> -- 
> 2.39.2

