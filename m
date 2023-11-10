Return-Path: <linux-kselftest+bounces-11-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC927E8377
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CD11C20B4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECA53B792;
	Fri, 10 Nov 2023 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAujfGHJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569C3B78D
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 20:08:49 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E29DC
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03c5ae220so2830325276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Nov 2023 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699646927; x=1700251727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAkJ89LUqtxG0K+MSJnco+XQD27u+TKLaVoOcPh4bOc=;
        b=JAujfGHJ8yOYNMAj+/UzMg5ghYS5kqcl7r5wvrjHHCdl2sM8xOiTkUGnVaF+EHQjJb
         TmJhenOTUE/qPxBsjJBqd7QjAUK89cbdB2q1c7corDKfnE2MywVyc4qjt2FMEwkQaUqA
         JLopDWEh9Zx6/9lehNFw0qyeeunwaCl3uO2oj/yVVL6EeBZFs80cjPKM1MxFsuubgqZm
         22YQEEAIjx0YRE7ZRv6AW7TsH4v6Bk9y2NYAkZIXYVKPKPdyCQFiz5UYFVzVbqd8ZJbg
         nAsYZInmjMEDKXuvMtX6lr2Urrl+kIUb81TOODAcX6wlIIdlBiY4HC+oOBC3CurBJGCu
         Ll4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646927; x=1700251727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAkJ89LUqtxG0K+MSJnco+XQD27u+TKLaVoOcPh4bOc=;
        b=YAhDGvzTuAUVujayLr8d2gJ9KYWZF3mt5Gukoi0kMjQ41fpctRqAq4tKrFs+/FfEWX
         EvpxH1ZZRaJ/NcwljUDPAYglzy+M1dbFuBDKACih7AGM3BlbP//8ECiTHTGGdmpIerSo
         qj+OmW1Qx6rTKHMi/NmbmxyEaqVlq3unbOpG6ug7B0xy8qETSwPWpGGdwy8JyJ7XnzWc
         BRfdhuZiz0XAIyRafDB2IJUNbMljW4+FH0casTFTh0xMHt5YGf9UXL33cWiunkZnoqm+
         OPROycef8/w7kdfR34e4GthUh98HKBYRUEtjFUKpw4JKWKTEaQJiZBbAdU+bkbderlfn
         NVKA==
X-Gm-Message-State: AOJu0Yxf114Ib70zzeL8HKdRbbq2luVG5Az1pxHURLG9wi4Nts7eXKQ6
	c4yrx48/q1Xr5R6409cYP4ZmDys/WGCD+g==
X-Google-Smtp-Source: AGHT+IG2qICxw/Ih6W1d00Yw7wl6gZh00iMH2vxhyvW4HtVTUR9T6SIeeV3AzuFmY7j3gx/bERyrecNPMvP5+g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:18d:b0:d89:42d7:e72d with SMTP
 id t13-20020a056902018d00b00d8942d7e72dmr141489ybh.3.1699646927074; Fri, 10
 Nov 2023 12:08:47 -0800 (PST)
Date: Sat, 11 Nov 2023 04:08:28 +0800
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110200830.1832556-1-davidgow@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110200830.1832556-3-davidgow@google.com>
Subject: [PATCH 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
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

vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
involves less boilerplate to use the new macro, so replace the manual
implementation.

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
 drivers/gpu/drm/vc4/tests/vc4_mock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index 63ca46f4cb35..becb3dbaa548 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -153,12 +153,9 @@ static int __build_mock(struct kunit *test, struct drm_device *drm,
 	return 0;
 }
 
-static void kunit_action_drm_dev_unregister(void *ptr)
-{
-	struct drm_device *drm = ptr;
-
-	drm_dev_unregister(drm);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_drm_dev_unregister,
+			    drm_dev_unregister,
+			    struct drm_device *);
 
 static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
 {
-- 
2.42.0.869.gea05f2083d-goog


