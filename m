Return-Path: <linux-kselftest+bounces-13437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4E92CB1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 08:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E84728287F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 06:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157C4AEF4;
	Wed, 10 Jul 2024 06:31:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30A3D96D;
	Wed, 10 Jul 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593064; cv=none; b=gs648NirWs7P3XVG/wGZ3HTMlCbuVXF7vJWQtx2BWYbq80acO3YY+5BBeoBBC4o9eCmDdO2nK/2z7l38xc5ltB1s7c9EHjY6UUmPuI0CX/EyRhESeCFFR6zWAwOe8Ktyv9NWCkNGOGzhJ6ViIOUOEDzlojxXO1qdU0wJP2APtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593064; c=relaxed/simple;
	bh=sM6KFWH6gfzQ94i0OID2kqBYu4u4wpOqFm2ESjUAg1I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ko2ruFZcVA2iDbP/w6boEw7h7fNj6TDJCoT+uamcCRhkXk/6CdN0XdBfo6iblzVbMoioQnsgNxNcJF+AfEieW2lwLHLfDfBKRtegqyb618MOCHQP4kNYy5EhOzBtzF2F0cPkxg8WtjRvyoY+8RF3axSswYK/FSDznlaRc/8mZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3668e2a989c3-f91ce;
	Wed, 10 Jul 2024 14:30:50 +0800 (CST)
X-RM-TRANSID:2ee3668e2a989c3-f91ce
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4668e2a99679-de188;
	Wed, 10 Jul 2024 14:30:49 +0800 (CST)
X-RM-TRANSID:2ee4668e2a99679-de188
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com,
	chenxiang66@hisilicon.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/dma:Fix a resource leak
Date: Tue,  9 Jul 2024 23:30:45 -0700
Message-Id: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 5c997f17fcbd..3fcea00961c0 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -114,6 +114,7 @@ int main(int argc, char **argv)
 	map.granule = granule;
 
 	if (ioctl(fd, cmd, &map)) {
+		close(fd);
 		perror("ioctl");
 		exit(1);
 	}
@@ -125,5 +126,7 @@ int main(int argc, char **argv)
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
 
+	close(fd);
+
 	return 0;
 }
-- 
2.17.1




