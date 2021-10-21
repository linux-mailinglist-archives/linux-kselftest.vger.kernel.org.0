Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0A4365C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJUPSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhJUPSS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 11:18:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72097C061231
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:16:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d13so7496wrf.11
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3QcDl+qrCs7DfRcj3nDkgEldBtCcz4guF3zRxr4yw0=;
        b=og8TLQCkdYW+NTgs03kMNvaz85gbJZg01RThVaPc9dwl+VDpWo6GQ80zhvw97gozGW
         /ThwmKTl7rcmU4ax2Ak+CNU8sdByHuVjxOOD6MeUCDsw44kWshPNXlvzS1uO4s4lZcGb
         9Zp4gZ9IO2XlC3e9KEMticcIkxx81rUt0Cn2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3QcDl+qrCs7DfRcj3nDkgEldBtCcz4guF3zRxr4yw0=;
        b=L1Cq6TUXuOuWq2YpbDe+vHihwdQlR5EbvFwouhtiSxByo3fVaCA6bcOZ0ZKy8aE/P9
         NV0d1bO8ZR2kLD/w4iikSHNoUe6znsGLnJQhYitTtX5wk9HIBJp57pkB1kJ+ccV5tWhA
         b3aYi5d0zNm4uiBQcuj7WL7S4WsIrkudGXJ/UnnP9IiNX3gcjHOwHLqal0YutA/Dq5FU
         5rqnzNwNYpupGq0e7mOp/NjnyC0kKiHYJlBHq6ZI38uSx/kuthm3eLvdjhPJo6RdvbWt
         wrnKC4Xz2SqVgXV5AziZI7eJrxyyfAu2zhRE6IQPysorblqogfIZSSCkE3CnOOFk705G
         3itw==
X-Gm-Message-State: AOAM531zcB0U3pLBJfpa5xfrKWILp/WTeR42rxbjqqap2wnU3DBBxR3r
        JhW1KGAVdMpy3+2OpfQavEpSvQ==
X-Google-Smtp-Source: ABdhPJyBjBioVdWACxdF2OFHo6mJ7WSHI3iwB7rn3GgXXX+lutNDfML5XgLhY7C35UZMHI5B2m7H+w==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr2472685wrc.259.1634829360154;
        Thu, 21 Oct 2021 08:16:00 -0700 (PDT)
Received: from altair.lan (7.2.6.0.8.8.2.4.4.c.c.f.b.1.5.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:451b:fcc4:4288:627])
        by smtp.googlemail.com with ESMTPSA id z1sm5098562wrt.94.2021.10.21.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:15:59 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests: bpf: convert test_bpffs to ASSERT macros
Date:   Thu, 21 Oct 2021 16:15:27 +0100
Message-Id: <20211021151528.116818-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211021151528.116818-1-lmb@cloudflare.com>
References: <20211021151528.116818-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove usage of deprecated CHECK macros.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 172c999e523c..533e3f3a459a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -29,43 +29,43 @@ static int read_iter(char *file)
 
 static int fn(void)
 {
-	int err, duration = 0;
+	int err;
 
 	err = unshare(CLONE_NEWNS);
-	if (CHECK(err, "unshare", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "unshare"))
 		goto out;
 
 	err = mount("", "/", "", MS_REC | MS_PRIVATE, NULL);
-	if (CHECK(err, "mount /", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount /"))
 		goto out;
 
 	err = umount(TDIR);
-	if (CHECK(err, "umount " TDIR, "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "umount " TDIR))
 		goto out;
 
 	err = mount("none", TDIR, "tmpfs", 0, NULL);
-	if (CHECK(err, "mount", "mount root failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount tmpfs"))
 		goto out;
 
 	err = mkdir(TDIR "/fs1", 0777);
-	if (CHECK(err, "mkdir "TDIR"/fs1", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mkdir " TDIR "/fs1"))
 		goto out;
 	err = mkdir(TDIR "/fs2", 0777);
-	if (CHECK(err, "mkdir "TDIR"/fs2", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mkdir " TDIR "/fs2"))
 		goto out;
 
 	err = mount("bpf", TDIR "/fs1", "bpf", 0, NULL);
-	if (CHECK(err, "mount bpffs "TDIR"/fs1", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs1"))
 		goto out;
 	err = mount("bpf", TDIR "/fs2", "bpf", 0, NULL);
-	if (CHECK(err, "mount bpffs " TDIR "/fs2", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs2"))
 		goto out;
 
 	err = read_iter(TDIR "/fs1/maps.debug");
-	if (CHECK(err, "reading " TDIR "/fs1/maps.debug", "failed\n"))
+	if (!ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug"))
 		goto out;
 	err = read_iter(TDIR "/fs2/progs.debug");
-	if (CHECK(err, "reading " TDIR "/fs2/progs.debug", "failed\n"))
+	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
 		goto out;
 out:
 	umount(TDIR "/fs1");
-- 
2.32.0

