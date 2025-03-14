Return-Path: <linux-kselftest+bounces-28998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C39A609F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02A41889E55
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8D1D5159;
	Fri, 14 Mar 2025 07:15:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 260EB193073;
	Fri, 14 Mar 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936515; cv=none; b=oeUjOhyAn5rSAxUjNVzrglbz8WMN5B3U4m9Z3WfFgDwOQC3nTRXd94XQ49UbvYCx1GAg1uTjrL1xoz+Vqrv245UOUy6fM9xN3xrSSXNKYzZVsbAD3dbdtp0dYc3LDY3psKcP9Ao3IxaYWb3Dp3zIw4Ob99XcEkamTsvjorOY/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936515; c=relaxed/simple;
	bh=901H3qnhq05EWF+lSoGZ+w8eo28I5pFtX3w8xPFOlkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=dtTeMxCyQvAWDqrW5wP4aXCCHKdmKQjdhpx2gRF/Hlt6K8qqKCUrPtfcY31r5yofR/f8vV2O672M0aG03lyiouJRuXeBU8hSLoDuubFl5KflWTJw01ECO35gTO7rEx/uyBXYpXMRZeI2gd1VVOhtTWSI+DTnVoLIx6KJiLlc5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id BB23F6068097E;
	Fri, 14 Mar 2025 15:15:09 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: zfigura@codeweavers.com,
	shuah@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 3/4] selftests: ntsync: update config
Date: Fri, 14 Mar 2025 15:14:53 +0800
Message-Id: <20250314071454.201697-4-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314071454.201697-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntsync should be tested when CONFIG_NTSYNC is setting rather than
CONFIG_WINESYNC, correct this.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 tools/testing/selftests/drivers/ntsync/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/ntsync/config b/tools/testing/selftests/drivers/ntsync/config
index 60539c826d06..0aa68de147af 100644
--- a/tools/testing/selftests/drivers/ntsync/config
+++ b/tools/testing/selftests/drivers/ntsync/config
@@ -1 +1 @@
-CONFIG_WINESYNC=y
+CONFIG_NTSYNC=y
-- 
2.30.2


