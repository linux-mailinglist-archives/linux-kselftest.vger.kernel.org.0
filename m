Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881AE61835D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiKCQAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiKCQAF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 12:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052964D0
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667491104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0lF3jiA7LcuE7cjXHq5WxwDLQT0EehPUVXz7ddg0CE=;
        b=XwSmr4FilcZbCLlXH9QN7lOUI8vjnntr8kjQpa8WdSypgLwjPdpez8rmaxt3vhDEpicG7a
        gXLxyCbopfWoxrYWv1tOvUhIUzNDbA0W2u5Ozl0sQ1KbJAb7jC6I1Nt/x3wMUj4qy4n6+l
        IFfSsHFrpOT6GPHKvF7RRZxh4B8ps2k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-VgAeypOdM3mwJlAFdLcOIA-1; Thu, 03 Nov 2022 11:58:21 -0400
X-MC-Unique: VgAeypOdM3mwJlAFdLcOIA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72AE33C11047;
        Thu,  3 Nov 2022 15:58:20 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A95F54A9254;
        Thu,  3 Nov 2022 15:58:18 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH hid v12 01/15] HID: fix I2C_HID not selected when I2C_HID_OF_ELAN is
Date:   Thu,  3 Nov 2022 16:57:42 +0100
Message-Id: <20221103155756.687789-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When I2C_HID_OF_ELAN is set, we need to turn on I2C_HID_CORE to
ensure we get all the HID requirements.

Fixes: bd3cba00dcc6 ("HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v12
---
 drivers/hid/i2c-hid/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index 5273ee2bb134..d65abe65ce73 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -66,6 +66,6 @@ endmenu
 
 config I2C_HID_CORE
 	tristate
-	default y if I2C_HID_ACPI=y || I2C_HID_OF=y || I2C_HID_OF_GOODIX=y
-	default m if I2C_HID_ACPI=m || I2C_HID_OF=m || I2C_HID_OF_GOODIX=m
+	default y if I2C_HID_ACPI=y || I2C_HID_OF=y || I2C_HID_OF_ELAN=y || I2C_HID_OF_GOODIX=y
+	default m if I2C_HID_ACPI=m || I2C_HID_OF=m || I2C_HID_OF_ELAN=m || I2C_HID_OF_GOODIX=m
 	select HID
-- 
2.36.1

