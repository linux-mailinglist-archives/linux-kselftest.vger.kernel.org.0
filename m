Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7A74B66B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGGSjS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGGSjR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:39:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4832684;
        Fri,  7 Jul 2023 11:39:14 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688755145t75gkm14
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:39:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: KvvwR/hcPA3zMYK1CcceBKsYTp/4/3pjRiGuKwCnZov/MPcdg6J8HujwWwHn5
        /8+dmG2yvIOgNqB0jCgFmPi5Ha91Smk+4wKn891hXp8XbdYOjS79GGq20AcOIqAKxPAl8/0
        4Cz0RXglli0Mvtl8Yq9J6jkbxTgmjSd16/syAnHj5NP8vI2kdNHnj4e5lM/CiJjdEv/GHL+
        97VoOznzLptB5D3ml4BUFJHo4EbLyPAS4mFOXcyXji3b9CNlU5SCnSwGILew7dI1cBLOl8y
        HhUDN+VuesWus3Y8xdcf3anZt6OUgJrj69kSKyIhv8LnqVl7ZK36w1QsGhaH42/m1v3jAcz
        gnjSZjbRmd4zusUN7+Bcc0TlLy63T2l89IpnXOhwe1rNEufsfDLVAoqfiFX6g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13821968345218044229
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 13/18] selftests/nolibc: prepare /tmp for tmpfs or ramfs
Date:   Sat,  8 Jul 2023 02:38:57 +0800
Message-Id: <ef82268ef4a9ae263a17cd1a3533842271c5520c.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

create a /tmp directory and mount tmpfs there, if tmpfs is not
mountable, use ramfs as tmpfs.

tmpfs will be used instead of procfs for some tests.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 5497ee86cf40..6b863f7b677c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1063,6 +1063,10 @@ int prepare(void)
 		}
 	}
 
+	/* try to mount /tmp if not mounted, if not mountable, use ramfs as tmpfs */
+	mkdir("/tmp", 0755);
+	mount("none", "/tmp", "tmpfs", 0, 0);
+
 	return 0;
 }
 
-- 
2.25.1

