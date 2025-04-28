Return-Path: <linux-kselftest+bounces-31751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368DA9E851
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E438189CA75
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801971C878E;
	Mon, 28 Apr 2025 06:33:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CC1C84CD;
	Mon, 28 Apr 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821995; cv=none; b=DfwS7BsmxmeJ0Di5pmC1oSqNexWLS5PZ3csKlNUsNumKZzzPymAnRiIUI/u4DR3uZMkZmTDnSmQl0ilAJhHNb0Z5h/ivtnEwxkG/7RckfBePpBkq65ICZtVcOMuG5ygmNpbd4/dRSrB1ROh++X0aUf/pKGXwpgb54zP7wzHOayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821995; c=relaxed/simple;
	bh=QF3nEfdc04fOKU8N14uxLnQDwusiLNZvwRwdlyEsFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWShY8+NLJaOViqwIlxukqLj0DUF8kVV7EEh+h+heoK+r3TFQtF46Dq1/uA3AtUhproo63yIy3RBVkoNqdyQoqVIHEDGKRm0Y9prgeoNx27+MoPQaD9l7FZc7lMksgglRLcT184lJLsTF35EJQextsu/laAgyfH9TgUWS57MmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxjawgIQ9okyDIAA--.36515S3;
	Mon, 28 Apr 2025 14:33:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxDcUdIQ9oTM6aAA--.59312S4;
	Mon, 28 Apr 2025 14:33:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: pid_namespace: Skip tests if not root
Date: Mon, 28 Apr 2025 14:33:00 +0800
Message-ID: <20250428063300.7137-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250428063300.7137-1-yangtiezhu@loongson.cn>
References: <20250428063300.7137-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDcUdIQ9oTM6aAA--.59312S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrW3ZFW3CFyDtr4kWr1DCFX_yoW8Kw4kpa
	4xZ39avF42yF47J3W3Xw4YgFyFg3Z5XF18Ar1ru3yUZ3WUCFZ7Jr43tF1fAFW5ZrZ5XrZx
	ZF9Yka1UZw1UtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUUU

CLONE_NEWPID or CLONE_NEWNS requires CAP_SYS_ADMIN, if the tests are not
running as root, just skip tests rather than fail and also give a warning
to the user.

Before:

  $ make -C tools/testing/selftests/pid_namespace
  $ tools/testing/selftests/pid_namespace/pid_max
  ...
  #  RUN           global.pid_max_simple ...
  # pid_max.c:337:pid_max_simple:Expected pid (-1) > 0 (0)
  ...
  #  RUN           global.pid_max_nested_limit ...
  # pid_max.c:346:pid_max_nested_limit:Expected pid (-1) > 0 (0)
  ...
  #  RUN           global.pid_max_nested ...
  # pid_max.c:355:pid_max_nested:Expected pid (-1) > 0 (0)
  ...
  # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0

After:

  $ make -C tools/testing/selftests/pid_namespace
  $ tools/testing/selftests/pid_namespace/pid_max
  ...
  #  RUN           global.pid_max_simple ...
  #      SKIP      Must be run as root
  ...
  #  RUN           global.pid_max_nested_limit ...
  #      SKIP      Must be run as root
  ...
  #  RUN           global.pid_max_nested ...
  #      SKIP      Must be run as root
  ...
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:3 error:0

While at it, remove the blank line in the TEST(pid_max_simple).

Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 96f274f0582b..30937c5ee12b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -332,8 +332,10 @@ TEST(pid_max_simple)
 {
 	pid_t pid;
 
-
 	pid = do_clone(pid_max_cb, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (errno == EPERM)
+		SKIP(return, "Must be run as root");
+
 	ASSERT_GT(pid, 0);
 	ASSERT_EQ(0, wait_for_pid(pid));
 }
@@ -343,6 +345,9 @@ TEST(pid_max_nested_limit)
 	pid_t pid;
 
 	pid = do_clone(pid_max_nested_limit_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (errno == EPERM)
+		SKIP(return, "Must be run as root");
+
 	ASSERT_GT(pid, 0);
 	ASSERT_EQ(0, wait_for_pid(pid));
 }
@@ -352,6 +357,9 @@ TEST(pid_max_nested)
 	pid_t pid;
 
 	pid = do_clone(pid_max_nested_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (errno == EPERM)
+		SKIP(return, "Must be run as root");
+
 	ASSERT_GT(pid, 0);
 	ASSERT_EQ(0, wait_for_pid(pid));
 }
-- 
2.42.0


