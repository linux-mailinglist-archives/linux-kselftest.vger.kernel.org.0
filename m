Return-Path: <linux-kselftest+bounces-18266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F3983BFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 06:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554E528464F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F31DDE9;
	Tue, 24 Sep 2024 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H21yjfw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1A26AD0;
	Tue, 24 Sep 2024 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150935; cv=none; b=NEi7T888fy9lrnD6NVSWH9CnMGCyJmGbmy0pyTRmAiwrDf2KbC62wnZ0eNReU4FTNyT9K7vSt8gCe/kH847vZOFUw3cOIrGA2T8FV1V/Uv0+5WYJXYkAoGInZyqqsmPy99+nT9E63QcP39JgHtcY79mllzqqrA1d1pHwvHAnrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150935; c=relaxed/simple;
	bh=Rb7ocaw8Ocp10mEL0qoY4U1nbWwwL6MGXEhpf5NGVhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOr8jEA2x9Bi4dvkjMvnWv/Xrhec9cZti2S0m2IbLiwKecw7QFGqrVCESR3jYFnqBMrwgMfPHsr4+WgXR0hi3oV9VaVwRjf0zaJe6keRtIalpMSlRJfs8zekuydcq1TgRK33Nvv3f9CLz7OaNIXi/jUvNyqyTjIuvN4kUtkZx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H21yjfw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD6FC4CEC4;
	Tue, 24 Sep 2024 04:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727150934;
	bh=Rb7ocaw8Ocp10mEL0qoY4U1nbWwwL6MGXEhpf5NGVhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H21yjfw8/Fc9fKlLdmJBZ8Rzrb8jvkYJhJVYcpUbVgTdeNVAuCGmi5Crv2mi+uepD
	 G1g875E+k6HlhcsWVuszV7h9aUJF2DUqqclSeO8WPNtm8ucXkfNkmORpJqnOiZQEd6
	 VHGc/EGbcbCv7zHlhXFd2ZZXjISAHJ/qQ/WVVp7CFB4+lTz/VnyD7U2u2dN8OG6f+o
	 FDlA7EdB9nezUE1OuB/vlXxch7CGO7VJrwwNg1qGukLpGOwRgEV+FaPmDsewUrzKMM
	 Pj5WVWPv9ZEe2aWGvz/NPWD4R304bz9zqp7rZo+u8Wk/Na6BsvUCnmUOv8+JGEcDMw
	 ELraETfDI3seA==
From: SeongJae Park <sj@kernel.org>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon/access_memory_even: remove unused variables
Date: Mon, 23 Sep 2024 21:08:45 -0700
Message-ID: <20240924040846.629985-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ba,


Thank you for revising this patch following my comment.

On Tue, 24 Sep 2024 10:14:26 +0800 Ba Jing <bajing@cmss.chinamobile.com> wrote:

> By reading the code, I found these variables are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
> Notes:
> v1: https://lore.kernel.org/all/20240903034300.10443-1-bajing@cmss.chinamobile.com/
> 
> v2: Modify the commit subject and commit log.
> 
>  tools/testing/selftests/damon/access_memory_even.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
> index 3be121487432..a9f4e9aaf3a9 100644
> --- a/tools/testing/selftests/damon/access_memory_even.c
> +++ b/tools/testing/selftests/damon/access_memory_even.c
> @@ -14,10 +14,8 @@
>  int main(int argc, char *argv[])
>  {
>  	char **regions;
> -	clock_t start_clock;
>  	int nr_regions;
>  	int sz_region;
> -	int access_time_ms;
>  	int i;
>  
>  	if (argc != 3) {
> -- 
> 2.33.0

