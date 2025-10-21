Return-Path: <linux-kselftest+bounces-43642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C038BF473E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 05:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE9418865C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E751DF269;
	Tue, 21 Oct 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YQXYw8x5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815128697;
	Tue, 21 Oct 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015832; cv=none; b=uXabWkHrtl2yXezJ2MI0QcGvlYZSVFVSslaOO24+PaixAF5pzLUabKV7UYMIZx5MRIWVqasW4vRBezktu04q5nodDvjXHy3yXybJjgCz8n+V85AM2AiDncHZQcczfzBMaVSbv1u00D8tQVfg6w088oGWZUO48KMh864InzsDJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015832; c=relaxed/simple;
	bh=32bPCGHvuK5Cq11IPLbjbaw0Rg1TmL8hq3QFI2ZTMKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXr0dtYZB70+m4rEtKKLbD2iFEONu/VqB+dBq3oOiCwJ0ZCYVlTpETHg4O2NzUC9+/X0kXApgVHgQoJujGfXySoMvi3vn5UVN1DqxXUV59/KZuPlWH54b+ov2Z/Qciqex1/VHY1iUJouFCAoTu+ggc15CDIxfMPYFrJFqhkkxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jp.fujitsu.com; spf=pass smtp.mailfrom=jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YQXYw8x5; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1761015831; x=1792551831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32bPCGHvuK5Cq11IPLbjbaw0Rg1TmL8hq3QFI2ZTMKU=;
  b=YQXYw8x54MiLOa4J6TJp4ovyI6wb/lmk46ULfOgLL9rrt3DfTS7Yh8fM
   916UVRWhze4fRAXZhaKqnw2vukQWaHRAhet/xTvAP005/mxdKTZON07eS
   ewBWlafQvA2YK9wkm243EtdSeK5de55gfWHN+ClOIoEMjt793lJ3lgtIi
   V8O6Jh0VPc5OSgrnsNImTVuJ2Cy9n+2J7SEOFo69WpYgzhJnqZH2jDPvp
   DkJHN/zX74m+P8E9SiSITJtGWoqKK0qoq3MbVRwqnN+jRoUHMTsxvhavy
   9h6TXhyLa4MOMqcqQQkUhPF3ToeM9Q23zzfCNJIRMbQqO735n8wowAim/
   Q==;
X-CSE-ConnectionGUID: zOaeevgyQHa0e2ndFldnwA==
X-CSE-MsgGUID: UMhD4kq6TS6p5n6+5RB/ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="216525923"
X-IronPort-AV: E=Sophos;i="6.19,243,1754924400"; 
   d="scan'208";a="216525923"
Received: from unknown (HELO az2uksmgr4.o.css.fujitsu.com) ([52.151.125.19])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 12:02:38 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 986D6C02F69;
	Tue, 21 Oct 2025 03:02:37 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (az2nlsmom1.o.css.fujitsu.com [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 56C1014003BC;
	Tue, 21 Oct 2025 03:02:37 +0000 (UTC)
Received: from sm-arm-grace06.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTP id B8576829EE9;
	Tue, 21 Oct 2025 03:02:32 +0000 (UTC)
From: Yuya Ishikawa <ishikawa.yuy-00@jp.fujitsu.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ishikawa.yuy-00@jp.fujitsu.com,
	misono.tomohiro@fujitsu.com
Subject: [PATCH] Documentation: kunit: add description of kunit.enable parameter
Date: Tue, 21 Oct 2025 12:06:00 +0900
Message-ID: <20251021030605.41610-1-ishikawa.yuy-00@jp.fujitsu.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current KUnit documentation does not mention the kunit.enable
kernel parameter, making it unclear how to troubleshoot cases where
KUnit tests do not run as expected.
Add a note explaining kunit.enable parmaeter. Disabling this parameter
prevents all KUnit tests from running even if CONFIG_KUNIT is enabled.

Signed-off-by: Yuya Ishikawa <ishikawa.yuy-00@jp.fujitsu.com>
---
 Documentation/dev-tools/kunit/run_manual.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index 699d92885075..98e8d5b28808 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -35,6 +35,12 @@ or be built into the kernel.
 	a good way of quickly testing everything applicable to the current
 	config.
 
+	KUnit can be enabled or disabled at boot time, and this behavior is
+	controlled by the kunit.enable kernel parameter.
+	By default, kunit.enable is set to 1 because KUNIT_DEFAULT_ENABLED is
+	enabled by default. To ensure that tests are executed as expected,
+	verify that kunit.enable=1 at boot time.
+
 Once we have built our kernel (and/or modules), it is simple to run
 the tests. If the tests are built-in, they will run automatically on the
 kernel boot. The results will be written to the kernel log (``dmesg``)
-- 
2.47.3


