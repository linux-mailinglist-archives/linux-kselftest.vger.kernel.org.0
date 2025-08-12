Return-Path: <linux-kselftest+bounces-38762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41549B22016
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E57D1B61970
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304A2E06EA;
	Tue, 12 Aug 2025 07:57:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04C2D6E4B;
	Tue, 12 Aug 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985432; cv=none; b=qD7Rt17/TJG/8KQD+NDnKg0ZC9Nojabxz8g0RNJJXtX5qn60fftX+QNO8MSoREmMm3AfscOSoLOcMcC7auCB7+MgoScobizrLQtQY1m2GLD74T6S7XxEkePjDYc8Q+EO1bgkOD7TCuXBCejJO67nbewzMqf8vZEZxBU7VYWjoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985432; c=relaxed/simple;
	bh=fBZW+gSb3x+bKEeBXEiVF8gvx98ESt7G5KmM8aSlMto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpjXh7ojlNgJsq8J7FPBOVGeVOfcmm4bb9GiwwZnhXelfhM9EgM7tUOog+P7qYBQLVpFxCaVjDGwA33K4n8gNmmJ3amUobIKFMOkLudNA+pQpipUhUB1UR449lCMO3crQwAqKXY0HagH2Na0vjlrOn5BYX88YWgv8+b0bRJwlEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3689af30eaa6-96370;
	Tue, 12 Aug 2025 15:53:56 +0800 (CST)
X-RM-TRANSID:2ee3689af30eaa6-96370
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W4100033 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4689af30cac4-dffae;
	Tue, 12 Aug 2025 15:53:56 +0800 (CST)
X-RM-TRANSID:2ee4689af30cac4-dffae
From: bajing <bajing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: lizhijian@fujitsu.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bajing@cmss.chinamobile.com
Subject: [PATCH] watchdog-test.c: Remove unused variable in main
Date: Tue, 12 Aug 2025 15:53:45 +0800
Message-ID: <20250812075345.872-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since $optind is not used in the subsequent code, the variable
should be removed.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index a1f506ba5578..837001a9e3a0 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -209,8 +209,6 @@ int main(int argc, char *argv[])
 		exit(ret);
 	}
 
-	optind = 0;
-
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
 		switch (c) {
 		case 'b':
-- 
2.33.0




