Return-Path: <linux-kselftest+bounces-34821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B1AD74C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B23165483
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA8270EBB;
	Thu, 12 Jun 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhQE1OOu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nWQo8k0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757F26529A;
	Thu, 12 Jun 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740054; cv=none; b=Vfdl7nbXEGZQbbaApyHiRxES4UNVeXGBsqv0UBrvfFKLKg+FnPuOyo9xXniIK/WvdEkl2mbC3hYLJ7/8nuGSMuWvP3lFNMtrkJeTq0MnIEDffQMitF1/9HglqFtviBiaXTgEAjWf+0iIkctXUQmmEq19WLug5xOQKzbgawl01Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740054; c=relaxed/simple;
	bh=hqwuCbuPfDirV9ezH9vFM/1xe2bdJIBXTWJNudHdkrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ip/9t5gbQjiVdhD3nR1nemC06pk8IJ/TSN+RxzlZX1zbZc3ZQe1CMkhpPZNSOAJRr0cIqnrPjzvOJcCHiaj5DvdZHpnthwLECDRkRlNs6nPqmOt1PdYJV16fUKnEmGDMhec8kimXf3P4glVauYX5WpEIgESVBAEi6oJsDZ7gQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhQE1OOu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nWQo8k0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749740051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=py6GP2JAARXzekNYXmGRyd+LjknrMRVM5xplKdlwTXg=;
	b=lhQE1OOu7xPdVXqRsztqXAcNOkH6J4VOLtkkQnQnj47HL7ISsRq79C2S2WE6q4bK+gv4i/
	Q81eKVVeRDAXUfnn2w44aV6xFQM0ZJwg6t5pSfxdYxtFCSAeOKWjxt+w0bwLl6fAtpm7Kr
	L6ShzrgRgMaVONc/02H3H3y9WMulqQF2IHGhKs2IoutFXIUFk5N72YVTAfxIpHZbCf0Gw9
	URzINDyryQDN9QdiYwyByjAIA0UOP5T3fEsMJ2AOHU2efekKxVYnETh3tmImmt+gNPq0s1
	mXvRVersMMYifBh57US8UwzqDAM5RBcZ0ArpcDfhdxTyfUnob4JFaNUDnLrZEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749740051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=py6GP2JAARXzekNYXmGRyd+LjknrMRVM5xplKdlwTXg=;
	b=7nWQo8k0YEHZYPe9LDnktyWFcPpoUzxim+t5fDu49q+jH8AeNxOGhgh5cBQQEzFT85KEkL
	fzVJvmZkK9cHmMAw==
Date: Thu, 12 Jun 2025 16:53:54 +0200
Subject: [PATCH 1/3] module: move 'struct module_use' to internal.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740050; l=1859;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hqwuCbuPfDirV9ezH9vFM/1xe2bdJIBXTWJNudHdkrI=;
 b=vq6kGYwsNovqkaoVCfb6ybXwuUWWL9HOQUelrJQyfLZKvryFiI/VXgmJbeDgCGi5R/PEOoxqv
 Z0iM1Fv37PmAw8JiAUves8du/RkgyNmT/HEvBa1kfBs8wannUWGqnzv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The struct was moved to the public header file in
commit c8e21ced08b3 ("module: fix kdb's illicit use of struct module_use.").
Back then the structure was used outside of the module core.
Nowadays this is not true anymore, so the structure can be made internal.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.49.0


