Return-Path: <linux-kselftest+bounces-19425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B1997F86
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38161F25072
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B02B1B86E4;
	Thu, 10 Oct 2024 07:38:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C97433C9;
	Thu, 10 Oct 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545902; cv=none; b=CCCFhUEj4/GjLl0tD6qxY2ITUtEbfQMWgp9r8WNnxgeS1T1obNeYGoN4ha2YcmHCYulBHtafoTc3PJiofyRhYxPPFCupWxSU5LwtPiMckaJrEkwTJcuTNzaxHX8IgX00/DKbZXrjTcns1ptf7Cxjtdi9kDqbxqfZ/MYDwUPQ4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545902; c=relaxed/simple;
	bh=kYJodM2zNUbFdMlqEPb0BcwVu748kYSmP/P3hlGd6Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5EjQ0LdeyU7VHnZs7XcuyKAOUyibgbPXwzEcIxzS/6wJi1s+WcX5tJTMp8Gqwpas3ngaWCnoKAAr0dOFfI3k+ykh36M/MQ+8Pkfoi8/S6ccwplxcLB5UIOtHvDyFXXWcoq8a2CofJbbkHzckttuseEGJ9eYNTTHSbEVW/vhviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACXfn1ahAdn6zm7BQ--.63S2;
	Thu, 10 Oct 2024 15:38:02 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] selftests: timers: Remove unneeded semicolon
Date: Thu, 10 Oct 2024 15:37:07 +0800
Message-Id: <20241010073707.4038081-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXfn1ahAdn6zm7BQ--.63S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXFykGFWUKryDZFb_yoW3WFgEkF
	42gan7WrWkAFy2kr17Ga1rZr1rZa1kWw4jyry2ga13tFWUZF45AF4kAF15uayrW3y0ga47
	ua10krySkr4IgjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUOID7DUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/testing/selftests/timers/set-timer-lat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 5365e9ae61c3..7a1a2382538c 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -79,7 +79,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.25.1


