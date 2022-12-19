Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575E650792
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 07:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiLSGci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 01:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiLSGch (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 01:32:37 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268B645C;
        Sun, 18 Dec 2022 22:32:36 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Nb8yW0JZSz8R039;
        Mon, 19 Dec 2022 14:32:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 2BJ6WPkC091404;
        Mon, 19 Dec 2022 14:32:25 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 19 Dec 2022 14:32:27 +0800 (CST)
Date:   Mon, 19 Dec 2022 14:32:27 +0800 (CST)
X-Zmail-TransId: 2afa63a0057b1bb119b1
X-Mailer: Zmail v1.0
Message-ID: <202212191432274558936@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <pbonzini@redhat.com>
Cc:     <shuah@kernel.org>, <dwmw@amazon.co.uk>, <seanjc@google.com>,
        <paul@xen.org>, <like.xu.linux@gmail.com>,
        <coltonlewis@google.com>, <mhal@rbox.co>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEtWTTogeDg2L3hlbjogUmVtb3ZlIHVubmVlZGVkIHNlbWljb2xvbg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BJ6WPkC091404
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63A00583.000 by FangMail milter!
X-FangMail-Envelope: 1671431555/4Nb8yW0JZSz8R039/63A00583.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A00583.000/4Nb8yW0JZSz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

The semicolon after the "}" is unneeded.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 721f6a693799..3e6ac82eba15 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -426,7 +426,7 @@ static void *juggle_shinfo_state(void *arg)
 		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_init);
 		__vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &cache_destroy);
 		pthread_testcancel();
-	};
+	}

 	return NULL;
 }
-- 
2.15.2
