Return-Path: <linux-kselftest+bounces-33558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A28AC1A0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79973A4611B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7C201032;
	Fri, 23 May 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzGAkXkm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE32DCC1B;
	Fri, 23 May 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747967397; cv=none; b=Nq+pB1BcAZf6BYJKEjFvpyUdye2fvrPAuuBBPmwTrCkV8UnFZszXvYEI4ia1u5HoK70Zfq7IeJIeZwIWRyJ4+xA3oiVK+cTDohlGWK5SpsdSPRVF9SHBz+BHPJQ9riwD8if7tFEDIdGy9Aqo1DebWNoWZHrEUMqwCI4waw99Gv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747967397; c=relaxed/simple;
	bh=/p5QOnAA5KJ7aDYcmscxs4NxE2/gHk0ljkfD71F1HIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tugTo3CHW87J3/7jE+ODocQufKyu1OG/S8x3gWSI8LrIsv4HyMI6baHiDPvYgv05tPdzExiXe437Ijp09c7wWVNQzzwJBZi/PwSheSjGmp31t2wO9r+y0M+R3dV0mPlMyrDOB7NXht8ydWvUk8IgYlx54aRKd8buMv28NCRoGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzGAkXkm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a35c339e95so1062855f8f.3;
        Thu, 22 May 2025 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747967393; x=1748572193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLWLUox7Pkfq1ZKB7xdwPbjb4AeXZLvutu7IKPhQb5U=;
        b=VzGAkXkmrS8cp7RlwRvGKH9offuchFSYlPEmYuZBKgCj0ilzS/lkn6s30UwsQt8INf
         XMpaHIJ/QjVp5joooYjfmllMosopuLP8GbM9zjU6wqAm2YhoqOf76M+4YNUvga5F90W4
         5rUHtajjnjEDck/cW+7lvWCpyhQu7kH7z4tI8oHgLCu8qC8ngLwOzi0KhxkAzRIXs90t
         WXHLxJFNSHUJzGxxfjvU4eIhpEMqXBAHBpCPt+Oj6ftnvd7AnQf/oou5vo407EKDxhQL
         qgYoSN8N0ctyVRGxusHcG2/w7mv8fQxoey5InQgVLuqI2OAr7zMlk1wkVZ2zFN15JaoS
         AXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747967393; x=1748572193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLWLUox7Pkfq1ZKB7xdwPbjb4AeXZLvutu7IKPhQb5U=;
        b=IAiZqfRC+Kf10LmjjHr7Y500CBt50tvg4TOIa6UHt6Q7OYgMxS9sv5LcCJcUnP+K/h
         YyXutIAM/fTf1l9p9hF28r6+8L+YZ4yGneip1zhnclMrX2GchVHogB4YFt8+68sNe8sJ
         vqxc/jaC+lMlNS/CGZav2sykywIcEYYWvHMB4RnpEhh3PlwyXECusHVCdhiconDBMyZN
         RPHqqTeSAtDSO8CJ2eFMYqYjUtCsHqTvPn8VhjpzWlq6PeQTCmE/MWJF46IhLddYcenU
         5u8pUj8eDxoGqP2sm/QEpHsUY/sP0ikRW04Zdr4eZY+aP2aHsunJDm3ldCwzheuiYxRI
         KbuA==
X-Forwarded-Encrypted: i=1; AJvYcCXEiqQ7oC3xUtHn6XbdARMqTxixi9f3dAZvLHF2ku5rMot1Z+9y5sdBeqTBrf1lA8LvFcqgWkGqy1p8WAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypO9jxiAXWztOSDaNto0S05/uaHwGIC/SUTJqEWc8rGgkqA3fX
	z6MKgnPY/FDHkbRM9SLkL4WdV1A/hJIjOZYPhowabd6s4r+4fzCOEdfu
X-Gm-Gg: ASbGnct97FTK9wNxpZIjudfTDz1ai37Vgm9/xWsay3je1igN81lZT0ak8Hyon8bHqi4
	NED4+Va28mPeYvPaF8bOamsuI31O/Xxn+i42cbk+87zsB+ds5bkioHJTkPu/PvkeeBJ5atyAqSc
	r6QbKPZjPQ2urSO9vpy9mO4M6lWnFCa2Wwo55TK/ZIIB9BYRvYezU2Mer8/67fUKW/jiOdDvp/d
	529c6B/DnuEOoLfROundBRisp7N9UdOf0xnB9UUNen14gPaME6oPU5NRAWm7/tLfHBxDRfbQ+ZD
	9mynzX6yTG9alQUScA9Hi4fRopsM2nw18EwKRZo5i4kBWpQXnCuTQuBYd2IZ0D7OfLt6/pkSIMu
	ou3b/7+CIDWKME5j67hGO
X-Google-Smtp-Source: AGHT+IHyEqUJdsoBYcocerfxCARePAv6el2lDNDKFk5koxOH+XVrvNdVbjPzhqS1h5b0QcBiIvnHZw==
X-Received: by 2002:a05:6000:420b:b0:3a3:7769:4f8b with SMTP id ffacd0b85a97d-3a4c2e58654mr190445f8f.14.1747967393380;
        Thu, 22 May 2025 19:29:53 -0700 (PDT)
Received: from localhost.localdomain ([156.208.37.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5abaesm24983265f8f.39.2025.05.22.19.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 19:29:53 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: ir_decoder: Convert header comment to proper multi-line block
Date: Fri, 23 May 2025 05:29:49 +0300
Message-Id: <20250523022949.11688-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2- fixed multiple trailing whitespace errors and
the Signed-off-by mismatch

The test file for the IR decoder used single-line comments
at the top to document its purpose and licensing,
which is inconsistent with the style used throughout the
Linux kernel.

In this patch i converted the file header to
a proper multi-line comment block
(/*) that aligns with standard kernel practices.
This improves readability, consistency across selftests,
and ensures the license and documentation are
clearly visible in a familiar format.

No functional changes have been made.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 tools/testing/selftests/ir/ir_loopback.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index f4a15cbdd5ea..c94faa975630 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
-// test ir decoder
-//
-// Copyright (C) 2018 Sean Young <sean@mess.org>
-
-// When sending LIRC_MODE_SCANCODE, the IR will be encoded. rc-loopback
-// will send this IR to the receiver side, where we try to read the decoded
-// IR. Decoding happens in a separate kernel thread, so we will need to
-// wait until that is scheduled, hence we use poll to check for read
-// readiness.
-
+/* Copyright (C) 2018 Sean Young <sean@mess.org>
+ *
+ * Selftest for IR decoder
+ *
+ *
+ * When sending LIRC_MODE_SCANCODE, the IR will be encoded.
+ * rc-loopback will send this IR to the receiver side,
+ * where we try to read the decoded IR.
+ * Decoding happens in a separate kernel thread,
+ * so we will need to wait until that is scheduled,
+ * hence we use poll to check for read
+ * readiness.
+ */
 #include <linux/lirc.h>
 #include <errno.h>
 #include <stdio.h>
-- 
2.25.1


