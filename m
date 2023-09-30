Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC87B4357
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjI3TlZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Sep 2023 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3TlY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Sep 2023 15:41:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF1E1;
        Sat, 30 Sep 2023 12:41:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69361132a60so394257b3a.1;
        Sat, 30 Sep 2023 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696102882; x=1696707682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLeIJ/fAJFQuWgfN3SfqzLo+G0sfER2FPjENsdAZzLE=;
        b=kUUXrxdjnDca3KTpyuzKcwxpgbg8m/S1YYkaMqpgebBMUgoBiMTYg2WsZBGwAlfhiW
         SYAlke7cE9ksLudI9wyXKRcoKJ96goXN6c5vqVjLmqbwKZsoXEspJ+36Yzzgys9EFtao
         3Zp7rn91Xu46uDSnSxOUBF6PyUSQsoFcLgYLaEi8KQJoovGkLqeP8EzM91LSlqOdAFq4
         aGL8AHH6/bPfBC3M+ENzOE6wC0lrnhl9Yr4xXtC8XBfxDMByxdRSoPKDoJUH94mhh9wJ
         FSn5+F9CG+yhVZhelj8SL8WcpyboWrB6MssEYyV8MOPMwO7ko/6GCYBiDP/Hzji2Z29G
         feJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696102882; x=1696707682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLeIJ/fAJFQuWgfN3SfqzLo+G0sfER2FPjENsdAZzLE=;
        b=AhdS1L24Bl2IBord+QKhaabKWD23XCX3F3NFHxJTcOuF+peClTclGe9QpaZSAMHQfx
         c3t3NdrhvF/99TgOYdS8EHngsuNu8T5lbQgWqSSzkSdau0yz77Y3CzG21o2Qp+jWL2mq
         +WCYD8uj9F8aiS5QVpDeEEe7JJeLfkSl9lZAbxREiCFn9/lmUzMmGMp0OvgBxdUbI0V7
         n81S3C0/4QP1cyN0k+3MmK2WMWmQSw/yaa/34UWiC6ImSxmSegmimfm85zkq+oVVMw7L
         00TeVZ+YDFNiry3lTFC6VMUg/+ZOuW2ZwbHDcZ4YTTPP03fR9GlqyxO1znPu5x2AbyCG
         /YAw==
X-Gm-Message-State: AOJu0YxlbdCooebWuxxxsi5TTXWUUtTYY89PPgyAIRGrrS7Q2N+pZaTm
        MdwCBOEM2kF1t3vV9WUzaeALyDaIHhL2JTWS
X-Google-Smtp-Source: AGHT+IFLX+X0bbprJYYxzfpMKb+uZKzOoBVsOhZSCU2aGF5m/fir3wpoVoZJzPPS/RknQ/D0E/cltQ==
X-Received: by 2002:a05:6a21:33a0:b0:15a:4634:e4c with SMTP id yy32-20020a056a2133a000b0015a46340e4cmr8807395pzb.5.1696102881879;
        Sat, 30 Sep 2023 12:41:21 -0700 (PDT)
Received: from abhinav-IdeaPad-Slim-5-14ABR8.. ([103.75.161.211])
        by smtp.googlemail.com with ESMTPSA id i14-20020aa787ce000000b006900cb919b8sm16969510pfo.53.2023.09.30.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 12:41:21 -0700 (PDT)
From:   Abhinav <singhabhinav9051571833@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Added missing TARGETS in kselftest top level Makefile
Date:   Sun,  1 Oct 2023 01:11:06 +0530
Message-Id: <20230930194106.1379527-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some TARGETS were missing in selftests top level Makefile.Added those.
Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
---
 tools/testing/selftests/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d9b2341b79a..14050f39cc5e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += dma
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
@@ -22,6 +23,7 @@ TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
+TARGETS += filelock
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
@@ -32,17 +34,21 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += hid
+TARGETS += ia64
 TARGETS += intel_pstate
 TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
 TARGETS += kexec
+TARGETS += kmod
 TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += locking
+TARGETS += media_tests
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
@@ -66,14 +72,18 @@ TARGETS += pid_namespace
 TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
+TARGETS += ptp
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += rcutorture
 TARGETS += openat2
 TARGETS += resctrl
 TARGETS += riscv
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
+TARGETS += safesetid
+TARGETS += sched
 TARGETS += seccomp
 TARGETS += sgx
 TARGETS += sigaltstack
@@ -99,6 +109,7 @@ TARGETS += user
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
+TARGETS += watchdog
 TARGETS += x86
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
-- 
2.34.1

