Return-Path: <linux-kselftest+bounces-38473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85AB1D94A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DDD18886EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3F257427;
	Thu,  7 Aug 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RggYHZXb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18E2566E2
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574319; cv=none; b=ibUM+4RXyq+V4Io51zFvSlEz28KSknF1JOgfB110wgMcCPaBwLt9LlJ1OvYMQH+7wz4d9CLmgzybjNLb1B+y66IDhe1pqC/8k2GsP6xhhtVEOuY+TQFrItaES2zHCmhiFH0zSIDVazR7a9bOk1ajUJSHE8RqpHS5eog0J1d3PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574319; c=relaxed/simple;
	bh=pB9dB+tUtO/4LYlYlR6kWHmGOMUtI8ZY776ITXEStvc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h0W+puwjkOMZm8TxW2g4zaaG4sr3BHu5J0njtN7jgW7mtvaQtIGCv0TUAgCge2kpQ+TmZvP5OWVKLxRUO7OrBLR2Wty7OKWZIkh1X/PyiwPEoXzyfJ1iiLwrjXANBw4Xp4dwfgjlPK2Tsc0nXK5kX/XLDgIIDKEtzx7cscrjCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RggYHZXb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-240908dd108so8506685ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754574317; x=1755179117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fewSyHZGpfiPfOd9d5r47/z03h852fAT/gw0xzwxW0=;
        b=RggYHZXbIk0badsQFvCGntyzR495XOVhOoByxSjYZ86HSSlklv9IMAnqoSk2yOhnN2
         SvvtCUAk4BNROmSAzS7izaMZg5tUKYYhmX2EZOism18tI7dlTkT6QArFAUcd+37crYwF
         iX2JmtjQ+BAb/zW5jipxr0WAcPAz06LsRa2vudlEBfvp/wBb6aRCiNZGCTvBlbKxG7Az
         8UOy1zcl6ElrxTy4Z2EGB6YT3eZ0V6ISIU5IjpWb6rpBvx0FU4TQA6UD4P8kJEugB8or
         FipwW306FkiIuHnuyD8cAmRfj4J1Iy+Qa9/MFbXILXhXYvSDAP78ka5K0FeOzVoNzuAq
         uDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574317; x=1755179117;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fewSyHZGpfiPfOd9d5r47/z03h852fAT/gw0xzwxW0=;
        b=az9VQkgU/VwmSNMUeiV6IBwFAwYsoW8CDZc1jeMtpTJSZNuBkomwGKMzFq9Nf/ez3T
         lgo/lT8RTWQYqVy1ZcwYMf4QYj+CQpRSdi0i0Mnu2/jF3nW2+kTPlr7oDN8oEFs4ZXkJ
         F4zlag0r4+eTpTbSaKuSPev0CwgNSJFqNjgybkiUMQusKRNvAfJkzgpaoVlxueSorIrL
         rKboG92EfAxtu0zwB7wxxBIAq7emNswE2sQVr1qyx5BB0zrRv3u65mYUm8G57xxAjR2G
         hNY3tPeH0wwSyp6v7tkIagoY/N/tEdDRw1TP4Fb9EtZvD/lhBD4OUcXh441Z41NfXfl6
         S5/A==
X-Gm-Message-State: AOJu0YwPOAMPi+ODYBA46/zuj+K21Ee1Ewsl6bNK0CtvXcfHyQ1Y6D32
	p2VtomcShMRCUdlonu+4K4R1n/bsSZcQbqL3btwfc/Bixc3EuoA2skQAv4PEQrTbzNco/8Kfd+x
	9HA==
X-Google-Smtp-Source: AGHT+IHTmZcifcgPYdTxiupks6e8yvb7k4L+nmzndnoTF3f/siVLFdHMTbDEyMEpwibyJ6wRz4yr6M62cQ==
X-Received: from pjbsk13.prod.google.com ([2002:a17:90b:2dcd:b0:321:78e7:57fb])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b2b:b0:237:f757:9ad8
 with SMTP id d9443c01a7336-242b05cbd49mr56472785ad.1.1754574316574; Thu, 07
 Aug 2025 06:45:16 -0700 (PDT)
Date: Thu,  7 Aug 2025 21:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807134510.1818025-1-wakel@google.com>
Subject: [PATCH] selftests/filesystems/binderfs: Skip tests if user namespaces
 are unavailable
From: Wake Liu <wakel@google.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wakel@google.com
Content-Type: text/plain; charset="UTF-8"

The binderfs selftests, specifically `binderfs_stress` and
`binderfs_test_unprivileged`, depend on user namespaces to run.

On kernels built without user namespace support (CONFIG_USER_NS=n),
these tests will fail.

To prevent these failures, add a check for the availability of user
namespaces by testing for the existence of "/proc/self/ns/user". If
the check fails, skip the tests and print an informative message.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../selftests/filesystems/binderfs/binderfs_test.c     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..e77ed34ebd06 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -291,6 +291,11 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
 	return 0;
 }
 
+static bool has_userns(void)
+{
+	return (access("/proc/self/ns/user", F_OK) == 0);
+}
+
 static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
 {
 	int ret;
@@ -378,6 +383,9 @@ static void *binder_version_thread(void *data)
  */
 TEST(binderfs_stress)
 {
+	if (!has_userns())
+		SKIP(return, "%s: user namespace not supported\n", __func__);
+
 	int fds[1000];
 	int syncfds[2];
 	pid_t pid;
@@ -502,6 +510,8 @@ TEST(binderfs_test_privileged)
 
 TEST(binderfs_test_unprivileged)
 {
+	if (!has_userns())
+		SKIP(return, "%s: user namespace not supported\n", __func__);
 	int ret;
 	int syncfds[2];
 	pid_t pid;
-- 
2.50.1.703.g449372360f-goog


