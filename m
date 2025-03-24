Return-Path: <linux-kselftest+bounces-29644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36799A6DC7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1957A3215
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430025F992;
	Mon, 24 Mar 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01kmrGij";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2ZeCJ0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F425DD0F;
	Mon, 24 Mar 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825008; cv=none; b=u0g7nOwT6GtSwahXfwBFmCECsdyYzb2ozmbDPZQVJIIqGA3qTS28Ql6g85fbk88y0oAGgFNQT88LPoQVb6bPtjCmmiSLS2a5+MSQP3saHSxfEEPtIU4h8ACsFPRDxt8Vo/9FGfW8HvL6qVwANiXT5LDlrUBumiwWaRZ1/bYLxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825008; c=relaxed/simple;
	bh=UKRxzSlR9qZ2gdAbfbAsj0yhw+zUOuNB45hNx8tgRn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxEloFNd95Rr7Hafz3fcGULNY/Yk2wWk/qsWkaSMhiHhijfhRawwMkeu44O+YGhCU4EptP75G5cKk4oMmd4bUNhM03WnJXUCjhuynCX+9/wYCXK58RtSazWbpOIbeswhaPlxtqkk+aue6/LXtocVWuC2ThIc+zIAWn5k37QxtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01kmrGij; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2ZeCJ0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742825005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqmtgxCMSRE9rwr7I/eQlLiLcjGvYFOZTsJXW6vfQDc=;
	b=01kmrGijkS5Si/rY4hCL67sEVnkiPrP3ORqxHd2nHtfud1dPmzhWzk/Q3+MMPSZA5lnDCe
	MpEhsva5HWPr75Tis7nfQEYZLeDvQsFUHgt7wTyqwUli32mHlaXjoOPVGRTMnFGPqcwb1g
	m6z1LeMKep4loYpX9GTuNpg1yRy/AlMy/ftW/TjxDEzRNtZXfRq5U7CShdNPlJ9p3Sw0tG
	aAfEVsIUPZ5U9+CIhUu7WzitWuHNwRLSUYLstbWB4jWQCr3bhvSfY3rM+c1u6eZdXkYL84
	oZiTmf9I7dH57RdOHfgr49amIvlApspaRBNOpysw1gUGaYMJm/Sh7sK3m6Adkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742825005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqmtgxCMSRE9rwr7I/eQlLiLcjGvYFOZTsJXW6vfQDc=;
	b=M2ZeCJ0NFrW4EaLYadVyejro0P9QuAZne/Ros8jk4p3nsZJFPS9Lxc7N9BwyMBuGtvfear
	7Nr2L8FQ5kQyuGDA==
Date: Mon, 24 Mar 2025 15:03:16 +0100
Subject: [PATCH 2/3] selftests: vDSO: chacha: Include asm/hwcap.h for arm64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-s390-vdso-hwcap-v1-2-cb9ad001ceba@linutronix.de>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
In-Reply-To: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742825002; l=987;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UKRxzSlR9qZ2gdAbfbAsj0yhw+zUOuNB45hNx8tgRn4=;
 b=yMsLw736eWvO2GzABKg4jI9NzhALNqSMwQErgNZJgQlw8QHMVC2REnCNv+c8g44h27POO4/wh
 8faZFBMkltiAiEfDgEKxBtCovgyJ+YSlPM+EYlxXliOMxlY2/7JwfCT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The hwcap constants are not available unconditionally.

Include asm/hwcap.h to make them available.

Not all architectures provide this header, so gate the inclusion behind an
architecture-specific ifdef.

Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_chacha.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 0aad682b12c8836efabb49a65a47cf87466891a3..fd5c5108b42f04ec459d39b74f33edc2ceafbba1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -13,6 +13,7 @@
 #include "../kselftest.h"
 
 #if defined(__aarch64__)
+#include <asm/hwcap.h>
 static bool cpu_has_capabilities(void)
 {
 	return getauxval(AT_HWCAP) & HWCAP_ASIMD;

-- 
2.48.1


