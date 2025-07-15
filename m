Return-Path: <linux-kselftest+bounces-37319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D6B0504B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3F44A3172
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9A25D55D;
	Tue, 15 Jul 2025 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPdEC7Kg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6492C033B;
	Tue, 15 Jul 2025 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554116; cv=none; b=AxwF91L7EK1znDleasGX+TzyXH/qQpDaQtKLXyS7AfeJ7d5Jhjy79fIlP5BJKpwe0CD4b4ikop+8JQjO19YXSF6yYcc7Pi4HYRQmF2fA4zmMAylPYWOAwb1WYWaKH+suYHiTP9PmWBGPcDizY+HQq9fJF5Kf7/u1MzoaEIf4wQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554116; c=relaxed/simple;
	bh=vN0qThUdAZikcy73mvxM60zY0XSmxgQItEa9GX+j+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGNE45L6402s/TtvJJ1qTQDD0Z2Ft5LaW34mUjUFtOz6DlfZforBy4d6smN7Yvuupc3THOrY5AKasfLWBNeALA5oq/md+3LQX6NzrjJ4gH7lFcH8XeAppokk9WmOu4VMAr3Jad58YqLAzNEiV+xTYC2rEogUADh9qNUKkIyJtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPdEC7Kg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6120098b3a.2;
        Mon, 14 Jul 2025 21:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752554114; x=1753158914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5BiwCUH/ppr5v34TPoC0DbtCLN6sN6rZn+QDA4gm0w=;
        b=XPdEC7KgfpC1oJ/7S7cLJGZSKpkXEGgA3bmAeG2wSTpvcgJ093UZY35E7xYHx7J3F8
         bTqrA4qcxKadLYe0aP1UUvx0UX7TOaPbtH/N3D3Let7AsGbrCrE6xtHDfbPmpEcw688n
         kvpof3OvkHQwzH3r8QuTQlJGOKAyXLiRMCLvZFNZ38sa2tPbwd+AYEek6/QEzwwIaj56
         4DnVt951ZBvIAyWwI7fAdhMByoZk70cr7Z4CMoYPRsRMID2ygze3Sm3QVhq6AxwfhBcw
         7/MNawgThy44e3uwZ7Ijp52z9/zSBOdxOa+0OJnqGkGzTGiGkv38p8VK+Vo756/PJ9g8
         hf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752554114; x=1753158914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5BiwCUH/ppr5v34TPoC0DbtCLN6sN6rZn+QDA4gm0w=;
        b=j1RYwCo580+RSD1L6R84uEn4uO8IQdo7/XYl3Xb1Jd1YTYIel42/O06RL6rgBUKHcb
         TYJIccA3YC8tZV2F+Gc0Onh5se8m8Q1WVYF1t2uVxsyIq6meVwTL2FDV2WaZ8d1hag+M
         j0ZNvYOvMUKE/mSsVFi2SnEcTuYpTwOGnm9Pi7Jg5MSGVMjQSx+QE/T4Cq6CbZqKK4RY
         dL6tViBF7FwtXvqYXiL68PPKlsfkg44qn6zGcQNOXQF4YopKFzE4Wj1bqJ8WKKf3fhYs
         A0IlIkCjignTlC7fEqgStzdR7GRD5/i349UsL2tMhmQrrP2s7GzIC5hzvYx5cKYP1D22
         EvDg==
X-Forwarded-Encrypted: i=1; AJvYcCVgm2J2gAhNYZcfSrClMa7K2Fov5waMqcOyTsOF/U2NJFkV0LVwFyyeJ0Z7zxAWzq/5B4zy1JlC0+Jb7JjP7QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqG16l0b6tQZKo/lakM0JHSDkB5ctfiu/skACK4arAccdzr9Oa
	pF0nk4F53/uT6/Uhf3xR8kSLfu/jdYxPd9vh0L07iQ+UMrDkIFNou24ZUe4o6xAS
X-Gm-Gg: ASbGncvUQ/e691k1mUrGAK/J+fIqgKf+n8QcEZAfA2qU/Tv+P+oXoSwwxPr8p++y/We
	ffEqVxXY1/3RPiG5YF1XJIsVNJfdj1rX/BC+P3r3aRhIBxjG7IzCsNtT/opJAEUiO2UCUvk+nn3
	D5FxZStfI3SCyxhsR83FEtNq3OZ6V4saft2c4ZF5a7nXJ7FKlUgc/Z6OVkNWfX2hg+HfUbT8RRx
	MhHYFDbK6s/Nb1JgoLX1BikZx/jKWwuOloPuSGeAkIPU7Gxllh9/R1a9F/r7q9BWb2Q98KEDArY
	x2tnnZXMx87R6Z48Sv287LCSFwfi5H8+vqmonvaHBoT1iZGYWS40ggpmwOiHG3ONWI1tf2CvEsY
	bl9RiJKgP8nPG+4Sanc53Q1DwLlThPZMaBmtVZEYav6eyMfg=
X-Google-Smtp-Source: AGHT+IHlmkw2ejad2PPpluCFyCQ8mYdhnSgXG1JLwXu0mESP9JLqSGPGtQvzsb32etlgLOYWiL+XtA==
X-Received: by 2002:a05:6a00:a1f:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-74ee04a9b48mr20320968b3a.2.1752554113733;
        Mon, 14 Jul 2025 21:35:13 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7341sm11620326b3a.15.2025.07.14.21.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 21:35:13 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: rtnetlink: fix addrlft test flakiness on power-saving systems
Date: Tue, 15 Jul 2025 04:34:59 +0000
Message-ID: <20250715043459.110523-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reported that the rtnetlink test for the preferred lifetime of an
address has become quite flaky. The issue started appearing around the 6.16
merge window in May, and the test fails with:

    FAIL: preferred_lft addresses remaining

The flakiness might be related to power-saving behavior, as address
expiration is handled by a "power-efficient" workqueue.

To address this, use slowwait to check more frequently whether the address
still exists. This reduces the likelihood of the system entering a low-power
state during the test, improving reliability.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..49141254065c 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -291,6 +291,17 @@ kci_test_route_get()
 	end_test "PASS: route get"
 }
 
+check_addr_not_exist()
+{
+	dev=$1
+	addr=$2
+	if ip addr show dev $dev | grep -q $addr; then
+		return 1
+	else
+		return 0
+	fi
+}
+
 kci_test_addrlft()
 {
 	for i in $(seq 10 100) ;do
@@ -298,9 +309,8 @@ kci_test_addrlft()
 		run_cmd ip addr add 10.23.11.$i/32 dev "$devdummy" preferred_lft $lft valid_lft $((lft+1))
 	done
 
-	sleep 5
-	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
-	if [ $? -eq 0 ]; then
+	slowwait 5 check_addr_not_exist "$devdummy" "10.23.11."
+	if [ $? -eq 1 ]; then
 		check_err 1
 		end_test "FAIL: preferred_lft addresses remaining"
 		return
-- 
2.46.0


