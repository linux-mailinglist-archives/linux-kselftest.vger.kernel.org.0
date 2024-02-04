Return-Path: <linux-kselftest+bounces-4121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81A848F9C
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29011F22446
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B7241E5;
	Sun,  4 Feb 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM9QI711"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79324249E4;
	Sun,  4 Feb 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066826; cv=none; b=k9XQlt6Fct+I2PLW7o770VScAxRSogZXir/NJBjXQjyyhMuv7HTxzUNFPxWHGhpxG/wJXB0pcEAA46us8K2h0v1H6YURQaCXu9WlPHwnQcL3GHsY3I+ER/PlxK0FknYBLudwgOErq3v6QgL9zz1DaWH01XG3mVN7bh6DPAXq/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066826; c=relaxed/simple;
	bh=ZQ2DMEHRwpKEUaPhTRDYc2Fgx4gCYeXdZWQ097yqZc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZRYZ0AWQOw64cyxXI75MC8DF2PdVxiuZ5diLiEsCk2IlVzC5bfKXa41P973VJEU0iLU143GHjWrinQdNLIutJmwdsytREBwPqT+JYcpSf+njNg44wehCSZBHmKjF5Ej2Ei/+Yx6ROkfMxbbJ6L7/MTSRpBXVWms1bODp/LFTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM9QI711; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A51C433F1;
	Sun,  4 Feb 2024 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707066825;
	bh=ZQ2DMEHRwpKEUaPhTRDYc2Fgx4gCYeXdZWQ097yqZc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IM9QI7116Jm3VyHq9VbDxUhz3Da4gWv3p0wDcI6KD1vIECBGAoMnN4R2DMij2mwUf
	 rehukUSqXUMrCYJJBucWZsF7YxpTPEsoa8Kpgo/yqn039gCWFNljr8cx2ydxW3S3xt
	 qSc9xB4PZ9XtUmSNmsoXcFRf1XITOP8XkJXZ9PXQGKThlEPP72Yc4s1bu6e4RGWnVk
	 LxXvavBAjqF7TFW4+SVfvHIkl0opqxqYmsAO7sgLLVKOR0qBORsrsunFcaQqCdviua
	 87kxELvAv8OfP6RQG7N6YopS+v7/QAg3re3yZpDJPDmeytXdy7BNLH/Zlsz+Gfw8tM
	 DZ6bmZsyyLfKg==
From: SeongJae Park <sj@kernel.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: shuah@kernel.org,
	sj@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] selftest: damon: fix minor typos in test logs
Date: Sun,  4 Feb 2024 09:13:43 -0800
Message-Id: <20240204171343.58820-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204122523.14160-1-vincenzo.mezzela@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun,  4 Feb 2024 13:25:23 +0100 Vincenzo Mezzela <vincenzo.mezzela@gmail.com> wrote:

> This patch resolves a spelling error in the test log, preventing potential
> confusion.
> 
> It is submitted as part of my application to the "Linux Kernel
> Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
> Foundation.

Thank you for fixing this :)

> 
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks,
SJ

[...]

