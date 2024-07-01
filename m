Return-Path: <linux-kselftest+bounces-13001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00191DE21
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 13:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0711E1F2227C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4314B061;
	Mon,  1 Jul 2024 11:33:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F312B9C6;
	Mon,  1 Jul 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833588; cv=none; b=mJsLn0nTb8hUfLNM8GInzqrso/zhTuShEAkQwM+LFDCtFjLOJjMGI3Dut+ytHKAjUKF9upl47QYgKN5OEt8Nz7D7fZczZEjjxYBdyjIRfr9vB8Wwrxq9uTV4hmdybXQJFcD+0kQwNH0S7E9DtIwr8TczQTGjrtYiTon5qwXGUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833588; c=relaxed/simple;
	bh=4+Ivk6b2jrBFJKc513Er8JVn7rnOHx579gQcUdHuc9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tThuozjWfCcDDA2SsVtRyNCE7Y9Xl/9KDx1JcvAhIBZiyCdYfFyoRnmaieCBDI/BQAbgxxa8IMQR7zx/Dx4LaGkG0hj/amKWFJFO4eAUtnvb4prsx/Bi/HoP308edCkfc/W8fieq88220rBmLIGD/oXFTKyZ9VbGXPMI0PbqHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1668293e5196-afa90;
	Mon, 01 Jul 2024 19:32:53 +0800 (CST)
X-RM-TRANSID:2ee1668293e5196-afa90
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3668293e3681-69d77;
	Mon, 01 Jul 2024 19:32:53 +0800 (CST)
X-RM-TRANSID:2ee3668293e3681-69d77
From: Liu Jing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftest: epoll_busy_poll: remove unnecessary assignment in TEST_F(epoll_busy_poll, test_get_params)
Date: Mon,  1 Jul 2024 19:32:51 +0800
Message-Id: <20240701113251.6630-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the TEST_F(epoll_busy_poll, test_get_params), the initialized value of 'ret' is unused,
because it will be assigned by the ioctl.thus remove it.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/net/epoll_busy_poll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
index 16e457c2f877..652b0957b6c5 100644
--- a/tools/testing/selftests/net/epoll_busy_poll.c
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -130,7 +130,7 @@ TEST_F(epoll_busy_poll, test_get_params)
 	 * the default should be default and all fields should be zero'd by the
 	 * kernel, so set params fields to garbage to test this.
 	 */
-	int ret = 0;
+	int ret;
 
 	self->params.busy_poll_usecs = 0xff;
 	self->params.busy_poll_budget = 0xff;
-- 
2.33.0




