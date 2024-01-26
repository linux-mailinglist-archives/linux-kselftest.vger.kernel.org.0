Return-Path: <linux-kselftest+bounces-3627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8A83D945
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 12:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E401C273A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CB179B2;
	Fri, 26 Jan 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZUFf2fTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758C17584;
	Fri, 26 Jan 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268119; cv=none; b=kOglBssRjRm+dZ+sQCm0n9d6U+Oet8ldLvXVNdqWU15c4MU9xylNFbg89a8S8++35AyEF/0GXIQ+cWOeaM1bP7kGgdix4e7wcXNohGQ6Zdy8y23R6sj0aLlYVWyMwRvnJAc/Ww+//MxCVFjG59JEY/uGl+POuVKhLAMdNqdygJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268119; c=relaxed/simple;
	bh=SdPwnBhu1IkYureVGrukhHdBHBYpSyD2MNsFTx/enBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1rbQmUHrvNOFgbp0DowPXlc1Ck/JY2lAJ9d+6bCYFLMQDgnquFK5SgnXTR3Lggmm7QKGrrotzCuslm6qr90bQu6ReCDZClQwF+ZnWTv7Al8F29un/NT6djNk8TkWr9VKiMHzTyImOX0B0KvzCcdsAlXoI3imQzx0YKsyygqD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZUFf2fTv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706268116;
	bh=SdPwnBhu1IkYureVGrukhHdBHBYpSyD2MNsFTx/enBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUFf2fTvDwyoQbO83osgVJswDX3pNohS7IxjYhRo/2uiyOZRntovC0WXTY55Pzfpi
	 gs0/owgCroaAYhKnKcNn5itw6ixC42fMcpVZjoQjW1UjMnooMwbUSDjfyhAPTRR6XV
	 1X7AcXDgvtSa7oOWabNAaP9iYX3/kKta0tOAfiwIWhjIezzXAM1Dp4zIzEWDKdcP/K
	 hBa5tzDSuzlvnck/9sxDVc0oMdemntRgdHqHBYPSLI+qowsyRY22ApV/zDvifxlb5o
	 yTKlOlYggHSq48HoBkIgDFYKMmK83mqiL+8hg0PGs3RDtlyZ63vJLSQkfp8T7joJUQ
	 NEj4d83AhZ1rA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D2F0E3782072;
	Fri, 26 Jan 2024 11:21:53 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] selftests/mm: config: add missing configs
Date: Fri, 26 Jan 2024 16:21:26 +0500
Message-ID: <20240126112129.1480265-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240126112129.1480265-1-usama.anjum@collabora.com>
References: <20240126112129.1480265-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add configurations which are needed for
- hugetlb-read-hwpoison
- ksm_functional_test and ksm_test

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v3:
- Rebased on top of next-20240125
---
 tools/testing/selftests/mm/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 4309916f629e3..d16a72036eb7f 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -7,3 +7,6 @@ CONFIG_TEST_HMM=m
 CONFIG_GUP_TEST=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_MEM_SOFT_DIRTY=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=y
+CONFIG_KSM=y
-- 
2.42.0


