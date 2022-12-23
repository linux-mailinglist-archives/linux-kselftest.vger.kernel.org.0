Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE9654B49
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiLWCub (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 21:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWCua (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 21:50:30 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838BBB48F;
        Thu, 22 Dec 2022 18:50:29 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NdWrN1p2Dz8R03d;
        Fri, 23 Dec 2022 10:50:28 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 2BN2oNH9058478;
        Fri, 23 Dec 2022 10:50:23 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 23 Dec 2022 10:50:24 +0800 (CST)
Date:   Fri, 23 Dec 2022 10:50:24 +0800 (CST)
X-Zmail-TransId: 2b0463a51770ffffffffe34a5f15
X-Mailer: Zmail v1.0
Message-ID: <202212231050245952617@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <shuah@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNlbGZ0ZXN0cy92bToga3NtX2Z1bmN0aW9uYWxfdGVzdHM6IGZpeCBhIHR5cG8gaW4gY29tbWVudMKg?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2BN2oNH9058478
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A51774.000 by FangMail milter!
X-FangMail-Envelope: 1671763828/4NdWrN1p2Dz8R03d/63A51774.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A51774.000/4NdWrN1p2Dz8R03d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Fix a typo of "comaring" which should be "comparing".

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 tools/testing/selftests/vm/ksm_functional_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/ksm_functional_tests.c b/tools/testing/selftests/vm/ksm_functional_tests.c
index b11b7e5115dc..d8b5b4930412 100644
--- a/tools/testing/selftests/vm/ksm_functional_tests.c
+++ b/tools/testing/selftests/vm/ksm_functional_tests.c
@@ -37,7 +37,7 @@ static bool range_maps_duplicates(char *addr, unsigned long size)
 	/*
 	 * There is no easy way to check if there are KSM pages mapped into
 	 * this range. We only check that the range does not map the same PFN
-	 * twice by comaring each pair of mapped pages.
+	 * twice by comparing each pair of mapped pages.
 	 */
 	for (offs_a = 0; offs_a < size; offs_a += pagesize) {
 		pfn_a = pagemap_get_pfn(pagemap_fd, addr + offs_a);
-- 
2.15.2
