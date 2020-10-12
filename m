Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CF28B314
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgJLKyt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 06:54:49 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:18598 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbgJLKyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 06:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602500089; x=1634036089;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=8y87zV5AlbPh5zyL4s+kUQVE8AR1AIkR7l4IYTIADsY=;
  b=s0Z3dVvbSFVNSfYpzG9EHM6kvZHCYHqn06ywgp9Boe48iN11iViuj8Ru
   EYHfnWURfoZ+uBVnCKPkyvaX+Emky4ErT8j8RRJJQBCTAxEjXXNdtTB3b
   A8ZCdjRb1azX/9Er98Iuh5qBn1nxEkp+g/nV0f16Elvqnj1h8FCqkdWVX
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,366,1596499200"; 
   d="scan'208";a="59190454"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Oct 2020 10:54:43 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 4D7ADA1C0B;
        Mon, 12 Oct 2020 10:54:39 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.71) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 12 Oct 2020 10:54:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.de>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Mon, 12 Oct 2020 12:54:20 +0200
Message-ID: <20201012105420.5945-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D17UWC004.ant.amazon.com (10.43.162.195) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
index 3c3fe8b5fecc..410380fc7fb4 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
 
 ...will run the tests.
 
+.. note::
+   Note that you should make your test depends on ``KUNIT=y`` in Kcofig if the
+   test does not support module build.  Otherwise, it will trigger compile
+   errors if ``CONFIG_KUNIT`` is ``m``.
+
 Writing new tests for other architectures
 -----------------------------------------
 
-- 
2.17.1

