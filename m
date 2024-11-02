Return-Path: <linux-kselftest+bounces-21338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C2E9B9FE3
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 13:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0881F1C20BE8
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD117D340;
	Sat,  2 Nov 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CobOeLfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD46AB8;
	Sat,  2 Nov 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730549407; cv=none; b=ZNHvihDNks4jNaLcS96DezIQr9IKUFDBjBBDV2CC7keFARf7Sic2O0fXLaKyPVKEL8gJm6ZakZfcRnpbfqvdMmUuf8SqVUF9BjZVCq6dYsu/IiVqDzfCsBpoQ3IOzDQ9tQNLrfHSSDUcDQe7Lb6M54ALTuWF/ILH+WCB0+BUiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730549407; c=relaxed/simple;
	bh=wCierMFjGUCTmOLcXeHYu6FDvOE6M0AivVXmNHy3OvA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GzAKuN92+oKVmpVEoNXs1s9A3P6Q8V212AOTPTk02z3jgTAj47oeKhDPqIfXwDPfu8X1iGQECwXJ9prOgwVjX0TFj+uhdhbBXWPOgmpYHXWfPE5sJ6CGA3GWhKZPg1xvo/cW5vmHrpF7sqtRYvBCx1TXRul/gWSUE+hPvdDr99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CobOeLfF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e30eca40dedso2197039276.3;
        Sat, 02 Nov 2024 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730549403; x=1731154203; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddnnep1GVh/a9Y2rD/AHUUIDuQdTwL2dDaSpCymsRq4=;
        b=CobOeLfF8RPPvu2rjmYL9BT9uew/G7DcAnqSJJR2xGtusQ4Z+Q0TSKe95/udZbSrSi
         iIOOKcJp+xaNTJVkzGpD3vYXYTlhLmUK5npB80omPLkA/BXAejKEsSuocNI940rzLbk+
         Y5uB10IgNn2s2G+I/PNo44Le/gYQFwGHMiBwiw+ieHgA1ZRESCM4yIMLDIWku8Az2Az/
         4NMcgYs1LKuYcv4PWrvxZ9rJGMA0JH99bZYf86lKz394McOb2Glq6Q1R0K8z+hMtpMxe
         zoeY898F80R3qxMEWnxry2cJ5ILtdzLHD5+DCySzH8Ky7WXXJzuUqHsFQU9t5oWuufYg
         15ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730549403; x=1731154203;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddnnep1GVh/a9Y2rD/AHUUIDuQdTwL2dDaSpCymsRq4=;
        b=NxqoAfShBFFuvR2yyYxg+fLSlUJ9DM3sE22WUHp0xXKsI9aHAK10XZ72tCWAd14lap
         /JACJAI6INFAevBTAWpttwI1KfZxDFmX8xnKHp6eoTqD19YlUh4l+LaZcv18dYvo44sO
         D57NE5rpB5afNWr7mx7kU0+LBASuAS1cFx71ekJoCTslclfQc4D8opXp2+A1H3Ax9Ubi
         DHQAKkGmtkYubNUyuTOJpi3Lqh3+84uR1R92WpEh5J5rW9dbvLPClOkFPOBfuoJ0YxBT
         88/wYV0+TTkQZAV7nVhvCS3IOgxL9gq8z1xwtuaRRBb0UCcN/HyYaviandXzr4rh74X6
         NA8w==
X-Forwarded-Encrypted: i=1; AJvYcCUdgzKF8oxtE2WnfGAtF2CqQLf2GuViWDDUoci45/EUGRrkq7FFdLlBng3AoS6xz0WDXrTbE5Scxx7Fd6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+PVOvwbdstBK5z8eFkcrZ2U6/lMfugQa6oj0NRgKlQkSCF+b
	gsfE5E5gomCfPSoj8UvHsW5Q5h0n/p4Qp+wj9EmIF9NoYXsAHjyuBQYiISUDCw8=
X-Google-Smtp-Source: AGHT+IEck9jo7+8IH38pwM8sGjcGVmpGBoVfkNdSARMBz0Mvdk9BhCjG5Jdn+URMTut1RqryqH/C/Q==
X-Received: by 2002:a05:6902:20c9:b0:e2b:dd83:6fb5 with SMTP id 3f1490d57ef6-e33025a9369mr5029626276.32.1730549403405;
        Sat, 02 Nov 2024 05:10:03 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (186-189-35-150.setardsl.aw. [186.189.35.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adf9ecsm1139393276.59.2024.11.02.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:10:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] kunit: enable hardware virtualization
Date: Sat, 02 Nov 2024 08:09:47 -0400
Message-Id: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIsWJmcC/4WNQQ6CMBBFr0K6dkw7FqOuvIdh0QwDTKQUWyAaw
 t2tXMDle8l/f1WJo3BSt2JVkRdJEoYMeCgUdW5oGaTOrFCjNRpLeM6DTPBiP4Mj4h68o5AAL1a
 zJay5KVUej5Ebee/hR5W5kzSF+Nl/FvOzf5OLAQ3YnDTh2VyxtvfWO+mPFLyqtm37AqT9aO28A
 AAA
X-Change-ID: 20241025-kunit-qemu-accel-macos-2840e4c2def5
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Alyssa Ross <hi@alyssa.is>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series implements feature detection of hardware virtualization on
Linux and macOS; the latter being my primary use case.

This yields approximately a 6x improvement using HVF on M3 Pro.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Use QEMU accelerator fallback (Alyssa Ross, Thomas Weißschuh).
- Link to v1: https://lore.kernel.org/r/20241025-kunit-qemu-accel-macos-v1-0-2f30c26192d4@gmail.com

---
Tamir Duberstein (2):
      kunit: add fallback for os.sched_getaffinity
      kunit: enable hardware acceleration when available

 tools/testing/kunit/kunit.py              | 11 ++++++++++-
 tools/testing/kunit/kunit_kernel.py       |  3 +++
 tools/testing/kunit/qemu_configs/arm64.py |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241025-kunit-qemu-accel-macos-2840e4c2def5

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


