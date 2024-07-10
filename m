Return-Path: <linux-kselftest+bounces-13438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299C92CB79
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 08:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939A71C22837
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658A79B7E;
	Wed, 10 Jul 2024 06:58:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7082485;
	Wed, 10 Jul 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594690; cv=none; b=lFmQYLWDyDxHl50QIBqVWy/61Y7J9HdPNnD+MHlSt8crv32f7IvoTLM2F0zBsurKyjVzWpBCfIa9leMPPLb3cYy82mxpY5VrpSv7ZCixGb5FVMXrzd1gRDhPXS1nHvhP9+n+6pcY/mKnvFFB+2r0H/vMqngT1Ofmby6rsmupQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594690; c=relaxed/simple;
	bh=fYPEXmI/LBSoVmcAiF9CNVOmJ6j5dnKxaStvmGwt1Ew=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Oga7UWaBuBiDfODeagj2tSZOJY6ud8TciQzyOjJmcdLU++mOvtst6EBXVrkB/edSjwMwtSW0ZACK0HQymtPCEoiU0ysXhj9g0csG1Q5fAwwJOdGyOHi8aMOD2ckZGyTXfqXJd4zhfhqNI1DvD5VDVkGCHDzwNzkUMNgWN/cBKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3668e30f7f1f-f972a;
	Wed, 10 Jul 2024 14:58:01 +0800 (CST)
X-RM-TRANSID:2ee3668e30f7f1f-f972a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2668e30f8765-e00fc;
	Wed, 10 Jul 2024 14:58:01 +0800 (CST)
X-RM-TRANSID:2ee2668e30f8765-e00fc
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: chenxiang66@hisilicon.com,
	zhujun2@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/dma:remove unused variable
Date: Tue,  9 Jul 2024 23:57:59 -0700
Message-Id: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The variable are never referenced in the code, just remove it
that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 3fcea00961c0..c91b485ca99a 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -33,7 +33,6 @@ int main(int argc, char **argv)
 	int granule = 1;
 
 	int cmd = DMA_MAP_BENCHMARK;
-	char *p;
 
 	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
 		switch (opt) {
-- 
2.17.1




