Return-Path: <linux-kselftest+bounces-2174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23B817F85
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 03:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0487B1F243F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3B17F7;
	Tue, 19 Dec 2023 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Xjlv5j/p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5817CF
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d12ade25dso26172185e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Dec 2023 18:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702951393; x=1703556193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjsAHbjfMeDwtBP8wrx8HGvaKAxkSsjCBhep4ZbKU2k=;
        b=Xjlv5j/p/JeyugKxAljebVR7bkCLcw0+Z71qAklY64xXgDqZ0zE7y5p51cgcW6xXe7
         AvdvN7e7KvjUL6z+QppAmkXcmsh4xrEKNY4xhhIgS9bIH1YSDUxrhkDH8iR07Wq+Fg03
         Fzpz/07lNuSTaBeeKRBBqWMpdojmtE58Fo1I+hEALzkdRUM1A3CZk3USVE3bnzuGicsC
         WBdYqqvqOoY5SPNDZBZKnBJTXrQ32ByzuIdEQNMdff0ExKz4qze9DIzLO/3Vvjh0ZFbG
         7udnPWEC9KlKx8BPQsQ2IdntMLUXT3W7caKUBq8OPKzvm3qzRlMMu69XaJaPAGXHj748
         lJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702951393; x=1703556193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjsAHbjfMeDwtBP8wrx8HGvaKAxkSsjCBhep4ZbKU2k=;
        b=gBSC+LhgteLI0EJ8dqwbKg4erd3daUCe4WGKobpskPT72kRb+07z9fya2NxQl8qJ6r
         FJEP1ZD8NrDj3nSy8QmaNHEx3gqbzt8HZhMDzoAfIhLf8bmj0stKHPQs6CuMdfRvMlkl
         6udfJYZ3yGBKRUTaskiLgoXf9caCavjqX69iwisHwVJDL0KwssLJ36zMKQ0HosqNIB7k
         z0k7vCUQ1EucVADkyLSA+zfj4AzjzyB0P3/hGV3iyH/2njTjkYSw0XXZA5crVUtxqt/y
         7z8MDjvmvVOY7zNX2EIdBob7ik8Teu18e0Ww8Yv7il7g4eunPbokNneJyd3ES1xdLDdY
         T81A==
X-Gm-Message-State: AOJu0YyVYM8aWr7l2ee4SdCBCrkQC1PGaCV24B2v6qeMOV9t+hA3V/gd
	mBF9oGahr6yXwQ3zWvbfZdKMCg==
X-Google-Smtp-Source: AGHT+IF/kNWkZMYNHeVVL3RUNGwgYlxAj7dA/S+cQyieGNqNAtjbstLMUDuonlQ07VWTyaXlrIyung==
X-Received: by 2002:a05:600c:358d:b0:40d:27d3:8f2c with SMTP id p13-20020a05600c358d00b0040d27d38f2cmr25810wmq.56.1702951393183;
        Mon, 18 Dec 2023 18:03:13 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b0040c495b1c90sm590084wmq.11.2023.12.18.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:03:12 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] selftest/tcp-ao: Rectify out-of-tree build
Date: Tue, 19 Dec 2023 02:03:05 +0000
Message-ID: <20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702951385; l=3173; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=kXGv43WpVA4QuiP4NyRqa0KCrJ/VO9r5P4J8vlLiCw4=; b=1kOnNm8p4AmUsY6Nx+/rLZt4zV6JjEDoQl4HTO7eoE4E/lSubDKnwS+Igmo/2rYam28n2VLEx I0by5+u8dJJCTRd323F9YsGNn3GyyBehrNSJVuJnaY7J2b0MMRoyxZ0
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Trivial fix for out-of-tree build that I wasn't testing previously:

1. Create a directory for library object files, fixes:
> gcc lib/kconfig.c -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing -I ../../../../../usr/include/ -iquote /tmp/kselftest/kselftest/net/tcp_ao/lib -I ../../../../include/  -o /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o -c
> Assembler messages:
> Fatal error: can't create /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o: No such file or directory
> make[1]: *** [Makefile:46: /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o] Error 1

2. Include $(KHDR_INCLUDES) that's exported by selftests/Makefile, fixes:
> In file included from lib/kconfig.c:6:
> lib/aolib.h:320:45: warning: ‘struct tcp_ao_add’ declared inside parameter list will not be visible outside of this definition or declaration
>   320 | extern int test_prepare_key_sockaddr(struct tcp_ao_add *ao, const char *alg,
>       |                                             ^~~~~~~~~~
...

3. While at here, clean-up $(KSFT_KHDR_INSTALL): it's not needed anymore
   since commit f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")

4. Also, while at here, drop .DEFAULT_GOAL definition: that has a
   self-explaining comment, that was valid when I made these selftests
   compile on local v4.19 kernel, but not needed since
   commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")

Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312190645.q76MmHyq-lkp@intel.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 6343cfcf919b..8e60bae67aa9 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -17,22 +17,18 @@ TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
 TEST_GEN_PROGS := $(TEST_IPV4_PROGS) $(TEST_IPV6_PROGS)
 
 top_srcdir	  := ../../../../..
-KSFT_KHDR_INSTALL := 1
 include ../../lib.mk
 
 HOSTAR ?= ar
 
-# Drop it on port to linux/master with commit 8ce72dc32578
-.DEFAULT_GOAL := all
-
 LIBDIR	:= $(OUTPUT)/lib
 LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
 CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
-CFLAGS	+= -I ../../../../../usr/include/ -iquote $(LIBDIR)
-CFLAGS	+= -I ../../../../include/
+CFLAGS	+= $(KHDR_INCLUDES)
+CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
 # Library
 LIBSRC	:= kconfig.c netlink.c proc.c repair.c setup.c sock.c utils.c
@@ -43,6 +39,7 @@ $(LIB): $(LIBOBJ)
 	$(HOSTAR) rcs $@ $^
 
 $(LIBDIR)/%.o: ./lib/%.c $(LIBDEPS)
+	mkdir -p $(LIBDIR)
 	$(CC) $< $(CFLAGS) $(CPPFLAGS) -o $@ -c
 
 $(TEST_GEN_PROGS): $(LIB)

---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231219-b4-tcp-ao-selftests-out-of-tree-452f787f2d58

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


