Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF6113E09
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfLEJfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 04:35:16 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18371 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575538516; x=1607074516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9ZbP6djXj6aBTAcsUIDjFweVfXJf8GOq+UwZ+M2/ok0=;
  b=omFIz3tmw6ZhTpk87XsKOAsDaWX9ZGcSH+cEsKH9mVlnPDI00pUTgtJ7
   ChyMG/X6X6+AqvAV+8v5nTF1O/DSLWww5xVdAM1ibr4O9k3ujd/+560IU
   V083g2hQwYEf72ZcsIkyc2z+rVzNEDnxHmDwCz2vZcVKpzgvcVJLuDumS
   U=;
IronPort-SDR: SUWJGRidlohcfSvWgzjX7YQkahommtqbg1ZrTHWFhc8y+AaYOo4ub/CbTECP+p1aH/9cZqgmek
 8NYx2NAaT9Jg==
X-IronPort-AV: E=Sophos;i="5.69,280,1571702400"; 
   d="scan'208";a="11769853"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Dec 2019 09:35:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 941D51A1F0C;
        Thu,  5 Dec 2019 09:35:03 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:35:02 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 09:34:58 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <sj38.park@gmail.com>, <corbet@lwn.net>,
        <kunit-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <sjpark@amazon.de>
Subject: [PATCH v5 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Thu, 5 Dec 2019 10:34:35 +0100
Message-ID: <20191205093440.21824-2-sjpark@amazon.com>
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

The kunit doc suggests users to get the default `kunitconfig` from an
external git tree.  However, the file is already located under the
`arch/um/configs/` of the kernel tree.  Because the local file is easier
to access and maintain, this commit updates the doc to use it.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index aeeddfafeea2..78a0aed4931d 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -29,9 +29,8 @@ regular Kernel config, with the specific test targets as well.
 
 .. code-block:: bash
 
-	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
 	cd $PATH_TO_LINUX_REPO
-	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+	cp arch/um/configs/kunit_defconfig kunitconfig
 
 You may want to add kunitconfig to your local gitignore.
 
-- 
2.17.1

