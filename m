Return-Path: <linux-kselftest+bounces-29850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EAA728C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 03:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37936188C91F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112947E105;
	Thu, 27 Mar 2025 02:21:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF2664C6;
	Thu, 27 Mar 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743042079; cv=none; b=dQTSZOeINuv9bjT9Gp5myd1Ob75Ow7F0aVzt2b0FiolCs9s5WYOsp/eunopJjr8SRS17XYR6GEbRwqCsYCO6EY6AzcXgv63uuM9eLv5/p5AMYJWn8ROCS+h/IBoMl6dBhpU3+zTNFtu4uXqpbKOiY3BpG/M5pVGFJvVjiWWp2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743042079; c=relaxed/simple;
	bh=t3d4FIUWGHItNNs3ti+ImF4oUMn5pF1neCbLNlVx5GY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAnHHA1v2XweGO1tcH672LE1ubd6QRpMPwHkehSiCyI4uqi7CGCaIq0rZwPbaTV4OZ6sgBmtJWhkH6yrTMeGUCR1h/soBCr56M85EFAxrv9i8V7I9IxKra/sx9wjRQwID8uuedxo/nDlFpFMMFISLRFQdcV1j9/6v3hxNioA7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3rgYStuRnOCYaAg--.28374S2;
	Thu, 27 Mar 2025 10:21:06 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: shuah@kernel.org,
	brauner@kernel.org,
	amir73il@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] selftests/filesystems: remove duplicate sys/types.h header
Date: Thu, 27 Mar 2025 10:13:01 +0800
Message-Id: <20250327021301.1596533-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3rgYStuRnOCYaAg--.28374S2
X-Coremail-Antispam: 1UD129KBjvdXoWrGrWDtF18uF15ur4DXF13Arb_yoWxXwb_A3
	y7Arn7ZrWDAFyqy3WfX3Z09F1kCw43Wr4rXF45uF13tF1UJFWDWFs8Wr1qv3WYg398Kry3
	Za1kWrW3Wr15GjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kK
	e7AKxVWUAVWUtwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUqfO7UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate header which is included twice.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/testing/selftests/filesystems/utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index e553c89c5b19..06419bf4ba19 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #endif
 #include <fcntl.h>
-#include <sys/types.h>
 #include <dirent.h>
 #include <grp.h>
 #include <linux/limits.h>
-- 
2.25.1


