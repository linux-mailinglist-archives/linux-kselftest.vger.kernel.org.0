Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7297CA844
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJPMnY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjJPMnX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 08:43:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E2EE
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1074321b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697460201; x=1698065001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JipE9whaUpQHHx7Hfz3apWysXcawzThQ/KfBXZfjFOY=;
        b=QuygNWtEEqSjM6S4JIcBdEpsT2cEk88ms5w2LnkqjO+EmaIl+6uTrtyHmKEi/imfbA
         L9xIo8xBg9ossubCrFHVAtHEew+9aVAwaZUxOvnwj2QWosCe5CrEhWP/I7cxf7vEwRCK
         3ZrKCXod1VAKIE7Dl/QEU3ZHHQNd2H1EQUMSQiwbKSH4kYU97Nd3hHeYWtet3BqQ+pdN
         3HpFLIa+XnUpz3mfzCHc1GJNf34yM9u8DS/6bMSy1K3uKSbvaehSVIbembQ50IVda6Td
         qj60RJrlnWg4+FxUGN4+Q+Mo3zrNvmUGeBAvzZrlqiEHwQE3ScxCyAi5sOMNjSIrdPj6
         t3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460201; x=1698065001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JipE9whaUpQHHx7Hfz3apWysXcawzThQ/KfBXZfjFOY=;
        b=olezTpGoK5kqGaiplIrc60h1pm0G2qoUruF9h6/GXiWk0bqwyAExqU1ZeuDwbQV/bK
         gW1qlqG6WhFGD+xpodV5nPW1DE/JXbkSjolzldhi0XGFvQPMJz1c7NkDHuSCm14xSKD5
         e9r+2xh7xCKVd0OWYWEp0ggeHioqWeVDMK3lCgBehtosi7yp8hRU54VjmyAxUoUIZAK9
         ZQuKdd/yLLEH0qZ0fTl0gDZL8X7FCnW+yeqaJ41UAGHuxLCL30e+kCJCAbuXdoTkfpuR
         mCBhV5P7AevTsIVrOCgyiMhETyO97CdHVZfxQP6qvNFQ3Wp1HFaH14wlIov0fT1kCa9d
         A6TQ==
X-Gm-Message-State: AOJu0Yy+RzQCsYnFs59n+BsltvB3e0CO2Kmk4kk4S3XUl8wP22757/te
        pesNar/1lddanY/QJluDNi9U7Q==
X-Google-Smtp-Source: AGHT+IFeq6Akf/V4v3w1mbuCkqoYrYeZ0+bp+1svHzm84NBLFinKNR6+SVrALJNs/7AMHkZJPWYJsw==
X-Received: by 2002:a05:6a00:855:b0:6b4:c21c:8b56 with SMTP id q21-20020a056a00085500b006b4c21c8b56mr6606933pfk.23.1697460201060;
        Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id a18-20020aa78e92000000b006be5af77f06sm77763pfr.2.2023.10.16.05.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:43:20 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v3] selftests/bpf: Use pkg-config to determine ld flags
Date:   Mon, 16 Oct 2023 21:43:12 +0900
Message-ID: <20231016124313.60220-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

 tools/testing/selftests/bpf/Makefile   | 4 +++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..0b4ce6266bfc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -31,7 +32,8 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib || echo -lelf -lz)	\
+	  -lrt -lpthread
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index cb9b95702ac6..9af79c7a9b58 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
 
 .. code-block:: console
 
-  $ LDLIBS=-static vmtest.sh
+  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
 .. note:: Some distros may not support static linking.
 
-- 
2.42.0

