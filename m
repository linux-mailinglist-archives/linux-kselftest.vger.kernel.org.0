Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D3735DE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjFSTgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjFSTgy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 15:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990BE4A
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687203364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pMJOIdE3X4UNJ2gErlr8U3aVkI1A50qWXW9P0aBkflI=;
        b=X1ogQagWYW5DzB/gNBRoLuq0iBy5SurmR+TGJ0qkXh6WuRW265G0qVLYUqYpepvW88XwuG
        x/ID3/QMiE9RadySh/MAudQ2RlWdDkJk6oKLqgCDeFokIky5R84lg7uYYoFNSsbSrcYEQM
        MFkFoQfqVXusJvLskflpL4uhgubymGo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-SyfiPo8gNpe36yNWuVcHKg-1; Mon, 19 Jun 2023 15:36:03 -0400
X-MC-Unique: SyfiPo8gNpe36yNWuVcHKg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f86cb1e258so1176843e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jun 2023 12:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203361; x=1689795361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMJOIdE3X4UNJ2gErlr8U3aVkI1A50qWXW9P0aBkflI=;
        b=a3/Op6gY8j6ne4dtkBwY4Sbqzmg7N3KmI5dwbyqOTZrbSzQNmV6uHxc962kjtIpiPs
         WYRRGFhGgXXIciChtWAkMUI/M/5oEBrfcb3h79zqVa1Z/gM1/yYYO0If06nWxsVl3mvk
         KVQ9+7ATrJcOSa6H51S0gGPqsxTciRLTbFXqyER6okIAlqeIcJ+pO0GbIx+IvHSVsh7M
         3OdDiDPf5yLEOlx8JsDal2y7cs3OxFNt7Au4LZOKTHJQajiSm+SjW3ghM3dmRcRzUvWA
         sQZwy67m5I3zD1HZ6uN00USNkDwOWhWdnPT4csF5zgEkNPMwH+kYUysD23DtpBxNZK9Z
         xtmg==
X-Gm-Message-State: AC+VfDzDNwWPRaIuYgY3OONqY8ZoGK5D4J+oAISqFM7DVgx8E6hwGroo
        iwIddjA4xVtlT/nfeZei/+GjwIWckZLK00tbMqq+pqujLc2e6loap3cgs/9yWmDR/77/MCu+3A/
        J7biZsKwDaa+ZZParAB86EqBTy6BoOxrt9nRImvqsRQ==
X-Received: by 2002:a2e:a443:0:b0:2b3:469d:1c7f with SMTP id v3-20020a2ea443000000b002b3469d1c7fmr6475960ljn.8.1687203361232;
        Mon, 19 Jun 2023 12:36:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bU0gz9QT13SNOJA8ROLOECj0uMSYK6fJxYbxlNMOGDa8e9p2YPqYTAa9eZBI/dRq3w2XqeQ==
X-Received: by 2002:a2e:a443:0:b0:2b3:469d:1c7f with SMTP id v3-20020a2ea443000000b002b3469d1c7fmr6475951ljn.8.1687203360849;
        Mon, 19 Jun 2023 12:36:00 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id n4-20020a2e86c4000000b002b31feab8f9sm21301ljj.100.2023.06.19.12.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:36:00 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: add test to cover len > maxlen in  bits_to_user()
Date:   Mon, 19 Jun 2023 22:35:48 +0300
Message-ID: <20230619193548.492395-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to cover this case, setting 'maxlen = 0', with the following
explanation:
EVIOCGKEY is executed from evdev_do_ioctl(), which is called from
evdev_ioctl_handler().
evdev_ioctl_handler() is called from 2 functions, where by code coverage,
only the first one is in use.
‘compat’ is given the value ‘0’ [1].
Thus, the condition [2] is always false.
This means ‘len’ always equals a positive number [3]
‘maxlen’ in evdev_handle_get_val [4] is defined locally in
evdev_do_ioctl() [5], and is sent in the variable 'size' [6]

[1] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1281
[2] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L705
[3] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L707
[4] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L886
[5] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1155
[6] https://elixir.bootlin.com/linux/v6.2/source/drivers/input/evdev.c#L1141

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
 tools/testing/selftests/input/evioc-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..b94de2ee5596 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,23 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgkey_get_global_key_state)
+{
+	struct selftest_uinput *uidev;
+	int rep_values[2];
+	int rc;
+
+	memset(rep_values, 0, sizeof(rep_values));
+
+	rc = selftest_uinput_create_device(&uidev);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	/* ioctl to create the scenario where len > maxlen in bits_to_user() */
+	rc = ioctl(uidev->evdev_fd, EVIOCGKEY(0), rep_values);
+	ASSERT_EQ(0, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

