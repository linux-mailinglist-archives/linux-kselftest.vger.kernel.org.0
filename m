Return-Path: <linux-kselftest+bounces-28152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF82A4D459
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA523A8EF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A41F63F0;
	Tue,  4 Mar 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PG03UypC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yelIy5aU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AB1F868F;
	Tue,  4 Mar 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072275; cv=none; b=RH/GJXL0Bhgfq/o3garjjbvJ2K3e529tGJrZd+OCn4hjBHOQYAofvH1Z88iKDWA4cNDE9erUf0yRwo/vVpQ2MzU5Yoq+C/Ln7KN5Zb7RTbic6NKc73XbZNZG4+QsUCtpD+FRGSZHFE8PHqTqTdtyAWuaXWahVKrtwxktn1nX9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072275; c=relaxed/simple;
	bh=IACp9TxeVkwNqbYPVDzgsOU/Szw5RWhqCAzuE/yKFGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9io0+Qz3RJWj/Q7KVYdTT3JZxodIS2o4flAvRLw/oFVBAC0nXLFjg5w8Lp7nycq9KOFeKuG5AoZbsXt2Rxj5EP4UJuphH32IPb5RmU1ogQyscwYJ+295Y6OX99u/DFxQj/3INJiHX9p17aHMloQSCFbe1Co/sJFIg6At51Xad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PG03UypC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yelIy5aU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhA1n9boo1l4ht8vtjGqbzX8VsaxQaGO+nCB1t8DBJE=;
	b=PG03UypCdgNgMOIaO/icx5Ydy7m4nXDAgq4WLd78Fzii9NP3J3oO/3qKYygGCdz3lutAnY
	E8eKODnMXUhEH/8kVcbrixXd3FQwAz+ZuwrjWKtuhdgY0mKkX1zcpUz95Q8MnbqTkYzLHi
	ByfTemms01XzuDiGm3mtFalpv0RBuSCH+Mw/eJUfB/hgYImIQWmsdn1neZMfCs5tVZTwAT
	VV+GT6KA7Jsm7nJjoFuaCTNCS6CrJuPRlu7MoP4HO75EQkd99jGfmiA2DMllRvmJszvuxF
	l7tPvWSdeyveK3TIaVna4fNCY44fHMfeeqN9d3bhURlJM7Ug3VCoougil6weBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhA1n9boo1l4ht8vtjGqbzX8VsaxQaGO+nCB1t8DBJE=;
	b=yelIy5aUjEbrtex6I3V1polmWxU+krBfKWHujUfpiOz3yMWfQ62YVjphjLODCg0tlLIy7V
	0XvUVSlrnQErpKAA==
Date: Tue, 04 Mar 2025 08:10:36 +0100
Subject: [PATCH 06/32] selftests: harness: Guard includes on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-6-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1190;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IACp9TxeVkwNqbYPVDzgsOU/Szw5RWhqCAzuE/yKFGQ=;
 b=nu/DeSbYTqvdwxssPGxt59mfA8eu/cOzgcmAI9WFImF7GWGYi6/N+PAiHagppT/nii5Ok2iVJ
 LGLJnti7EFnB8vKOo7V4hpNSUcrtaU6ympDwU9EB3rGF7uB/rrMllk/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Nolibc doesn't provide all normal header files.

Don't try to include these non-existent header files, as the symbols are
available unconditionally anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 222a4f51a8d704c41597e09a241ad887ef787139..6659c10f4d8fc7c750bc5e8a36ebcbcacda5de60 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -53,19 +53,23 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-#include <asm/types.h>
-#include <ctype.h>
-#include <errno.h>
+
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
+
+#ifndef NOLIBC
+#include <asm/types.h>
+#include <ctype.h>
+#include <errno.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <unistd.h>
 #include <setjmp.h>
+#endif
 
 #include "kselftest.h"
 

-- 
2.48.1


