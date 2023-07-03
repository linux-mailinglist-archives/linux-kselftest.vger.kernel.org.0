Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636B7458BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGCJs3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjGCJs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 05:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC594BE
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688377662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HjDG9EDRPV/EgTnmORU7tSN/WwduSfYwcySr89RNbmQ=;
        b=Y58+mLfEcS4X9pQZjl084aVhkwgxCRjDvl75N9WabXqGkxWKEw3c+0yXqbS3oPRHX3+xlP
        9AIX3Ds+yNcRj08V8g2Nw+NMlO6xqFJoOhQURkyk5xivypjnr91ttm3ZWM9jIcNP4vq01V
        V5JhuniIe/TKSHLONj0wyhab6WSGV6M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-kq4h6AAJN9msU9tvLKa8Vw-1; Mon, 03 Jul 2023 05:47:41 -0400
X-MC-Unique: kq4h6AAJN9msU9tvLKa8Vw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765a44ce88aso247632885a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jul 2023 02:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377660; x=1690969660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjDG9EDRPV/EgTnmORU7tSN/WwduSfYwcySr89RNbmQ=;
        b=E1ntp8DauccY7xvpFGe7nh+ldfz0gHqvz0wbGKEX13dX1IHLaf/TVntPpiGA7usQpm
         cgpG7djUQMVlq6vxjXre3JK9Bp9c5ATEQJg41qsHziZpkq6hIyh1gmwxnpUwLDlliGyg
         YUKQhtROfer8VtrJzgtipDjk1m3GtVU/rf7t/wBQHRGeihglT8KZW7K5de7W8/pLtZks
         esddmt0A+3I+0vA4SLNp/Do4pbTfTQ9r3nAHQ72FmqQjEl7TQhBaqC3Sxisr8C6rqzfT
         lq6LgDscPt+KPAenx077Ibv8OCOifCR2uSBRqx4xhnOH40MurrkhcqDoQHI4pzViB9OO
         yFDQ==
X-Gm-Message-State: AC+VfDzV2xQikKescl9sDat2xJ+Ut2J1JWNOdKQLB682S3Uutbbq25md
        kJHClTFvZqjDtFIsWkbp7lrqBEH1BU0D3Ax9dPtZA/47fXCV8B+5IC6G/0kFnHqa6n6sbCMRrzH
        HYvw7u0shvTgJQhlAX+mLErRHeKO9Bow3GBcu
X-Received: by 2002:a05:620a:4512:b0:760:6fcb:77db with SMTP id t18-20020a05620a451200b007606fcb77dbmr12149705qkp.36.1688377660643;
        Mon, 03 Jul 2023 02:47:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oc0M0BEGnNlJlDoPddT1lpfCp+vKZ5LRV7f3/EvDr6CxKSrEtsmk9NDvnPCRDOAI1JRyhyw==
X-Received: by 2002:a05:620a:4512:b0:760:6fcb:77db with SMTP id t18-20020a05620a451200b007606fcb77dbmr12149691qkp.36.1688377660331;
        Mon, 03 Jul 2023 02:47:40 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:4b84:700:e5a3:9a79:b307:264a])
        by smtp.gmail.com with ESMTPSA id da34-20020a05620a362200b0075b2af4a076sm405815qkb.16.2023.07.03.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:47:39 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCHv2] selftests/input: add tests for the EVIOCSCLOCKID ioctl
Date:   Mon,  3 Jul 2023 12:47:22 +0300
Message-ID: <20230703094722.909348-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
coverage of the different clkids

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
Changes in v2:
- Replaced clkids numerical values with their equivalent definition

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..83ce1a3c9b84 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <unistd.h>
+#include <linux/time.h>
 
 #include "../kselftest_harness.h"
 
@@ -234,4 +235,33 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsclockid_set_clockid)
+{
+	struct selftest_uinput *uidev;
+	int clkid = CLOCK_REALTIME;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_MONOTONIC;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_BOOTTIME;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case default
+	clkid = -1;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(-1, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

