Return-Path: <linux-kselftest+bounces-18206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5697E655
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8521C20F49
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764821D52B;
	Mon, 23 Sep 2024 07:01:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901061759F;
	Mon, 23 Sep 2024 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074910; cv=none; b=jNmNuo2CNgGKqB2hLBPMAI2D3nE6iGxtSnztdJtAPkFPkLtk2uhZO0hIODSkzHOZovJJmA+tF3NAYKvH62WpP0Cdgcu0WhWtUe1m4eAkugeNPLP2U7s9o3uHcyZswigtIXMChq5iFoYzCPn1QCEODCvRhyBvvYdDcAfVUl8YUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074910; c=relaxed/simple;
	bh=/2JVorIG7th0ajxlD50o5U0sBCabrYn/8381IRn39OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rsGZlr2tL7DTqyizxF/cx+GXTTz1k0kefZF+M28ate7JjoR5S3s9yDdsRtfPTl/abokqBaVrS0elPNzvH7DQBqS6x/Tmax1K38Td0QUGCCkGh8X4jl0VioRt/Q5u880Krp/9bLDFxUkCRepbCmlaJx3BADMxoT5i54UqGe4ws4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366f1119d631-46e40;
	Mon, 23 Sep 2024 14:58:37 +0800 (CST)
X-RM-TRANSID:2ee366f1119d631-46e40
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566f1118bd55-540c9;
	Mon, 23 Sep 2024 14:58:37 +0800 (CST)
X-RM-TRANSID:2ee566f1118bd55-540c9
From: Ba Jing <bajing@cmss.chinamobile.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] damon: access_memory_even: remove unused variables
Date: Tue,  3 Sep 2024 11:43:00 +0800
Message-Id: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These variables are never referenced in the code, just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/damon/access_memory_even.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
index 3be121487432..a9f4e9aaf3a9 100644
--- a/tools/testing/selftests/damon/access_memory_even.c
+++ b/tools/testing/selftests/damon/access_memory_even.c
@@ -14,10 +14,8 @@
 int main(int argc, char *argv[])
 {
 	char **regions;
-	clock_t start_clock;
 	int nr_regions;
 	int sz_region;
-	int access_time_ms;
 	int i;
 
 	if (argc != 3) {
-- 
2.33.0




