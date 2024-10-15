Return-Path: <linux-kselftest+bounces-19768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178499F47E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438C41C23008
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BA2281D5;
	Tue, 15 Oct 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgEoebN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF262281C9;
	Tue, 15 Oct 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014867; cv=none; b=HG5xvZODYx0P5XiiRIEs/RHeOMUJClzADNMB1jz9/p/QQ3l9xWuXGQEDyZZZUvRcfib2PBGqSSr7FEtGLs4VsbO8tYtLkkbo5rvKfve0U62ETTzt1xVE3G+tJ7A5SLoQyiQeWy2oiso6T7sBVu25Y18jFmyGljIb76aRxI6OUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014867; c=relaxed/simple;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gejJF1qUFPE8gQ2wLd+GdFDXwgHgDRTC3qH0YoeuC+NpB9TC/Jv0Ir6TJYipSzfSc7K10gI1gZ5McaqR5CTkyp9mPtLGOMndHpMSWdw6lywMjMIZgU99GP0plbyis+klZAJvf/jGtZBQbQDztuHVe4mNvxcPLxu9BHnT57oSMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgEoebN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B67C4CEDA;
	Tue, 15 Oct 2024 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014867;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgEoebN5ggv7bJIo+tsNgprDtKq52wrOPozQdSYwCVYN+SgZfqUvnrAPLS8D/ibpJ
	 4tRo5REmWLrJjKyeBovXYKZA5W9qTNPB9fltaGLfZV72T48xutIrBPinTlwTVcTBwf
	 55J4Li7dQGrXMBg08rbbkW6nYCOggKydEWolHwTj1SDocyvqL+RDJozEtZo8EP562L
	 8tbIhbmmyQJ0NlLTdXu+URKTqB+H+IsV+Apl84HDOwKXJVFZTFuFkHA4CvE3qv6WOv
	 C1y3HDKtF2X3pvYNbtG5f3Qb0IH1f9yPMPu9t2xKZK659xiYZFUGZeR/yk125lTTvH
	 9O8PwBMbOubuA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] kunit: configs: remove configs for DAMON debugfs interface tests
Date: Tue, 15 Oct 2024 10:54:10 -0700
Message-Id: <20241015175412.60563-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove kernel configs for running DAMON debugfs interface kunit tests
from the kunit all_tests configuration, to prevent unnecessary noises
from tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index b3b00269a52a..b0049be00c70 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -38,9 +38,6 @@ CONFIG_IWLWIFI=y
 CONFIG_DAMON=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_PADDR=y
-CONFIG_DEBUG_FS=y
-CONFIG_DAMON_DBGFS=y
-CONFIG_DAMON_DBGFS_DEPRECATED=y
 
 CONFIG_REGMAP_BUILD=y
 
-- 
2.39.5


