Return-Path: <linux-kselftest+bounces-42542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72401BA6160
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E4189F978
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B425C2E54A1;
	Sat, 27 Sep 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX2pRive"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED22D8DA6
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Sep 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758989525; cv=none; b=uxvIEk4SOzGLCpDtCn/hBYWgTu+NVqYQKNnbt316bLr0FFS0mfyJmlNTiAC6VCVcNRG4STmQkAJamIwB/z944/N72/Ue7gAvrmbMIn6EJvZthGusyS0hvsF7WciDSYzOm+FL0pqPwwpwr/IIgkq5kD1Pk1RjGPPQJw+2lUTNnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758989525; c=relaxed/simple;
	bh=FlXf6A6U1TCoVupOp52iYngSL0vU7uTOEMTo0EWklfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXWEpWic6Pd2t/6re7zaKqsg5H7IVddxtGdLE8CL5LNmr2sb6f9b1kS0ubNi6afj2hZQivYBdDSIjH1eI1395GZpIQcAPf3AIyCgEGOpWR2qhAIF9bVwpklyHYi6YjLfvLLOo0E4A/D8775cjuGoKUU6edN3oGzCHfpKDvmcO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX2pRive; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780f6632e64so1646268b3a.2
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Sep 2025 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758989523; x=1759594323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05pKpEscySAPey8grE3bZC2pVMoFVZAK0WHxujOjSYo=;
        b=YX2pRive8RdANpuf1yJX/LTUJ696kiObKLl9uwo0ue4V0zyBCBsb38V4wJlhI+oLIr
         CuPLEssH+2yTD7LSMYyKfJuaQBEyZdp5wnwEycAj1WU31JApsPTtYcsMaxjBW7zcjFAV
         gJneuGSJXAjg9adZuT7yYFU+4ly7/OHu42HjVstTMl+XPuBeTJ7PGi/CEznc3LiUyxW1
         V6dcXNBNrh2s0OJwyok+vxh0Qesq+ybe6vmiTl0Y4CUxEwqJyiLz9yk3KZmopZzCuKJh
         wl+dAOVO/9tLBAarhpJ9yHVCDBs9SqGA1EjD+cXdHG3VLXpOZgeURiQuOCSc1f7XCC+D
         /ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758989523; x=1759594323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05pKpEscySAPey8grE3bZC2pVMoFVZAK0WHxujOjSYo=;
        b=ruzdJS/eBDAtfd5D/irMf9aWKG7/3SPaubY7GEvllnhYYJ9dnEMrCdxxS8R0ynlJgd
         tLxXSTRwaFiZqzeM/UVo/qRzJEhtlwv3ukTL903WXTv10qK/zvnBXTV10ZCXOPuQtGyg
         JX0E3q1euCLezSO3j8YPyvvtV/bGaEBqYJhmb587xNoNbXeMf1SRnxIKdhb4aO13bxwK
         IM5FQElzzno8irgn8eiRqrgfQixO7eRFUq3X5RX6AVS2LXkWyQqLnH9ZcAjWl6GW4iOY
         78GM0RIdR6OcQpYAjkQOJ411cR+MCuTFpzQXbSoNQIH6cY7QALE4XU6aLRbxIzV7EI6l
         H5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXexcnPVj3cfDQvDkqjA+Tdd1uVhuriTHcdXdHJNxgeW+BBG/3T+5iv1xVshhsGdUhMcraF8jY2ampoR8Fu39o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjk0S5qaLJrCIYg/oBCVbkhmaZ9dMA8URGclJZkw1zD6e7vDxC
	T7hyUOJpF4gWhlOlkw2HuJaHlmkj/aMR+HwYVPxM9Oo/ArbOj4YP4rCZo6B8H1JD
X-Gm-Gg: ASbGnctob+JE8hipo7e4uu3cLH/SwwnJIhpw9KggPjyw+SwrDAWjMmXelnt7iBTeGcE
	IL1yfmhmBSdmCPxKNLEeCF1VEmU6cBMon7bPLef2/CDb6B4aC/6jrnPq8utOK3xuolfR7mdUBRb
	QwUsaVFeH+KM8BTL+p85F1IqgHNhgeYs9Bz1CbemXI6OtE6jT08E5RrHf/KFGUsJGPk9avwDGKG
	re5S0TW9r932E34e/DZMnsVSpwdGEXmauEcQJgeDF55S7hcKjOLrpj5UZODSzazdcoKvPFZ+FAi
	v69lqYiAOwnrlB68cbcbQmSlSx9m6dWVYev4DxhgHWiqa3Q63KYOpaqgJNIY7tkZGmTyqpxRRzV
	cLMAGcBKuyfVbJLbWNfcc6k4Yf7+OcwBbXaocgzlP6v/U/Q==
X-Google-Smtp-Source: AGHT+IER9UtAbZFy+Mmh5AHdXm0Wzu9fDKzm4dGEnBECZaMbz55UHuRFnI6Dg21XQP7946L7Wqo8bA==
X-Received: by 2002:a17:903:1b28:b0:269:ba8b:8476 with SMTP id d9443c01a7336-27ed4aea2abmr123050575ad.56.1758989523418;
        Sat, 27 Sep 2025 09:12:03 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm84420365ad.103.2025.09.27.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 09:12:03 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH v2 2/2] selftests/cachestat: add cleanup for leftover tmpshmcstat file
Date: Sat, 27 Sep 2025 21:41:41 +0530
Message-ID: <20250927161141.778631-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cachestat test generates a temporary file named
"tmpshmcstat" when it runs, but this file is not removed by
'make kselftest-clean'. Add an EXTRA_CLEAN entry to ensure
the file gets cleaned up properly.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---

v2:
- Corrected subject line to describe "tmpshmcstat" as a file, not a binary.
- Refined commit log for clarity
---
 tools/testing/selftests/cachestat/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
index 778b54ebb036..c48065d791a9 100644
--- a/tools/testing/selftests/cachestat/Makefile
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := test_cachestat
+EXTRA_CLEAN := tmpshmcstat
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
-- 
2.51.0


