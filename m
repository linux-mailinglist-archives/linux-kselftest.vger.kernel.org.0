Return-Path: <linux-kselftest+bounces-41961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E37B8A530
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A51C82BAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23731690F;
	Fri, 19 Sep 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n4xvTQm/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F862F83BA;
	Fri, 19 Sep 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296166; cv=none; b=e25cU4x7e3JWQdcgtu8uRP8qk4FEoCMUaKoDo1D4uCEB3I4Qw49NJHlNvEeJsnxjMhqRRkdb7GlJBnYfG0nDMOQU818sXrfMhygR31cT9cst70dyS4BByOnPe8r+CT4sWYVBVj09JB1WMRCDvnRes7Zju+HRNh6ug4E4M1RRluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296166; c=relaxed/simple;
	bh=OnThKVkAxTbvu2cs4FLMAMZ+dEhCwYFgliP6EBhRpLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFSrfEbCdzSySQGFqF/5b/SVrMVH+TokG8uzbXplb4HpompuysSnYKs8hEWVIrpSteuNMXYw4OEUCc+1qwFu68/Ic5K3SbZG8YyGfnNhMI6M2guvCHOEGkdu9rYnK+8uYMmticG36LzmVMOIqnAcUbkgPVzMOMtP6JwAqnVzsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n4xvTQm/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=;
	t=1758296164; x=1759505764; b=n4xvTQm/qmzoOF+LkA+Oqzqi9cLqBe/n/LzwIseLCoUMqqB
	QBeedQR6gd0IiYAl8aWXwuOz2zQXz43AvC6Cq6mTnjWCsn77CNcQeyVbdoErgfabwAC8e6nKOgPPw
	zh4eCTWXlMSi2W+T40+D79oYRl3N27urzdZucv3gY0sbZ98202bKMxeF0LLUcagXKcPW32iYW27ut
	lwsb+RhDZgQS5Rw8GBgLGr3cbt5CIU1r4QwBcpuxcole96fzuh+8rnlhrq0oX1IQxtrQwdorf9s2x
	wOHgCYTrPUEAI8STLqLGc+d9eGT7p4uS2IvvLp1cHhfPYFh48QQoWsmrBl3UwLbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9T-0000000G6O6-2i20;
	Fri, 19 Sep 2025 17:35:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 01/11] tools compiler.h: fix __used definition
Date: Fri, 19 Sep 2025 17:34:10 +0200
Message-ID: <20250919153420.727385-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

The define mapped to __attribute__((__unused__)) instead of using
__used__. Having the wrong definition here may result in the linker
incorrectly removing the symbol. Also, this now matches the definition
in include/linux/compiler_attributes.h.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


