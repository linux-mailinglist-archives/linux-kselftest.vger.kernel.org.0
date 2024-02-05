Return-Path: <linux-kselftest+bounces-4136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41C849A36
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827FAB2496E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D61BDD8;
	Mon,  5 Feb 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aRA7WQ8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD821BC46;
	Mon,  5 Feb 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136175; cv=none; b=oYtgmkiEwGpQhCqs832NSTXfbVLTPhvXP0eVsmQG67l8UaD3Wh+Kh9Yq5IlIqwj3picew4IaTTFtVjbj7KPj4YRbS8tKGHuGaBUkBSAoNC4U1MCPcdQ8qLQc1ZJbY7vgIhKjCUyY+fsjyqgKlXet0jHQU7sYPYStbvuPHo3KLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136175; c=relaxed/simple;
	bh=lBo2RrV5pMdT02xDg06b4tem5y69eHf5xWvN+5io1mU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/c4bZCWw5GYonIoG+CSI4gYSgBHTycGVslRUCkvZeavSGbCngd68M7mc77M8THPoC9zNAeoZiF5y72qLdNvM00lv/5VWzsrJ9DffJu5kSBTp6QE1sURTVs5h8BmckagzlssrzbGunuLa+dIQL8SmMauB+JD1z5/pkUUZqsc7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aRA7WQ8m; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707136163; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nS7UhL6yQx/tw2vtmeDMl1ie3elC6cG5X3EMPLDAjNU=;
	b=aRA7WQ8mHqRoxdAFs/4TCBXqW/g5Hblauc8aFZPrjRA36Hu+bzH2Jv133Ln0ddwjuX6C51g5XbkrB7JnNlWD6fDnDWvlnkIbOusiE1/wMLkJebhrF/AHiLX9z4swvU7iPBGGdeYyrwyBj9TnvaMYgabQxm1Ydc0/VtzMz7h6dM4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0AVhK2_1707136147;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0AVhK2_1707136147)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:29:23 +0800
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
Subject: [PATCH v2 0/3] pstore: add multi-backend support
Date: Mon,  5 Feb 2024 20:28:49 +0800
Message-Id: <20240205122852.7069-1-xiangzao@linux.alibaba.com>
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
This submission presents the second iteration of my efforts, listing
notable changes form the v1:

1. pstore.backend no longer acts as "registered backend", but "backends
eligible for registration".

2. drop subdir since it will break user space

3. drop tty frontend since I haven't yet devised a satisfactory
implementation strategy

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
 fs/pstore/ftrace.c                            |  29 ++-
 fs/pstore/inode.c                             |  19 +-
 fs/pstore/internal.h                          |   4 +-
 fs/pstore/platform.c                          | 225 ++++++++++++------
 fs/pstore/pmsg.c                              |  24 +-
 include/linux/pstore.h                        |  29 +++
 tools/testing/selftests/pstore/common_tests   |   8 +-
 .../selftests/pstore/pstore_post_reboot_tests |  65 ++---
 tools/testing/selftests/pstore/pstore_tests   |   2 +-
 11 files changed, 293 insertions(+), 124 deletions(-)

-- 
2.39.3


