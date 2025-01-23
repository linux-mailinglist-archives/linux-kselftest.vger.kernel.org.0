Return-Path: <linux-kselftest+bounces-25038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8E2A1AAF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B017A4709
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931381C5D66;
	Thu, 23 Jan 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nZf77Vtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820281ADC73;
	Thu, 23 Jan 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663093; cv=none; b=J+IYKV6gFwwITtgU68TK9M/r7nsRjV8ft4tT7+THr4CT6hs+G+fZuIywGC0rdGWJs0QAu1uahSsfLepCcCVEF+eKyvebU3wgbFDmhPPjvSNWhgpz2bOawrNffuebT8XKmI78Suuc7Lg8Bupf6WvnjbiudjPqFe55UE/Ly/u9P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663093; c=relaxed/simple;
	bh=6HSeKK6lLRgo8rYYH3goFTU1KE0Elskz+p5O1c5WWTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQhvpwlrq2ltyj0/NwPabcBl7DBtxjoWOOh7rebaAPD1XQZT/yDuf3xyyXdalnSEYA002mPShRoHVMXNX8TwvtdzV1nvrFSP3Cgn0yIhNJNdJvdSRDJUBcqPkURKDVNviDUAGWm1qF7+cMT49HMM2lSI3v70Z7H+fHvtjsT2BUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nZf77Vtg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737663088;
	bh=6HSeKK6lLRgo8rYYH3goFTU1KE0Elskz+p5O1c5WWTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZf77Vtg94yN7woPJEDxqiNQi4dSBPDfeCmNskJrd5xoy1bUg74ytEOxWHABEoAr0
	 bjtDWCcuAG86dL2OuqDdfUrhA5cbjRjmaE6ECH5hYicK75pUNGteg8iRBQcF51/YL6
	 p3pu1MkNYzQ1zrz8ezzRbZ7MSpinYiQxKd0Bz3HY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 21:10:44 +0100
Subject: [PATCH 3/3] selftests/nolibc: enable -Wmissing-prototypes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-prototype-v1-3-e1afc5c1999a@weissschuh.net>
References: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
In-Reply-To: <20250123-nolibc-prototype-v1-0-e1afc5c1999a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737663088; l=1054;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6HSeKK6lLRgo8rYYH3goFTU1KE0Elskz+p5O1c5WWTI=;
 b=q8ThX0bGeKbhAaPOmGjOOaJ2vhPC4jEhWlUbF+kxDCrVM8ekvccjFWRHoB3DQVKtGJEyL16Wy
 wbH8FKltF84ApQzjKeDowpleG7kftcl0nHaW/hsWrrIfm4lNdJyM5r3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

User code may want to use this compiler flag.
Make sure it is supported by nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 7d14a7c0cb62608f328b251495264517d333db2e..f867ebe3474e0e9bfbe4a586bfe9832f51796673 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -164,7 +164,7 @@ CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
-		$(call cc-option,-fno-stack-protector) \
+		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
 		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 

-- 
2.48.1


