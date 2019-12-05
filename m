Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC0113E0C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfLEJfV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:35:21 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37911 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfLEJfV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538521; x=1607074521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2/aNhSLU5O/S7NLog7ZszXLsCI7nZNsLq9HwXG0KqJ0=;
  b=e8tPWM6yyluCQqvO108R3SI0skKBUAZs/cPoJSCoLY2Ra4zYdl60vuod
   TehITpStTiKG14XamjuXTRpkN2WKTTsJqLWgydZoOWh15Nt8WvlGrh31O
   G96TbMQkAajSsAy+dYJSVM5m8RH6eI3D4xqNfR7dD1XjUyS32Ja04uTzZ
   8=;
IronPort-SDR: 9hHbSPSv5WqiZUROjP5wnDBfj6jCP3dDx1AdxVgY+8lMmOy+SoMxBtooMh1/Ti8k7zpMkmwyXT
 az45GlSF0iIw==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="3361121"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Dec 2019 09:35:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id 3A24EA1EBC;
        Thu,  5 Dec 2019 09:35:07 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:06 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:02 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 2/6] kunit: Remove duplicated defconfig creation
Date:   Thu, 5 Dec 2019 10:34:36 +0100
Message-ID: <20191205093440.21824-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205093440.21824-1-sjpark@amazon.com>
References: <20191205093440.21824-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d621983..f8f26951cd1b 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -37,9 +37,6 @@ def create_default_kunitconfig():
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
-- 
2.17.1

