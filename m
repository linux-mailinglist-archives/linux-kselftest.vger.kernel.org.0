Return-Path: <linux-kselftest+bounces-1034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAF802CAB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 09:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A7280A23
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09249CA4A;
	Mon,  4 Dec 2023 08:06:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7362510C;
	Mon,  4 Dec 2023 00:06:08 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8656d8867851-c7851;
	Mon, 04 Dec 2023 16:06:00 +0800 (CST)
X-RM-TRANSID:2ee8656d8867851-c7851
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2656d8862379-275e9;
	Mon, 04 Dec 2023 16:05:59 +0800 (CST)
X-RM-TRANSID:2ee2656d8862379-275e9
From: liujing <liujing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] Fixed an open function not judging the return value and closed the open function
Date: Mon,  4 Dec 2023 03:05:54 -0500
Message-Id: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index cacbd2a4aec9..5fc9b46f236f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -205,7 +205,12 @@ static int make_exe(const uint8_t *payload, size_t len)
 	/* Avoid ETXTBSY on exec. */
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
 	fd1 = open(buf, O_RDONLY|O_CLOEXEC);
+	if (fd == -1) {
+		exit(1);
+	}
+
 	close(fd);
+	close(fd1);
 
 	return fd1;
 }
-- 
2.18.2




