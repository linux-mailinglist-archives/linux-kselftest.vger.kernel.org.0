Return-Path: <linux-kselftest+bounces-4206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5284C264
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 03:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13761C2222D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E16DDC7;
	Wed,  7 Feb 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ui/tL+mc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7554DDC6;
	Wed,  7 Feb 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272397; cv=none; b=kAA22HUyGM/nZtotkpvmCc7OFhmxZKXVE77NvQuyfUoCJiMkkrerxkASY9PaOpkch1om8CUr48C5gdR22BLx3O/poMaA9E1BeTr32lzOHj6w5PNcGSANPwaM3GtY2flnqsN688USwWuCRma3qJ6dkwhZA/fDVJJPzq4V2iNzNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272397; c=relaxed/simple;
	bh=Chp9zNiZQisqvJTCxnpUb83eLJUJnwZdDtmJwK5aEjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TuI22k+YlsJc9R1PuqtoSfjjX00XT85dWQeBFYh9U8/YLwP7R3vEWT2oyfXpLv5+CT391ZfTrT5+q7q8rXpnr1e4Dl+pLVEZQ2XLSHOSH0tlQslyHMlRGJ1H+YF8Or6u707aV+PGmAbXbDEkPD7w5/iwt18+30oMKhheWz/2aIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ui/tL+mc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707272384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SzzRsuoKn9NUe6qiu7CdTsPN+rpGpZaX9D+ucZDQDig=;
	b=ui/tL+mcqJVOTxMOJR2kU7D5xQAgfJqpdqcg9i+yvwllD7CNjqMsXqdKR9U79+WTGuzfeG3phA6dM+8bIGLycrLt+S66IhBTwZSpZn+EOH2eeM/L+m+P+4YezubFTV6f/wGxgv4DKisR3vSx+YHe1f7nTxx8nY7q+3BgvpPwLOQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0F5hRE_1707272372;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0F5hRE_1707272372)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 10:19:43 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH v3 0/3] pstore: add multi-backend support
Date: Wed,  7 Feb 2024 10:19:18 +0800
Message-Id: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been steadily working but struggled to find a seamlessly
integrated way to implement tty frontend until Guilherme inspired me
that multi-backend and tty frontend are actually two separate entities.
This submission presents the 3rd iteration of my efforts, listing
notable changes form the v1:

1. pstore.backend no longer acts as "registered backend", but "backends
eligible for registration".

2. drop subdir since it will break user space

3. drop tty frontend since I haven't yet devised a satisfactory
implementation strategy

Changes from v2:

1. Fix ftrace.c build error as I did not compile with
CONFIG_PSTORE_FTRACE.

A heartfelt thank you to Kees and Guilherme for your suggestions.
I firmly believe that a tty frontend is crucial for kdump debugging,
and I am still dedicating effort to develop one. Hope in the future I
can accomplish it with deeper comprehension with tty driver :) 

Yuanhe Shu (3):
  pstore: add multi-backend support
  Documentation: adjust pstore backend related document
  tools/testing: adjust pstore backend related selftest

 Documentation/ABI/testing/pstore              |   8 +-
 .../admin-guide/kernel-parameters.txt         |   4 +-
 fs/pstore/ftrace.c                            |  31 ++-
 fs/pstore/inode.c                             |  19 +-
 fs/pstore/internal.h                          |   4 +-
 fs/pstore/platform.c                          | 225 ++++++++++++------
 fs/pstore/pmsg.c                              |  24 +-
 include/linux/pstore.h                        |  29 +++
 tools/testing/selftests/pstore/common_tests   |   8 +-
 .../selftests/pstore/pstore_post_reboot_tests |  65 ++---
 tools/testing/selftests/pstore/pstore_tests   |   2 +-
 11 files changed, 295 insertions(+), 124 deletions(-)

-- 
2.39.3


