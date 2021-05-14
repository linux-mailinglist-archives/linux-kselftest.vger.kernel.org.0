Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68778380176
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhENBYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 21:24:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENBYg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 21:24:36 -0400
Received: from 189-18-220-116.dsl.telesp.net.br ([189.18.220.116] helo=mussarela..)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <cascardo@canonical.com>)
        id 1lhMY0-00028y-Ms; Fri, 14 May 2021 01:23:25 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     bpf@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, cascardo@canonical.com
Subject: [PATCH] selftests/bpf: only munmap the mmaped ringbuf pages
Date:   Thu, 13 May 2021 22:23:06 -0300
Message-Id: <20210514012306.39020-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One the mmap tests will map a single page, then try to extend the
mapping by use of mremap, which should fail. Right after that, it unmaps
the extended area, which may end up unmapping other valid mapped areas,
this causing a segfault.

Only unmap the area that is expected to be mapped.

Fixes: b2fb299c9aa4 ("selftests/bpf: test ringbuf mmap read-only and read-write restrictions")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 197e30b83298..f9a8ae331963 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -146,7 +146,7 @@ void test_ringbuf(void)
 	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_WRITE), "write_protect");
 	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_protect");
 	ASSERT_ERR_PTR(mremap(mmap_ptr, 0, 3 * page_size, MREMAP_MAYMOVE), "ro_remap");
-	ASSERT_OK(munmap(mmap_ptr, 3 * page_size), "unmap_ro");
+	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_ro");
 
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
-- 
2.30.2

