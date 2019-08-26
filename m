Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA9D9D1DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2019 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfHZOnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Aug 2019 10:43:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38884 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZOnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Aug 2019 10:43:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id q64so6413849qtd.5
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2019 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5tRAUVjwICwqP1eBMBkWBXaZ38ZgsH4zDqL+x+uPlE=;
        b=Wu1kiSaxjFuhzmEinNBFb3YSHaE7tSSzhgK59v+g0nF2SRc1aArk53h1nFKU2RdEOO
         7s5h7s4OntPORswAHcuLR7+Qiq4GczQqM3oPkb7XE3DotQMOT3IcVnkCzS1rNLinJ/7E
         +7/zDaE+SV1wA4Yxdnk6nqlkF3a97y8n1XpvrrL1KgxdXE1rUwApL/Qd2quWZPlA7WoN
         wflbv4VDsfNRD27owdg5ha2p6s1BqGQJ0j6UgKXt59E7+YNdsHepMJbosXKuWenNd9MK
         Wh34L0M7vLXsB/gE6GU2P2a3lyz/vq2AT9pNpzM9DjeBxlG45gJD6HuDBRaFtj1Sprgp
         KwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5tRAUVjwICwqP1eBMBkWBXaZ38ZgsH4zDqL+x+uPlE=;
        b=WTprXyUoP2b/LYVURcfmT/Ia2JLsNnHoUSrVTIa/uGL76YttnYPYOckM4HaJomLcu0
         tp0m15WazGR01Xnm/GVKB0EShtBo4Q3tba3nqARzFLip1Dyt94jW1notUHqFF93H/cBo
         cJr4bDKoao547zgL1KQA+oLMD0LNKJycGqGeTFt5oHzxhAmLL6lTKNrhm/vUaqfk04p0
         GeWDDj1uElSqtF0lPBDH814BesiN0dCLEhrgsidwhAr5TKJoBmEEwuaCwbBF2RK4/inF
         2bEAdWIrpa+3IhuVSamaE/LxP7IUU/c+yF9DoeyTmu0aIONdoaWIuqgtWXI3H1q9YSVd
         s1ZQ==
X-Gm-Message-State: APjAAAWjByRnrKeQ2I7Z1uAh3SnNkVWiQsDHKi5zzlJySDumCdyHoys2
        4eD6UL0Ji4ZMpUP17rJwqoLe+Q==
X-Google-Smtp-Source: APXvYqwVYjVrmp2SGBbNu2DRmDXtuB0C5ntzmIKReoSuTK9X/Uz0O0RgWFDJp+X7U6707NimRb4gdQ==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr17459504qtp.73.1566830582162;
        Mon, 26 Aug 2019 07:43:02 -0700 (PDT)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:3979:c36f:a14f:ef87])
        by smtp.gmail.com with ESMTPSA id o33sm7089937qtd.72.2019.08.26.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 07:43:01 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] selftests/seccomp: fix build on older kernels
Date:   Mon, 26 Aug 2019 08:43:02 -0600
Message-Id: <20190826144302.7745-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The seccomp selftest goes to some length to build against older kernel
headers, viz. all the #ifdefs at the beginning of the file. 201766a20e30
("ptrace: add PTRACE_GET_SYSCALL_INFO request") introduces some additional
macros, but doesn't do the #ifdef dance. Let's add that dance here to
avoid:

gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
In file included from seccomp_bpf.c:51:
seccomp_bpf.c: In function ‘tracer_ptrace’:
seccomp_bpf.c:1787:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_CLONE’?
  EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
  __typeof__(_expected) __exp = (_expected); \
             ^~~~~~~~~
seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
  EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
  ^~~~~~~~~
seccomp_bpf.c:1787:20: note: each undeclared identifier is reported only once for each function it appears in
  EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
  __typeof__(_expected) __exp = (_expected); \
             ^~~~~~~~~
seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
  EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
  ^~~~~~~~~
seccomp_bpf.c:1788:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_EXIT’?
    : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
  __typeof__(_expected) __exp = (_expected); \
             ^~~~~~~~~
seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
  EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
  ^~~~~~~~~
make: *** [Makefile:12: seccomp_bpf] Error 1

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6ef7f16c4cf5..7f8b5c8982e3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -199,6 +199,11 @@ struct seccomp_notif_sizes {
 };
 #endif
 
+#ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
+#define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
+#define PTRACE_EVENTMSG_SYSCALL_EXIT	2
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
-- 
2.20.1

