Return-Path: <linux-kselftest+bounces-697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E797FB29F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2109FB20EEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3712E57;
	Tue, 28 Nov 2023 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eD0GsesO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD4D4B
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 23:24:30 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so5804163276.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 23:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701156270; x=1701761070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8A55muWkSvzSnrtuE06G95D3EwTRR81H/qJIXehCNYE=;
        b=eD0GsesOBhAzZBH/kplxySSzuceiyUg9nzOV4gFHnjE3Ey782NPKnuXVFERvC985oe
         JppY5onThnOlVKDNIC3zRmq5MII4xigtkggUparmjS679IlM3hUH02YLVS4MT/kpO9bo
         Q2J6w+mRmQ42uPmIysbO01ONcCKQFKTZQhIrw9QnQcx98zCqIjo3q4KisuRz4zKBgGaF
         G3ElAg6nTiRJizSTwNOoGYfOBoibR4Yr4PNE3gYKtwJL64lFnGJcxch1HZi4gHn2VjBZ
         1BLIcCWQQnEzck50aNa8rVh6AiVSOspASyWionfTI8Emc+aZs2RC/stdLdA2vZ8wx0nW
         KhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156270; x=1701761070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A55muWkSvzSnrtuE06G95D3EwTRR81H/qJIXehCNYE=;
        b=nARv6ant9/gsdDt3B9BZJkknOJ8bG09Z/0LX/uSoDs0btw2Kt3gdLBSb0qPyRH2CCR
         njc0SHJQXzyv79Ks27LIRH5/gb6XKE/fveGhdbiscotIXgc5QWs7Dbf5AD0dWpDd1S+p
         RVm1JG3e9Rb5TrjX7ebADDJBZznpz5oago2r0Z1h3LY8VuXO3jPt57bLqrfd03Of3HZ9
         CC/yFUgqhWeR+uKrASrJcZ7PrUD/oGf8XDFl+SG6cb/6joOrAAVBYZ+NwFoY3Nwoo7C5
         o/BkhnwQSMkxq0q9kEMaqVGne4egouRtQd8GTu5aY9gyfJBYwGY+CEQ8DO/Ws116QDi+
         8/5Q==
X-Gm-Message-State: AOJu0YwoD3OCd5RuoHO0bAVol1QmZfTSbCdS4wX2DutyuG9zXi598M0j
	DnlOswS4GdiR76exu3z6Z1T695FT9tdBZw==
X-Google-Smtp-Source: AGHT+IE7kvRypcJMNH1aBvRFoLiB9G1ImGLyl3WTQDpglv6t886iGoKBRHmMrlJFektQzH1GywC4p5ZQUuyHDQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:738c:0:b0:d90:e580:88e5 with SMTP id
 o134-20020a25738c000000b00d90e58088e5mr390789ybc.10.1701156270109; Mon, 27
 Nov 2023 23:24:30 -0800 (PST)
Date: Tue, 28 Nov 2023 15:24:06 +0800
In-Reply-To: <20231128072410.952662-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128072410.952662-1-davidgow@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128072410.952662-2-davidgow@google.com>
Subject: [PATCH v2 2/3] drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
From: David Gow <davidgow@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, dlatypov@google.com
Cc: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In order to pass functions to kunit_add_action(), they need to be of the
kunit_action_t type. While casting the function pointer can work, it
will break control-flow integrity.

drm_kunit_helpers already defines wrappers, but we now have a macro
which does this automatically. Using this greatly reduces the
boilerplate needed.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20231110200830.1832556-2-davidgow@google.com/

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
2.43.0.rc1.413.gea7ed67945-goog


