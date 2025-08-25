Return-Path: <linux-kselftest+bounces-39843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE5B344D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A4B7A4356
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE352FF65D;
	Mon, 25 Aug 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gIFGIof/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281CB2FF66B
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133886; cv=none; b=hnFjpetUtfoWiG3GcYMdwF+OWANjgGNDdjCeF2YLPtTuABRKYhMCfP5SiQhNrAlJwpI1FRI7HF+8cNL4/0fzH1+hWH4ifMxvO2MyEeE2n3U5rE2hIrEZB/J34uBP9/Ewgj3/lejYkOIsXsL8YvEETzfAH0ReM/B5sD5qey50f8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133886; c=relaxed/simple;
	bh=5SQHOFh1sUDEoQa/LsWjRDqFRqBAtXV8PziERqMxVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnUs+t1OgXNmTxMRcWgQyMcBfYu+zmfBseZAsNXR1jrjhF/aDRQvfWdeMTOzIlxk+nxeleoVLWusJoPxn1Q1mkHTwF9dg61c6HvagGGzuSMwbjADK0dmH1/29csRaKBGpJepqv6f33Fed9tOmhH6deB+UGO09C/exg5PG1hVCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gIFGIof/; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2194127a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133884; x=1756738684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=gIFGIof/9cANOhAxoLp/qDYt4MA2YVPp1dfTiF4O/hThF4diAtqxE/Y4FxZlveDzex
         WvFYtB9I/4V6aciUdgOmLYMlmVug/fYbPaIGKm2h9WpNRgBf4/Ckcjjmn2bRY1dNNHop
         1svP0al8Zy7SpqnOUiol/QmLROkle3wnJ9Jy0tzZnNtj1M/1QnBpDQcOsMgH7a07B560
         UPjdxeUNNQT3ohD0ONQVnfWlkGnWbAkiR/uTwzrZHq5Unl32b5lUKpyYiBiD6lrJf71o
         EGQ4bw9w56OpWgE1G4QAUwRWc5hIBSHVgc8YGeK5aGzt6brh/+ZdgGEgXKFF7hdZytCH
         3h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133884; x=1756738684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=qh+4GEx5YCoIQU/JCyLUluEt6tATZEMweYJtnLmSwJW5KEUwBzjd0f/DQ7GfyfPLq9
         m8CSzaPw9QVadbOnKZFjFO2+4Kit1btPvlkbyYPi+/DDFyaWloiq05UXugcSiFWs46SO
         tMpMhH+NQwTefeEzGufy4apqhFPIgh1qy5ReWJHX71DbqWL/7v8tlnrHbXViUZCvZE+d
         OIcZKASYgVV1fBgInDNtlZQBTGOvpEwPjLjY0Ege/Rh+7Wrx2EHcEqnuS8mGMUXRWaMd
         ii09qOioUIlmzOahV8mi8xql5u5KN0whix4JkTDnBnn0b1yaBUkjdgZcNbgREmgCbCdg
         v7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcm82yi0Xz8h5A5U1+dwCiydzNZ8G6FzPOngSc89ZkzEkWTbWUPZPi0YuZ5wr7dHm3AeLXqGtbHGiHCsLsgDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdp+/9Bg3HoRhG8Y4LJzKEHb9ATYtGX3A1NceYyarN4yYNAHmE
	2A9hBm0zn6/0+NIg3UM8wJBzjHaWj4xK5G3UBXSmx6ZBgBjsQkif1HYw3TjnxxNuHk0=
X-Gm-Gg: ASbGncvlnhAxkFkzcd2/UWIZVir7ccsqOiuQE0YWIrjH3HldjQR+K17qD4PrQ8IwEQo
	rSg9JMXbUw8VABssN44hTmGJ2NX4qQBYnnqS3lFvFoOqTf14ZjhqSBmtQMZFo7p5+LMftnY4U56
	iwBANVwJA7KNWzVy4Q3FSMfh6ObsiQ8Ds5oMUiuTDUdOLhB0RTab1DmKJIyXRdMVbWdYz/3IJd8
	GUjRHlPcfekGfVSV+AqIoGUZEP6SXoHBtY8rabnvslGtzroGDQ0lopaXxGvcIUMKU5PWiABSuh2
	grnQMSKV5j/kVjcfG/o3Z7S/JGlpZZVJCpPN8ODF1NFWqgvoYdw8P0jTMifS4XB2dgEzvAFxImC
	KOg2dfMt6RMLqion35qULA1f4OqO/iiq7+hbvGMFzApa6Sal8JRLx/asGGLGN
X-Google-Smtp-Source: AGHT+IHCWW/ShQpQHuPFTA6y+zNShKRdJnkteX326IPoMfo05QiaIWxdBNx+Yt2H9gYmCzshpIHnBQ==
X-Received: by 2002:a17:90a:d60d:b0:31e:3d06:739c with SMTP id 98e67ed59e1d1-32517d1988fmr15265101a91.31.1756133884241;
        Mon, 25 Aug 2025 07:58:04 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:03 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mshare: Add selftests
Date: Mon, 25 Aug 2025 22:57:12 +0800
Message-Id: <20250825145719.29455-10-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets up the selftests project for mshare and add a
'hello world' to project.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/.gitignore |  3 +++
 tools/testing/selftests/mshare/Makefile   |  7 +++++++
 tools/testing/selftests/mshare/basic.c    | 10 ++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c

diff --git a/tools/testing/selftests/mshare/.gitignore b/tools/testing/selftests/mshare/.gitignore
new file mode 100644
index 000000000000..406f31bd432c
--- /dev/null
+++ b/tools/testing/selftests/mshare/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+basic
diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
new file mode 100644
index 000000000000..651658d091c5
--- /dev/null
+++ b/tools/testing/selftests/mshare/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
+
+TEST_GEN_PROGS := basic
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
new file mode 100644
index 000000000000..482af948878d
--- /dev/null
+++ b/tools/testing/selftests/mshare/basic.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+TEST(basic)
+{
+	printf("Hello mshare\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


