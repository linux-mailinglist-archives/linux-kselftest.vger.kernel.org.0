Return-Path: <linux-kselftest+bounces-8632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9037B8AD314
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 19:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C109C1C21667
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381C153BC6;
	Mon, 22 Apr 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MybUg73y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31815380C;
	Mon, 22 Apr 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805713; cv=none; b=n5/kW9sbqj+yPxYkrQjg3QPZ8L2GnybPYAlL2gROaN+faIu80BdfKGhQLghCxQl8hDzZcHDbpLytIqyo8EIw59LzcppwZ3xYl30c3C55YHnw8MBXcIpkFAwGA6yc2fkMJjkW+6b7rzZGXmEPSxy8kIlkRk3VZaIRAYLuWWTZ/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805713; c=relaxed/simple;
	bh=CpRjxn+7n9MiCWeFV86YpJfJEt1nihvk65CDyghsTR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvMo/GxawJ9F4tCCnrxVbmM3N7AgmxouUNPUlYljJHLJkOLT+py5EjhiFQZP4e9p646cP2erL+wP8JUm1OM+LGhjXDzE/bU/lvKer3Nb0zo8azSEOUOQ6y9GQTPBbZgw6HhnN368gCIL51k5K/lAzseUMxIPtfPVkYxH5i9JcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MybUg73y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713805703;
	bh=CpRjxn+7n9MiCWeFV86YpJfJEt1nihvk65CDyghsTR4=;
	h=From:To:Cc:Subject:Date:From;
	b=MybUg73yac1GBnq24R27cKOgM2lqmEswhEQB0t3ihw9uDCCZ2fsW+Vd9FapDb6rG4
	 xsR2mmgLBHnhGVxw40zH4RhVH1VZwxqxVsdFPjgwdJF+9/MdS0xE4FtzQjwGjkW3rM
	 R78FPxaaFidlORkNIBs5w+nIdSZjIovCTbsdCAtTD8ieyoyMWjpDrDAuDM5hsgv89H
	 wJolXV2WvfcmwmXOITekaDbhUVmQMdILVZqNibGEZwxLl8lLp9r8Qsvv/6fMzTnOW8
	 n0XHLePgWVgN1chDKO1dgPAlEk8JvaVCdkULPeL1oqZE8ZoRFO12dsN/joCHCFeDvL
	 d9JEgFgcAOCBg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C6F7037820E2;
	Mon, 22 Apr 2024 17:08:19 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] selftests: kvm: fix undeclared function error
Date: Mon, 22 Apr 2024 22:08:42 +0500
Message-Id: <20240422170842.2073979-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include kvm_test_harness.h first which will include kselftest_harness.h
for _GNU_SOURCE to get defined first before inclusion of stdio.h. It
is required for declaration of asprintf(). It removes the following
build error caught by clang-17:

In file included from x86_64/fix_hypercall_test.c:12:
In file included from include/kvm_test_harness.h:11:
../kselftest_harness.h:1169:2: error: call to undeclared function
'asprintf'; ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
 1169 |         asprintf(&test_name, "%s%s%s.%s", f->name,
      |         ^

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index f3c2239228b10..75306dcfaad6c 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -4,12 +4,12 @@
  *
  * Tests for KVM paravirtual feature disablement
  */
+#include "kvm_test_harness.h"
 #include <asm/kvm_para.h>
 #include <linux/kvm_para.h>
 #include <linux/stringify.h>
 #include <stdint.h>
 
-#include "kvm_test_harness.h"
 #include "apic.h"
 #include "test_util.h"
 #include "kvm_util.h"
-- 
2.39.2


