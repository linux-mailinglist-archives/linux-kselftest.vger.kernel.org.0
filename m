Return-Path: <linux-kselftest+bounces-17508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75219710F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663EB28270A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EF91B143E;
	Mon,  9 Sep 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVhXFzGr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F731B655C;
	Mon,  9 Sep 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868633; cv=none; b=CN2VjmQSnbn7wupMfkOyyQR7nDRobJTNOwR4pPYp5vl2ukDjUQrE7gzhJ71qfnsOGagvxvJBltIdPelctJgg6JkCt+ofExIPUBYrrQJ0N5+mPcNsak6GH3/btq5/dBi7WI+C6JMEqrSnvK7HIDX890UPeVD5+RPB5bd0FRDzfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868633; c=relaxed/simple;
	bh=+YkTkQsCc/ElfgFXQ9fK2Ix48bUTDK80E7WaH8Zz54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYj0g4u62oXs9nhJPV4+SEm8tEleep7Q3oOGLHWsC1fDLEcnatPFPT1ddc1bt+PPozM583FOFAQt31QOBeJBZiz0Oi6h6PvNXwpgjm/lRGkwanvMgVellVms8hzQ/F5L4gUvbvIwmCNkl12ISYYdNNxFwEosR4sbNXcWmEQMzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVhXFzGr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c7e64b60so2351766f8f.2;
        Mon, 09 Sep 2024 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868630; x=1726473430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ/CxQk74jojRioxhgvCcab9AFX1uIzQFXWshuJb0bA=;
        b=dVhXFzGrmOLED1ZRWExuN8pGwNzOUINNy+SOAoJWOuUKusJI1GnYcLRvGWM4/lPtgd
         /yfrRq2Yth7K0vPC3SNdkHdg0vw3jOm7/bHnLnKdxrcZjigGENhJc3RD6lLxysJRNsR+
         BcyYYNep9W13GUkr3QFwLsV9xcFEJyCv7Tzx/SQ6mexIpYJ57RzMQULPNeMv5aFOOYvN
         8UH1TJc/e+W/+CKvGHuFlWpGZET38ZpXFTiGhcXZ2k2W9+ldF+iLBQ9nRaLyhF0eG8w8
         3ycDBXI4teTgVb+NhQNQm3zyy2inoGYO5y0XKgy+gIuqDGkMAZpvrZYdcGuZ1bhMS5XB
         qPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868630; x=1726473430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ/CxQk74jojRioxhgvCcab9AFX1uIzQFXWshuJb0bA=;
        b=jKkipBJo4ttsI/2+3E2GuQRhbABTvoAX2LKp6B485zwe1FmoZxrMXf2Wj9DeA0jX9h
         d5u29VwCCZWZcKljNsm0IzbnWFuhwVhV8bascl8WDIUayQmYfibbNsmzH7JtRLniCZ9g
         goWCOJuyFks2gGSs5iu1qRexpmkWU0qIR6s/bFtiNinz+PQKFAwCD2UVzVkMR96U3OIP
         0y0/NiJTb5AYA+Zdtemmp7bff+Me9SMo7QUBIEYXvVuZbaYiQvHI+8U50/UquQ88MXiz
         /B0x40CWVjCKLrTyuiuPcMoRxDIOuFse13GvVGEsoWcW6LM6uIyebDl56EBol+2T/ZHD
         57lg==
X-Forwarded-Encrypted: i=1; AJvYcCU3qAvBnSqPd94eVHBaR7jIEfUeaeTPmNzV8AdQVB0UFGkgkglnXeyo4WcTB8GeDxjcCgIANFWxIQmK2QS5@vger.kernel.org, AJvYcCUOlp3ygXQZLzdZPb9CWNwO1yQaGlKycwVEv0KmaZwFxLpB4PbOVomedHIRgYbQPlMlZI7r0N7kPtelF+8=@vger.kernel.org, AJvYcCUyay8AceaKUKZXq5OoqsvSF7ypCxrXue5EyyrtOJexFBwQNjpmHMwyijwTg4BzNLwGXwE/Nr8uBBTbCcTsQJ0T@vger.kernel.org, AJvYcCV10pL0PQIFH3qN8MOhJaBkZDqCLblA9bNujD5KwkCPCBgEgJQT2+DwEr2mYXHoXWHvTA7WNTXx8B2S7I2H@vger.kernel.org, AJvYcCVLKB45PVDQViFVBbxq/oxrR4/XQqn0PBRBRbLI/odT0YuyvKTqq+p+38JFSAswrYYlc9PzbkdCc81D6g==@vger.kernel.org, AJvYcCW6os/v/9z/FgAi7fLsWE1O2UG1ZpMx/ayiwADGelPd45Kg+OjTNYTC5pNzSjYv2UhESDA=@vger.kernel.org, AJvYcCXLG3yVGpGmA4zUqZbYS3+Oea3K9ROUffbX6fgugLWXXC549NAKCzj/AGxth/+NYG/i4I27Xw4ypvWsNugwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvHn5cFpb/wiOUwGiL2IGWDnmjTr/I5Mb09AVkSJ0XGA52VeS
	M+U0oqFs8524yXam1ghXBCC5S8cLOLis3LHccnHLGz6FTOBAYvnN
X-Google-Smtp-Source: AGHT+IE10L70PE21eNLD25lAB8aBB8jSN0E1SHrHS6kqOQxmGH/7X/EdRl1RCvLCQcBxps/pONHtBA==
X-Received: by 2002:adf:e8c5:0:b0:374:bf62:bc91 with SMTP id ffacd0b85a97d-378895db711mr6586624f8f.25.1725868630119;
        Mon, 09 Sep 2024 00:57:10 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:09 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH RESEND v2 15/19] lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:58 +0200
Message-ID: <20240909075641.258968-16-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Pirko <jiri@resnulli.us>
---
 lib/test_parman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_parman.c b/lib/test_parman.c
index 35e32243693c..f9b97426a337 100644
--- a/lib/test_parman.c
+++ b/lib/test_parman.c
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/parman.h>
 
 #define TEST_PARMAN_PRIO_SHIFT 7 /* defines number of prios for testing */
-- 
2.46.0


