Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A5466F85
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 03:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbhLCCKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 21:10:15 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55276
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377953AbhLCCKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 21:10:15 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 75CA03F1B7
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638497210;
        bh=BrU2Q27F3zwyVziRmal9LmGlZ7G8dV/WLaFe+j0TIm4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SnbyR14lswsqN9iwLGiAkB1Tlsx61fJPysUvALDysFkHUjOq47e1CDz/4M9eLpj3q
         uNQPzudKgIYJEJmLosH1T7PmHfVZtLezkDTpLxDkUIFeo04kaeWdKqsXZMw8t+pbPP
         Rs1y1onUSLP1p3pOScZiDnYffHDrG/JUwgJ3smhhVwwcJzYhpaU1XZ5OQljytRhXMq
         iCcX72alYNulf1HPR2aHtSI33FsGlJ5kHUPW8Gemqb26lp4krn9159z4IhESoiGxQ7
         Pef6RfDagi+Xnx5WCNOj1u5//6Qn0xMfvZf55bMoNjkWSncjDhM/JQA1rAHCQqb1qH
         wJG839jfJR++Q==
Received: by mail-qt1-f197.google.com with SMTP id v19-20020ac85793000000b002b19184b2bfso1877341qta.14
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 18:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrU2Q27F3zwyVziRmal9LmGlZ7G8dV/WLaFe+j0TIm4=;
        b=JeUtT8HDYsqMoQ/nDJz8FFyIaCNgpAyMKaout3RWj1tqJGTUU6e6zMoWJ/lWcEhSeL
         B3CehzHUhnLLqgf+9TL8Ausw3xpI0+LgP2ViSI/nvkgCClRYUSDZwK8nKW5ttETXvGj5
         0OX1OQhGhRrcpXlc/JKqusXe7MzqY40vRf06fIdL6wIj76bcnOGSSMXUQy6jOFFN7hRi
         5k6ZETPneVFM2karxKSbQ/tfa8OrtC9XMJgSD+K32exCkiVQnSpQENIW7E8TOB17JCWS
         1WEzUeKpIytL3V6EKg2tjZP7goD+Z0LJvlQjXxvPaM2kZN1883mmZ2D9gmDgMVOC871Y
         bk/Q==
X-Gm-Message-State: AOAM53057xPcQwV8qfmMGjoAA0XKjxhW192gDG9C4KGepjicMqW2ldI6
        8uEJSRJBRecFCvnx+nhdq/yOPsEvn1zCCbmyhKKItxh6zcLtX7OykCaLrL9mQcOlsNHwDEGnQ4m
        opETGQ6gvczgehWxIGy4wxwySgy1dkwGsKRZCD+R3ZFIpcw==
X-Received: by 2002:a05:622a:1306:: with SMTP id v6mr18136645qtk.115.1638497209600;
        Thu, 02 Dec 2021 18:06:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqZPMGMVu6qVqXIsSCsiSzpXSoXA0wtn6y7tSEyAGLVQqcoKOtOntbdP/v48vwFGS89L77qg==
X-Received: by 2002:a05:622a:1306:: with SMTP id v6mr18136626qtk.115.1638497209404;
        Thu, 02 Dec 2021 18:06:49 -0800 (PST)
Received: from lukenow-XPS-13-9380.attlocal.net (108-249-109-234.lightspeed.sndgca.sbcglobal.net. [108.249.109.234])
        by smtp.gmail.com with ESMTPSA id v12sm1327227qtx.80.2021.12.02.18.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 18:06:49 -0800 (PST)
From:   Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2] selftests/seccomp: Unconditionally define seccomp_metadata
Date:   Thu,  2 Dec 2021 18:06:39 -0800
Message-Id: <20211203020639.6773-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unconditonally define seccomp_metadata and remove the linux/ptrace.h
include.

There are conflicts between glibc system headers sys/ptrace.h and
linux/ptrace.h that can likely cause seccomp_metadata to not be
defined depending on what system header versions are installed,
leading to compile errors. This fix makes this test more likely to
compile on a wider variety of systems.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2 + resend: 
Added comment to explain why there is a header definiton being
defined in the file and to suggest to future developers that they
might have to do the same for future fixes for definition issues like
this.

 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d425688cf59c..19d0b448511c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -26,7 +26,6 @@
 #include <sys/ptrace.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
-#include <linux/ptrace.h>
 #include <linux/seccomp.h>
 #include <pthread.h>
 #include <semaphore.h>
@@ -171,12 +170,17 @@ struct seccomp_data {
 
 #ifndef PTRACE_SECCOMP_GET_METADATA
 #define PTRACE_SECCOMP_GET_METADATA	0x420d
+#endif
 
+/*
+ * There are conflicting definitions in ptrace system headers that lead to
+ * struct seccomp_metadata to not be defined. So until those conflicts get
+ * sorted out, we should rely on some of our own in-tree ptrace definitions.
+ */
 struct seccomp_metadata {
 	__u64 filter_off;       /* Input: which filter */
 	__u64 flags;             /* Output: filter's flags */
 };
-#endif
 
 #ifndef SECCOMP_FILTER_FLAG_NEW_LISTENER
 #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
-- 
2.32.0

