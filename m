Return-Path: <linux-kselftest+bounces-12150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107890CD86
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746A21C2265E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5F1B29C9;
	Tue, 18 Jun 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfCXqkCV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8071B29C6;
	Tue, 18 Jun 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714563; cv=none; b=TjdbnbUjRp05JAVXXKHFwC1BqRVyYmyn8m0P0pl3JUbeRmQnoNsLvFwmCkqdRoKQV21irl+SE5fLxPGJoo0fx1EO2FsyB5jCI1s+zUN9F9+XDKYXMXKEyByR5xHpgLis1JWukL6ZO3SJ4Gt8AS5SehmGgEPropB/ESiCWie++k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714563; c=relaxed/simple;
	bh=o9y2ImBDUHBIFJ58FSRGbv0KBquKYclerjTIRvuoJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERYWXWfSMupbp5GMlxFgPNH2C5f/mudrRlWxbNK6/NUiKXK2fuNZ8TnKjuQF65iefymKEOKgVTnypqgrgm5bsTWt+gqfMzAmsOoA+I9czB3SBzrB+oMLgo4gIRYJ8CLqSx/OaAccydHTDp0I9sqWXAD/k/N0IKMHim/JGEKLoP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfCXqkCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B75FC3277B;
	Tue, 18 Jun 2024 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714562;
	bh=o9y2ImBDUHBIFJ58FSRGbv0KBquKYclerjTIRvuoJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfCXqkCV8f0urpUHjNls9lqEDjU4TWUv6ssDilj+TdVL4zvuvl39bmj5c6MG4FBcj
	 PSPwfpm3h93mklSKuMIMkWpCl8mgowlMYtyPyy6Op5thO5dySMscP0jy5OPELRIkKj
	 sgbCfBhJYNzzF05dJj1ozd87Vk2Zo1dFrWbba+jvvGMol09vKkYJ2uvSePBzs0bhyQ
	 Cybqz0FqHh6ujJVu/MkRaJGoBvHKswbbGPLDHmXmk674oqDaaxw/UnvUGQ5BGWUO81
	 9ii9Kn8s15EQD64WYnExRb4fYPBMtzjOAgN2yI4lwyYMf4FJ5PqJce7Z4zRzXtRkDl
	 8aXiGeRPQQ3gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	maciej.wieczor-retman@intel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/13] selftests/openat2: Fix build warnings on ppc64
Date: Tue, 18 Jun 2024 08:42:17 -0400
Message-ID: <20240618124231.3304308-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124231.3304308-1-sashal@kernel.org>
References: <20240618124231.3304308-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 84b6df4c49a1cc2854a16937acd5fd3e6315d083 ]

Fix warnings like:

  openat2_test.c: In function ‘test_openat2_flags’:
  openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
  ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/openat2/openat2_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 453152b58e7f0..1045df1a98c07 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.43.0


