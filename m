Return-Path: <linux-kselftest+bounces-31739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282EA9E276
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFD41746A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF823FC66;
	Sun, 27 Apr 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWTN4r51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF5189B9D;
	Sun, 27 Apr 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749617; cv=none; b=Treri3j6Et+MNRwHXlyXBB4a4/625iUC5F/8JvGY4H66v6QFzLlI/ETkR075UaDNBsBFPRyaxdc5ZGrAiplDa9+z8I/YUsY1wh4fxge1fBoWiqUuqUA8R4JBl9HNQvJcOXj/0GBmhuDkMeJMyIiZnGynOGm6B2X9IQp7RsSmsZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749617; c=relaxed/simple;
	bh=L/7d+0sCrBkkhNvjbYbI7sHyU7E2+1tFiqTht7ojsAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XM07ApzHLm/1LFmDxHNoSpLgcHB8VtcHE9KIK83EHeQEpBRWyvys4gN5MGQtdw14c0Gzhe7AtNEewWoKoYzYUDDHHayfJYuTS8V4R6bKtDM6YyvLjVGSstiZtqoqejkutJ9dynkPK+NZOWz0Qr7utT0WBkCO/jfBmPPFgS8qMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWTN4r51; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-af548cb1f83so3985412a12.3;
        Sun, 27 Apr 2025 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745749615; x=1746354415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG4wi/dNPtItNd0KVOI4rRQ1RlH3zfmT05+Zcy25VSA=;
        b=DWTN4r51yQSkmXrMvorjiweu3Yt2FuxyJ8cnYCTRxCe73Ole1pTGtoDeNZIZQM5o61
         /sjOthSn69iLVF1AUmylX5QTIP414Vj7HBv/XaYvWIUNuBMt2ZbDsD8/0NGEPr5Xyv2k
         TpsT0LsrN71/6ODsCkGC2oKWH9coPaSkn2n0QdheyG9W8Nvmh5lrRxZnDnhsBCr00OXQ
         H3rDn3ABoB+xt5foUCbuVNJjQzQMNRfWvM1mDAnIqFc0rqvr6IfbzPAUlKrrTx1bUXpQ
         UkXe0DIBNi1Vo1d8uzzuS4gnraEWv+cfMY1c8di79NQKXHcSdY+oxo1DePIqBxvVcSgb
         lvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745749615; x=1746354415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG4wi/dNPtItNd0KVOI4rRQ1RlH3zfmT05+Zcy25VSA=;
        b=LPbB8EDc2A6PafptjRaX5T7eN74idT/NJqCNzKh4Jn9ivA+1Bbkor9qDfT8US8etWQ
         GVc7dPMmJwgYAxSxPjRgfcl+piq64APsagOiaEW0jq1C8qviw7deAjNhXug8kaaR49of
         lQbpDr5ZdLrXj85NygOU38bHCWdvzFHDF4ETKfnr/qtsn4E6TP7tRB4YQCBdfQqnmq5I
         e58kaLuZLgm3PdeId2jwctQP/EQfIf5sgQBO291yudz3A1hySyKO90xynHe52sbJ5ZEC
         RIC6NiyTkGCA9Y2QCQIZZFP7mVxdPZ9QarLOKNFyWu7RiBsPx+Lkv+qCWIQ3Xck4XCOz
         Xq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVd/4pdvXmRRSRdee86Uj7eXjNJQXaUHmpETOUlfIGrujCRywoWu+Aiz8df41rzrbDIm1f8TSYSt1NnoecvXpq@vger.kernel.org, AJvYcCXozU3fK70AaOXjJPTmzDefhsXutv2CGP8gHMGGPYtSm2sbbCi4Dea9tEqj46vG7GGBGn3n2CD9aRqmBm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVQZUgQhEGbQ5XqicVImA6MGigwGGyzzhPHH7BMcHoq4P4x09
	rH4gAaQhI41W4zSDrM+0rA7cu1fKdAmXXpvxP8euTlGJ4VNd9wKt
X-Gm-Gg: ASbGncuvYkXqXATxqvuBub/Kvzq22PX8hjEDA3f6Q0WAWVQDvXMEgUW1rGddE7FjFOF
	7Lsb4qn5FQDq8Zimcl/BSw5CbB6mYz8wzK37ZwWgoWwu0NskRcjeK8cx8cG8eTmd+dJ/6pwQjsi
	SNETH/+agslV5TVOcx40+d2jRu5GVIt1i9m1uRPvtfVfXSQ0ByjpxNr2ulvahUiTwQlvpq+wkUC
	xALpY1vhXvfNS0h2je91Mlslq7/VTc3cf2aNBbgnuFu3ZjNnS2pQ+wN/o1bdt46DLCA+HqAwnE6
	jL68TJhTxNEdQiptVM1sSFpLD+77yE0cl6QRHaLaIsTKey8PJHEo4wSlrHE=
X-Google-Smtp-Source: AGHT+IGUa2Tx/EYX0ogpIqp9guU98wCtywVQo/NXZ5wFhd6QoXBDnQgp7Xjl56+ehyjTtG3Uj0Ld+Q==
X-Received: by 2002:a17:903:3d0e:b0:229:1717:8812 with SMTP id d9443c01a7336-22dc6826e1dmr85333375ad.0.1745749615424;
        Sun, 27 Apr 2025 03:26:55 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.229.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221677sm61672545ad.248.2025.04.27.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 03:26:55 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Siddarth G <siddarthsgml@gmail.com>
Subject: [PATCH] selftests/mm: use long for dwRegionSize
Date: Sun, 27 Apr 2025 15:56:39 +0530
Message-ID: <20250427102639.39978-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the type of 'dwRegionSize' in wp_init() and wp_free()
from int to long to match callers that pass long or
unsigned long long values.

wp_addr_range function is left unchanged because it passes
'dwRegionSize' parameter directly to pagemap_ioctl, which expects
an int.

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f..5773666f07ea 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -112,7 +112,7 @@ int init_uffd(void)
 	return 0;
 }
 
-int wp_init(void *lpBaseAddress, int dwRegionSize)
+int wp_init(void *lpBaseAddress, long dwRegionSize)
 {
 	struct uffdio_register uffdio_register;
 	struct uffdio_writeprotect wp;
@@ -136,7 +136,7 @@ int wp_init(void *lpBaseAddress, int dwRegionSize)
 	return 0;
 }
 
-int wp_free(void *lpBaseAddress, int dwRegionSize)
+int wp_free(void *lpBaseAddress, long dwRegionSize)
 {
 	struct uffdio_register uffdio_register;
 
-- 
2.43.0


