Return-Path: <linux-kselftest+bounces-44691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C2C2F08D
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 03:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E5044E2296
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE925DB1A;
	Tue,  4 Nov 2025 02:55:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED11FFC6D;
	Tue,  4 Nov 2025 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224954; cv=none; b=GQ5OLkS/MMBE68T1D4oSQyffLn+oCWXOBui/YvC36ypmNHOlDbP7jJlmdRFBETXptcekuOXV1y08INOXqgNAIEb4SMfWGupkpUqYTpxai9i9Sg4f7XXDGsPxkiz252SLF1g0jo/6N+YsQgSdxUkrBNxB45KkCFBuC1ia304TsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224954; c=relaxed/simple;
	bh=VltWER56COxnICQrkyLAFOuJG20Kgc9n+y4y0mPsSQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbR1I9gutV+FaFry85wloaLb+LdknMspE/CGN0wWypF488Ug0sWtjdLc2zVAZZ8vvlJMwzBBfn3E/jjTQRN94DLKK9uPl8DoxdS+LOaKz6MQFJxPiLV3K8F5IPTogSo55q4YDr0E5IVnLA1UIhY7/zurV0xV63/22J2vxCL9q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee669096a78c98-5d63c;
	Tue, 04 Nov 2025 10:52:40 +0800 (CST)
X-RM-TRANSID:2ee669096a78c98-5d63c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee969096a745a9-e9e91;
	Tue, 04 Nov 2025 10:52:39 +0800 (CST)
X-RM-TRANSID:2ee969096a745a9-e9e91
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftests/dma: fix invalid array access in printf
Date: Tue,  4 Nov 2025 10:52:34 +0800
Message-ID: <20251104025234.2363-1-zhangchujun@cmss.chinamobile.com>
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




