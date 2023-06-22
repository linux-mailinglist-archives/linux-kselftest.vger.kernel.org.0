Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7273A2E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFVOTk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFVOTk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 10:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519B9E2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687443531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SuhxBXJ6cKLy3QQhzr3pF9dmirmGTLkErjm6gq5Ry2Q=;
        b=GdxkSeynMf1hzV/Ejout2uD1MBtI5zZdjqAIjPB7W7eMgdo5sjjO0EeMboX4icoQNSPqcI
        w5T4kwjn1qy+xaim5jrlXkwvx/n3lIyrEeQqmn54p+E0dSGHF63w055oioMSyvEqQy6b7D
        FizA6GbGKxBPUDKGZrhnSmMXJwR14NA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-iS2yw197MbCqwqUwrC_YEQ-1; Thu, 22 Jun 2023 10:18:44 -0400
X-MC-Unique: iS2yw197MbCqwqUwrC_YEQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ff3cb54a54so29143371cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443524; x=1690035524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuhxBXJ6cKLy3QQhzr3pF9dmirmGTLkErjm6gq5Ry2Q=;
        b=hirD0Es4ML4SWl+bJAFpPLnin4fFuQKx44XKeshwql6x9MPYwsisj+6OKLiR2/i0u/
         b0B6Zg1UwT48OhBeNIatMFiSZeBNncsioHjeTn5ldpO58FkD8+CyH9IrEuM/tdPZInzZ
         Z95+ZXwineDIFn8idlNvk4Wk0Py0XLnBV5emEL5u0gWSkKL5dd5xVyQRJXkDCt8lt3tm
         h/zyi89LCGmp/DrNVxtprl4HTm3KNmP1n6IWEgtmLOS7WpyfO0ft8BGq5Ef+P9CMcLHX
         QmtZzp7Yw58hiWxduxplh1HfzqRcXpln/TVvDwYgFX61ZSU/buDFKWeKz8Vm5NH2OoSG
         58IA==
X-Gm-Message-State: AC+VfDyyUjbVP4wnbLgcVe2fZkMl3dJDh4gqmR8CWo+VuJpw0hXZQhzc
        TL8TYOVj/SnxwGk6eJ5hTKK6R4CtFl3/rmBIH5KpY57VBJB76E/N/oglMq8+PEaITw4yE3QqsfZ
        XmIJpawJgSDefP0rK0kRwEDnaQYoI
X-Received: by 2002:a05:622a:64b:b0:3fd:ebfa:2c58 with SMTP id a11-20020a05622a064b00b003fdebfa2c58mr17712036qtb.40.1687443524064;
        Thu, 22 Jun 2023 07:18:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ErR1UXiWuEJjQNTo1bUaPkpUj/PlO46WSHTrzVNvEyhspH1DbqNDaLRkaW5S3+07HWXRKZA==
X-Received: by 2002:a05:622a:64b:b0:3fd:ebfa:2c58 with SMTP id a11-20020a05622a064b00b003fdebfa2c58mr17712014qtb.40.1687443523634;
        Thu, 22 Jun 2023 07:18:43 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86147000000b003eabcc29132sm3643155qtm.29.2023.06.22.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:18:43 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v3] selftests/input: introduce a test for the EVIOCGKEY ioctl
Date:   Thu, 22 Jun 2023 17:18:02 +0300
Message-ID: <20230622141802.135723-1-dangel101@gmail.com>
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

This patch introduces a specific test case for the EVIOCGKEY ioctl.
The test covers the case where len > maxlen in the
EVIOCGKEY(sizeof(keystate)), keystate) ioctl.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
Changes in v3:
- Edited commit's subject and description
- Renamed variable rep_values to keystate
- Added argument to selftest_uinput_create_device()
- Removed memset

Changes in v2:
- Added following note about the patch's dependency

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
 tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..e0f69459f504 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgkey_get_global_key_state)
+{
+	struct selftest_uinput *uidev;
+	int keystate = 0;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	/* ioctl to create the scenario where len > maxlen in bits_to_user() */
+	rc = ioctl(uidev->evdev_fd, EVIOCGKEY(0), keystate);
+	ASSERT_EQ(0, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

