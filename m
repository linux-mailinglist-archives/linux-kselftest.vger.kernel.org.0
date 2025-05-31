Return-Path: <linux-kselftest+bounces-34109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D7AC9BCB
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3044A10AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79C17A2FB;
	Sat, 31 May 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv+xXj5J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0E1714C0;
	Sat, 31 May 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748710141; cv=none; b=dHzgCHd5PCHkeyCJI7uNFmwTLpIFhcLuRmqZRXRrC7XsFYWWyXpQPQ6bgLnpGoL9MGDjSI8PlxXhT4gPjBvNxNlaq2fb3Vv2hrZkbscyu6oaIWRziUI4LQ45Hz7GpVuuIeVBGpGoYg7eCYb/MLvYIO1xRfaLPRaaoq9TgDzrNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748710141; c=relaxed/simple;
	bh=EImyog8mJ2d1KSn2d/5M4MrBuuXlY9j+Aeou6GlnT00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubxS6rbMbntG4CLcYu+6z0YGNF2g3uLIMUvfSUrZerrvFIxjJtZQ79ifQVLT0xNiszYednWYZ1DrpyDL1Vvr21mbmKqMXso8t1sZtqECEp0I0KqqkmZNaNedqFvBWctY49VSbMiRpFIhkbB5i6fHVPwfmI1ADwxkuymszVB9z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv+xXj5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A65C4CEE3;
	Sat, 31 May 2025 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748710141;
	bh=EImyog8mJ2d1KSn2d/5M4MrBuuXlY9j+Aeou6GlnT00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nv+xXj5J8KG2TlcMwQGBuGyhk9nm/OSHlZ9z2opOK3e8fosTVpW3qO9UaZSELc0rO
	 +RDF3xkAVIV1rDOA6yHwtCgtG2IA0bj2qtClKebAktbej1aEaE3M7LxrCItZ4y1Hso
	 BScG7pvqMmMcsuzY+ELc9TSbSzrk41lo9NlAzzMvD+KRbFhr52vEKtTHPmzAEgcglD
	 knnPYj5lvhf2P0kWrpLjWUiXSmnuCBoSQH+HGCCZsCVLO2B3/8Wx99h1W4c+KUGZKF
	 xdidb/ALcs6tD5AXWfOZy0NS7w/7CY97p8ZwUPBvXc4yGHx92pA630emoXCeqSAZKm
	 VcwS8T0QIf5yQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/damon/_damon_sysfs: skip testcases if CONFIG_DAMON_SYSFS is disabled
Date: Sat, 31 May 2025 09:48:58 -0700
Message-Id: <20250531164858.37308-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531093937.1555159-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 31 May 2025 17:39:37 +0800 Enze Li <lienze@kylinos.cn> wrote:

> When CONFIG_DAMON_SYSFS is disabled, the selftests fail with the
> following outputs,
> 
> not ok 2 selftests: damon: sysfs_update_schemes_tried_regions_wss_estimation.py # exit=1
> not ok 3 selftests: damon: damos_quota.py # exit=1
> not ok 4 selftests: damon: damos_quota_goal.py # exit=1
> not ok 5 selftests: damon: damos_apply_interval.py # exit=1
> not ok 6 selftests: damon: damos_tried_regions.py # exit=1
> not ok 7 selftests: damon: damon_nr_regions.py # exit=1
> not ok 11 selftests: damon: sysfs_update_schemes_tried_regions_hang.py # exit=1
> 
> The root cause of this issue is that all the testcases above do not
> check the sysfs interface of DAMON whether it exists or not.  With this
> patch applied, all the testcases above now pass successfully.

Thank you for finding and fixing this!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  tools/testing/selftests/damon/_damon_sysfs.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> index 6e136dc3df19..cab67addfb00 100644
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> @@ -15,6 +15,10 @@ if sysfs_root is None:
>      print('Seems sysfs not mounted?')
>      exit(ksft_skip)
>  
> +if not os.path.exists(sysfs_root):
> +    print('Seems DAMON disabled?')
> +    exit(ksft_skip)
> +
>  def write_file(path, string):
>      "Returns error string if failed, or None otherwise"
>      string = '%s' % string
> 
> base-commit: 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce
> -- 
> 2.43.0


Thanks,
SJ

