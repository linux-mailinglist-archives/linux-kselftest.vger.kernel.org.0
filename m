Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E464CE6E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJGPKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 11:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGPKW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 11:10:22 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146FC21479;
        Mon,  7 Oct 2019 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461021;
        bh=C/j8wF5nPghh73PI8MAMCRE0Uukowd37eLCPxz0oV5s=;
        h=From:To:Cc:Subject:Date:From;
        b=gu5mKLE4+Bbcnv5QIDBBme4x1AApivq5EGxEHtvd/4oYepfGTL9R3hbkB6+4ljGoq
         XA5JMmhMFKt7cfDWeIHhTWOacEejHSCAMJ4dJDxGz1BqbCmbECt1LK2TfyAJVoCdu3
         STT0XcmYWp4qfHyZg4dwRfibIJehykqcDGV/sPIs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH 0/5] selftests: Fixes for 32bit arch
Date:   Tue,  8 Oct 2019 00:10:16 +0900
Message-Id: <157046101671.20724.9561877942986463668.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here are some patches to fix some warnings/issues on 32bit arch
(e.g. arm).

When I built the ksefltest on arm, I hit some 32bit related warnings.
Here are the patches to fix those issues.


 - [1/5] va_max was set 2^32 even on 32bit arch. This can make
        va_max == 0 and always fail. Make it 3GB on 32bit.
 - [2/5] Some VM tests requires 64bit user space, which should
        not run on 32bit arch.
 - [3/5] For counting the size of large file, we should use
        size_t instead of unsinged long.
 - [4/5] Gcc warns printf format for size_t and int64_t on
        32bit arch. Use %llu and cast it.
 - [5/5] Gcc warns __u64 and pointer type castings. It should
        once translated to unsigned long.

Thank you,

---

Masami Hiramatsu (5):
      selftests: proc: Make va_max 3GB on 32bit arch
      selftests: vm: Build/Run 64bit tests only on 64bit arch
      selftests: net: Use size_t and ssize_t for counting file size
      selftests: net: Fix printf format warnings on arm
      selftests: sync: Fix cast warnings on arm


 tools/testing/selftests/net/so_txtime.c            |    4 ++--
 tools/testing/selftests/net/tcp_mmap.c             |    8 ++++----
 tools/testing/selftests/net/udpgso.c               |    3 ++-
 tools/testing/selftests/net/udpgso_bench_tx.c      |    3 ++-
 .../selftests/proc/proc-self-map-files-002.c       |   11 ++++++++++-
 tools/testing/selftests/sync/sync.c                |    6 +++---
 tools/testing/selftests/vm/Makefile                |    5 +++++
 tools/testing/selftests/vm/run_vmtests             |   10 ++++++++++
 8 files changed, 38 insertions(+), 12 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
