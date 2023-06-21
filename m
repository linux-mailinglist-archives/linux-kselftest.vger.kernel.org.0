Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62C3737DA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjFUIbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 04:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjFUIbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 04:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7010F2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687336244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MKFEkURhYUz2vUhCiF0pfANZYfcv/ilKi9F31Jrk6tM=;
        b=R9d264QlFomO9Sjh1UeG91ZcpsTEAEPAsgIew+JRxy5eVfaLTyj2W5Tv+O7YrMcqVcAbbc
        E0Z0HcVihyJu3adTJhRvASKfJ9OC+o5GCoZmL9RQO5W+TlewGWx0GcUnQ1UxlSrRiK+5W3
        OwmptmRdcEOwaQjJ7t+x7IKUZXWcLL4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-lgmla6cvNuuWtZkMzMZjtw-1; Wed, 21 Jun 2023 04:30:43 -0400
X-MC-Unique: lgmla6cvNuuWtZkMzMZjtw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-763a397a3ceso343427485a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336243; x=1689928243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKFEkURhYUz2vUhCiF0pfANZYfcv/ilKi9F31Jrk6tM=;
        b=IpJSZ05fT+y3fba5aLqljkIcgpWXkr6oXDYOYxDMO7f8LqLDNFFbTgyKnqB2d5e7PE
         UQSZIkSMbLmFXcVDGExSYPaJ2S2CJzjb8GVfvWBT7i1psJ0/wjL/9mZ5q+AMMkb0I8I5
         R6k5rJwr6gdLJ5qiHt6+ZVwobY/etBTkNRSSmgJK9Hz9nIBXNcbibBdynZgAZ4sBCSPA
         KU4hJdVCwjmBUEOUz4PTrO/BUc52h53qaTUb3oVYBRwjUUaXySJ0OV3z8D2K+46B5T3f
         XgYbQU9nsn2DE+r1vdUiCDTqZIhKowj2LcNyqaK3z8IqXhPthPkyObfvVb5/C6YblYfN
         ViZA==
X-Gm-Message-State: AC+VfDz63W7nE3m89NhbHN6KroSOCtoEIO0cwAni2JJIlp8z4HcMNzDF
        ZVX26162dh5tNjO+tMJTHrjs4rI4ngn0H9tK4ukROH+0l48AKbUoEEk0erno5qdAicMeT5c4MV6
        kPh9t4tlUhjASFsJyj/AE4TnNSxmE
X-Received: by 2002:a05:620a:224:b0:763:9e42:6bfa with SMTP id u4-20020a05620a022400b007639e426bfamr6939057qkm.75.1687336242863;
        Wed, 21 Jun 2023 01:30:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+zvL+qTMug0hEQjAxU+7n84VQIggVdf3bf4usiGjlRRs4E8mqW6AXj62bm8oYIzf9ENqiag==
X-Received: by 2002:a05:620a:224:b0:763:9e42:6bfa with SMTP id u4-20020a05620a022400b007639e426bfamr6939046qkm.75.1687336242564;
        Wed, 21 Jun 2023 01:30:42 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id s19-20020ae9f713000000b00763ae8f8f55sm1712117qkg.90.2023.06.21.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 01:30:41 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v2] selftests/input: add test to cover len > maxlen in bits_to_user()
Date:   Wed, 21 Jun 2023 11:30:26 +0300
Message-ID: <20230621083026.591323-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v2:
- Added following note about the patch's dependency 

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

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

