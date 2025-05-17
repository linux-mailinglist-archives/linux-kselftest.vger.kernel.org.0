Return-Path: <linux-kselftest+bounces-33249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E350ABAA0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594153AEAB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A91EE017;
	Sat, 17 May 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab8dRkii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001B4B1E7F;
	Sat, 17 May 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747484889; cv=none; b=ni3igsCLj1dYqvlVKq7uEvYYTwZPpjwDgyqMN4ntnjbt7UtXx4p6bhqCD4ZqXT+fCqr2yruV2mSSH+vaYO+Bkwsc8hK0GQiqa6c7jep4mSSBT0fobWdargBmXbcV/PktWL4kGnHFBbHkRV3hijt5DV2WCda5AMTNHVzsWAKsyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747484889; c=relaxed/simple;
	bh=RoB5ejzT39dJyqDA/LHnS6c5cSx+S+1vl0bptQDv+Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGyI1uUW9Z1xC5iPg1pEgJlb8Y8bThWV7uTfuTPeM5oClmkm95NPhnExY44Q2uKhhEgU/HIhgF0qMOa++wtvHTzJzkYD3zw/o2F3hBtTDhxkIjzThXdUwZGxjtdVFcUOS6hWIGw+18Hhn1W11p9XC5wT3GW6Bu0uc/2KJLlgtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab8dRkii; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22fa47d6578so26660025ad.2;
        Sat, 17 May 2025 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747484887; x=1748089687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6akfme5Vv/pIFUI0IHvo07yJJuYolE7NanFLpkcN5cU=;
        b=Ab8dRkii34ajpe13/kvSn8yRdqYwxJzlzmVFLKilCElNzYZx4idrNqAiU1GM2p6lB9
         MoRIp8VIXpBaggstMvG0LdJaKcQuYgSM7cT8YxN6P41CKu5MmdATrcmJtSPHWs9us8OK
         iJZwBhQ4WCa2C+/6EJMUuA4Vj8PAKTuZ5OeTr9bhgv/KI2Asj1HuSgDs8Va5sYWrSDKc
         KtTdH/2+T5KOyoxa812DfOZZ2SE3I0n6ib+FSFAgEITDtf/20RQEUDLmned+yMSv+IOF
         7kiVR/CNZ1gwjlHV7xORWSIHalyClCopzfy/8qEKLVr8CPHIgSid9fhtFpVC93cb8952
         ViuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747484887; x=1748089687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6akfme5Vv/pIFUI0IHvo07yJJuYolE7NanFLpkcN5cU=;
        b=P0C8MYvdcr0jUj5D5VpEnihtDVm7TNfmF3L9a7nNmpyGCG2rZwWZRUNvJbAlS2kkVy
         FITILGFKCzBRQ6n54dsHmucROQ/kOfC3trbgemvpVAQU73AjqduLd+nvb7aSCe3DKb8x
         R2HsbZqn8J9iCYrOQxrKEgNzsnLP9d1MF1rhmYvAcmQhbDfQTOetrygTCYKETgq+RKs6
         HpMM3liOq7O/1lXBvEGgn/WZQr8TXKvcR50oPP4p+B5d4mDawKTbBmLXXu/lESARRa7v
         F7A0TepMOpzxv+JXK1MDi+AE0obIMUwH7smDBIEFDk3PSb2tpPfq1eBcZwlhyRKsuAje
         NGoA==
X-Forwarded-Encrypted: i=1; AJvYcCWu4vXsmBDFJ0yWQMRjsbp0j3XUhkcd8Ta1RE/OYFGJMBdKRkjrGBumuQ/Qb7J4RQSPxgW2yibr2vw2F6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXwYNIIe/0rGM61ONgvfW7oKT7m7BHQ8c0g9OYVrOHpkaSpNb
	kScYrBdeFuPbsGXv1ibpxy5vrKAsY1mH1z2iX4Uv9vZsDTpi5KBHSm0=
X-Gm-Gg: ASbGncsJYdrziROfpP8SaxUG9c5OLPRwRnvfCsuXT1Qk8YXXRiTPvkU6AdUaE3nhjfE
	ixRFD+rGvf6DNNs8+KrskC4w/aNeM6GLmm5miLDIsE46kkzgCtmI8zO15Npfj9SQ46Ty18FolNP
	4gEInPGBY/DuP/w6yl2nE4lunYDtpsXlMD5N/lRCZR26lINcpcBtc8a3Lt3tvmvL95ghMnYnTGq
	LJf4WN9eyHx7p0IxvCOejHAewDeKo9ZMhkqQt5tvxu0n6CGjKw5Fk5KcxAYKZkOdu3N5D02F9b8
	7DunaES7OLgSoHg9faPR4ObYLtTH69ST9QPCqbaGiWkQpx8nPvWvtT7XabFOBjENBSFKQRLkvU1
	cLvZemiKenXE=
X-Google-Smtp-Source: AGHT+IHLOGoDESwOuLswcndnDgr70wl1Ia0pGTRKmV8q3PttojQ3xY1z5pJKY4Azg59AkBlEtEoYUQ==
X-Received: by 2002:a17:903:1b6d:b0:231:cec7:34fe with SMTP id d9443c01a7336-231d454ebb5mr98126925ad.46.1747484886750;
        Sat, 17 May 2025 05:28:06 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([103.211.112.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97ec3sm29609165ad.107.2025.05.17.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 05:28:06 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: skhan@linuxfoundation.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] selftests/seccomp: report errno and add hints on failure
Date: Sat, 17 May 2025 17:57:40 +0530
Message-ID: <20250517122740.35043-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 14ba51b52095..d6a85d7b26da 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4508,7 +4508,11 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
 	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
-
+	int rc = get_nth(_metadata, proc_path, 3, &line);
+    	if (rc != 1) {
+        	printf("[ERROR] user_notification_fifo: failed to read stat for PID %d (rc=%d)\n", pid, rc);
+    	}
+    	ASSERT_EQ(rc, 1);
 	status = *line;
 	free(line);
 
@@ -4518,6 +4522,7 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 TEST(user_notification_fifo)
 {
 	struct seccomp_notif_resp resp = {};
+	ksft_print_msg("[INFO] Starting FIFO notification test\n");
 	struct seccomp_notif req = {};
 	int i, status, listener;
 	pid_t pid, pids[3];
@@ -4535,6 +4540,7 @@ TEST(user_notification_fifo)
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
+	ksft_print_msg("[INFO] user_notification_fifo: listener PID is %d\n", listener);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
-- 
2.43.0


