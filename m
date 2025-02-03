Return-Path: <linux-kselftest+bounces-25604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1628A26607
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 22:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4C3A3578
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DD200121;
	Mon,  3 Feb 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEYCDKLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950378F54;
	Mon,  3 Feb 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619332; cv=none; b=ETL3hOspflzi3hv4uGtDqcVG6Gpb3RoFjWmvKyJnxgNNVpg7KDZgJMe92v3AGEcUMs3cJmoFe+DVWdi71jzasT9iWZ5k1oJ/B3qinWnp0PfOE8bOscP2oLvAbeOcwA+gwHj4unZCJ4ePLwsMRTjknWYYIHKTbNdYnoX+TQztjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619332; c=relaxed/simple;
	bh=AgNip4Ad0+xKhyaCmGtkbrPXcE+2OIzYanrzNlcDRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czsqOrhTDHSKuH3K++8FxG8JC1gP87wALsjsA+3JeOc3Pn0vc5R2THXN79Kthivfg9ko1zxzzdCTRXy/RBIDkpiVtWp65AvhchiyI6/iCbJWR5zLuaWeXli9WUXeIpY2AvD26szZlsoepXysgHlDpEECkI8Ktl4LVHL8WS6zuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEYCDKLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55FFC4CED2;
	Mon,  3 Feb 2025 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738619332;
	bh=AgNip4Ad0+xKhyaCmGtkbrPXcE+2OIzYanrzNlcDRfw=;
	h=From:To:Cc:Subject:Date:From;
	b=BEYCDKLeNx9YAXG/HZU/1SOvy2hDp/Owq9MKgX5svdZoqjls9jI1wHl4mH1jo3hst
	 hcendJUGzmi+CRvUi3xutbE8Y8v2qQtUPe0NVxb9yQBfyy4Lyf6AukEVRddXTqG/FR
	 6hzwSCKiAV8GONVcCiAz//NZfP4jtuq9xGx0d/psW8LKzbUqrCWywvy2shUo1/IsrH
	 CYwAyIE4c9X26u3THacVG9dEBJ3aBtSpaxms71aVyzM8n+F17mfHMrgYslhQGdqR82
	 5zDEyWTGzh7MiWFfWi1OSnpTGYqUZnCf6534kXvoWM98jbHpS/K5zHltmElUkHnrPG
	 GYIDKI6MN2K6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: suppress ReST file generation when building selftests
Date: Mon,  3 Feb 2025 13:48:50 -0800
Message-ID: <20250203214850.1282291-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some selftests need libynl.a. When building it try to skip
generating the ReST documentation, libynl.a does not depend
on them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/ynl.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index 12e7cae251be..e907c2751956 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -27,7 +27,8 @@ YNL_GENS_HASH := $(shell echo $(YNL_GENS) | sha1sum | cut -c1-8)
 
 $(OUTPUT)/libynl.a: $(YNL_SPECS) $(OUTPUT)/.libynl-$(YNL_GENS_HASH).sig
 	$(Q)rm -f $(top_srcdir)/tools/net/ynl/libynl.a
-	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
+	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl \
+		GENS="$(YNL_GENS)" RSTS="" libynl.a
 	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
 
 EXTRA_CLEAN += \
-- 
2.48.1


