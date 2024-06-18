Return-Path: <linux-kselftest+bounces-12142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4790CC22
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252D1285357
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4513E050;
	Tue, 18 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbRlzSVv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821613E039;
	Tue, 18 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714241; cv=none; b=e9Dcd1+6R12P6I+hygqXYj3IIjXEzWVBcp58hRBL/ASsHpjDuyHxaYYOvEvkXX/YO7QbeSUJUNVBEWaS+l++kG2Ar7PWwlYitINiOxLhXk/BW24OZGgl1waaHaRt7C6L10vh87TlvMhKV31TRgBZdtoe1z0rFrxsyFeKmLApXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714241; c=relaxed/simple;
	bh=xVqRJugbodHNTwrbdds9RCp4ryI4PtFZUFV14jUvP8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/p34g93zsWFpdLDttQBOjRDHA0U0Ii84h2nHt3/RamjU5VelRqACS8ImQim1axcjqYzJ9BeiWxlgiX65dgdoWafuVIXuz0cYaz2N8fuacdB+XOFrTJAQU1YkV2d0YcTXKPl6OZ33QqbAvEzr2/mXpO+A8Uxuue8SSw7hNjfpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbRlzSVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9653C3277B;
	Tue, 18 Jun 2024 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714241;
	bh=xVqRJugbodHNTwrbdds9RCp4ryI4PtFZUFV14jUvP8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbRlzSVvx+rNZQ5vdQ4vLw58iX0qCsDPoqcJrxCw916Osc0qpfqJoco9UyAgUSwWP
	 H+bXwESrUq9rKWqeYUsV5J3SuBS025A3GNEzd3Iy26HcvRb47GJu+D4qPitYssA9WX
	 SwQtpq7E47IyrTkpz52RE+ihWemB+0+FDcww8d1Gin4x4LS4UslZCSQWVMV3vEGMvY
	 cjLNDfxTEvbce8H95g0GbhF/azdRjvGOJsaWn5rX9Q4HAMupK5xL19djfLunR+qbaE
	 4a3eE6oV/MT5cH1vbzLMwEsh0XSgbGpI0hhUo7QUda+6nQ62o7InKy8lVeYVbs2Wya
	 l1E/jNEdxU6Ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	brauner@kernel.org,
	avagin@google.com,
	hu.yadi@h3c.com,
	amir73il@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 27/44] selftests/overlayfs: Fix build error on ppc64
Date: Tue, 18 Jun 2024 08:35:08 -0400
Message-ID: <20240618123611.3301370-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit e8b8c5264d4ebd248f60a5cef077fe615806e7a0 ]

Fix build error on ppc64:
  dev_in_maps.c: In function ‘get_file_dev_and_inode’:
  dev_in_maps.c:60:59: error: format ‘%llu’ expects argument of type
  ‘long long unsigned int *’, but argument 7 has type ‘__u64 *’ {aka ‘long
  unsigned int *’} [-Werror=format=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263e..2862aae58b79a 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <inttypes.h>
 #include <unistd.h>
-- 
2.43.0


