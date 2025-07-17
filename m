Return-Path: <linux-kselftest+bounces-37511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA9B091AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946DD178561
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D32FC3DC;
	Thu, 17 Jul 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw3u2fdc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D02FC3D9;
	Thu, 17 Jul 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769462; cv=none; b=o0MI2v9bFODiKc9d4KgWoJwPmB5raqlGp+TaOiMXtEAuDdvFziTVbpBAkdArze5T7MyglOxb5z2K1s6IdKyRgdN+tg/gLV1tDoydWBZKE3DHGl+CFIS67Ovm2nL5V3OqWhINdfegqkHpb0CF/OMifiz6nciuGc8fsbbvFqp5c5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769462; c=relaxed/simple;
	bh=SlRUX2QyUFuoWdG6+bh41PuWc7RBR2qIqJuigQAHpAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syRGLQqckyO2vUhmY4AmeTOovrHoLi0k5efxgDu5Cokc6a2qEA9orXwVAv+YKLNE1/H/np/gEtte0Z+K9gSI0dR6pSuXJWL9THY6f7c3n5NQ2df/K1T76CdK7sf2bdQ7Voqk9a/sG4JofmaoaRjbk3blhTTZ9XPQExBqsFaCtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw3u2fdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB75C4CEE3;
	Thu, 17 Jul 2025 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769462;
	bh=SlRUX2QyUFuoWdG6+bh41PuWc7RBR2qIqJuigQAHpAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cw3u2fdcZRlIVgwq9ee67CnU/L3kQKvlgjOFKhIxC7mX5BUYUD8z06OyooTphapbo
	 PqNrhTuMp1y+WhyBUh/Jupq9irxxim5E0c9evkx8FzgNhgjF1YYErHT6aMLtZOJ7bj
	 kTaHF73sbpf7yfwQXJVf8mjzXDxVTzTMR5tqMUpfs9uo4LFaATkVXEKO/B0mdJ/m4K
	 gee/hEWxuCDlkLTwu0D6nopryjzREnKKEV600ZOK1QB3OqRRWDel2z8vXCrmRacg5y
	 3t3/20trtTvatWAODt6roekSG2EE4VZrcNUa8L+iBCHeuE01Op7666UqnmQUcMHKNx
	 qeMQqq0XO/0SQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] selftests/damon: introduce _common.sh to host shared function
Date: Thu, 17 Jul 2025 09:24:18 -0700
Message-Id: <20250717162418.64271-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717091902.104466-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enze,

On Thu, 17 Jul 2025 17:19:02 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The current test scripts contain duplicated root permission checks
> in multiple locations.  This patch consolidates these checks into
> _common.sh to eliminate code redundancy.

Thank you for this patch!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  tools/testing/selftests/damon/_common.sh           | 14 ++++++++++++++
>  tools/testing/selftests/damon/lru_sort.sh          |  9 ++-------
>  tools/testing/selftests/damon/reclaim.sh           |  9 ++-------
>  tools/testing/selftests/damon/sysfs.sh             | 12 +-----------
>  .../damon/sysfs_update_removed_scheme_dir.sh       |  9 ++-------
>  5 files changed, 21 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/damon/_common.sh
> 
> diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
> new file mode 100644
> index 000000000000..3920b619c30f
> --- /dev/null
> +++ b/tools/testing/selftests/damon/_common.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Kselftest frmework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +check_dependencies()
> +{
> +	if [ $EUID -ne 0 ]
> +	then
> +		echo "Run as root"
> +		exit $ksft_skip
> +	fi
> +}
> diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
> index 61b80197c896..0d128d809fd3 100755
> --- a/tools/testing/selftests/damon/lru_sort.sh
> +++ b/tools/testing/selftests/damon/lru_sort.sh
> @@ -1,14 +1,9 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4

As Joshua also pointed out, let's keep ksft_skip definition in each file,
unless there is no more use of the variable.

> +source _common.sh
>  
> -if [ $EUID -ne 0 ]
> -then
> -	echo "Run as root"
> -	exit $ksft_skip
> -fi
> +check_dependencies
>  
>  damon_lru_sort_enabled="/sys/module/damon_lru_sort/parameters/enabled"
>  if [ ! -f "$damon_lru_sort_enabled" ]
[...]

Other than ksft_skip, looks good to me.  Looking forward to your next version
:)


Thanks,
SJ

