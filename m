Return-Path: <linux-kselftest+bounces-36834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7FAFEE49
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A162162C00
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6952E9759;
	Wed,  9 Jul 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ai0tzacM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C382E972D
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076688; cv=none; b=X6ZvVbJdW/aRMhfvPwhFZW+8Grsh9zwM3k8iJ7OisQ1UyCWLZg0wUzsG4VpVUTlQspx2devKn5iL63paXbI5Hwy4UOqrYy47v9ey1GNyimtE1cZFsQbxHqR4NxWv2wHb3WGhHYOOVcpsJSepTXh9ERFT2pxhptSZdSZniug1Jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076688; c=relaxed/simple;
	bh=CFd3foraxPeIay+JuAECS6wC9m+8qc5wdbemw3ITxig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3XACeY4yuMdULAvQxi0N+5e2mA6H1fneqU2R4+ifgem1zsJrCrMevKZ0CSHWDDRv/yDRC7D34pp9aM2agxOyhp8hLrx4CsMwqCitXY3df3Hwp/srcdlJk9onEdJfSh4Mi2PSeo3gmPUCVd/2oIkTpCHAofokj0RtaR3DxmIBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ai0tzacM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/jTbtp+wsSFFOp81TRlIe08sg4deuCkA9VEPwTW4aTk=;
	t=1752076686; x=1753286286; b=ai0tzacM4slAoogg8HfNl5VGXskFtm/xX2iRs1jeCWGup3l
	t+K0rvtxnrA5cAXf9HZdCMs3Rb0iEk8hGyQ/TkMjtyUimZ5ySeL3HgNeqp8apIqMH+5lOHUZDZLFS
	tzUzTA7RgMZvMPCopQC7Assd8vg8+rUjbpC3b0G4V1hMjrZvhlc6/KZVMcXlaCRMazfgfISGLWww6
	8/FdmegzgTo5Ni3SneRxM4X+O+4bbkormXrqaulmU9tKfmHczVQ+WeqWnxoef/h5foRihH1MyEGCF
	p6bYc0C0XXEDzEwqa90UNeS5hhJM29mQcaPyh2u6OQWodfJ08FHX05+/XlRnvxMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZXBL-0000000DWBm-3EKd;
	Wed, 09 Jul 2025 17:58:03 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/3] tools/nolibc: show failed run if test process crashes
Date: Wed,  9 Jul 2025 17:55:10 +0200
Message-ID: <20250709155512.971080-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709155512.971080-1-benjamin@sipsolutions.net>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The logic would not catch if the test process crashes and would
incorrectly report a "success" state. Fix this by looking for the final
"Total number of errors:" message and printing "failure" if it was not
seen.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 8cb65392fa10..51ba853dd97e 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -245,8 +245,9 @@ endif
 include $(srctree)/tools/scripts/Makefile.include
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
+		/^Total number of errors:/{done++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
-		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
+		if (f || !p || !done) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("\nSee all results in %s\n", ARGV[1]); }'
 
 help:
-- 
2.50.0


