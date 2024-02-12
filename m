Return-Path: <linux-kselftest+bounces-4534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0BA851E2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1871C21EDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D547A6B;
	Mon, 12 Feb 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAJr3+bH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC447A5C;
	Mon, 12 Feb 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767610; cv=none; b=B3Mo6rwLez97J0JG0N4eE0tq0r89ZjTlxKKT1rHW7SgXUUituDjfYUjzziAbpwB743qdG0hM6hm+qG1DI+IyKLpU4eOFRMo25sxH5Tz1o3ga9JcWeRJWIuuy5IZL9CFC99duwmCy3raSZd94KZFTeeKMkDwdu/YKL9b4S/t+A90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767610; c=relaxed/simple;
	bh=u4HMOvzpN+Ix3Ii0REHIjwioM3W2CHOuHM79fAw+SOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsQsH8QygkFrHPOL6XLsQAws7W/wmguMJvyzvHLKGYOUSp9kDm4kAvhzowVaHmqpEOAWUUiE+qg+RCSQjy1UzgiQkILU9TcRDAgaHQ9GfZPoCwpRSdxBrc9b8zDgZH6KuqRJV5pDlKT3SqKdvDko1Ju4RjZpXh5n261kYbtZfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAJr3+bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5813AC433F1;
	Mon, 12 Feb 2024 19:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707767610;
	bh=u4HMOvzpN+Ix3Ii0REHIjwioM3W2CHOuHM79fAw+SOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAJr3+bHGCJciiRzQqiJ9i8PrEoDiJcbFepout6HfUQV1+i0Y1m9JJyMc9bpBQ5Pa
	 wyV0E1t1VVMYClDgK9QfBYUkLBVDibVA+kprRce6I0D1HJqYfEOcvBXeGN2khwOJWa
	 /Q1OKNtjrXxTwYCj42RqwhFojrjqK2yRAcUEPSQIfzTNtLo66fIV+D/bLfUFWl/3YQ
	 cMggTGeBZcp10BoGGzcJgpl062qkkA9arfXeZTVLGScaTO6UDv4+FLijP+jCsUvAi7
	 Xa6usP3gw3JZyVCgGASVHnYjCn2m65Ufd0T34tMGDJt4BIPIr0lbGH2pCT89dfEz4n
	 BZDcws8QPiP6w==
From: SeongJae Park <sj@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Bernd Edlinger <bernd.edlinger@hotmail.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
Date: Mon, 12 Feb 2024 11:53:28 -0800
Message-Id: <20240212195328.73406-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212-selftest_gitignore-v2-4-75f0de50a178@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 12 Feb 2024 20:43:39 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This binary is missing in the .gitignore and stays as an untracked file.
> 
> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

'checkpatch.pl' complains as below:

    WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
    #11:
    Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
    Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

I guess the 'Closes:' could this link?
https://lore.kernel.org/r/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM

Also, note that this conflicts on mm-unstable.

Other than those,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ


> ---
>  tools/testing/selftests/damon/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
> index c6c2965a6607..79b32e30fce3 100644
> --- a/tools/testing/selftests/damon/.gitignore
> +++ b/tools/testing/selftests/damon/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  huge_count_read_write
> +access_memory
> 
> -- 
> 2.40.1

