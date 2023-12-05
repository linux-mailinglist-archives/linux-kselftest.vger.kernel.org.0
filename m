Return-Path: <linux-kselftest+bounces-1121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1831804B2C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 08:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658B7281705
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7C2557D;
	Tue,  5 Dec 2023 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU77UWLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF651B5
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 23:32:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so75485787b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761529; x=1702366329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=gU77UWLf17NGFwns1NTtH4ufmlGXSuKUVMe0SMM3Z/hkuzpNhnNVs/ZdiK6v8qArF6
         1iPq9ZvY1n1XV3BuyBhS4bmkK8n6w20y/1zUlCfOFepTmp8dM/vEVUVW3ZPiyfbMRP09
         hCwu1fRloMi511BNUmei169Jh4wxlce0fe+rV9OB4IrxNpS6tsjOgXiLaRfHNMwnwex2
         ejrpMQ53Cn32gWbPxEVS1/Yjq8olZc8mk8my+okMtGnUhPA6d6nmXnJXs+6+EWW05mW0
         ifZyaaeAlZ2xHbNk+ndalBpIbTFFUgDECLafYNtE7lWJ7IA0Dp9H6goWe+DyqAqCVbkp
         Y9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761529; x=1702366329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdHfmQmZDYuyXCu0NGdHRUb/90Lva6Q2oB2rwJOjRS8=;
        b=mUZISiv/czKL9a1BERSjY7Q9SgLr5H49iEd12ovfp2boXJ7YTT88c4WW+/RrUyGSkD
         DoJcSjuLDK8ykvLrhfKRak4WB0Jlf9DH5LjSIz211J88sbqNO7rmW8oem4ldW4M30xwN
         Qsdl6KPZK6NRwUe6nXkds56ssi0sTwvXdwfHhvKvi7b3VIklQ9dQXKbcVsN1WI3Jk+iI
         fnq/5bqblYotCzNAIoMJhRhBgDS1O/y0InU5p5cEEgut2AcQT7ns5hTxE3iOhZDLmtUH
         Uxj+yF93TrXUcyxz7Ji4CiLB1SoBwhIjA6XcwMIgYdHCYs9IpGidarYhB8Bmr8HpoFKZ
         EkwA==
X-Gm-Message-State: AOJu0YwSGj/sbCPmAXULnkIqNcY7OWFgcBsGFi9p7f53Rbq989NV5tfp
	WPzYm83BYu0tg3WlqyJcZ2k0xevZ55Xt0w==
X-Google-Smtp-Source: AGHT+IHHF6+HTN+R7wTnVRWLqb4w18tX0Cim+QBivHuTkcMFGQFLnFtpexLAxiytHhXHivrQcbisM6rp+Y02ZQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d6d1:0:b0:db7:dce9:76d3 with SMTP id
 n200-20020a25d6d1000000b00db7dce976d3mr188630ybg.9.1701761529700; Mon, 04 Dec
 2023 23:32:09 -0800 (PST)
Date: Tue, 05 Dec 2023 15:31:36 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
Subject: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Signed-off-by: David Gow <davidgow@google.com>
---
 sound/soc/soc-topology-test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index 2cd3540cec04..1d7696e5bffc 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -10,6 +10,7 @@
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
 #include <kunit/test.h>
+#include <kunit/device.h>
 
 /* ===== HELPER FUNCTIONS =================================================== */
 
@@ -21,26 +22,20 @@
  */
 static struct device *test_dev;
 
-static struct device_driver test_drv = {
-	.name = "sound-soc-topology-test-driver",
-};
-
 static int snd_soc_tplg_test_init(struct kunit *test)
 {
-	test_dev = root_device_register("sound-soc-topology-test");
+	test_dev = kunit_device_register(test, "sound-soc-topology-test");
 	test_dev = get_device(test_dev);
 	if (!test_dev)
 		return -ENODEV;
 
-	test_dev->driver = &test_drv;
-
 	return 0;
 }
 
 static void snd_soc_tplg_test_exit(struct kunit *test)
 {
 	put_device(test_dev);
-	root_device_unregister(test_dev);
+	kunit_device_unregister(test, test_dev);
 }
 
 /*

-- 
2.43.0.rc2.451.g8631bc7472-goog


