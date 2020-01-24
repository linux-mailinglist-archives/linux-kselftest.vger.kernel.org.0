Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2488148D83
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgAXSJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 13:09:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38311 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgAXSJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 13:09:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id m4so174355pjv.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=tl33NMB4xb0Oa3P5bsoXvWl9n72K/Immm4it2JBZlyA=;
        b=uyI37eJ5+pWiKL95QrI8s9+IPlQe/iwpnUrs9427leFlv+jWAoJ/A+pPE5gtMAe3y1
         ym2wBWUw/ug607NLZJ0Lx7Ngoosbnvra9u27cj4ek0Ax8nH3bdbRQ83CK+9G94vqYk2E
         7UU3+XEIIloN0HYtFxIzDVeY7N+zdTpbxDdsX9uwuBWzl/eFgHFNAsxCVoZQw4WQgeVt
         Kodi6q6q07iFIPmXnu93ZKTpauWeAiq5jd6P9OJ3AgtF3vB+wmy/IiBSrzp79WEGsJti
         N/8XZ9rFn+VmpE4HLmAgZQaV/swEBjmtxugC9bDtGq8nXv/43f0R3UL+GE1P4ewQIsso
         ajCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=tl33NMB4xb0Oa3P5bsoXvWl9n72K/Immm4it2JBZlyA=;
        b=mSO030kQW0cQXP6Rs5YWj+CyQrABKl0s6A3n/Keo5qGFKCYOGob20tcwzgxhvYiMQZ
         7BJfe+uEOxhtFphC1O1sJFzXmdLfyR1gqfIwdqQVDA85elVIhiqkhzI7SzY6QWYYGORs
         g7fLtkpNoRuvGBjKZXYOeBbKLENFzH3LejwBHVLUBRUJlcgntIhOvYcWFSSWwGJbRiMM
         +gMvpmhFpHEnp4NB2YtXjAi4Gr68G69atvm0++Lqsxx2z6GtAdDiVM9GU8aVJhn+MHAH
         h+Q/CisRVpiQoT4RrYObVrAXVtds4uckLFkOHbh+rxbRufTagFx4jIGL6rUp6+dnErSI
         Ag+A==
X-Gm-Message-State: APjAAAX5cvJbBMrCNgTZOuyPT1/Tv9t+a1gt0uXYb2x5q2ElWBxreIYL
        /6tRqO+0bWgTGJkgXEOcWjfRPw==
X-Google-Smtp-Source: APXvYqzFmqNXDTGXhgjmflNvPd4/r6/ygwXhSF679LLu4iDHd+MEhRcrDuwurclHInHbqyWpKkOLEw==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr540430pju.46.1579889377253;
        Fri, 24 Jan 2020 10:09:37 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:bf69:4011:cfff:c9e3])
        by smtp.gmail.com with ESMTPSA id q10sm7192274pfn.5.2020.01.24.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:09:36 -0800 (PST)
Subject: [PATCH] selftests/bpf: Elide a check for LLVM versions that can't compile it
Date:   Fri, 24 Jan 2020 10:08:39 -0800
Message-Id: <20200124180839.185837-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current stable LLVM BPF backend fails to compile the BPF selftests
due to a compiler bug.  The bug has been fixed in trunk, but that fix
hasn't landed in the binary packages I'm using yet (Fedora arm64).
Without this workaround the tests don't compile for me.

This patch triggers a preprocessor warning on LLVM versions that
definitely have the bug.  The test may be conservative (ie, I'm not sure
if 9.1 will have the fix), but it should at least make the current set
of stable releases work together.

See https://reviews.llvm.org/D69438 for more information on the fix.  I
obtained the workaround from
https://lore.kernel.org/linux-kselftest/aed8eda7-df20-069b-ea14-f06628984566@gmail.com/T/

Fixes: 20a9ad2e7136 ("selftests/bpf: add CO-RE relocs array tests")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .../testing/selftests/bpf/progs/test_core_reloc_arrays.c  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
index 89951b684282..e5eafdab80a4 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
@@ -43,15 +43,23 @@ int test_core_arrays(void *ctx)
 	/* in->a[2] */
 	if (CORE_READ(&out->a2, &in->a[2]))
 		return 1;
+#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
+# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
+#else
 	/* in->b[1][2][3] */
 	if (CORE_READ(&out->b123, &in->b[1][2][3]))
 		return 1;
+#endif
 	/* in->c[1].c */
 	if (CORE_READ(&out->c1c, &in->c[1].c))
 		return 1;
+#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
+# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
+#else
 	/* in->d[0][0].d */
 	if (CORE_READ(&out->d00d, &in->d[0][0].d))
 		return 1;
+#endif
 
 	return 0;
 }
-- 
2.25.0.341.g760bfbb309-goog

