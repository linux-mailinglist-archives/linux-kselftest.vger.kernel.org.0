Return-Path: <linux-kselftest+bounces-2006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A581429D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4833A2853FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0C10973;
	Fri, 15 Dec 2023 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0lx2l5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8013FE9
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcce488c52so71807276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 23:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625972; x=1703230772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4MXXH5cbPxzFQMx+eKCBMLxcs0KvqjK2kPkW0nLFkA=;
        b=G0lx2l5I+vav3thN3cKmD1WWSs6NF6uQsEFdCIAH7M3r0whgeoX1BdfWBCcFBIg8+q
         xJzQPxnh05VFerTIyBUweR48mVScGreqo6WDxM5INYStE7T2Y0SdupOba1AkSMKpTcE+
         oLdp3cg0yZLyDmyRLP5J/3WCUkFE1cRbAmI040dr7WOwn0xtzqponnIzdVLIQ3a05xrZ
         I77xdlKl0CO4+KPcdkR33lnEEEzCZ44LQKjmcyw+Bft8K7tg1De6NOhpl4c4W+SXNxpC
         IKdxyaBDMivHmwaI5XgX9wfcqHFkjyptHj8Ju3kepZvEeNWzVTIT8J+Y+09DYdjiXiyX
         cTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625972; x=1703230772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4MXXH5cbPxzFQMx+eKCBMLxcs0KvqjK2kPkW0nLFkA=;
        b=cqZwmanm1xET0O/Vnj5XSLxG8g0laVTvrPKvsCcX6+Z2XGybWOBZZectH6nW6R5gBp
         D74+hqT6Te1a+DS18v4Jp5TY3bDwLn8vpUMxrhwSxLC55z03uZ8xkou8DNXkLR13sZtl
         EpSCD8FmTt5B4w0Ud33frx9yzgF5N7C0tQLtQD+0dQKd6GZHVD5wVSRayD5k8TRX12Cv
         Xd0BwrRzFW+BhoIXRE59uAXsPPh+TeJQngJXv2N0901bs+rcU9W0c6R7na2/q4Sihad4
         lXUg8LYEHkNiwu/xzIZW9LcDPNEpUYmiDC2LhYGgPZR4yau2qnDV2cURSFsirg6rRFD2
         EClQ==
X-Gm-Message-State: AOJu0YzFN8MXKnZB2LwvZY+lk29gIF/cdlptHEi/jI6wYoX+pwpVjwH2
	gKSrmx59eMVkrxLHP4ncJ93eM32hLJGFog==
X-Google-Smtp-Source: AGHT+IHFhhWMR/kJRqTx6WHoW1Cw50Apf42JCOhF6MR/ULXu4wBRUQj91kJR8wij5MUTOYH+2REhYsHY7wVTEg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ab8c:0:b0:dbc:c82d:7f0a with SMTP id
 v12-20020a25ab8c000000b00dbcc82d7f0amr53140ybi.9.1702625972472; Thu, 14 Dec
 2023 23:39:32 -0800 (PST)
Date: Fri, 15 Dec 2023 15:39:11 +0800
In-Reply-To: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231215-kunit_bus-v4-4-4f5160e2f95e@google.com>
Subject: [PATCH v4 4/5] ASoC: topology: Replace fake root_device with
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

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 sound/soc/soc-topology-test.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index 2cd3540cec04..70cbccc42a42 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -9,6 +9,7 @@
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
+#include <kunit/device.h>
 #include <kunit/test.h>
 
 /* ===== HELPER FUNCTIONS =================================================== */
@@ -21,26 +22,19 @@
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
 }
 
 /*

-- 
2.43.0.472.g3155946c3a-goog


