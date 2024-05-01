Return-Path: <linux-kselftest+bounces-9249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE38B9212
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1221281921
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23997165FAA;
	Wed,  1 May 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGio9w8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB114D9EF;
	Wed,  1 May 2024 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605223; cv=none; b=cdNMkh3QM7kQx7nymoRN7mkXc4VkGYNh0LjLVr9w4eAhKtrnhNB0AANADDT0vX0jEDtKdNgcPTUvV1uEfV8bKA3ipU8F6SCOxS+JuqAuSQG8xv4R2U/zLvaiZcdAxchP4vc1TClWQp0qsl+NIHw8ZnqyKz1gaz9unyWQwDsB2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605223; c=relaxed/simple;
	bh=PoFcIeZkV/mxc2J82vfCM4Z3LKMi/U9yVabayINCqEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbef4nesr2WR2Uqq8uBzVY9q4v+m5W3GfFNg4aQgB0NaJMN5ZlLiMN+zjdpiea+UHvpwufPaT30pdGf93j7PgtwNX8kUz5IKeIaHQSNzuR9EnOP698Egm1VjetUmTCkkrurWn139kQLq+rQMuw0O/uEJjELfpekBV3rttnlbxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGio9w8O; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee3a7cb9f1so1955892a34.1;
        Wed, 01 May 2024 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605220; x=1715210020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6hR+LTCh++HJmDxNTitSkT354S+V0BUkggMSxAqRI4=;
        b=aGio9w8OFdT6tc6FZ4p7MebLg5ALGbAcIO3QUDLqRn84zP2p3EJZE2244QkxYm47I6
         z6VXyYrdmwO0+hZNxQUEwWZlhcUrFLAHMfMHU9rdlaHhi6F7M4TT7uihNQYYgJZgD6SD
         w2xIKFAR0JpN0LEOK2BJD6RBvd8h7Ss6nX2GSKLpJnn6TUQphu50ci0O6lrT+QR9JeVd
         JKg+JL6d+D7SoS3JtrHHTwpv501OGr7NjIDxe24PzVqeihSZVfxDcuGOQR3g4tLhBqeB
         HDClOfqNhKGrzE7MSc6CB24iDYI6qA7rEgRtHFBNVOkKFaSaA7gFDcGOMgzIv4244DKP
         vFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605220; x=1715210020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6hR+LTCh++HJmDxNTitSkT354S+V0BUkggMSxAqRI4=;
        b=V4wkEFhkpq4EHMLce+k6stPoDpNYiHuXjzo6+UpxyUfsNQaBUcaf4E+ZlTe4vWoR+U
         2Oc2dEXJ1nLF0KF2Iw+xVwPIJDdaQzSwVNR00aHOsc5dZumnOeCG4WRsQSdUoQWws204
         G28R0LZAY+Y1hAXTHP7qhFBaOAXo6WdKYhBMscNwvGHcKn3gLKDQxY0SmOSt0GIPaL4/
         oJHxCBoZX0xC2BAbl4uPmeuPQt0lOKu0O+ZrS0up3a2894WKQc6emg59Ez3z/UVLbdjf
         C1KwmUpin/NMoDplYmVglt1cBQBIQX5ZTXmULQHFF31/CO/q9tz28Ge/MpKPeZaueTrL
         7nwA==
X-Forwarded-Encrypted: i=1; AJvYcCVFfdPTDA6h9nnptM0nNwYZP8b4vWjelqku+w7vXK10hU9fbEFDGIcQAR2rUOLp8E145MkSJPeCCeW1ocxH9VSJjNKtWPEuxr8U5HVuoWaY0GESjU09tCDzDll6i8MFIJVM7TQml+vrx6OHEXdD
X-Gm-Message-State: AOJu0YyrOW8X1gWop/dESOUcsHs5k7fpBF9YZPWEWNDBFfa3V+6YYid/
	lPJnDA+YGwBC5IYO8QGOJ1QVNwsi2IPCwVzEu1oqbK87D26eGQH6
X-Google-Smtp-Source: AGHT+IGF40LvLfwKdlI2BiBWH2OfsCP+ZKCXvoGuJrWhVtkss/fRm6OgoMJv2CGbgRhTF1qLa/bZDQ==
X-Received: by 2002:a05:6870:548c:b0:23d:2ac9:1207 with SMTP id f12-20020a056870548c00b0023d2ac91207mr589011oan.28.1714605219691;
        Wed, 01 May 2024 16:13:39 -0700 (PDT)
Received: from kerneldev.. ([171.76.83.90])
        by smtp.gmail.com with ESMTPSA id w1-20020a6556c1000000b005f3d54c0a57sm12997153pgs.49.2024.05.01.16.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:13:39 -0700 (PDT)
From: Saurav Shah <sauravshah.31@gmail.com>
To: shuah@kernel.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	jeffxu@google.com,
	gthelen@google.com
Cc: Saurav Shah <sauravshah.31@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/memfd: fix spelling mistakes
Date: Thu,  2 May 2024 04:43:17 +0530
Message-Id: <20240501231317.24648-1-sauravshah.31@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes in the comments.

Signed-off-by: Saurav Shah <sauravshah.31@gmail.com>
---
 tools/testing/selftests/memfd/fuse_test.c  | 2 +-
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index 93798c8c5d54..dbc171a3806d 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -306,7 +306,7 @@ int main(int argc, char **argv)
 	 * then the kernel did a page-replacement or canceled the read() (or
 	 * whatever magic it did..). In that case, the memfd object is still
 	 * all zero.
-	 * In case the memfd-object was *not* sealed, the read() was successfull
+	 * In case the memfd-object was *not* sealed, the read() was successful
 	 * and the memfd object must *not* be all zero.
 	 * Note that in real scenarios, there might be a mixture of both, but
 	 * in this test-cases, we have explicit 200ms delays which should be
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 18f585684e20..95af2d78fd31 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1528,7 +1528,7 @@ static void test_share_open(char *banner, char *b_suffix)
 
 /*
  * Test sharing via fork()
- * Test whether seal-modifications work as expected with forked childs.
+ * Test whether seal-modifications work as expected with forked children.
  */
 static void test_share_fork(char *banner, char *b_suffix)
 {
-- 
2.34.1


