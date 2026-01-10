Return-Path: <linux-kselftest+bounces-48648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14561D0CAFD
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 02:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F390E301E22D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422661DF248;
	Sat, 10 Jan 2026 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsyTwe/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40742048;
	Sat, 10 Jan 2026 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007810; cv=none; b=QQmWQsOUEJ0RvM2BdqHKYFcNCD6P671k9wXpgCf3VQiZKs2bMMBWcJsOjdBUVFcGmGmYq+14HJw4e3tqYhkIKHHKKOByh6/oKdsUTl83el9OekqvlR6uIzNedKw2YJyENXMulOHqlwRzMkUN+bT8Lsx5FZtCin9lJy6G2Xfbodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007810; c=relaxed/simple;
	bh=1yqAuwPlUfRbkywsOHYeC8zQzYiMnx9T0dqkU24ak7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8Y0mRyR93XmmdlqrC2bD6hl8jDmaGGBgu9WedsVvx6AuSdKJ1a4YaLTNLGCP1xub22X1BkyM3bBTdR/mQxPQkRX7Y1HNFE5p3qVf8KTFmENssfQrB8I/RRt9EP+tw8I1OusVOvr7Lwz9cMOugrYpvztlXcLBHBMrRhWZv2WaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsyTwe/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE73C4CEF1;
	Sat, 10 Jan 2026 01:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768007809;
	bh=1yqAuwPlUfRbkywsOHYeC8zQzYiMnx9T0dqkU24ak7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsyTwe/zSpke6a9XZ6AKLa6ZQ3ADLRwY8NzsYMoo9vtCM3McMX3RZNQR+YG/YJvjR
	 +Kojk+cRQFG/GZcRFeJ3+4dRApBG4Q9p1BQWOcS0lpfCb5Kv8bB2c/GXgr+TXFa+R6
	 Ho0hzcKyk6cAA/6uifqZ0/bE/wR/EMwh98DG/nk3KFRkzUc5JJQ1uvFFsZ9Ybfs9fB
	 PBXZi2e60iSAjHuQryLCZ025oRuwIf7gLFgOHEwVxAcMyC+QpDFzMfI6GZOap9rXZ7
	 pwCARKTqLLedq/a7gA6X06GdaXr9Kr9bAEaSMNC55mAdfRzhfk5OX+QW21X87BYV2u
	 SZbtvQNv34LXg==
From: SeongJae Park <sj@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: ksm_tests: skip when not run as root
Date: Fri,  9 Jan 2026 17:16:40 -0800
Message-ID: <20260110011641.81278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109094313.52307-1-sun.jian.kdev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  9 Jan 2026 17:43:13 +0800 Sun Jian <sun.jian.kdev@gmail.com> wrote:

> ksm_tests writes KSM sysfs knobs under /sys/kernel/mm/ksm, which requires
> root privileges. When run unprivileged, it fails with permission errors
> and reports FAIL, which is misleading.
> 
> Skip the test early when not run as root to avoid false failures.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  tools/testing/selftests/mm/ksm_tests.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index a0b48b839d54..c22cd9c61711 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -766,6 +766,11 @@ int main(int argc, char *argv[])
>  	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
>  	long size_MB = 0;
>  
> +	if (geteuid() != 0) {
> +		printf("# SKIP ksm_tests requires root privileges\n");
> +		return KSFT_SKIP;

What about using ksft_exit_skip() instead, like compaction_test.c does?


Thanks,
SJ

[...]

