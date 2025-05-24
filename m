Return-Path: <linux-kselftest+bounces-33737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2BAC2FFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0170C9E6A10
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE01DED53;
	Sat, 24 May 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="hyD0oJ5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AE72633
	for <linux-kselftest@vger.kernel.org>; Sat, 24 May 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748097218; cv=none; b=UGeEz9FFiXfYExJ36pAsQQmbNv/dQn5i7YXg3BK0yGWc1BWB21AEfLHNSeY/qWIWW4L1NY8b/wE5RYk2Xp70illvsD6zlm2lYgGxD41zr8osEnG7zgIVlV02iNVX4DY44zR4qafF3u/haQKZA5J02SbdqrzAraqutFo3YhExTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748097218; c=relaxed/simple;
	bh=9Y2Cy2Z684iV3WCV0FZgOy54ODTJIJFTPgB2qEiELMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OITX1KlIzp7xQkcIHeEvDo0yrg7xXC+HY59f4FyD9yQl1mrryRM+GJcaJNAoTlFmmVCaOHKzF+WAHo3TYOqp8UokRzLch0QTyIQfOen50hvGhLLZWDIYQHSnVObJZbBWdEcWjxBvV3whAsjlvrp1vS1pNfgF9E612cgzFmKMQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=hyD0oJ5u; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4b4Pdy0FpBz9sFC;
	Sat, 24 May 2025 16:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1748097206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GPjhRmUlvUDlyGASnR0b4c9p06n+6EXVDrA4lsSApk4=;
	b=hyD0oJ5ueUot8fDEE1pFDPYK1uG4ua/fXc2Areeu9TrvzjiFwi+vt2MswGFU2+SQ5CIVcp
	osFXnvcMn0ocG2C1TfsZYt0guWMxcPlEZGjqslFhoTRxtT8wTGiaH9rEAzNpgd1echVLb6
	OiZLopTFjZTRslEh3mRrOfu/fVptoUgbTCPaaihGuoQIKJA8On+PZPNltiYy6+XalbZThb
	Fh03TuagYMi/0QSfS3t79g15JTs7mc8b3MD3dLN01YWPSkRMzF0xL6CV4FdsBs7ajdufq3
	OCVMJ+BBdBM4ZWPHzrfmJELERCLM+EER2zD34A4U5JVEtliDOoSjOgg9thBWFA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-kernel-mentees@lists.linux.dev
Cc: linux-kselftest@vger.kernel.org,
	brauner@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 1/1] tests/pid_namespace: fix pid_max test building
Date: Sat, 24 May 2025 20:03:18 +0530
Message-ID: <20250524143318.6528-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With newer compilers the pid_max test is failing to build with the
following build error:

...
pid_max.c: In function ‘pid_max_cb’:
pid_max.c:42:15: error: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
   42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |               ^~~~~
pid_max.c:42:36: error: ‘MS_PRIVATE’ undeclared (first use in this function); did you mean ‘MAP_PRIVATE’?
   42 |         ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
      |                                    ^~~~~~~~~~
      |                                    MAP_PRIVATE
pid_max.c:42:36: note: each undeclared identifier is reported only once for each function it appears in
...

The fix seems to be including sys/mount.h which brings in the missing
defines and missing definition mount function.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..96f274f0582b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/mount.h>
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
-- 
2.49.0


