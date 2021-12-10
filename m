Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98D470765
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhLJRiz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbhLJRhB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:01 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62765C0617A1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t23so14198105oiw.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5piJeGroEj5EK/nl0Pv9Gmn3OrmZFhy1pHRTuf94YA=;
        b=g9+QdAKDtcUtq15KKC71Ntw+2MfOqG+XUAQDqkyK7Jg0EbL9dU9e9fXhNMoyUMDS5G
         SnEWEn5JGFiH1/nSNkFCTpxAiKtRKqutdPjBo0jWoagYZ398eZrrSfq7jzPEDfvmoJ99
         VuMh+A1ngJiI8532kLDIzoUxuLCkV+f6nJptA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5piJeGroEj5EK/nl0Pv9Gmn3OrmZFhy1pHRTuf94YA=;
        b=4jEcY4yu38jfXyyzwOQsq9iOoWAkIAz1sugGb6GoSIjF/boVqQf3WhvApMQhqaLjPu
         gl3sWFqm4tgZbwOYQVDcoNta2M0SJMBPp4NvTuCJA3vOftgMTMMBMv6PRHie1dNwmMRr
         pTTmACX0Z6J0APg3aMhEhzO3PzrJ9eltglhzJWN7G40fHC9p4cNbP+ssiCx77CLeEavv
         sworudRLX+HBg/DQsP6EgxxN83dJvSLuDKmaWx9zMQNi/CgKYEsN2f2RqGZYOr88M06V
         KAKWITHGhiSQOeKd9cQ+5MPqp7Ji75b3vXdl9LezQZ+r9WYPExAtIf3dkJA0JaUDfp/b
         iJXw==
X-Gm-Message-State: AOAM530xB7EHHuARkfwVEA4ETpm0h4ofPJn7/FqbFwOX5b9eYNSbEooU
        fi18E8p7+3HoUw2/K60A+1fLAA==
X-Google-Smtp-Source: ABdhPJwpegtHSTsU291UpONzkrU9vfCDqPTNb+9w5/E07tR0hubuohplY3DJy4sIWD9rkj30iZEy5g==
X-Received: by 2002:a05:6808:485:: with SMTP id z5mr13675532oid.96.1639157605614;
        Fri, 10 Dec 2021 09:33:25 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:25 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 00/12] selftests: Remove ARRAY_SIZE duplicate defines
Date:   Fri, 10 Dec 2021 10:33:10 -0700
Message-Id: <cover.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. There are about 25+
duplicate defines in various selftests source and header files.
This patch series removes the duplicated defines.

Several tests that define ARRAY_SIZE also include kselftest.h or
kselftest_harness.h. Remove ARRAY_SIZE defines from them.

Some tests that define ARRAY_SIZE don't include headers that define
it. Remove ARRAY_SIZE define and include kselftest.h

The first patch in this series:

- Adds ARRAY_SIZE define to kselftest.h
- Adds ifndef guard around ARRAY_SIZE define in
  tools/include/linux/kernel.h and kselftest_harness.h
- Patches 2-12 do the cleanup and depend on patch 1, hence
  will have to go through kselftest tree.

Shuah Khan (12):
  tools: fix ARRAY_SIZE defines in tools and selftests hdrs
  selftests/arm64: remove ARRAY_SIZE define from vec-syscfg.c
  selftests/cgroup: remove ARRAY_SIZE define from cgroup_util.h
  selftests/core: remove ARRAY_SIZE define from close_range_test.c
  selftests/ir: remove ARRAY_SIZE define from ir_loopback.c
  selftests/landlock: remove ARRAY_SIZE define from common.h
  selftests/net: remove ARRAY_SIZE define from individual tests
  selftests/rseq: remove ARRAY_SIZE define from individual tests
  selftests/seccomp: remove ARRAY_SIZE define from seccomp_benchmark
  selftests/sparc64: remove ARRAY_SIZE define from adi-test
  selftests/timens: remove ARRAY_SIZE define from individual tests
  selftests/vm: remove ARRAY_SIZE define from individual tests

 tools/include/linux/kernel.h                          | 2 ++
 tools/testing/selftests/arm64/fp/vec-syscfg.c         | 2 --
 tools/testing/selftests/cgroup/cgroup_util.h          | 4 ++--
 tools/testing/selftests/core/close_range_test.c       | 4 ----
 tools/testing/selftests/ir/ir_loopback.c              | 1 -
 tools/testing/selftests/kselftest.h                   | 4 ++++
 tools/testing/selftests/kselftest_harness.h           | 2 ++
 tools/testing/selftests/landlock/common.h             | 4 ----
 tools/testing/selftests/net/gro.c                     | 3 ++-
 tools/testing/selftests/net/ipsec.c                   | 1 -
 tools/testing/selftests/net/reuseport_bpf.c           | 4 +---
 tools/testing/selftests/net/rxtimestamp.c             | 2 +-
 tools/testing/selftests/net/socket.c                  | 3 ++-
 tools/testing/selftests/net/tcp_fastopen_backup_key.c | 6 ++----
 tools/testing/selftests/rseq/basic_percpu_ops_test.c  | 3 +--
 tools/testing/selftests/rseq/rseq.c                   | 3 +--
 tools/testing/selftests/seccomp/seccomp_benchmark.c   | 2 +-
 tools/testing/selftests/sparc64/drivers/adi-test.c    | 4 ----
 tools/testing/selftests/timens/procfs.c               | 2 --
 tools/testing/selftests/timens/timens.c               | 2 --
 tools/testing/selftests/vm/mremap_test.c              | 1 -
 tools/testing/selftests/vm/pkey-helpers.h             | 3 ++-
 tools/testing/selftests/vm/va_128TBswitch.c           | 2 +-
 23 files changed, 24 insertions(+), 40 deletions(-)

-- 
2.32.0

