Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78A0E114F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 06:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfJWE5p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 00:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731908AbfJWE5p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 00:57:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 369C42173B;
        Wed, 23 Oct 2019 04:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806664;
        bh=5vrDSn4gx5uWB17ZXLelMba+6LXKDNOLUgRmxFZ6nMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU1ECglOJpTThrD5PNFGjpyZrB0C98aBTo/Dsi15H5TWAPq6+Ao6U88L9Fh9yrJWQ
         TEiM1O1loMQrSxulUP/Fgz8GgNIqAl9gUL2QXED7ZrOoNMYCtyRXAdhdzM9dCPAqO8
         irgjZhXx8fd8mHZVYEWcfoujqcx8+53o8HYxcUlo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [BUGFIX PATCH v3 1/5] selftests: proc: Make va_max 1MB
Date:   Wed, 23 Oct 2019 13:57:40 +0900
Message-Id: <157180666053.17298.15273701201071089765.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157180665007.17298.907392422924029261.stgit@devnote2>
References: <157180665007.17298.907392422924029261.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently proc-self-map-files-002.c sets va_max (max test address
of user virtual address) to 4GB, but it is too big for 32bit
arch and 1UL << 32 is overflow on 32bit long.
Also since this value should be enough bigger than vm.mmap_min_addr
(64KB or 32KB by default), 1MB should be enough.

Make va_max 1MB unconditionally.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 Changes in v3:
  - Make the va_max 1MB unconditionally, according to Alexey's comment.
 Changes in v2:
  - Make the va_max 1GB according to Alexey's comment.
---
 .../selftests/proc/proc-self-map-files-002.c       |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 47b7473dedef..e6aa00a183bc 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -47,7 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	const unsigned long va_max = 1UL << 32;
+	/*
+	 * va_max must be enough bigger than vm.mmap_min_addr, which is
+	 * 64KB/32KB by default. (depends on CONFIG_LSM_MMAP_MIN_ADDR)
+	 */
+	const unsigned long va_max = 1UL << 20;
 	unsigned long va;
 	void *p;
 	int fd;

