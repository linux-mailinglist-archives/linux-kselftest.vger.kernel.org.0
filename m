Return-Path: <linux-kselftest+bounces-44873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9013C392F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 06:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95694E309E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 05:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7B211706;
	Thu,  6 Nov 2025 05:44:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A061DA0E1;
	Thu,  6 Nov 2025 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407845; cv=none; b=ABqqV4oJRnPgUSOIITjKp5Voa3UgPcksTv+D6EUsqsDpDMadDUcKZVmOx68v0SLoRFX/d+VvFsjHH2DJxF6ipH2aJMc1Rg8SIJMXuql0NWG9AF8kyIr44RUEFBBKK8YHU0xE+BPlxJaMGRmlOoJr36jgqTLQeJp8gK31HK1ieRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407845; c=relaxed/simple;
	bh=VltWER56COxnICQrkyLAFOuJG20Kgc9n+y4y0mPsSQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arkVqgStJIhfhSR3oJEJ1NR39VRXC77P76cJW7HmozIc34KzAGsnab6uSlftebInxhz7BQZlf1fe0vbiLgXTQPhwupH/yH/9TYu1hClepy0dxS0zPgfhDhKpWCNKYwhKmwK1dqX10gjbbrOJqPzYsTPXFGbpMKewVRkCO1HxrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5690c34dfdf7-a5f1b;
	Thu, 06 Nov 2025 13:40:52 +0800 (CST)
X-RM-TRANSID:2ee5690c34dfdf7-a5f1b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1690c34e2fa4-4531b;
	Thu, 06 Nov 2025 13:40:52 +0800 (CST)
X-RM-TRANSID:2ee1690c34e2fa4-4531b
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftests/dma: fix invalid array access in printf
Date: Thu,  6 Nov 2025 11:30:56 +0800
Message-ID: <20251106033056.1926-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The printf statement attempts to print the DMA direction string using
the syntax 'dir[directions]', which is an invalid array access. The
variable 'dir' is an integer, and 'directions' is a char pointer array.
This incorrect syntax should be 'directions[dir]', using 'dir' as the
index into the 'directions' array. Fix this by correcting the array
access from 'dir[directions]' to 'directions[dir]'.

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..b925756373ce 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 	}
 
 	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
-			threads, seconds, node, dir[directions], granule);
+			threads, seconds, node, directions[dir], granule);
 	printf("average map latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_map_100ns/10.0, map.map_stddev/10.0);
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
-- 
2.50.1.windows.1




