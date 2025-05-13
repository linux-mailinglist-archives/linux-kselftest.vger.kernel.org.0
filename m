Return-Path: <linux-kselftest+bounces-32919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE0AB5F4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FC0865D7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675F1F12EF;
	Tue, 13 May 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIjoSA1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA978F43;
	Tue, 13 May 2025 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175570; cv=none; b=iOws+2Hot0jPsrBMOoSOoD90O3/ymYl19aenKfEN3hASQwY6pWPTrZPtljToFrzfy7B+Q4mv1HpcXbZon6hwaVfiT85Kmeanh5kT6o+28jC8IRboF1ftdcnlnZqJmHbLddVlxIgRt5MZ6hwWH4V2EsTnnLs6BnZGpIrJUZhws90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175570; c=relaxed/simple;
	bh=+3XGKK5tSVsAG22kTR01LPisOgKQ8LKsZXwmHszxcxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eLobgYen1R1Dq5P5gvURBuPHGs5U/OBq8hzoYz+PlhyDM2l9+Pv95h866d86p2Gw0GLrlm1zkksH+tpXGoMbpfOJqo9r9BeCQC3DkdrLD/4REkiXw/Mi0x1As7vJtHo84TM9SK+D+Xxvi7lqqztvSiBQS8S+QnDUULr5NtwzyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIjoSA1X; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b4907a28so917457f8f.2;
        Tue, 13 May 2025 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747175567; x=1747780367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOO3+D38PGP2XKKbxPd24Ou4JSZM80XieSsvghMwa6E=;
        b=aIjoSA1XtOiCCp5zdAvy+GcFYApso3NSe50rN9mlgje5lxArWouMPnIRJ7170yBEgu
         wR0l0AhqzgMYoW7aslesVMB5UMPcdAOtV166TFqWpVrObdxzbRbQcMEkr44QpFgQxiZT
         H3CGQNsUbSK1XFkpwvwMtneQv7bMBKofwoK95c1ctoE2G9+D3afVyD5XBjBmu3u3iNdg
         /7kpsMdjJjxtSKjumDNjl/3yLMB9hzVqQ4rruwwJAszdnEyztV9XHh75lnpi6MjosfQG
         HGdvXnNnIJ3VSDA9ZwUqHK3S+ZeYx4evf4mQ9sc+Ho3lQvSo8vGeSQpvXwrFCEK4WpVi
         JGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747175567; x=1747780367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOO3+D38PGP2XKKbxPd24Ou4JSZM80XieSsvghMwa6E=;
        b=FfdQpAnY1/cIKdeXTcfTX5FE63FG3uZV+seH+X2WO0wbEnBp3DbGOifovowqe6adV8
         0KNGUyzJ7pbp+2gyEJkFGLHcCF1Xi2n7aFwtvmEzWDaDidULnnSAiPkbEzNtvL5dhf10
         1ghcH3RthQ0xiKxb7PQwCh6C29q3srudlDKBKRa9cYOxkZlAPQ1YW/RXmFk5+FqFjfGF
         d8pPYzFIsDMcvfo4ilHdEhRkobno2bKz4Vv/U/D6JtYmpxxRK7YRRXWXvfvVq4uY6vGf
         guvb+467nPphM+qPbL+ZR3VDnqTnOYAIrOcFk1ZakdiQRCNNGras5xhBFBspQDwDBtZf
         tAFg==
X-Forwarded-Encrypted: i=1; AJvYcCUTLJN90fAFJg+NN32g91SG4RtYWbZhSY2p0/ZlbfErvHkfFr9+IvJt43ckO7CkS0jeymZb708migyvgwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJlDxQJcwcvLwPUfgW2BD4V7jhLM3JGZ2h/bqaEQg4pHhFDMX
	ukisVLI4u6s66ULNZlqFZMl48p3c4N4m8aZQrPbeJTyQJ86J0gHB
X-Gm-Gg: ASbGnctgCjXeCG6mRTWShjh7irjFyDYd/5AJkGnOS6c4Xam6eRpUUZRESvwT6SJsre3
	JsEmTh3V0FhRgdIJOWEOyM0C6n8JcSta5LhssZOsBO8FdVoaCTbo1qO/b30tTp8H+Nw4vuY0nyK
	rf3HVfU9NCXfpiYFc1fiKHP9SvZoP2VivLhfw3i81XTA4yONKc8187VgkrLD37+pdZymdfjZVec
	KEQFHCEsy5NqJWBR/0s72y9vOrfCHEhFQyJHa21GgRJvquGa2mxXo8QMw1wojpjm+cvR8M0Hh9L
	Sze9W4++Jj4+RJGhcDCfLCJzeXs5viSfaPO0DWcbR7INM49ebVkREc7uKvDAbYyRJQEve3xTUeb
	EXS98o6YceOKz
X-Google-Smtp-Source: AGHT+IFXJLpwx5PB9w07pxqndJCIjz+5sTL3g4V+/2gtwJv10YxYnXtbMmFVW1vbDCGtifs54FlzCA==
X-Received: by 2002:a05:600c:350e:b0:439:a3df:66f3 with SMTP id 5b1f17b1804b1-442f2190f43mr2271575e9.6.1747175566477;
        Tue, 13 May 2025 15:32:46 -0700 (PDT)
Received: from localhost.localdomain ([102.44.114.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368d1csm3849195e9.8.2025.05.13.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 15:32:46 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
X-Google-Original-From: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
To: shuah@Kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
Subject: [PATCH] selftests: ir_decoder: Convert header comment to proper multi-line block
Date: Wed, 14 May 2025 01:32:42 +0300
Message-Id: <20250513223242.304716-1-Abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test file for the IR decoder used single-line  comments at the top
to document its purpose and licensing, which is inconsistent with the style
used throughout the Linux kernel.

in this patch i converted the file header to a proper multi-line comment block
(/*) that aligns with standard kernel practices. This improves
readability, consistency across selftests, and ensures the license and
documentation are clearly visible in a familiar format.

No functional changes have been made.

Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
---
 tools/testing/selftests/ir/ir_loopback.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index f4a15cbdd5ea..2de4a6296f35 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -1,14 +1,15 @@
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
+ * When sending LIRC_MODE_SCANCODE, the IR will be encoded. rc-loopback
+ * will send this IR to the receiver side, where we try to read the decoded
+ * IR. Decoding happens in a separate kernel thread, so we will need to
+ * wait until that is scheduled, hence we use poll to check for read
+ * readiness.
+*/
 #include <linux/lirc.h>
 #include <errno.h>
 #include <stdio.h>
-- 
2.25.1


