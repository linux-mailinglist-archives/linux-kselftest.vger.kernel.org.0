Return-Path: <linux-kselftest+bounces-47278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2700CAE054
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A294300774A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0928D83F;
	Mon,  8 Dec 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAZSSSEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71021E51E0;
	Mon,  8 Dec 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219573; cv=none; b=Qod8V0MEqK7LTg2l60mAkP/aoAYDMoJZs2xPptMIhyQZ3UI38C0G/2PurwlbySVF12IUZ4npVL2kulp5i+lVnY6k33MfDQ+rgvA0rTcCYMcBLhgL/zcKUaUgv5yZCuL4qZ5dRJ/Utzgu7+RScX/TBo84m91dF742UiKgpQ67f3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219573; c=relaxed/simple;
	bh=3PhigGiQFETOlEHjQ8QT8DJmfkGFZGk3iQKzOfzK5wI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ckBkxfve4FHB2FBIdRtzhEnpP+yvyA1MU9p72llG3Pu0IaZTujrg+Mgdhc2KjzFp811fStfU5YoT1NEb2gEOisonVjqRxoYDDBJOea6TKl9KN51rvkJbNXEPpjNxlGGOaCG3m38MZlWFHftzEggQv7OtdOC7gUs+mdZko8BXR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAZSSSEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4776AC4CEF1;
	Mon,  8 Dec 2025 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765219573;
	bh=3PhigGiQFETOlEHjQ8QT8DJmfkGFZGk3iQKzOfzK5wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QAZSSSEywd62tybihpGXHEc5BTr5P5KMW18ZpX9fg9Opk/w1lIm9s+dt0FIfL/sMM
	 ZWTBsXPQlyDp1GDTI+8pNs1rrLK7i/0XwddVkiFIVHGlAqChDwrtRt+ENJCvHqCR1I
	 75y3K1c1+lQ3ropH2ISWwQcPFDUE5DfAIlO+jabzcUCOdHPQ5E9sFweI5I39jMgujA
	 ocDbnXzenQum78iXyVmvBR2MsJ9h7B0JSwHnd5RUJ25bb72jo/7mxgLYoi6fiDXZF8
	 9RaK2Vyqs4akzGgRZJ0qbg5L8byF+rE0d5W7AIr+mJgh2Qx9DA6ErqlTAKGnkn0AfB
	 lxDTnsJdnrTFw==
Date: Mon, 08 Dec 2025 08:46:12 -1000
Message-ID: <b0cb1cd3fe26bd0f79bafd0f6aa3249e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: hannes@cmpxchg.org, shuah@kernel.org, roman.gushchin@linux.dev,
 lance.yang@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 mkoutny@suse.com, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] selftests: cgroup: Enhance robustness with
 polling helpers
In-Reply-To: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

> Guopeng Zhang (3):
>   selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key
>     with retries
>   selftests: cgroup: make test_memcg_sock robust against delayed sock
>     stats
>   selftests: cgroup: Replace sleep with cg_read_key_long_poll() for
>     waiting on nr_dying_descendants

Applied 1-3 to cgroup/for-6.20.

Thanks.
--
tejun

