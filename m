Return-Path: <linux-kselftest+bounces-14267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B592993D1AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C9283DFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C69178CDE;
	Fri, 26 Jul 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UAF8k873"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C417838A;
	Fri, 26 Jul 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992044; cv=none; b=EzDdx/JYv1dPLNqdCucU5JtLY0DpURYztV5x0yL/Kqc6aPsSfIZKyX3uExj1YrqxeNa6bnoIjJPNBcZ7l507132szSrz2EUxYkbq4nIx1MihCG3VQD9MiSt39wNRT0f7duC2X0MTy8lVJik/Rpt0uit1qHct/1Dx71JrEQS05og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992044; c=relaxed/simple;
	bh=2+geS2b0XsrpvyOoq75+4P0MzSMplaC8G6tV9qamZ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmFM9iX4UMd0UW3bmUF2U8YAmkh9ZeZk6XSE32M7oKqwMwJ/1k9IgT8/87VFqKgHX0L/05lcxMESW4xCYPX+LrDbtUU0zh/fuUxG3m9Vs/2bS3yCL/Yt/oH+JboDUgFGVhhjpuNGm4qe9L5ohYn1PKaMFZmDCzelUv5hXf0JAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UAF8k873; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721992041;
	bh=2+geS2b0XsrpvyOoq75+4P0MzSMplaC8G6tV9qamZ+8=;
	h=From:To:Cc:Subject:Date:From;
	b=UAF8k8737zGePmGrCmUUL7IUQuZxgQvHW6INNxteWuwrPoR2b/p6pfnCOYKY36i5T
	 Y5lqjQWcdmlvHlSxlErLqpi9MDzJLPM+HFBXC0yN7ZiZeHvLU8fFmrx9+jRA9CG9of
	 go34senmcaWUaQ6jJS5WVr1pNr/kbnTZIL9Cgi3tRfr/2TUsV5p2IovGJaZsHiQ4Xk
	 olgRTZLbsaP/cdwKPdKXkn5vBT5xpBSjxNbpuLcidVPgOHuxQT4mJDaiuOBn7kMXhN
	 FlDvmv3lo9+rt8Wu1josNxtp9XMKY3FjAzDhRuQhW4W0pUvIG8hbfe7+nJJywLD1AS
	 v9YA5Z0GOW55Q==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB78637821B7;
	Fri, 26 Jul 2024 11:07:17 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kees@kernel.org,
	David Gow <davidgow@google.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com
Subject: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
Date: Fri, 26 Jul 2024 16:06:55 +0500
Message-Id: <20240726110658.2281070-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, test_bitmap is being converted to kunit test. Multiple
patches will make the review process smooth.

- Patch-1: Convert the tests in lib/test_bitmap.c to kunit
- Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
           configuration options
- Patch-3: Remove the bitmap.sh selftest

Muhammad Usama Anjum (3):
  bitmap: convert test_bitmap to KUnit test
  bitmap: Rename module
  selftests: lib: remove test_bitmap

 MAINTAINERS                           |   2 +-
 lib/Kconfig.debug                     |  15 +-
 lib/Makefile                          |   2 +-
 lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
 tools/testing/selftests/lib/Makefile  |   2 +-
 tools/testing/selftests/lib/bitmap.sh |   3 -
 tools/testing/selftests/lib/config    |   1 -
 7 files changed, 295 insertions(+), 354 deletions(-)
 rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
 delete mode 100755 tools/testing/selftests/lib/bitmap.sh

-- 
2.39.2


