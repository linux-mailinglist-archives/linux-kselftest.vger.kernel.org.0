Return-Path: <linux-kselftest+bounces-20207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB309A5208
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 05:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BB21C21623
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 03:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6A3209;
	Sun, 20 Oct 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyI+m2Gd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172ABBE40;
	Sun, 20 Oct 2024 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394079; cv=none; b=b0xuYgwE5rkCqNqf8TjRcU52yLcuYK2L3p3DceihsUDCk7IkMBAnRQb66A9zF9cIvFAZcZOp37gErMZMkdGDv4yVVz7xGseH9wZ51eB2uMVvl6Gi5ONBus1TMImK4jHuHMx3UTPfBR9UxMvRtwXZbQRfdGJcgYXib5lO9hz9A08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394079; c=relaxed/simple;
	bh=qaPYNCZLDShnpAsUhIsPM324e6qSDcpIi4sUEwnS/PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eALZuARrytD8OYAXOIDMr5FS7FfhICTI9bvoR3Z74YKHTxRNzI80KUYvIWzyDhtzP2U6E+bTSNe82FsWfgd4j7rZ6evkItGImAxEDRJCux2z3d9xKaVQZd32r7AI+FDSnOulXXjuJ1c4Fmir1UjsCwA1aqPFkLaFT9LskvNZXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyI+m2Gd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e585ef0b3so2685408b3a.1;
        Sat, 19 Oct 2024 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729394077; x=1729998877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3KhY9DlhPOzQxVu6Ypnl189jFpbkIDSyUOnSOJA8JM=;
        b=FyI+m2GdtjweFLjXQKELMTIeACpZ5kn/h4ppK/X+zE3yvcmYApNJiojpsx+RbLsoMU
         UeA7+c9qMd0wHrKdi3WENaT5MVn3eiECd1DpXNbRNAZ2mxYxWsYQb0gZo0c9oLgfylDo
         D2uZhgHp7PfZPUuQZ3MQkWhfHRgfd/BUZOiIp/xfvNo1QQOvGsYURC/qIDL7qwdHAHM1
         j9i4sgT7rp5CYfaPT5/acrokOtygqFySOKJ+OomijX9UiaV86pGTusuSTkVaeqP9a3cb
         W0NqX4YU+dLj6LgPUdlLCggPqBQanBEnjPuMSHaGrsTcG5A8FTzCgig0s5Wc+8P1sxOA
         opCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729394077; x=1729998877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3KhY9DlhPOzQxVu6Ypnl189jFpbkIDSyUOnSOJA8JM=;
        b=dPuGyQlXoh/X02Ha7+2yH6ylrxEJF6fvewdQepZth1QJmiFdm6kMhD9Sbxkj61D6DO
         4GSytXGO2gyVm0VRpRFST88nrKQVXQG+1YbjJLfZcxjZn+cS6GY4rBzeGzy4q15yhHqv
         2TfiQzjYFn/xrsUAyPIczIMj2D8aJpQnGTlVJ8H0/HVqLQNXkA2PeGWpRxusEjYr5oCd
         nsnsYP71Xj4KJjJLn3KMkOfEIYlfjDcoBc2hhwkZQWL3DPZ8wO5RpBrWSkDaPqqiuZFR
         LIZQ9Td1KaIjHQbrMTNYxOOobNAVieCEJWKlE3J4KpVlFleZgDGpdp6rsByIv/CbJUsh
         QVzA==
X-Forwarded-Encrypted: i=1; AJvYcCViljpBSppAWNqI5tIu536WCitedrfJ7BdRGZF+EA2r2hFFJBlyR+zPfN/fS5kOYkrDNwOmLN2D/0DeQ9t87ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoIK7zecPd+2Qk3ue5C58ZEQFdvgzknbco5LgMkkg2PbKdw3OJ
	gNBddFNS8OvPj6usn88NnhYfrbpxqpcbHd1i6xhyP7kYqybVQPPR
X-Google-Smtp-Source: AGHT+IFNWC/DixKyJO10qn9DABG/XpiA7F1Kh2Ua2/z+g3A5U9knER8TF9pO2I6ciEQ/FIVZlqwJrA==
X-Received: by 2002:a05:6a21:6711:b0:1d9:9a9:7dcf with SMTP id adf61e73a8af0-1d92c4a30f0mr9569964637.4.1729394077011;
        Sat, 19 Oct 2024 20:14:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407801sm432372b3a.196.2024.10.19.20.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 20:14:36 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
Date: Sun, 20 Oct 2024 11:14:22 +0800
Message-Id: <20241020031422.46894-1-kerneljasonxing@gmail.com>
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

We can see MADV_PAGEOUT existing in mman-common.h on x86 arch, so
including this header file solves this compilation error.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/bpf/uprobe_multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index c7828b13e5ff..b0e11ffe0e1c 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/mman.h>
+#include <mman-common.h>
 #include <unistd.h>
 #include <sdt.h>
 
-- 
2.37.3


