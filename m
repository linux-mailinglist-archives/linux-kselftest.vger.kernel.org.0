Return-Path: <linux-kselftest+bounces-37106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A9B01D9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E9A45B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB02E0919;
	Fri, 11 Jul 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tSqaL0dM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqSgArGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6F2D77EB;
	Fri, 11 Jul 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240710; cv=none; b=a2v/OzxqGchVU+GA2QRDj+nPFNsbmzIUmFgtxI3vSCmenKwscvJ18ov2Q78ldJOB71TE0WAe/nBBgkqqY2/m74XIZwGdPrwhvyKMl8RK9UW3TsBC7B2B5bONOaVu6o35XY2mwQw1PdDj+LsZFSkGCEMcREl9fW70bSTYSp7PNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240710; c=relaxed/simple;
	bh=fz+VMXoPvVEeoVYCnv7IaR6grGXXdY88CzWfdfhiMQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oD3rz4k9xhlk4xBMu6eyzeo1d51PYAU/IIGZeQPDvkr/xar0bOlnor7iguuaEIDk/nC944kYN5vv5/lwXqA9LPdrY24M3ST87R5xZyhawDq30TE4Nw5XVC+DW1QAzrNRBdoVIi5DK7ztCwtmJkzPdOXdjyBm+jQikk87ILjiU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tSqaL0dM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zqSgArGD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752240701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY6KbPjcfv5j/RTn7PjCFY4WtA7LMGhcLxijFU6bp3E=;
	b=tSqaL0dMrq6lsoaoqw7SCNIWz+8RBRWbOvFlSwDIWfy6o/Hd7OeFCf1Uaub/s2DZ58b1/P
	m+iQfBzUQlCWO9cJxb9esV+24igIMfYk2SfQgDw8fz+Prx7gZSaNMSVrerRXs4gmnX0DSX
	cIDCQlD4ZGMVFQr/Ndl7O7n5esC57TWUrqn91EiGzYHydzpjqi9QHuRyFGYNM4bYujvfZj
	uA23Hu4ap1dbHZHSAjjvG77rwH9vP8UDxnBtXI8yOUub5KFMe1CEQk9vamS8jDXv1nC/FD
	MMYpeE9R/nDlSafGIHTYRjslTAqi2noqldCymRD8x/dgMab5Y7mSbVMbFQOPKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752240701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY6KbPjcfv5j/RTn7PjCFY4WtA7LMGhcLxijFU6bp3E=;
	b=zqSgArGDOGOzPRciLJBxk2gpdOMv4W5EwBVoSPismB9dMI+kzE9Ay0KQqlI7qolYhhobKf
	PC/EoZpUcWhSqiAg==
Date: Fri, 11 Jul 2025 15:31:36 +0200
Subject: [PATCH v2 1/3] module: move 'struct module_use' to internal.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250711-kunit-ifdef-modules-v2-1-39443decb1f8@linutronix.de>
References: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
In-Reply-To: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752240698; l=1956;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fz+VMXoPvVEeoVYCnv7IaR6grGXXdY88CzWfdfhiMQg=;
 b=bMbDMeiJ6dkqWwg0KsST0PU3jMEIWcHi/FgZwzHLiif6steU0VulCQtf3x1kjF6e35NCadPtK
 668EUZR3sjgBE9CxGC10O1jczK0rV5ffdbJrNHWfjyUZ/WGFyYYKPaz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The struct was moved to the public header file in commit c8e21ced08b3
("module: fix kdb's illicit use of struct module_use.").
Back then the structure was used outside of the module core.
Nowadays this is not true anymore, so the structure can be made internal.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h   | 7 -------
 kernel/module/internal.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 92e1420fccdffc9de9f49da9061546cc1e0c89d1..52f7b0487a2733c56e2531a434887e56e1bf45b2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -313,13 +313,6 @@ void *__symbol_get_gpl(const char *symbol);
 		__used __section(".no_trim_symbol") = __stringify(x); \
 	(typeof(&x))(__symbol_get(__stringify(x))); })
 
-/* modules using other modules: kdb wants to see this. */
-struct module_use {
-	struct list_head source_list;
-	struct list_head target_list;
-	struct module *source, *target;
-};
-
 enum module_state {
 	MODULE_STATE_LIVE,	/* Normal state. */
 	MODULE_STATE_COMING,	/* Full formed, running module_init. */
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8d74b0a21c82b5360977a29736eca78ee6b6be3e..1c2e0b0dc52e72d5ecd2f1b310ce535364b3f33b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -109,6 +109,13 @@ struct find_symbol_arg {
 	enum mod_license license;
 };
 
+/* modules using other modules */
+struct module_use {
+	struct list_head source_list;
+	struct list_head target_list;
+	struct module *source, *target;
+};
+
 int mod_verify_sig(const void *mod, struct load_info *info);
 int try_to_force_load(struct module *mod, const char *reason);
 bool find_symbol(struct find_symbol_arg *fsa);

-- 
2.50.0


