Return-Path: <linux-kselftest+bounces-48677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F6D0E72E
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 10:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AA7300942D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD122D0C64;
	Sun, 11 Jan 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxtxT8RP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C9212554
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768123354; cv=none; b=OXuhrn4W4nxnAMtfwp/lXilHfN+EQneHmXSIUQxX6WOmKQtvj8Tj+Q7FCbbbI5Zy6Rbc6Q4QIoVKb+sBCFucYMmXYuMWOFvylj5sW49f1wpndNNGBsT7+1WrCk7SBVX2CvNnud2rPwB3RPZ8RLo2+GoDfYFoJIk1/eFv/fTGV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768123354; c=relaxed/simple;
	bh=LKsAGUQMvmL11lmGfMYcWXJRH7UW5iw+CwUGb/wlONY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIhUkIpkEwVNIo6x3T4n3yPP4cc/3PbKkgGc4eMzmUfLMTtkT1+w8pgdgh5bHWShG3CHwpSiOmqWnI07YM3XAAL9AYYYlBSLzJjPMChrgZ7v5Uqli2FxQW0tKQw+G5pyIuMEZx8SSdkLAXlY7UIYT+Ih+MqmbLMnDM3eVGLi+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxtxT8RP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29efd139227so39406045ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768123352; x=1768728152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCm/drnWWfGcY1VClJPtxWKc/C1MtIQpIdK458YIl5Y=;
        b=ZxtxT8RPmdGMVCrTpXI3JUHrIEgTdGrexTu3DmMJT6EZbDu9K3REIKCeESRrCLeBsw
         qKhlwBIdosZenKqZtWWiaNeLjnGHLPYlcEsLuiCdnLxBTCCGS2V2X5dt8qvkaF02/KTz
         D1+SGDvk8DhRun4JC+Q4881ZXhk7gR34OIZqN/PkJYQQ1BwBLQEC4HNqvxb+7t+Q/CrX
         ydikXz5uSZ7Fzmnps9prOdNyu1ZY0exxBzCpjhRgYNJtn8v4z6j9xZpvWWuM1r6xIGug
         xzZKkE+0Pz2/07SbEQF+VlUp5Aarv8j90xT82r3YiScBP+uk4PkX9UFsvEXgKl8NJBHl
         wTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768123352; x=1768728152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCm/drnWWfGcY1VClJPtxWKc/C1MtIQpIdK458YIl5Y=;
        b=M2pbb9XzJFv8i+w3i4RoKRiOpu/iexeAszmOFZqY5HWufaFzAmr+o+vxNmDYuXS8+F
         9km6COaPs+1vS8ZjeRTjl6OodYyDBFILZxH0c/0yHnm6s0bkq+K6Sb2xVM0Ky/9IIaD6
         btW8EMbmx9O1Nt5lUZVD18T4yKac+WqQRQbnmr4YtcuyZfThIRXOn0EOp09V/JsmieUK
         EX1qkGJP+5NeOI3n9e7ZaSbNfGUKYVA8kwuvhS4367pq4vMxlvGInFQj31zfCf7U8Dnh
         BGJ4oLMi2Oy+tTAyv0nlQmuklBeuI2hf3PUyKtf2gmQhutNXJ5PpH608V8gcDGtU1crA
         A9GA==
X-Forwarded-Encrypted: i=1; AJvYcCVMUbX+NJ9KH83JnZ1C9auRph5ORwPwR1Ws0BBxB9ZEkdFz48ITrSeQqbmcm+wikFh+ZE9o64O7IyB/wfajHcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqBpblCrbXFjSogb2yzljZKO5Kbwy2oNsOvK1UPBsgwB9jPxG
	VDRPwvTJFA1qkN8vxBdlFimaox/5TjBq913WsXvyeqqX4no53P/YEZPP
X-Gm-Gg: AY/fxX7VLZLvgXWNPvdiIXNHVsL18bQnJ336ec1XPhEbtbUy4Zvnej/LvSrTK4mQps3
	1FYlcDfEtS9EwDt4ndXHIbCuRCbeAsO5gAuS+9xlGgJB4FC41FIRF557lSOJklq47G2WLsdt+o7
	en8SYQB2sBmo7TPcJ1cTumy2mtpukxiNGPquuRLEZxQhDiXZH9quGIfymeVx2JvI1GX6BTC5fnP
	DWiJp6xYvFfcYtEjoZ1t0oj2h7Shrhvap/zFkLflIBuc3B617TyE5vSL/orRtWfFzxDJ5ds8HpY
	9kONw/YlLpD23OkJmUF9XnqYmCFw/69MQZEyJm44UGF3hsqQCrx2wujGB0zI9W8a7Qsh/NMqLYm
	vWoIla+u6m8u2V7XDi4CwWOOMweAFFeJ0C50QoCrN7y82CFtd/sy5bzyWhnkoryDhpFu6B/bCUm
	sOiMshGeIcdHUK30A7Z8fJube4Hz+o9BmhWXv+png0qRaHsiRfkcc=
X-Google-Smtp-Source: AGHT+IEXRPsU8756Xoluv1FrSAdfgALB7igo232JghFF19myMgALVM9PemrDvYZb7zfCsYcJiv1tdw==
X-Received: by 2002:a17:903:354b:b0:29f:b3e5:5186 with SMTP id d9443c01a7336-2a3ee4e7aabmr143195675ad.56.1768123352201;
        Sun, 11 Jan 2026 01:22:32 -0800 (PST)
Received: from tauron.. ([155.230.91.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81efe4a95c7sm4464537b3a.37.2026.01.11.01.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 01:22:31 -0800 (PST)
From: Jiwoo Ahn <ikwydls1314@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Jiwoo Ahn <ikwydls1314@gmail.com>
Subject: [PATCH] selftests/seccomp: Add test for SECCOMP_RET_LOG semantics
Date: Sun, 11 Jan 2026 18:21:17 +0900
Message-ID: <20260111092117.99696-1-ikwydls1314@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify that SECCOMP_RET_LOG actually emits a kernel
log entry when a system call is triggered under a seccomp filter.

The test installs a minimal seccomp BPF program returning
SECCOMP_RET_LOG and checks that a corresponding seccomp message
including the process PID appears in /dev/kmsg. If /dev/kmsg is
inaccessible or logging is disabled, the test is skipped.

Signed-off-by: Jiwoo Ahn <ikwydls1314@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..fde01647668c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -622,6 +622,64 @@ TEST(log_all)
 	EXPECT_EQ(parent, syscall(__NR_getppid));
 }
 
+static bool kmsg_has_seccomp_log(int fd, pid_t pid)
+{
+	char buf[4096];
+	char pid_pat[32];
+	ssize_t ret;
+	int retries = 10;
+
+	snprintf(pid_pat, sizeof(pid_pat), "pid=%d", pid);
+
+	while (retries--) {
+		while ((ret = read(fd, buf, sizeof(buf) - 1)) > 0) {
+			buf[ret] = '\0';
+			if (strstr(buf, "seccomp") && strstr(buf, pid_pat))
+				return true;
+		}
+		usleep(10000); /* 10ms */
+	}
+	return false;
+}
+
+TEST(ret_log_semantics)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_LOG),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+	pid_t self;
+	int kmsg_fd;
+
+	/* move the file pointer to the end */
+	kmsg_fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
+	if (kmsg_fd >= 0)
+		lseek(kmsg_fd, 0, SEEK_END);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
+	ASSERT_EQ(0, ret);
+
+	self = getpid();
+	EXPECT_EQ(self, syscall(__NR_getpid));
+
+	/*
+	 * - only if /dev/kmsg was accessible
+	 * - skip silently otherwise
+	 */
+	if (kmsg_fd >= 0) {
+		if (!kmsg_has_seccomp_log(kmsg_fd, self))
+			SKIP(return, "seccomp log not observed (logging disabled or restricted)");
+		close(kmsg_fd);
+	}
+}
+
 TEST_SIGNAL(unknown_ret_is_kill_inside, SIGSYS)
 {
 	struct sock_filter filter[] = {
@@ -5294,7 +5352,6 @@ TEST_F(UPROBE, uprobe_default_block_with_syscall)
  * - 64-bit arg prodding
  * - arch value testing (x86 modes especially)
  * - verify that FILTER_FLAG_LOG filters generate log messages
- * - verify that RET_LOG generates log messages
  */
 
 TEST_HARNESS_MAIN
-- 
2.43.0


