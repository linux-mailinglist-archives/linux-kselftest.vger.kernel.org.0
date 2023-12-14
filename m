Return-Path: <linux-kselftest+bounces-1900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206C9812AB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00481F21853
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C92421F;
	Thu, 14 Dec 2023 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRByfs6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E0116
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcca4c56b9so2382326276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543784; x=1703148584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=aRByfs6jJv1pPl+XO5MRrqPIEKLf20hbEIpup6djP2bJKRqLu9PMErZeB6Wn/uAKpr
         G91nfjkpuuoXv581ZhCxU44bDu3oeBDHIkwI09alP0Ei6zXO3GqXx746/JAUu7mA0xcZ
         d91pIaanzP9lwQUmw+P/4oFZGlKa/+nHsmOJs04dVVrtgq+bIgsnbKqbeAE/LxiIKWVd
         60NngqrtSB8o79W+YfxOKpRVq0hfRyhbEwcvaOK1cQeq1+2uYNL4S8nvfNv2HpGi31C0
         o1wkxhUq292fLKjC+F2uw5swWgMqpmvbjIW4rR/a2FH33eNGai5C4mUhzFKD8p5yLD2i
         3AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543784; x=1703148584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=hAQmWe9b9nBTyJiXEveGHT2BkFLxbuyJIA6aWN88eipirgHmlHfvp43yh3bT93CWdH
         WUxIRFnZYACNv8Ar6ioUceUvW1Ey1rCyfPvfIhMAd72nthAUDBNXfaF16JgUQsYo5HwD
         dGakIQJHOKnkykyKaoqLasGyYN/hPiurcneYUwYFIeAPIuUL4f//w4Za8HrkIOGnwRiE
         afj306Jl3Wb/YU5LTxMIhbtFw7iMX4lpS0JKmrQR+q2C+NDqv3Mn8YF+SZAn7uD1QiIK
         8GeztaJLld5bF4kFQ9Iajzap/DbOcjoNXPY9dJkyinI0fK90i7RKkowBso+wJICxn4xs
         3p+w==
X-Gm-Message-State: AOJu0Yy4gjptZwQ4sKex+eQfm4GNma55QTgCPm9ZrmYJE3DVmuG0WzU0
	JyokpLVTJ38oihTFe0GRPCq3eLhmda5rVQ==
X-Google-Smtp-Source: AGHT+IFVOYWdsgVT9nhqnqJRy5ZyN3SJnHb/wvN1UGFrpdBCV2Uk0Ui6lM09NFUHkZEBROCN/4reVrGN3Guhgw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ca92:0:b0:dbc:cb73:15c8 with SMTP id
 a140-20020a25ca92000000b00dbccb7315c8mr38319ybg.5.1702543784333; Thu, 14 Dec
 2023 00:49:44 -0800 (PST)
Date: Thu, 14 Dec 2023 16:49:16 +0800
In-Reply-To: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-2-7e9a287d3048@google.com>
Subject: [PATCH v3 2/5] fortify: test: Use kunit_device
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

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/fortify_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..2e4fedc81621 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,6 +15,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	size_t len;							\
 									\
 	/* Create dummy device for devm_kmalloc()-family tests. */	\
-	dev = root_device_register(dev_name);				\
+	dev = kunit_device_register(test, dev_name);			\
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
 			       "Cannot register test device\n");	\
 									\
@@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
 		devm_kfree(dev, p));					\
 									\
-	device_unregister(dev);						\
+	kunit_device_unregister(test, dev);				\
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 

-- 
2.43.0.472.g3155946c3a-goog


