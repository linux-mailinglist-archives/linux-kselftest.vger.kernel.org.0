Return-Path: <linux-kselftest+bounces-5511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1C86A7FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 06:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAF31F24100
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 05:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5314210F4;
	Wed, 28 Feb 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8deY+mg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15246210ED
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709098051; cv=none; b=MWgD77MTEw/IW+EmuMMUI76Gox7D3rDzwHF+bE5YwS1XBvQbKkKq90Nht09oBdDmATcIbP+mGKn+89ZUpJo69nMhBhkSFaNI1Fbu+T9c+jtZe01X6rx4Jsw8oRiws8gCtIUa7aR1tT7V5U2Q/3Qj7cfO29DC0PNgQ0hR/L0PN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709098051; c=relaxed/simple;
	bh=f91w+0QC3qP9EU7d+4+laz201VJZGD/uwQ2hj2v9Y8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oYiKIxUfmc6aABrKawzRqZktRnk1ULevNQ5n7Qo5Ilpqp6mTViD0MPaMPm+QBZU09l0fnzFGENqy4300ujAYUUkMsuai0uYp5N57EwYU+RcdqcAP2JSqr5nZyhyjIzYdGnIPa8XpxtOo9SyyKNygTy3J4afMW8JS2huGv/TG1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8deY+mg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so84022947b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 21:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709098049; x=1709702849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qlQXkJNmXY3V9U5JrSaKD9CZoD39fkjGBycAj3A9pQ=;
        b=K8deY+mgb02H7CYEmxZXBGFs4WVQKH/MEe+c3P5i+FDd8GJ6ua0QFFz9FdQT6ct8jR
         t9EV+hZp/q+xlJBJO+P+4HRhYC0x1eS9YebKf8EASYhp0zLdNGe6UDIKptVHUBbJ+XiG
         Gi9nYw5ptGX7bum5lMYyM3YP6WoTaY50Mjz58e+ykUyszNqtBk8dgI8SKmMKBOTDZU/M
         C7xPd1IPWVaXUvMSMvbrGDqEUNe7U/npR3pYKZSMFIt6DUy4MRtWhVxAHOtK24o9T17e
         L6o55kilsL/C6NcSLv/ZbjZsGYYmRtT7Wld7/KdcWkG8L+h/hl3+l9K8tLBa9JDJveV/
         pRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709098049; x=1709702849;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qlQXkJNmXY3V9U5JrSaKD9CZoD39fkjGBycAj3A9pQ=;
        b=fA4Dbcd9vicjH6rIZTUyQnGrS12hOq7Zp6uPOpzS2s05geDKNwBbhU6H803k0/IM0Q
         Eh6eP6Z08DXuo/lm8PbcsxM/AySEtrQm6a7dpGTUA+ZfLI0ycm/79fUUWZPMGH8u3crc
         odoM6oTVTFPWmfDrKSdj3ZZtX4LWj8ynXTkxn/RYXoLQDZpDy0Rh3dQOQC7q/m79FDyO
         QghhG4dQdzz+4HbYvuC9FOBXaHMYfUt0VFmz7V6ie6ukGnzNKdD6TlocG1D0Wg53ccGg
         Pg3Q/Vmw76d556mqib3pffnIE/a9hRQQSa8jaTkYCA74mmq4eV5aAcPkb5npzhi7nbwB
         wf+A==
X-Forwarded-Encrypted: i=1; AJvYcCVVj1gFzi1S21lkYMZf0nFd3XZdjdu3VMYxHEY2QOgpcHMtKTYDNiZzRHf32J5M1Un7hl0RZEGQw1Y/mQeNeSWekuSpM9p8DEdepRriBiSg
X-Gm-Message-State: AOJu0YwAGPxgXkRfJ7E1xSbHxvS0HVjL4RX8Yo1JSyKHJqp3WiGHKhHg
	Uj49IX2S1XQ0wO1ynquCfyx9KcD8SzIG+gBQBMIhTHH/2pbs+4PRm6HElEbPn83Fngcu7R769Lp
	JK/bSZRSZBA==
X-Google-Smtp-Source: AGHT+IH+/qGhGDq3Yovyrglwb4bcFyvgK7xysDbRhlcFNgma2qcuZmmIjriDyKoazNpJafEO07qRx6QW2gm0kA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:b341:0:b0:dcb:bc80:8333 with SMTP id
 k1-20020a25b341000000b00dcbbc808333mr455657ybg.13.1709098049017; Tue, 27 Feb
 2024 21:27:29 -0800 (PST)
Date: Wed, 28 Feb 2024 13:27:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228052722.409679-1-davidgow@google.com>
Subject: [PATCH v2] drm: tests: Fix invalid printf format specifiers in KUnit tests
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The drm_buddy_test's alloc_contiguous test used a u64 for the page size,
which was then updated to be an 'unsigned long' to avoid 64-bit
multiplication division helpers.

However, the variable is logged by some KUNIT_ASSERT_EQ_MSG() using the
'%d' or '%llu' format specifiers, the former of which is always wrong,
and the latter is no longer correct now that ps is no longer a u64. Fix
these to all use '%lu'.

Also, drm_mm_test calls KUNIT_FAIL() with an empty string as the
message. gcc and clang warns if a printf format string is empty, so
give these some more detailed error messages, which should be more
useful anyway.

Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
Fixes: fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targ=
ets")
Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20240221092728.1281499-8-davidgow@g=
oogle.com/
- Split this patch out, as the others have been applied already.
- Rebase on 6.8-rc6
- Add everyone's {Reviewed,Acked,Tested}-by tags. Thanks!

---
 drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
 drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests=
/drm_buddy_test.c
index 2f32fb2f12e7..3dbfa3078449 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -55,30 +55,30 @@ static void drm_test_buddy_alloc_contiguous(struct kuni=
t *test)
 		KUNIT_ASSERT_FALSE_MSG(test,
 				       drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							      ps, ps, list, 0),
-				       "buddy_alloc hit an error size=3D%u\n",
+				       "buddy_alloc hit an error size=3D%lu\n",
 				       ps);
 	} while (++i < n_pages);
=20
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=3D%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=3D%lu\n", 3 * ps);
=20
 	drm_buddy_free_list(&mm, &middle);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=3D%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=3D%lu\n", 3 * ps);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   2 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=3D%u\n", 2 * ps);
+			       "buddy_alloc didn't error size=3D%lu\n", 2 * ps);
=20
 	drm_buddy_free_list(&mm, &right);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=3D%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=3D%lu\n", 3 * ps);
 	/*
 	 * At this point we should have enough contiguous space for 2 blocks,
 	 * however they are never buddies (since we freed middle and right) so
@@ -87,13 +87,13 @@ static void drm_test_buddy_alloc_contiguous(struct kuni=
t *test)
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							    2 * ps, ps, &allocated,
 							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc hit an error size=3D%u\n", 2 * ps);
+			       "buddy_alloc hit an error size=3D%lu\n", 2 * ps);
=20
 	drm_buddy_free_list(&mm, &left);
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							    3 * ps, ps, &allocated,
 							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc hit an error size=3D%u\n", 3 * ps);
+			       "buddy_alloc hit an error size=3D%lu\n", 3 * ps);
=20
 	total =3D 0;
 	list_for_each_entry(block, &allocated, link)
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/dr=
m_mm_test.c
index 1eb0c304f960..f37c0d765865 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -157,7 +157,7 @@ static void drm_test_mm_init(struct kunit *test)
=20
 	/* After creation, it should all be one massive hole */
 	if (!assert_one_hole(test, &mm, 0, size)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm not one hole on creation");
 		goto out;
 	}
=20
@@ -171,14 +171,14 @@ static void drm_test_mm_init(struct kunit *test)
=20
 	/* After filling the range entirely, there should be no holes */
 	if (!assert_no_holes(test, &mm)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm has holes when filled");
 		goto out;
 	}
=20
 	/* And then after emptying it again, the massive hole should be back */
 	drm_mm_remove_node(&tmp);
 	if (!assert_one_hole(test, &mm, 0, size)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm does not have single hole after emptying");
 		goto out;
 	}
=20
--=20
2.44.0.rc1.240.g4c46232300-goog


