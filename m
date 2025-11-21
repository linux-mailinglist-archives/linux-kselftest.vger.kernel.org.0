Return-Path: <linux-kselftest+bounces-46146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCE0C76B35
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1839635E4C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8B2032D;
	Fri, 21 Nov 2025 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VePy7+KN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893964C97
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763683479; cv=none; b=IM3PX8taIhmxXXs4AG2FXk32QeHRBoqu7h8Hlp0HtD4czxjmaalbg59Anq/jG0V7Cq0KKEGsWZsy+YRbli8wc9WPVkyDbn2lmFEDBfEP7+EsdWBAYeIB73kJqavJYz920TieCt24kb1sN8oO/WLKK8TEZMYWU2g6z5OiuQ65W/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763683479; c=relaxed/simple;
	bh=2AXrSv9Whw8ZnmYI11LonZo2zoxqHUg4PkT1bewu+LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbosW4zuj8DuJ70W9J07Im+cSNX3sSUkjMJlG4WnwOs7iQR8LQUEK4UaLUSDp4BEn8xDdmaEleTZnzLwdYYT4Tlr4M2zc/QzGuGcJjdvhmai+x+LOzrNXaUxYP9v6I8nqygr5pZHlX8bKA9750O8iX/jvVI7X8cQ7uP1wPityJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VePy7+KN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso1676607b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763683477; x=1764288277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSsLiiSTL2av7klPupKbRan+kIsIZbAf1eXJiOEAwnc=;
        b=VePy7+KNE7vd6Gsm2JDK/Z4LToX2hxktSsuldlzbGOmJZYYHMI5OLZQmbjPtZ8FHfH
         Da14lZVEv5iSIilF8IlFIm8XY5fRdFXz/dV3jZiBlEJYiw7SKQVndUhIt5heuLwG5hf+
         JeepQH3SY7JYmyStmtF8lbzaMhxoY0ItX8JCcxrnpvYc+yqWD2EGHp8j6Dd670/QV/Ik
         alyh67o5i0kBHkUozS5M3zxoNu3UYwPJWrjrhvGFrJvbAAZF9QeMQyS3vWe6DeeMan/b
         OMYQBzZDOig6/W0IMROzARSWsioACHsJLwyEvw+E7FkYeEjJq7InnQ0SO0hC6fQxWOwK
         GKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763683477; x=1764288277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSsLiiSTL2av7klPupKbRan+kIsIZbAf1eXJiOEAwnc=;
        b=USXSCxvLVNiEGSnLETxUF3H/JOKzyj73uBBZPmAUjmW7KZHVnsXsFGQ76cW+u618F3
         BFs1EShuYQwcFM3VoTAQ+dXWfiTJHoCq4wtZYz60Cftb6CEF/TPnuBG3w8A358q7bC+9
         6X8r1pPm0tE1N65pLzG6gVaTNejqSqT1LabKfdnO5ySiwDlS7skwJ+LubRl5NDt/Myql
         PSZa0f3SBd1PhmnXPXe943DkqzYPVR1ngbWVhZKtX7DFpUMRsJ7poq6AOj/9KjL+NKcy
         JpIGsrwoLXBe+Q0CEY8z40AUpQJbRHNlZCsXp1a9pqkj3k2QVAgBkkRZLpaxr5kgg/L5
         aEtA==
X-Forwarded-Encrypted: i=1; AJvYcCXq59MdnU0QokveJQQI7BeWftXdfc3c6/6QaYw/zz9V1nopOx3S29ECBEIUEWye7ngV6M6Xn1IEPW5sXO6gvrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVm8wAkebtrCeZVwsiLd22BNeFO0A2u5ObTq9v39u81zzhTh6
	SS5zbg2dEcSQIxpoOkenJiBVZxVUjfE/oKge7D8iOJt60NUYNdDcC5vd
X-Gm-Gg: ASbGncv+oaZdMvvr0sEuYOgnVY9LCGiP5ZVfgD0uPO0a90DuK2h9MGBTmBtW8QJoWip
	mOELFAdtOaZbUfjkG9j22AQ9w4tN1NKdFrrl/LQuqlmZaTRlS0iV0wJnVdUBudr7NJoHj+qkt6F
	W5bGTqgHzLbTEZq1KCJp0TJpcBOmQSIP5L1EjdGNBpL4hzvHzq4knR5BsFQIwl6LEUBy349S/TT
	YVs19jDumKRiov3YAldHIqFQ4Ug1wWMfnMLdD7Lb79qOUfZS7dgJ6hR1PJyv+q6FvsLM60YFMqY
	6CTvYGQVEDSMsZXf7N4X5PhgdfWnZeUSJdxLU5EgqeC/a/T8HdPFJ8Fqg9lHxGTg9YbE4TbeMoI
	5UzZh6qTU1y/RBKWX/xCawKPHLnWaK2qlkTJWfztg1N9LnlLf1W3bYl0EIHfLyd7QYFuKhtJaxj
	z/4BL8MJ81BHs=
X-Google-Smtp-Source: AGHT+IHEEykjr6frs/VgM0X+yEhuXraBfQZb1stxpNE6IIjwHd7vKqpUhN1IDF8q8RL/oojJYuO/FA==
X-Received: by 2002:a05:7022:a92:b0:11b:1cae:a0fa with SMTP id a92af1059eb24-11c9d55469dmr197846c88.0.1763683476748;
        Thu, 20 Nov 2025 16:04:36 -0800 (PST)
Received: from fedora ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm15035710c88.10.2025.11.20.16.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:04:36 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v2] selftests: hid: tests: test_wacom_generic: add tests for display devices and opaque devices
Date: Thu, 20 Nov 2025 16:04:27 -0800
Message-ID: <20251121000427.401283-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117014721.3142490-1-alex.t.tran@gmail.com>
References: <20251117014721.3142490-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify Wacom devices set INPUT_PROP_DIRECT on display devices and
INPUT_PROP_POINTER on opaque devices. Moved test_prop_pointer into
TestOpaqueTablet. Created a DirectTabletTest mixin class for 
test_prop_direct that can be inherited by display tablet test classes.
Used DirectTabletTest for TestDTH2452Tablet case.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- Removed the tests from the BaseTest class
- Removed disabling tests for certain subclasses
- Moved test_prop_pointer under TestOpaqueTablet
- Created DirectTabletTest mixin class
- Moved test_prop_direct under TestDTH2452Tablet
 .../selftests/hid/tests/test_wacom_generic.py | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index 2d6d04f0f..9d0b0802d 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -598,18 +598,6 @@ class BaseTest:
                 if unit_set:
                     assert required[usage].contains(field)
 
-        def test_prop_direct(self):
-            """
-            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
-            """
-            pass
-
-        def test_prop_pointer(self):
-            """
-            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
-            """
-            pass
-
 
 class PenTabletTest(BaseTest.TestTablet):
     def assertName(self, uhdev):
@@ -677,6 +665,13 @@ class TestOpaqueTablet(PenTabletTest):
             uhdev.event(130, 240, pressure=0), [], auto_syn=False, strict=True
         )
 
+    def test_prop_pointer(self):
+        """
+        Verify that INPUT_PROP_POINTER is set on opaque devices.
+        """
+        evdev = self.uhdev.get_evdev()
+        assert libevdev.INPUT_PROP_POINTER in evdev.properties
+
 
 class TestOpaqueCTLTablet(TestOpaqueTablet):
     def create_device(self):
@@ -862,7 +857,16 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
         )
 
 
-class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest):
+class DirectTabletTest():
+    def test_prop_direct(self):
+        """
+        Verify that INPUT_PROP_DIRECT is set on display devices.
+        """
+        evdev = self.uhdev.get_evdev()
+        assert libevdev.INPUT_PROP_DIRECT in evdev.properties
+
+
+class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest, DirectTabletTest):
     ContactIds = namedtuple("ContactIds", "contact_id, tracking_id, slot_num")
 
     def create_device(self):
-- 
2.51.0


