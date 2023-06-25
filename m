Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F273D0EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 14:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFYMb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFYMb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 08:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE7E7
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Jun 2023 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687696268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Jw7D3cDIPezb5KyTrtfg6zC3lbK4rtQzoMzmA2DE1o=;
        b=J0gDVYndlXJMUr0WVmaY8t/wbKPda/xEuqLS0+6M1NEdKe9HifaOhla8SHcHb8iejrAHMe
        ZaGBol7deAk3EUB2gwYrOPvlpSWucXD5mCflAg1F/7kcSdcAApTKhjXv5aN1tSllDkLZXe
        oY0eTpf30l1sMu2hdI5zmQ46jIeGzVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Ess2Z6lXPzuUN57kr82e_Q-1; Sun, 25 Jun 2023 08:31:03 -0400
X-MC-Unique: Ess2Z6lXPzuUN57kr82e_Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31275e9fbdaso899242f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Jun 2023 05:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687696262; x=1690288262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jw7D3cDIPezb5KyTrtfg6zC3lbK4rtQzoMzmA2DE1o=;
        b=dxAMflb3L/XXUwnJV5cdb2PVC4GRvAZG56UX7diU0SorDLa0EF0t2OBIf3U3dBwTEQ
         zgsr3SjaJKVBMBF8lQVKytevSAgjUEpkXT+lY96yogjrm8KkJHtnLChCarDtHFhkiTrQ
         +xSkNSGMYeJ78j505dvNnTTgZuMDgo8BkqMpQsLJBK9KuLw64ZKv5+nnWGsATk0FUkMZ
         Vcv9co/Dbu1Ir7pFyiNGkYQqbTRCPxgiieZiRxJ670sSBl7J+pIhx+begBb6eX+tHWdb
         Eird+oS3ZCEDgHh842nDfQyyx4DtBDm9J6HC023SW8WvfMeWq1pi8RUoDqzjqMQq27Xt
         HtTg==
X-Gm-Message-State: AC+VfDzhRQv+yZR7CdphGoaZw8XbIe3dl575r7KnXm4002WM4DdsgfYs
        foemHD+E/0m8r+N1BvUJIZHDOUuW26hy3Qoc9ZBcKb56rluVvhg712S4iwU8yl6OYJ79dDu9BhM
        woNAJDYXvj3+vlpG8sHkdwK++fwyHp1448+Io
X-Received: by 2002:a5d:4bc1:0:b0:30a:ae5b:9e93 with SMTP id l1-20020a5d4bc1000000b0030aae5b9e93mr16944156wrt.11.1687696262144;
        Sun, 25 Jun 2023 05:31:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42ubQM2wG9PKLJJNI76/IVi6hdgCnTu3rml1+kpgQQUDv1VSsAbmGkoJBZxLVQZKeLxlUjvA==
X-Received: by 2002:a5d:4bc1:0:b0:30a:ae5b:9e93 with SMTP id l1-20020a5d4bc1000000b0030aae5b9e93mr16944147wrt.11.1687696261794;
        Sun, 25 Jun 2023 05:31:01 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id hn31-20020a05600ca39f00b003fa745f3264sm4614881wmb.43.2023.06.25.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 05:31:01 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v2] selftests/input: add tests for the EVIOCSABS ioctl
Date:   Sun, 25 Jun 2023 15:30:37 +0300
Message-ID: <20230625123037.8384-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces two tests for the EVIOCSABS ioctl. The first one
checks that the ioctl fails when the EV_ABS bit was not set, and the
second one just checks that the normal workflow for this ioctl
succeeds.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index 4c0c8ebed378..7afd537f0b24 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -279,4 +279,27 @@ TEST(eviocgrep_get_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsabs_set_abs_value_limits)
+{
+	struct selftest_uinput *uidev;
+	struct input_absinfo absinfo;
+	int rc;
+
+	// fail test on dev->absinfo
+	rc = selftest_uinput_create_device(&uidev), -1;
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+	rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
+	ASSERT_EQ(-1, rc);
+	selftest_uinput_destroy(uidev);
+
+	// ioctl normal flow
+	rc = selftest_uinput_create_device(&uidev, EV_ABS, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+	rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
+	ASSERT_EQ(0, rc);
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

