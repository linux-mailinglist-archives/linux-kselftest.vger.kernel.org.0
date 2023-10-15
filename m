Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED407C992C
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJONj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJONj0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 09:39:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7CA6
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 06:39:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c7ce16ddfaso2583800a34.3
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697377164; x=1697981964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzrY7VrqbAXMDQ/An7uucXcUyYeK5QX4Iy/EeDSFw9Q=;
        b=07gmkEyYlTje7KG4Pz5zn2csjnguffsHbs6sjyxvUXef52O04NwLi36J6q96N/nNCz
         4lZgjiityXknQhYcWWuiVh2Rq30roM/XevjSLRfylPmjpmeYThXqXQvvjKYmUApX6cov
         7gW5sjN1zTtBM9Eomqq2VAEq935rjGlT/LMNJvjK7nKA2roxhZ0RTUsgwEQ25qvlODgS
         /kl/x1FF/gg7rRSI3fC+rxaSWCAOGcU4zpR9ddBiKHYtI4hrn5OJ1mtukZo+X6ko+4+O
         oXjTLXFYQCySrFAHX19yeA6RwV575NJEEcACZHZZSEN8KvgUiOM0NjTHHmTvVFeTr27w
         +XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697377164; x=1697981964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzrY7VrqbAXMDQ/An7uucXcUyYeK5QX4Iy/EeDSFw9Q=;
        b=Wx/Lvus29TJKDuV4twhU9kNuh5ul63Z2VRlTIbZ8mmtcJDOwHp++jx1t+7Y5O1ITUd
         vdKt7P3cz9lItPARgkucHcjrq4B50beUfmCHRCIJh5Tjg2izbTccdXVgHAV9oYrqYZdS
         sDnqObFY7HceER9RRSdPxTMJPT0Pp6fq7tRG3HABfhsN15DPaizML4TZhhDj/nDhJE9V
         PPzLFUiGni+tMdhMJJxej+FJsE50CenaiWAfLKY4yBEMXUQE4MArb5FQ6WX4LNOH5lnK
         EOusFDEUUto7bsFKF5cPxx2x4UWChYf4JimYx3dFgZxTqg5Cj+w3iUcMKqtMigR216Ey
         lD4w==
X-Gm-Message-State: AOJu0Yyloog1K1KZY6DpNwFrhCYYa5SSzvXBl8y2VE6vOiWjW1SPF5et
        KEwOqkc/M6mMzKjK0lw28/zsqg==
X-Google-Smtp-Source: AGHT+IHMn+MWkXPiN2PFxj8eGoPs4OSA1Ena1/nrJQ5EuTY6OU4nQm29Q9sWZwur4SV4dUon/ktE5w==
X-Received: by 2002:a9d:7751:0:b0:6b9:ba85:a5fa with SMTP id t17-20020a9d7751000000b006b9ba85a5famr37027847otl.5.1697377164515;
        Sun, 15 Oct 2023 06:39:24 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id h9-20020a654689000000b005af08f65227sm2518837pgr.80.2023.10.15.06.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 06:39:24 -0700 (PDT)
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
Subject: [PATCH bpf-next] selftests/bpf: Use pkg-config to determine ld flags
Date:   Sun, 15 Oct 2023 22:39:14 +0900
Message-ID: <20231015133916.257197-1-akihiko.odaki@daynix.com>
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
 tools/testing/selftests/bpf/Makefile   | 3 ++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..833134aa2eda 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -31,7 +32,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib) -lrt -lpthread
 
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

