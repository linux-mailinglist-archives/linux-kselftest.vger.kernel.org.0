Return-Path: <linux-kselftest+bounces-18261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0D983B1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 04:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A042E282787
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE6C13C;
	Tue, 24 Sep 2024 02:14:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB1184E;
	Tue, 24 Sep 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144095; cv=none; b=BdC8WK45HcOfZpLyv5Q1JTsk0BNF5aBTVkvCpBHtoq7g+BkVfw72puF9CZzbH5i0p/GkRSCQnC0jZ2bi8Lp2hF/qb1g82Q37tCYNA6YXEOh1WdjRoLyoj7GnLE5ZinUv39/GryQxEfz1JLq44Ld935v6B8xaot8ZiFq5GqhZBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144095; c=relaxed/simple;
	bh=oykfzB6nHLUfE9J1mnEXpZRH3mzaUWEh/zaEMy/bYcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHhKfkuzo5uJUpENzLVfPO290pWDjlCw1+RyWQM/60l95Soa2XjdORtJFY28WV5bkIS/7bCbViGUWUFOjy0zw7nxT6NcItPYuPdbBZ0rmkv1jy4DjUD+uKjWI7EPsFcbqpleslyCpJClFhvxHixvf+Cj4G/3l8ZyRK/Vp7mQm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666f22099ebf-4d782;
	Tue, 24 Sep 2024 10:14:49 +0800 (CST)
X-RM-TRANSID:2ee666f22099ebf-4d782
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566f2208a446-7c9a7;
	Tue, 24 Sep 2024 10:14:49 +0800 (CST)
X-RM-TRANSID:2ee566f2208a446-7c9a7
From: Ba Jing <bajing@cmss.chinamobile.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH v2] selftests/damon/access_memory_even: remove unused variables
Date: Tue, 24 Sep 2024 10:14:26 +0800
Message-Id: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found these variables are never
referenced in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
Notes:
v1: https://lore.kernel.org/all/20240903034300.10443-1-bajing@cmss.chinamobile.com/

v2: Modify the commit subject and commit log.

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




