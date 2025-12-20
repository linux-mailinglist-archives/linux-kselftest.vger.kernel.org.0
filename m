Return-Path: <linux-kselftest+bounces-47779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC3CD3738
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14A4300D423
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79148313538;
	Sat, 20 Dec 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLTGuJq4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2F3128AE
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766263709; cv=none; b=VlEmU8WBC5swDibx9BTBQNJk8IwNOxECdPd39bwHLcnO4vHX7BcJfdjJorgn3XqxDJOZgSyuS+pEgKyMoOy7o62lvgKIodXEz/HJFBjCqEKlr/37xGF55CsqWpbgcDoIucb6yQY1AFUGEApJiOXFcx/cWwguQ/wxuNreAasIyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766263709; c=relaxed/simple;
	bh=2AXrSv9Whw8ZnmYI11LonZo2zoxqHUg4PkT1bewu+LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxvGs+wNRR7U+4aBTF1pApcFK5hUqvC85on+r9FJ0RT0CGUQhQCMSptuwyM84+SnaLmIrtPlY9uInYSG657HTeHJmywLCiSmNaBnRmO2JK3/1+Uw1n7EMuPhmGSeLS36DQ2YCJi1RWMSAN6ZjK9RTN5VOX4Go9eKBXwpSZNjBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLTGuJq4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso4220663b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766263707; x=1766868507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSsLiiSTL2av7klPupKbRan+kIsIZbAf1eXJiOEAwnc=;
        b=KLTGuJq4EJz1+1neb5hXe48GHji7J4xJD09lMpOhPoNwt8knQqhznwavvHFcz+67KD
         iswAsidLdhAhEYNdSFKmWmuVZgORKmM1W7c7xSwA6NWLsLfxxB9yDyYNfzYsQrvD5BRV
         ohvnZuaBmgy8HxdXLks8P3kXLvtDXNZ+rotYKW+PYC0iTzDWP7bsFSl81tze1qtkKeNy
         0QtwsNVPPoRrcYkVj3YqLApLsr/0jCJqItYxrwj+ZUPDH1rOUr+0VLx1ogPCHf81+r/r
         1rSLmrNiIllhRizqrjv7mlIJQBbkxWpEI69irzGxaC3zx1irDEkIgBWQdxfnYT51OAA6
         b/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766263707; x=1766868507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSsLiiSTL2av7klPupKbRan+kIsIZbAf1eXJiOEAwnc=;
        b=saTziemEvcFoETIwPkDMyUdb4x5AmBCuIxVSgog1zbkNooDAVBAa3oF1Bdh7/+e7wB
         QAHUhOfPQ30DC06P84vt+woCSK/VGgwWRgFb3c3kKYaQnsWuTQYDNxk5sfSOtK6OGWEr
         3w9qwySwm4WagVFnIvSaYIEWIdn/rB5Jjfq/SAy1lC7QLcvgytCF5fJ9WCpV67jFOqlA
         Ykr99GAYOjTsMpfNFo8XXPfJxv/SzH1SjoUPP+P1N8scP6CDNrC3rhHS3MSHbCZuDeRG
         DIoSFpQ5/XlbLLMaA63lELB3wnWQEGt9j6MvlTVcnkaNobTql/YsWWV6EHHlXF+/eOUM
         t/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXHxy2zJhlBpXlZb1+rfFPsbRu/NjqwcoiT7BgQ3jxC3aVawWHXe8G8ckC1+Co64PE3tsD6hvzK6PTiN4rhYNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dFbDDibRyhEfiwhqApZCm4r6yxk4rQATEgHy7BiBgRtHo/i7
	FiWDLDFI4Efssk+UxtDRu/MjnRdpD1EB+BPIUJh2e4gITfk1PGGxfxBZ
X-Gm-Gg: AY/fxX7FgWHEr1GvMbFkgAjm5GTLUgy/GI/pc8nZsbxj8qiWGiYout2LFjlGryFX5Nl
	eDcj1qquB0ctx8py1+jIdXcDs4SH0oG6M+zd8rBhcF58i5hIOP79RpoulA+hXEEn0cylIv80bj1
	UMQFqRStdUBSqgl+6+jLntDDtpyG+zCbNxeI1dU80qNyzDu7IEoGM3eyS9abupda6uhY8eh76YR
	e3IyfpH+R5djvEtmxF3F29Bt8iv6Rn2CBU0HJtjXnGdKSes8lPL4cEu/SZNMZvuqR+/IYUKDTaC
	tb5JUhHEY5u43Ghg79zb5kmSaP8/T7fGfa/h4HwGGNIzW1UozP1FHgM+Fn2UWBe4LSz1YgccAmM
	5D75U7vFD7Q625t1jDDRjyn6ucVznhmDMKKeoNJjo8R+ymUUl7N3oftdcFHL/32q20KMBkB30E+
	dRJY4gWMHbXpkdnNyeP25zAg==
X-Google-Smtp-Source: AGHT+IHJ9TDxVg4JDg/3TYZVX5GS4uVFekWGVR8sJr7Lo3J8+b+7PTIbB121gqzYNlncKBx3kNGuRQ==
X-Received: by 2002:a05:7022:68a3:b0:119:e56b:c75f with SMTP id a92af1059eb24-121722f7fd4mr9036656c88.36.1766263706893;
        Sat, 20 Dec 2025 12:48:26 -0800 (PST)
Received: from fedora ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm18097539c88.10.2025.12.20.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 12:48:26 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v2 RESEND] selftests: hid: tests: test_wacom_generic: add tests for display devices and opaque devices
Date: Sat, 20 Dec 2025 12:48:11 -0800
Message-ID: <20251220204811.3539836-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
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


