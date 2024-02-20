Return-Path: <linux-kselftest+bounces-4987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B989585AFF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 01:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613E31F22BF4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF920188;
	Tue, 20 Feb 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoyvEwmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9A160;
	Tue, 20 Feb 2024 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387578; cv=none; b=gRvkykuXGerJ/9oWwJz1wL/DcrMW2vklmPHT4+eqXT+JYa7/jlMaVBul/d8M2NKhjBlnTmso7nB12s2X54gW3sz8YI6DOnpqYVQ5OAEqRaHvUMNQbaUbjFKoZgZzHHNpZ7pYlLcJEvv4B/qmvOho5Ew8qjm8MZWCs/N9VE0So4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387578; c=relaxed/simple;
	bh=xw0IM8zkbPLUVckNWkQFIhnJMFBsBIfYlm+2dBJ0DO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8xmoXSBgW3XnhHVzIp06pZeK2QnGmeH+sEYJ0ZJhBxkuAC/Ij+RodBhyOof95e0MH3gD+lNoHvlkJhjJ330W9OXMGsn/svMEIsX7YiuEZuiAOQTfn8KGzhuV9e3szCqsT9DA8M1QkC8kWQb5jEyGPtcoozvHm02FlEik7MVomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoyvEwmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4194FC433C7;
	Tue, 20 Feb 2024 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708387578;
	bh=xw0IM8zkbPLUVckNWkQFIhnJMFBsBIfYlm+2dBJ0DO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoyvEwmxNmIcMSIoqMl8HYLBWMe+oI+yqnnoTEfkOQ++juByaJE73fTT4eluo6gSG
	 moQDPA3FeXY94pbP3pwWibDUOSjL/ERsMtzfWjLDLcAUjmeIeJIKFtxS9UPM3M78SS
	 v6N9ZlxnFN8QL4IlimE0OHGh6/he4+WAx2huN+0oN4pJPUX6SvCelp+PTlnWVQpJ95
	 +eNeICk1WLjinN9rAGlQuKz+PRDIEWCcL0M0k9p+g9nmv/URhxrVHIwk3LxPr4yXJp
	 EYU/m7OEptosiRUc9NmJH5x7CwCVadvLVCl7z8SRanCRD6YI/mcRBZCstnHrvnLtrU
	 aXrxwQ5kZu3hQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org,
	ryan.roberts@arm.com,
	abuehaze@amazon.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com
Subject: Re: [PATCH v2] selftests/mqueue: Set timeout to 180 seconds
Date: Mon, 19 Feb 2024 16:06:15 -0800
Message-Id: <20240220000615.162512-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220000243.162285-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 16:02:43 -0800 SeongJae Park <sj@kernel.org> wrote:

> While mq_perf_tests runs with the default kselftest timeout limit, which
> is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> AWS instances.  Hence, the test always times out.  Increase the timeout
> to 100 seconds.

Oops, I forgot updating this message.

> 
> Link: https://lore.kernel.org/r/20240208212925.68286-1-sj@kernel.org

Also, this Link: line should be removed.

I will send v3 with above fixes.


Thanks,
SJ

> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Cc: <stable@vger.kernel.org> # 5.4.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Changes from v1
> (https://lore.kernel.org/r/20240208212925.68286-1-sj@kernel.org)
> - Use 180 seconds timeout instead of 100 seconds
> 
>  tools/testing/selftests/mqueue/setting | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/mqueue/setting
> 
> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> new file mode 100644
> index 000000000000..a953c96aa16e
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue/setting
> @@ -0,0 +1 @@
> +timeout=180
> -- 
> 2.39.2

