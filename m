Return-Path: <linux-kselftest+bounces-41568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2B7B58E4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29452525895
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5612DF712;
	Tue, 16 Sep 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gri64SC9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+EbPLBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2BE2DF3F9;
	Tue, 16 Sep 2025 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003364; cv=none; b=OwVaeQ5QPYEf+J1L41S20S2gWpQMYwgMJzkQ0RPu12UivC8+/oSJlnuRf1Yv1jeDm1/y4ij+KNReqg16lrwaCuAdCKBCfpbHvUdyeZgR6Ad/Ev6yn7MZva85XI1KddZP4q8GhdSeU5Ar4N2HAgRl9nonVN7uF0PUE0xMlyKr9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003364; c=relaxed/simple;
	bh=3ZTBXQYIh1KylVz8qq5z88NYEalsc9rPcJ9GI9PBEhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dCtiNXdcd4bVYjdCza7T3Fnk+tfetF17IA5jQm6C7vnHSiX1VeavcezpKiNPm0TEBS8apJNMRVm/Y7uqPLRy73StEkgh4HSsiLcreFlATXRsn6GSw5XJcUqcJvG3Wfnqnl9nkJUz7a+M5DGoQXu5WlvdhBGxU20uVa3zihicbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gri64SC9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+EbPLBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758003359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GivhC8RZbTGVwI9Uiq7S9gZTcPa3vHaIHg4NSnQfTFU=;
	b=gri64SC9BF5focC/t6YTC0PyvhpPbxEP2IbfWT9FJL4kprHpWauWVzqJ8NIuSyUoHWq4LM
	SB/tP3bVWY0RqyH/+yvd2VYe9M7mGEMH4DoUgXbsZ9pZ6znIkkk9PVKuR2pfZ8Z3rzsA01
	z65oaSPpnQ9iX2t9Mf+hlqfo0XYf/kqjwb/9lcGHgkMCPQbZKqbxT+hiy4anxdRZLNDWZx
	34iVHZtjJudMj3kAFi2CyZ1wuzaNWE/sVni8Bg/pTYK2a36/BJvZ5iIqvOCjqgJxRCEt+e
	DuwpTpmNkkN7v5nLWUlsuwc3p92X/laxR0Mh63KRbVyyATHL/9Ot053Sb7zT6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758003359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GivhC8RZbTGVwI9Uiq7S9gZTcPa3vHaIHg4NSnQfTFU=;
	b=g+EbPLBfz5H96EtvsxLhM/VCD+8+HPQogpVdG1AeIo5ZaYAH+JNN4rVtzEWyxdtYcyYDeZ
	DTFruZDc8RHUBpCw==
Date: Tue, 16 Sep 2025 08:15:46 +0200
Subject: [PATCH] kunit: Extend kconfig help text for KUNIT_UML_PCI
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-kunit-pci-kconfig-v1-1-6d1369f06f2a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJEAyWgC/x3MQQqAIBBA0avErBsw06KuEi3KRhsCC60IpLsnL
 d/i/wSRAlOEvkgQ6ObIu8+oygLMOnlHyEs2SCG16KoGt8vziYdh3MzuLTusdSsbNc9KWwW5OwJ
 Zfv7nML7vBwCdcZNjAAAA
X-Change-ID: 20250916-kunit-pci-kconfig-357264bb45f4
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758003353; l=1177;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3ZTBXQYIh1KylVz8qq5z88NYEalsc9rPcJ9GI9PBEhY=;
 b=xeqz1Ab257owlfkt12/0UbICWtnoDtZieVZDFHm3CWPDsePDNXDgZZHtyT/o83LfJqzHaMz9g
 OO3NCNKlfLbBexm6q0lqjZGh38XN2McKeXok/xfyqI/ESLu/kiqbtPX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Checkpatch.pl expects at least 4 lines of help text.

Extend the help text to make checkpatch.pl happy.

Fixes: 031cdd3bc3f3 ("kunit: Enable PCI on UML without triggering WARN()")
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/3dc95227-2be9-48a0-bdea-3f283d9b2a38@linuxfoundation.org/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Feel free to fold this into the original commit.
---
 lib/kunit/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 1823539e96da30e165fa8d395ccbd3f6754c836e..7a6af361d2fc6276b9667be8c694b0c80e33c1e8 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -112,5 +112,9 @@ config KUNIT_UML_PCI
 	select UML_PCI
 	help
 	  Enables the PCI subsystem on UML for use by KUnit tests.
+	  Some KUnit tests require the PCI core which is not enabled by
+	  default on UML.
+
+	  If unsure, say N.
 
 endif # KUNIT

---
base-commit: f20e264262f1e6a6e5302249e37da355d844b52b
change-id: 20250916-kunit-pci-kconfig-357264bb45f4

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


