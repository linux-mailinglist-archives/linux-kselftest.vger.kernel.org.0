Return-Path: <linux-kselftest+bounces-19698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1499DC0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 04:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F091C219D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E2315AD9C;
	Tue, 15 Oct 2024 02:06:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712013D291;
	Tue, 15 Oct 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957971; cv=none; b=IIqZkInLku0AfCmFIKNim8yoj+SGQVhJQUNqvmab1X2tIA+XCC+uuE9tjHOYOGrSbOaKgIUlGOrD7FsNZhEUo/PRDCktZitNazGU5W3RVvxq2Lkmq4pmztl3LbSG2beqh6c9FZzAjBmuqqPhVh+/dKtjoKPNo4ZfiltuE3/xvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957971; c=relaxed/simple;
	bh=CT7UBDJsDpXV8Zfelo4jYLS1A1s6ZN+yHV49dQGjc98=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siU8Zo5H4IczXCx+zUoMJ7BFzNB5uBp94G6cte2M9i0TkT4BOeYc02JNT+MYnIxZh1yTJPKqdB0XCn8LGAla8FNdPppt2G1ThqyDPb+2qcU/KwaWzyUyDkj9pifZ0jg6SgD6CVr3S02Hry03FlZmqbyLgzP/JKMjhNjUNBdKtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XSHV75jkgz1j9h3;
	Tue, 15 Oct 2024 10:04:47 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 15956140134;
	Tue, 15 Oct 2024 10:06:00 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 10:05:59 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <akpm@linux-foundation.org>, <shuah@kernel.org>, <zokeefe@google.com>
CC: <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: [PATCH] selftests: mm: fix the incorrect usage() info of khugepaged
Date: Tue, 15 Oct 2024 10:02:57 +0800
Message-ID: <20241015020257.139235-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)

The mount option of tmpfs should be huge=advise, not madvise
which is not supported and may mislead the users.

Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 tools/testing/selftests/mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 56d4480e8d3c..8a4d34cce36b 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1091,7 +1091,7 @@ static void usage(void)
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
 	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
 	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
-	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
+	fprintf(stderr,	"\tmounted with huge=advise option for khugepaged tests to work\n");
 	fprintf(stderr,	"\n\tSupported Options:\n");
 	fprintf(stderr,	"\t\t-h: This help message.\n");
 	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
-- 
2.33.0


