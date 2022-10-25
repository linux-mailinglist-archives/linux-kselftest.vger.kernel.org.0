Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2060C834
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiJYJfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiJYJfR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95ECA8B2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGbtfkMEb8GyCHz72Cj7Hj6kcmjTcDTxFhyd1w3lCf0=;
        b=VKXhtOfFY/jGIVLyLnBHKTkVGi86X4edwCpJq0eSsGhwXpwDWc8/Y7CtCq5sS3bMCWhVpK
        VE05HRQtIyiw3vg6em4Forh7piwLwGucZ48F2iBLreHmCO3/FCglg0yAxBEV2tBLAc/9Rr
        pZDetGVCmc4zAZqtFISPs+1D0aKhHpw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-yBcCjRxGPb2AQ560Y73EQA-1; Tue, 25 Oct 2022 05:35:06 -0400
X-MC-Unique: yBcCjRxGPb2AQ560Y73EQA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A7A5185A78B;
        Tue, 25 Oct 2022 09:35:05 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5C149BB65;
        Tue, 25 Oct 2022 09:35:03 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 01/14] HID: Kconfig: split HID support and hid-core compilation
Date:   Tue, 25 Oct 2022 11:34:45 +0200
Message-Id: <20221025093458.457089-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, we step into drivers/hid/ based on the value of
CONFIG_HID.

However, that value is a tristate, meaning that it can be a module.

As per the documentation, if we jump into the subdirectory by
following an obj-m, we can not compile anything inside that
subdirectory in vmlinux. It is considered as a bug.

To make things more friendly to HID-BPF, split HID (the HID core
parameter) from HID_SUPPORT (do we want any kind of HID support in the
system?), and make this new config a boolean.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v11

no changes in v10

no changes in v9

no changes in v8

new in v7
---
 drivers/Makefile    |  2 +-
 drivers/hid/Kconfig | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index bdf1c66141c9..cf5d8b86da8f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -137,7 +137,7 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-y				+= clocksource/
 obj-$(CONFIG_DCA)		+= dca/
-obj-$(CONFIG_HID)		+= hid/
+obj-$(CONFIG_HID_SUPPORT)	+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_OF)		+= of/
 obj-$(CONFIG_SSB)		+= ssb/
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 185a077d59cd..ad767955ee62 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -2,12 +2,18 @@
 #
 # HID driver configuration
 #
-menu "HID support"
-     depends on INPUT
+menuconfig HID_SUPPORT
+	bool "HID bus support"
+	default y
+	depends on INPUT
+	help
+	  This option adds core support for human interface device (HID).
+	  You will also need drivers from the following menu to make use of it.
+
+if HID_SUPPORT
 
 config HID
-	tristate "HID bus support"
-	depends on INPUT
+	tristate "HID bus core support"
 	default y
 	help
 	  A human interface device (HID) is a type of computer device that
@@ -24,8 +30,6 @@ config HID
 
 	  If unsure, say Y.
 
-if HID
-
 config HID_BATTERY_STRENGTH
 	bool "Battery level reporting for HID devices"
 	select POWER_SUPPLY
@@ -1278,8 +1282,6 @@ config HID_KUNIT_TEST
 
 endmenu
 
-endif # HID
-
 source "drivers/hid/usbhid/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
@@ -1290,4 +1292,4 @@ source "drivers/hid/amd-sfh-hid/Kconfig"
 
 source "drivers/hid/surface-hid/Kconfig"
 
-endmenu
+endif # HID_SUPPORT
-- 
2.36.1

