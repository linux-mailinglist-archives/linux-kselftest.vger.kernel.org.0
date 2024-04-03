Return-Path: <linux-kselftest+bounces-7036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78E896285
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 04:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335B01F23392
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BD1B969;
	Wed,  3 Apr 2024 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUgulRoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFC1B952;
	Wed,  3 Apr 2024 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111673; cv=none; b=cnejWU8tR2IYqPS36U6qgMgSvkN+omdfPe1wyk1hPB4H5asAmhe3SWd1uFoyMjL8F3gY2IXp03geuD1L39exH5hg8B1Ow0vT0RwJ7qMXq+1cW3SfOrbuQprxqNiCOVp3oAPy7AKXP1/9SmRZBK6pahxRJq4yyBZR0wZLhUGthos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111673; c=relaxed/simple;
	bh=qMDSBPwJr3ShI0X/pT3ZBrb1Z8HIj3lJ315yAx7FL18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T14v7/TRtKPxDBRq1qQZAA+Pikg7Z1fKnp0QJWX6YKfOw+ktuZqLgPgdniIuIMbVDaPp+9gRLW4czMWm0rWmFw7sUlyw9njm7F1fZKcXNR60YRLHewyoJoh+bAkoa7OPy/kPYLIofRX8EAumNd2K08M0DhCR7uofs/TiMBT+xII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUgulRoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46EBC433B2;
	Wed,  3 Apr 2024 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712111673;
	bh=qMDSBPwJr3ShI0X/pT3ZBrb1Z8HIj3lJ315yAx7FL18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUgulRoceQUAsPq/xIRar+o/3tvsTNZiZ+EExEkrvU4vuArXsVqsMqkQY+1ze83kM
	 kDrSXem/EZ0QgjWM9SExuNi35IuCau1G7IPuO4GXlbvNeva8zxVhEBpp4j+MmjIOXJ
	 9Toh41rcIuAiFztm+CP1BX43Sum0KIR5s1iSPhoh8dq/iGABgMqzcmhqRqCnXhBVgs
	 Y4dI1AOPaHysOtgzJSvcH5D4ezvElcKndLLsV4f0BIAbfi0B4S/4DxSKKhswJlHVqP
	 hPWGmXNA5rgMkoF2Og+uyDSVlk7zOnP+PSTBY2vxT7ySBjLQmphnOueiPkV0JBPI3h
	 VZi2Z9FACH65g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	donald.hunter@gmail.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net-next v2 2/7] tools: ynl: copy netlink error to NlError
Date: Tue,  2 Apr 2024 19:34:21 -0700
Message-ID: <20240403023426.1762996-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typing e.nl_msg.error when processing exception is a bit tedious
and counter-intuitive. Set a local .error member to the positive
value of the netlink level error.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 82d3c98067aa..b30210f537f7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -100,9 +100,10 @@ from .nlspec import SpecFamily
 class NlError(Exception):
   def __init__(self, nl_msg):
     self.nl_msg = nl_msg
+    self.error = -nl_msg.error
 
   def __str__(self):
-    return f"Netlink error: {os.strerror(-self.nl_msg.error)}\n{self.nl_msg}"
+    return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
 
 
 class ConfigError(Exception):
-- 
2.44.0


