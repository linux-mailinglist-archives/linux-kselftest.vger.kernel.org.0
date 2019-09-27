Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28A9BFC9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 03:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfI0BNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 21:13:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38643 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfI0BNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 21:13:48 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so11821754iom.5
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9rA1WD839oUqijh+Vh8zZRtr0Ej8NqAU1MM5cNTJc=;
        b=dX6f3lPvSg9p2xx0kSYYtSRW/JjhIx4eA1YpglOO+6kZKvxeJICogR/PdXk9SyluNE
         d/qt5V5/PUpkaX+OSSVc5kSdh/AmzoxZ5aMrEr4rEgwa7fil0v9ZZX4A34BfhjiZdyLo
         xxSwfEFenWsZrSvfYTJwR5aDCJitIxqWKE8tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8j9rA1WD839oUqijh+Vh8zZRtr0Ej8NqAU1MM5cNTJc=;
        b=e98XC02AbNmuTSZNTx75h/J2+rOASfN5rE2YVIIqU8fpnWpLBta9o7rZN9CBgRzm1Z
         tNkbQVnJzvjM/uX72sWLMxJ8qyQ9iUgR7XvLK7W6NX4Cflbg4xCuy582UlqV0Az0Vbk+
         D0p1lSwKZyMcGC1mTLZy1xSuPSwWb9/flUDrf4e7YZwRjx3onGdPRDiMSd+79w5GX3Tx
         KgS7TJYKRlZTYwHoac4YKzbl8ACmWjWx5Fgfvj7wTmzAD9JM279iZ+sE9HLz1b9rKhou
         NBedHurpl0FYRGFSdTPrkKUzfnUgPkTGjXchH311PP6O3GzTsFHl7K7rzKkfdptbaO3x
         g7ng==
X-Gm-Message-State: APjAAAUDbOUNlc3svyt8P4BPGe43HfYTaa7FmWlODfCHZy7artbndKHw
        KJJpHcSPnVR3cVkUkbRai7EJTA==
X-Google-Smtp-Source: APXvYqyXeSPC+d9QdCWlvsXRPQVaxLUlT8C3HCTK3Kg9BOMblYLJYajtK7SPVki2xvpeDwPQEca/3A==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr6360952jac.26.1569546827184;
        Thu, 26 Sep 2019 18:13:47 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h70sm1907469iof.48.2019.09.26.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 18:13:46 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] tools: bpf: Use !building_out_of_srctree to determine srctree
Date:   Thu, 26 Sep 2019 19:13:44 -0600
Message-Id: <20190927011344.4695-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

make TARGETS=bpf kselftest fails with:

Makefile:127: tools/build/Makefile.include: No such file or directory

When the bpf tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/bpf Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=bpf kselftest" build failure.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/bpf/Makefile     | 6 +++++-
 tools/lib/bpf/Makefile | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index fbf5e4a0cb9c..5d1995fd369c 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -12,7 +12,11 @@ INSTALL ?= install
 CFLAGS += -Wall -O2
 CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index c6f94cffe06e..20772663d3e1 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -8,7 +8,11 @@ LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
 
 MAKEFLAGS += --no-print-directory
 
-ifeq ($(srctree),)
+# This will work when bpf is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is a ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
-- 
2.20.1

