Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9366D7572AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGRECY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 00:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRECX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 00:02:23 -0400
X-Greylist: delayed 1068 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 21:02:20 PDT
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD518D;
        Mon, 17 Jul 2023 21:02:20 -0700 (PDT)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
        by Atcsqr.andestech.com with ESMTP id 36I3iV83007226;
        Tue, 18 Jul 2023 11:44:31 +0800 (+08)
        (envelope-from minachou@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 36I3i5uO007200;
        Tue, 18 Jul 2023 11:44:05 +0800 (+08)
        (envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 18 Jul 2023
 11:44:01 +0800
From:   Hui Min Mina Chou <minachou@andestech.com>
To:     <hirofumi@mail.parknet.co.jp>, <shuah@kernel.org>,
        <javierm@redhat.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <dylan@andestech.com>, <az70021@gmail.com>,
        <minachou@andestech.com>
Subject: [PATCH] selftests/filesystems: Add six consecutive 'x' characters to mktemp
Date:   Tue, 18 Jul 2023 11:43:51 +0800
Message-ID: <20230718034351.1373857-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 36I3iV83007226
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In busybox, the mktemp requires that the generated filename be
suffixed with at least six consecutive 'X' characters. Otherwise,
it will return an "Invalid argument" error.

Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 tools/testing/selftests/filesystems/fat/run_fat_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
index 7f35dc3d15df..d61264d4795d 100755
--- a/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
+++ b/tools/testing/selftests/filesystems/fat/run_fat_tests.sh
@@ -12,7 +12,7 @@ set -u
 set -o pipefail
 
 BASE_DIR="$(dirname $0)"
-TMP_DIR="$(mktemp -d /tmp/fat_tests_tmp.XXXX)"
+TMP_DIR="$(mktemp -d /tmp/fat_tests_tmp.XXXXXX)"
 IMG_PATH="${TMP_DIR}/fat.img"
 MNT_PATH="${TMP_DIR}/mnt"
 
-- 
2.34.1

