Return-Path: <linux-kselftest+bounces-38741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC3B219EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D771F1A23A42
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0A2D660E;
	Tue, 12 Aug 2025 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEFayJqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836127450;
	Tue, 12 Aug 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959870; cv=none; b=sJi5P1Cc7ugqge2TcM4lZn+1JPk5pqe6SLD358ewm5hCvjQUjw7R+9134zBgbIs8+x1uR3t0WfLpVmnbMrOp57BpN0KaaNWYstm3f1Qgd+aUibSTrXUxwqnpJu5jco5DCiK/1orRaCzXkIKES3tdhM6Jiqs45RoTnmxUJIcrKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959870; c=relaxed/simple;
	bh=I+JJT/HEgzht8NH5PV02zwDfS1nSJ1CV2zFF8/WCNdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBbcf4IWp97A/wQtNKXgew+pmeb+pWQ+7OMjC9oFyKh2jF8238EOHZ2QxzgoKXVCfnZXSaHe3vr+rEFZEzL4qTEbo1v1qskHdp6Z3CVZ1nVEP83gx3XVLu9bdNHZPQ05c1qcGyuFVMpRXImdt6C8Mcw2c4hcODAJv1We0r4gw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEFayJqQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4255b4d8f9so3304166a12.0;
        Mon, 11 Aug 2025 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754959869; x=1755564669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLk7JyZeB5fZff0o7uyhPEE+hzUw7ew/nwGo79HGTQI=;
        b=eEFayJqQEUf9jd7wt8hOFs/23kBqGa410Vh2PMAGsTq+/LWLKHl+7FOb3a40oXaabZ
         E5ZM345EFg5+z13rUVWDV5+qaIytCxWIw1o1glT3WBjJkNBgNG216Cw6+bUk+JshltBq
         juxmWuU819PV6lSF3o4aeZqyMfCEiGxP+ESlcmpgFzkVXkToyp0aSu0VNtrpTH6ss1L7
         XNFsGMQmDV0xWHSLP3wDj6pjYMTd/ULNkVpBtQBmQU/7QtzEauvYYW0HLBnxEO2pOgIj
         90782jS9rnVOymULKM2dlmzW4xYeVpzsRsbTHYuPd7eoSf29WAcW9aZz4/3rS9ekEhAm
         HUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754959869; x=1755564669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLk7JyZeB5fZff0o7uyhPEE+hzUw7ew/nwGo79HGTQI=;
        b=DgT3+8vj+Ivka8ONgXB0IO5x9grAqO9leAvdhyOmUy8Gfi04Kp5V6Q/DvvvOL/4BG3
         /qT7oHP7uv8r931ur5Z5ubK5OXs2ZQbeQFTPNA73WCV7GLX6qxlFH3UjEWP6O6yHmIn8
         NfagxfhaltDMOifWEZesA0GrtvRcECRvH+tMQgWTBN0LstomoomshhSE+Yt8YaFKZZUr
         Gjyum5/QjB/uo3y2hsqeLLoYIAlXK+Lg4+jcBhq+FfkoxCz2bOqB1wFNMbt3SxC2KuXE
         btrkmLySoAMc4w0G5Y92wGuuH0qWny5D45ek/4c5mQy/6FADtDrHs8DKBTA4W8D+vqDy
         iEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeBidaMtjyhIjKVsiMUWc68ANuBhmg99Y8qAXPvhevbRqCkst8+XGTyeC6vePBGRudbGlBXnm1i8i/y8KBKa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeaTcPtTUxASlCQAZJp3qNUOk6UJxjbxX6LM7V/df9Z+Qq4wP
	J4xfgy+w48Am6j8t4oAb9wEkb4FxjIfpiMHnxIYU/tYxAU7e0y2MrxYW
X-Gm-Gg: ASbGncuUQX0KcTtLiMMYOrXQO5+O+pBZMJgpB/Y6u/exOrl1mSY8ex0fJFzsLuMO+lG
	2R3xMZSdqh3vcMZwltYIf/19tfmBelmROGgF3Lstsg6IC7Tk86YClwfMtWuaL+PVkglgGLQkmDp
	p6nomuh9Exnjf5kdFwKDjCtpCUj2BASGf0TTQrMpvSTZsyfxOrDwx8CBB2sMFTcDcb3IaWhi4B1
	EqyJWu5dVCbnXvT1VV+y7l1FDKUvQjrOzOFG/0vEmr5KEcEiMYTrIfVSLGyzm5Y+YDNWtOBGBuZ
	DNVG8uj4NhgSu8Y+fgdNjiSAHloTrVIEDe5ZYIytbl4pdesMnzPgBFF5vDlW2U9k76GZ3ev5fQl
	FmRr8IKq2vRvCvSmv6PkXFcuiu3X8rWc=
X-Google-Smtp-Source: AGHT+IFeQ4dRsxAoCsTYUm6+5cX6P5ashl71urTJ+obxYkrmQdDrTJ4Ig2f2oLTBbk3S9YSOm6D0xA==
X-Received: by 2002:a17:902:ce88:b0:240:4d19:8797 with SMTP id d9443c01a7336-242fc23f4e4mr24656975ad.22.1754959868729;
        Mon, 11 Aug 2025 17:51:08 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1f0e945sm283785035ad.56.2025.08.11.17.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 17:51:08 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Nai-Chen Cheng <bleach1827@gmail.com>
Subject: [PATCH v2] selftests/futex: fix format-security warnings in futex_priv_hash
Date: Tue, 12 Aug 2025 08:50:48 +0800
Message-ID: <20250812005048.59892-1-bleach1827@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix format-security warnings by using proper format strings when
passing message variables to ksft_exit_fail_msg(),
ksft_test_result_pass(), and ksft_test_result_skip() function.

This prevents potential security issues and eliminates compiler warnings
when building with -Wformat-security.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---

Changes in v2:
- Fix typo in subject: "selftest" -> "selftests"
- Retested compilation and functionality
- Link to v1: https://lore.kernel.org/all/20250717120606.45115-1-bleach1827@gmail.com/

---
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc94eb8..19651087c4de 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -184,10 +184,10 @@ int main(int argc, char *argv[])
 	futex_slots1 = futex_hash_slots_get();
 	if (futex_slots1 <= 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
-		ksft_exit_fail_msg(test_msg_auto_create);
+		ksft_exit_fail_msg("%s", test_msg_auto_create);
 	}
 
-	ksft_test_result_pass(test_msg_auto_create);
+	ksft_test_result_pass("%s", test_msg_auto_create);
 
 	online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
@@ -212,11 +212,11 @@ int main(int argc, char *argv[])
 		if (futex_slotsn < 0 || futex_slots1 == futex_slotsn) {
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
-			ksft_exit_fail_msg(test_msg_auto_inc);
+			ksft_exit_fail_msg("%s", test_msg_auto_inc);
 		}
-		ksft_test_result_pass(test_msg_auto_inc);
+		ksft_test_result_pass("%s", test_msg_auto_inc);
 	} else {
-		ksft_test_result_skip(test_msg_auto_inc);
+		ksft_test_result_skip("%s", test_msg_auto_inc);
 	}
 	ret = pthread_mutex_unlock(&global_lock);
 
-- 
2.43.0


