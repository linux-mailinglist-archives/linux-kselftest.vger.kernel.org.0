Return-Path: <linux-kselftest+bounces-12051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E790B012
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81788B2D22B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ECB1AC234;
	Mon, 17 Jun 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWi0GOzF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FE19A2B7;
	Mon, 17 Jun 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630517; cv=none; b=SXwO5fLppebWvpPgYvHC2QLag+WgwSE34Rd0YT1h7Y0/PHbArwQZ12FOAIdTrmHjBw8DXU6f/JArifSkMyUunSzPtVT9Fj8ZPbEY1u4zzucnnEVIEbrlg8DdlDwtSWJWwZqpCpYtFe69LcdKoSsdCUQ/Do54YVu5ij5OM2kVv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630517; c=relaxed/simple;
	bh=xVqRJugbodHNTwrbdds9RCp4ryI4PtFZUFV14jUvP8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FieDyMLse+qKalrTl6RSyBixxoZ9F1fEFDX7ewyFlm3vMi4kpQqivyWJgjfobW+yX3CGvjGxxGK3o3AnGoH2X9RHuHDz1xQJuSb3u3Ka8tKSeKLCvRXhaWO0ZuvMJ3WzJDo3VyfhrCAlLX6K8rBI+Ni+JbWqi1XAweEjpzH+Gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWi0GOzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F52C2BD10;
	Mon, 17 Jun 2024 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630517;
	bh=xVqRJugbodHNTwrbdds9RCp4ryI4PtFZUFV14jUvP8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWi0GOzFKwZ5UwvqHeU0pOWc+l+0babKMuehuSvlY+X+DzEm7a9wbbQA6bWFntoWy
	 GF+p9WRFttbtNePVv0kk2qXunfCyIWs6WCLvA7r5t53yEGBOSlhGH3VkNNxZSYltNf
	 k7nkCVPcgp7FaVz8avqYnwmud0jA/+Vi1VtCyM9EzyVAr87HdDWmadJuTTrKcPH8DN
	 d/dG6vRaam9gVnl/An8642OEonXo5FGICjjyEdvoZmB+UkFDYjHOyprIX2iXJbn/fZ
	 +KleWQjCdjU9zoSonw5i5Azoyk5mh0O4mn7YYwv4Jwf9aVIx4KKgLgPMUPdxMNqxgj
	 lzlo97MRzu4mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	avagin@google.com,
	brauner@kernel.org,
	hu.yadi@h3c.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 27/44] selftests/overlayfs: Fix build error on ppc64
Date: Mon, 17 Jun 2024 09:19:40 -0400
Message-ID: <20240617132046.2587008-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


