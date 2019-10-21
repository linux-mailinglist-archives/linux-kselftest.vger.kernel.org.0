Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3CEDE648
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfJUI2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 04:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfJUI2E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 04:28:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784992064A;
        Mon, 21 Oct 2019 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571646484;
        bh=n5MLYFVGXTsz0eJT/BbgubhoVR4OoLwDL9aQS6TH6/k=;
        h=From:To:Cc:Subject:Date:From;
        b=ujILqfvhvwAIzJg2ksFKx0u7AufpjCiLCCaMfXi6uSMOaNSaLwOF0UzsTsZjQqhJ4
         O7p9YzTZIwIB+7Ie+XoJn3m+r2gol61Q7fhcU3eTxBVG91NcAhZzOTr6rA6zbAFSAO
         bQIhcfTKUF3xT7xR91cMuvnqpdvpxQe1jfYL+S/Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Emilio =?utf-8?b?TMOzcGV6?= <emilio.lopez@collabora.co.uk>
Subject: [BUGFIX PATCH v2 0/5] selftests: Fixes for 32bit arch
Date:   Mon, 21 Oct 2019 17:27:58 +0900
Message-Id: <157164647813.17692.3834082082658965225.stgit@devnote2>
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

Here are the 2nd version of kselftest fixes some on 32bit arch
(e.g. arm). In this version, I updated [1/5] to make va_max 1GB
instead of 3GB, according to Alexey's comment.

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
      selftests: proc: Make va_max 1GB on 32bit arch
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
