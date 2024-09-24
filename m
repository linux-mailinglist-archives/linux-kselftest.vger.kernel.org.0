Return-Path: <linux-kselftest+bounces-18321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80D984B4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25032B22F9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D94E1AC88D;
	Tue, 24 Sep 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP5SaqOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAC80BF8;
	Tue, 24 Sep 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203643; cv=none; b=g7TKsleAg3EqmDxEJkKDdEGvzZdyL6+48xOBLPGqpITfU/tjENQ2Dt1eV3HKgwVdD/sDKy5YT7yfpAhpHWTZJRij+LJnakWQylwDiIfda2FG2mVtXrQPZcXb2b5J+SJObUiFZdfr+VDHhaPXCecXT2t72qXmOoNN9j1q0Qzne8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203643; c=relaxed/simple;
	bh=I3xlCxCgRrlgcGeWrdThprr/PtPPIOpTGHY52oR0aX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odNYixOGBkhedTyUOawA7X2uaWotw3wiLhRgaAf9AR0E76qit9EIpVLlEDj0wSNti4oDGR6fJ5NJw7Xb7U+xjHWbDvSstsLvyVC/Yzh2PoN307PhrHAR3W+rYsCcMvc9hk2/0Apwf/mTSvywFz4yiL4jptZKevNxLDGxJXBbo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP5SaqOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4541C4CEC4;
	Tue, 24 Sep 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203642;
	bh=I3xlCxCgRrlgcGeWrdThprr/PtPPIOpTGHY52oR0aX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AP5SaqObdxk8329qse9ot1zeEYmDkYzoBbJyY9H75XKFBlGv9Q3soJarnbacBkcql
	 XgG32wn4OlQY0qF2n3nLWJiGJLbv1TQc8K2Nwv8MLNkaKbWL7r7C3jBXiXtzFR8pSf
	 j7UcKDzV38fkCnCK+GswlS9yomcg14zXG9dHbAz6N4S00ujDBP5dgeLd0f+ly3c6p/
	 VZ5siPNXjmpV8yBZd3yi3zVp8Z4vxnwAez+m8T3mT47e8gRnyGZmxVF+7MYYzuoLN9
	 iR4m+zd1xf2GoyoZu1Q3uhbFtBf8jzW7ccnWz14lj+/IECv2jbf8FUoE1GqYOBGirO
	 h+71i/2/oDCpQ==
From: SeongJae Park <sj@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v1 1/1] selftests: set executable bit
Date: Tue, 24 Sep 2024 11:47:18 -0700
Message-ID: <20240924184719.686727-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924175500.17212-1-david.hunter.linux@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Tue, 24 Sep 2024 13:54:57 -0400 David Hunter <david.hunter.linux@gmail.com> wrote:

> Turn on the executable bit for the following script files. These scripts
> are set to TEST_PROGS in their respective Makefiles, but currently, when
> these tests are run, a warning occurs:
> 
>   # Warning: <file> is not executable

Thank you so much for finding this issue and sending this nice fix!

> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
>  tools/testing/selftests/damon/damon_nr_regions.py                 | 0
>  tools/testing/selftests/damon/damos_apply_interval.py             | 0
>  tools/testing/selftests/damon/damos_quota.py                      | 0
>  tools/testing/selftests/damon/damos_quota_goal.py                 | 0
>  tools/testing/selftests/damon/damos_tried_regions.py              | 0
>  tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh      | 0
>  .../damon/debugfs_target_ids_read_before_terminate_race.sh        | 0
>  .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py    | 0
>  .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py    | 0
>  tools/testing/selftests/net/rds/test.py                           | 0
>  10 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/damon/damon_nr_regions.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/damos_apply_interval.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota_goal.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/damos_tried_regions.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
>  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
>  mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
>  mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py

However, a very similar fix has already posted [1] and merged [2] into the
mainline.  So, apparently there was a trivial race.  I'm looking forward to
your next patches for DAMON, though!

[1] https://lore.kernel.org/20240827030336.7930-4-sj@kernel.org
[2] https://github.com/torvalds/linux/commit/8c211412c5dffd090eaea5ee033cd729f8e5f873


Thanks,
SJ

[...]

