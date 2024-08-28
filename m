Return-Path: <linux-kselftest+bounces-16482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94236961D1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F3D2849E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 03:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D973C488;
	Wed, 28 Aug 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aSgt+W1t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EDDDC1;
	Wed, 28 Aug 2024 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816977; cv=none; b=OVDxujCn3Q1J5JmRSDUrHJvWU2TDbohZRLwMXcbwayNOTJs/dhln7+TUPsGQxvlnTC1ao2R8a5CDMaCEqitcUIZCB8mdROM5ZNf7ytQdTlRWmpuJOdnattvseXrwNvRnABcly7BG7MPUMRaW2KJeDchlnKORs7GquBZJ+zzuCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816977; c=relaxed/simple;
	bh=DbDHI3A8IPTu9KWOfutpOC8CnWM3ZPqn6IDcJLs9r2A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=M5N725BSv5nPru3bVkiOC6HwsxlPoq7/AEJuHTH5QK5+W4Y688y/k65JX1KQGCpOfZadQtu1zYg/kSUKNyTyNG5B8+QLscRZglbEyYLIwdHrlTFLrrV42RHiGWa3/TgSz4zgtEUDt6+H2wel+ClZNZpSB4zVGssc4DgWaY2tYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aSgt+W1t; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724816968;
	bh=YD+ZzXtdt2h7jTR2X0Sl300G3sHVGgebRrSJ43NeX4o=;
	h=From:To:Cc:Subject:Date;
	b=aSgt+W1tINPO1oIgrtHfNTTKWsJgfdQGJSIBlkpkObabFBZ8oBJEMjWQlByM9W4co
	 IyyRWGfwiOW/GRK57OkDPF5UMkj5dztuRlx/tZZdftML8/pUSa/UORjOhZbohZw36Q
	 FSF4QYjraqYY8vIvFHhyw9kPUGYpmE3fG3Q0OtDQ=
Received: from RT-NUC.. ([39.156.73.10])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id A1EB52B3; Wed, 28 Aug 2024 11:40:30 +0800
X-QQ-mid: xmsmtpt1724816430ts77j56v7
Message-ID: <tencent_3E0DB88452B3022E6754AC5F8546B310BD09@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeKiR/YrXN/3LKoqk8bh1B8AKcksyKuHFDLFwNPsxpax5IGbhO3z
	 81DO065DKH2eGHdujLYLN/3qj4/NnntA1C2maOP4ENdZ83LSFRHzkb2/eJ0m2nAjEKdUeNmWEI9O
	 YlPcYiqAmyzORHmVluh8EC5youn2qldoIFtgnNA1Gbee9eTndGywiQFb5uhnaCr/QLYFtyIMj2/r
	 MrcpAHGSA2e0KnuMl3wNalunrN8BEn03Jhp48Uk/xI8v8QxLPpwu3eSK3KLVAF/iTC2BV1vFdZNH
	 mOg8ueNdaneXnwkWj2vTQYyFCu3DwaKbAd7VWL3nQQWAierH95vsLCcHSj3SQcQLIRfQuQqIWI8y
	 XjOfTgYViOY3fg1pQqsxJeKlvCY+Th25odGzWBxgDrROlmO0bZDH7oYP4imHK2ios0B+apencWWm
	 iYeZeHf8PnrtMqaS1yvrCSJUNZ+KR4c3Ju/+c0LPAOYt/5C+qSuJ2yMsJRoVVMgh7xEnftj3H7GC
	 lM+cNYFjjAOi5LL8GLjSAtjaslNwoP3QXVEX7Tl53To55pTyf0cYCXQo+ouDoxW7ZzRnPBnJpiO6
	 w6yObENfaWgnmO5LZ+GyqML4CSm+fqOd9KNg5IVqz2/LLBF8A4sRgCvAKRjX8+tcMzQr45TTs2AV
	 fQKPuo5FlpTAiMjAytQQ52LIkJkoNAhIwX1UNIuHMo9b2GCqondAEpPTyFuPwOzOvocPbDMHw2CP
	 SC8YfIO1rZ7HbkO/cEveZFhUkXtBTBgaBQ1P6wWHY29RUB4c6mZbYmi1ua3ZOnM9MM1a5n9Yi+Ww
	 QBFvPW8mBhnr7Xui4PjJVoeBfJDqK9dO2tDGPG3zGFNEFJDsDIcduKiktd1gF2BZNzweYjlxHWcn
	 d/6hKEFBuk3tg1JuYzsEFtd4cw1FhNMjs6D0TH/HBb+hFn5iYrhCdMq3SD3VD41ix8UV1utyGsE8
	 yJ+bt5AUV+SZNXZLE3oATfnTuA+4zkxZ5+yUq/BSLa70M9vaOynIy7bZjzotcXiHIjV8K46uRGTP
	 SocK0KdA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Rong Tao <rtoax@foxmail.com>
To: shuah@kernel.org
Cc: rongtao@cestc.cn,
	Rong Tao <rtoax@foxmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH] selftests: splice: Add splice_read.sh and hint
Date: Wed, 28 Aug 2024 11:40:16 +0800
X-OQ-MSGID: <20240828034023.521918-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add test scripts and prompts.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/splice/splice_read.c  | 1 +
 tools/testing/selftests/splice/splice_read.sh | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100755 tools/testing/selftests/splice/splice_read.sh

diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
index 46dae6a25cfb..194b075f6bc0 100644
--- a/tools/testing/selftests/splice/splice_read.c
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -49,6 +49,7 @@ int main(int argc, char *argv[])
 		      size, SPLICE_F_MOVE);
 	if (spliced < 0) {
 		perror("splice");
+		fprintf(stderr, "May try: %s /etc/os-release | cat\n", argv[0]);
 		return EXIT_FAILURE;
 	}
 
diff --git a/tools/testing/selftests/splice/splice_read.sh b/tools/testing/selftests/splice/splice_read.sh
new file mode 100755
index 000000000000..10fd5d738a2d
--- /dev/null
+++ b/tools/testing/selftests/splice/splice_read.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+set -e
+nl=$(./splice_read /etc/os-release | wc -l)
+
+test "$nl" != 0 && exit 0
+
+echo "splice_read broken"
+exit 1
-- 
2.46.0


