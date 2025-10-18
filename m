Return-Path: <linux-kselftest+bounces-43454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F9BEC19F
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3751408CB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953D8F6F;
	Sat, 18 Oct 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEabLOPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A8354AC3
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746051; cv=none; b=QftJS80YHAt/5ls9AM9s0oCghJ7EyA423jrmSTrvA6vvaDhInwP+mwXIk/JBC08qhqBTOF2w7JzMphw7j3t/ybwpRC3wuypOXffkl+yDTdbyUiBi4Ox8AU0HV3UnB1lP8HgAEqCikhAzFJ+vrRSbCjpchzmehb+Sey3Zaj+ISL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746051; c=relaxed/simple;
	bh=J9W4VofzNPHVJcydvT+7yYMBRwGznJMzR/aHNqN3grE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ql4ckVsAj0oUVef5e8NBiU9wISLZhPDYREwDjVKLskzzyOmj22FY6j7fdxT3ovNP3dQUzmrEOPXPzikGOV5Q11nI6QIq2qBvBPiNUv1a+Q8l4WmTC8z9jriwjR00KMLpOXygI/wwJaFRj276iXuXbRRA++AZ32/h9wW0ZHkAn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEabLOPQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5516e33800so3398653a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746049; x=1761350849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrXpTUXsPRdectGWUXdK6/cWMJ1EivPtVPHR+juuW6U=;
        b=QEabLOPQUwbbLyMxpVp3U0LZmIJklkAhqX6/xeKJuJPje/Eg4CBGpcc7dQVSgYK3XK
         1pxRZacq3zM4Fsapzvt6F/7cCvlVUHfqdjRjphlJBymj6eX8uLBhkJmGyDTgttr34f6/
         qdMGOKZpeTwrQben9U8Xi/AvX136X2ygl1i+WVRj1n/1A0XjXTw2TOGEpdvrH/TCXCgb
         UVqnXsDaIgrSDJgZsrZha7czFF6MirNcZzkE92T5EYt6ZZkvqSyy/l3anKg1E5u5ZoOg
         PF9xwe2yywCoyy4j8kyCZuT7R0CScKCcwjVNX5NVtRjOk7xrWAeVfxbxGNYuMbOlsdfj
         jWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746049; x=1761350849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrXpTUXsPRdectGWUXdK6/cWMJ1EivPtVPHR+juuW6U=;
        b=wqcrOxj/TkWdC1lCHYApC/N7UJOV/5WSYMNF/DMvej3QorkPAYxJaFodaMJsp8BE2N
         yxHx5mqVo0azcZwwHl2MV5pe/tbs+ChKNw+0vOT81kBwzbgNc3W1zOzwkiMh4FSnkQFk
         HNLXGeIZjrMGl1OWl0Ko2rEOKBk+fF9AS3Eq9AY2tOl1QZjXTTra3bzaFuDXMTPViBXF
         GSbKXomHi0BoNo8lUL5bXf2aJH45NVkFxfWdphZKUf2HbraLAi22bLzwDnYE/O2JkqpE
         3rs5mhOaQQ9xeUDLBeQ/2L+XK9L7Nwe8WZ2xXY+zzYJWR9d/YjPft9BNMp2McQHAK+P7
         uvAg==
X-Forwarded-Encrypted: i=1; AJvYcCXjJpsJo0TDOpfFOkEnYDZU7iLPoaPxDbwuxnR9/n2N27daXOHjdZh9y3uoRu7DMvZY1y1Upr4d1nuzsTW/qVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzGglGMQrJ5zYWm38gu1iiW5ii5uZJZ8sCvwDJI0RwVngAvLc
	b3xWafLnCLmDAUx5z7dDW3BjKI0xz2aHRDThfesyhiVbLVK/mtglOmJxHOeinYJBb/w8mbELDHG
	J0E0bgXOAjw==
X-Google-Smtp-Source: AGHT+IHW64ddk30kYxy1u6aO7zkiAGN29Y3gtXXrzh6xaAbx/wQ5vxDGnCf0Gb8SvNpdO7t14/3mEhrMGD6V
X-Received: from plri16.prod.google.com ([2002:a17:903:32d0:b0:268:11e:8271])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce12:b0:279:daa1:6780
 with SMTP id d9443c01a7336-290cba41dd2mr64939455ad.52.1760746048654; Fri, 17
 Oct 2025 17:07:28 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:06:55 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-4-vipinsh@google.com>
Subject: [RFC PATCH 03/21] selftests/liveupdate: Move do_kexec.sh script to liveupdate/lib
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move do_kexec.sh to lib directory in the liveupdate selftest directory.
Add code in libliveupdate.mk to copy the script to generated
libliveupdate directory during the build.

Script allows liveupdate library users to initiate kexec for liveupdate
test flows.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/liveupdate/Makefile           |  2 --
 .../selftests/liveupdate/{ => lib}/do_kexec.sh        |  0
 .../liveupdate/lib/include/liveupdate_util.h          |  2 ++
 .../testing/selftests/liveupdate/lib/libliveupdate.mk |  1 +
 .../selftests/liveupdate/lib/liveupdate_util.c        | 11 +++++++++++
 tools/testing/selftests/liveupdate/luo_multi_file.c   |  2 --
 tools/testing/selftests/liveupdate/luo_multi_kexec.c  |  2 --
 .../testing/selftests/liveupdate/luo_multi_session.c  |  2 --
 tools/testing/selftests/liveupdate/luo_unreclaimed.c  |  1 -
 9 files changed, 14 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/liveupdate/{ => lib}/do_kexec.sh (100%)

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 79d1c525f03c..f203fd681afe 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -9,8 +9,6 @@ LUO_MANUAL_TESTS += luo_multi_kexec
 LUO_MANUAL_TESTS += luo_multi_session
 LUO_MANUAL_TESTS += luo_unreclaimed
 
-TEST_FILES += do_kexec.sh
-
 LUO_MAIN_TESTS += liveupdate
 
 # --- Automatic Rule Generation (Do not edit below) ---
diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/testing/selftests/liveupdate/lib/do_kexec.sh
similarity index 100%
rename from tools/testing/selftests/liveupdate/do_kexec.sh
rename to tools/testing/selftests/liveupdate/lib/do_kexec.sh
diff --git a/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h b/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
index f938ce60edb7..6ee9e124a1a4 100644
--- a/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
+++ b/tools/testing/selftests/liveupdate/lib/include/liveupdate_util.h
@@ -11,10 +11,12 @@
 #include <linux/liveupdate.h>
 
 #define LUO_DEVICE "/dev/liveupdate"
+#define KEXEC_SCRIPT "libliveupdate/do_kexec.sh"
 
 int luo_open_device(void);
 int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
+int luo_session_preserve_fd(int session_fd, int fd, int token);
 
 int luo_set_session_event(int session_fd, enum liveupdate_event event);
 int luo_set_global_event(int luo_fd, enum liveupdate_event event);
diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
index b3fc2580a7cf..ddb9b1a4363b 100644
--- a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
+++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
@@ -8,6 +8,7 @@ LIBLIVEUPDATE_O := $(patsubst %.c, $(LIBLIVEUPDATE_OUTPUT)/%.o, $(LIBLIVEUPDATE_
 
 LIBLIVEUPDATE_O_DIRS := $(shell dirname $(LIBLIVEUPDATE_O) | uniq)
 $(shell mkdir -p $(LIBLIVEUPDATE_O_DIRS))
+$(shell cp -n $(LIBLIVEUPDATE_SRCDIR)/do_kexec.sh $(LIBLIVEUPDATE_OUTPUT))
 
 CFLAGS += -I$(LIBLIVEUPDATE_SRCDIR)/include
 
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate_util.c b/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
index 1e6fd9dd8fb9..26fd6a7763a2 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate_util.c
@@ -30,6 +30,17 @@ int luo_create_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
+int luo_session_preserve_fd(int session_fd, int fd, int token)
+{
+	struct liveupdate_session_preserve_fd arg = {
+		.size = sizeof(arg),
+		.fd = fd,
+		.token = token
+	};
+
+	return ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0;
+}
+
 int luo_retrieve_session(int luo_fd, const char *name)
 {
 	struct liveupdate_ioctl_retrieve_session arg = { .size = sizeof(arg) };
diff --git a/tools/testing/selftests/liveupdate/luo_multi_file.c b/tools/testing/selftests/liveupdate/luo_multi_file.c
index ae38fe8aba4c..1a4f95046c75 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_file.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_file.c
@@ -7,8 +7,6 @@
 
 #include "luo_test_utils.h"
 
-#define KEXEC_SCRIPT "./do_kexec.sh"
-
 #define SESSION_NAME "multi_file_session"
 #define TOKEN_A 101
 #define TOKEN_B 102
diff --git a/tools/testing/selftests/liveupdate/luo_multi_kexec.c b/tools/testing/selftests/liveupdate/luo_multi_kexec.c
index 1f350990ee67..5cfecbc6d269 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_kexec.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_kexec.c
@@ -7,8 +7,6 @@
 
 #include "luo_test_utils.h"
 
-#define KEXEC_SCRIPT "./do_kexec.sh"
-
 #define NUM_SESSIONS 3
 
 /* Helper to set up one session and all its files */
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
index 9ea96d7b997f..389d4b559cb3 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -8,8 +8,6 @@
 #include "luo_test_utils.h"
 #include "../kselftest.h"
 
-#define KEXEC_SCRIPT "./do_kexec.sh"
-
 #define NUM_SESSIONS 5
 #define FILES_PER_SESSION 5
 
diff --git a/tools/testing/selftests/liveupdate/luo_unreclaimed.c b/tools/testing/selftests/liveupdate/luo_unreclaimed.c
index c3921b21b97b..b31bb354bfc3 100644
--- a/tools/testing/selftests/liveupdate/luo_unreclaimed.c
+++ b/tools/testing/selftests/liveupdate/luo_unreclaimed.c
@@ -8,7 +8,6 @@
 #include "luo_test_utils.h"
 #include "../kselftest.h"
 
-#define KEXEC_SCRIPT "./do_kexec.sh"
 
 #define SESSION_NAME "unreclaimed_session"
 #define TOKEN_A 100
-- 
2.51.0.858.gf9c4a03a3a-goog


