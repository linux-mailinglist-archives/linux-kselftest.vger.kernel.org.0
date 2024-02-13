Return-Path: <linux-kselftest+bounces-4604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64F854038
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EAA28AB19
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84C63115;
	Tue, 13 Feb 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSkxuw8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106B6310B;
	Tue, 13 Feb 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867528; cv=none; b=UXO/hxls3TItc4Jikv1Kc2s6ixbR6E/ID1C8vvzB4LXCK9d/9xRdvUM1tad+2QaLd+oR9v52FhIacfJz9T86QO8nQeNoWKWRX1ojrHKFqnMJ88MPb3IV5g1NkRrvihFM7gf8lv2Rowt52e0+nMmpV/mmupSchV8ZzBggkJGMfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867528; c=relaxed/simple;
	bh=7QKrr3yoi5HndAL0PHs3321T07A51wU1UgawT2AnNWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmIk9KTz9e2M29HJqJJXZZ3sWZ2ualC0ZBuOTIZkskgox+bRVVjng93xk6QJQO5kiyxFkV/f3+OudKhKWyTWtM90GghpvAyQ2eWqd6tQs4XiND3IRiwJlms3x3W576r5ETZ9iNEoZgepuo8HF0soQAqULyat3SH6mKTL/mM/+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSkxuw8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CADC43390;
	Tue, 13 Feb 2024 23:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867528;
	bh=7QKrr3yoi5HndAL0PHs3321T07A51wU1UgawT2AnNWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSkxuw8P3rwBWqCgwikdl9RfCRffS8gAeIRddtc3D1+RYtJbtBz0C/X1by1D+FVId
	 bSxzOf3jccb2ciKiWkvWJiBenT04O0bnRVotujwjp3zVvtUNIvKqzBF53zaJVAldRv
	 Kb5uKu48SnZZ5bVVCToWCpi+VHi5pNv64V0i2fO7nukRgZZQF7+HXqLqCZmr4mPA6d
	 83SB1Xxa3GpnClZWowzAHej8FfPyHYflZwzdzl2z4CsBGoLRq84CcuDJySz6ahC6ar
	 3hj2sv4vfUcAQumCMTmdrKykFj5KsqnXFEVdKZhoo9IbVVKh25yqHcxQ5437m+Sq5w
	 bwSaNbIRQebWQ==
From: SeongJae Park <sj@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Bernd Edlinger <bernd.edlinger@hotmail.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 4/4] selftests: damon: add access_memory to .gitignore
Date: Tue, 13 Feb 2024 15:38:46 -0800
Message-Id: <20240213233846.2723-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213-selftest_gitignore-v3-4-1f812368702b@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 23:46:53 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This binary is missing in the .gitignore and stays as an untracked file.
> 
> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> Closes: https://lore.kernel.org/all/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM/
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Thank you, I confirmed this can cleanly be applied on mm-unstable.  But, I
think my suggestion was to split this patch out of the patchset and send
separately so that Andrew can carry this on mm-unstable?  Otherwise, Shuah
would get the conflict on her tree, or Andrew would need to carry the patches
for theremal and uevent selftests on mm-unstable.


Thanks,
SJ

> ---
>  tools/testing/selftests/damon/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
> index d861701f0327..e65ef9d9cedc 100644
> --- a/tools/testing/selftests/damon/.gitignore
> +++ b/tools/testing/selftests/damon/.gitignore
> @@ -2,3 +2,4 @@
>  huge_count_read_write
>  debugfs_target_ids_read_before_terminate_race
>  debugfs_target_ids_pid_leak
> +access_memory
> 
> -- 
> 2.40.1

