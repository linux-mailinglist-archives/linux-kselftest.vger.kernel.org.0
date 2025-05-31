Return-Path: <linux-kselftest+bounces-34100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D84AC99C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E03189B055
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17A22D7BF;
	Sat, 31 May 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG83xyDa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF803398B;
	Sat, 31 May 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674981; cv=none; b=hUtBi0DaCvfb3azRcQ4fZKEBlmI4WsB/26EfSFEJEHe05mPLEHtnU1CXj0kSQ0o0oOcvGwnKveost4ikSYHbCOK5nf1NAMSSpvjQosHy1/uaj+gmLYV4fvrDBu6JzZQjntxU8SDr5pHEDkf842qd6+VLL4rBvqi0wOypfkOMtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674981; c=relaxed/simple;
	bh=DswE2TwuuIytt3LvxEg3WwL0l+4g2d16uTME9WzPi2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+QSfPhzFQES/6ZjbG3oQAtnzcrzfIGja4jLR5OnC8S5izhQOjAyhz+iRYnFnM2Ne+vF2LGk9asIukLAyFNzh+FjOw99R17i0x4GZjDo3F6uEbPVu/Z/CCaBrPrEUDeBzcssdwdwRYbpTjeZZkdnb43zjgy2g/T9m4uDxIFYrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG83xyDa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747d59045a0so53490b3a.1;
        Sat, 31 May 2025 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674979; x=1749279779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaJSKOBzeU+bQnzHBt7Umgn5ZEd7j+MngwkiV+M03AY=;
        b=OG83xyDaXorMyfkOW3PlRDn76lyX0DmA005Wf5raZigVy8cE9pIzcCDnShGURXrVQv
         VwvuUCVN8ZQIbEXgjOR852cj5WUpRoaB63SzqJHa9oXmtXAvyKqxwRqnTqhhhBjjiS1p
         kqmvP/y7sFx2RTe1Rrc4pWeVefMZ/7DhpgRLVDVCbVswQCBBEdCs7R+fr0JnItgBqy+m
         ugnlc1UaILP01xW6uX6J5IJulPdYivWR89WZ2ZjxtZ4NWUXU0kCe78IOiTGewynOwFuZ
         2NNe3IIqdSbcyeRcj+i3lBOsFGfUFQ6In0MB0v6nxXnsJKvreXWy3iB6O9NPBPFbmdWo
         65VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674979; x=1749279779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaJSKOBzeU+bQnzHBt7Umgn5ZEd7j+MngwkiV+M03AY=;
        b=QjPAYAF2/ZEBd1Y/wwGHxyoR8zAXQqhE2/quEWazk9DXo/0UOiNk0caQaRd+f3iPI0
         0haMjnjnYIKdk9rr3bgD/g1OO+8bZ1Gn9fvO99ZAzTZfj3MlvwkXUUsDPa616IOxbEB0
         d8WvjLYTDpIzAFuPljqPET/rH2Y1HNDAhcByQFKkXdNUUcgJGo5hzjRbccmoKCqBHtsz
         MxBVIew/1M0xF1VVTRzRQHgKBq7Td5Vg7M9Z3yy9tnOfKMxfpuXkq2cbvY4ECBz0rl6y
         lXOgCW0kmEJrw17lRolpah6J2D1O+ZCdO/UhbdaCJceyLOPNS3GjSMSqL966lHCnbRpm
         PY/g==
X-Forwarded-Encrypted: i=1; AJvYcCViulKgIpusuEBwxkdt/quKCxwXh+nm0Rl9e9AVpymJLWRf6rEhqVUMPdOR2aYhdv8aXBHbmTBtej3P11U=@vger.kernel.org, AJvYcCWlO22aQlkyb/YkPPzhpSWolrk+ORvjqTMbBSpkeoo2cDUsSVNAfmIRwsZ5n7h8T0cc2p3MwvZV6HI3LqQLqU7m@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYiA7aiaKhVv41J/fCQ/676ZZomfigeJPt+sjsbI3Iy2Mze6g
	6u32lRvkqHUm7DqJjYakUF9TvumCnaEjIgKurLIymvre4MdzzJFmEj/I
X-Gm-Gg: ASbGncvLeDxfD3pmFsaydmsvpT0nPaIEnc65jZTiFgY4k29HYqk0+6LhQDSDw42TtZt
	gsrZwmcQSL8OWMsa7YkeWybIZQWMopGnte9mz4eNOt8YuXgVoUAQaA3nLb2VGZbQ+9SbUEQb/b+
	lk6gOo8uZ/4Dj4DuRUlic+XUs1QGH3CrW1Y0mveUQry70dFbAf8RmYhqdZbJ0wj/AscJCFlW8WM
	zrMyGMZkdN5rIZ1N+KuYSvZFyspWGEn04RmiL4rqU/0IgTespj3QQrXIdGQ+gyZs0RczOjIfhyf
	aFjSioYiT44sV1bfgB6qcvlejgk8gLEzUnx7t3AexbmXzT3uR+Ce4HEqKhtjxK7CoOXzzOuh7I+
	LvUcm6uG4JIHUMaqGoVFKpyM+rSxUO2CvTiyy17OBAg==
X-Google-Smtp-Source: AGHT+IGh3EaAtFlrfSeI9IH8D1uOTK4HYia9JvlVMLpWPHep8rlmidI+sAlX9uRRm9NAevjP+iAWQg==
X-Received: by 2002:a05:6a20:3ca5:b0:203:becd:f9ce with SMTP id adf61e73a8af0-21ae00ce772mr6822768637.39.1748674978829;
        Sat, 31 May 2025 00:02:58 -0700 (PDT)
Received: from localhost.localdomain (114-136-199-106.emome-ip.hinet.net. [114.136.199.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb29a39sm2116126a12.22.2025.05.31.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 00:02:58 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: usama.anjum@collabora.com,
	zhangjiao2@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH] selftests: ipc: Replace fail print statements with ksft_test_result_fail
Date: Sat, 31 May 2025 15:01:40 +0800
Message-ID: <20250531070140.24287-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the standard kselftest failure report function to ensure consistent
test output formatting. This improves readability and integration with
automated test frameworks.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 tools/testing/selftests/ipc/msgque.c | 47 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index e9dbb84c100a..5e36aeeb9901 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -39,26 +39,26 @@ int restore_queue(struct msgque_data *msgque)
 
 	fd = open("/proc/sys/kernel/msg_next_id", O_WRONLY);
 	if (fd == -1) {
-		printf("Failed to open /proc/sys/kernel/msg_next_id\n");
+		ksft_test_result_fail("Failed to open /proc/sys/kernel/msg_next_id\n");
 		return -errno;
 	}
 	sprintf(buf, "%d", msgque->msq_id);
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret != strlen(buf)) {
-		printf("Failed to write to /proc/sys/kernel/msg_next_id\n");
+		ksft_test_result_fail("Failed to write to /proc/sys/kernel/msg_next_id\n");
 		return -errno;
 	}
 
 	id = msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
 	if (id == -1) {
-		printf("Failed to create queue\n");
+		ksft_test_result_fail("Failed to create queue\n");
 		return -errno;
 	}
 
 	if (id != msgque->msq_id) {
-		printf("Restored queue has wrong id (%d instead of %d)\n",
-							id, msgque->msq_id);
+		ksft_test_result_fail("Restored queue has wrong id (%d instead of %d)\n"
+								, id, msgque->msq_id);
 		ret = -EFAULT;
 		goto destroy;
 	}
@@ -66,7 +66,7 @@ int restore_queue(struct msgque_data *msgque)
 	for (i = 0; i < msgque->qnum; i++) {
 		if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
 			   msgque->messages[i].msize, IPC_NOWAIT) != 0) {
-			printf("msgsnd failed (%m)\n");
+			ksft_test_result_fail("msgsnd failed (%m)\n");
 			ret = -errno;
 			goto destroy;
 		}
@@ -90,23 +90,22 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 		if (ret < 0) {
 			if (errno == ENOMSG)
 				break;
-			printf("Failed to read IPC message: %m\n");
+			ksft_test_result_fail("Failed to read IPC message: %m\n");
 			ret = -errno;
 			goto err;
 		}
 		if (ret != msgque->messages[cnt].msize) {
-			printf("Wrong message size: %d (expected %d)\n", ret,
-						msgque->messages[cnt].msize);
+			ksft_test_result_fail("Wrong message size: %d (expected %d)\n", ret, msgque->messages[cnt].msize);
 			ret = -EINVAL;
 			goto err;
 		}
 		if (message.mtype != msgque->messages[cnt].mtype) {
-			printf("Wrong message type\n");
+			ksft_test_result_fail("Wrong message type\n");
 			ret = -EINVAL;
 			goto err;
 		}
 		if (memcmp(message.mtext, msgque->messages[cnt].mtext, ret)) {
-			printf("Wrong message content\n");
+			ksft_test_result_fail("Wrong message content\n");
 			ret = -EINVAL;
 			goto err;
 		}
@@ -114,7 +113,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 	}
 
 	if (cnt != msgque->qnum) {
-		printf("Wrong message number\n");
+		ksft_test_result_fail("Wrong message number\n");
 		ret = -EINVAL;
 		goto err;
 	}
@@ -139,7 +138,7 @@ int dump_queue(struct msgque_data *msgque)
 		if (ret < 0) {
 			if (errno == EINVAL)
 				continue;
-			printf("Failed to get stats for IPC queue with id %d\n",
+			ksft_test_result_fail("Failed to get stats for IPC queue with id %d\n",
 					kern_id);
 			return -errno;
 		}
@@ -150,7 +149,7 @@ int dump_queue(struct msgque_data *msgque)
 
 	msgque->messages = malloc(sizeof(struct msg1) * ds.msg_qnum);
 	if (msgque->messages == NULL) {
-		printf("Failed to get stats for IPC queue\n");
+		ksft_test_result_fail("Failed to get stats for IPC queue\n");
 		return -ENOMEM;
 	}
 
@@ -162,7 +161,7 @@ int dump_queue(struct msgque_data *msgque)
 		ret = msgrcv(msgque->msq_id, &msgque->messages[i].mtype,
 				MAX_MSG_SIZE, i, IPC_NOWAIT | MSG_COPY);
 		if (ret < 0) {
-			printf("Failed to copy IPC message: %m (%d)\n", errno);
+			ksft_test_result_fail("Failed to copy IPC message: %m (%d)\n", errno);
 			return -errno;
 		}
 		msgque->messages[i].msize = ret;
@@ -178,7 +177,7 @@ int fill_msgque(struct msgque_data *msgque)
 	memcpy(msgbuf.mtext, TEST_STRING, sizeof(TEST_STRING));
 	if (msgsnd(msgque->msq_id, &msgbuf.mtype, sizeof(TEST_STRING),
 				IPC_NOWAIT) != 0) {
-		printf("First message send failed (%m)\n");
+		ksft_test_result_fail("First message send failed (%m)\n");
 		return -errno;
 	}
 
@@ -186,7 +185,7 @@ int fill_msgque(struct msgque_data *msgque)
 	memcpy(msgbuf.mtext, ANOTHER_TEST_STRING, sizeof(ANOTHER_TEST_STRING));
 	if (msgsnd(msgque->msq_id, &msgbuf.mtype, sizeof(ANOTHER_TEST_STRING),
 				IPC_NOWAIT) != 0) {
-		printf("Second message send failed (%m)\n");
+		ksft_test_result_fail("Second message send failed (%m)\n");
 		return -errno;
 	}
 	return 0;
@@ -202,44 +201,44 @@ int main(int argc, char **argv)
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
-		printf("Can't make key: %d\n", -errno);
+		ksft_test_result_fail("Can't make key: %d\n", -errno);
 		ksft_exit_fail();
 	}
 
 	msgque.msq_id = msgget(msgque.key, IPC_CREAT | IPC_EXCL | 0666);
 	if (msgque.msq_id == -1) {
 		err = -errno;
-		printf("Can't create queue: %d\n", err);
+		ksft_test_result_fail("Can't create queue: %d\n", err);
 		goto err_out;
 	}
 
 	err = fill_msgque(&msgque);
 	if (err) {
-		printf("Failed to fill queue: %d\n", err);
+		ksft_test_result_fail("Failed to fill queue: %d\n", err);
 		goto err_destroy;
 	}
 
 	err = dump_queue(&msgque);
 	if (err) {
-		printf("Failed to dump queue: %d\n", err);
+		ksft_test_result_fail("Failed to dump queue: %d\n", err);
 		goto err_destroy;
 	}
 
 	err = check_and_destroy_queue(&msgque);
 	if (err) {
-		printf("Failed to check and destroy queue: %d\n", err);
+		ksft_test_result_fail("Failed to check and destroy queue: %d\n", err);
 		goto err_out;
 	}
 
 	err = restore_queue(&msgque);
 	if (err) {
-		printf("Failed to restore queue: %d\n", err);
+		ksft_test_result_fail("Failed to restore queue: %d\n", err);
 		goto err_destroy;
 	}
 
 	err = check_and_destroy_queue(&msgque);
 	if (err) {
-		printf("Failed to test queue: %d\n", err);
+		ksft_test_result_fail("Failed to test queue: %d\n", err);
 		goto err_out;
 	}
 	ksft_exit_pass();
-- 
2.48.1


