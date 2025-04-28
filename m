Return-Path: <linux-kselftest+bounces-31752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BACA9E853
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5312C3BC06D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF81D5170;
	Mon, 28 Apr 2025 06:33:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA201C84D6;
	Mon, 28 Apr 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821996; cv=none; b=Vp8TzW/iRjz+pPOaDzaxMVNZ4xnkHzdli+xYALxg02Rbe5OUm776TeH6qXaH5Mk/VoU7PmOFt9RLSWIneXEvc3dAXVQyhj7EIRxu3TiOHftGegym3Fl5vletS0/d5Zeoeu1Y38bvaRE3zZAHLthMrwWLaf+KRpInvCckPzBa/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821996; c=relaxed/simple;
	bh=aRlm9nDiOJ2NxGR6jbwLEXuWeOOW0exqJwSqMq8FUIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbNeQtKd2YAThd4ryhroA/OIWKpQLT7GjozqB2DiwkT9fULHAzLwm9q675aCokUA2Slb2tRzGQP5Jx/rMjZ1IsBfmkLQWFU1zXv8PLzF0vmZpDhpk16icN1QEmqedL6I7MC9F/iA7TRIRoyJzs+I85xW+MG1PNfkS4wRFexFJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxG6wfIQ9ojyDIAA--.37083S3;
	Mon, 28 Apr 2025 14:33:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxDcUdIQ9oTM6aAA--.59312S3;
	Mon, 28 Apr 2025 14:33:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: pid_namespace: Include sys/mount.h
Date: Mon, 28 Apr 2025 14:32:59 +0800
Message-ID: <20250428063300.7137-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMAxDcUdIQ9oTM6aAA--.59312S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyfGFW7uF4UCw15Wr1Dtwc_yoW8Jw1Dpa
	4kZwnakw4fAF17K3ZxW3sIgryxWr4kGF48tw1rWaykJ34UC3s7Xr4xtF1UJFyfW3yFqr9x
	ZayxGr4rurs8ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

When executing "make -C tools/testing/selftests/pid_namespace", there exist
many errors such as:

  $ make -C tools/testing/selftests/pid_namespace
  ...
  pid_max.c:42:15: error: implicit declaration of function 'mount' [-Wimplicit-function-declaration]
  ...
  pid_max.c:42:36: error: 'MS_PRIVATE' undeclared (first use in this function); did you mean 'MAP_PRIVATE'?
  ...
  pid_max.c:42:49: error: 'MS_REC' undeclared (first use in this function)
  ...

Include sys/mount.h to fix the errors, tested on x86_64 and LoongArch.

Reported-by: Haiyong Sun <sunhaiyong@loongson.cn>
Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..96f274f0582b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/mount.h>
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
-- 
2.42.0


