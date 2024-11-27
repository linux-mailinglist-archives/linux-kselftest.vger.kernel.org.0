Return-Path: <linux-kselftest+bounces-22575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E5E9DAC31
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498FBB22502
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4179200BB4;
	Wed, 27 Nov 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvaknC7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEB1F8F1A;
	Wed, 27 Nov 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727051; cv=none; b=NG/cGhxjh2IN71WUHGn6ep3lE5rSZ8MBGhMW35ww721/kkAjt5gxBopaVzFcS2cBgDvyhlyQRkV67qM5yPN3N9p/fOurUqxI4eW0NKK4ccHb2ohW6nfJzWOrilvecOreqPwM1qOb+nFzFnRlXkFuWvWF0IW9Kw1JR+Nr8o1jzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727051; c=relaxed/simple;
	bh=5HRBVytr5GUFSIGmJD7/dGSkmSv8GWKUHwmGpMyEXys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdYJWniXTPsIvwFPrBsO8I+sMOomHTHFj1HzO3mmEq+EqVPsKRDi/rk3nZeqW2EauajakICxZx468PtE+eg3o5nPpmmbBLmYUlXOxvAp5BxnIJdLi1nbswJymai7uBgeOwNDKQyxL5GNtJW3JiB362Uv1iIlFm9LdqZqgg0w9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvaknC7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BFBC4CECC;
	Wed, 27 Nov 2024 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732727051;
	bh=5HRBVytr5GUFSIGmJD7/dGSkmSv8GWKUHwmGpMyEXys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvaknC7egerwU0wTAMT56+snNiguf+QPNUBbcMHW3PPtw20N60ss+DgBPNrYLv1MY
	 Jn4xJL2ZWjCE1cO9yrH+LnKDqOc7cm/JNVET4NSyX9BFk7yQT9Xml4uP4fM/WPTzJb
	 rd7hCpnRsAayL+3YQ+aQAneAGoTqng+trBp2eKxYsjwVyxoMbuWf+gmc9NatWUKtE4
	 /9UAmPQaSl7FsrvpWzDTVhOz6iLsRidYhhBOAtpRl+kgS2GGRFa+vXf0cDiawcuqC+
	 VbwSqQaLm7rhrGMdtxVysKqCdpgnnGqwKTyay6Vm+IcxKmfoG4b92ZBaoxNOgqZDIl
	 LCghrdgcfDrFQ==
From: SeongJae Park <sj@kernel.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: SeongJae Park <sj@kernel.org>,
	"Shuah Khan" <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/damon: Add _damon_sysfs.py to TEST_FILES
Date: Wed, 27 Nov 2024 09:04:07 -0800
Message-Id: <20241127170407.82602-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127-picks-visitor-7416685b-mheyne@amazon.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Nov 2024 12:08:53 +0000 Maximilian Heyne <mheyne@amazon.de> wrote:

> When running selftests I encountered the following error message with
> some damon tests:
> 
>  # Traceback (most recent call last):
>  #   File "[...]/damon/./damos_quota.py", line 7, in <module>
>  #     import _damon_sysfs
>  # ModuleNotFoundError: No module named '_damon_sysfs'
> 
> Fix this by adding the _damon_sysfs.py file to TEST_FILES so that it
> will be available when running the respective damon selftests.

Thank you for finding and fixing this issue, Max!

> 
> Fixes: 306abb63a8ca ("selftests/damon: implement a python module for test-purpose DAMON sysfs controls")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> index 5b2a6a5dd1af7..812f656260fba 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -6,7 +6,7 @@ TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
>  TEST_GEN_FILES += debugfs_target_ids_pid_leak
>  TEST_GEN_FILES += access_memory access_memory_even
>  
> -TEST_FILES = _chk_dependency.sh _debugfs_common.sh
> +TEST_FILES = _chk_dependency.sh _debugfs_common.sh _damon_sysfs.py
>  
>  # functionality tests
>  TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
> -- 
> 2.40.1
[...]

