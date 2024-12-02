Return-Path: <linux-kselftest+bounces-22655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3D9DFAD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32675161ADD
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D01D63F9;
	Mon,  2 Dec 2024 06:46:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC11D61AC;
	Mon,  2 Dec 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121999; cv=none; b=PQDCeEz0sZELSVmMbwpYRIAz8FZpcsgnGio7slOhDBuVyXhHFBeWR0vqGzfZ3lFzSfgxerTOOukYiHeYgNbiqaR6eJHgezmbz/UU5ZoZ0EnwjB63TiNFNyjiFaP2NUufFU9Xkpb5crPfiBvps9Nntc1IhLcZlLCFOPm5BZQr1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121999; c=relaxed/simple;
	bh=hxc65VefIzXh0alDcpnjNt1h9d/rTdrAlp1+cSoaozo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8Re358AYV8fOVJg4l2IRQgZm4Qthh1Oi+rvL/7e26wflhhZJbiOhIKoMT3stG6JtFKwz1CJRsqp5mmJfgU5aKIvGlo4eyX8rzdu/wAL3KqD69U9s0aFpe731kbDGcO3ehylbrndE6J7IQnGyr8SIaxhERe8eWIIjUxBXHp8/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2674d570d9dd-eb9fb;
	Mon, 02 Dec 2024 14:43:26 +0800 (CST)
X-RM-TRANSID:2ee2674d570d9dd-eb9fb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8674d570dbbb-dc264;
	Mon, 02 Dec 2024 14:43:26 +0800 (CST)
X-RM-TRANSID:2ee8674d570dbbb-dc264
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	usama.anjum@collabora.com,
	tglx@linutronix.de,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests/ipc: Remove unused variables
Date: Mon,  2 Dec 2024 12:58:27 +0800
Message-Id: <20241202045827.4704-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Delete variables "msg" and "pid" that have never been used.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/ipc/msgque.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index c75ea4094870..e9dbb84c100a 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -194,7 +194,7 @@ int fill_msgque(struct msgque_data *msgque)
 
 int main(int argc, char **argv)
 {
-	int msg, pid, err;
+	int err;
 	struct msgque_data msgque;
 
 	if (getuid() != 0)
-- 
2.33.0




