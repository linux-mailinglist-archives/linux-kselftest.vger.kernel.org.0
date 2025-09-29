Return-Path: <linux-kselftest+bounces-42593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36FBAA1F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DD1922BA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1D30DECF;
	Mon, 29 Sep 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPaYzQ+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC026ACC
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166287; cv=none; b=TWvjurngH78bsc6oAa3Qm6r0caKZxswJe5aYEhKQtL9Sa9xe435q9hvqVAcI9NysS0jc+TaCgJCRctngSl9DpE8AfjNS7k3y+u4OUMmvYZV1BBlIyoeTf1yakt8KhP8pbSBvQvvazP44F6G8h48Q8UkvN9yaC4AgwxIBPAXWN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166287; c=relaxed/simple;
	bh=0qSC4RP6/Kd/XegjbOpcMoXwRGlnjDzdhRP+zZoREGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5RcFydyblJ8JsnpISq1IjmQBlQ+KUOpOn0YqV86skvSaqco0+TqFBySb8xODx6kzlBZkPtaEmwr6wxZvH3KSwR4E08hOIdfSM19AIXgiItbWGlot53VKQaeVFLB4waUr+a06zB7KOpzegidr4EH3GpIbKWUooSs0j9iNcQVCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPaYzQ+J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78115430134so2621449b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759166285; x=1759771085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8N7+SRw+4fb7ms5sLEv+9Amp7wSRqL4B11xUAR7VxS4=;
        b=gPaYzQ+JVRzWpmz6LgVCQ4TtVzIpRJ1/4lUJamvGHJ/kzTcKLuAv7slhqsuKt2ZZLJ
         ug2N4SIpcOfB9Duekg2BK4GeOUmNrG7csxq02czZPIVQviDQabLbYNU9pcCK4gJtaCHh
         PQP4r+SFFs1dc0FQZvGE42iKE8GlubJaXVc1nWm66cbzOmxAoTTM73i1Ioa3cD6fJZTb
         GDsACPdZ3LHQr0aRR1sWTPYMl+0W65e1nJiGjEyRYbfV+fG0YmkLCB4vrtUw0eGXKiDc
         F2B13/nuJnUZVwoffUJ/Om6SUWnkmgOFIITZMs5wJYWiy+idhBv7PFE3z96tYlcmWIgE
         8kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166285; x=1759771085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N7+SRw+4fb7ms5sLEv+9Amp7wSRqL4B11xUAR7VxS4=;
        b=lI3ig+S9TT4WVxacKSHrtFPU/YYpmSUsxTZKEy9dUN68SO9nilegcFPAUdhH4f5R8D
         O/gud85kLz8rmnc2YJTcDuWM/XJ/PllLk1MJcVwqh4bOkkspQuoWBsoXQhsS3rnclqOv
         ZQHzGuflDJWZ06jNxW2+Nt2lrJ4ry1Z0bYL+aKUNZ8bmBlcSFge10yAB6EcbtmfYGh87
         BpPtaCmtzgMSSzFf9G3+52QSFgjwgg0ehc65cRrDjlCOyuJXY1qqEdRYyXjqmXEmTUnA
         phYdibNGaQBufozZfPx4+QCWhfd1yq5QXRnaoZ6ccwJ6fhgb/dStN2UaV3l1BBhyvnu+
         tx7w==
X-Gm-Message-State: AOJu0Ywy0Tn80eI6qsN0mNXwmEsmJsM7xJIooW1PG/1yXjJfhJL228Ji
	u2XCmOehwB+tV4ppg3pFCmnsrIRVDdo/CHETUXUvZiBptRzv1gOEvJnO
X-Gm-Gg: ASbGncst/dL/qLu8Ne0C1grxBGObBzUWB/GzxGc2+mCMHxqtJXZPiJfKOoKujcFVgT6
	NtXvr6pvP26HxLj62eGLceiFgMDI9Z4yYFUYGDuOWi5km/Dd30iLC+F32uaGi42G8WXvD/6vtLx
	XCK8U4PkVi7TwMLzsSTpIqPi8KwG4A8o3BqlheEjOl1WhmtNAK3jXCrEmRRPHvShyzF4kDPf9CC
	h7jkMUSR6RMk+0lYEIJJHz5LC3WGFPaJw3ykGuAn1wMwRo01FC8z9PHX1nutwTlhm5oOb2ZwHxl
	mvFfS3ghPjpeuZq6MizLKM7shBV8oW1UkWNq2W/NUpSwETP6/E1k+85/mG1glXF5/QW7xjavdHV
	OIh0YzfxhN4Uri5N2Ji9GjmVwGFwSlS7n8GlbzdVhpoPUGtjA3whgBVLHUIaz5QDm8EXnVQDnIQ
	JMf/S/4EQacBPQM5WHvK7QH/g6xA==
X-Google-Smtp-Source: AGHT+IHL57hT26htgxW5zl6/HZ/kLPlAQmFjBSeDtQM6qgZ+ndu0fWXFlgK+6JXF9HYoIRwFSrojRg==
X-Received: by 2002:a17:90b:3148:b0:31e:c95a:cef8 with SMTP id 98e67ed59e1d1-3342a2e148cmr15480239a91.32.1759166285299;
        Mon, 29 Sep 2025 10:18:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14601sm17629314a91.14.2025.09.29.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:18:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] filelock: add .gitignore
Date: Mon, 29 Sep 2025 17:17:12 +0000
Message-Id: <20250929171712.1161253-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a .gitignore to tools/testing/selftests/filelock to ignore build
artifacts. This prevents accidental commits of object files or binaries.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 tools/testing/selftests/filelock/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/filelock/.gitignore

diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/selftests/filelock/.gitignore
new file mode 100644
index 000000000000..410842f05f90
--- /dev/null
+++ b/tools/testing/selftests/filelock/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+ofdlocks
\ No newline at end of file
-- 
2.34.1


