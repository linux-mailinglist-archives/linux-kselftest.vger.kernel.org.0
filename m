Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64C314A86
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBIIkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 03:40:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:41615 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhBIIks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 03:40:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UOHlriS_1612859989;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UOHlriS_1612859989)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Feb 2021 16:40:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, shuah@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selftests/bpf: Simplify the calculation of variables
Date:   Tue,  9 Feb 2021 16:39:47 +0800
Message-Id: <1612859987-93923-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/bpf/xdpxceiver.c:954:28-30: WARNING !A || A &&
B is equivalent to !A || B.

./tools/testing/selftests/bpf/xdpxceiver.c:932:28-30: WARNING !A || A &&
B is equivalent to !A || B.

./tools/testing/selftests/bpf/xdpxceiver.c:909:28-30: WARNING !A || A &&
B is equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 99ea6cf..f4a96d5 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -897,7 +897,7 @@ static void *worker_testapp_validate(void *arg)
 			ksft_print_msg("Destroying socket\n");
 	}
 
-	if (!opt_bidi || (opt_bidi && bidi_pass)) {
+	if (!opt_bidi || bidi_pass) {
 		xsk_socket__delete(ifobject->xsk->xsk);
 		(void)xsk_umem__delete(ifobject->umem->umem);
 	}
@@ -922,7 +922,7 @@ static void testapp_validate(void)
 	pthread_mutex_lock(&sync_mutex);
 
 	/*Spawn RX thread */
-	if (!opt_bidi || (opt_bidi && !bidi_pass)) {
+	if (!opt_bidi || !bidi_pass) {
 		if (pthread_create(&t0, &attr, worker_testapp_validate, ifdict[1]))
 			exit_with_error(errno);
 	} else if (opt_bidi && bidi_pass) {
@@ -942,7 +942,7 @@ static void testapp_validate(void)
 	pthread_mutex_unlock(&sync_mutex);
 
 	/*Spawn TX thread */
-	if (!opt_bidi || (opt_bidi && !bidi_pass)) {
+	if (!opt_bidi || !bidi_pass) {
 		if (pthread_create(&t1, &attr, worker_testapp_validate, ifdict[0]))
 			exit_with_error(errno);
 	} else if (opt_bidi && bidi_pass) {
-- 
1.8.3.1

