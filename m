Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013674346F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJTIc3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJTIcY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 04:32:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD65C061768
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 01:30:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m42so17083293wms.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AcbCknbbtHbGw3Vd0vk/03qqtzI8ujhtq9XguWeSRMk=;
        b=ivHmWxkSQLTfxpTj7dhhvSlvzaNXTGh0hbqAT3JucIqokrazKkhu6o15CjUexSM105
         LBVl+KtdSjaSbZVHd+jogDO5uEgTDVti/GuERREkD2WNmU6cDIQBxX3jkM4GfakiUl5q
         xqMaGVsNCMnKu9rjNKeXwGEzE8JP7cuLu19Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcbCknbbtHbGw3Vd0vk/03qqtzI8ujhtq9XguWeSRMk=;
        b=FKj0fb7tGy3R7WmF7aKJsCEFDhp8bqsBYBA92kRhSSc9rq9EK8q+C//SVqT3O5mEdh
         pNf2GfNajXxmrFjn+WQq/Go4jcIS/zI3DNLsS+fWSkyF4rp6nVipOsqZfS9u9C9nj1Po
         akw3v7loMLC9hluccGZdP9al5kxdtSg8KflA2XGAFvBCaE6PLxxaNy4v4Vg9KPhkWMt5
         nCWzVAKPFHItQgvxMos3GHswdg8cV8l1hI9dJVojRObBo2r9+8LWQJAKY6uSxBcnkbTk
         jv3q/H9GOCgWeiyrm9yki38vw87EKeMpFJTVIf0XBG9xPPFDqv+34Ii0PFcVWWirbWVZ
         /MxA==
X-Gm-Message-State: AOAM530ipFz39IOonmJOHYjK4yP2kVG8Ov0hwLOPrWYU5GJDcVOgJGnT
        b+IyzZKCGt+5R4Qv+8JPaPo8CA==
X-Google-Smtp-Source: ABdhPJw+wTJP3EINkq3wLFo/fNuwR+IAQBZZkqAHuxV8Bf6kn1x5/8XdOPQTT6ggDVmG9S0mC425uA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr12198266wmc.132.1634718607017;
        Wed, 20 Oct 2021 01:30:07 -0700 (PDT)
Received: from antares.. (d.5.c.c.6.2.1.6.f.5.3.5.c.9.c.f.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:fc9c:535f:6126:cc5d])
        by smtp.gmail.com with ESMTPSA id s13sm4473133wmc.47.2021.10.20.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:30:06 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests: bpf: test RENAME_EXCHANGE and RENAME_NOREPLACE on bpffs
Date:   Wed, 20 Oct 2021 09:29:56 +0100
Message-Id: <20211020082956.8359-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020082956.8359-1-lmb@cloudflare.com>
References: <20211020082956.8359-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests to exercise the behaviour of RENAME_EXCHANGE and RENAME_NOREPLACE
on bpffs. The former checks that after an exchange the inode of two
directories has changed. The latter checks that the source still exists
after a failed rename.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 172c999e523c..9c28ae9589bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #define _GNU_SOURCE
+#include <stdio.h>
 #include <sched.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
@@ -29,6 +30,7 @@ static int read_iter(char *file)
 
 static int fn(void)
 {
+	struct stat a, b;
 	int err, duration = 0;
 
 	err = unshare(CLONE_NEWNS);
@@ -67,6 +69,43 @@ static int fn(void)
 	err = read_iter(TDIR "/fs2/progs.debug");
 	if (CHECK(err, "reading " TDIR "/fs2/progs.debug", "failed\n"))
 		goto out;
+
+	err = mkdir(TDIR "/fs1/a", 0777);
+	if (CHECK(err, "creating " TDIR "/fs1/a", "failed\n"))
+		goto out;
+	err = mkdir(TDIR "/fs1/a/1", 0777);
+	if (CHECK(err, "creating " TDIR "/fs1/a/1", "failed\n"))
+		goto out;
+	err = mkdir(TDIR "/fs1/b", 0777);
+	if (CHECK(err, "creating " TDIR "/fs1/b", "failed\n"))
+		goto out;
+
+	/* Check that RENAME_EXCHANGE works. */
+	err = stat(TDIR "/fs1/a", &a);
+	if (CHECK(err, "stat(" TDIR "/fs1/a)", "failed\n"))
+		goto out;
+	err = renameat2(0, TDIR "/fs1/a", 0, TDIR "/fs1/b", RENAME_EXCHANGE);
+	if (CHECK(err, "renameat2(RENAME_EXCHANGE)", "failed\n"))
+		goto out;
+	err = stat(TDIR "/fs1/b", &b);
+	if (CHECK(err, "stat(" TDIR "/fs1/b)", "failed\n"))
+		goto out;
+	if (CHECK(a.st_ino != b.st_ino, "b should have a's inode", "failed\n"))
+		goto out;
+	err = access(TDIR "/fs1/b/1", F_OK);
+	if (CHECK(err, "access(" TDIR "/fs1/b/1)", "failed\n"))
+		goto out;
+
+	/* Check that RENAME_NOREPLACE works. */
+	err = renameat2(0, TDIR "/fs1/b", 0, TDIR "/fs1/a", RENAME_NOREPLACE);
+	if (CHECK(!err, "renameat2(RENAME_NOREPLACE)", "succeeded\n")) {
+		err = -EINVAL;
+		goto out;
+	}
+	err = access(TDIR "/fs1/b", F_OK);
+	if (CHECK(err, "access(" TDIR "/fs1/b)", "failed\n"))
+		goto out;
+
 out:
 	umount(TDIR "/fs1");
 	umount(TDIR "/fs2");
-- 
2.30.2

