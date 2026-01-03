Return-Path: <linux-kselftest+bounces-48097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24CCEF96B
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39593025F84
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E6262FC0;
	Sat,  3 Jan 2026 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UqSxpcmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBD23D28C
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=Gd2VptCLxWPHtwZO5G3KKPtSkV8ThS2Du6Kwa4FgNbjqGV9VULphgRSHec4KAXFI96vyTozV/Ew8YU82cLE9t5yX+8Wvk3Df+m4LeFKXo13T9LYPnbKUR1fU/t4My2QtmnERgnqlD0hUv+zfIl/7EeAx2V67cRYHhbSm300wfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=ZSzLYKUPhGsUobh2wC8NY8isXzUtJcpaIt8dWErFwBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBKIQLSJY6YW28Ppla+EENCJ5waoH3IbcSuAXnJyiK7OMqaUDrdmrlrvh9LvKlML30V38ISCEfkcCRdqGuRaTCiLp25WS4oFLXfhMHp3y3LwZrxflHFodhrbY3iQ4tYuj0ikhNEDlt9p4O8d3uN8FFm8YJosKK2QhlJTQ1SC1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UqSxpcmd; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6447b403647so1651330d50.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R8A5xPkV3IeduJQ3FDhSVHeRqV+YNzn9A5NxRqrJgc=;
        b=UqSxpcmdRQBEUd/3QmIiMK39Nl5o3R+gLKeyRYF9geXZQtGtFBrFxFNVOIQo8RGveE
         bSkTRdYX0m8WWQChZCmFyGXjH29L2AwWciTzXFLUhUp+J5fgWqKxKmNHPY26e30ENRCF
         JxEscjOTG6UkuSxTCahdD0XJwK8iqtBGJPPoPxo7RnrNAoN5J0xIjDRfcWNA3m9qZ8p9
         gNm9lAS8jk7CMVvyJUEKCkJrtZ/G048ns/IHAl3z4nguy2LUnZ8UCEwuorgPy+/3Eqts
         2dEWb40WvoI0WElZDHOdVqHcMVUQlwTQ9p6bYLSEAaOtik2C+TYdlNP548jtJEuwPJam
         IqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R8A5xPkV3IeduJQ3FDhSVHeRqV+YNzn9A5NxRqrJgc=;
        b=oSit9rzBlrNmhVDPbGy4HXK/9z+6lfXa+NvR92FGkcWWfjCPMYCaQS160hBhZJmwjV
         TKRB61PD08VhJWMLLpv9Ek+L5QDvScXTJSwrW+wSvbE8DUnJwS7pyr2g2rpd2m3Ilhsz
         BFAmZCGtByclHmdkajnFnxkjA/zJP2FM8ubGF2DYbvzTrzXym9J8fSiTPnN7egvWiWiq
         uaUF/Jf2zUld5nvrUtV+QDPMLojylzy9mWB1pBs0qIDTQVuOldrD2LioZVNOuK9kAcFi
         XPsJ9sfgw+9+ivJY4Q/rwy+XYjkGKM4l9o74jn+Kqc0rZE5vkRbjUcZMDfMLnquRTJiR
         9xXA==
X-Forwarded-Encrypted: i=1; AJvYcCXxk19VtQY7fWfP59Lx3dv+vDSz2KgJOp61HbSvsTBBHwwGY0u+v+jfOyvfrqIsPc6DyHJTccTg8OTI0wKFZ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bF6zaVU1M8NcabziAWW7VBBKZQkOV9JlRWrq7/CRoL2pMXz1
	mEjyAD5fPv3YmwuqkgEyxKqiarwAHmy5iNNJLgLn+kHM1fV//vvUJ6Ltw3MZUz0RsWrKzxoiq25
	GEDSBxOaREEVS5U8dmrqy+97H/MHqJSAGzxNDqz8ktjem4d70ROqR
X-Gm-Gg: AY/fxX5TArdheHqiBu+qtUBsu6H1y3HF6Jr/hlfoHD+V1EGQUK9dBsIgJxxsC7hX2Oj
	LI8iiOQ6dL6Ly0HcNJyQaGfL+wqlnJbEVnlip3iWdDcMUF63OyDKIE90riEeaJ4YCfddKj5OD2N
	T10CRFRFoBj5rtYmP6DZu6YiCNBwUIF9w0TLnGWpshQ7HJzEEqT0ppA6Tsr9/3CV9lyJTzOmf1L
	B2sWouRrvC72rUZnSqAzF8SLuEC1/7j0tD8hgfuPpw7OwlwsbsZEGIm3HlSFt243bFpZXXc61cC
	D8C1RR3AxQRpxjjUojqxgoXY04Y9JEUp8qixr74irLOKZyZxQDmyYO+ZZzLRLuqmuS9gZzvOoNO
	FlWllW/AQOr/Hj41WWjBs8UJo0GQ=
X-Google-Smtp-Source: AGHT+IG8e0ZZfW+lu/gruxYzr7Rl1uVpSHQgdK3pJYfY+125TFW3ptE8y9OXsGfdXlr5Zj3xy7LLASN5fq78
X-Received: by 2002:a05:690e:2445:b0:646:e25d:cc21 with SMTP id 956f58d0204a3-646e25dcd2cmr963833d50.8.1767401134512;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fb4539795sm20084837b3.27.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9D77F3420A9;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9A63FE43D1D; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 10/19] ublk: support UBLK_F_INTEGRITY
Date: Fri,  2 Jan 2026 17:45:20 -0700
Message-ID: <20260103004529.1582405-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Now that all the components of the ublk integrity feature have been
implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
servers to create ublk devices with UBLK_F_INTEGRITY set and
UBLK_U_CMD_GET_FEATURES to report the feature as supported.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 82b193d63583..8b2466b5de07 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,11 +73,12 @@
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
-- 
2.45.2


