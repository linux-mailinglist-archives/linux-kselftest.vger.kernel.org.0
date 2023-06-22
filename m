Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1089F73A32E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVOhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFVOhA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 10:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D4719B7
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687444578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ylhMEZiYZ14hAt+x750PPGtpT677FhHYsnwM5fGcQpw=;
        b=fzrUmgw4OoolYX+c5HNgY3oRg4nDDwv+fPo2geP/wSRmw2/QNXNr/D9LpHChegJHSMmjDX
        EmGtI/IabAaJtt/SEnZz1BgmavFcdqfubIXKZNDPBV3HWoDtZUnhNxx8yrD+37iwdE3pdT
        OXp25YBQBA47nP2NpE0rWZcexnRqkhg=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-w1yDdPyzOHWrpFuXGDUq3g-1; Thu, 22 Jun 2023 10:35:07 -0400
X-MC-Unique: w1yDdPyzOHWrpFuXGDUq3g-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-440d2cd1087so1034367137.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 07:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444497; x=1690036497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylhMEZiYZ14hAt+x750PPGtpT677FhHYsnwM5fGcQpw=;
        b=cu9R9rvurDVmX4BDysV0S5FNOhDBA5V4PDX92hZrgt6pTjc8qFSj9uqexkgGNmC0zp
         HpPH5Y77NMGWY/+C1t7maoIE3ElAbBgmZKtxuIssqhI8gkEXXQnoEL71vbykeVIDLR9v
         SgN7gvRN5Jy+9q3pHf7nASd3dWLZWd4bb9I0kZIjEFhuyBxOaXKAC9QYo7CpasXnIgin
         5VycAm244C5aq1v7/cJpsTnr9xPp6JJ+96EHY6htDpuXzg0aiC7RuV0n/DwCP9nM7ih3
         FNlElFIPGwwGkwKjSrGTu4sa7zuI0yyFzNqt5C6NSc0kXgXzy+CifguRmIWr2CGy/mcr
         enKg==
X-Gm-Message-State: AC+VfDxRyGb41Xa/7RVXsKd9erQghPh9MWS1mqJxoV2jD4mYUSRIyQxp
        NFKe97frqgAtGdw0e8k41gC6hX6EPBcb7zulAYZ8UZBvChFNWRW86Leq3pxOYG0B/iAYkyL8wdn
        wyoSkHO+j5XMZhd5V8jSjwAN8zyXF
X-Received: by 2002:a67:f958:0:b0:440:d38b:79dd with SMTP id u24-20020a67f958000000b00440d38b79ddmr3600217vsq.7.1687444496916;
        Thu, 22 Jun 2023 07:34:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7w0+pRcQ7vKC7nMxRgzfWN+zMx2algx4tIykzGciAigLiAa4Fgu8mpzXPVMmqSngLOQhmVbg==
X-Received: by 2002:a67:f958:0:b0:440:d38b:79dd with SMTP id u24-20020a67f958000000b00440d38b79ddmr3600203vsq.7.1687444496628;
        Thu, 22 Jun 2023 07:34:56 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id d24-20020a0caa18000000b00631fea4d5c2sm3287887qvb.98.2023.06.22.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:34:56 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v2] selftests/input: introduce a test for the EVIOCGLED ioctl
Date:   Thu, 22 Jun 2023 17:34:38 +0300
Message-ID: <20230622143438.139187-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces a specific test case for the EVIOCGLED ioctl.
The test covers the case where len > maxlen in the
EVIOCGLED(sizeof(all_leds)), all_leds) ioctl.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
Changes in v2:
- Changed variable leds from an array to an int

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..378db2b4dd56 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgled_get_all_leds)
+{
+	struct selftest_uinput *uidev;
+	int leds = 0;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	/* ioctl to set the maxlen = 0 */
+	rc = ioctl(uidev->evdev_fd, EVIOCGLED(0), leds);
+	ASSERT_EQ(0, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

