Return-Path: <linux-kselftest+bounces-49353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B5D3A6A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1E8D3002BB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370E309F02;
	Mon, 19 Jan 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU9TRkye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867329E0E6
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821697; cv=none; b=C40dANy7+rROb62cqZiZYVgRG6za+tvr1KVFHrdVKgTvHDNeGeGPVeCHjjGI2ZoCjbPk4BjS3FUXPG+FEIZqAqgTv8fR6Z6yE3SA//lUdyKrYRyEkzMuh9w0/CtjWW0ENxTAjuzg93DATJLMJmI2Julr7k/H73SSuRpFx03VfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821697; c=relaxed/simple;
	bh=yPftNe1eBo88wm7ppevp0smvK8fQ6KWwB5Mb54b2xHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p63yiwaOG4L03rAqMcpns6zMWKHQN19+9z5jQUVbtB9l7kiM+4bH0Dz7rnN396WXss0fP2frQ4WvX3q6p9LrYviNDnyGwP1ARGOhUzB5gGfW1zOaVl5hs3WS4/Lf8uvGegSKkzOQ5NjUGKMXu4mN9+pP1h1v6kuVHpjC3XKHxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU9TRkye; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0833b5aeeso43100785ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768821696; x=1769426496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aK9qmJZRVXQxUxjI8B8dlk4Mfacym62A0+MCvDso+8=;
        b=hU9TRkyeub5C1aTBF4k5o8vO4WG9WbbKb/Hbn0S/h+g423MjmrxaQR6HEW0TVWgMP7
         N6Ezt07I5FHXwYAhHGp3+vRT3tdtYToM6oVv4HuAOeqehr2oUfpeOSDGp64+OHSmgE72
         hUq1/+apV06jSKdTMfP9AnX9vYwweDbIk2Ae1ogCYcR4Qrraqt61YEvUWS9Du6g5dB+Y
         t/ngCn95Q7OrnWsGUvJRqY88z2drgtaWGLPFDQ819rQ3e620kQalb/f7iVKf9VHe2WV5
         SkA0krqNsqDFlw47bcel37zAqCnsABWIjRZmio3jj/0WrRGS83fesmJkX7lhLzfOzJ3T
         rngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768821696; x=1769426496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aK9qmJZRVXQxUxjI8B8dlk4Mfacym62A0+MCvDso+8=;
        b=lkflkSR+WepUO0NqitZDK35DfIAYhKcrm1Xoc/LVAwZTuBfYRE3wl2Saqsenv9qJoG
         32rX2eNyS1eY02pAmyvOPXkCY4P3fH8gGJT+Md+Hsa8HzIQvju70JFw1h35pw006BwUG
         0PWCQA5sYYKxBv+t1bmzSdei+nta04PRKQzqQw1dE8BG78E2P2ISYXpJDproceKWp0ns
         B7Bkk5Yu0fZVZ/5xLMAKIFmjNzODpue+Faleo0vWzic+y0JhNhdX37+x4/8WyEXYrPSA
         BXFJ6o3092MZY1dLZeGZWcRZ5zPZj3kC839W3CVq2/oRlGztSRrllFajT4MZjJHVfcv1
         q9BQ==
X-Gm-Message-State: AOJu0YytUhW1CwphJLIBGZUvpgEkL+tXcPb459Xic4cj2fMMW9TMzWEY
	X3de8QWSAJtKld5frz4tSgipiYLC3eUUrFx/EFN+bCrJc0qW13IxLBs1
X-Gm-Gg: AZuq6aIqn6SMX2c8dxayRlnoBRxhykTmXvrRphB1H2WRtX5765Z5TT4MjzV0E9RyDRn
	m3XcLxOHkHSbNRYlba3LXwWaL6Kr51aqYn3peAPQUdr8X6JUSiwdFspfX8nK9FrJF5oZk4LH8dz
	ul0T2MmAtDXyQl2EBjANeXIWgVEV3rz8hDcpnJKL8BfiW4POOC23yrYsOt22DiEZSkaQt8wNn6k
	Qm4+VKGApcUGadlB38m+P64FmVyuM6MUkZK1Sd0BhpiuCq/tQxW2Nf+ohasyqVqBgrD7RXYklDw
	HixGalotdJQpDrdh95fg16wtWn38GehQmQaUB1LiPWjMIhxu3Kbl7EjlOtyD6+Z/hAh48UdwE3H
	4JwNt6N+CIvjfdEEJKxcJaRLVOnd6auZnp5IXRzyl+LWqe9+rTR/FZn9I4RhsnkppOnPXzCC1T5
	f4iECUU1DVywGmi85GGusiBpZ7Ozkl6D0Eo27F4YWC5U6xwsAt3L8JMQvD6A==
X-Received: by 2002:a17:902:e84c:b0:2a1:2ebc:e631 with SMTP id d9443c01a7336-2a7188a18c3mr112173865ad.24.1768821696091;
        Mon, 19 Jan 2026 03:21:36 -0800 (PST)
Received: from neogulmanpassingby-IdeaPad-1-15AMN7.. ([121.148.108.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm92978525ad.58.2026.01.19.03.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:21:35 -0800 (PST)
From: UYeol Jo <jouyeol8739@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richard.weiyang@gmail.com,
	akpm@linux-foundation.org,
	sef1548@gmail.com,
	jouyeol8739@gmail.com
Subject: [PATCH] selftests/ipc: skip msgque test if MSG_COPY is not supported
Date: Mon, 19 Jan 2026 20:21:20 +0900
Message-ID: <20260119112120.83592-1-jouyeol8739@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The msgque test uses the MSG_COPY flag, which depends on
CONFIG_CHECKPOINT_RESTORE. On kernels where this option is disabled,
msgrcv() fails with ENOSYS.

Currently, the test reports this as a failure:

Change it to skip the test instead, as the failure is due to missing
kernel configuration rather than a bug in the IPC subsystem.
 # selftests: ipc: msgque
 # not ok 1 Failed to copy IPC message: Function not implemented (38)
 # not ok 2 Failed to dump queue: -38

After this patch, the test reports a skip instead of failure:
1..0 # SKIP MSG_COPY not supported

Signed-off-by: UYeol Jo <jouyeol8739@gmail.com>
---
 tools/testing/selftests/ipc/msgque.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index e107379d185c..82f73cdae120 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -161,6 +161,9 @@ int dump_queue(struct msgque_data *msgque)
 		ret = msgrcv(msgque->msq_id, &msgque->messages[i].mtype,
 				MAX_MSG_SIZE, i, IPC_NOWAIT | MSG_COPY);
 		if (ret < 0) {
+			if (errno == ENOSYS)
+				ksft_exit_skip("MSG_COPY not supported\n");
+
 			ksft_test_result_fail("Failed to copy IPC message: %m (%d)\n", errno);
 			return -errno;
 		}
-- 
2.43.0


