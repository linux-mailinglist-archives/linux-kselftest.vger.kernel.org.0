Return-Path: <linux-kselftest+bounces-41818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7582B83EEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8705E620467
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6762DA76F;
	Thu, 18 Sep 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+p/vkH+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZxPIDp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8628F1;
	Thu, 18 Sep 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189427; cv=none; b=Oqoz0reJUJ0sl/rG9muuqI0wKs4SHXcpSvXajCBXcMDPKTyPh5JPgu/zZw3gZE9JsR7KtKHF9Y/lQtvMdPxttg6C51p96ZDr2uQ6bUI7vWXQaAREtxX1MrIndXlR0hFXJlpfRtkemWqHGn9gmVC756k1e4Z38h3ocm2q+awTDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189427; c=relaxed/simple;
	bh=jK7EvwxigtoJEFKIhDuhDv3qFvNtLHjdtdaIK8mzC3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BjDh/eHspJmCbE3REfFwN66sCbkqX94fQ/8BAFPYYYXtd9s6iGhxmhtvxkFjna+wBx0XOkkzdl1MgEJ0iI5sQyCPmE2nid8TpEj6cw1SiJfgq+QRkprdakTlsp5o44JXLCfpbrg/RErjHJCYTZgJ5XOa7HuABk8sswk/gh2qclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+p/vkH+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZxPIDp8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758189423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5VbA+um2A2j6OFBZRmVPvhlrOodmplDW/1hXbUCAAZc=;
	b=l+p/vkH+yTsb+/l5dMzTZIFmQuwe4pw8Ju2iidJURNBXkibQEjmuX7gRgonXJNvpt2Bcdw
	oAFHRiL0kCraaE8Vjh2jLaBij9C4Oenp5VMC0EsGvzKoHAlxQqHETXr8dSIBTjeJTmDoBx
	zLKKPMVrH5ghZaJ5WPGQUegE1eQaHRs72uD7r52jRrt5/P+62ceWRbZsrBHfSonhLmksDZ
	kZYhjwUE1GwbL237BuMf23cp2kNgWMAKz0weCnaV2UpbvOnjNXfAdOywZFtxxJIqrpARP6
	vXopnazIvTeA2G9gHbIctTqcDXBzIYEjYGODVfTWr2wbKhYYYH9RDnh4AlE2rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758189423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5VbA+um2A2j6OFBZRmVPvhlrOodmplDW/1hXbUCAAZc=;
	b=2ZxPIDp8ZaRAI3lqfYen8RUqlbQx9sAqb51acEdpaB/7qmLq3/19qLVb3hXSM2g5liQ9we
	1xX5dSQ3yxlR7jDg==
Date: Thu, 18 Sep 2025 11:56:36 +0200
Subject: [PATCH] selftests: always install UAPI headers to the correct
 directory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-kselftest-uapi-out-of-tree-v1-1-f4434f28adcd@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAFPXy2gC/x3MQQqDMBAF0KvIrDswigHTq5QuRH/aQTGSiSKId
 ze4fJt3kiEpjN7VSQm7msaloH5VNPz75QfWsZgaaZz4uuPJMIcMy7z1q3LcMsfAOQHsu9FJcF5
 aGagEa0LQ48k/3+u6AZVX+uNsAAAA
X-Change-ID: 20250918-kselftest-uapi-out-of-tree-98d50f59040c
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758189423; l=1688;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jK7EvwxigtoJEFKIhDuhDv3qFvNtLHjdtdaIK8mzC3o=;
 b=upanb3vkp6zgRbRMcDJ2oRh6+Vx/Fqriu9XiCv0O3HjAw1otsopd1gRZ6TIlOjU78+qqMgBaD
 mHwCnAUn7uNBfcwb83k76bkTeCosx+QfCmpqCg67eiH2QtyD+RtDIwK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently the UAPI headers are always installed into the source directory.
When building out-of-tree this doesn't work, as the include path will be
wrong and it dirties the source tree, leading to complains by kbuild.

Make sure the 'headers' target installs the UAPI headers in the correctly.

The real target directory can come from multiple places. To handle them all
extract the target directory from KHDR_INCLUDES.

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Closes: https://lore.kernel.org/lkml/20250917153209.GA2023406@nvidia.com/
Fixes: 1a59f5d31569 ("selftests: Add headers target")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/lib.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5303900339292e618dee4fd7ff8a7c2fa3209a68..a448fae57831d86098806adaff53f6f1a747febb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,7 +228,10 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
+# Extract the expected header directory
+khdr_output := $(patsubst %/usr/include,%,$(filter %/usr/include,$(KHDR_INCLUDES)))
+
 headers:
-	$(Q)$(MAKE) -C $(top_srcdir) headers
+	$(Q)$(MAKE) -f $(top_srcdir)/Makefile -C $(khdr_output) headers
 
 .PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250918-kselftest-uapi-out-of-tree-98d50f59040c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


