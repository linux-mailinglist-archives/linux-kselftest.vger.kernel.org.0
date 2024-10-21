Return-Path: <linux-kselftest+bounces-20230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C319A59A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 07:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543841F221D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 05:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CDE193426;
	Mon, 21 Oct 2024 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyGVEeP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F52C95;
	Mon, 21 Oct 2024 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487235; cv=none; b=ew/7pi8+LI0I2NsHkxp2z+oJpSyT1hXqSrqcIY4mc5dye8iU1etDzd6+kuNJksgTml3Us7j+9DrxP/2SBGDjlz8slIFN1XetGta6ckhQj9yMQzDebQ/xX2er0vNSGtSq1bV3cNxX8sb5fyJ70yVw9e3X7lk6C8v+Vcr7jBT8KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487235; c=relaxed/simple;
	bh=woaOYsN/8ZXG9JhFaJM6yAMQs5wl0uO6IyPDHccyzQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jbLqiu/e0Yeh51z0bK1SLzZEbO/v8ApGm4fv7tS63y/639p4UFOsELKb8rLtUbUJtCo8L5O/X9rWmS9bwlp827Wy32nv+K+GOFu63IOsZpwRBnBZj9ZGS1bYzIm65O67ZC6NzB5GsPlw42y7516qbVdBMP80hNppDHnANN5PYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyGVEeP/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so22717285ad.1;
        Sun, 20 Oct 2024 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729487233; x=1730092033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsP1R/Yrt+r8ODdOs3dcZNgXib6nhIN4eckNsin7BcM=;
        b=UyGVEeP/p/2ZQfI//b3ljbJ51NSm0ZNuUPlB9hsDNtN7XW3R2U1qRgSrGfsCvUM8wD
         EQBcogFRJ0hwL3yYNeGcJrO57I6jfVpIntzhyBV5Hr13QckQEMQ2+JLCgUT4+LtpYf1m
         dv5PwjkFBA643MkwF7w2gLgFvjoTHMdiYmJ9U45Vn8WTDhYGXl7y/ExqylKxXlEo8cwe
         Murw50tm6uGujCXLlZoEghvaTsbXs/P0WMSWhHs2aWGhwiJgyvLlCRrKo9aocXvPebUN
         SklQbd/SrDf5oHanI6MATzyYkf08yhy+0wKmGD2H7sUR+6zxErEx5VnBpEv0sMeF0mp/
         P5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729487233; x=1730092033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsP1R/Yrt+r8ODdOs3dcZNgXib6nhIN4eckNsin7BcM=;
        b=GNLkwDqrohVFTlyPn71+PppByGhBcHSw+SP4RgZ27Iz77a1sMZD4N0enR1eJ9Ucim6
         NpBlhdnNX8auL/ZTjqqmSL+CBa3JWYUqFVFV8rkIOUBb5NJbdqfyj11x2NOeLV/qzdnv
         +EKuqAfwLqjgGRZRrmQhryypVgwxku9/6376wus1/dh06hOrZ2VximphRSnk4UKGsE7p
         tasj40UECiKtHUZYavKz6WzOxnD+g1NQ7ZNGqUamensahAl3/justd4k2g/PTMzYOG8F
         sB3zl2N3lgQ7F3RcoXp9E4B3W045QGKTMlS1ATh9y+owdMd0ULPBIur4i6mV43NUBwhr
         XN6w==
X-Forwarded-Encrypted: i=1; AJvYcCXc5yEoNMahY2Qjm/XQ+PDmSYKEAVwxRM/YBIZtuvxYcxeMhaOiGPsXCo7AdRa2D3hmNIzloknF1CZRV98ALto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBvAD7Uqugc48XLZrwDXoZOfpJZfYRHZYReOPVQgfN94/R0js
	ZPysoYOeKUOVdDRpzJ93CMq7kjFtvbsOR4YEqzaxTvY3BlpEcQ6N
X-Google-Smtp-Source: AGHT+IFcGEUucg5M3GUfi1Fqig/AMK3OEQkkhQYuQQUd6DCdD+Ozly5nqrQxwfAiMC2OLfQ4u5NJkA==
X-Received: by 2002:a17:902:d2d2:b0:20c:68af:a4e3 with SMTP id d9443c01a7336-20e5c29b02emr127570975ad.22.1729487233374;
        Sun, 20 Oct 2024 22:07:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eeef550sm17693565ad.57.2024.10.20.22.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 22:07:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
Date: Mon, 21 Oct 2024 13:07:06 +0800
Message-Id: <20241021050706.29403-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I compiled the tools/testing/selftests/bpf, the following error
pops out:
uprobe_multi.c: In function ‘trigger_uprobe’:
uprobe_multi.c:109:26: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
   madvise(addr, page_sz, MADV_PAGEOUT);
                          ^~~~~~~~~~~~
                          MADV_RANDOM

Including the <linux/linux/mman.h> header file solves this compilation error.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20241020031422.46894-1-kerneljasonxing@gmail.com/
1. handle it in a proper way
---
 tools/testing/selftests/bpf/uprobe_multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index c7828b13e5ff..40231f02b95d 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <unistd.h>
 #include <sdt.h>
-- 
2.37.3


