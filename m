Return-Path: <linux-kselftest+bounces-3576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080E83C725
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50BF1F216FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DE73175;
	Thu, 25 Jan 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qpXjEHK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8EA7316D;
	Thu, 25 Jan 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197619; cv=none; b=pz5Gkw3YTG2idcc9IevSevf6uaE5AIiyOO61A4IJYT4w2sDp9ey/gE16eLBNLdwSnBQR5sWknLaOCmViELUy0i2QlBzmbD8p6Yx8qYC8bt60M4s5Cgv+WvgTT2psb8waZCj3D6vJc32usPhNMusWsROmqUbamJAU/vh7XJWGpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197619; c=relaxed/simple;
	bh=hXCl5ifi2xUqFFL/6Lz0q2a/DC39aj5N2wlFm3EAR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6IODkETNPnJuYUdpfzm0UMtPbn/JH4ektUGPgCvDzOBLHa09eKiZwR/uYDc8sycYEiwNM8UYVTjwwP3oMpECxPQOpZFV71fivS01TeM+yKSBAauUm6kXdQXNHDMlBkUDDfcvZ74pCVVUk8J8EoSZLDs7/eRnl3mchh1Y3amy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qpXjEHK2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706197615;
	bh=hXCl5ifi2xUqFFL/6Lz0q2a/DC39aj5N2wlFm3EAR4w=;
	h=From:To:Cc:Subject:Date:From;
	b=qpXjEHK2NZ70YWG1YdHVRZctb+7U/gODCpmOts/SDEAcB2aiuJW5om0qO5r+hw3Bx
	 AtCn2V5hij8gEAKP3THzUk1+Cu1RkMo/BE7ebWw23sFORV7ROwbRc80mpJzKIbjIhl
	 kbly9umGaJxQtg7JaTAu6jvot9iYS5+JxGQTdBk9OGfL6YZOdtVJxEUqaNl1haDRgo
	 EL1YtRQvSCxjuSxZKPUH1ad69ymspe938S1mfZTPaDS76QgeG+ZtJq9HyJhTaYdmsz
	 u6L35Em+tDA2iOdW7t6mlhC6yT2jcLlN6eobEkrrD/1HKyWcsLMX8y6h3nA5SNMzUM
	 ABQmp2bPIlV+w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B4EA37820C2;
	Thu, 25 Jan 2024 15:46:53 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] selftests/mm: Improve run_vmtests.sh
Date: Thu, 25 Jan 2024 20:46:03 +0500
Message-ID: <20240125154608.720072-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, I'm trying to add 3 missing tests to vm_runtests.sh
which is used to run all the tests in mm suite. These tests weren't
running by CIs. While enabling them and through review feedback, I've
fixed some problems in tests as well. I've found more flakiness in more
tests which I'll be fixing with future patches.

hugetlb-read-hwpoison test is being added where it can only run with
newly added "-d" (destructive) flag only. Not sure why it is failing
again. So once it become stable, we can think of moving it to default
set of tests if it doesn't have any side-effect to them.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v3:
- Add cover letter
- Fix flakiness in tests found during enablement
- Move additional tests down in the file
- Add "-d" option which poisons the pages and aren't being useable after
  the test

v2: https://lore.kernel.org/all/20240123073615.920324-1-usama.anjum@collabora.com

Muhammad Usama Anjum (5):
  selftests/mm: hugetlb_reparenting_test: do not unmount
  selftests/mm: run_vmtests: remove sudo and conform to tap
  selftests/mm: save and restore nr_hugepages value
  selftests/mm: protection_keys: save/restore nr_hugepages settings
  selftests/mm: run_vmtests.sh: add missing tests

 tools/testing/selftests/mm/Makefile           |  5 +++
 .../selftests/mm/charge_reserved_hugetlb.sh   |  4 +++
 .../selftests/mm/hugetlb_reparenting_test.sh  |  9 +++--
 tools/testing/selftests/mm/on-fault-limit.c   | 36 +++++++++----------
 tools/testing/selftests/mm/protection_keys.c  | 34 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     | 10 +++++-
 6 files changed, 76 insertions(+), 22 deletions(-)

-- 
2.42.0


