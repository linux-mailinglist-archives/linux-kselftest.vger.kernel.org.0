Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E382952F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 21:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440032AbgJUTcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 15:32:19 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61413 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411427AbgJUTcT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 15:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603308739; x=1634844739;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xErA7tGVQTTJTfkYqLQRWA6Hey2ktgCsIWr/FG0tGeA=;
  b=CpG3KbI+xkc//2asM8AQRjb6zd8UJTvkOsFNeNyy+EteW4aG0240YIZj
   vd6VED89ESIwwNMNr60LnUSaRyBFJP4YSE8ZbZgkZfNjKUjdbSybsxD0o
   PHPlS8H7DW7UfjPcJLwcl7vD8117pTqcH8lDZweIhgoqnoxm2JYUQ6VEF
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,401,1596499200"; 
   d="scan'208";a="78949982"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Oct 2020 19:25:40 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 5001CA18DB;
        Wed, 21 Oct 2020 19:25:39 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.125) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 21 Oct 2020 19:25:33 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>, <corbet@lwn.net>
CC:     SeongJae Park <sjpark@amazon.de>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Wed, 21 Oct 2020 21:25:18 +0200
Message-ID: <20201021192518.31187-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
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
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v2
(https://lore.kernel.org/linux-kselftest/20201013063743.32179-1-sjpark@amazon.com/)
- Fix a grammar issue (David Gow)
- Add 'Reviewed-by: David Gow <davidgow@google.com>'

Changes from v1
(https://lore.kernel.org/linux-kselftest/20201012105420.5945-1-sjpark@amazon.com/)
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
index 961d3ea3ca19..62142a47488c 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -561,6 +561,11 @@ Once the kernel is built and installed, a simple
 
 ...will run the tests.
 
+.. note::
+   Note that you should make sure your test depends on ``KUNIT=y`` in Kconfig
+   if the test does not support module build.  Otherwise, it will trigger
+   compile errors if ``CONFIG_KUNIT`` is ``m``.
+
 Writing new tests for other architectures
 -----------------------------------------
 
-- 
2.17.1

