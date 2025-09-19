Return-Path: <linux-kselftest+bounces-41969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A0B8A55C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8581CC4B88
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BA31D363;
	Fri, 19 Sep 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u3KFDC5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150C31690F;
	Fri, 19 Sep 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296173; cv=none; b=VbU6sptVkaVV8xDyICxvtQ9baVnD4xvn7b5BaSW1oXhKVq3l0L0WiHQw0vaEL3xoXobS8TVLnArpeB/zO3YXbwpWtrF0dv9sv8iLp0kkoGM5LGoRE91TwWVDCTuvTxPDm9el3rU7pok7mF1Ds+0Uxy0ziNI4dwtg0tx5slgh2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296173; c=relaxed/simple;
	bh=+1XbHYWO44eiLyr3lQME0rhVVOh0E9r61o4FckS2Ch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJbWyrsk2QSJKZGXl2U8IXF2iLaV9cYiuTk92ErvJvutqz6m/oStyMnH2uEwFyMnGtHS871FH8BksjvosZZRgsYdsDpLafQk0u/vvlVYk1uuxTjkvwZVnYi78ljDtLXCn6ZJjehmqoW9dJCT8Wf/yBXB11FxYMFjPemoosxwNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u3KFDC5Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=;
	t=1758296172; x=1759505772; b=u3KFDC5Q4r8E6W2iykSXrV7xA/yaVcq5UkX0U15zQaVs8Xn
	Kwkj6C8NTCMX/SVDVYe7sJqKPemH0ab6ktujeozlHW9NIEV18aPSomiDx8sSR/n8MOdcdSdpM+a+z
	+VMrJv9lRLRiFIdV2NmZToTc38njZIzLBXqLQimjrmYf+NhC2Ou9nYP7oD8KOxPVUKFEgEe5A7oP7
	BWA8F4pngd+n9rPUVMGFOIfsa0f65+bafBbuJamHgae1wSukgurBIfru8Ze+8ucGwImzWgkwD856d
	J9sFcj6YdhlrzuFj82ILu/PaOtdY/caiDyqjpUzD94L7vWSbvHBxwalV1dxM2c5g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9c-0000000G6O6-0blB;
	Fri, 19 Sep 2025 17:36:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 08/11] um: use nolibc for the --showconfig implementation
Date: Fri, 19 Sep 2025 17:34:17 +0200
Message-ID: <20250919153420.727385-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This is one of the simplest files and it can be switched over to use
nolibc without any modifications.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..4b206a40b611 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
-USER_OBJS := config.o
+NOLIBC_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 
-- 
2.51.0


