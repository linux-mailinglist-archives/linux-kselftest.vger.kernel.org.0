Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A033CEB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhCPHeB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCPHdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 03:33:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0740C06174A;
        Tue, 16 Mar 2021 00:33:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n17so12976750plc.7;
        Tue, 16 Mar 2021 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uwGLw4oyBg2siguHNzqzxEJ2zioYts2IjBxF9nVxAg=;
        b=SdXcCZp5eAj0eG7le1UodFJ9kJpKFCcQXFQp8y9qS8SdgjuQUyQtykgdEoNmnyyzKW
         IQ1GtYSUBCwWSC3WBh0bAoZ1T7a7sfvhhxTRkgQjODrJjpZBbfucYpPO1DICYL7y46U5
         kVnaM9dnC+obTvaD/Pyd4n4TjkZkW4PzW+0l8hSS3H3HbX+yTGRz1cuTTefF98kwU7/9
         9jyskWUQbxOckPjq60RBOooNAgPyiBqm2eqoD6AYFhZoYW7UqkZI+ejXh2XmO80BklJ8
         C/uD2l2ry6DUrtnjfwjnWoB4JMxx2v6vYiNyXeiSwuyG9FbMSR2nPHCgnDmBRLpNRsXe
         6uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uwGLw4oyBg2siguHNzqzxEJ2zioYts2IjBxF9nVxAg=;
        b=X6gA/qSlTVxWah5/YczMbVHaD+iWPPIiRXzdbkxD5Gu9kaQQFsvZaEgS9MSNZ7uxzH
         BNTchcTxviMiR6aK0J0+mXuTn5K1LZCJywkMOjioWZOElD36RCPyFJ7FA9z7dxif5YVo
         3Y4W0Whe2Ro5eZsp6Ctd6OHXXZVYwWNY2Tx9AK8yuq5gDzdE0A3n6beZNaUuk97W1ZPW
         GlCBxlZRGMPn32PdHemiIPDdAlmb3niM6QPFTsg2mt2ZON1ss7Z2kGMsnceyWFGuMmY5
         J7OXugJEa2tGAuftgREuT2jxbzlpX7u2U9J1melE+kL0//MhRpPXPo4R2nCcVtou0nmt
         lw+Q==
X-Gm-Message-State: AOAM533g7q/ACucvqH1YuZvvrvgLSFhoC8pEYwyaakutxCcDQVTl7OG4
        /YkGiGfuuNTVDUbsZ8WeTXk=
X-Google-Smtp-Source: ABdhPJz2vO1LkuhskFr46Ba09gSjtiCwL5zhzdrTzGXkiqsvd3q1KCoj2T2CQeDKwYaintJT/FE2Ew==
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr3298352pjt.132.1615880023387;
        Tue, 16 Mar 2021 00:33:43 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id d20sm1850131pjv.47.2021.03.16.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 00:33:42 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     pbonzini@redhat.com
Cc:     shuah@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, zhang.yunkai@zte.com.cn,
        akpm@linux-foundation.org, ricardo.canuelo@collabora.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests: remove duplicate include
Date:   Tue, 16 Mar 2021 00:33:36 -0700
Message-Id: <20210316073336.426255-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'assert.h' included in 'sparsebit.c' is duplicated.
It is also included in the 161th line.
'string.h' included in 'mincore_selftest.c' is duplicated.
It is also included in the 15th line.
'sched.h' included in 'tlbie_test.c' is duplicated.
It is also included in the 33th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 tools/testing/selftests/kvm/lib/sparsebit.c        | 1 -
 tools/testing/selftests/mincore/mincore_selftest.c | 1 -
 tools/testing/selftests/powerpc/mm/tlbie_test.c    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 031ba3c932ed..a0d0c83d83de 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -1890,7 +1890,6 @@ void sparsebit_validate_internal(struct sparsebit *s)
  */
 
 #include <stdlib.h>
-#include <assert.h>
 
 struct range {
 	sparsebit_idx_t first, last;
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 5a1e85ff5d32..e54106643337 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -14,7 +14,6 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-#include <string.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index f85a0938ab25..48344a74b212 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -33,7 +33,6 @@
 #include <sched.h>
 #include <time.h>
 #include <stdarg.h>
-#include <sched.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
-- 
2.25.1

