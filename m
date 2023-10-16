Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C167CA8C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjJPNDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjJPNDY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 09:03:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE979B
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 06:03:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso1305428b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697461401; x=1698066201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSkHq/2/rbn0aIK0PQDHbOiabGTDeAbAiWm0vNQhn7I=;
        b=kLXTxWk3hwZf78rpZREJjVKGvK5QisHTUCep66kdeEAX2/P+a5jp+W5hotp62Na78o
         aU4Xc+CPI3llJWSfEMrlaAaKF6ep8P2MzEH1XLeEr7HV9u8YZE6OgQUcrxuzQQwwGx1n
         bfSdb+9nRKfOHuroIAc+yLCwD4lvLeH91KNq8Jic5DXk+AagqpNkeRe8WMYjLLInTisY
         AFD+V08g1JHU7U17AESIrdLhWrcwcxfMlQyM6HzD/w+u5YsKMb8/NutkcN23eWZZJ8An
         YoZO4LJ2XFSYCnRVZZqmdSlq1OtfnLLQFN6RT/nCYdjEMUE5fcSbnM5jc7lwLtVe7090
         u+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461401; x=1698066201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSkHq/2/rbn0aIK0PQDHbOiabGTDeAbAiWm0vNQhn7I=;
        b=NoGL2LAusAiI7Os5r7Bpu289QSaDCA3c5Rz4L8SnO1Hy5jmJj1H+ximr0u7WOGFjXg
         s21ycO2qyrTfZk+Nvfg6ILThKxyCoVALaMtYRSRxvo4Wt+5ZyKk+zB8wWBGqcEWvz2ti
         heRhF5q6DaA/yCIeZFB7Ab7lWc+kZiIzuEUDdUNLt28pIfSLxa0tLfpj/IAmcAXbVpUJ
         qWWrmb95H0/fQ8CW5QfRAys0H7H+Y+quZFnDqNxghrB35ZMBLFQNIur92+VFCf2vpeWQ
         gIpsMgUQDmR91k85wD1Qe0jCojPDe09C9JU/8C8uMtW1BuQw+Z3sQBQzhTzVDEzPsRYt
         mwoA==
X-Gm-Message-State: AOJu0YxZ/YMflnRnPLzaCdJdw0+1TxZcT/pdYaYL7QTzWVo6qTZ9GuNR
        X/cVWZezLGsi9U/ko8YLmOe+xg==
X-Google-Smtp-Source: AGHT+IHvKs3HuKF12+ygnM8OAY5E9Dq0KRh1fsHfQhI7dmkk7nXLkT03F0R+hk7PdvVa6WkQ/SSRtQ==
X-Received: by 2002:a05:6a00:2d83:b0:6bd:3157:2dfe with SMTP id fb3-20020a056a002d8300b006bd31572dfemr3491264pfb.7.1697461401326;
        Mon, 16 Oct 2023 06:03:21 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id z8-20020a6553c8000000b005b1bf3a200fsm3505583pgr.1.2023.10.16.06.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:03:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v4] selftests/bpf: Use pkg-config to determine ld flags
Date:   Mon, 16 Oct 2023 22:03:05 +0900
Message-ID: <20231016130307.35104-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
V3 -> V4: Added "2> /dev/null".
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

 tools/testing/selftests/bpf/Makefile   | 4 +++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..009e907a8abe 100644
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
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib 2> /dev/null || echo -lelf -lz)	\
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

