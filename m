Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D728C8B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbgJMGiP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 02:38:15 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23530 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389433AbgJMGiO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602571094; x=1634107094;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=aHrNIi6Spaa8PTVDo9sFuO7JRmGUmYOw/fAbYNNAQdY=;
  b=RQfbt1qjlcVA+yuLRiiMBYMLENj2h/NK+eCtbXquvUBEsly8wpKyod1O
   qh/B6Pao7Y/HP1ToBels6fD5DQFhWi9yahTRVVCL8rcpLAtSqwGnl4nfi
   gJTmOxzxTHSbx1QYIB1KMMUw9gCBBWgq8g2ESer5uiM6O+97bX0XczAUp
   E=;
X-IronPort-AV: E=Sophos;i="5.77,369,1596499200"; 
   d="scan'208";a="83990110"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Oct 2020 06:38:08 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 212CCA1ECF;
        Tue, 13 Oct 2020 06:38:04 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.27) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 13 Oct 2020 06:38:00 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Tue, 13 Oct 2020 08:37:43 +0200
Message-ID: <20201013063743.32179-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D50UWA004.ant.amazon.com (10.43.163.5) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
errors.  This commit updates the document for this.

Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---

Changes from v1
(https://lore.kernel.org/linux-kselftest/20201012105420.5945-1-sjpark@amazon.com/):
- Fix a typo (Marco Elver)

---
 Documentation/dev-tools/kunit/start.rst | 2 +-
 Documentation/dev-tools/kunit/usage.rst | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index d23385e3e159..454f307813ea 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
 
 	config MISC_EXAMPLE_TEST
 		bool "Test for my example"
-		depends on MISC_EXAMPLE && KUNIT
+		depends on MISC_EXAMPLE && KUNIT=y
 
 and the following to ``drivers/misc/Makefile``:
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5fecc..b331f5a5b0b9 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
 
 ...will run the tests.
 
+.. note::
+   Note that you should make your test depends on ``KUNIT=y`` in Kconfig if the
+   test does not support module build.  Otherwise, it will trigger compile
+   errors if ``CONFIG_KUNIT`` is ``m``.
+
 Writing new tests for other architectures
 -----------------------------------------
 
-- 
2.17.1

