Return-Path: <linux-kselftest+bounces-45710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E3C62072
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 596E034B122
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E031531C8;
	Mon, 17 Nov 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSgQZMVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A481F19A
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344051; cv=none; b=M60PvSHVoE0vDnlWfnL1JC3dmYPei4LQ7NHC7VbeSNIuHKKwAEmPm0NHLIC7iblBkhKNW5NvN0SCOmjPLyx+UU8JArWhOlcr9aLA5wb+29l98INb614rIpxyxHbP4Gp2oyRSBfFJjQfEIKutTMVButWhjXUCLGpM35s1JzzSvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344051; c=relaxed/simple;
	bh=ci1MJqonUW7+fRPgF29LNM4X1wJ2QmGrj0EhSyjLDd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdQDr9K2lcY4M+/D9sehafeYWmh4domIb95juZI3C63e9GAys1Hx1K+XZCdcO89wAKlQdSO1INMFFjvOVVY6yELu2SdVx1XXnSh1KjuPOr3+t39+3awMe1zqZ/Dj7CzQswtFdCRElSe2nRmR5ki8FCUkgDvR27XDlUgLGN0A5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSgQZMVM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc169af247eso3354962a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763344049; x=1763948849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NN+0/WXQ+hiU5DStJXAkgWAwjWLdOPrrNQUogMgbThM=;
        b=ZSgQZMVMnJPP38v1HH7sJaqxeM6skxHKst0sC2Ab0lOVYIwzgKHwbAsetGq84mp2A+
         LGqkhDm9f6R5hjtS0B5Zw4ci5SjxxEUUQ0UrW3VAIgyJKq1Eb1x/W0x4FKLxmfX+vZBv
         7QVJQ0p0GY1cHAecz6yXABDTr1KS6q0xxV7TmtrPjOaYm62O3ozAu24Idjh10PcWC7LL
         2uAxMEjVzcphN3X2SZ5hX1Aq1pNZJQ+35g6Dk1FBTRNlCmBWUCT0Ga/NXXA9Mw5NhBmv
         EJkNdOntncBxJ9bO1nEvGh30M3zv8qWSiNOvYuwYXo1EuNblBtpdhNm8yHoDgRVXzcEL
         gnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763344049; x=1763948849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN+0/WXQ+hiU5DStJXAkgWAwjWLdOPrrNQUogMgbThM=;
        b=SIsCECit6hShVX6Sd4IbRpEMEtwrTF8pMRBhxQvotXhi0jdEycLbi9ZNkIXVuG9sNq
         gZxnLrXjPGZ/xSy2U9Q3Nww+stZOhi1aI7K9fkoiCny+4m+uRXQucIKNOn6HRcQVj62S
         Otfe/Q7H+K4DFTRGYp3qPSYzScQFBlLT8PFsk5aK+qhiiAoRTN7Y8R4m/WiSC865JPfL
         5X+D/8oDSV13e1DqRtJ7SYNx9ZNBBzNXZ24zPdIgTUAEy8s/9yiIU8LiXXQ91+xYoDyi
         jwLpdkXf6BmDezkZ7rO5RhXZIa9LKdRS6OLd+sMq7MSnJQgGeCjPU7rC0QJ3Spg1WSdN
         FxGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYnMpwwcvklWt44L+nmfEzEA3cc+22yy6W+xV19kDZu/KSJJCetxs590xPDeTlZPTXe+RZmd73YrLQARJkJAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgcIV4ywBV/jfrddWbA937B6v21kZjr0SXI/OQrO0WU16g2gp
	LfYQfBUN1t7icU4n/m/8/S+r8Kb0RhsfI+EySAW7il4/hyCkiE7KNXU+
X-Gm-Gg: ASbGncumxnTosA0Cnux+UuwUo1s25pTYR8Luk7LozZD/Rg+yyrj27Ss7Q5VMtMfu27y
	WHHrL0nFJnKTDnkChG9Lvo2l/kY9brRLPkXbj3b1X1qcAwsmbxgfoE0XIX9ZrZVe86FnGHUWHbn
	LqjYErE4DEFim5Bmu2Lma2gzzvXAqCb8uOTx/G9aTNmtRw//XRYunBNKiekbg9qAjmpvZ1BpWcL
	FuBG1TZNCOuUy0sp+/3IJGsbMGWs67YOBmdDQ0EsgKnasu4ZYTYiBsgR9Dj9DMNoOyjtVk+IN3s
	4wPxh6Xke1CpibZARfxK6JDuIuCBB1yi9mFC3IDSxTYkn2MgdAosKQ/vk8UuwE6Z1cqD5x4J4uZ
	9OmfPtCSppFyS7QoFhwrSg9MRp3P7fhEKFT1fa4DWrhttS4+pi3ZnGVYBMzGUPkmsqKPWmGQZeD
	PD
X-Google-Smtp-Source: AGHT+IG9DWYfri2RoAj4ysET577lbaipDwCtVOsVcnfV9nDn9tuThKae221+nKnKPpNTGD8Rd+Nq2A==
X-Received: by 2002:a05:7300:ae1c:b0:2a4:3593:9698 with SMTP id 5a478bee46e88-2a4abb330b7mr4686136eec.21.1763344049417;
        Sun, 16 Nov 2025 17:47:29 -0800 (PST)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49da0662dsm42088815eec.2.2025.11.16.17.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 17:47:29 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] selftests: hid: tests: test_wacom_generic: add base test for display devices and opaque devices
Date: Sun, 16 Nov 2025 17:47:21 -0800
Message-ID: <20251117014721.3142490-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify Wacom devices set INPUT_PROP_DIRECT appropriately on display devices
and INPUT_PROP_POINTER appropriately on opaque devices. Tests are defined
in the base class and disabled for inapplicable device types.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 .../selftests/hid/tests/test_wacom_generic.py       | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/tools/testing/selftests/hid/tests/test_wacom_generic.py
index 2d6d04f0f..aa2a175f2 100644
--- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
+++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
@@ -600,15 +600,17 @@ class BaseTest:
 
         def test_prop_direct(self):
             """
-            Todo: Verify that INPUT_PROP_DIRECT is set on display devices.
+            Verify that INPUT_PROP_DIRECT is set on display devices.
             """
-            pass
+            evdev = self.uhdev.get_evdev()
+            assert libevdev.INPUT_PROP_DIRECT in evdev.properties
 
         def test_prop_pointer(self):
             """
-            Todo: Verify that INPUT_PROP_POINTER is set on opaque devices.
+            Verify that INPUT_PROP_POINTER is set on opaque devices.
             """
-            pass
+            evdev = self.uhdev.get_evdev()
+            assert libevdev.INPUT_PROP_POINTER in evdev.properties
 
 
 class PenTabletTest(BaseTest.TestTablet):
@@ -622,6 +624,8 @@ class TouchTabletTest(BaseTest.TestTablet):
 
 
 class TestOpaqueTablet(PenTabletTest):
+    test_prop_direct = None
+
     def create_device(self):
         return OpaqueTablet()
 
@@ -864,6 +868,7 @@ class TestPTHX60_Pen(TestOpaqueCTLTablet):
 
 class TestDTH2452Tablet(test_multitouch.BaseTest.TestMultitouch, TouchTabletTest):
     ContactIds = namedtuple("ContactIds", "contact_id, tracking_id, slot_num")
+    test_prop_pointer = None
 
     def create_device(self):
         return test_multitouch.Digitizer(
-- 
2.51.0


