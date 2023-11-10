Return-Path: <linux-kselftest+bounces-10-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909777E8375
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 21:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C177E1C20B0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA743B796;
	Fri, 10 Nov 2023 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8z0hd3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41333B7B7
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 20:08:44 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B2A9
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dae71322ed4so3022350276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699646923; x=1700251723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=51fJBfx3imxlXxpJCLaVZXz5cvn77oR86IbzpiZXKNs=;
        b=Z8z0hd3rLiSBV1f7Bl/bch+Tx+/+iZQFB1vZWYMcF4yhbJ2WW9dLRvw9ghPIw3ton/
         D7VUgsAgzqGQBQiAIu6k0HE9GiL5tw1nYVvcl88RFGE36J+f6f2VAfFQSK0/xXPEo1FN
         AHkz61ADkq3ZlXuHSIYA15/cfCcY1CkuzJ0c93ukLURMJ9HrLb09RiKnxdX4EEktjU6G
         Z/7yB97kcUhDBlQaLTk5E6WnGD3MGnnubTqOkyAwzRlhhEMSOZocrY7UVFbvJnbA966R
         VTPboVNN5AdLNxUroFO4CBImuDhi1wn1dmb9SiCMdGYTMJMuerSqsJLiRJDkAXIV/2/E
         jNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646923; x=1700251723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51fJBfx3imxlXxpJCLaVZXz5cvn77oR86IbzpiZXKNs=;
        b=erkUcbLdjCE9sb7ZHieZZD6pXWwfyuhHbnRul9bqKLuToStcqC4UYVzFL45hIMQeZl
         PMeT2oZ7hynogKH6whhZBo/i65MC0gI4aABzTyyOhRVUYEiAZ+74d3Cwd2GAlQV8zt7i
         kyw4U9ELbvy3y9wi2gCuVRkrbn772bWB/VZQLEWjZdhUBt2aY/FH75up6CRss3XfKSSA
         FQIZaObItZfdKeqYVSJO5q4WBDq8iC6YYg6cZQ7CXW7t5vn563B/PICz9ZcBv0XiSf3S
         4Rg0NKLi2tkHGNcTEsZyw1Ze8NNiQMv+HY0tX87J93glhOTe0ex2GgIfLya+akpeDbjH
         M7dg==
X-Gm-Message-State: AOJu0Yw6jpGmsljOFF14vGEz9Qzo0ExvfQKe+3jOU+vVtdiUglTyBU/g
	q4erdYI0OF5I/X/+deB8Uh5Vf1nlxqlinQ==
X-Google-Smtp-Source: AGHT+IGDK07iaPg+g9N2kLo9bN2a5OkVBolpHXkG2QTgPQJFeKS5zwURLPQj7RWzYTJuEXCxK3CW75e1iydlNQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:182:b0:d9a:ec95:9687 with SMTP
 id t2-20020a056902018200b00d9aec959687mr3348ybh.11.1699646922890; Fri, 10 Nov
 2023 12:08:42 -0800 (PST)
Date: Sat, 11 Nov 2023 04:08:27 +0800
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110200830.1832556-2-davidgow@google.com>
Subject: [PATCH 2/3] drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
From: David Gow <davidgow@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, dlatypov@google.com, 
	Maxime Ripard <mripard@kernel.org>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>, Sami Tolvanen <samitolvanen@google.com>, 
	kunit-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

In order to pass functions to kunit_add_action(), they need to be of the
kunit_action_t type. While casting the function pointer can work, it
will break control-flow integrity.

drm_kunit_helpers already defines wrappers, but we now have a macro
which does this automatically. Using this greatly reduces the
boilerplate needed.

Signed-off-by: David Gow <davidgow@google.com>
---

This patch should be a no-op, just moving to use a standard macro to
implement these wrappers rather than hand-coding them.

Let me know if you'd prefer to take these in separately via the drm
trees, or if you're okay with having this whole series go via
kselftest/kunit.

Cheers,
-- David

---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 30 +++++++----------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index bccb33b900f3..c251e6b34de0 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -27,27 +27,15 @@ static struct platform_driver fake_platform_driver = {
 	},
 };
 
-static void kunit_action_platform_driver_unregister(void *ptr)
-{
-	struct platform_driver *drv = ptr;
-
-	platform_driver_unregister(drv);
-
-}
-
-static void kunit_action_platform_device_put(void *ptr)
-{
-	struct platform_device *pdev = ptr;
-
-	platform_device_put(pdev);
-}
-
-static void kunit_action_platform_device_del(void *ptr)
-{
-	struct platform_device *pdev = ptr;
-
-	platform_device_del(pdev);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_driver_unregister,
+			    platform_driver_unregister,
+			    struct platform_driver *);
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_put,
+			    platform_device_put,
+			    struct platform_device *);
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_del,
+			    platform_device_del,
+			    struct platform_device *);
 
 /**
  * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
-- 
2.42.0.869.gea05f2083d-goog


