Return-Path: <linux-kselftest+bounces-16792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEDD9661B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8EF1C216D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8B1A7AC0;
	Fri, 30 Aug 2024 12:29:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D481A4B7B;
	Fri, 30 Aug 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020954; cv=none; b=kEl+vTosnCahgRG7Z+xZBe7vsl5RCl4HtmQ3Smxvxkiy8MJprhtZNGRAtgoiDjSOMdW+0J6DsAjyv1UKNBGG+FN81PsGe9zTaRu4CETKaN4jVcWnOig5osYKcbPS3CxKJE8Hr9E0whlOcgVLlr+khluciTqbVFgREy/STVQHMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020954; c=relaxed/simple;
	bh=DCrPSezoxbVIYz0kG+pXVgQVaxus2MZrfI5WodRpYSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRzwf3qFiDUkkholEzOZSyZxEkOMY0gaFr0rGMvA9PFlxZAm5d9e4BpTKl2pHnfdLlevC88TYd7cI+ZYeEuvf2leXv5Zsck0IcVVQFTZDWsPfOTCZVjyOI0h/+i2EuzMesKAwD+F4ODU0k83WouuKLFr937OaHV2E7dkC6HRhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwHWW1TfXz9sS8;
	Fri, 30 Aug 2024 14:28:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ghA23GVqmrt; Fri, 30 Aug 2024 14:28:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwHWT2hGYz9sSH;
	Fri, 30 Aug 2024 14:28:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8118B764;
	Fri, 30 Aug 2024 14:28:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sYTh0SpiC3mf; Fri, 30 Aug 2024 14:28:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C17FE8B794;
	Fri, 30 Aug 2024 14:28:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@mit.edu>,
	"H. Peter Anvin" <hpa@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] selftests: vdso: Use parse_vdso.h in vdso_test_abi
Date: Fri, 30 Aug 2024 14:28:39 +0200
Message-ID: <0d8896fa24167ea85f5b9398b72d2e016af06843.1725020674.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
References: <6c5da802e72befecfa09046c489aa45d934d611f.1725020674.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725020918; l=937; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=DCrPSezoxbVIYz0kG+pXVgQVaxus2MZrfI5WodRpYSE=; b=aIDp1kXqB16bTbdqdx16YUnXPFryN5jjhA+zIAW7cZLM8ouFvh8JTlXR/A8DFqG15GxJb8usU U8M6DQks2feBunzg8dBqJLIFbBkCV1IlqUmzR5Yx0RUxrRLt0wNKxUm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Don't duplicate parse_vdso function prototypes, include
the header instead.

Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 00034208c4c6..a54424e2336f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -21,10 +21,7 @@
 #include "../kselftest.h"
 #include "vdso_config.h"
 #include "vdso_call.h"
-
-extern void *vdso_sym(const char *version, const char *name);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void vdso_init_from_auxv(void *auxv);
+#include "parse_vdso.h"
 
 static const char *version;
 static const char **name;
-- 
2.44.0


