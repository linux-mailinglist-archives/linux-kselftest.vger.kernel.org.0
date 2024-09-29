Return-Path: <linux-kselftest+bounces-18556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A736398982D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56710B21A3E
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2D55E53;
	Sun, 29 Sep 2024 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg01/2Cl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57522B9B7;
	Sun, 29 Sep 2024 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727647237; cv=none; b=r32IM4W3e6vZPLNSBf2DxMA9Eb4i61v+Xpfd6HpvK9NjGvvqXwcSoMt2Oax8zLOe9NR7swI2J+3XaiEIp+p2766CT6uFPQjee660X+Z599eX0Y0ARxbYAzYjMHNv6slhRTAX4Eoy3s/OrVG7fL++clLdzMwJEASu+tvudJEwE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727647237; c=relaxed/simple;
	bh=l/v4S7kXdm6SKsj0hvrsWvT+/uGV0XUxl9Xyr0fw/x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2a8V84CqJ33/NvvRuTHkDgPST/xrGwtq6z4V/yN7+GZxEWz6zz2c3btkPPZ01Z4I1IPxW10vrmdkN8N6JSP7xUC7BD30EHNZAniCke3cVMI1oj1Oc7snTnCoKt7Tl9Z4krJjGkJ/GhaojByqfOgJvn5D6Qx0ODY3vw8mpL46v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg01/2Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C97C4CEC5;
	Sun, 29 Sep 2024 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727647237;
	bh=l/v4S7kXdm6SKsj0hvrsWvT+/uGV0XUxl9Xyr0fw/x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg01/2ClUQtwAdA4GOAw7Mj/0q5ApYNO8c7+q1/oByfZqPRMKhXoa5LbL+fBEYKFz
	 2OIkZYydb98/Iu6mcVhuxybdmEs2Jwcf3hBBIPSwuPdYg1N/8cikdNpZhWqo9AilSR
	 4sUCBqkQHjI0F3c3Y+XzAVVjWyXw/9RM376Bu2lCZsi2MbZQs4TK4l5s0BXR/xu1zK
	 +zGD17achshBp+KHpPGitS+mSsJix5KV/cmiHuiMfA3BAhrFrxIzs4y/7v6DUZCGZs
	 cWoCaFR7IhRxwG3SoKNeDshFnJrXvbq3Fj4PH5vOIaPMd+AOAAVXzXMAahuJpHQZwN
	 qTf2LBV48JSAg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sj@kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon/access_memory_even: remove unused variables
Date: Sun, 29 Sep 2024 15:00:32 -0700
Message-Id: <20240929220032.71704-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924040846.629985-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sj@kernel.org

On Mon, 23 Sep 2024 21:08:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Ba,
>
>
> Thank you for revising this patch following my comment.
>
> On Tue, 24 Sep 2024 10:14:26 +0800 Ba Jing <bajing@cmss.chinamobile.com> wrote:
>
> > By reading the code, I found these variables are never
> > referenced in the code. Just remove them.
> >
> > Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Andrew, could you please add this patch to relevant mm trees?


Thanks,
SJ

[...]

