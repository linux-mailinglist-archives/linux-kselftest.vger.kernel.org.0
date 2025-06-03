Return-Path: <linux-kselftest+bounces-34263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E30ACCFB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73A93A5730
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4122F755;
	Tue,  3 Jun 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5d4nNSw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543F1474DA;
	Tue,  3 Jun 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989163; cv=none; b=QSSmUdnAXHvnBUYjQ8B+LwUYPO/LHkh75GhCOBL9s5iZMoViSxghA+2BYpi/727DC3F7MzRRPs6XNJTEkfi0FFdMoj0SJQy9vOksFVkExz4gMYDAl4ReSZqd5bDQmpb2TByqJC2VmV1Ffe5O43Re7uIj4Yhxqujrb4rnu2iVCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989163; c=relaxed/simple;
	bh=JwN9ELcSUl3mBJxYBcBop1epVVw04UgyCIZK3jECD2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rZGwSDAbJO+47ZxuOw4JdJypm4gXnc2fQgEQu7MwSoTyEe5XVRP5lKNAGDUZFSCcGeJ0qIQZh81Nm4OXru4De50vXwXZdEUyUskxVR6t7RKOdT79YAppMdfwdfl0nsWg13yt2yWayMhazfeH8YNx9YNTAd/NwfCdIO5OWRSldUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5d4nNSw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450828af36aso2926775e9.1;
        Tue, 03 Jun 2025 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748989160; x=1749593960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2MuCnQmfuymAmGE1q3a3tLJgIKf+tdHvWlxHjuDCBQ=;
        b=I5d4nNSwStdK3moRruzaQtExXzpHFl+0kus5EUc+XpkCMWfJslZDAzA70B1soCdQpO
         2vxxpgdCupndGCviCdtgeDS4CzEFFs/L8SdiOhuvvOQJNDIeUC5duTb/jAC3WGEUUm5A
         DP15xHWPHPUyBWn0Ioqvb1VkvaF3pY14BzrqvZBGS7aVd/pGsd7+E9SvGk05Jyt0sJ55
         c+uvD/3kjbj5eoV9j6fQoM2z8yNvennfW0xYGt2OSp4d85z7vIXOXNOoaqxYfRYF81uB
         t00ZOR+Ph4g719Fyqv22DjvoQpZGJItsf1zM8m7qLInCfN4s09wRSez+y6gcURNkVqzX
         7+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748989160; x=1749593960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2MuCnQmfuymAmGE1q3a3tLJgIKf+tdHvWlxHjuDCBQ=;
        b=IgGdt5cUYV+JoOgAfg3wWB55AHPrbZcDXctBCgOXjUqCzSF2bI9jJQMnf6OqE8qouh
         qdObNouZSoy7p9zVt49YgipLky3Y9W7IUWa6dVgFitSAkleQk1RDbjcanivINddNM/jC
         6MTMtXjHilN2OlW4nud1U0ttWELQx7Xa08ZsdCcqHpaQEkMroEImNzGi52g9OLP96shS
         tbqfoqhA0hSawqZbZavpmn15yonJLe7vyRXu/X+8pGReJmTwjatAhDApolEPJvWsnLD4
         JfDYMi8XKAM5SfvmSq5oxC8ExJzGTTYbv3sK2kBHdb4AM4lMdRNWcnRBEl5MpjBUlw2L
         67fg==
X-Forwarded-Encrypted: i=1; AJvYcCW6aFUdKEWTRQtFS4foqY4FSdsZRt73z84CPEq+BlgE54dMUordTw8ZTgUSZ9ANCyJ4xYcwdb5hNuFsT7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3XlPiPqR+4j0RcAJmElPV1W7u5P0ZAARLvFHBJwjdyk43zC0
	/goChvtYVU3ywxtDSilbfHaCLN8SIlRG3Ki4oS4OwVQxxB+z+13N/LsG
X-Gm-Gg: ASbGncsS3Cx35ozZnTAL0szwkK/wce9iSvWGrQ3vlfYFqxylVL2dnSvodiZomguBEhR
	qtVFUzaiRs1bo3+FKN6/Fo0IvQbjv5o/L8otg14r6MNR1+GDJi+Z1w905M4eRWeXLWGk9j7jvCJ
	qhY5bKFUeeZC54o7SUFFsz045fk/Gflp0wTxqjm7YADS8iYFp/CQU4cD5Dlmeh1mRgCbwfhPHRc
	wqhx2EAbZecJ71zRmQlqupkR54X2DiKUwhIfuranpERQ0kcsiltkhiJw/9ln2entovM8G/v2OYy
	XALJ1d1wcqEv17HAGqhfAz/KsDuRHma4+T1btSBwuqQm1cWJgKk6sBhG0f3fyyAbvPzssIDs6AB
	Z85F7FK611Mc=
X-Google-Smtp-Source: AGHT+IEIY12wMUTGy581egmFECqQyjd34dT25No79UiTOYop0jzYJJ+YqVBbCRVZR1wEJPb9MQQJ3g==
X-Received: by 2002:a05:600c:3b86:b0:439:9a1f:d73d with SMTP id 5b1f17b1804b1-451f0b40015mr969025e9.8.1748989159063;
        Tue, 03 Jun 2025 15:19:19 -0700 (PDT)
Received: from localhost.localdomain ([102.40.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7facf9dsm171215565e9.17.2025.06.03.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:19:18 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: ir_decoder: Convert header comment to proper multi-line block
Date: Wed,  4 Jun 2025 01:19:14 +0300
Message-Id: <20250603221914.102888-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

well, i checked the script using checkpatch.pl and
it shows that the patch has no warnings or errors
and its ready to be sent

v2:
- fixed multiple trailing whitespace errors and
- the Signed-off-by mismatch

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


