Return-Path: <linux-kselftest+bounces-18239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DA97EF55
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A87E1F21C7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7C19E975;
	Mon, 23 Sep 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFpQbNg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFB28E7;
	Mon, 23 Sep 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109372; cv=none; b=eGuerSNee0cO+48vx9bKm1cDnKc5jBpFqid4XfwZp8ILw/ekO2ye2zluuSNbFcd6+pAcEOyYctCo5HT21Fj0nDsVm2lBeAYYvYXn70AD9MNg3LopjJpdyrJA/qjlspfIT90qUiPFdMsSAzb1U36Us1tuk/DTlJlvlwxRYTqRJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109372; c=relaxed/simple;
	bh=1XU4JWrWMckwknKVBBKhzkqovdaB9PtL+kY6TeZaKKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apiONFK9Bot0Lt1e83mQLcikiUZzAaALa+/CL9CrvFS8A1ki3h0tpiY9SB7URsTfTb+8RL21HMTa0p2p4g6n5oFRuXLl0VEU5rL6MxLLQxGoeWiAXyNv4w9xlXTyFVUPM5gyL4gSxtNCnUXi8kTgorKKYX/yeOUCY/4t4zwGamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFpQbNg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA204C4CEC4;
	Mon, 23 Sep 2024 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727109372;
	bh=1XU4JWrWMckwknKVBBKhzkqovdaB9PtL+kY6TeZaKKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFpQbNg7smZpnzLGjeV8w9DSE4xMPILouyTi7L540cGP/iKWjZUzwvwYg2yRKfJsr
	 /Dc2jBLu7HNMK2YpeWahGi4FeB4NGrS8lndRHrIYPmNHABgWO6WENKQRUzpAdcD9us
	 w2fyym4zmDIwQTiJMGd24yWpIis7CxeAJmvDVjoMjRtbchQ0rajm7u/KVZs0AAKK5U
	 GREfYS0MUNRl0MS+c88j0geea68zzr2uOrCiNml7ywk44PqVzuSZKQ4oPsmWtgbfxN
	 bOYvaNl/lzO/eA6mQyBEQx8vQwmRT6gSyIl2GhyxXGe2M4wUNNQc+n1K3AJWDf5CoP
	 2JSVdg4h/FeuA==
From: SeongJae Park <sj@kernel.org>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] damon: access_memory_even: remove unused variables
Date: Mon, 23 Sep 2024 09:36:07 -0700
Message-ID: <20240923163608.552593-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ba,

On Tue,  3 Sep 2024 11:43:00 +0800 Ba Jing <bajing@cmss.chinamobile.com> wrote:

> These variables are never referenced in the code, just remove it.

Nice finding, thank you!

I'd prefer having 'selftests/damon/access_memory_even: ' as the commit subject
prefix.

> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>

Other than the above trivial nitpick,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
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

