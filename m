Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D1736586
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 09:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjFTH7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFTH6l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 03:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEAF19A
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687247825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Snds2MMFULbsGTHGwj66Dlo7izMts2DqALhHBNLw5/I=;
        b=O814/bxlR9gS+w8PLHDTiUOL03f8CVOw3W2+CKvecsqToaa3MmOwsps5Qca+y+2x18sgZq
        pj+iJwn+xbfQW+5h7uvQYJYH9jo7VPvyI/nTGN7pxfU3s+N6dP58X41/NEjt1lzgr+SW9o
        Oa/Zf3h8NH7YX0asXb3686jBu7fjq48=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-a_Y2d1AJOmm673fphtq0qQ-1; Tue, 20 Jun 2023 03:57:04 -0400
X-MC-Unique: a_Y2d1AJOmm673fphtq0qQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-763a3046722so188022485a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247823; x=1689839823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snds2MMFULbsGTHGwj66Dlo7izMts2DqALhHBNLw5/I=;
        b=M9Wmq8waLg2bmDZR55396/6k246ftFv/Krv6RRXMn1MAOEwuDkwqHKzIV5wNFu4its
         sk8DhIad65CSwSv1xqz6i3F7qgw5nTORQlBqsgt39V7Uuvl8vUNCi7P0Ny27n26Jddu3
         DEesq7IkcPSRS0wdfLldhk+SyWU5BvT69zQOvbglwCoK2VHZyHV2bXgMut0KwKHJ5hBY
         Pv24q19wDR/NJ4YqndTvBooYxWP9CGKnzdFX6FNs+jXkF5rOR1x79z+1HBVmg5BogGz1
         BHxQfMa1HMOb5OmHL3tGrzyMSqulIiahGq/y2H0U3E8BJQ35lTODqzToPXJ7R9Uh8Ssw
         6Xwg==
X-Gm-Message-State: AC+VfDxAe/s9yd+iuXKWCjqK7QCGHldEYO7r9SH3ZndEKynxiLbxJJ47
        Ae9bVxDR8Wbiv7ZqKKV77XIIRdfpJcxDW6uKytB82jhkqIYoAmI64cpiKgaF9znq7i3euSFvUuv
        lthiqbIKmGhjR+rmkez1KjiAZeaHFCiqK14/2QvMtzg==
X-Received: by 2002:a05:620a:9046:b0:763:b08c:1bef with SMTP id rl6-20020a05620a904600b00763b08c1befmr952107qkn.38.1687247823257;
        Tue, 20 Jun 2023 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VAo8FNQed1xNbUum0JLZ9eGLq7EYEo4fRgwrZZyiJngQ4drjXUe0hBNY+LU4ZYAkju0WEUg==
X-Received: by 2002:a05:620a:9046:b0:763:b08c:1bef with SMTP id rl6-20020a05620a904600b00763b08c1befmr952099qkn.38.1687247822950;
        Tue, 20 Jun 2023 00:57:02 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id x25-20020ae9e919000000b00763a23c1f23sm858415qkf.7.2023.06.20.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:57:01 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: add test to cover failure on dev->absinfo
Date:   Tue, 20 Jun 2023 10:56:45 +0300
Message-ID: <20230620075645.536827-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added coverage for the case where !dev->absinfo, and executing the
normal flow as well.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/ 

 tools/testing/selftests/input/evioc-test.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..1a688002e1e7 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,27 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsabs_set_abs_value_limits)
+{
+	struct selftest_uinput *uidev;
+	struct input_absinfo absinfo;
+	int rc;
+
+	// fail test on dev->absinfo
+	rc = selftest_uinput_create_device(&uidev);
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

