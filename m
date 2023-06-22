Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623AA73A1C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFVNRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFVNRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 09:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146B26A2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687439703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2ZkiY3h1e+pdydS87wK/l+Se+zZo9jQmPSOziGg2h4=;
        b=FnUT6QZd+pqVmt57Lz+Uh9jNYCg/5YmTFSRHNNShpf1jWaQgzKgiIILFpB3r7CdC8oIIq0
        hmTVaCc9NZRTDRhkz+46Ifpi8Kdu7hI13ZBgc5gGMbHHal1XWfUqmZOGF5CjW/ZsWs3UUc
        /BiIdukhEuIA7WtT+iqsjIRQbkKu9Es=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-C0JtktmxNTu_LsnouDJsrA-1; Thu, 22 Jun 2023 09:15:02 -0400
X-MC-Unique: C0JtktmxNTu_LsnouDJsrA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-471cce5f82fso1264061e0c.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 06:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439702; x=1690031702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2ZkiY3h1e+pdydS87wK/l+Se+zZo9jQmPSOziGg2h4=;
        b=KTMwHhnwypZhdAK1+8ygUxYNZNvQvoKRiFrvQpOvx74qfsIWhPPtRHSv3090uZ6zul
         jCvxBkA9FK91llTZz5UuCpTj1yUmEgFg6atfLIxX83GTPnIVLAqPYsQbi9Gt3/o3sp20
         VBBmE1N9Ju4QPjFUOVV5Rovx7rlDyFe5KdN1WJTPA3bIM6AEGVAFrBcg1WShG/GQTdrD
         +w18AZZ+zD8SIBAaq+1+WmetaTJh8B8j8hvSUlV7IOQNj2leJPFCxMljpRegFeWx3mzh
         QP033+ZeOe9LIh6aCu6+jcQxLlIFoA4qTl9KUJIQ0k97xy6Jdp6LYQW148D2XJ7utlOz
         BrZg==
X-Gm-Message-State: AC+VfDxugGK5ODCEHT0hyn2QtCSf50cCGDeXkCew+4+gguRt5MM3iIC8
        JxXlE/E1TNVKtkCtndCzuI1k6RqHJ5d8RYhw+neNFi4FrEKE/Fepyx12egbM1QBlCVHRbsmzeDT
        syXP/EZgngG74/9+AWgmo9yJL73mFUSOF0/Bu
X-Received: by 2002:a1f:4395:0:b0:471:53e9:376d with SMTP id q143-20020a1f4395000000b0047153e9376dmr4970620vka.4.1687439701750;
        Thu, 22 Jun 2023 06:15:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5W5DxiVuwRx7/IXq3nEY+fcjfbw1GPt92XZe/MPKnssDclCDV9biKYd4cQNHBzgiW8865QqA==
X-Received: by 2002:a1f:4395:0:b0:471:53e9:376d with SMTP id q143-20020a1f4395000000b0047153e9376dmr4970605vka.4.1687439701380;
        Thu, 22 Jun 2023 06:15:01 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a01f600b00763b9b390b1sm2457874qkn.107.2023.06.22.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:15:00 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: introduce a test for the EVIOCGLED ioctl
Date:   Thu, 22 Jun 2023 16:14:40 +0300
Message-ID: <20230622131440.59859-1-dangel101@gmail.com>
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

This patch introduces a specific test case for the EVIOCGLED ioctl.
The test covers the case where len > maxlen in the
EVIOCGLED(sizeof(all_leds)), all_leds) ioctl.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..2bf1b32ae01a 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgled_get_all_leds)
+{
+	struct selftest_uinput *uidev;
+	int leds[2];
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

